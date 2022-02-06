class DocsNotesController < ApplicationController
	def index
		@docs_note = DocsNote.lumniStart(params,current_company, list: current_user.template('DocsNote','docs_notes',current_user))
		contactDocsNote = @docs_note.lumniSave(params,current_user, list: current_user.template('DocsNote','docs_notes',current_user))
		lumniClose(@docs_note,contactDocsNote)
	end

	def new
		@docs_note = DocsNote.lumniStart(params,current_company, list: current_user.template('DocsNote','docs_notes',current_user))
		contactDocsNote = @docs_note.lumniSave(params,current_user, list: current_user.template('DocsNote','docs_notes',current_user))
		lumniClose(@docs_note,contactDocsNote)
	end

	def create
		@docs_note = DocsNote.lumniStart(params,current_company, list: current_user.template('DocsNote','docs_notes',current_user))
		contactDocsNote = @docs_note.lumniSave(params,current_user, list: current_user.template('DocsNote','docs_notes',current_user))
		lumniClose(@docs_note,contactDocsNote)
	end

	def edit
		@docs_note = DocsNote.lumniStart(params,current_company, list: current_user.template('DocsNote','docs_notes',current_user))
		contactDocsNote = @docs_note.lumniSave(params,current_user, list: current_user.template('DocsNote','docs_notes',current_user))
		lumniClose(@docs_note,contactDocsNote)
	end

	def update
		@docs_note = DocsNote.lumniStart(params,current_company, list: current_user.template('DocsNote','docs_notes',current_user))
		contactDocsNote = @docs_note.lumniSave(params,current_user, list: current_user.template('DocsNote','docs_notes',current_user))
		lumniClose(@docs_note,contactDocsNote)
	end
	def destroy
		@docs_note = DocsNote.lumniStart(params,current_company, list: current_user.template('DocsNote','docs_notes',current_user))
		contactDocsNote = @docs_note.lumniSave(params,current_user, list: current_user.template('DocsNote','docs_notes',current_user))
		lumniClose(@cluster,contactDocsNote)
	end
end