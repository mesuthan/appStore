import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage
import com.nokia.extras 1.1
import "drive.js" as Driver

Page {
    tools:
        ToolBarLayout {
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
    }
    property string dri
    property int say:driverse
    Component.onCompleted: {Driver.gtDb();tumblercolumn1.selectedIndex=driverse;closeDialog.close();ist();istaa();update();mettp.close();}
    function drivechan() {
        var syh = tumblercolumn1.selectedIndex;
        if(syh==0)dri="C"
        if(syh==1)dri="E"
        if(syh==2)dri="F"
        console.debug("aaaaaaaaccccccccccc:::"+dri);
        Driver.drivese(dri,driverse);
        ttdr.text = dri;
    }
    function update() {
        var itemsay = driverse;
        var itemdriv = dri;
        Driver.updateDrvSay(itemdriv,itemsay)
    }
    function ist() {
        say = Driver.frkd(say);
        tumblercolumn1.selectedIndex=say;
    }
    function istaa() {
        var syh = tumblercolumn1.selectedIndex;
        if(syh==0)dri="C"
        if(syh==1)dri="E"
        if(syh==2)dri="F"
        Driver.drkd(dri);
        ttdr.text = dri;
        dlhelper.path(dri);
    }
    Column {
        id:column
        anchors.fill: parent
        ListHeading {
            id:header
            ListItemText {
                text: "Configs"
            }
        }
        ListItem {
            id: themeitem
            subItemIndicator: true
            platformInverted: invertedTheme
            ListItemText {
                id:theme
                text: "Theme:"
                x:15
                platformInverted: invertedTheme
                anchors {
                    verticalCenter: parent.verticalCenter
                    }
                }
                onClicked: {
                if(invertedTheme) {
                    invertedTheme=false
                } else {
                    invertedTheme=true
                }
            }
            Text {
                anchors { right: themeitem.right; verticalCenter: parent.verticalCenter; rightMargin: 50 }
                text: (invertedTheme) ? "Radiance" : "Evolve"
                color: (invertedTheme) ? "grey" : "#737373"
            }
            }
        ListItem {
                    id: ecfdrv
                    subItemIndicator: true
                    platformInverted: invertedTheme
                    ListItemText {
                        id:ecf
                        text: "Drive:"
                        x:15
                        platformInverted: invertedTheme
                        anchors {
                            verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                        closeDialog.open()
                    }
                    Text {
                        id:ttdr
                        anchors { right: ecfdrv.right; verticalCenter: parent.verticalCenter; rightMargin: 50 }
                        color: (invertedTheme) ? "grey" : "#737373"
                    }
                    }
        ListItem {
                    id: method
                    subItemIndicator: true
                    platformInverted: invertedTheme
                    ListItemText {
                        id:mth
                        text: "Optional Installer:"
                        x:15
                        platformInverted: invertedTheme
                        anchors {
                            verticalCenter: parent.verticalCenter
                            }
                        }
                        onClicked: {
                        mettp.open()
                    }
                    Text {
                        id:textm
                        anchors { right: method.right; verticalCenter: parent.verticalCenter; rightMargin: 50 }
                        text: (metHol) ? "GUI" : "Silent"
                        color: (invertedTheme) ? "grey" : "#737373"
                    }
                    }
                }
            ListModel { id: drivet
                        ListElement {value: "C";}
                        ListElement {value: "E";}
                        ListElement {value: "F";}
                }
                TumblerColumn {
                        id: tumblercolumn1
                        items: drivet

                    }
                CommonDialog {
                           id: closeDialog
                           smooth: true
                           clip: true
                           titleText: "Select Drive"
                           buttonTexts: ["OK"]
                           content:
                               Tumbler {
                                   id: tumbler1
                                   visible:true
                                   x: 15
                                   columns: [tumblercolumn1]
                               }

                           platformInverted: invertedTheme

                           onButtonClicked: {
                               if(index === 0){
                                   if(tumblercolumn1.selectedIndex==0)
                                   {driverse=0;dlhelper.path("C");drivechan();}
                                   if(tumblercolumn1.selectedIndex==1)
                                   {driverse=1;dlhelper.path("E");drivechan();}
                                   if(tumblercolumn1.selectedIndex==2)
                                   {driverse=2;dlhelper.path("F");drivechan();}
                                   update();
                                }
                            }
                }
                ListModel { id: mtdn
                            ListElement {value: "GUI";}
                            ListElement {value: "Silent";}
                    }
                    TumblerColumn {
                            id: tumblercolumn3
                            items: mtdn

                        }
                    CommonDialog {
                               id: mettp
                               smooth: true
                               clip: true
                               titleText: "Select"
                               buttonTexts: ["OK"]
                               content:
                                   Tumbler {
                                       id: tumbler3
                                       visible:true
                                       x: 15
                                       columns: [tumblercolumn3]
                                   }

                               platformInverted: invertedTheme

                               onButtonClicked: {
                                   if(index === 0){
                                       if(tumblercolumn3.selectedIndex==0)
                                       {metHol = true}
                                       if(tumblercolumn3.selectedIndex==1)
                                       {metHol = false}
                                    }
                                }
                    }
}


