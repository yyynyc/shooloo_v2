/*
 Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
CKEDITOR.dialog.add("smiley",function(a){for(var b=a.config,c=a.lang.smiley,d=b.smiley_images,e=b.smiley_columns||8,f,g=function(b){var c=b.data.getTarget(),d=c.getName();if("a"==d)c=c.getChild(0);else if("img"!=d)return;var d=c.getAttribute("cke_src"),e=c.getAttribute("title"),c=a.document.createElement("img",{attributes:{src:d,"data-cke-saved-src":d,title:e,alt:e,width:c.$.width,height:c.$.height}});a.insertElement(c),f.hide(),b.data.preventDefault()},h=CKEDITOR.tools.addFunction(function(b,c){var b=new CKEDITOR.dom.event(b),c=new CKEDITOR.dom.element(c),d;d=b.getKeystroke();var e="rtl"==a.lang.dir;switch(d){case 38:if(d=c.getParent().getParent().getPrevious())d=d.getChild([c.getParent().getIndex(),0]),d.focus();b.preventDefault();break;case 40:(d=c.getParent().getParent().getNext())&&(d=d.getChild([c.getParent().getIndex(),0]))&&d.focus(),b.preventDefault();break;case 32:g({data:b}),b.preventDefault();break;case e?37:39:if(d=c.getParent().getNext())d=d.getChild(0),d.focus(),b.preventDefault(!0);else if(d=c.getParent().getParent().getNext())(d=d.getChild([0,0]))&&d.focus(),b.preventDefault(!0);break;case e?39:37:if(d=c.getParent().getPrevious())d=d.getChild(0),d.focus(),b.preventDefault(!0);else if(d=c.getParent().getParent().getPrevious())d=d.getLast().getChild(0),d.focus(),b.preventDefault(!0)}}),i=CKEDITOR.tools.getNextId()+"_smiley_emtions_label",i=['<div><span id="'+i+'" class="cke_voice_label">'+c.options+"</span>",'<table role="listbox" aria-labelledby="'+i+'" style="width:100%;height:100%;border-collapse:separate;" cellspacing="2" cellpadding="2"',CKEDITOR.env.ie&&CKEDITOR.env.quirks?' style="position:absolute;"':"","><tbody>"],j=d.length,c=0;c<j;c++){0===c%e&&i.push('<tr role="presentation">');var k="cke_smile_label_"+c+"_"+CKEDITOR.tools.getNextNumber();i.push('<td class="cke_dark_background cke_centered" style="vertical-align: middle;" role="presentation"><a href="javascript:void(0)" role="option"',' aria-posinset="'+(c+1)+'"',' aria-setsize="'+j+'"',' aria-labelledby="'+k+'"',' class="cke_smile cke_hand" tabindex="-1" onkeydown="CKEDITOR.tools.callFunction( ',h,', event, this );">','<img class="cke_hand" title="',b.smiley_descriptions[c],'" cke_src="',CKEDITOR.tools.htmlEncode(b.smiley_path+d[c]),'" alt="',b.smiley_descriptions[c],'"',' src="',CKEDITOR.tools.htmlEncode(b.smiley_path+d[c]),'"',CKEDITOR.env.ie?" onload=\"this.setAttribute('width', 2); this.removeAttribute('width');\" ":"",'><span id="'+k+'" class="cke_voice_label">'+b.smiley_descriptions[c]+"</span></a>","</td>"),c%e==e-1&&i.push("</tr>")}if(c<e-1){for(;c<e-1;c++)i.push("<td></td>");i.push("</tr>")}return i.push("</tbody></table></div>"),b={type:"html",id:"smileySelector",html:i.join(""),onLoad:function(a){f=a.sender},focus:function(){var a=this;setTimeout(function(){a.getElement().getElementsByTag("a").getItem(0).focus()},0)},onClick:g,style:"width: 100%; border-collapse: separate;"},{title:a.lang.smiley.title,minWidth:270,minHeight:120,contents:[{id:"tab1",label:"",title:"",expand:!0,padding:0,elements:[b]}],buttons:[CKEDITOR.dialog.cancelButton]}});