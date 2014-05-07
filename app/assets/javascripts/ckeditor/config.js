CKEDITOR.editorConfig = function( config ) {
    config.autoParagraph = true; 
    config.scayt_autoStartup = true;
    config.toolbar = [
        [ 'SpellChecker', 'Scayt', 'Table', 'EqnEditor' ],
        [ 'Bold', 'Italic', '-', 'Underline','Strike', '-', 'Subscript','Superscript','-','RemoveFormat' ], 
        [ 'Cut', 'Copy', 'PasteFromWord', '-', 'Undo', 'Redo' ],
       	[ 'Find','Replace','-','SelectAll' ],
       	[ 'NumberedList','BulletedList','-','Outdent','Indent',
			'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ],
        [ 'Smiley']
    ];
    config.extraPlugins = 'tabletools,eqneditor';
    config.language = 'en';
    // config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') + 'ckeditor_wiris';
    // config.allowedContent = true;
 //    config.toolbar = "CKcomment"
 //    config.toolbar_CKcomment = [
 //    	[ 'SpellChecker', 'Scayt', 'SpecialChar' ],
 //        [ 'Bold', 'Italic', '-', 'Underline','Strike', 'TextColor', '-', 'Subscript','Superscript','-','RemoveFormat' ], 
 //        [ 'Cut', 'Copy', 'PasteFromWord', '-', 'Undo', 'Redo' ],
 //       	[ 'NumberedList','BulletedList','-','Outdent','Indent',
	// 		'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ],
	// 	[ 'Smiley']
 //    ]

 //    config.toolbar = "admin"
 //    config.toolbar_admin = [
 //    	[ 'SpellChecker', 'Scayt', 'Table','SpecialChar' ],
 //        [ 'Bold', 'Italic', '-', 'Underline','Strike', '-', 'Subscript','Superscript','-','RemoveFormat' ], 
 //        [ 'Cut', 'Copy', 'PasteFromWord', '-', 'Undo', 'Redo' ],
 //       	[ 'Find','Replace','-','SelectAll' ],
 //       	[ 'NumberedList','BulletedList','-','Outdent','Indent',
	// 		'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ],
	// 	[ 'Link', 'Unlink' ], 
	// 	[ 'Source']
	// ]

	// config.toolbar = "comment_admin"
 //    config.toolbar_comment_admin = [
 //    	[ 'SpellChecker', 'Scayt', 'SpecialChar' ],
 //        [ 'Bold', 'Italic', '-', 'Underline','Strike', 'TextColor', '-', 'Subscript','Superscript','-','RemoveFormat' ], 
 //        [ 'Cut', 'Copy', 'PasteFromWord', '-', 'Undo', 'Redo' ],
 //       	[ 'NumberedList','BulletedList','-','Outdent','Indent',
	// 		'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ],
	// 	[ 'Smiley'],
	// 	[ 'Link', 'Unlink' ], 
	// 	[ 'Source']
 //    ]
};

CKEDITOR.config.smiley_images= [
	'regular_smile.gif','sad_smile.gif','wink_smile.gif','teeth_smile.gif',
	'confused_smile.gif','tongue_smile.gif',
    'embarrassed_smile.gif','omg_smile.gif','whatchutalkingabout_smile.gif',
    'angel_smile.gif','shades_smile.gif',
    'cry_smile.gif','lightbulb.gif','thumbs_up.gif','heart.gif',
    'broken_heart.gif'
];

CKEDITOR.config.smiley_descriptions = [
    'smiley', 'sad', 'wink', 'laugh', 
    'frown', 'cheeky', 
    'blush', 'surprise', 'indecision', 
    'angel', 'cool', 
    'cry', 'idea', 'yes', 'heart', 'broken heart'
];

