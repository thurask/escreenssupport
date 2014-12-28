/*EScreens.qml
 -------------
 Generates a code for the escreens app (take that, Javascript!). Invoke the escreens app.
 
 --Thurask*/

import bb.cascades 1.4
import bb.device 1.4
import "js/escreens.js" as Escreens

Page {
    actions: [
        ActionItem {
            title: qsTr("Get Key") + Retranslate.onLanguageChanged
            onTriggered: {
                var regex_pin = RegExp(/\b[0-9a-f]{8}\b/)
                var regex_appv = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/)
                var regex_uptime = RegExp(/\b\d{1,}\b/)
                if (regex_pin.test(pin.text) == true && regex_appv.test(appv.text) == true && regex_uptime.test(uptime.text) == true){
                    Escreens.newHMAC();
                }
            }
            ActionBar.placement: ActionBarPlacement.Signature
        }
    ]
    attachedObjects: [
        Invocation {
            id: myQuery
            query {
                uri: ("escreen://")
                invokeActionId: "bb.action.OPEN"
                onQueryChanged: {
                    myQuery.query.updateQuery()
                }
            }
        },
        HardwareInfo {
            id: hwinfo
        }
    ]
    Container {
        topPadding: 20.0
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            topPadding: 5.0
            TextField {
                id: pin
                hintText: qsTr("PIN") + Retranslate.onLanguageChanged
                onTextChanging: {
                    pin.text = pin.text.toLowerCase()
                }
                validator: Validator {
                    id: validator_pin
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex_pin = RegExp(/\b[0-9a-f]{8}\b/)
                        if (regex_pin.test(pin.text) == true) {
                            validator_pin.setValid(true);
                        }
                        else {
                            validator_pin.setValid(false);
                        }
                    }
                }
            }
            Button {
                text: qsTr("Load PIN") + Retranslate.onLanguageChanged
                onClicked: {
                    pin.text = hwinfo.pin.slice(2)
                }
            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            topPadding: 5.0
            TextField {
                id: appv
                hintText: qsTr("App Version") + Retranslate.onLanguageChanged
                validator: Validator {
                    id: validator_appver
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex_appv = RegExp(/\b\d{1,4}\.\d{1,4}\.\d{1,4}\.\d{1,4}\b/)
                        if (regex_appv.test(appv.text) == true) {
                            validator_appver.setValid(true);
                        }
                        else {
                            validator_appver.setValid(false);
                        }
                    }
                }
            }
            Button {
                text: qsTr("Load App Version") + Retranslate.onLanguageChanged
                onClicked: {
                    appv.text = _manager.readTextFile("/base/etc/os.version", "normal")
                }
            }
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            topPadding: 5.0
            TextField {
                id: uptime
                hintText: qsTr("Uptime") + Retranslate.onLanguageChanged
                validator: Validator {
                    id: validator_uptime
                    mode: ValidationMode.Immediate
                    onValidate: {
                        var regex_uptime = RegExp(/\b\d{1,}\b/)
                        if (regex_uptime.test(uptime.text) == true) {
                            validator_uptime.setValid(true);
                        }
                        else {
                            validator_uptime.setValid(false);
                        }
                    }
                }
                function returnUptime() {
                    var now = new Date();
                    var dmy = new Date(_manager.readTextFile("/var/boottime.txt", "normal"));
                    uptime.text = (now.getTime() - dmy.getTime());
                }
            }
            Button {
                text: qsTr("Open EScreens") + Retranslate.onLanguageChanged
                onClicked: {
                    myQuery.trigger(myQuery.query.invokeActionId);
                }
            }//Load uptime button isn't the same as the actual escreens uptime, but I'm too proud of it to let it go
            /*Button {
             text: qsTr("Load Uptime") + Retranslate.onLanguageChanged
             onClicked: {
             uptime.returnUptime();
             }
             }*/
        }
        
        DropDown {
            id: validity
            title: qsTr("Validity") + Retranslate.onLanguageChanged
            options: [
                Option {
                    text: qsTr("1 day") + Retranslate.onLanguageChanged
                    value: ""
                },
                Option {
                    text: qsTr("3 days") + Retranslate.onLanguageChanged
                    value: "%55%72%79%79%62%20%7A%6C%20%6F%6E%6F%6C%2C%20%75%72%79%79%62%20%7A%6C%20%75%62%61%72%6C%2C%20%75%72%79%79%62%20%7A%6C%20%65%6E%74%20%67%76%7A%72%20%74%6E%79"
                },
                Option {
                    text: qsTr("7 days") + Retranslate.onLanguageChanged
                    value: "%55%72%20%6A%6E%66%20%6E%20%6F%62%6C%2C%20%6E%61%71%20%66%75%72%20%6A%6E%66%20%6E%20%74%76%65%79%2C%20%70%6E%61%20%56%20%7A%6E%78%72%20%76%67%20%6E%61%6C%20%7A%62%65%72%20%62%6F%69%76%62%68%66%3F"
                },
                Option {
                    text: qsTr("15 days") + Retranslate.onLanguageChanged
                    value: "%46%62%20%6E%7A%20%56%2C%20%66%67%76%79%79%20%6A%6E%76%67%76%61%74%2C%20%73%62%65%20%67%75%76%66%20%6A%62%65%79%71%20%67%62%20%66%67%62%63%20%75%6E%67%76%61%74%3F"
                },
                Option {
                    text: qsTr("30 days") + Retranslate.onLanguageChanged
                    value: "%56%20%79%62%69%72%20%7A%6C%66%72%79%73%20%67%62%71%6E%6C%2C%20%61%62%67%20%79%76%78%72%20%6C%72%66%67%72%65%71%6E%6C%2E%20%56%27%7A%20%70%62%62%79%2C%20%56%27%7A%20%70%6E%79%7A%2C%20%56%27%7A%20%74%62%61%61%6E%20%6F%72%20%62%78%6E%6C"
                    selected: true
                }]
        }
        Label {
            id: ykey
            text: qsTr("Your Key") + Retranslate.onLanguageChanged
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontSize: FontSize.XXLarge
        }
    }
}