CKEDITOR.editorConfig = function( config ) {
    config.toolbar = [
        [ 'SpellChecker', 'Scayt', 'Table','SpecialChar' ],
        [ 'Bold', 'Italic', '-', 'Underline','Strike', '-', 'Subscript','Superscript','-','RemoveFormat' ], 
        [ 'Cut', 'Copy', 'PasteFromWord', '-', 'Undo', 'Redo' ],
       	[ 'Find','Replace','-','SelectAll' ],
       	[ 'NumberedList','BulletedList','-','Outdent','Indent',
			'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ]
    ];
    config.div_wrapTable=true;
};
