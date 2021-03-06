/*!
 * Jodit Editor (https://xdsoft.net/jodit/)
 * License GNU General Public License version 2 or later;
 * Copyright 2013-2018 Valeriy Chupurnov https://xdsoft.net
 */

import { Config, OptionsDefault } from './Config';
import * as consts from './constants';
import { Component } from './modules/Component';
import { Dom } from './modules/Dom';
import { EventsNative } from './modules/events/EventsNative';
import { FileBrowser } from './modules/filebrowser/filebrowser';
import * as helper from './modules/helpers/Helpers';
import {
    asArray,
    debounce,
    defaultLanguage,
    dom,
    inArray,
    normalizeKeyAliases,
    splitArray,
    sprintf,
} from './modules/helpers/Helpers';
import { JoditArray } from './modules/helpers/JoditArray';
import { JoditObject } from './modules/helpers/JoditObject';
import { Observer } from './modules/observer/Observer';
import { Select } from './modules/Selection';
import { StatusBar } from './modules/StatusBar';
import { localStorageProvider } from './modules/storage/localStorageProvider';
import { Storage } from './modules/storage/Storage';
import { ToolbarCollection } from './modules/toolbar/collection';
import { Uploader } from './modules/Uploader';
import { View } from './modules/view/view';
import {
    CustomCommand,
    ExecCommandCallback,
    ICommandType,
    IDictionary,
    IPlugin,
    markerInfo,
} from './types/types';

declare let appVersion: string;

/**
 * Class Jodit. Main class
 */
export class Jodit extends View {
    get value(): string {
        return this.getEditorValue();
    }
    set value(html: string) {
        this.setEditorValue(html);
    }

    /**
     * Return default timeout period in milliseconds for some debounce or throttle functions.
     * By default return {observer.timeout} options
     *
     * @return {number}
     */
    get defaultTimeout(): number {
        return this.options && this.options.observer
            ? this.options.observer.timeout
            : Jodit.defaultOptions.observer.timeout;
    }

    public static Array(array: any[]): JoditArray {
        return new JoditArray(array);
    }
    public static Object(object: any): JoditObject {
        return new JoditObject(object);
    }

    public static fireEach(events: string, ...args: any[]) {
        Object.keys(Jodit.instances).forEach((key: string) => {
            const editor: Jodit = Jodit.instances[key];
            if (!editor.isDestructed && editor.events) {
                editor.events.fire(events, ...args);
            }
        });
    }

    public static defaultOptions: Config;
    public static plugins: any = {};
    public static modules: any = {};
    public static instances: IDictionary<Jodit> = {};
    public static lang: any = {};

    private __defaultStyleDisplayKey = 'data-jodit-default-style-display';
    private __defaultClassesKey = 'data-jodit-default-classes';

    private commands: IDictionary<Array<CustomCommand<Jodit>>> = {};

    private __selectionLocked: markerInfo[] | null = null;

    private __wasReadOnly: boolean = false;

    private async __initEditor(buffer: null | string) {
        await this.__createEditor();

        // syncro
        if (this.element !== this.container) {
            this.setElementValue();
        } else {
            buffer !== null && this.setEditorValue(buffer); // inline mode
        }

        Jodit.instances[this.id] = this;

        let mode: number = this.options.defaultMode;

        if (this.options.saveModeInStorage) {
            const localMode: string | null = this.storage.get(
                'jodit_default_mode'
            );
            if (localMode !== null) {
                mode = parseInt(localMode, 10);
            }
        }

        this.setMode(mode);

        if (this.options.readonly) {
            this.setReadOnly(true);
        }
        if (this.options.disabled) {
            this.setDisabled(true);
        }

        // if enter plugin not installed
        try {
            this.editorDocument.execCommand(
                'defaultParagraphSeparator',
                false,
                this.options.enter.toLowerCase()
            );
        } catch (ignore) {}

        // fix for native resizing
        try {
            this.editorDocument.execCommand(
                'enableObjectResizing',
                false,
                'false'
            );
        } catch (ignore) {}

        try {
            this.editorDocument.execCommand(
                'enableInlineTableEditing',
                false,
                'false'
            );
        } catch (ignore) {}
    }

    private __initPlugines() {
        const disable: string[] = Array.isArray(this.options.disablePlugins)
            ? this.options.disablePlugins.map((pluginName: string) => {
                  return pluginName.toLowerCase();
              })
            : this.options.disablePlugins.toLowerCase().split(/[\s,]+/);

        Object.keys(Jodit.plugins).forEach((key: string) => {
            if (disable.indexOf(key.toLowerCase()) === -1) {
                this.__plugins[key] = new Jodit.plugins[key](this);
            }
        });
    }

    /**
     * Create main DIV element and replace source textarea
     *
     * @private
     */
    private async __createEditor() {
        const createDefault: boolean | undefined = await this.events.fire(
            'createEditor',
            this
        );
        if (createDefault !== false) {
            this.editor = dom(
                `<div class="jodit_wysiwyg" contenteditable aria-disabled="false" tabindex="${
                    this.options.tabIndex
                }"></div>`,
                this.ownerDocument
            ) as HTMLDivElement;
            this.workplace.appendChild(this.editor);
        }

        if (this.options.editorCssClass) {
            this.editor.classList.add(this.options.editorCssClass);
        }

        // proxy events
        this.events
            .on('synchro', () => {
                this.setEditorValue();
            })
            .on(
                this.editor,
                'selectionchange selectionstart keydown keyup keypress mousedown mouseup mousepress ' +
                    'click copy cut dragstart drop dragover paste resize touchstart touchend focus blur',
                (event: Event): false | void => {
                    if (this.options.readonly) {
                        return;
                    }
                    if (this.events && this.events.fire) {
                        if (this.events.fire(event.type, event) === false) {
                            return false;
                        }

                        this.setEditorValue();
                    }
                }
            );

        if (this.options.spellcheck) {
            this.editor.setAttribute('spellcheck', 'true');
        }

        // direction
        if (this.options.direction) {
            this.editor.style.direction =
                this.options.direction.toLowerCase() === 'rtl' ? 'rtl' : 'ltr';
        }

        // actual for inline mode
        if (this.element !== this.container) {
            // hide source element
            if (this.element.style.display) {
                this.element.setAttribute(
                    this.__defaultStyleDisplayKey,
                    this.element.style.display
                );
            }

            this.element.style.display = 'none';
        }

        if (this.options.triggerChangeEvent) {
            this.events.on(
                'change',
                debounce(() => {
                    this.events && this.events.fire(this.element, 'change');
                }, this.defaultTimeout)
            );
        }
    }

    private execCustomCommands(
        commandName: string,
        second: any = false,
        third: null | any = null
    ): false | void {
        commandName = commandName.toLowerCase();

        if (this.commands[commandName] !== undefined) {
            let result: any = void 0;

            this.commands[commandName].forEach(command => {
                let callback: ExecCommandCallback<Jodit>;

                if (typeof command === 'function') {
                    callback = command;
                } else {
                    callback = command.exec;
                }

                const resultCurrent: any = (callback as any).call(
                    this,
                    commandName,
                    second,
                    third
                );

                if (resultCurrent !== undefined) {
                    result = resultCurrent;
                }
            });

            return result;
        }
    }
    public version: string = appVersion; // from webpack.config.js

    /**
     * Some extra data inside editor
     *
     * @type {{}}
     * @see copyformat plugin
     */
    public buffer: IDictionary;

    /**
     * @property {HTMLDocument} editorDocument
     */
    public editorDocument: HTMLDocument;

    /**
     * @property {Window} editorWindow
     */
    public editorWindow: Window;

    public components: any = [];

    /**
     * @property {HTMLDocument} ownerDocument
     */
    public ownerDocument: HTMLDocument;

    /**
     * ownerWindow
     */
    public ownerWindow: Window;

    /**
     * Container for set/get value
     * @type {Storage}
     */
    public storage: Storage = new Storage(new localStorageProvider());

    /**
     * progress_bar Progress bar
     */
    public progress_bar: HTMLDivElement;

    /**
     * workplace It contains source and wysiwyg editors
     */
    public workplace: HTMLDivElement;

    public statusbar: StatusBar;
    public observer: Observer;

    public events: EventsNative;

    /**
     * element It contains source element
     */
    public element: HTMLElement;

    /**
     * editor It contains the root element editor
     */
    public editor: HTMLDivElement | HTMLBodyElement;

    /**
     * iframe Iframe for iframe mode
     */
    public iframe: HTMLIFrameElement | null = null;

    /**
     * options All Jodit settings default + second arguments of constructor
     */
    public options: Config;

    /**
     * @property {Select} selection
     */
    public selection: Select;

    /**
     * @property {Uploader} uploader
     */
    public uploader: Uploader;

    /**
     * @property {FileBrowser} filebrowser
     */
    public filebrowser: FileBrowser;

    public helper: any;

    public __plugins: IDictionary<IPlugin> = {};

    public mode: number = consts.MODE_WYSIWYG;

    /**
     * Jodit's Destructor. Remove editor, and return source input
     */
    public destruct() {
        if (this.isDestructed) {
            return;
        }

        this.isDestructed = true;

        /**
         * Triggered before {@link events:beforeDestruct|beforeDestruct} executed. If returned false method stopped
         *
         * @event beforeDestruct
         * @example
         * ```javascript
         * var editor = new Jodit("#redactor");
         * editor.events.on('beforeDestruct', function (data) {
         *     return false;
         * });
         * ```
         */
        if (this.events.fire('beforeDestruct') === false) {
            return;
        }

        if (!this.editor) {
            return;
        }

        const buffer: string = this.getEditorValue();

        if (this.element !== this.container) {
            if (this.element.hasAttribute(this.__defaultStyleDisplayKey)) {
                this.element.style.display = this.element.getAttribute(
                    this.__defaultStyleDisplayKey
                );
                this.element.removeAttribute(this.__defaultStyleDisplayKey);
            } else {
                this.element.style.display = '';
            }
        } else {
            if (this.element.hasAttribute(this.__defaultClassesKey)) {
                this.element.className =
                    this.element.getAttribute(this.__defaultClassesKey) || '';
                this.element.removeAttribute(this.__defaultClassesKey);
            }
        }

        if (
            this.element.hasAttribute('style') &&
            !this.element.getAttribute('style')
        ) {
            this.element.removeAttribute('style');
        }

        Object.keys(this.__plugins).forEach((pluginName: string) => {
            if (
                this.__plugins !== undefined &&
                this.__plugins[pluginName] !== undefined &&
                this.__plugins[pluginName].destruct !== undefined &&
                typeof this.__plugins[pluginName].destruct === 'function'
            ) {
                // @ts-ignore: Object is possibly 'undefined'
                this.__plugins[pluginName].destruct();
            }
            delete this.__plugins[pluginName];
        });

        this.components.forEach((component: Component) => {
            if (
                component.destruct !== undefined &&
                typeof component.destruct === 'function'
            ) {
                component.destruct();
            }
        });

        delete this.selection;

        this.events.off(this.ownerWindow);
        this.events.off(this.ownerDocument);
        this.events.off(this.ownerDocument.body);
        this.events.off(this.element);
        this.events.off(this.editor);
        this.events.destruct();

        delete this.events;

        Dom.safeRemove(this.workplace);
        Dom.safeRemove(this.editor);
        Dom.safeRemove(this.iframe);

        if (this.container !== this.element) {
            Dom.safeRemove(this.container);
        }

        delete this.editor;
        delete this.workplace;

        // inline mode
        if (this.container === this.element) {
            this.element.innerHTML = buffer;
        }

        delete Jodit.instances[this.id];
        delete this.container;
    }

    /**
     * Return source element value
     */
    public getElementValue() {
        return (this.element as HTMLInputElement).value !== undefined
            ? (this.element as HTMLInputElement).value
            : this.element.innerHTML;
    }

    /**
     * Return real HTML value from WYSIWYG editor.
     *
     * @return {string}
     */
    public getNativeEditorValue(): string {
        if (this.editor) {
            return this.editor.innerHTML;
        }

        return this.getElementValue();
    }

    /**
     * Return editor value
     */
    public getEditorValue(removeSelectionMarkers: boolean = true): string {
        /**
         * Triggered before {@link Jodit~getEditorValue|getEditorValue} executed.
         * If returned not undefined getEditorValue will return this value
         *
         * @event beforeGetValueFromEditor
         * @example
         * ```javascript
         * var editor = new Jodit("#redactor");
         * editor.events.on('beforeGetValueFromEditor', function () {
         *     return editor.editor.innerHTML.replace(/a/g, 'b');
         * });
         * ```
         */
        let value: string;

        value = this.events.fire('beforeGetValueFromEditor');

        if (value !== undefined) {
            return value;
        }

        value = this.getNativeEditorValue().replace(
            consts.INVISIBLE_SPACE_REG_EXP,
            ''
        );

        if (removeSelectionMarkers) {
            value = value.replace(
                /<span[^>]+id="jodit_selection_marker_[^>]+><\/span>/g,
                ''
            );
        }

        if (value === '<br>') {
            value = '';
        }

        /**
         * Triggered after  {@link Jodit~getEditorValue|getEditorValue} got value from wysiwyg.
         * It can change new_value.value
         *
         * @event afterGetValueFromEditor
         * @param string new_value
         * @example
         * ```javascript
         * var editor = new Jodit("#redactor");
         * editor.events.on('afterGetValueFromEditor', function (new_value) {
         *     new_value.value = new_value.value.replace('a', 'b');
         * });
         * ```
         */
        const new_value: { value: string } = { value };

        this.events.fire('afterGetValueFromEditor', new_value);

        return new_value.value;
    }

    public getEditorText(): string {
        if (this.editor) {
            return this.editor.innerText;
        }

        const div: HTMLDivElement = this.ownerDocument.createElement('div');
        div.innerHTML = this.getElementValue();

        return div.innerText;
    }

    /**
     * Set source element value and if set sync fill editor value
     * When method was called without arguments - it is simple way to synchronize element to editor
     *
     * @param {string} [value]
     */
    public setElementValue(value?: string) {
        if (typeof value !== 'string' && value !== undefined) {
            throw new Error('value must be string');
        }

        if (value !== undefined) {
            if (this.element !== this.container) {
                if ((this.element as HTMLInputElement).value !== undefined) {
                    (this.element as HTMLInputElement).value = value;
                } else {
                    this.element.innerHTML = value;
                }
            }
        } else {
            value = this.getElementValue();
        }

        if (value !== this.getEditorValue()) {
            this.setEditorValue(value);
        }
    }

    /**
     * Set editor html value and if set sync fill source element value
     * When method was called without arguments - it is simple way to synchronize editor to element
     * @event beforeSetValueToEditor
     * @param {string} [value]
     */
    public setEditorValue(value?: string) {
        /**
         * Triggered before  {@link Jodit~getEditorValue|setEditorValue} set value to wysiwyg.
         *
         * @event beforeSetValueToEditor
         * @param string old_value
         * @returns string | undefined | false
         * @example
         * ```javascript
         * var editor = new Jodit("#redactor");
         * editor.events.on('beforeSetValueToEditor', function (old_value) {
         *     return old_value.value.replace('a', 'b');
         * });
         * editor.events.on('beforeSetValueToEditor', function () {
         *     return false; // disable setEditorValue method
         * });
         * ```
         */
        const newValue: string | undefined | false = this.events.fire(
            'beforeSetValueToEditor',
            value
        );

        if (newValue === false) {
            return;
        }

        if (typeof newValue === 'string') {
            value = newValue;
        }

        if (!this.editor) {
            if (value !== undefined) {
                this.setElementValue(value);
            }
            return; // try change value before init or after destruct
        }

        if (typeof value !== 'string' && value !== undefined) {
            throw new Error('value must be string');
        }

        if (value !== undefined && this.editor.innerHTML !== value) {
            this.editor.innerHTML = value;
        }

        const old_value: string = this.getElementValue(),
            new_value: string = this.getEditorValue();

        if (old_value !== new_value) {
            this.setElementValue(new_value);
            this.events.fire('change', new_value, old_value);
        }
    }

    /**
     * Register custom handler for command
     *
     * @example
     * ```javascript
     * var jodit = new Jodit('#editor);
     *
     * jodit.setEditorValue('test test test');
     *
     * jodit.registerCommand('replaceString', function (command, needle, replace) {
     *      var value = this.getEditorValue();
     *      this.setEditorValue(value.replace(needle, replace));
     *      return false; // stop execute native command
     * });
     *
     * jodit.execCommand('replaceString', 'test', 'stop');
     *
     * console.log(jodit.getEditorValue()); // stop test test
     *
     * // and you can add hotkeys for command
     * jodit.registerCommand('replaceString', {
     *    hotkeys: 'ctrl+r',
     *    exec: function (command, needle, replace) {
     *     var value = this.getEditorValue();
     *     this.setEditorValue(value.replace(needle, replace));
     *    }
     * });
     *
     * ```
     *
     * @param {string} commandNameOriginal
     * @param {ICommandType | Function} command
     */
    public registerCommand(
        commandNameOriginal: string,
        command: CustomCommand<Jodit>
    ): Jodit {
        const commandName: string = commandNameOriginal.toLowerCase();

        if (this.commands[commandName] === undefined) {
            this.commands[commandName] = [];
        }

        this.commands[commandName].push(command);

        if (typeof command !== 'function') {
            const hotkeys: string | string[] | void =
                this.options.commandToHotkeys[commandName] ||
                this.options.commandToHotkeys[commandNameOriginal] ||
                command.hotkeys;

            if (hotkeys) {
                this.registerHotkeyToCommand(hotkeys, commandName);
            }
        }

        return this;
    }

    /**
     * Register hotkey for command
     *
     * @param hotkeys
     * @param commandName
     */
    public registerHotkeyToCommand(
        hotkeys: string | string[],
        commandName: string
    ) {
        const shortcuts: string[] = asArray(hotkeys).map(normalizeKeyAliases);

        this.events
            .off(shortcuts.map(hotkey => hotkey + '.hotkey').join(' '))
            .on(shortcuts.map(hotkey => hotkey + '.hotkey').join(' '), () => {
                return this.execCommand(commandName); // because need `beforeCommand`
            });
    }

    /**
     * Execute command editor
     *
     * @method execCommand
     * @param  {string} command command. It supports all the
     * {@link https://developer.mozilla.org/ru/docs/Web/API/Document/execCommand#commands} and a number of its own
     * for example applyCSSProperty. Comand fontSize receives the second parameter px,
     * formatBlock and can take several options
     * @param  {boolean|string|int} showUI
     * @param  {boolean|string|int} value
     * @fires beforeCommand
     * @fires afterCommand
     * @example
     * ```javascript
     * this.execCommand('fontSize', 12); // sets the size of 12 px
     * this.execCommand('underline');
     * this.execCommand('formatBlock', 'p'); // will be inserted paragraph
     * ```
     */
    public execCommand(
        command: string,
        showUI: any = false,
        value: null | any = null
    ) {
        if (this.options.readonly && command !== 'selectall') {
            return;
        }

        let result: any;
        command = command.toLowerCase();

        /**
         * Called before any command
         * @event beforeCommand
         * @param {string} command Command name in lowercase
         * @param {string} second The second parameter for the command
         * @param {string} third The third option is for the team
         * @example
         * ```javascript
         * parent.events.on('beforeCommand', function (command) {
         *  if (command === 'justifyCenter') {
         *      var p = parent.getDocument().createElement('p')
         *      parent.selection.insertNode(p)
         *      parent.selection.setCursorIn(p);
         *      p.style.textAlign = 'justyfy';
         *      return false; // break execute native command
         *  }
         * })
         * ```
         */
        result = this.events.fire('beforeCommand', command, showUI, value);

        if (result !== false) {
            result = this.execCustomCommands(command, showUI, value);
        }

        if (result !== false) {
            this.selection.focus();
            switch (command) {
                case 'selectall':
                    this.selection.select(this.editor, true);
                    break;
                default:
                    try {
                        result = this.editorDocument.execCommand(
                            command,
                            showUI,
                            value
                        );
                    } catch (e) {}
            }
        }

        /**
         * It called after any command
         * @event afterCommand
         * @param {string} command name command
         * @param {*} second The second parameter for the command
         * @param {*} third The third option is for the team
         */
        this.events.fire('afterCommand', command, showUI, value);

        this.setEditorValue(); // synchrony

        return result;
    }

    /**
     * Disable selecting
     */
    public lock(name: string = 'any') {
        if (!this.isLocked()) {
            this.__whoLocked = name;
            this.__selectionLocked = this.selection.save();
            this.editor.classList.add('jodit_disabled');
        }
    }

    /**
     * Enable selecting
     */
    public unlock() {
        if (this.isLocked()) {
            this.__whoLocked = '';
            this.editor.classList.remove('jodit_disabled');
            if (this.__selectionLocked) {
                this.selection.restore(this.__selectionLocked);
            }
        }
    }

    public isLockedNotBy = (name: string): boolean => {
        return this.isLocked() && this.__whoLocked !== name;
    };

    /**
     * Return current editor mode: Jodit.MODE_WYSIWYG, Jodit.MODE_SOURCE or Jodit.MODE_SPLIT
     * @return {number}
     */
    public getMode(): number {
        return this.mode;
    }
    public isEditorMode(): boolean {
        return this.getRealMode() === consts.MODE_WYSIWYG;
    }

    /**
     * Return current real work mode. When editor in MODE_SOURCE or MODE_WYSIWYG it will
     * return them, but then editor in MODE_SPLIT it will return MODE_SOURCE if
     * Textarea(CodeMirror) focused or MODE_WYSIWYG otherwise
     *
     * @example
     * ```javascript
     * var editor = new Jodit('#editor');
     * console.log(editor.getRealMode());
     * ```
     */
    public getRealMode(): number {
        if (this.getMode() !== consts.MODE_SPLIT) {
            return this.getMode();
        }

        const active: Element | null = this.ownerDocument.activeElement;

        if (
            active &&
            (Dom.isOrContains(this.editor, active) ||
                Dom.isOrContains(this.toolbar.container, active))
        ) {
            return consts.MODE_WYSIWYG;
        }

        return consts.MODE_SOURCE;
    }

    /**
     * Set current mode
     *
     * @fired beforeSetMode
     * @fired afterSetMode
     */
    public setMode(mode: number | string) {
        const oldmode: number = this.getMode();
        const data = {
                mode: parseInt(mode.toString(), 10),
            },
            modeClasses = [
                'jodit_wysiwyg_mode',
                'jodit_source_mode',
                'jodit_split_mode',
            ];

        /**
         * Triggered before {@link Jodit~setMode|setMode} executed. If returned false method stopped
         * @event beforeSetMode
         * @param {Object} data PlainObject {mode: {string}} In handler you can change data.mode
         * @example
         * ```javascript
         * var editor = new Jodit("#redactor");
         * editor.events.on('beforeSetMode', function (data) {
         *     data.mode = Jodit.MODE_SOURCE; // not respond to the mode change. Always make the source code mode
         * });
         * ```
         */
        if (this.events.fire('beforeSetMode', data) === false) {
            return;
        }

        this.mode = inArray(data.mode, [
            consts.MODE_SOURCE,
            consts.MODE_WYSIWYG,
            consts.MODE_SPLIT,
        ])
            ? data.mode
            : consts.MODE_WYSIWYG;

        if (this.options.saveModeInStorage) {
            this.storage.set('jodit_default_mode', this.mode);
        }

        modeClasses.forEach(className => {
            this.container.classList.remove(className);
        });
        this.container.classList.add(modeClasses[this.mode - 1]);

        /**
         * Triggered after {@link Jodit~setMode|setMode} executed
         * @event afterSetMode
         * @example
         * ```javascript
         * var editor = new Jodit("#redactor");
         * editor.events.on('afterSetMode', function () {
         *     editor.setEditorValue(''); // clear editor's value after change mode
         * });
         * ```
         */
        if (oldmode !== this.getMode()) {
            this.events.fire('afterSetMode');
        }
    }

    /**
     * Toggle editor mode WYSIWYG to TEXTAREA(CodeMirror) to SPLIT(WYSIWYG and TEXTAREA) to again WYSIWYG
     *
     * @example
     * ```javascript
     * var editor = new Jodit('#editor');
     * editor.toggleMode();
     * ```
     */
    public toggleMode() {
        let mode: number = this.getMode();
        if (
            inArray(mode + 1, [
                consts.MODE_SOURCE,
                consts.MODE_WYSIWYG,
                this.options.useSplitMode ? consts.MODE_SPLIT : 9,
            ])
        ) {
            mode += 1;
        } else {
            mode = consts.MODE_WYSIWYG;
        }

        this.setMode(mode);
    }

    /**
     * Internationalization method. Uses Jodit.lang object
     *
     * @param {string} key Some text
     * @param {string[]} params Some text
     * @return {string}
     * @example
     * ```javascript
     * var editor = new Jodit("#redactor", {
     *      langusage: 'ru'
     * });
     * console.log(editor.i18n('Cancel')) //????????????;
     *
     * Jodit.defaultOptions.language = 'ru';
     * console.log(Jodit.prototype.i18n('Cancel')) //????????????
     *
     * Jodit.lang.cs = {
     *    Cancel: 'Zru??it'
     * };
     * Jodit.defaultOptions.language = 'cs';
     * console.log(Jodit.prototype.i18n('Cancel')) //Zru??it
     *
     * Jodit.lang.cs = {
     *    'Hello world': 'Hello \s Good \s'
     * };
     * Jodit.defaultOptions.language = 'cs';
     * console.log(Jodit.prototype.i18n('Hello world', 'mr.Perkins', 'day')) //Hello mr.Perkins Good day
     * ```
     */
    public i18n(key: string, ...params: Array<string | number>): string {
        const debug: boolean =
            this.options !== undefined && this.options.debugLanguage;

        let store: IDictionary;

        const parse = (value: string): string =>
                params.length
                    ? sprintf.apply(this, [value].concat(params as string[]))
                    : value,
            default_language: string =
                Jodit.defaultOptions.language === 'auto'
                    ? defaultLanguage(Jodit.defaultOptions.language)
                    : Jodit.defaultOptions.language,
            language: string = defaultLanguage(
                this.options ? this.options.language : default_language
            );

        if (this.options !== undefined && Jodit.lang[language] !== undefined) {
            store = Jodit.lang[language];
        } else {
            if (Jodit.lang[default_language] !== undefined) {
                store = Jodit.lang[default_language];
            } else {
                store = Jodit.lang.en;
            }
        }

        if (
            this.options !== undefined &&
            (this.options.i18n as any)[language] !== undefined &&
            (this.options.i18n as any)[language][key]
        ) {
            return parse((this.options.i18n as any)[language][key]);
        }

        if (typeof store[key] === 'string' && store[key]) {
            return parse(store[key]);
        }

        if (debug) {
            return '{' + key + '}';
        }

        if (typeof Jodit.lang.en[key] === 'string' && Jodit.lang.en[key]) {
            return parse(Jodit.lang.en[key]);
        }

        return parse(key);
    }

    /**
     * Return current version
     *
     * @method getVersion
     * @return {string}
     */
    public getVersion = () => {
        return this.version;
    };

    /**
     * Switch on/off the editor into the disabled state.
     * When in disabled, the user is not able to change the editor content
     * This function firing the `disabled` event.
     *
     * @param {boolean} isDisabled
     */
    public setDisabled(isDisabled: boolean) {
        this.options.disabled = isDisabled;

        const readOnly: boolean = this.__wasReadOnly;
        this.setReadOnly(isDisabled || readOnly);
        this.__wasReadOnly = readOnly;

        if (this.editor) {
            this.editor.setAttribute('aria-disabled', isDisabled.toString());
            this.container.classList.toggle('jodit_disabled', isDisabled);
            this.events.fire('disabled', isDisabled);
        }
    }

    /**
     * Return true if editor in disabled mode
     */
    public getDisabled(): boolean {
        return this.options.disabled;
    }

    /**
     * Switch on/off the editor into the read-only state.
     * When in readonly, the user is not able to change the editor content, but can still
     * use some editor functions (show source code, print content, or seach).
     * This function firing the `readonly` event.
     *
     * @param {boolean} isReadOnly
     */
    public setReadOnly(isReadOnly: boolean) {
        if (this.__wasReadOnly === isReadOnly) {
            return;
        }

        this.__wasReadOnly = isReadOnly;
        this.options.readonly = isReadOnly;

        if (isReadOnly) {
            this.editor && this.editor.removeAttribute('contenteditable');
        } else {
            this.editor && this.editor.setAttribute('contenteditable', 'true');
        }

        this.events && this.events.fire('readonly', isReadOnly);
    }

    /**
     * Return true if editor in read-only mode
     */
    public getReadOnly(): boolean {
        return this.options.readonly;
    }

    /**
     * Create instance of Jodit
     * @constructor
     *
     * @param {HTMLInputElement | string} element Selector or HTMLElement
     * @param {object} options Editor's options
     */
    constructor(element: HTMLInputElement | string, options?: object) {
        super();

        this.buffer = {}; // empty new object for every Jodit instance

        this.options = new OptionsDefault(options) as Config;

        // in iframe it can be changed
        this.editorDocument = this.options.ownerDocument;
        this.editorWindow = this.options.ownerWindow;
        this.ownerDocument = this.options.ownerDocument;
        this.ownerWindow = this.options.ownerWindow;

        this.events = new EventsNative(this.ownerDocument);

        if (typeof element === 'string') {
            try {
                this.element = this.ownerDocument.querySelector(
                    element
                ) as HTMLInputElement;
            } catch (e) {
                throw new Error(
                    'String "' + element + '" should be valid HTML selector'
                );
            }
        } else {
            this.element = element;
        }

        // Duck checking
        if (
            !this.element ||
            typeof this.element !== 'object' ||
            this.element.nodeType !== Node.ELEMENT_NODE ||
            !this.element.cloneNode
        ) {
            throw new Error(
                'Element "' +
                    element +
                    '" should be string or HTMLElement instance'
            );
        }

        if (this.element.attributes) {
            [].slice.call(this.element.attributes).forEach((attr: Attr) => {
                const name: string = attr.name;
                let value: string | boolean | number = attr.value;

                if (
                    (Jodit.defaultOptions as any)[name] !== undefined &&
                    (!options || (options as any)[name] === undefined)
                ) {
                    if (['readonly', 'disabled'].indexOf(name) !== -1) {
                        value = value === '' || value === 'true';
                    }

                    if (/^[0-9]+(\.)?([0-9]+)?$/.test(value.toString())) {
                        value = Number(value);
                    }

                    (this.options as any)[name] = value;
                }
            });
        }

        if (this.options.events) {
            Object.keys(this.options.events).forEach((key: string) => {
                this.events.on(key, this.options.events[key]);
            });
        }

        this.selection = new Select(this);
        this.uploader = new Uploader(this);
        this.observer = new Observer(this);

        this.container = dom(
            '<div contenteditable="false" class="jodit_container" />',
            this.ownerDocument
        ) as HTMLDivElement;

        let buffer: null | string = null;

        if (this.options.inline) {
            if (['TEXTAREA', 'INPUT'].indexOf(this.element.nodeName) === -1) {
                this.container = this.element as HTMLDivElement;
                this.element.setAttribute(
                    this.__defaultClassesKey,
                    this.element.className.toString()
                );
                buffer = this.container.innerHTML;
                this.container.innerHTML = '';
            }

            this.container.classList.add('jodit_inline');
            this.container.classList.add('jodit_container');
        }

        this.container.classList.add(
            'jodit_' + (this.options.theme || 'default') + '_theme'
        );

        if (this.options.zIndex) {
            this.container.style.zIndex = parseInt(
                this.options.zIndex.toString(),
                10
            ).toString();
        }

        this.workplace = dom(
            '<div contenteditable="false" class="jodit_workplace" />',
            this.ownerDocument
        ) as HTMLDivElement;
        this.progress_bar = dom(
            '<div class="jodit_progress_bar"><div></div></div>',
            this.ownerDocument
        ) as HTMLDivElement;

        this.toolbar = new ToolbarCollection(this);

        if (this.options.toolbar) {
            this.toolbar.build(
                splitArray(this.options.buttons).concat(
                    this.options.extraButtons
                ),
                this.container
            );
        }

        this.container.classList.add(
            'jodit_toolbar_size-' +
                (['middle', 'large', 'small'].indexOf(
                    this.options.toolbarButtonSize.toLowerCase()
                ) !== -1
                    ? this.options.toolbarButtonSize.toLowerCase()
                    : 'middle')
        );

        if (this.options.textIcons) {
            this.container.classList.add('jodit_text_icons');
        }

        this.events.on(this.ownerWindow, 'resize', () => {
            if (this.events) {
                this.events.fire('resize');
            }
        });

        this.container.appendChild(this.workplace);
        this.statusbar = new StatusBar(this, this.container);

        this.workplace.appendChild(this.progress_bar);

        if (this.element.parentNode && this.element !== this.container) {
            this.element.parentNode.insertBefore(this.container, this.element);
        }

        this.helper = helper;

        this.id =
            this.element.getAttribute('id') || new Date().getTime().toString();

        this.__initPlugines();

        this.__initEditor(buffer).then(async () => {
            await this.events.fire('afterInit', this);
            this.events.fire('afterConstructor', this);
        });
    }
}
