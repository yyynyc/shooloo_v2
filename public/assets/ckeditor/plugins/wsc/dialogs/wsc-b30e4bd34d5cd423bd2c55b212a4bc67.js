/*
 Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
*/
(function(){function a(a){if(!a)throw"Languages-by-groups list are required for construct selectbox";var b=[],c="",d;for(d in a)for(var e in a[d]){var f=a[d][e];"en_US"==f?c=f:b.push(f)}return b.sort(),c&&b.unshift(c),{getCurrentLangGroup:function(b){a:{for(var c in a)for(var d in a[c])if(d.toUpperCase()===b.toUpperCase()){b=c;break a}b=""}return b},setLangList:function(){var b={},c;for(c in a)for(var d in a[c])b[a[c][d]]=d;return b}()}}var b=function(){var a=function(a,b,c){var c=c||{},d=c.expires;if("number"==typeof d&&d){var e=new Date;e.setTime(e.getTime()+1e3*d),d=c.expires=e}d&&d.toUTCString&&(c.expires=d.toUTCString());var b=encodeURIComponent(b),a=a+"="+b,f;for(f in c)b=c[f],a+="; "+f,!0!==b&&(a+="="+b);document.cookie=a};return{postMessage:{init:function(a){document.addEventListener?window.addEventListener("message",a,!1):window.attachEvent("onmessage",a)},send:function(a){var b=a.fn||null,c=a.id||"",d=a.target||window,e=a.message||{id:c};"[object Object]"==Object.prototype.toString.call(a.message)&&(a.message.id||(a.message.id=c),e=a.message),a=window.JSON.stringify(e,b),d.postMessage(a,"*")}},hash:{create:function(){},parse:function(){}},cookie:{set:a,get:function(a){return(a=document.cookie.match(RegExp("(?:^|; )"+a.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g,"\\$1")+"=([^;]*)")))?decodeURIComponent(a[1]):void 0},remove:function(b){a(b,"",{expires:-1})}}}}(),c=c||{};c.TextAreaNumber=null,c.load=!0,c.cmd={SpellTab:"spell",Thesaurus:"thes",GrammTab:"grammar"},c.dialog=null,c.optionNode=null,c.selectNode=null,c.grammerSuggest=null,c.textNode={},c.iframeMain=null,c.dataTemp="",c.div_overlay=null,c.textNodeInfo={},c.selectNode={},c.selectNodeResponce={},c.selectingLang=c.currentLang,c.langList=null,c.langSelectbox=null,c.banner="",c.show_grammar=null,c.div_overlay_no_check=null,c.wsc_customerId=CKEDITOR.config.wsc_customerId,c.cust_dic_ids=CKEDITOR.config.wsc_customDictionaryIds,c.userDictionaryName=CKEDITOR.config.wsc_userDictionaryName,c.defaultLanguage=CKEDITOR.config.defaultLanguage,c.targetFromFrame={},c.onLoadOverlay=null,c.LocalizationComing={},c.OverlayPlace=null,c.LocalizationButton={ChangeTo:{instance:null,text:"Change to"},ChangeAll:{instance:null,text:"Change All"},IgnoreWord:{instance:null,text:"Ignore word"},IgnoreAllWords:{instance:null,text:"Ignore all words"},Options:{instance:null,text:"Options",optionsDialog:{instance:null}},AddWord:{instance:null,text:"Add word"},FinishChecking:{instance:null,text:"Finish Checking"}},c.LocalizationLabel={ChangeTo:{instance:null,text:"Change to"},Suggestions:{instance:null,text:"Suggestions"}};var d=function(a){for(var b in a)a[b].instance.getElement().setText(c.LocalizationComing[b])},e=function(a){for(var b in a){if(!a[b].instance.setLabel)break;a[b].instance.setLabel(c.LocalizationComing[b])}},f,g;c.framesetHtml=function(a){return'<iframe src="'+c.templatePath+c.serverLocation+'" id='+c.iframeNumber+"_"+a+' frameborder="0" allowtransparency="1" style="width:100%;border: 1px solid #AEB3B9;overflow: auto;background:#fff; border-radius: 3px;"></iframe>'},c.setIframe=function(a,b){var d=c.framesetHtml(b);return a.getElement().setHtml(d)},c.setCurrentIframe=function(a){c.setIframe(c.dialog._.contents[a].Content,a)},c.setHeightBannerFrame=function(){var a=c.dialog.getContentElement("SpellTab","banner").getElement(),b=c.dialog.getContentElement("GrammTab","banner").getElement(),d=c.dialog.getContentElement("Thesaurus","banner").getElement();a.setStyle("height","90px"),b.setStyle("height","90px"),d.setStyle("height","90px")},c.setHeightFrame=function(){document.getElementById(c.iframeNumber+"_"+c.dialog._.currentTabId).style.height="240px"},c.sendData=function(a){var b=a._.currentTabId,d=a._.contents[b].Content,e,f;c.setIframe(d,b),a.parts.tabs.removeAllListeners(),a.parts.tabs.on("click",function(g){g=g||window.event,g.data.getTarget().is("a")&&b!=a._.currentTabId&&(b=a._.currentTabId,d=a._.contents[b].Content,e=c.iframeNumber+"_"+b,c.div_overlay.setEnable(),d.getElement().getChildCount()?n(c.targetFromFrame[e],c.cmd[b]):(c.setIframe(d,b),f=document.getElementById(e),c.targetFromFrame[e]=f.contentWindow))})},c.buildSelectLang=function(){var a=new CKEDITOR.dom.element("div"),b=new CKEDITOR.dom.element("select"),d="wscLang"+c.CKNumber;return a.addClass("cke_dialog_ui_input_select"),a.setAttribute("role","presentation"),a.setStyles({height:"auto",position:"absolute",right:"0",top:"-1px",width:"160px","white-space":"normal"}),b.setAttribute("id",d),b.addClass("cke_dialog_ui_input_select"),b.setStyles({width:"160px"}),a.append(b),a},c.buildOptionLang=function(a){var b=document.getElementById("wscLang"+c.CKNumber),d=document.createDocumentFragment(),e,f=[];if(0===b.options.length){for(e in a)f.push([e,a[e]]);f.sort();for(var g=0;g<f.length;g++)a=document.createElement("option"),a.setAttribute("value",f[g][1]),e=document.createTextNode(f[g][0]),a.appendChild(e),f[g][1]==c.selectingLang&&a.setAttribute("selected","selected"),d.appendChild(a);b.appendChild(d)}},c.buildOptionSynonyms=function(a){a=c.selectNodeResponce[a],c.selectNode.synonyms.clear();for(var b=0;b<a.length;b++)c.selectNode.synonyms.add(a[b],a[b]);c.selectNode.synonyms.getInputElement().$.firstChild.selected=!0,c.textNode.Thesaurus.setValue(c.selectNode.synonyms.getInputElement().getValue())};var h=function(a){var b=document,c=a.target||b.body,d=a.id||"overlayBlock",e=a.opacity||"0.9",a=a.background||"#f1f1f1",f=b.getElementById(d),g=f||b.createElement("div");return g.style.cssText="position: absolute;top:30px;bottom:40px;left:1px;right:1px;z-index: 10020;padding:0;margin:0;background:"+a+";opacity: "+e+";filter: alpha(opacity="+100*e+");display: none;",g.id=d,f||c.appendChild(g),{setDisable:function(){g.style.display="none"},setEnable:function(){g.style.display="block"}}},i=function(a,b,d){var e=new CKEDITOR.dom.element("div"),f=new CKEDITOR.dom.element("input"),g=new CKEDITOR.dom.element("label"),h="wscGrammerSuggest"+a+"_"+b;return e.addClass("cke_dialog_ui_input_radio"),e.setAttribute("role","presentation"),e.setStyles({width:"97%",padding:"5px","white-space":"normal"}),f.setAttributes({type:"radio",value:b,name:"wscGrammerSuggest",id:h}),f.setStyles({"float":"left"}),f.on("click",function(a){c.textNode.GrammTab.setValue(a.sender.getValue())}),d&&f.setAttribute("checked",!0),f.addClass("cke_dialog_ui_radio_input"),g.appendText(a),g.setAttribute("for",h),g.setStyles({display:"block","line-height":"16px","margin-left":"18px","white-space":"normal"}),e.append(f),e.append(g),e},j=function(d){var e=new a(d),d=document.getElementById("wscLang"+c.CKNumber),f=c.iframeNumber+"_"+c.dialog._.currentTabId;c.buildOptionLang(e.setLangList),o[e.getCurrentLangGroup(c.selectingLang)](),d.onchange=function(){o[e.getCurrentLangGroup(this.value)](),c.div_overlay.setEnable(),c.selectingLang=this.value,b.postMessage.send({message:{changeLang:c.selectingLang,text:c.dataTemp},target:c.targetFromFrame[f],id:"selectionLang_outer__page"})}},k=function(a){if("no_any_suggestions"==a){a="No suggestions",c.LocalizationButton.ChangeTo.instance.disable(),c.LocalizationButton.ChangeAll.instance.disable();var b=function(a){a=c.LocalizationButton[a].instance,a.getElement().hasClass("cke_disabled")?a.getElement().setStyle("color","#a0a0a0"):a.disable()};b("ChangeTo"),b("ChangeAll")}else c.LocalizationButton.ChangeTo.instance.enable(),c.LocalizationButton.ChangeAll.instance.enable(),c.LocalizationButton.ChangeTo.instance.getElement().setStyle("color","#333"),c.LocalizationButton.ChangeAll.instance.getElement().setStyle("color","#333");return a},l={iframeOnload:function(){c.div_overlay.setEnable();var a=c.dialog._.currentTabId;n(c.targetFromFrame[c.iframeNumber+"_"+a],c.cmd[a])},suggestlist:function(a){delete a.id,c.div_overlay_no_check.setDisable(),s(),j(c.langList),"false"==c.show_grammar&&q();var b=k(a.word),d="";b instanceof Array&&(b=a.word[0]),d=b=b.split(","),g.clear(),c.textNode.SpellTab.setValue(d[0]);for(a=0;a<d.length;a++)g.add(d[a],d[a]);r(),c.div_overlay.setDisable()},grammerSuggest:function(a){delete a.id,delete a.mocklangs,s();var b=a.grammSuggest[0];c.grammerSuggest.getElement().setHtml(""),c.textNode.GrammTab.reset(),c.textNode.GrammTab.setValue(b),c.textNodeInfo.GrammTab.getElement().setHtml(""),c.textNodeInfo.GrammTab.getElement().setText(a.info);for(var a=a.grammSuggest,b=a.length,d=!0,e=0;e<b;e++)c.grammerSuggest.getElement().append(i(a[e],a[e],d)),d=!1;r(),c.div_overlay.setDisable()},thesaurusSuggest:function(a){delete a.id,delete a.mocklangs,s(),c.selectNodeResponce=a,c.textNode.Thesaurus.reset(),c.selectNode.categories.clear();for(var b in a)c.selectNode.categories.add(b,b);a=c.selectNode.categories.getInputElement().getChildren().$[0].value,c.selectNode.categories.getInputElement().getChildren().$[0].selected=!0,c.buildOptionSynonyms(a),r(),c.div_overlay.setDisable()},finish:function(a){delete a.id,c.dialog.getContentElement(c.dialog._.currentTabId,"bottomGroup").getElement().hide(),c.dialog.getContentElement(c.dialog._.currentTabId,"BlockFinishChecking").getElement().show(),c.div_overlay.setDisable()},settext:function(a){delete a.id,c.dialog.getParentEditor().focus(),c.dialog.getParentEditor().setData(a.text,c.dataTemp=""),c.dialog.hide()},ReplaceText:function(a){delete a.id,c.div_overlay.setEnable(),c.dataTemp=a.text,c.selectingLang=a.currentLang,window.setTimeout(function(){c.div_overlay.setDisable()},500),d(c.LocalizationButton),e(c.LocalizationLabel)},options_checkbox_send:function(a){delete a.id,a={osp:b.cookie.get("osp"),udn:b.cookie.get("udn"),cust_dic_ids:c.cust_dic_ids},b.postMessage.send({message:a,target:c.targetFromFrame[c.iframeNumber+"_"+c.dialog._.currentTabId],id:"options_outer__page"})},getOptions:function(a){var d=a.DefOptions.udn;c.LocalizationComing=a.DefOptions.localizationButtonsAndText,c.show_grammar=a.show_grammar,c.langList=a.lang;if(c.bnr=a.bannerId){c.setHeightBannerFrame();var e=a.banner;c.dialog.getContentElement(c.dialog._.currentTabId,"banner").getElement().setHtml(e)}else c.setHeightFrame();"false"==c.show_grammar&&q(),"undefined"==d&&(c.userDictionaryName?(d=c.userDictionaryName,e={osp:b.cookie.get("osp"),udn:c.userDictionaryName,cust_dic_ids:c.cust_dic_ids,id:"options_dic_send",udnCmd:"create"},b.postMessage.send({message:e,target:c.targetFromFrame[void 0]})):d=""),b.cookie.set("osp",a.DefOptions.osp),b.cookie.set("udn",d),b.cookie.set("cust_dic_ids",a.DefOptions.cust_dic_ids),b.postMessage.send({id:"giveOptions"})},options_dic_send:function(){var a={osp:b.cookie.get("osp"),udn:b.cookie.get("udn"),cust_dic_ids:c.cust_dic_ids,id:"options_dic_send",udnCmd:b.cookie.get("udnCmd")};b.postMessage.send({message:a,target:c.targetFromFrame[c.iframeNumber+"_"+c.dialog._.currentTabId]})},data:function(a){delete a.id},giveOptions:function(){},setOptionsConfirmF:function(){},setOptionsConfirmT:function(){f.setValue("")},clickBusy:function(){c.div_overlay.setEnable()},suggestAllCame:function(){c.div_overlay.setDisable(),c.div_overlay_no_check.setDisable()},TextCorrect:function(){j(c.langList)}},m=function(a){a=a||window.event,a=window.JSON.parse(a.data),l[a.id](a)},n=function(a,d,e,f){d=d||CKEDITOR.config.wsc_cmd||"spell",e=e||c.dataTemp,b.postMessage.send({message:{customerId:c.wsc_customerId,text:e,txt_ctrl:c.TextAreaNumber,cmd:d,cust_dic_ids:c.cust_dic_ids,udn:c.userDictionaryName,slang:c.selectingLang,reset_suggest:f||!1},target:a,id:"data_outer__page"}),c.div_overlay.setEnable()},o={superset:function(){c.dialog.showPage("Thesaurus"),c.dialog.showPage("GrammTab"),c.dialog.showPage("SpellTab")},usual:function(){c.dialog.hidePage("Thesaurus"),q(),c.dialog.showPage("SpellTab")}},p=function(a){var b=new function(a){var b={};return{getCmdByTab:function(c){for(var d in a)b[a[d]]=d;return b[c]}}}(c.cmd);a.selectPage(b.getCmdByTab(CKEDITOR.config.wsc_cmd)),c.sendData(a)},q=function(){c.dialog.hidePage("GrammTab")},r=function(){c.dialog.getContentElement(c.dialog._.currentTabId,"bottomGroup").getElement().show()},s=function(){c.dialog.getContentElement(c.dialog._.currentTabId,"BlockFinishChecking").getElement().hide()};c.CKNumber=CKEDITOR.tools.getNextNumber(),CKEDITOR.dialog.add("checkspell",function(a){var d=function(){c.div_overlay.setEnable();var d=c.dialog._.currentTabId,e=c.iframeNumber+"_"+d,f=c.textNode[d].getValue();b.postMessage.send({message:{cmd:this.getElement().getAttribute("title-cmd"),tabId:d,new_word:f},target:c.targetFromFrame[e],id:"cmd_outer__page"}),"FinishChecking"==this.getElement().getAttribute("title-cmd")&&a.config.wsc_onFinish.call(CKEDITOR.document.getWindow().getFrame())},e="file:"==document.location.protocol?"http:":document.location.protocol,f=CKEDITOR.config.wsc_customLoaderScript||e+"//loader.webspellchecker.net/sproxy_fck/sproxy.php?plugin=fck2&customerid="+CKEDITOR.config.wsc_customerId+"&cmd=script&doc=wsc&schema=22";return{title:a.config.wsc_dialogTitle||a.lang.wsc.title,minWidth:560,minHeight:444,buttons:[CKEDITOR.dialog.cancelButton],onShow:function(){c.dialog=this,c.TextAreaNumber="cke_textarea_"+CKEDITOR.currentInstance.name,b.postMessage.init(m),c.dataTemp=CKEDITOR.currentInstance.getData(),c.OverlayPlace=c.dialog.parts.tabs.getParent().$,CKEDITOR.scriptLoader.load(f,function(b){CKEDITOR.config&&CKEDITOR.config.wsc&&CKEDITOR.config.wsc.DefaultParams?(c.serverLocationHash=CKEDITOR.config.wsc.DefaultParams.serviceHost,c.logotype=CKEDITOR.config.wsc.DefaultParams.logoPath,c.loadIcon=CKEDITOR.config.wsc.DefaultParams.iconPath,c.loadIconEmptyEditor=CKEDITOR.config.wsc.DefaultParams.iconPathEmptyEditor,c.LangComparer=new CKEDITOR.config.wsc.DefaultParams._SP_FCK_LangCompare):(c.serverLocationHash=DefaultParams.serviceHost,c.logotype=DefaultParams.logoPath,c.loadIcon=DefaultParams.iconPath,c.loadIconEmptyEditor=DefaultParams.iconPathEmptyEditor,c.LangComparer=new _SP_FCK_LangCompare),c.pluginPath=CKEDITOR.getUrl(a.plugins.wsc.path),c.iframeNumber=c.TextAreaNumber,c.serverLocation="#server="+c.serverLocationHash,c.templatePath=c.pluginPath+"dialogs/tmp.html",c.LangComparer.setDefaulLangCode(c.defaultLanguage),c.currentLang=a.config.wsc_lang||c.LangComparer.getSPLangCode(a.langCode),c.div_overlay=new h({opacity:"1",background:"#fff url("+c.loadIcon+") no-repeat 50% 50%",target:c.OverlayPlace});var d=CKEDITOR.document.getById("cke_dialog_tabs_"+(c.CKNumber+1));d.setStyle("width","97%"),d.getElementsByTag("DIV").count()||d.append(c.buildSelectLang()),c.div_overlay_no_check=new h({opacity:"1",id:"no_check_over",background:"#fff url("+c.loadIconEmptyEditor+") no-repeat 50% 50%",target:c.OverlayPlace}),b&&(p(c.dialog),c.dialog.setupContent(c.dialog))})},onHide:function(){c.dataTemp=""},contents:[{id:"SpellTab",label:"SpellChecker",accessKey:"S",elements:[{type:"html",id:"banner",label:"banner",style:"",html:"<div></div>"},{type:"html",id:"Content",label:"spellContent",html:"",setup:function(a){var a=c.iframeNumber+"_"+a._.currentTabId,b=document.getElementById(a);c.targetFromFrame[a]=b.contentWindow}},{type:"hbox",id:"bottomGroup",style:"width:560px; margin: 0 auto;",widths:["50%","50%"],children:[{type:"hbox",id:"leftCol",align:"left",width:"50%",children:[{type:"vbox",id:"rightCol1",widths:["50%","50%"],children:[{type:"text",id:"text",label:c.LocalizationLabel.ChangeTo.text+":",labelLayout:"horizontal",labelStyle:"font: 12px/25px arial, sans-serif;",width:"140px","default":"",onShow:function(){c.textNode.SpellTab=this,c.LocalizationLabel.ChangeTo.instance=this},onHide:function(){this.reset()}},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"text",id:"labelSuggestions",label:c.LocalizationLabel.Suggestions.text+":",onShow:function(){c.LocalizationLabel.Suggestions.instance=this,this.getInputElement().hide()}},{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=c.logotype,this.getElement().getParent().setStyles({"text-align":"left"})}}]},{type:"select",id:"list_of_suggestions",labelStyle:"font: 12px/25px arial, sans-serif;",size:"6",inputStyle:"width: 140px; height: auto;",items:[["loading..."]],onShow:function(){g=this},onHide:function(){this.clear()},onChange:function(){c.textNode.SpellTab.setValue(this.getValue())}}]}]}]},{type:"hbox",id:"rightCol",align:"right",width:"50%",children:[{type:"vbox",id:"rightCol_col__left",widths:["50%","50%","50%","50%"],children:[{type:"button",id:"ChangeTo",label:c.LocalizationButton.ChangeTo.text,title:"Change to",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),c.LocalizationButton.ChangeTo.instance=this},onClick:d},{type:"button",id:"ChangeAll",label:c.LocalizationButton.ChangeAll.text,title:"Change All",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),c.LocalizationButton.ChangeAll.instance=this},onClick:d},{type:"button",id:"AddWord",label:c.LocalizationButton.AddWord.text,title:"Add word",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),c.LocalizationButton.AddWord.instance=this},onClick:d},{type:"button",id:"FinishChecking",label:c.LocalizationButton.FinishChecking.text,title:"Finish Checking",style:"width: 100%;margin-top: 9px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),c.LocalizationButton.FinishChecking.instance=this},onClick:d}]},{type:"vbox",id:"rightCol_col__right",widths:["50%","50%","50%"],children:[{type:"button",id:"IgnoreWord",label:c.LocalizationButton.IgnoreWord.text,title:"Ignore word",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),c.LocalizationButton.IgnoreWord.instance=this},onClick:d},{type:"button",id:"IgnoreAllWords",label:c.LocalizationButton.IgnoreAllWords.text,title:"Ignore all words",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),c.LocalizationButton.IgnoreAllWords.instance=this},onClick:d},{type:"button",id:"option",label:c.LocalizationButton.Options.text,title:"Option",style:"width: 100%;",onLoad:function(){c.LocalizationButton.Options.instance=this,"file:"==document.location.protocol&&this.disable()},onClick:function(){"file:"==document.location.protocol?alert("WSC: Options functionality is disabled when runing from file system"):a.openDialog("options")}}]}]}]},{type:"hbox",id:"BlockFinishChecking",style:"width:560px; margin: 0 auto;",widths:["70%","30%"],onShow:function(){this.getElement().hide()},onHide:r,children:[{type:"hbox",id:"leftCol",align:"left",width:"70%",children:[{type:"vbox",id:"rightCol1",setup:function(){this.getChild()[0].getElement().$.src=c.logotype,this.getChild()[0].getElement().getParent().setStyles({"text-align":"center"})},children:[{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">'}]}]},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"button",id:"Option_button",label:c.LocalizationButton.Options.text,title:"Option",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id),"file:"==document.location.protocol&&this.disable()},onClick:function(){"file:"==document.location.protocol?alert("WSC: Options functionality is disabled when runing from file system"):a.openDialog("options")}},{type:"button",id:"FinishChecking",label:c.LocalizationButton.FinishChecking.text,title:"Finish Checking",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d}]}]}]}]},{id:"GrammTab",label:"Grammar",accessKey:"G",elements:[{type:"html",id:"banner",label:"banner",style:"",html:"<div></div>"},{type:"html",id:"Content",label:"GrammarContent",html:"",setup:function(){var a=c.iframeNumber+"_"+c.dialog._.currentTabId,b=document.getElementById(a);c.targetFromFrame[a]=b.contentWindow}},{type:"vbox",id:"bottomGroup",style:"width:560px; margin: 0 auto;",children:[{type:"hbox",id:"leftCol",widths:["66%","34%"],children:[{type:"vbox",children:[{type:"text",id:"text",label:"Change to:",labelLayout:"horizontal",labelStyle:"font: 12px/25px arial, sans-serif;",inputStyle:"float: right; width: 200px;","default":"",onShow:function(){c.textNode.GrammTab=this},onHide:function(){this.reset()}},{type:"html",id:"html_text",html:"<div style='min-height: 17px; line-height: 17px; padding: 5px; text-align: left;background: #F1F1F1;color: #595959; white-space: normal!important;'></div>",onShow:function(){c.textNodeInfo.GrammTab=this}},{type:"html",id:"radio",html:"",onShow:function(){c.grammerSuggest=this}}]},{type:"vbox",children:[{type:"button",id:"ChangeTo",label:"Change to",title:"Change to",style:"width: 133px; float: right;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d},{type:"button",id:"IgnoreWord",label:"Ignore word",title:"Ignore word",style:"width: 133px; float: right;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d},{type:"button",id:"IgnoreAllWords",label:"Ignore Problem",title:"Ignore Problem",style:"width: 133px; float: right;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d},{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 133px; float: right; margin-top: 9px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d}]}]}]},{type:"hbox",id:"BlockFinishChecking",style:"width:560px; margin: 0 auto;",widths:["70%","30%"],onShow:function(){this.getElement().hide()},onHide:r,children:[{type:"hbox",id:"leftCol",align:"left",width:"70%",children:[{type:"vbox",id:"rightCol1",children:[{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=c.logotype,this.getElement().getParent().setStyles({"text-align":"center"})}}]}]},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d}]}]}]}]},{id:"Thesaurus",label:"Thesaurus",accessKey:"T",elements:[{type:"html",id:"banner",label:"banner",style:"",html:"<div></div>"},{type:"html",id:"Content",label:"spellContent",html:"",setup:function(){var a=c.iframeNumber+"_"+c.dialog._.currentTabId,b=document.getElementById(a);c.targetFromFrame[a]=b.contentWindow}},{type:"vbox",id:"bottomGroup",style:"width:560px; margin: 0 auto;",children:[{type:"hbox",widths:["75%","25%"],children:[{type:"vbox",children:[{type:"hbox",widths:["65%","35%"],children:[{type:"text",id:"ChangeTo",label:"Change to:",labelLayout:"horizontal",inputStyle:"width: 160px;",labelStyle:"font: 12px/25px arial, sans-serif;","default":"",onShow:function(){c.textNode.Thesaurus=this},onHide:function(){this.reset()}},{type:"button",id:"ChangeTo",label:"Change to",title:"Change to",style:"width: 121px; margin-top: 1px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d}]},{type:"hbox",children:[{type:"select",id:"categories",label:"Categories:",labelStyle:"font: 12px/25px arial, sans-serif;",size:"5",inputStyle:"width: 180px; height: auto;",items:[],onShow:function(){c.selectNode.categories=this},onHide:function(){this.clear()},onChange:function(){c.buildOptionSynonyms(this.getValue())}},{type:"select",id:"synonyms",label:"Synonyms:",labelStyle:"font: 12px/25px arial, sans-serif;",size:"5",inputStyle:"width: 180px; height: auto;",items:[],onShow:function(){c.selectNode.synonyms=this,c.textNode.Thesaurus.setValue(this.getValue())},onHide:function(){this.clear()},onChange:function(){c.textNode.Thesaurus.setValue(this.getValue())}}]}]},{type:"vbox",width:"120px",style:"margin-top:46px;",children:[{type:"html",id:"logotype",label:"WebSpellChecker.net",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=c.logotype,this.getElement().getParent().setStyles({"text-align":"center"})}},{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 121px; float: right; margin-top: 9px;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d}]}]}]},{type:"hbox",id:"BlockFinishChecking",style:"width:560px; margin: 0 auto;",widths:["70%","30%"],onShow:function(){this.getElement().hide()},children:[{type:"hbox",id:"leftCol",align:"left",width:"70%",children:[{type:"vbox",id:"rightCol1",children:[{type:"html",id:"logo",html:'<img width="99" height="68" border="0" src="" title="WebSpellChecker.net" alt="WebSpellChecker.net" style="display: inline-block;">',setup:function(){this.getElement().$.src=c.logotype,this.getElement().getParent().setStyles({"text-align":"center"})}}]}]},{type:"hbox",id:"rightCol",align:"right",width:"30%",children:[{type:"vbox",id:"rightCol_col__left",children:[{type:"button",id:"FinishChecking",label:"Finish Checking",title:"Finish Checking",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onClick:d}]}]}]}]}]}}),CKEDITOR.dialog.add("options",function(){var a=null,d={},e={},g=null,h=null;b.cookie.get("udn"),b.cookie.get("osp");var i=function(){h=this.getElement().getAttribute("title-cmd");var a=[];a[0]=e.IgnoreAllCapsWords,a[1]=e.IgnoreWordsNumbers,a[2]=e.IgnoreMixedCaseWords,a[3]=e.IgnoreDomainNames,a=a.toString().replace(/,/g,""),b.cookie.set("osp",a),b.cookie.set("udnCmd",h?h:"ignore"),"delete"!=h&&(a="",""!==f.getValue()&&(a=f.getValue()),b.cookie.set("udn",a)),b.postMessage.send({id:"options_dic_send"})},j=function(){g.getElement().setHtml(c.LocalizationComing.error),g.getElement().show()};return{title:c.LocalizationComing.Options,minWidth:430,minHeight:130,resizable:CKEDITOR.DIALOG_RESIZE_NONE,contents:[{id:"OptionsTab",label:"Options",accessKey:"O",elements:[{type:"hbox",id:"options_error",children:[{type:"html",style:"display: block;text-align: center;white-space: normal!important; font-size: 12px;color:red",html:"<div></div>",onShow:function(){g=this}}]},{type:"vbox",id:"Options_content",children:[{type:"hbox",id:"Options_manager",widths:["52%","48%"],children:[{type:"fieldset",label:"Spell Checking Options",style:"border: none;margin-top: 13px;padding: 10px 0 10px 10px",onShow:function(){this.getInputElement().$.children[0].innerHTML=c.LocalizationComing.SpellCheckingOptions},children:[{type:"vbox",id:"Options_checkbox",children:[{type:"checkbox",id:"IgnoreAllCapsWords",label:"Ignore All-Caps Words",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){e[this.id]=this.getValue()?1:0}},{type:"checkbox",id:"IgnoreWordsNumbers",label:"Ignore Words with Numbers",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){e[this.id]=this.getValue()?1:0}},{type:"checkbox",id:"IgnoreMixedCaseWords",label:"Ignore Mixed-Case Words",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){e[this.id]=this.getValue()?1:0}},{type:"checkbox",id:"IgnoreDomainNames",label:"Ignore Domain Names",labelStyle:"margin-left: 5px; font: 12px/16px arial, sans-serif;display: inline-block;white-space: normal;",style:"float:left; min-height: 16px;","default":"",onClick:function(){e[this.id]=this.getValue()?1:0}}]}]},{type:"vbox",id:"Options_DictionaryName",children:[{type:"text",id:"DictionaryName",style:"margin-bottom: 10px",label:"Dictionary Name:",labelLayout:"vertical",labelStyle:"font: 12px/25px arial, sans-serif;","default":"",onLoad:function(){f=this,this.setValue(c.userDictionaryName?c.userDictionaryName:(b.cookie.get("udn"),this.getValue()))},onShow:function(){f=this,this.setValue(b.cookie.get("udn")?b.cookie.get("udn"):this.getValue()),this.setLabel(c.LocalizationComing.DictionaryName)},onHide:function(){this.reset()}},{type:"hbox",id:"Options_buttons",children:[{type:"vbox",id:"Options_leftCol_col",widths:["50%","50%"],children:[{type:"button",id:"create",label:"Create",title:"Create",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(c.LocalizationComing.Create)},onClick:i},{type:"button",id:"restore",label:"Restore",title:"Restore",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(c.LocalizationComing.Restore)},onClick:i}]},{type:"vbox",id:"Options_rightCol_col",widths:["50%","50%"],children:[{type:"button",id:"rename",label:"Rename",title:"Rename",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(c.LocalizationComing.Rename)},onClick:i},{type:"button",id:"delete",label:"Remove",title:"Remove",style:"width: 100%;",onLoad:function(){this.getElement().setAttribute("title-cmd",this.id)},onShow:function(){this.getElement().setText(c.LocalizationComing.Remove)},onClick:i}]}]}]}]},{type:"hbox",id:"Options_text",children:[{type:"html",style:"text-align: justify;margin-top: 15px;white-space: normal!important; font-size: 12px;color:#777;",html:"<div>"+c.LocalizationComing.OptionsTextIntro+"</div>",onShow:function(){this.getElement().setText(c.LocalizationComing.OptionsTextIntro)}}]}]}]}],buttons:[CKEDITOR.dialog.okButton,CKEDITOR.dialog.cancelButton],onOk:function(){var a=[];a[0]=e.IgnoreAllCapsWords,a[1]=e.IgnoreWordsNumbers,a[2]=e.IgnoreMixedCaseWords,a[3]=e.IgnoreDomainNames,a=a.toString().replace(/,/g,""),b.cookie.set("osp",a),b.cookie.set("udn",f.getValue()),b.postMessage.send({id:"options_checkbox_send"}),g.getElement().hide(),g.getElement().setHtml(" ")},onLoad:function(){a=this,b.postMessage.init(j),d.IgnoreAllCapsWords=a.getContentElement("OptionsTab","IgnoreAllCapsWords"),d.IgnoreWordsNumbers=a.getContentElement("OptionsTab","IgnoreWordsNumbers"),d.IgnoreMixedCaseWords=a.getContentElement("OptionsTab","IgnoreMixedCaseWords"),d.IgnoreDomainNames=a.getContentElement("OptionsTab","IgnoreDomainNames")},onShow:function(){var a=b.cookie.get("osp").split("");e.IgnoreAllCapsWords=a[0],e.IgnoreWordsNumbers=a[1],e.IgnoreMixedCaseWords=a[2],e.IgnoreDomainNames=a[3],parseInt(e.IgnoreAllCapsWords,10)?d.IgnoreAllCapsWords.setValue("checked",!1):d.IgnoreAllCapsWords.setValue("",!1),parseInt(e.IgnoreWordsNumbers,10)?d.IgnoreWordsNumbers.setValue("checked",!1):d.IgnoreWordsNumbers.setValue("",!1),parseInt(e.IgnoreMixedCaseWords,10)?d.IgnoreMixedCaseWords.setValue("checked",!1):d.IgnoreMixedCaseWords.setValue("",!1),parseInt(e.IgnoreDomainNames,10)?d.IgnoreDomainNames.setValue("checked",!1):d.IgnoreDomainNames.setValue("",!1),e.IgnoreAllCapsWords=d.IgnoreAllCapsWords.getValue()?1:0,e.IgnoreWordsNumbers=d.IgnoreWordsNumbers.getValue()?1:0,e.IgnoreMixedCaseWords=d.IgnoreMixedCaseWords.getValue()?1:0,e.IgnoreDomainNames=d.IgnoreDomainNames.getValue()?1:0,d.IgnoreAllCapsWords.getElement().$.lastChild.innerHTML=c.LocalizationComing.IgnoreAllCapsWords,d.IgnoreWordsNumbers.getElement().$.lastChild.innerHTML=c.LocalizationComing.IgnoreWordsWithNumbers,d.IgnoreMixedCaseWords.getElement().$.lastChild.innerHTML=c.LocalizationComing.IgnoreMixedCaseWords,d.IgnoreDomainNames.getElement().$.lastChild.innerHTML=c.LocalizationComing.IgnoreDomainNames}}}),CKEDITOR.dialog.on("resize",function(a){var a=a.data,b=a.dialog,d=CKEDITOR.document.getById(c.iframeNumber+"_"+b._.currentTabId);"checkspell"==b._.name&&(c.bnr?d&&d.setSize("height",a.height-310):d&&d.setSize("height",a.height-220))}),CKEDITOR.on("dialogDefinition",function(a){var b=a.data.definition;c.onLoadOverlay=new h({opacity:"1",background:"#fff",target:b.dialog.parts.tabs.getParent().$}),c.onLoadOverlay.setEnable(),b.dialog.on("show",function(){}),b.dialog.on("cancel",function(){return b.dialog.getParentEditor().config.wsc_onClose.call(this.document.getWindow().getFrame()),c.div_overlay.setDisable(),!1},this,null,-1)})})();