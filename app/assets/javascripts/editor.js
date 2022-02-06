$(document).on('turbolinks:load',function () {

  lumni_quill()

  // Jodit Editor!

  if( $('.lumni-jodit').length > 0){
    lumni_jodit()
  }

})


function lumni_quill(){

  var toolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],        // toggled buttons

    [{ 'header': 1 }, { 'header': 2 }],               // custom button values
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
    [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent

    [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

    [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
    [{ 'align': [] }]

    ['clean']                                         // remove formatting button
  ];


  if($('.quill-bubble-editor').length >0){

    
    for(i=0;i < $('.quill-bubble-editor').length;i++){
      targetId = '#' + $('.quill-bubble-editor')[i].id
      target_placeholder = $(targetId).attr('starting_text')

      var bubbleEditor = new Quill(targetId, {
        placeholder: target_placeholder,
        modules: {
          toolbar: {
            container: toolbarOptions,
            handlers: {
                "options": function (value) { 
                    if (value) {
                        const cursorPosition = this.quill.getSelection().index;
                        this.quill.insertText(cursorPosition, value,{bold: true,underline: true,color: '#26B4FF',class: 'justatest'});
                        this.quill.setSelection(cursorPosition + value.length);
                    }
                }
            }
          }
        },
        theme: 'bubble'
      });
    };




    $('.lumnisubmit').on('click',function(){

      for(i=0;i < $('.quill-bubble-editor').length;i++){
        targetElement = $('.quill-bubble-editor')[i]
        targetContent = targetElement.children[0].innerHTML

        $('#' + targetElement.id.split('lumnieditor')[0]).val(targetContent)

      }

    })




  }

}



// Jodit Editor

function lumni_jodit(){
  for(i=0;i<$('.lumni-jodit').length;i++){
    if(typeof joditelements != 'object'){
      joditelements = {}
    }

    targetId = '#' + $('.lumni-jodit')[i].id
    if($(targetId).attr('jodit_loaded_status') != 'done'){
      joditelements[targetId] = new Jodit(targetId)
      $(targetId).attr('jodit_loaded_status','done')
    }

  }



  $('.lumnisubmit').on('click',function(){
    for(i=0;i < $('.lumni-jodit').length;i++){
      targetId = '#' + $('.lumni-jodit')[i].id
      if($(targetId).attr('jodit_status') != 'done'){

        $( targetId.split('lumnifulleditor')[0]).val(joditelements[targetId].value)
      }

    }

  })
}



/*


var toolbarOptions = [
  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
  ['blockquote', 'code-block'],

  [{ 'header': 1 }, { 'header': 2 }],               // custom button values
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  [{ 'script':'sub'}, { 'script': 'super' }],      // superscript/subscript
  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
  [{ 'direction': 'rtl' }],                         // text direction

  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
  [{ 'font': [] }],
  [{ 'align': [] }],

  ['clean'],                                         // remove formatting button
  ['link', 'image', 'video'],
  ['spanblock']
];


let Inline = Quill.import('blots/inline');

class SpanBlock extends Inline{    
    
    static create(value){
        let node = super.create();
        node.setAttribute('class','spanblock');
        return node;    
    } 

    
}

SpanBlock.blotName = 'spanblock';
SpanBlock.tagName = 'div';
Quill.register(SpanBlock);

var quill = new Quill('#editor', {
  modules: {
    toolbar: toolbarOptions
  },
  theme: 'snow'
});

var spanBlockButton = document.querySelector('.ql-spanblock');

spanBlockButton.addEventListener('click', function() {
        console.log('function called');
        var range = quill.getSelection();
        if(range){
            console.log('range is valid');
            quill.formatText(range,'spanblock');
        }else{
            console.log('it it invalid');
        }

    }
);

*/

  