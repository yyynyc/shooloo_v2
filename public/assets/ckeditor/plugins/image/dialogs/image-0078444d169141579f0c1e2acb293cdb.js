/*
 Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
(function(){var a=function(a,b){function c(){var a=arguments,b=this.getContentElement("advanced","txtdlgGenStyle");b&&b.commit.apply(b,a),this.foreach(function(b){b.commit&&"txtdlgGenStyle"!=b.id&&b.commit.apply(b,a)})}function d(a){if(!k){k=1;var b=this.getDialog(),c=b.imageElement;if(c){this.commit(e,c);for(var a=[].concat(a),d=a.length,f,g=0;g<d;g++)(f=b.getContentElement.apply(b,a[g].split(":")))&&f.setup(e,c)}k=0}}var e=1,f=/^\s*(\d+)((px)|\%)?\s*$/i,g=/(^\s*(\d+)((px)|\%)?\s*$)|^$/i,h=/^\d+px$/,i=function(){var a=this.getValue(),b=this.getDialog(),c=a.match(f);c&&("%"==c[2]&&l(b,!1),a=c[1]),b.lockRatio&&(c=b.originalElement,"true"==c.getCustomData("isReady")&&("txtHeight"==this.id?(a&&"0"!=a&&(a=Math.round(c.$.width*(a/c.$.height))),isNaN(a)||b.setValueOf("info","txtWidth",a)):(a&&"0"!=a&&(a=Math.round(c.$.height*(a/c.$.width))),isNaN(a)||b.setValueOf("info","txtHeight",a)))),j(b)},j=function(a){return!a.originalElement||!a.preview?1:(a.commitContent(4,a.preview),0)},k,l=function(a,b){if(!a.getContentElement("info","ratioLock"))return null;var c=a.originalElement;if(!c)return null;if("check"==b){if(!a.userlockRatio&&"true"==c.getCustomData("isReady")){var d=a.getValueOf("info","txtWidth"),e=a.getValueOf("info","txtHeight"),c=1e3*c.$.width/c.$.height,f=1e3*d/e;a.lockRatio=!1,!d&&!e?a.lockRatio=!0:!isNaN(c)&&!isNaN(f)&&Math.round(c)==Math.round(f)&&(a.lockRatio=!0)}}else void 0!=b?a.lockRatio=b:(a.userlockRatio=1,a.lockRatio=!a.lockRatio);return d=CKEDITOR.document.getById(s),a.lockRatio?d.removeClass("cke_btn_unlocked"):d.addClass("cke_btn_unlocked"),d.setAttribute("aria-checked",a.lockRatio),CKEDITOR.env.hc&&d.getChild(0).setHtml(a.lockRatio?CKEDITOR.env.ie?"■":"▣":CKEDITOR.env.ie?"□":"▢"),a.lockRatio},m=function(a){var b=a.originalElement;if("true"==b.getCustomData("isReady")){var c=a.getContentElement("info","txtWidth"),d=a.getContentElement("info","txtHeight");c&&c.setValue(b.$.width),d&&d.setValue(b.$.height)}j(a)},n=function(a,b){function c(a,b){var c=a.match(f);return c?("%"==c[2]&&(c[1]+="%",l(d,!1)),c[1]):b}if(a==e){var d=this.getDialog(),g="",h="txtWidth"==this.id?"width":"height",i=b.getAttribute(h);i&&(g=c(i,g)),g=c(b.getStyle(h),g),this.setValue(g)}},o,p=function(){var a=this.originalElement;a.setCustomData("isReady","true"),a.removeListener("load",p),a.removeListener("error",q),a.removeListener("abort",q),CKEDITOR.document.getById(u).setStyle("display","none"),this.dontResetSize||m(this),this.firstLoad&&CKEDITOR.tools.setTimeout(function(){l(this,"check")},0,this),this.dontResetSize=this.firstLoad=!1},q=function(){var a=this.originalElement;a.removeListener("load",p),a.removeListener("error",q),a.removeListener("abort",q),a=CKEDITOR.getUrl(CKEDITOR.plugins.get("image").path+"images/noimage.png"),this.preview&&this.preview.setAttribute("src",a),CKEDITOR.document.getById(u).setStyle("display","none"),l(this,!1)},r=function(a){return CKEDITOR.tools.getNextId()+"_"+a},s=r("btnLockSizes"),t=r("btnResetSize"),u=r("ImagePreviewLoader"),v=r("previewLink"),w=r("previewImage");return{title:a.lang.image["image"==b?"title":"titleButton"],minWidth:420,minHeight:360,onShow:function(){this.linkEditMode=this.imageEditMode=this.linkElement=this.imageElement=!1,this.lockRatio=!0,this.userlockRatio=0,this.dontResetSize=!1,this.firstLoad=!0,this.addLink=!1;var a=this.getParentEditor(),c=a.getSelection(),d=(c=c&&c.getSelectedElement())&&a.elementPath(c).contains("a",1);CKEDITOR.document.getById(u).setStyle("display","none"),o=new CKEDITOR.dom.element("img",a.document),this.preview=CKEDITOR.document.getById(w),this.originalElement=a.document.createElement("img"),this.originalElement.setAttribute("alt",""),this.originalElement.setCustomData("isReady","false");if(d){this.linkElement=d,this.linkEditMode=!0;var f=d.getChildren();if(1==f.count()){var g=f.getItem(0).getName();if("img"==g||"input"==g)this.imageElement=f.getItem(0),"img"==this.imageElement.getName()?this.imageEditMode="img":"input"==this.imageElement.getName()&&(this.imageEditMode="input")}"image"==b&&this.setupContent(2,d)}if(c&&"img"==c.getName()&&!c.data("cke-realelement")||c&&"input"==c.getName()&&"image"==c.getAttribute("type"))this.imageEditMode=c.getName(),this.imageElement=c;this.imageEditMode?(this.cleanImageElement=this.imageElement,this.imageElement=this.cleanImageElement.clone(!0,!0),this.setupContent(e,this.imageElement)):this.imageElement=a.document.createElement("img"),l(this,!0),CKEDITOR.tools.trim(this.getValueOf("info","txtUrl"))||(this.preview.removeAttribute("src"),this.preview.setStyle("display","none"))},onOk:function(){if(this.imageEditMode){var c=this.imageEditMode;"image"==b&&"input"==c&&confirm(a.lang.image.button2Img)?(this.imageElement=a.document.createElement("img"),this.imageElement.setAttribute("alt",""),a.insertElement(this.imageElement)):"image"!=b&&"img"==c&&confirm(a.lang.image.img2Button)?(this.imageElement=a.document.createElement("input"),this.imageElement.setAttributes({type:"image",alt:""}),a.insertElement(this.imageElement)):(this.imageElement=this.cleanImageElement,delete this.cleanImageElement)}else"image"==b?this.imageElement=a.document.createElement("img"):(this.imageElement=a.document.createElement("input"),this.imageElement.setAttribute("type","image")),this.imageElement.setAttribute("alt","");this.linkEditMode||(this.linkElement=a.document.createElement("a")),this.commitContent(e,this.imageElement),this.commitContent(2,this.linkElement),this.imageElement.getAttribute("style")||this.imageElement.removeAttribute("style"),this.imageEditMode?!this.linkEditMode&&this.addLink?(a.insertElement(this.linkElement),this.imageElement.appendTo(this.linkElement)):this.linkEditMode&&!this.addLink&&(a.getSelection().selectElement(this.linkElement),a.insertElement(this.imageElement)):this.addLink?this.linkEditMode?a.insertElement(this.imageElement):(a.insertElement(this.linkElement),this.linkElement.append(this.imageElement,!1)):a.insertElement(this.imageElement)},onLoad:function(){"image"!=b&&this.hidePage("Link");var a=this._.element.getDocument();this.getContentElement("info","ratioLock")&&(this.addFocusable(a.getById(t),5),this.addFocusable(a.getById(s),5)),this.commitContent=c},onHide:function(){this.preview&&this.commitContent(8,this.preview),this.originalElement&&(this.originalElement.removeListener("load",p),this.originalElement.removeListener("error",q),this.originalElement.removeListener("abort",q),this.originalElement.remove(),this.originalElement=!1),delete this.imageElement},contents:[{id:"info",label:a.lang.image.infoTab,accessKey:"I",elements:[{type:"vbox",padding:0,children:[{type:"hbox",widths:["280px","110px"],align:"right",children:[{id:"txtUrl",type:"text",label:a.lang.common.url,required:!0,onChange:function(){var a=this.getDialog(),b=this.getValue();if(0<b.length){var a=this.getDialog(),c=a.originalElement;a.preview.removeStyle("display"),c.setCustomData("isReady","false");var d=CKEDITOR.document.getById(u);d&&d.setStyle("display",""),c.on("load",p,a),c.on("error",q,a),c.on("abort",q,a),c.setAttribute("src",b),o.setAttribute("src",b),a.preview.setAttribute("src",o.$.src),j(a)}else a.preview&&(a.preview.removeAttribute("src"),a.preview.setStyle("display","none"))},setup:function(a,b){if(a==e){var c=b.data("cke-saved-src")||b.getAttribute("src");this.getDialog().dontResetSize=!0,this.setValue(c),this.setInitValue()}},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())?(b.data("cke-saved-src",this.getValue()),b.setAttribute("src",this.getValue())):8==a&&(b.setAttribute("src",""),b.removeAttribute("src"))},validate:CKEDITOR.dialog.validate.notEmpty(a.lang.image.urlMissing)},{type:"button",id:"browse",style:"display:inline-block;margin-top:10px;",align:"center",label:a.lang.common.browseServer,hidden:!0,filebrowser:"info:txtUrl"}]}]},{id:"txtAlt",type:"text",label:a.lang.image.alt,accessKey:"T","default":"",onChange:function(){j(this.getDialog())},setup:function(a,b){a==e&&this.setValue(b.getAttribute("alt"))},commit:function(a,b){a==e?(this.getValue()||this.isChanged())&&b.setAttribute("alt",this.getValue()):4==a?b.setAttribute("alt",this.getValue()):8==a&&b.removeAttribute("alt")}},{type:"hbox",children:[{id:"basic",type:"vbox",children:[{type:"hbox",requiredContent:"img{width,height}",widths:["50%","50%"],children:[{type:"vbox",padding:1,children:[{type:"text",width:"45px",id:"txtWidth",label:a.lang.common.width,onKeyUp:i,onChange:function(){d.call(this,"advanced:txtdlgGenStyle")},validate:function(){var b=this.getValue().match(g);return(b=!!b&&0!==parseInt(b[1],10))||alert(a.lang.common.invalidWidth),b},setup:n,commit:function(a,b,c){var d=this.getValue();a==e?(d?b.setStyle("width",CKEDITOR.tools.cssLength(d)):b.removeStyle("width"),!c&&b.removeAttribute("width")):4==a?d.match(f)?b.setStyle("width",CKEDITOR.tools.cssLength(d)):(a=this.getDialog().originalElement,"true"==a.getCustomData("isReady")&&b.setStyle("width",a.$.width+"px")):8==a&&(b.removeAttribute("width"),b.removeStyle("width"))}},{type:"text",id:"txtHeight",width:"45px",label:a.lang.common.height,onKeyUp:i,onChange:function(){d.call(this,"advanced:txtdlgGenStyle")},validate:function(){var b=this.getValue().match(g);return(b=!!b&&0!==parseInt(b[1],10))||alert(a.lang.common.invalidHeight),b},setup:n,commit:function(a,b,c){var d=this.getValue();a==e?(d?b.setStyle("height",CKEDITOR.tools.cssLength(d)):b.removeStyle("height"),!c&&b.removeAttribute("height")):4==a?d.match(f)?b.setStyle("height",CKEDITOR.tools.cssLength(d)):(a=this.getDialog().originalElement,"true"==a.getCustomData("isReady")&&b.setStyle("height",a.$.height+"px")):8==a&&(b.removeAttribute("height"),b.removeStyle("height"))}}]},{id:"ratioLock",type:"html",style:"margin-top:30px;width:40px;height:40px;",onLoad:function(){var a=CKEDITOR.document.getById(t),b=CKEDITOR.document.getById(s);a&&(a.on("click",function(a){m(this),a.data&&a.data.preventDefault()},this.getDialog()),a.on("mouseover",function(){this.addClass("cke_btn_over")},a),a.on("mouseout",function(){this.removeClass("cke_btn_over")},a)),b&&(b.on("click",function(a){l(this);var b=this.originalElement,c=this.getValueOf("info","txtWidth");b.getCustomData("isReady")=="true"&&c&&(b=b.$.height/b.$.width*c,isNaN(b)||(this.setValueOf("info","txtHeight",Math.round(b)),j(this))),a.data&&a.data.preventDefault()},this.getDialog()),b.on("mouseover",function(){this.addClass("cke_btn_over")},b),b.on("mouseout",function(){this.removeClass("cke_btn_over")},b))},html:'<div><a href="javascript:void(0)" tabindex="-1" title="'+a.lang.image.lockRatio+'" class="cke_btn_locked" id="'+s+'" role="checkbox"><span class="cke_icon"></span><span class="cke_label">'+a.lang.image.lockRatio+'</span></a><a href="javascript:void(0)" tabindex="-1" title="'+a.lang.image.resetSize+'" class="cke_btn_reset" id="'+t+'" role="button"><span class="cke_label">'+a.lang.image.resetSize+"</span></a></div>"}]},{type:"vbox",padding:1,children:[{type:"text",id:"txtBorder",requiredContent:"img{border-width}",width:"60px",label:a.lang.image.border,"default":"",onKeyUp:function(){j(this.getDialog())},onChange:function(){d.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(a.lang.image.validateBorder),setup:function(a,b){if(a==e){var c;c=(c=(c=b.getStyle("border-width"))&&c.match(/^(\d+px)(?: \1 \1 \1)?$/))&&parseInt(c[1],10),isNaN(parseInt(c,10))&&(c=b.getAttribute("border")),this.setValue(c)}},commit:function(a,b,c){var d=parseInt(this.getValue(),10);a==e||4==a?(isNaN(d)?!d&&this.isChanged()&&b.removeStyle("border"):(b.setStyle("border-width",CKEDITOR.tools.cssLength(d)),b.setStyle("border-style","solid")),!c&&a==e&&b.removeAttribute("border")):8==a&&(b.removeAttribute("border"),b.removeStyle("border-width"),b.removeStyle("border-style"),b.removeStyle("border-color"))}},{type:"text",id:"txtHSpace",requiredContent:"img{margin-left,margin-right}",width:"60px",label:a.lang.image.hSpace,"default":"",onKeyUp:function(){j(this.getDialog())},onChange:function(){d.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(a.lang.image.validateHSpace),setup:function(a,b){if(a==e){var c,d;c=b.getStyle("margin-left"),d=b.getStyle("margin-right"),c=c&&c.match(h),d=d&&d.match(h),c=parseInt(c,10),d=parseInt(d,10),c=c==d&&c,isNaN(parseInt(c,10))&&(c=b.getAttribute("hspace")),this.setValue(c)}},commit:function(a,b,c){var d=parseInt(this.getValue(),10);a==e||4==a?(isNaN(d)?!d&&this.isChanged()&&(b.removeStyle("margin-left"),b.removeStyle("margin-right")):(b.setStyle("margin-left",CKEDITOR.tools.cssLength(d)),b.setStyle("margin-right",CKEDITOR.tools.cssLength(d))),!c&&a==e&&b.removeAttribute("hspace")):8==a&&(b.removeAttribute("hspace"),b.removeStyle("margin-left"),b.removeStyle("margin-right"))}},{type:"text",id:"txtVSpace",requiredContent:"img{margin-top,margin-bottom}",width:"60px",label:a.lang.image.vSpace,"default":"",onKeyUp:function(){j(this.getDialog())},onChange:function(){d.call(this,"advanced:txtdlgGenStyle")},validate:CKEDITOR.dialog.validate.integer(a.lang.image.validateVSpace),setup:function(a,b){if(a==e){var c,d;c=b.getStyle("margin-top"),d=b.getStyle("margin-bottom"),c=c&&c.match(h),d=d&&d.match(h),c=parseInt(c,10),d=parseInt(d,10),c=c==d&&c,isNaN(parseInt(c,10))&&(c=b.getAttribute("vspace")),this.setValue(c)}},commit:function(a,b,c){var d=parseInt(this.getValue(),10);a==e||4==a?(isNaN(d)?!d&&this.isChanged()&&(b.removeStyle("margin-top"),b.removeStyle("margin-bottom")):(b.setStyle("margin-top",CKEDITOR.tools.cssLength(d)),b.setStyle("margin-bottom",CKEDITOR.tools.cssLength(d))),!c&&a==e&&b.removeAttribute("vspace")):8==a&&(b.removeAttribute("vspace"),b.removeStyle("margin-top"),b.removeStyle("margin-bottom"))}},{id:"cmbAlign",requiredContent:"img{float}",type:"select",widths:["35%","65%"],style:"width:90px",label:a.lang.common.align,"default":"",items:[[a.lang.common.notSet,""],[a.lang.common.alignLeft,"left"],[a.lang.common.alignRight,"right"]],onChange:function(){j(this.getDialog()),d.call(this,"advanced:txtdlgGenStyle")},setup:function(a,b){if(a==e){var c=b.getStyle("float");switch(c){case"inherit":case"none":c=""}!c&&(c=(b.getAttribute("align")||"").toLowerCase()),this.setValue(c)}},commit:function(a,b,c){var d=this.getValue();if(a==e||4==a){if(d?b.setStyle("float",d):b.removeStyle("float"),!c&&a==e)switch(d=(b.getAttribute("align")||"").toLowerCase(),d){case"left":case"right":b.removeAttribute("align")}}else 8==a&&b.removeStyle("float")}}]}]},{type:"vbox",height:"250px",children:[{type:"html",id:"htmlPreview",style:"width:95%;",html:"<div>"+CKEDITOR.tools.htmlEncode(a.lang.common.preview)+'<br><div id="'+u+'" class="ImagePreviewLoader" style="display:none"><div class="loading">&nbsp;</div></div><div class="ImagePreviewBox"><table><tr><td><a href="javascript:void(0)" target="_blank" onclick="return false;" id="'+v+'"><img id="'+w+'" alt="" /></a>'+(a.config.image_previewText||"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas feugiat consequat diam. Maecenas metus. Vivamus diam purus, cursus a, commodo non, facilisis vitae, nulla. Aenean dictum lacinia tortor. Nunc iaculis, nibh non iaculis aliquam, orci felis euismod neque, sed ornare massa mauris sed velit. Nulla pretium mi et risus. Fusce mi pede, tempor id, cursus ac, ullamcorper nec, enim. Sed tortor. Curabitur molestie. Duis velit augue, condimentum at, ultrices a, luctus ut, orci. Donec pellentesque egestas eros. Integer cursus, augue in cursus faucibus, eros pede bibendum sem, in tempus tellus justo quis ligula. Etiam eget tortor. Vestibulum rutrum, est ut placerat elementum, lectus nisl aliquam velit, tempor aliquam eros nunc nonummy metus. In eros metus, gravida a, gravida sed, lobortis id, turpis. Ut ultrices, ipsum at venenatis fringilla, sem nulla lacinia tellus, eget aliquet turpis mauris non enim. Nam turpis. Suspendisse lacinia. Curabitur ac tortor ut ipsum egestas elementum. Nunc imperdiet gravida mauris.")+"</td></tr></table></div></div>"}]}]}]},{id:"Link",requiredContent:"a[href]",label:a.lang.image.linkTab,padding:0,elements:[{id:"txtUrl",type:"text",label:a.lang.common.url,style:"width: 100%","default":"",setup:function(a,b){if(2==a){var c=b.data("cke-saved-href");c||(c=b.getAttribute("href")),this.setValue(c)}},commit:function(b,c){if(2==b&&(this.getValue()||this.isChanged())){var d=decodeURI(this.getValue());c.data("cke-saved-href",d),c.setAttribute("href",d);if(this.getValue()||!a.config.image_removeLinkByEmptyURL)this.getDialog().addLink=!0}}},{type:"button",id:"browse",filebrowser:{action:"Browse",target:"Link:txtUrl",url:a.config.filebrowserImageBrowseLinkUrl},style:"float:right",hidden:!0,label:a.lang.common.browseServer},{id:"cmbTarget",type:"select",requiredContent:"a[target]",label:a.lang.common.target,"default":"",items:[[a.lang.common.notSet,""],[a.lang.common.targetNew,"_blank"],[a.lang.common.targetTop,"_top"],[a.lang.common.targetSelf,"_self"],[a.lang.common.targetParent,"_parent"]],setup:function(a,b){2==a&&this.setValue(b.getAttribute("target")||"")},commit:function(a,b){2==a&&(this.getValue()||this.isChanged())&&b.setAttribute("target",this.getValue())}}]},{id:"Upload",hidden:!0,filebrowser:"uploadButton",label:a.lang.image.upload,elements:[{type:"file",id:"upload",label:a.lang.image.btnUpload,style:"height:40px",size:38},{type:"fileButton",id:"uploadButton",filebrowser:"info:txtUrl",label:a.lang.image.btnUpload,"for":["Upload","upload"]}]},{id:"advanced",label:a.lang.common.advancedTab,elements:[{type:"hbox",widths:["50%","25%","25%"],children:[{type:"text",id:"linkId",requiredContent:"img[id]",label:a.lang.common.id,setup:function(a,b){a==e&&this.setValue(b.getAttribute("id"))},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())&&b.setAttribute("id",this.getValue())}},{id:"cmbLangDir",type:"select",requiredContent:"img[dir]",style:"width : 100px;",label:a.lang.common.langDir,"default":"",items:[[a.lang.common.notSet,""],[a.lang.common.langDirLtr,"ltr"],[a.lang.common.langDirRtl,"rtl"]],setup:function(a,b){a==e&&this.setValue(b.getAttribute("dir"))},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())&&b.setAttribute("dir",this.getValue())}},{type:"text",id:"txtLangCode",requiredContent:"img[lang]",label:a.lang.common.langCode,"default":"",setup:function(a,b){a==e&&this.setValue(b.getAttribute("lang"))},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())&&b.setAttribute("lang",this.getValue())}}]},{type:"text",id:"txtGenLongDescr",requiredContent:"img[longdesc]",label:a.lang.common.longDescr,setup:function(a,b){a==e&&this.setValue(b.getAttribute("longDesc"))},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())&&b.setAttribute("longDesc",this.getValue())}},{type:"hbox",widths:["50%","50%"],children:[{type:"text",id:"txtGenClass",requiredContent:"img(cke-xyz)",label:a.lang.common.cssClass,"default":"",setup:function(a,b){a==e&&this.setValue(b.getAttribute("class"))},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())&&b.setAttribute("class",this.getValue())}},{type:"text",id:"txtGenTitle",requiredContent:"img[title]",label:a.lang.common.advisoryTitle,"default":"",onChange:function(){j(this.getDialog())},setup:function(a,b){a==e&&this.setValue(b.getAttribute("title"))},commit:function(a,b){a==e?(this.getValue()||this.isChanged())&&b.setAttribute("title",this.getValue()):4==a?b.setAttribute("title",this.getValue()):8==a&&b.removeAttribute("title")}}]},{type:"text",id:"txtdlgGenStyle",requiredContent:"img{cke-xyz}",label:a.lang.common.cssStyle,validate:CKEDITOR.dialog.validate.inlineStyle(a.lang.common.invalidInlineStyle),"default":"",setup:function(a,b){if(a==e){var c=b.getAttribute("style");!c&&b.$.style.cssText&&(c=b.$.style.cssText),this.setValue(c);var d=b.$.style.height,c=b.$.style.width,d=(d?d:"").match(f),c=(c?c:"").match(f);this.attributesInStyle={height:!!d,width:!!c}}},onChange:function(){d.call(this,"info:cmbFloat info:cmbAlign info:txtVSpace info:txtHSpace info:txtBorder info:txtWidth info:txtHeight".split(" ")),j(this)},commit:function(a,b){a==e&&(this.getValue()||this.isChanged())&&b.setAttribute("style",this.getValue())}}]}]}};CKEDITOR.dialog.add("image",function(b){return a(b,"image")}),CKEDITOR.dialog.add("imagebutton",function(b){return a(b,"imagebutton")})})();