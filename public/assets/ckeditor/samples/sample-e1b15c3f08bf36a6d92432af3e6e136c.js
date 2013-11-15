/**
 * Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */
// Tool scripts for the sample pages.
// This file can be ignored and is not required to make use of CKEditor.
(function(){CKEDITOR.on("instanceReady",function(a){var b=a.editor,c=CKEDITOR.document.$.getElementsByName("ckeditor-sample-required-plugins"),d=c.length?CKEDITOR.dom.element.get(c[0]).getAttribute("content").split(","):[],e=[];if(d.length){for(var f=0;f<d.length;f++)b.plugins[d[f]]||e.push("<code>"+d[f]+"</code>");if(e.length){var g=CKEDITOR.dom.element.createFromHtml('<div class="warning"><span>To fully experience this demo, the '+e.join(", ")+" plugin"+(e.length>1?"s are":" is")+" required.</span>"+"</div>");g.insertBefore(b.container)}}})})();