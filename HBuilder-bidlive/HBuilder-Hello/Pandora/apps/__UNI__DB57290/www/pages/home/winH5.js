!function(t){var e={};function n(i){if(e[i])return e[i].exports;var a=e[i]={i:i,l:!1,exports:{}};return t[i].call(a.exports,a,a.exports,n),a.l=!0,a.exports}n.m=t,n.c=e,n.d=function(t,e,i){n.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:i})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,e){if(1&e&&(t=n(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var i=Object.create(null);if(n.r(i),Object.defineProperty(i,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var a in t)n.d(i,a,function(e){return t[e]}.bind(null,a));return i},n.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(e,"a",e),e},n.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},n.p="",n(n.s=467)}({0:function(t,e,n){"use strict";function i(t,e,n,i,a,r,o,s,u,c){var l,p="function"==typeof t?t.options:t;if(u){p.components||(p.components={});var f=Object.prototype.hasOwnProperty;for(var h in u)f.call(u,h)&&!f.call(p.components,h)&&(p.components[h]=u[h])}if(c&&((c.beforeCreate||(c.beforeCreate=[])).unshift((function(){this[c.__module]=this})),(p.mixins||(p.mixins=[])).push(c)),e&&(p.render=e,p.staticRenderFns=n,p._compiled=!0),i&&(p.functional=!0),r&&(p._scopeId="data-v-"+r),o?(l=function(t){(t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext)||"undefined"==typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),a&&a.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(o)},p._ssrRegister=l):a&&(l=s?function(){a.call(this,this.$root.$options.shadowRoot)}:a),l)if(p.functional){p._injectStyles=l;var d=p.render;p.render=function(t,e){return l.call(e),d(t,e)}}else{var v=p.beforeCreate;p.beforeCreate=v?[].concat(v,l):[l]}return{exports:t,options:p}}n.d(e,"a",(function(){return i}))},1:function(t,e,n){"use strict";function i(t){var e=Object.prototype.toString.call(t);return e.substring(8,e.length-1)}function a(){return"string"==typeof __channelId__&&__channelId__}function r(t,e){switch(i(e)){case"Function":return"function() { [native code] }";default:return e}}Object.defineProperty(e,"__esModule",{value:!0}),e.log=function(t){for(var e=arguments.length,n=new Array(e>1?e-1:0),i=1;i<e;i++)n[i-1]=arguments[i];console[t].apply(console,n)},e.default=function(){for(var t=arguments.length,e=new Array(t),n=0;n<t;n++)e[n]=arguments[n];var o=e.shift();if(a())return e.push(e.pop().replace("at ","uni-app:///")),console[o].apply(console,e);var s=e.map((function(t){var e=Object.prototype.toString.call(t).toLowerCase();if("[object object]"===e||"[object array]"===e)try{t="---BEGIN:JSON---"+JSON.stringify(t,r)+"---END:JSON---"}catch(n){t=e}else if(null===t)t="---NULL---";else if(void 0===t)t="---UNDEFINED---";else{var n=i(t).toUpperCase();t="NUMBER"===n||"BOOLEAN"===n?"---BEGIN:"+n+"---"+t+"---END:"+n+"---":String(t)}return t})),u="";if(s.length>1){var c=s.pop();u=s.join("---COMMA---"),0===c.indexOf(" at ")?u+=c:u+="---COMMA---"+c}else u=s[0];console[o](u)}},2:function(t,e){t.exports={"placeholder-class":{fontSize:"14rpx"},"safeArea-plus":{paddingBottom:0},"LiveClassRoom-rich-text-p":{fontSize:"16"},"@VERSION":2}},238:function(t,e,n){"use strict";var i=n(361),a=n(332),r=n(0);var o=Object(r.a)(a.default,i.b,i.c,!1,null,null,"17797495",!1,i.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(n(435).default,this.options.style):Object.assign(this.options.style,n(435).default)}).call(o),e.default=o.exports},3:function(t,e,n){"use strict";n.r(e),e.default={appid:"__UNI__DB57290"}},332:function(t,e,n){"use strict";var i=n(333),a=n.n(i);e.default=a.a},333:function(t,e,n){"use strict";(function(t){Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i,a=(i=n(468))&&i.__esModule?i:{default:i};var r=getApp().globalData,o={components:{bottomShareBox:a.default},data:function(){return{url:"",shareData:null,shareBoxShow:!1,systemInfo:{},videobox:{isOpen:!1,videoWidth:0,videoHeight:0,url:""}}},onLoad:function(t){this.systemInfo=uni.getSystemInfoSync(),this.videobox.videoWidth=this.systemInfo.screenWidth,this.videobox.videoHeight=9*this.systemInfo.screenWidth/16,this.url=t.url,this.url.indexOf("?")>-1?this.url+="&":this.url+="?",this.url+="rnd="+(new Date).getTime(),uni.setNavigationBarTitle({title:"\u8054\u62cd\u5728\u7ebf"})},onNavigationBarButtonTap:function(t){this.shareBoxShow=!0,this.shareData&&(this.shareBoxShow=!0)},methods:{setShareData:function(t){this.shareData=t},reciveH5Message:function(e){if(this.eventData=e.detail.data[0],this.eventData.event)switch(this.eventData.event){case"navigateTo":uni.navigateTo({url:this.eventData.pageUrl});break;case"share":this.setShareData(this.eventData.shareData);break;case"title":uni.setNavigationBarTitle({title:this.eventData.title});break;case"login":var n=r.$isLogined()?"true":"false",i=uni.getStorageSync("accessToken");this.$refs.webview.evalJS("h5LoginSuccess("+n+",'"+i+"')");break;case"video":t("log","video11111111"," at pages/home/winH5.nvue:93"),this.videobox.url=this.eventData.url,this.videobox.isOpen=!0}}}};e.default=o}).call(this,n(1).default)},334:function(t,e,n){"use strict";n.r(e);var i=n(335),a=n.n(i);for(var r in i)"default"!==r&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e.default=a.a},335:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i;(i=n(44))&&i.__esModule;var a=getApp().globalData,r={components:{},props:{shareData:{type:Object,default:function(){}}},data:function(){return{}},created:function(){},destroyed:function(){},methods:{openUrl:function(t){this.close(1),a.$h5OpenUrl(t)},showShare:function(){},close:function(t){this.$emit("close",t)},codeClick:function(){},WXclick:function(t,e){uni.share({provider:t,scene:e,type:0,href:this.shareData.shareUrl,title:this.shareData.title,summary:this.shareData.summary,imageUrl:this.shareData.imageUrl}),this.close()},copeClick:function(){var t=this;uni.setClipboardData({data:this.shareData.shareUrl,success:function(e){uni.hideToast(),uni.showModal({title:"\u6e29\u99a8\u63d0\u793a\uff01",content:"\u590d\u5236\u94fe\u63a5\u6210\u529f\uff0c\u6253\u5f00\u5fae\u4fe1\u3001QQ\u7b49\uff0c\u7c98\u8d34\u4fe1\u606f\uff0c\u5373\u53ef\u5206\u4eab\u3002",showCancel:!1,complete:function(){t.close()}})}})}}};e.default=r},336:function(t,e){t.exports={box:{position:"fixed",left:0,right:0,bottom:0,backgroundColor:"#f3f3f3",borderTopWidth:"1",borderTopColor:"#EEEEEE"},title:{fontSize:"16",color:"#c5c5c5",height:"40",lineHeight:"40",textAlign:"center"},boxbg:{position:"fixed",top:0,left:0,right:0,bottom:0,backgroundColor:"rgba(1,1,1,0.2)"},img:{borderRadius:100},uniImage:{width:"45",height:"45"},name:{width:100,textAlign:"center",color:"#505050",fontSize:"14",marginTop:"5"},"box-row1":{borderBottomWidth:"1",borderBottomStyle:"dashed",borderBottomColor:"#dddddd",paddingTop:"20",paddingRight:0,paddingBottom:"20",paddingLeft:0,flexDirection:"row",justifyContent:"space-around",alignItems:"center"},li:{width:"125"},img1:{alignItems:"center"},uniImg1:{width:"45",height:"45",textAlign:"center"},name1:{color:"#505050",marginTop:"10",alignItems:"center"},icontxt:{fontSize:"14"},"box-row2":{flexDirection:"column",justifyContent:"center",alignItems:"center",paddingTop:"15",paddingRight:0,paddingBottom:"15",paddingLeft:0},uniImg:{width:"45",height:"45"},btnbar:{paddingTop:"10",paddingRight:"10",paddingBottom:"10",paddingLeft:"10"},"btn-close":{borderRadius:"4",paddingTop:"10",paddingRight:0,paddingBottom:"11",paddingLeft:0,fontSize:"16",height:"40",backgroundColor:"#ffffff",textAlign:"center",borderWidth:0,color:"#69b2d2"},"@VERSION":2}},337:function(t,e){t.exports={webview:{position:"fixed",top:"0",left:"0",right:"0",bottom:"0"},videobox:{position:"fixed",top:"0",left:"0",right:"0",bottom:"0",flexDirection:"row",alignItems:"center",backgroundColor:"rgba(0,0,0,0.8)"},"videobox-btn-close":{position:"absolute",top:"15",right:0,width:"50",height:"50",alignItems:"center"},"videobox-video":{transform:"translateY(-20)"},"videobox-btn-close-img":{width:"22",height:"22"},sharebox:{left:"20rpx",top:"20rpx"},"@VERSION":2}},361:function(t,e,n){"use strict";n.d(e,"b",(function(){return i})),n.d(e,"c",(function(){return a})),n.d(e,"a",(function(){}));var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("scroll-view",{staticStyle:{flexDirection:"column"},attrs:{scrollY:!0,showScrollbar:!0,enableBackToTop:!0,bubble:"true"}},[n("view",[n("u-web-view",{ref:"webview",staticClass:["webview"],attrs:{src:t.url},on:{onPostMessage:t.reciveH5Message}}),t.shareBoxShow?n("view",{staticClass:["sharebox"]},[n("bottomShareBox",{attrs:{shareData:t.shareData},on:{close:function(e){t.shareBoxShow=!1}}})],1):t._e(),t.videobox.isOpen?n("view",{staticClass:["videobox"]},[n("view",{staticClass:["videobox-btn-close"],on:{click:function(e){t.videobox.isOpen=!1}}},[n("u-image",{staticClass:["videobox-btn-close-img"],attrs:{src:"/static/images/closeVideo.png"}})],1),n("u-video",{staticClass:["videobox-video"],style:{width:this.videobox.videoWidth+"px",height:this.videobox.videoHeight+"px"},attrs:{autoplay:!0,src:t.videobox.url}})],1):t._e()],1)])},a=[]},372:function(t,e,n){"use strict";n.d(e,"b",(function(){return i})),n.d(e,"c",(function(){return a})),n.d(e,"a",(function(){}));var i=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("view",{staticClass:["boxbg"],on:{click:t.close}},[n("view",{staticClass:["box"]},[n("u-text",{staticClass:["title"],appendAsTree:!0,attrs:{append:"tree"}},[t._v("\u5206\u4eab\u5230")]),n("view",{staticClass:["box-row1"]},[n("view",{staticClass:["li"]},[n("view",{staticClass:["img1"],on:{click:function(e){t.WXclick("weixin","WXSceneSession")}}},[n("u-image",{staticClass:["uniImg1"],attrs:{src:"/static/images/WX.png"}})],1),t._m(0)]),n("view",{staticClass:["li"]},[n("view",{staticClass:["img1"],on:{click:function(e){t.WXclick("weixin","WXSenceTimeline")}}},[n("u-image",{staticClass:["uniImg1"],attrs:{src:"/static/images/PYQ.png"}})],1),t._m(1)]),n("view",{staticClass:["li"],on:{click:function(e){t.WXclick("weixin","WXSceneFavorite")}}},[n("view",{staticClass:["img1"]},[n("u-image",{staticClass:["uniImg1"],attrs:{src:"/static/images/SC.png"}})],1),t._m(2)])]),n("view",{staticClass:["box-row2"]},[n("view",{staticClass:["img"],on:{click:function(e){t.copeClick("fz")}}},[n("u-image",{staticClass:["uniImg"],attrs:{src:"/static/images/lj.png"}})],1),t._m(3)]),n("view",{staticClass:["btnbar"]},[n("u-text",{staticClass:["btn-close"],appendAsTree:!0,attrs:{append:"tree"},on:{click:t.close}},[t._v("\u5173\u95ed")])])])])},a=[function(){var t=this.$createElement,e=this._self._c||t;return e("view",{staticClass:["name1"]},[e("u-text",{staticClass:["icontxt"],appendAsTree:!0,attrs:{append:"tree"}},[this._v("\u5fae\u4fe1")])])},function(){var t=this.$createElement,e=this._self._c||t;return e("view",{staticClass:["name1"]},[e("u-text",{staticClass:["icontxt"],appendAsTree:!0,attrs:{append:"tree"}},[this._v("\u5fae\u4fe1\u670b\u53cb\u5708")])])},function(){var t=this.$createElement,e=this._self._c||t;return e("view",{staticClass:["name1"]},[e("u-text",{staticClass:["icontxt"],appendAsTree:!0,attrs:{append:"tree"}},[this._v("\u5fae\u4fe1\u6536\u85cf")])])},function(){var t=this.$createElement,e=this._self._c||t;return e("view",{staticClass:["name1"]},[e("u-text",{staticClass:["icontxt"],appendAsTree:!0,attrs:{append:"tree"}},[this._v("\u590d\u5236\u94fe\u63a5")])])}]},434:function(t,e,n){"use strict";n.r(e);var i=n(336),a=n.n(i);for(var r in i)"default"!==r&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e.default=a.a},435:function(t,e,n){"use strict";n.r(e);var i=n(337),a=n.n(i);for(var r in i)"default"!==r&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e.default=a.a},44:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i={ENV:"product",webUrl:"http://wxv3.51bidlive.com",auctionUrl:"http://en.auction.51bidlive.com",webOldApiUrl:"http://en.m.51bidlive.com",webJdApiUrl:"http://m.jdapi.51bidlive.com",webApiUrl:"http://webapi.51bidlive.com",webJdApiUrlTtp:"http://newttp_api.51bidlive.com",imageOssBaseUrl:"https://en-image-51bidlive-com.oss-cn-shenzhen.aliyuncs.com/u",imageJdBaseUrl:"http://jdupload.51bidlive.com/"};i.ENV;var a=i;e.default=a},45:function(t,e,n){function i(t,e){return(i=Object.setPrototypeOf||function(t,e){return t.__proto__=e,t})(t,e)}function a(t){var e=function(){if("undefined"==typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"==typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(t){return!1}}();return function(){var n,i=o(t);if(e){var a=o(this).constructor;n=Reflect.construct(i,arguments,a)}else n=i.apply(this,arguments);return r(this,n)}}function r(t,e){return!e||"object"!=typeof e&&"function"!=typeof e?function(t){if(void 0===t)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return t}(t):e}function o(t){return(o=Object.setPrototypeOf?Object.getPrototypeOf:function(t){return t.__proto__||Object.getPrototypeOf(t)})(t)}function s(t,e){if(!(t instanceof e))throw new TypeError("Cannot call a class as a function")}function u(t,e){for(var n=0;n<e.length;n++){var i=e[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(t,i.key,i)}}function c(t,e,n){return e&&u(t.prototype,e),n&&u(t,n),t}function l(t,e,n){return e in t?Object.defineProperty(t,e,{value:n,enumerable:!0,configurable:!0,writable:!0}):t[e]=n,t}var p,f=uni.getSystemInfoSync(),h="https://tongji.dcloud.io/uni/stat",d={};p=n(3).default||n(3);var v=n(46).default.pages;for(var _ in v){var g,y=v[_],m=y.navigationBarTitleText||y.defaultTitle||(null===(g=y.navigationBar)||void 0===g?void 0:g.titleText)||"";m&&(d[_]=m)}var b,S,T=p,w=function(){var t,e=(l(t={app:"n","app-plus":"n",h5:"h5","mp-weixin":"wx"},["y","a","p","mp-ali"].reverse().join(""),"ali"),l(t,"mp-baidu","bd"),l(t,"mp-toutiao","tt"),l(t,"mp-qq","qq"),l(t,"quickapp-native","qn"),l(t,"mp-kuaishou","ks"),l(t,"mp-lark","lark"),l(t,"quickapp-webview","qw"),t);if("ali"===e["app-plus"]&&my&&my.env){var n=my.env.clientName;if("ap"===n)return"ali";if("dingtalk"===n)return"dt"}return e["app-plus"]},D=function(t){var e=w(),n="";return t||("wx"===e&&(n=uni.getLaunchOptionsSync().scene),n)},A=function(t){var e=t||k();if("bd"===w()){var n=e.$mp&&e.$mp.page&&e.$mp.page.is,i=e.$scope&&e.$scope.is;return n||i||""}return e.route||e.$scope&&e.$scope.route||e.$mp&&e.$mp.page.route},x=function(t){var e=t.$page||t.$scope&&t.$scope.$page,n=uni.getStorageSync("_STAT_LAST_PAGE_ROUTE");return e?"/"===e.fullPath?e.route:e.fullPath||e.route:n||""},k=function(){var t=getCurrentPages(),e=t[t.length-1];return e?e.$vm:null},I=function(t){return"page"===t.mpType||"page"===t.$mpType||t.$mp&&"page"===t.$mp.mpType||"page"===t.$options.mpType?"page":"app"===t.mpType||"app"===t.$mpType||t.$mp&&"app"===t.$mp.mpType||"app"===t.$options.mpType?"app":null},O=function(t){return d&&d[t]||""},C=function(t){var e={usv:"0.0.1",conf:JSON.stringify({ak:"__UNI__DB57290"})};uni.request({url:h,method:"GET",data:e,success:function(e){var n=e.data;0===n.ret&&"function"==typeof t&&t({enable:n.enable})},fail:function(e){var n=1;try{n=uni.getStorageSync("Report_Status")}catch(e){n=1}""===n&&(n=1),"function"==typeof t&&t({enable:n})}})},R=uni.getStorageSync("$$STAT__DBDATA")||{},$=function(t,e){R||(R={}),R[t]=e,uni.setStorageSync("$$STAT__DBDATA",R)},U=function(t){if(!R[t]){var e=uni.getStorageSync("$$STAT__DBDATA");if(e||(e={}),!e[t])return;R[t]=e[t]}return R[t]},E=function(t){(R[t]||(R=uni.getStorageSync("$$STAT__DBDATA"))[t])&&(delete R[t],uni.setStorageSync("$$STAT__DBDATA",R))},B=function(){return parseInt((new Date).getTime()/1e3)},q=function(){var t=U("__last__visit__time"),e=0;return t&&(e=t),$("__last__visit__time",B()),e},j=0,P=0,N=function(){return j=B(),$("__page__residence__time",j),j},L=function(){var t=U("__total__visit__count"),e=1;return t&&(e=t,e++),$("__total__visit__count",e),e},V=0,M=0,H=function(){var t=(new Date).getTime();return V=t,M=0,t},W=function(){var t=(new Date).getTime();return M=t,t},J=function(t){var e=0;return 0!==V&&(e=M-V),e=(e=parseInt(e/1e3))<1?1:e,"app"===t?{residenceTime:e,overtime:e>300}:"page"===t?{residenceTime:e,overtime:e>1800}:{residenceTime:e}},G={uuid:f.deviceId||function(){var t="";if("n"===w()){try{t=plus.runtime.getDCloudId()}catch(e){t=""}return t}try{t=uni.getStorageSync("__DC_STAT_UUID")}catch(e){t="__DC_UUID_VALUE"}if(!t){t=Date.now()+""+Math.floor(1e7*Math.random());try{uni.setStorageSync("__DC_STAT_UUID",t)}catch(t){uni.setStorageSync("__DC_STAT_UUID","__DC_UUID_VALUE")}}return t}(),ut:w(),mpn:(S="","wx"!==w()&&"qq"!==w()||uni.canIUse("getAccountInfoSync")&&(S=uni.getAccountInfoSync().miniProgram.appId||""),w(),S),ak:T.appid,usv:"0.0.1",v:"n"===w()?plus.runtime.version:"",ch:(b="","n"===w()&&(b=plus.runtime.channel),b),cn:"",pn:"",ct:"",t:B(),tt:"",p:"android"===f.platform?"a":"i",brand:f.brand||"",md:f.model,sv:f.system.replace(/(Android|iOS)\s/,""),mpsdk:f.SDKVersion||"",mpv:f.version||"",lang:f.language,pr:f.pixelRatio,ww:f.windowWidth,wh:f.windowHeight,sw:f.screenWidth,sh:f.screenHeight},X=function(t){"use strict";!function(t,e){if("function"!=typeof e&&null!==e)throw new TypeError("Super expression must either be null or a function");t.prototype=Object.create(e&&e.prototype,{constructor:{value:t,writable:!0,configurable:!0}}),e&&i(t,e)}(n,t);var e=a(n);function n(){return s(this,n),e.call(this)}return c(n,null,[{key:"getInstance",value:function(){return uni.__stat_instance||(uni.__stat_instance=new n),uni.__stat_instance}}]),c(n,[{key:"launch",value:function(t,e){N(),this.__licationShow=!0,this.sendReportRequest(t,!0)}},{key:"load",value:function(t,e){this.self=e,this._query=t}},{key:"appHide",value:function(t){this.applicationHide(t,!0)}},{key:"appShow",value:function(t){this.applicationShow(t)}},{key:"show",value:function(t){this.self=t,"page"===I(t)&&this.pageShow(t),"app"===I(t)&&this.appShow()}},{key:"hide",value:function(t){this.self=t,"page"===I(t)&&this.pageHide(t),"app"===I(t)&&this.appHide()}},{key:"error",value:function(t){this._platform;var e="";e=t.message?t.stack:JSON.stringify(t);var n={ak:this.statData.ak,uuid:this.statData.uuid,lt:"31",ut:this.statData.ut,ch:this.statData.ch,mpsdk:this.statData.mpsdk,mpv:this.statData.mpv,v:this.statData.v,em:e,usv:this.statData.usv,t:parseInt((new Date).getTime()/1e3),p:this.statData.p};this.request(n)}}]),n}(function(){"use strict";function t(){s(this,t),this.self="",this.__licationShow=!1,this.__licationHide=!1,this.statData=G,this._navigationBarTitle={config:"",page:"",report:"",lt:""},this._query={},"function"==typeof uni.addInterceptor&&(this.addInterceptorInit(),this.interceptLogin(),this.interceptShare(!0),this.interceptRequestPayment())}return c(t,[{key:"addInterceptorInit",value:function(){var t=this;uni.addInterceptor("setNavigationBarTitle",{invoke:function(e){t._navigationBarTitle.page=e.title}})}},{key:"interceptLogin",value:function(){var t=this;uni.addInterceptor("login",{complete:function(){t._login()}})}},{key:"interceptShare",value:function(t){var e=this;t?uni.addInterceptor("share",{success:function(){e._share()},fail:function(){e._share()}}):e._share()}},{key:"interceptRequestPayment",value:function(){var t=this;uni.addInterceptor("requestPayment",{success:function(){t._payment("pay_success")},fail:function(){t._payment("pay_fail")}})}},{key:"_login",value:function(){this.sendEventRequest({key:"login"},0)}},{key:"_share",value:function(){this.sendEventRequest({key:"share"},0)}},{key:"_payment",value:function(t){this.sendEventRequest({key:t},0)}},{key:"applicationShow",value:function(){if(this.__licationHide){if(W(),J("app").overtime){var t={path:uni.getStorageSync("_STAT_LAST_PAGE_ROUTE"),scene:this.statData.sc};this.sendReportRequest(t)}this.__licationHide=!1}}},{key:"applicationHide",value:function(t,e){t||(t=k()),this.__licationHide=!0,W();var n=J(),i=x(t);uni.setStorageSync("_STAT_LAST_PAGE_ROUTE",i),this.sendHideRequest({urlref:i,urlref_ts:n.residenceTime},e),H()}},{key:"pageShow",value:function(t){this._navigationBarTitle={config:"",page:"",report:"",lt:""};var e=x(t),n=A(t);if(this._navigationBarTitle.config=O(n),this.__licationShow)return H(),uni.setStorageSync("_STAT_LAST_PAGE_ROUTE",e),void(this.__licationShow=!1);if(W(),J("page").overtime){var i={path:e,scene:this.statData.sc};this.sendReportRequest(i)}H()}},{key:"pageHide",value:function(t){if(!this.__licationHide){W();var e=J("page"),n=x(t),i=uni.getStorageSync("_STAT_LAST_PAGE_ROUTE");return i||(i=n),uni.setStorageSync("_STAT_LAST_PAGE_ROUTE",n),void this.sendPageRequest({url:n,urlref:i,urlref_ts:e.residenceTime})}}},{key:"sendReportRequest",value:function(t){this._navigationBarTitle.lt="1",this._navigationBarTitle.config=O(t.path);var e,n,i=t.query&&"{}"!==JSON.stringify(t.query)?"?"+JSON.stringify(t.query):"";Object.assign(this.statData,{lt:"1",url:t.path+i||"",t:B(),sc:D(t.scene),fvts:(e=U("__first__visit__time"),n=0,e?n=e:(n=B(),$("__first__visit__time",n),E("__last__visit__time")),n),lvts:q(),tvc:L()}),"n"===w()?this.getProperty():this.getNetworkInfo()}},{key:"sendPageRequest",value:function(t){var e=t.url,n=t.urlref,i=t.urlref_ts;this._navigationBarTitle.lt="11";var a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"11",ut:this.statData.ut,url:e,tt:this.statData.tt,urlref:n,urlref_ts:i,ch:this.statData.ch,usv:this.statData.usv,t:B(),p:this.statData.p};this.request(a)}},{key:"sendHideRequest",value:function(t,e){var n=t.urlref,i=t.urlref_ts,a={ak:this.statData.ak,uuid:this.statData.uuid,lt:"3",ut:this.statData.ut,urlref:n,urlref_ts:i,ch:this.statData.ch,usv:this.statData.usv,t:B(),p:this.statData.p};this.request(a,e)}},{key:"sendEventRequest",value:function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},e=t.key,n=void 0===e?"":e,i=t.value,a=void 0===i?"":i,r=A();this._navigationBarTitle.config=O(r),this._navigationBarTitle.lt="21";var o={ak:this.statData.ak,uuid:this.statData.uuid,lt:"21",ut:this.statData.ut,url:r,ch:this.statData.ch,e_n:n,e_v:"object"==typeof a?JSON.stringify(a):a.toString(),usv:this.statData.usv,t:B(),p:this.statData.p};this.request(o)}},{key:"getProperty",value:function(){var t=this;plus.runtime.getProperty(plus.runtime.appid,(function(e){t.statData.v=e.version||"",t.getNetworkInfo()}))}},{key:"getNetworkInfo",value:function(){var t=this;uni.getNetworkType({success:function(e){t.statData.net=e.networkType,t.getLocation()}})}},{key:"getLocation",value:function(){var t=this;T.getLocation?uni.getLocation({type:"wgs84",geocode:!0,success:function(e){e.address&&(t.statData.cn=e.address.country,t.statData.pn=e.address.province,t.statData.ct=e.address.city),t.statData.lat=e.latitude,t.statData.lng=e.longitude,t.request(t.statData)}}):(this.statData.lat=0,this.statData.lng=0,this.request(this.statData))}},{key:"request",value:function(t,e){var n=this,i=B(),a=this._navigationBarTitle;Object.assign(t,{ttn:a.page,ttpj:a.config,ttc:a.report});var r=U("__UNI__STAT__DATA")||{};if(r[t.lt]||(r[t.lt]=[]),r[t.lt].push(t),$("__UNI__STAT__DATA",r),!((P=B(),j=U("__page__residence__time"),P-j)<10)||e){N();var o={usv:"0.0.1",t:i,requests:function(t){var e=[],n=[],i=[],a=function(a){t[a].forEach((function(t){var r=function(t){var e="";for(var n in t)e+=n+"="+t[n]+"&";return e.substr(0,e.length-1)}(t);0===a?e.push(r):3===a?i.push(r):n.push(r)}))};for(var r in t)a(r);return e.push.apply(e,n.concat(i)),JSON.stringify(e)}(r)};E("__UNI__STAT__DATA"),"h5"!==t.ut?"n"!==w()||"a"!==this.statData.p?this.sendRequest(o):setTimeout((function(){n.sendRequest(o)}),200):this.imageRequest(o)}}},{key:"getIsReportData",value:function(){return new Promise((function(t,e){var n="",i=(new Date).getTime(),a=1;try{n=uni.getStorageSync("Report_Data_Time"),a=uni.getStorageSync("Report_Status")}catch(t){n="",a=1}""!==a?(1===a&&t(),n||(uni.setStorageSync("Report_Data_Time",i),n=i),i-n>864e5&&C((function(t){var e=t.enable;uni.setStorageSync("Report_Data_Time",i),uni.setStorageSync("Report_Status",e)}))):C((function(e){var n=e.enable;uni.setStorageSync("Report_Data_Time",i),uni.setStorageSync("Report_Status",n),1===n&&t()}))}))}},{key:"sendRequest",value:function(t){var e=this;this.getIsReportData().then((function(){uni.request({url:h,method:"POST",data:t,success:function(){},fail:function(n){++e._retry<3&&setTimeout((function(){e.sendRequest(t)}),1e3)}})}))}},{key:"imageRequest",value:function(t){this.getIsReportData().then((function(){var e=new Image,n=function(t){var e=Object.keys(t).sort(),n={},i="";for(var a in e)n[e[a]]=t[e[a]],i+=e[a]+"="+t[e[a]]+"&";return{sign:"",options:i.substr(0,i.length-1)}}(function(t){var e={};for(var n in t)e[n]=encodeURIComponent(t[n]);return e}(t)).options;e.src="https://tongji.dcloud.io/uni/stat.gif?"+n}))}},{key:"sendEvent",value:function(t,e){var n,i;(i=e,(n=t)?"string"!=typeof n?(console.error("uni.report [eventName] Parameter type error, it can only be of type String"),1):n.length>255?(console.error("uni.report [eventName] Parameter length cannot be greater than 255"),1):"string"!=typeof i&&"object"!=typeof i?(console.error("uni.report [options] Parameter type error, Only supports String or Object type"),1):"string"==typeof i&&i.length>255?(console.error("uni.report [options] Parameter length cannot be greater than 255"),1):"title"===n&&"string"!=typeof i?(console.error("uni.report [eventName] When the parameter is title, the [options] parameter can only be of type String"),1):void 0:(console.error("uni.report Missing [eventName] parameter"),1))||("title"!==t?this.sendEventRequest({key:t,value:"object"==typeof e?JSON.stringify(e):e},1):this._navigationBarTitle.report=e)}}]),t}()).getInstance(),z=!1,F={onLaunch:function(t){X.launch(t,this)},onLoad:function(t){if(X.load(t,this),this.$scope&&this.$scope.onShareAppMessage){var e=this.$scope.onShareAppMessage;this.$scope.onShareAppMessage=function(t){return X.interceptShare(!1),e.call(this,t)}}},onShow:function(){z=!1,X.show(this)},onHide:function(){z=!0,X.hide(this)},onUnload:function(){z?z=!1:X.hide(this)},onError:function(t){X.error(t)}};!function(){console.log("uni\u7edf\u8ba1\u5f00\u542f,version:1");var t=n(47);(t.default||t).mixin(F),uni.report=function(t,e){X.sendEvent(t,e)}}()},46:function(t,e,n){"use strict";n.r(e),e.default={pages:{},globalStyle:{}}},467:function(t,e,n){"use strict";n.r(e);n(45),n(48),n(50);var i=n(238);i.default.mpType="page",i.default.route="pages/home/winH5",i.default.el="#root",new Vue(i.default)},468:function(t,e,n){"use strict";n.r(e);var i=n(372),a=n(334);for(var r in a)"default"!==r&&function(t){n.d(e,t,(function(){return a[t]}))}(r);var o=n(0);var s=Object(o.a)(a.default,i.b,i.c,!1,null,"6c792fab","57d317c4",!1,i.a,void 0);(function(t){this.options.style||(this.options.style={}),Vue.prototype.__merge_style&&Vue.prototype.__$appStyle__&&Vue.prototype.__merge_style(Vue.prototype.__$appStyle__,this.options.style),Vue.prototype.__merge_style?Vue.prototype.__merge_style(n(434).default,this.options.style):Object.assign(this.options.style,n(434).default)}).call(s),e.default=s.exports},47:function(t,e){t.exports=Vue},48:function(t,e,n){Vue.prototype.__$appStyle__={},Vue.prototype.__merge_style&&Vue.prototype.__merge_style(n(49).default,Vue.prototype.__$appStyle__)},49:function(t,e,n){"use strict";n.r(e);var i=n(2),a=n.n(i);for(var r in i)"default"!==r&&function(t){n.d(e,t,(function(){return i[t]}))}(r);e.default=a.a},50:function(t,e){if("undefined"==typeof Promise||Promise.prototype.finally||(Promise.prototype.finally=function(t){var e=this.constructor;return this.then((function(n){return e.resolve(t()).then((function(){return n}))}),(function(n){return e.resolve(t()).then((function(){throw n}))}))}),"undefined"!=typeof uni&&uni&&uni.requireGlobal){var n=uni.requireGlobal();ArrayBuffer=n.ArrayBuffer,Int8Array=n.Int8Array,Uint8Array=n.Uint8Array,Uint8ClampedArray=n.Uint8ClampedArray,Int16Array=n.Int16Array,Uint16Array=n.Uint16Array,Int32Array=n.Int32Array,Uint32Array=n.Uint32Array,Float32Array=n.Float32Array,Float64Array=n.Float64Array,BigInt64Array=n.BigInt64Array,BigUint64Array=n.BigUint64Array}}});