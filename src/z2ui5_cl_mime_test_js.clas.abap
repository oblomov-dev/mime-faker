CLASS z2ui5_cl_mime_test_js DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    interfaces z2ui5_if_mime_container.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_mime_test_js IMPLEMENTATION.
  METHOD z2ui5_if_mime_container~container.
*sap.z2ui5 = sap.z2ui5 || {};
*sap.ui.define("z2ui5/Controller", ["sap/ui/core/mvc/Controller", "sap/ui/core/mvc/XMLView", "sap/ui/model/json/JSONModel", "sap/ui/core/BusyIndicator", "sap/m/MessageBox", "sap/m/MessageToast", "sap/ui/core/Fragment"], function(Controller, XMLView, JSON
"Model, BusyIndicator, MessageBox, MessageToast, Fragment) {
*    "use strict";
*    return Controller.extend("z2ui5.Controller", {
*        async onAfterRendering() {
*         try{
*            if (!sap.z2ui5.oResponse.PARAMS) {
*                return;
*            }
*            const {S_POPUP, S_VIEW_NEST, S_VIEW_NEST2, S_POPOVER} = sap.z2ui5.oResponse.PARAMS;
*            if (S_POPUP?.CHECK_DESTROY) {
*                sap.z2ui5.oController.PopupDestroy();
*            }
*            if (S_POPOVER?.CHECK_DESTROY) {
*                sap.z2ui5.oController.PopoverDestroy();
*            }
*            if (S_POPUP?.XML) {
*                sap.z2ui5.oController.PopupDestroy();
*                await this.displayFragment(S_POPUP.XML, 'oViewPopup');
*            }
*            if (!sap.z2ui5.checkNestAfter) {
*                if (S_VIEW_NEST?.XML) {
*                    sap.z2ui5.oController.NestViewDestroy();
*                    await this.displayNestedView(S_VIEW_NEST.XML, 'oViewNest', 'S_VIEW_NEST');
*                    sap.z2ui5.checkNestAfter = true;
*                }
*            }
*            if (!sap.z2ui5.checkNestAfter2) {
*                if (S_VIEW_NEST2?.XML) {
*                    sap.z2ui5.oController.NestViewDestroy2();
*                    await this.displayNestedView(S_VIEW_NEST2.XML, 'oViewNest2', 'S_VIEW_NEST2');
*                    sap.z2ui5.checkNestAfter2 = true;
*                }
*            }
*            if (S_POPOVER?.XML) {
*                await this.displayFragment(S_POPOVER.XML, 'oViewPopover', S_POPOVER.OPEN_BY_ID);
*            }
*            BusyIndicator.hide();
*            if (sap.z2ui5.isBusy) {
*                sap.z2ui5.isBusy = false;
*            }
*            if (sap.z2ui5.busyDialog) {
*                sap.z2ui5.busyDialog.close();
*            }
*            sap.z2ui5.onAfterRendering.forEach(item=>{
*                if (item !== undefined) {
*                    item();
*                }
*            }
*            )
*           }catch(e){ BusyIndicator.hide(); MessageBox.error(e.toLocaleString()); }
*        },
*
*        async displayFragment(xml, viewProp, openById) {
*            const oFragment = await Fragment.load({
*                definition: xml,
*                controller: sap.z2ui5.oController,
*            });
*            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);
*            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);
*            oFragment.setModel(oview_model);
*            let oControl = openById ? this.getControlById(openById) : null;
*            if (oControl) {
*                oFragment.openBy(oControl);
*            } else {
*                oFragment.open();
*            }
*            sap.z2ui5[viewProp] = oFragment;
*        },
*
*        async displayNestedView(xml, viewProp, viewNestId) {
*            const oView = await XMLView.create({
*                definition: xml,
*                controller: sap.z2ui5.oControllerNest,
*            });
*
*            let oview_model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);
*            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);
*            oView.setModel(oview_model);
*
*            let oParent = sap.z2ui5.oView.byId(sap.z2ui5.oResponse.PARAMS[viewNestId].ID);
*            if (oParent) {
*                try {
*                    oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_DESTROY]();
*                } catch {}
*                oParent[sap.z2ui5.oResponse.PARAMS[viewNestId].METHOD_INSERT](oView);
*            }
*            sap.z2ui5[viewProp] = oView;
*        },
*
*        getControlById(id) {
*            let oControl = sap.z2ui5.oView.byId(id);
*            if (!oControl) {
*                oControl = sap.ui.getCore().byId(id);
*                debugger ;
*            }
*            if (!oControl) {
*                oControl = sap.z2ui5.oViewNest.byId(id) || sap.z2ui5.oViewNest2.byId(id);
*            }
*            return oControl;
*        },
*
*        PopupDestroy() {
*            if (!sap.z2ui5.oViewPopup) {
*                return;
*            }
*            if (sap.z2ui5.oViewPopup.close) {
*                try {
*                    sap.z2ui5.oViewPopup.close();
*                } catch {}
*            }
*            sap.z2ui5.oViewPopup.destroy();
*        },
*        PopoverDestroy() {
*            if (!sap.z2ui5.oViewPopover) {
*                return;
*            }
*            if (sap.z2ui5.oViewPopover.close) {
*                try {
*                    sap.z2ui5.oViewPopover.close();
*                } catch {}
*            }
*            sap.z2ui5.oViewPopover.destroy();
*        },
*        NestViewDestroy() {
*            if (!sap.z2ui5.oViewNest) {
*                return;
*            }
*            sap.z2ui5.oViewNest.destroy();
*        },
*        NestViewDestroy2() {
*            if (!sap.z2ui5.oViewNest2) {
*                return;
*            }
*            sap.z2ui5.oViewNest2.destroy();
*        },
*        ViewDestroy() {
*            if (!sap.z2ui5.oView) {
*                return;
*            }
*            sap.z2ui5.oView.destroy();
*        },
*        onEventFrontend(...args) {
*
*            sap.z2ui5.onBeforeEventFrontend.forEach(item => {
*                if (item !== undefined) {
*                    item(args);
*                }
*              }
*            )
*
*            let oCrossAppNavigator;
*            switch (args[0].EVENT) {
*            case 'CROSS_APP_NAV_TO_PREV_APP':
*                oCrossAppNavigator = sap.ushell.Container.getService("CrossApplicationNavigation");
*                oCrossAppNavigator.backToPreviousApp();
*                break;
*            case 'CROSS_APP_NAV_TO_EXT':
*                oCrossAppNavigator = sap.ushell.Container.getService("CrossApplicationNavigation");
*                const hash = (oCrossAppNavigator.hrefForExternal({
*                    target: args[1],
*                    params: args[2]
*                })) || "";
*                if (args[3] === 'EXT') {
*                    let url = window.location.href.split('#')[0] + hash;
*                    sap.m.URLHelper.redirect(url, true);
*                } else {
*                    oCrossAppNavigator.toExternal({
*                        target: {
*                            shellHash: hash
*                        }
*                    });
*                }
*                break;
*            case 'LOCATION_RELOAD':
*                window.location = args[1];
*                break;
*            case 'OPEN_NEW_TAB':
*                window.open(args[1], '_blank');
*                break;
*            case 'POPUP_CLOSE':
*                sap.z2ui5.oController.PopupDestroy();
*                break;
*            case 'POPOVER_CLOSE':
*                sap.z2ui5.oController.PopoverDestroy();
*                break;
*            case 'NAV_CONTAINER_TO':
*                var navCon = sap.z2ui5.oView.byId(args[1]);
*                var navConTo = sap.z2ui5.oView.byId(args[2]);
*                navCon.to(navConTo);
*                break;
*            case 'NEST_NAV_CONTAINER_TO':
*                navCon = sap.z2ui5.oViewNest.byId(args[1]);
*                navConTo = sap.z2ui5.oViewNest.byId(args[2]);
*                navCon.to(navConTo);
*                break;
*            case 'NEST2_NAV_CONTAINER_TO':
*                navCon = sap.z2ui5.oViewNest2.byId(args[1]);
*                navConTo = sap.z2ui5.oViewNest2.byId(args[2]);
*                navCon.to(navConTo);
*                break;
*            }
*        },
*        onEvent(...args) {
*            if (sap.z2ui5.isBusy) {
*                if (sap.z2ui5.isBusy == true) {
*                    sap.z2ui5.busyDialog = new sap.m.BusyDialog();
*                    sap.z2ui5.busyDialog.open();
*                    return;
*                }
*            }
*            sap.z2ui5.isBusy = true;
*            if (!window.navigator.onLine) {
*                sap.m.MessageBox.alert('No internet connection! Please reconnect to the server and try again.');
*                sap.z2ui5.isBusy = false;
*                return;
*            }
*            BusyIndicator.show();
*            sap.z2ui5.oBody = {};
*            let isUpdated = false;
*            if (sap.z2ui5.oViewPopup) {
*                if (sap.z2ui5.oViewPopup.isOpen ) { if( sap.z2ui5.oViewPopup.isOpen() == true ) {
*                    sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewPopup.getModel().getData().EDIT;
*                    isUpdated = true;
*                    sap.z2ui5.oBody.VIEWNAME = 'MAIN';
*                } }
*            }
*            if (isUpdated == false) {
*                if (sap.z2ui5.oViewPopover) {
*                    if (sap.z2ui5.oViewPopover.isOpen) {
*                        if (sap.z2ui5.oViewPopover.isOpen() == true) {
*                            sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewPopover.getModel().getData().EDIT;
*                            isUpdated = true;
*                            sap.z2ui5.oBody.VIEWNAME = 'MAIN';
*                        }
*                    }
*                    sap.z2ui5.oViewPopover.destroy();
*                }
*            }
*            if (isUpdated == false) {
*                if (sap.z2ui5.oViewNest == this.getView()) {
*                    sap.z2ui5.oBody.EDIT = sap.z2ui5.oViewNest.getModel().getData().EDIT;
*                    sap.z2ui5.oBody.VIEWNAME = 'NEST';
*                    isUpdated = true;
*                }
*            }
*            if (isUpdated == false) {
*                sap.z2ui5.oBody.EDIT = sap.z2ui5.oView.getModel().getData().EDIT;
*                sap.z2ui5.oBody.VIEWNAME = 'MAIN';
*            }
*
*            sap.z2ui5.onBeforeRoundtrip.forEach(item=>{
*                if (item !== undefined) {
*                    item();
*                }
*            }
*            )
*            if (args[0].CHECK_VIEW_DESTROY) {
*                sap.z2ui5.oController.ViewDestroy();
*            }
*            sap.z2ui5.oBody.ID = sap.z2ui5.oResponse.ID;
*            sap.z2ui5.oBody.ARGUMENTS = args;
*
*            sap.z2ui5.oResponseOld = sap.z2ui5.oResponse;
*            sap.z2ui5.oResponse = {};
*            sap.z2ui5.oController.Roundtrip();
*        },
*        responseError(response) {
*            document.write(response);
*        },
*        updateModelIfRequired(paramKey, oView) {
*            if (sap.z2ui5.oResponse.PARAMS[paramKey]?.CHECK_UPDATE_MODEL) {
*                let model = new JSONModel(sap.z2ui5.oResponse.OVIEWMODEL);
*                model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);
*                oView.setModel(model);
*            }
*        },
*   async     responseSuccess(response) {
*         try{
*            sap.z2ui5.oResponse = response;
*
*            if (sap.z2ui5.oResponse.PARAMS?.S_VIEW?.CHECK_DESTROY) {
*                sap.z2ui5.oController.ViewDestroy();
*            }
*
*            sap.z2ui5.oController.showMessage('S_MSG_TOAST', sap.z2ui5.oResponse.PARAMS);
*            sap.z2ui5.oController.showMessage('S_MSG_BOX', sap.z2ui5.oResponse.PARAMS);
*            if (sap.z2ui5.oResponse.PARAMS?.S_VIEW?.XML) { if ( sap.z2ui5.oResponse.PARAMS?.S_VIEW?.XML !== '') {
*                sap.z2ui5.oController.ViewDestroy();
*               await sap.z2ui5.oController.createView(sap.z2ui5.oResponse.PARAMS.S_VIEW.XML, sap.z2ui5.oResponse.OVIEWMODEL);
*            return;  } }
*                this.updateModelIfRequired('S_VIEW', sap.z2ui5.oView);
*                this.updateModelIfRequired('S_VIEW_NEST', sap.z2ui5.oViewNest);
*                this.updateModelIfRequired('S_VIEW_NEST2', sap.z2ui5.oViewNest2);
*                this.updateModelIfRequired('S_POPUP', sap.z2ui5.oViewPopup);
*                this.updateModelIfRequired('S_POPOVER', sap.z2ui5.oViewPopover);
*                sap.z2ui5.oController.onAfterRendering();
*           }catch(e){ BusyIndicator.hide(); MessageBox.error(e.toLocaleString()); }
*        },
*        showMessage(msgType, params) {
*            if (params[msgType]?.TEXT !== undefined) {
*                if (msgType === 'S_MSG_TOAST') {
*                    MessageToast.show(params[msgType].TEXT);
*                } else if (msgType === 'S_MSG_BOX') {
*                    MessageBox[params[msgType].TYPE](params[msgType].TEXT);
*                }
*            }
*        },
*        async createView(xml, viewModel) {
*            const oView = await XMLView.create({
*                definition: xml,
*                controller: sap.z2ui5.oController,
*            });
*            let oview_model = new JSONModel(viewModel);
*            oview_model.setSizeLimit(sap.z2ui5.JSON_MODEL_LIMIT);
*            oView.setModel(oview_model);
*
*            if (sap.z2ui5.oParent) {
*                sap.z2ui5.oParent.removeAllPages();
*                sap.z2ui5.oParent.insertPage(oView);
*            } else {
*                oView.placeAt("content");
*            }
*            sap.z2ui5.oView = oView;
*        },
*        async readHttp() {
*            const response = await fetch(sap.z2ui5.pathname, {
*                method: 'POST',
*                headers: {
*                    'Content-Type': 'application/json'
*                },
*                body: JSON.stringify(sap.z2ui5.oBody)
*            });
*
*            if (!response.ok) {
*                const responseText = await response.text();
*                sap.z2ui5.oController.responseError(responseText);
*            } else {
*                const responseData = await response.json();
*                sap.z2ui5.oController.responseSuccess(responseData);
*            }
*
*        },
*
*        Roundtrip() {
*
*            sap.z2ui5.checkTimerActive = false;
*            sap.z2ui5.checkNestAfter = false;
*            sap.z2ui5.checkNestAfter2 = false;
*
*            sap.z2ui5.oBody.OLOCATION = {
*                ORIGIN: window.location.origin,
*                PATHNAME: sap.z2ui5.pathname,
*                SEARCH: window.location.search,
*                //      VERSION: sap.ui.getVersionInfo().gav,
*                CHECK_LAUNCHPAD_ACTIVE: sap.ushell !== undefined,
*                STARTUP_PARAMETERS: sap.z2ui5.startupParameters,
*            };
*            if (sap.z2ui5.search) {
*                sap.z2ui5.oBody.OLOCATION.SEARCH = sap.z2ui5.search;
*            }
*           sap.z2ui5.oController.readHttp();
*        },
*    })
*});
*
*sap.ui.require(["z2ui5/Controller", "sap/ui/core/BusyIndicator", "sap/ui/core/mvc/XMLView", "sap/ui/core/Fragment", "sap/m/MessageToast", "sap/m/MessageBox", "sap/ui/model/json/JSONModel"], (Controller,BusyIndicator)=>{
*
*    BusyIndicator.show();
*    sap.z2ui5.oController = new Controller();
*    sap.z2ui5.oControllerNest = new Controller();
*    sap.z2ui5.oControllerNest2 = new Controller();
*
*    sap.z2ui5.pathname = sap.z2ui5.pathname ||  window.location.pathname;
*    sap.z2ui5.checkNestAfter = false;
*
*    sap.z2ui5.oBody = {
*        APP_START: sap.z2ui5.APP_START
*    };
*    sap.z2ui5.oController.Roundtrip();
*
*    sap.z2ui5.onBeforeRoundtrip = [];
*    sap.z2ui5.onAfterRendering = [];
*    sap.z2ui5.onBeforeEventFrontend = [];
*    sap.z2ui5.onAfterRoundtrip = []; }
*);
* sap.ui.define("z2ui5/Timer" , [
*   "sap/ui/core/Control"
*], (Control) => {
*   "use strict";
*
*   return Control.extend("z2ui5.Timer", {
*       metadata : {
*           properties: {
*                delayMS: {
*                    type: "string",
*                    defaultValue: ""
*                },
*                checkActive: {
*                    type: "boolean",
*                    defaultValue: true
*                },
*                checkRepeat: {
*                    type: "boolean",
*                    defaultValue: false
*                },
*            },
*            events: {
*                 "finished": {
*                        allowPreventDefault: true,
*                        parameters: {},
*                 }
*            }
*       },
*       onAfterRendering() {
*       },
*       delayedCall( oControl){
*
*          if ( oControl.getProperty("checkActive") == false ){ return; }
*            setTimeout((oControl) => {
*               oControl.setProperty( "checkActive", false )
*                oControl.fireFinished();
*              if ( oControl.getProperty( "checkRepeat" ) ) { oControl.delayedCall( oControl ); }
*              }, parseInt( oControl.getProperty("delayMS") ), oControl );
*       },
*       renderer(oRm, oControl) {
*        oControl.delayedCall( oControl );
*        }
*   });
*});sap.ui.define("z2ui5/Focus", [
*  "sap/ui/core/Control",
*], (Control) => {
*  "use strict";
*
*  return Control.extend("z2ui5.Focus", {
*      metadata: {
*          properties: {
*              setUpdate : { type: "boolean", defaultValue: true },
*              focusId: { type: "string" },
*              selectionStart: { type: "string", defaultValue: "0" },
*              selectionEnd: { type: "string", defaultValue: "0" },
*          }
*      },
*
*      init() {
*      },
*
*      renderer(oRm, oControl) {
*
*        if (!oControl.getProperty("setUpdate")){ return; }
*            oControl.setProperty("setUpdate", false);
*
*          setTimeout((oControl) => {
*
*              var oElement = sap.z2ui5.oView.byId(oControl.getProperty("focusId"));
*              var oFocus = oElement.getFocusInfo();
*              oFocus.selectionStart = parseInt(oControl.getProperty("selectionStart"));
*              oFocus.selectionEnd = parseInt(oControl.getProperty("selectionEnd"));
*              oElement.applyFocusInfo(oFocus);
*
*          }, 100, oControl);
*
*      }
*  });
*});sap.ui.define("z2ui5/Title" , ["sap/ui/core/Control"], (Control)=>{
*        "use strict";
*        return Control.extend("z2ui5.Title", {
*            metadata: {
*                properties: {
*                    title: {
*                        type: "string"
*                    },
*                }
*            },
*            setTitle(val) {
*                this.setProperty("title", val);
*                document.title = val;
*            },
*            renderer(oRm, oControl) {}
*        });
*  });sap.ui.define("z2ui5/History",["sap/ui/core/Control"], (Control)=>{
*        "use strict";
*        return Control.extend("z2ui5.History", {
*            metadata: {
*                properties: {
*                    search: {
*                        type: "string"
*                    },
*                }
*            },
*            setSearch(val) {
*                this.setProperty("search", val);
*                history.replaceState(null, null, window.location.pathname + val );
*            },
*            renderer(oRm, oControl) {}
*        });
*  });sap.ui.define("z2ui5/Scrolling", [
*  "sap/ui/core/Control",
*], (Control) => {
*  "use strict";
*
*  return Control.extend("z2ui5.Scrolling", {
*      metadata: {
*          properties: {
*              setUpdate: { type: "boolean" , defaultValue: true},
*              items: { type: "Array" },
*          }
*      },
*
*      setBackend() {
*   if (this.mProperties.items){ this.mProperties.items.forEach(item => {
*                        try {
*                            item.SCROLLTO = sap.z2ui5.oView.byId(item.ID).getScrollDelegate().getScrollTop();
*                        } catch (e) {
*                            try {
*                                var ele = '#' + sap.z2ui5.oView.byId(item.ID).getId() + '-inner';
*                                item.SCROLLTO = $(ele).scrollTop();
*                            } catch (e) { }
*                        }
*                    });
*  } },
*      init() {    sap.z2ui5.onBeforeRoundtrip.push( this.setBackend.bind(this) );   },
*      renderer(oRm, oControl) {
*
*
*            if (!oControl.getProperty("setUpdate")){ return; }
*
*            oControl.setProperty("setUpdate", false);
*          var items = oControl.getProperty("items");
*          if(!items){return;};
*
*            setTimeout( (oControl) => {
*              var items = oControl.getProperty("items");
*              items.forEach(item => {
*                  try {
*                      sap.z2ui5.oView.byId(item.ID).scrollTo(item.SCROLLTO);
*                  } catch {
*                      try {
*                          var ele = '#' + sap.z2ui5.oView.byId(item.ID).getId() + '-inner';
*                          $(ele).scrollTop(item.SCROLLTO);
*                      } catch { setTimeout( function( item ) { sap.z2ui5.oView.byId(item.ID).scrollTo(item.SCROLLTO); } , 1 , item);}
*                  }
*              }
*              );
*
*            } , 50 , oControl );
*      }
*  });
*});sap.ui.define("z2ui5/Info",[
*   "sap/ui/core/Control"
*], (Control) => {
*   "use strict";
*
*   return Control.extend("z2ui5.Info", {
*       metadata : {
*           properties: {
*                ui5_version: {
*                    type: "string"
*                },
*                ui5_gav: {
*                    type: "string"
*                },
*                ui5_theme: {
*                    type: "string"
*                },
*                device_os: {
*                    type: "string"
*                },
*                device_systemtype: {
*                    type: "string"
*                },
*                device_browser: {
*                    type: "string"
*                },
*            },
*            events: {
*                 "finished": {
*                        allowPreventDefault: true,
*                        parameters: {},
*                 }
*            }
*       },
*
*       init () {
*
*       },
*
*       onAfterRendering() {
*
*       },
*
*       renderer(oRm, oControl) {
*
*            oControl.setProperty( "ui5_version" ,  sap.ui.version );
*            oControl.setProperty( "ui5_gav" ,  sap.ui.getVersionInfo().gav );
*            oControl.setProperty( "device_os" ,  sap.ui.Device.os.name );
*          //  this.setProperty( "device_systemtype" ,  sap.ui.getVersionInfo().gav );
*          oControl.setProperty( "device_browser" ,  sap.ui.Device.browser.name );
*          oControl.fireFinished();
*
*        }
*   });
*});sap.ui.define("z2ui5/Geolocation" , [
*   "sap/ui/core/Control"
*], (Control) => {
*   "use strict";
*
*   return Control.extend("z2ui5.Geolocation", {
*       metadata : {
*           properties: {
*                longitude: {
*                    type: "string",
*                    defaultValue: ""
*                },
*               latitude: {
*                    type: "string",
*                    defaultValue: ""
*                },
*               altitude: {
*                    type: "string",
*                    defaultValue: ""
*                },
*               accuracy: {
*                    type: "string",
*                    defaultValue: ""
*                },
*               altitudeAccuracy: {
*                    type: "string",
*                    defaultValue: ""
*                },
*               speed: {
*                    type: "string",
*                    defaultValue: false
*                },
*               heading: {
*                    type: "string",
*                    defaultValue: false
*                },
*               enableHighAccuracy: {
*                    type: "boolean",
*                    defaultValue: false
*                },
*               timeout: {
*                    type: "string",
*                    defaultValue: "5000"
*                }
*           },
*           events: {
*               "finished": {
*                      allowPreventDefault: true,
*                      parameters: {},
*               }
*          }
*       },
*
*       callbackPosition(position){
*
*           var test = position.coords.longitude
*           this.setProperty("longitude", position.coords.longitude , true);
*           this.setProperty("latitude", position.coords.latitude , true);
*           this.setProperty("altitude", position.coords.altitude , true);
*           this.setProperty("accuracy", position.coords.accuracy , true);
*           this.setProperty("altitudeAccuracy", position.coords.altitudeAccuracy , true);
*           this.setProperty("speed", position.coords.speed , true);
*           this.setProperty("heading", position.coords.heading , true);
*           this.fireFinished();
*           //this.getParent().getParent().getModel().refresh();
*
*       },
*
*       async init(){
*
*           navigator.geolocation.getCurrentPosition(this.callbackPosition.bind(this));
*           //navigator.geolocation.watchPosition(this.callbackPosition.bind(this));
*
*       },
*
*        exit () {
*           //clearWatch
*        },
*
*       onAfterRendering() {
*
*
*       },
*
*       renderer(oRm, oControl) {
*
*        }
*   });
*}); sap.ui.define("z2ui5/FileUploader",[
*            "sap/ui/core/Control",
*            "sap/m/Button",
*            "sap/ui/unified/FileUploader"
*        ], function (Control, Button, FileUploader) {
*            "use strict";
*
*            return Control.extend("z2ui5.FileUploader", {
*
*                metadata: {
*                    properties: {
*                        value: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        path: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        tooltip: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        fileType: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        placeholder: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        buttonText: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        style: {
*                            type: "string",
*                            defaultValue: ""
*                        },
*                        uploadButtonText: {
*                            type: "string",
*                            defaultValue: "Upload"
*                        },
*                        enabled: {
*                            type: "boolean",
*                            defaultValue: true
*                        },
*                        icon: {
*                            type: "string",
*                            defaultValue: "sap-icon://browse-folder"
*                        },
*                        iconOnly: {
*                            type: "boolean",
*                            defaultValue: false
*                        },
*                        buttonOnly: {
*                            type: "boolean",
*                            defaultValue: false
*                        },
*                        multiple: {
*                            type: "boolean",
*                            defaultValue: false
*                        },
*                        visible: {
*                            type: "boolean",
*                            defaultValue: true
*                        },
*                        checkDirectUpload: {
*                            type: "boolean",
*                            defaultValue: false
*                        }
*                    },
*
*
*                    aggregations: {
*                    },
*                    events: {
*                        "upload": {
*                            allowPreventDefault: true,
*                            parameters: {}
*                        }
*                    },
*                    renderer: null
*                },
*
*                renderer: function (oRm, oControl) {
*
*                    if (!oControl.getProperty("checkDirectUpload")) {
*                     oControl.oUploadButton = new Button({
*                        text: oControl.getProperty("uploadButtonText"),
*                        enabled: oControl.getProperty("path") !== "",
*                        press: function (oEvent) {
*
*                            this.setProperty("path", this.oFileUploader.getProperty("value"));
*
*                            var file = sap.z2ui5.oUpload.oFileUpload.files[0];
*                            var reader = new FileReader();
*
*                            reader.onload = function (evt) {
*                                var vContent = evt.currentTarget.result;
*                                this.setProperty("value", vContent);
*                                this.fireUpload();
*                                //this.getView().byId('picture' ).getDomRef().src = vContent;
*                            }.bind(this)
*
*                            reader.readAsDataURL(file);
*                        }.bind(oControl)
*                     });
*                    }
*
*                    oControl.oFileUploader = new FileUploader({
*                        icon: oControl.getProperty("icon"),
*                        iconOnly: oControl.getProperty("iconOnly"),
*                        buttonOnly: oControl.getProperty("buttonOnly"),
*                        buttonText: oControl.getProperty("buttonText"),
*                        style: oControl.getProperty("style"),
*                        fileType: oControl.getProperty("fileType"),
*                        visible: oControl.getProperty("visible"),
*                        uploadOnChange: true,
*                        value: oControl.getProperty("path"),
*                        placeholder: oControl.getProperty("placeholder"),
*                        change: function (oEvent) {
*                           if (oControl.getProperty("checkDirectUpload")) {
*                             return;
*                           }
*
*                            var value = oEvent.getSource().getProperty("value");
*                            this.setProperty("path", value);
*                            if (value) {
*                                this.oUploadButton.setEnabled();
*                            } else {
*                                this.oUploadButton.setEnabled(false);
*                            }
*                            this.oUploadButton.rerender();
*                            sap.z2ui5.oUpload = oEvent.oSource;
*                        }.bind(oControl),
*                        uploadComplete: function (oEvent) {
*                           if (!oControl.getProperty("checkDirectUpload")) {
*                             return;
*                           }
*
*                            var value = oEvent.getSource().getProperty("value");
*                            this.setProperty("path", value);
*
*                            var file = oEvent.oSource.oFileUpload.files[0];
*                            var reader = new FileReader();
*
*                            reader.onload = function (evt) {
*                                var vContent = evt.currentTarget.result;
*                                this.setProperty("value", vContent);
*                                this.fireUpload();
*                            }.bind(this)
*
*                            reader.readAsDataURL(file);
*                        }.bind(oControl)
*                    });
*
*                    var hbox = new sap.m.HBox();
*                    hbox.addItem(oControl.oFileUploader);
*                    hbox.addItem(oControl.oUploadButton);
*                    oRm.renderControl(hbox);
*                }
*            });
*        }); sap.ui.define( "z2ui5/MultiInputExt" , ["sap/ui/core/Control", "sap/m/Token"
*], (Control, Token) => {
*  "use strict";
*
*  return Control.extend("z2ui5.MultiInputExt", {
*      metadata: {
*          properties: {
*              MultiInputId: { type: "String" },
*              addedTokens: { type: "Array" },
*              checkInit: { type: "Boolean", defaultValue : false },
*              removedTokens: { type: "Array" }
*          },
*                    events: {
*                        "change": {
*                            allowPreventDefault: true,
*                            parameters: {}
*                        }
*                    },
*      },
*
*      init() {
*  sap.z2ui5.onAfterRendering.push( this.setControl.bind(this) );
*      },
*
*      onTokenUpdate(oEvent) {
*          this.setProperty("addedTokens", []);
*          this.setProperty("removedTokens", []);
*
*          if (oEvent.mParameters.type == "removed") {
*              let removedTokens = [];
*              oEvent.mParameters.removedTokens.forEach((item) => {
*                  removedTokens.push({ KEY: item.getKey(), TEXT: item.getText() });
*              });
*              this.setProperty("removedTokens", removedTokens);
*          } else {
*              let addedTokens = [];
*              oEvent.mParameters.addedTokens.forEach((item) => {
*                  addedTokens.push({ KEY: item.getKey(), TEXT: item.getText() });
*              });
*              this.setProperty("addedTokens", addedTokens);
*          }
*      this.fireChange();
*      },
*      setControl(){ let table = sap.z2ui5.oView.byId( this.getProperty("MultiInputId"));
*         if ( this.getProperty("checkInit") == true ){ return; }
*         this.setProperty( "checkInit" , true );
*          table.attachTokenUpdate(this.onTokenUpdate.bind(this));
*          var fnValidator = function (args) {
*              var text = args.text;
*              return new Token({ key: text, text: text });
*          };
*          table.addValidator(fnValidator); },
*      renderer(oRM, oControl) {
*      }
*  });
*});sap.ui.define("z2ui5/UITableExt" , [
*  "sap/ui/core/Control"
*], (Control) => {
*  "use strict";
*
*  return Control.extend("z2ui5.UITableExt", {
*      metadata: {
*          properties: {
*              tableId: { type: "String" }
*          }
*      },
*
*      init() {
*          sap.z2ui5.onBeforeRoundtrip.push(this.readFilter.bind(this));
*          sap.z2ui5.onAfterRoundtrip.push(this.setFilter.bind(this));
*      },
*
*      readFilter() {
*          try {
*              let id = this.getProperty("tableId");
*              let oTable = sap.z2ui5.oView.byId(id);
*              this.aFilters = oTable.getBinding().aFilters;
*          } catch (e) { };
*      },
*
*      setFilter() {
*          try {
*            setTimeout( (aFilters) => { let id = this.getProperty("tableId");
*              let oTable = sap.z2ui5.oView.byId(id);
*              oTable.getBinding().filter(aFilters);
*        } , 100 , this.aFilters);  } catch (e) { };
*      },
*
*      renderer(oRM, oControl) {
*      }
*  });
*});sap.ui.define("z2ui5/Util" , ["sap/ui/core/Control"], (Control)=>{
*        "use strict";
*        return {
*        DateCreateObject: (s) => new Date(s),
*        DateAbapTimestampToDate: (sTimestamp) => new sap.gantt.misc.Format.abapTimestampToDate(sTimestamp),
*        DateAbapDateToDateObject: (d) => new Date(d.slice(0, 4), parseInt(d.slice(4, 6)) - 1, d.slice(6, 8)),
*        DateAbapDateTimeToDateObject: (d, t = '000000') => new Date(d.slice(0, 4), parseInt(d.slice(4, 6)) - 1, d.slice(6, 8), t.slice(0, 2), t.slice(2, 4), t.slice(4, 6)),
*        };
*  });
*          sap.z2ui5.JSON_MODEL_LIMIT = 100;
*sap.ui.define( "z2ui5/DebuggingTools" ,[
*    "sap/ui/core/Control",
*     "sap/ui/core/Fragment",
*     "sap/ui/model/json/JSONModel"
*], (Control, Fragment, JSONModel) => {
*    "use strict";
*
*    return Control.extend("project1.control.DebuggingTools", {
*        metadata: {
*            properties: {
*                checkLoggingActive: {
*                    type: "boolean",
*                    defaultValue: ""
*                }
*            },
*            events: {
*                "finished": {
*                    allowPreventDefault: true,
*                    parameters: {},
*                }
*            }
*        },
*
*        async show() {
*
*            var oFragmentController = {
*   prettifyXml: function (sourceXml) {
*                    var xmlDoc = new DOMParser().parseFromString(sourceXml, 'application/xml');
*                        // describes how we want to modify the XML - indent everything
*                     var sParse =   unescape( '%3Cxsl%3Astylesheet%20xmlns%3Axsl%3D%22http%3A//www.w3.org/1999/XSL/Transform%22%3E%0A%20%20%3Cxsl%3Astrip-space%20elements%3D%22*%22/%3E%0A%20%20%3Cxsl%3Atemplate%20match%3D%22para%5Bcontent-style%5D%5Bnot
"%28text%28%29%29%5D%22%3E%0A%20%20%20%20%3Cxsl%3Avalue-of%20select%3D%22normalize-space%28.%29%22/%3E%0A%20%20%3C/xsl%3Atemplate%3E%0A%20%20%3Cxsl%3Atemplate%20match%3D%22node%28%29%7C@*%22%3E%0A%20%20%20%20%3Cxsl%3Acopy%3E%3Cxsl%3Aapply-templates%20sel
"ect%3D%22node%28%29%7C@*%22/%3E%3C/xsl%3Acopy%3E%0A%20%20%3C/xsl%3Atemplate%3E%0A%20%20%3Cxsl%3Aoutput%20indent%3D%22yes%22/%3E%0A%3C/xsl%3Astylesheet%3E' )
*                    var xsltDoc = new DOMParser().parseFromString(sParse , 'application/xml');
*
*                    var xsltProcessor = new XSLTProcessor();
*                    xsltProcessor.importStylesheet(xsltDoc);
*                    var resultDoc = xsltProcessor.transformToDocument(xmlDoc);
*                    var resultXml = new XMLSerializer().serializeToString(resultDoc);
*                    return resultXml;
*                },
*                onItemSelect: function (oEvent) {
*                    let selItem = oEvent.getSource().getSelectedItem();
*
*                    if (selItem == 'MODEL') {
*                       this.displayEditor( oEvent, JSON.stringify( sap?.z2ui5?.oView?.getModel()?.getData(), null, 3) , 'json' );
*                        return;
*                    }
*                    if (selItem == 'VIEW') {
*                       this.displayEditor( oEvent, this.prettifyXml( sap?.z2ui5?.oView?.mProperties?.viewContent ) , 'xml' );
*                        return;
*                    }
*                    if (selItem == 'PLAIN') {
*                        this.displayEditor(  oEvent, JSON.stringify(sap.z2ui5.oResponse, null, 3) , 'json' );
*                        return;
*                    }
*                    if (selItem == 'REQUEST') {
*                        this.displayEditor(  oEvent, JSON.stringify(sap.z2ui5.oBody, null, 3) , 'json' );
*                        return;
*                    }
*                    if (selItem == 'POPUP') {
*                        this.displayEditor(  oEvent, this.prettifyXml( sap?.z2ui5?.oResponse?.PARAMS?.S_POPUP?.XML ) , 'xml' );
*                        return;
*                    }
*                    if (selItem == 'POPUP_MODEL') {
*                        this.displayEditor(  oEvent, JSON.stringify( sap.z2ui5.oViewPopup.getModel().getData(), null, 3) , 'json' );
*                        return;
*                    }
*                    if (selItem == 'POPOVER') {
*                        this.displayEditor(  oEvent,  sap?.z2ui5?.oResponse?.PARAMS?.S_POPOVER?.XML  , 'xml' );
*                        return;
*                    }
*                    if (selItem == 'POPOVER_MODEL') {
*                        this.displayEditor(  oEvent, JSON.stringify( sap?.z2ui5?.oViewPopover?.getModel( )?.getData( ) , null, 3) , 'json' );
*                        return;
*                    }
*                    if (selItem == 'NEST1') {
*                        this.displayEditor(  oEvent, sap?.z2ui5?.oViewNest?.mProperties?.viewContent  , 'xml' );
*                        return;
*                    }
*                    if (selItem == 'NEST1_MODEL') {
*                        this.displayEditor(  oEvent, JSON.stringify( sap?.z2ui5?.oViewNest?.getModel( )?.getData( ) , null, 3) , 'json' );
*                        return;
*                    }
*                    if (selItem == 'NEST2') {
*                        this.displayEditor(  oEvent, sap?.z2ui5?.oViewNest2?.mProperties?.viewContent  , 'xml' );
*                        return;
*                    }
*                    if (selItem == 'NEST2_MODEL') {
*                        this.displayEditor(  oEvent, JSON.stringify( sap?.z2ui5?.oViewNest2?.getModel( )?.getData( ) , null, 3) , 'json' );
*                        return;
*                    }
*
*                },
*
*                displayEditor (oEvent, content, type) {
*                    oEvent.getSource().getModel().oData.value = content;
*                    oEvent.getSource().getModel().oData.type = type;
*                    oEvent.getSource().getModel().refresh();
*                },
*
*
*
*                onClose: function () {
*                    this.oDialog.close();
*
*                }
*            };
*
*          let  XMLDef = "PGNvcmU6RnJhZ21lbnREZWZpbml0aW9uCiAgICAgICAgICAgIHhtbG5zPSJzYXAubSIKICAgICAgICAgICAgICAgIHhtbG5zOm12Yz0ic2FwLnVpLmNvcmUubXZjIgogICAgICAgICAgICAgICAgeG1sbnM6Y29yZT0ic2FwLnVpLmNvcmUiCiAgICAgICAgICAgICAgICB4bWxuczp0bnQ9InNhcC50bnQi
"CiAgICAgICAgICAgICAgICB4bWxuczplZGl0b3I9InNhcC51aS5jb2RlZWRpdG9yIj4KICAgICAgICAgICAgICAgICAgPERpYWxvZyB0aXRsZT0iYWJhcDJVSTUgLSBEZWJ1Z2dpbmcgVG9vbHMiIHN0cmV0Y2g9InRydWUiIGlkPSJkZWJ1Zy1kaWFsb2ciPgogICAgICAgICAgICAgICAgICA8SEJveD4KICAgICAgICAgICAgICAgIDx0b
"nQ6U2lkZU5hdmlnYXRpb24gaWQ9InNpZGVOYXZpZ2F0aW9uIiBzZWxlY3RlZEtleT0iUExBSU4iIGl0ZW1TZWxlY3Q9Im9uSXRlbVNlbGVjdCI+CiAgICAgICAgICAgICAgICAgICAgPHRudDpOYXZpZ2F0aW9uTGlzdD4KICAgICAgICAgICAgICAgICAgICAgICAgPHRudDpOYXZpZ2F0aW9uTGlzdEl0ZW0gdGV4dD0iQ29tbXVuaWNhdG
"lvbiIgaWNvbj0ic2FwLWljb246Ly9lbXBsb3llZSIgIHRleHREaXJlY3Rpb249IkxUUiI+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dG50Ok5hdmlnYXRpb25MaXN0SXRlbSB0ZXh0PSJQcmV2aW91cyBSZXF1ZXN0IiBpZD0iUkVRVUVTVCIga2V5PSJSRVFVRVNUIiAgdGV4dERpcmVjdGlvbj0iTFRSIi8+CiAgICAgICAgICA
"gICAgICAgICAgICAgICAgICA8dG50Ok5hdmlnYXRpb25MaXN0SXRlbSB0ZXh0PSJSZXNwb25zZSIgICAgICAgICAgICAgICAgaWQ9IlBMQUlOIiAgICAgICAgIGtleT0iUExBSU4iICB0ZXh0RGlyZWN0aW9uPSJMVFIiLz4KICAgICAgICAgICAgICAgICAgICAgICAgPC90bnQ6TmF2aWdhdGlvbkxpc3RJdGVtPgogICAgICAgICAgICAg
"ICAgICAgICAgICA8dG50Ok5hdmlnYXRpb25MaXN0SXRlbSB0ZXh0PSJWaWV3IiBpY29uPSJzYXAtaWNvbjovL2VtcGxveWVlIiAgdGV4dERpcmVjdGlvbj0iTFRSIj4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0bnQ6TmF2aWdhdGlvbkxpc3RJdGVtIHRleHQ9IlZpZXcgKFhNTCkiICAgICAgICAgICBpZD0iVklFVyIgICAgI
"CAgICAga2V5PSJWSUVXIiAgdGV4dERpcmVjdGlvbj0iTFRSIi8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dG50Ok5hdmlnYXRpb25MaXN0SXRlbSB0ZXh0PSJWaWV3IE1vZGVsIChKU09OKSIgICAgaWQ9Ik1PREVMIiAgICAgICAgIGtleT0iTU9ERUwiICAgdGV4dERpcmVjdGlvbj0iTFRSIi8+CiAgICAgICAgICAgICAgIC
"AgICAgICAgICAgICA8dG50Ok5hdmlnYXRpb25MaXN0SXRlbSB0ZXh0PSJQb3B1cCAoWE1MKSIgICAgICAgICAgaWQ9IlBPUFVQIiAgICAgICAgIGtleT0iUE9QVVAiICAgICAgICAgIGVuYWJsZWQ9InsvYWN0aXZlUG9wdXB9IiAgdGV4dERpcmVjdGlvbj0iTFRSIi8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dG50Ok5hdml
"nYXRpb25MaXN0SXRlbSB0ZXh0PSJQb3B1cCBNb2RlbCAoSlNPTikiICAgaWQ9IlBPUFVQX01PREVMIiAgIGtleT0iUE9QVVBfTU9ERUwiICAgIGVuYWJsZWQ9InsvYWN0aXZlUG9wdXB9IiAgdGV4dERpcmVjdGlvbj0iTFRSIi8+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dG50Ok5hdmlnYXRpb25MaXN0SXRlbSB0ZXh0PSJQ
"b3BvdmVyIChYTUwpIiAgICAgICAgaWQ9IlBPUE9WRVIiICAgICAgIGtleT0iUE9QT1ZFUiIgICAgICAgIGVuYWJsZWQ9InsvYWN0aXZlUG9wb3Zlcn0iICB0ZXh0RGlyZWN0aW9uPSJMVFIiLz4KICAgICAgICAgICAgICAgICAgICAgICAgICAgIDx0bnQ6TmF2aWdhdGlvbkxpc3RJdGVtIHRleHQ9IlBvcG92ZXIgTW9kZWwgKEpTT04pI
"iBpZD0iUE9QT1ZFUl9NT0RFTCIga2V5PSJQT1BPVkVSX01PREVMIiAgZW5hYmxlZD0iey9hY3RpdmVQb3BvdmVyfSIgIHRleHREaXJlY3Rpb249IkxUUiIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRudDpOYXZpZ2F0aW9uTGlzdEl0ZW0gdGV4dD0iTmVzdDEgKFhNTCkiICAgICAgICAgIGlkPSJORVNUMSIgICAgICAgIC
"BrZXk9Ik5FU1QxIiAgICAgICAgICBlbmFibGVkPSJ7L2FjdGl2ZU5lc3QxfSIgIHRleHREaXJlY3Rpb249IkxUUiIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRudDpOYXZpZ2F0aW9uTGlzdEl0ZW0gdGV4dD0iTmVzdDEgTW9kZWwgKEpTT04pIiAgIGlkPSJORVNUMV9NT0RFTCIgICBrZXk9Ik5FU1QxX01PREVMIiAgICB
"lbmFibGVkPSJ7L2FjdGl2ZU5lc3QxfSIgIHRleHREaXJlY3Rpb249IkxUUiIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRudDpOYXZpZ2F0aW9uTGlzdEl0ZW0gdGV4dD0iTmVzdDIgKFhNTCkiICAgICAgICAgIGlkPSJORVNUMiIgICAgICAgICBrZXk9Ik5FU1QyIiAgICAgICAgICBlbmFibGVkPSJ7L2FjdGl2ZU5lc3Qy
"fSIgIHRleHREaXJlY3Rpb249IkxUUiIvPgogICAgICAgICAgICAgICAgICAgICAgICAgICAgPHRudDpOYXZpZ2F0aW9uTGlzdEl0ZW0gdGV4dD0iTmVzdDIgTW9kZWwgKEpTT04pIiAgIGlkPSJORVNUMl9NT0RFTCIgICBrZXk9Ik5FU1QyX01PREVMIiAgICBlbmFibGVkPSJ7L2FjdGl2ZU5lc3QyfSIgIHRleHREaXJlY3Rpb249IkxUU
"iIvPgogICAgICAgICAgICAgICAgICAgICAgICA8L3RudDpOYXZpZ2F0aW9uTGlzdEl0ZW0+CiAgICAgICAgICAgICAgICAgICAgPC90bnQ6TmF2aWdhdGlvbkxpc3Q+CiAgICAgICAgICAgICAgICA8L3RudDpTaWRlTmF2aWdhdGlvbj4KICAgICAgICAgICAgICAgICAgICA8ZWRpdG9yOkNvZGVFZGl0b3IKICAgICAgICAgICAgICAgIC
"AgICB0eXBlPSJ7L3R5cGV9IgogICAgICAgICAgICAgICAgICAgIHZhbHVlPSd7L3ZhbHVlfScKICAgICAgICAgICAgICAgIGhlaWdodD0iODAwcHgiIHdpZHRoPSIxMjAwcHgiLz4gPC9IQm94PgogICAgICAgICAgICAgICA8Zm9vdGVyPjxUb29sYmFyPjxUb29sYmFyU3BhY2VyLz48QnV0dG9uIHRleHQ9IkNsb3NlIiBwcmVzcz0ib25
"DbG9zZSIvPjwvVG9vbGJhcj48L2Zvb3Rlcj4KICAgICAgICAgICAgICAgPC9EaWFsb2c+CiAgICAgICAgICAgIDwvY29yZTpGcmFnbWVudERlZmluaXRpb24+";            XMLDef = atob( XMLDef );
*            if (this.oFragment) {
*                this.oFragment.close();
*                this.oFragment.destroy();
*            }
*            this.oFragment = await Fragment.load({
*                definition: XMLDef,
*                controller: oFragmentController,
*            });
*
*            oFragmentController.oDialog = this.oFragment;
*            oFragmentController.oDialog.addStyleClass('dbg-ltr');
*
*            let value = JSON.stringify(sap.z2ui5.oResponse, null, 3);
*            debugger; let oData = {
*                type: 'json',
*                value: value,
*                activeNest1   : sap?.z2ui5?.oViewNest?.mProperties?.viewContent !== undefined,
*                activeNest2   : sap?.z2ui5?.oViewNest2?.mProperties?.viewContent !== undefined,
*                activePopup   : sap?.z2ui5?.oResponse?.PARAMS?.S_POPUP?.XML !== undefined,
*                activePopover : sap?.z2ui5?.oResponse?.PARAMS?.S_POPOVER?.XML !== undefined,
*            };
*            var oModel = new JSONModel(oData);
*            this.oFragment.setModel(oModel);
*            this.oFragment.open();
*
*        },
*
*        async init() {
*
*            document.addEventListener("keydown", function (zEvent) {
*                if (zEvent.ctrlKey ) { if ( zEvent.key === "F12") {  // case sensitive
*                    sap.z2ui5.DebuggingTools.show();
*                } }
*            });
*
*        },
*
*        renderer(oRm, oControl) {
*        },
*    });
*});  sap.ui.require(["z2ui5/DebuggingTools","z2ui5/Controller"], (DebuggingTools) => { sap.z2ui5.DebuggingTools = new DebuggingTools();
* });
  ENDMETHOD.

  METHOD z2ui5_if_mime_container~get_metadata.

    result = value #( ).

  ENDMETHOD.

ENDCLASS.
