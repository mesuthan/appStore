import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1

PageStackWindow {
    id: window
    showStatusBar: true
    showToolBar: false
    platformInverted: true
    property bool downloading: false
    property bool finished: false
    property bool cancel: false
    property int headerheight: 70
    property int itemHeight: 80
    property bool xmlLoaded: false
    property bool xmlError: false
    property string cateFilter: ""
//---------------VIEWS-------------------//
    property bool categoriesView: false
    property bool storeView: false
    property bool catView: false
    function xmlErrorF() { retryButton.visible=true; errorText.visible=true;  model.source=""; xmlLoaded=false; xmlError=true}
    function retry() { retryButton.visible=false; errorText.visible=false;  model.source="http://storeage.eu.pn/data.xml"; xmlError=false }

//------------------------------PAGE---------------------------//
    Flickable {
        id: rosterView
        anchors { fill: parent; topMargin: 25;}
        contentWidth: columnContent.width
        clip:true
        contentHeight:(repeater.count*itemHeight)+headerheight
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.VerticalFlick
        Rectangle {
            id:header
            color:"black"
            anchors.top:parent.top
            width:parent.width
            height:headerheight
            visible:xmlLoaded
                Rectangle {
                    id:header2;
                    radius: 10
                    visible:true
                    height: headerheight;
                    width: parent.width;
                    anchors.top:parent.top
                    color:"#F1F1F1"
                    Rectangle {
                        height:14
                        color:"#F1F1F1"
                        width:header.width
                        anchors { bottom:parent.bottom }
                        Rectangle {
                            anchors {
                                bottom:parent.bottom
                            }
                            color:"grey"
                            height:2
                            width:header.width
                        }
                    }

                    Text {
                        id:headerText
                        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; }
                        text: "Store"; font.pointSize: 9;
                    }
                    ToolButton{
                        id:catButton
                        iconSource: "toolbar-list"
                        platformInverted: true
                        visible:(catView) ? false : (categoriesView) ? false : true
                        onClicked: {
                            window.state="Categories"
                            categoriesView=true
                        }
                        anchors { right:parent.right; verticalCenter: parent.verticalCenter; }
                    }
                    ToolButton {
                        id:catBack
                        anchors { left:parent.left; verticalCenter: parent.verticalCenter; }
                        visible:true
                        platformInverted: true
                        iconSource: "toolbar-back"
                        onClicked: {
                            if(catView) {
                                window.state="Categories"
                                catView=false
                                return
                            }

                            if(categoriesView) {
                                window.state="Store"
                                categoriesView=false
                                catView=false
                                cateFilter=""
                                return
                            }

                            else {
                                Qt.quit()
                            }
                        }
                    }
                }
        }

//------------------------ALL-APP-LIST--------------------------------//
        Column {
                id: columnContent
                anchors { top: header.bottom; bottom:parent.bottom }
                Behavior on y { PropertyAnimation {} }
                Repeater {
                    id:repeater
                    delegate: recipeDelegate
                    model:model
                }
            }
        Categories {
            id:catColumn
            anchors { top: header.bottom; bottom:parent.bottom }
            visible:false
        }
    }
//-----------------------------DELEGATE----------------------------------------//

    Component {
        id: recipeDelegate

        ListItem {
            id: recipe
            height: itemHeight
            visible: (!cateFilter=="") ? (cat==cateFilter) ? true : false : true
            platformInverted: true
            onClicked: {
                recipe.state = 'Details';
            }
            Item {
                id: background
                x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
            }
            Button {
                y: 10
                id:backBnt
                enabled:(downloading) ? false : true
                anchors { right: parent.right; rightMargin: 10 }
                visible:false
                text: "Back"
                platformInverted: true
                onClicked: {
                    recipe.state = '';
                    if(finished) {
                    finished=false;
                    dlhelper.delFile(sis);
                    }
                }
            }
            ToolButton {
                id:dButton
                width: 135
                height: 51
                //enabled: (downloading) ? false : true
                visible:false
                text:(!finished) ? (!downloading) ? "Download" : "Cancel" : "Install"
                platformInverted: true
                onClicked:{
                    if(text=="Cancel") {
                        dlhelper.cancelDownload();
                    }
                    if(!downloading) {
                        if(!finished) {
                        downloading=true
                            if(!link){
                                dlhelper.setTarget(sis);
                                dlhelper.download();
                            }else{
                                dlhelper.setLink(link);
                                dlhelper.download();
                            }
                        } else {
                            dlhelper.installDownload(sis)
                            finished=false
                        }
                    }
                }

                anchors {
                    top:backBnt.bottom; topMargin: 5
                    right: parent.right; rightMargin: 10
                }

                BusyIndicator {
                    id:busyind

                    anchors {
                        right: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                    running: (downloading) ? true : false
                    visible: (downloading) ? true : false
                }

            }

            Row {
                id: topLayout
                x: 10; y: 15;  height: appIcon.height; width: parent.width;
                spacing: 10
                Image {
                    id: appIcon
                    width: 50; height: 50
                    source: picture
                    clip:true // this is needed
                }
                Text {
                    id:appName
                    text: title
                    font.pointSize: 7.5;
                    anchors { verticalCenter: appIcon.verticalCenter; verticalCenterOffset: -10 }
                    Text {
                        id:category
                        text: cat
                        font.pointSize: 6;
                        color:"#737373"
                        anchors { verticalCenter: parent.verticalCenter; verticalCenterOffset: 23 }
                    }
                }

            }
            Column {
                spacing: 0
                id: details
                width: parent.width - 20
                anchors { top: topLayout.bottom;  left:parent.left; leftMargin: 15}
                opacity: 0
                Text {
                 id: appDev
                 text:"By "+dev
                 color:"#737373"
                 font.pointSize: 6; font.bold: true
                }
                Text {
                    id:ver
                    text: "Version: " + version
                    font.pointSize: 6; font.bold: false
                     color:"#737373"
                }

            }
            ButtonRow {
                id:buttonRow
                width: 330
                anchors { top: details.bottom; topMargin: 10; horizontalCenter: parent.horizontalCenter }
//                visible:false
                opacity:0
                onOpacityChanged: {
                    checkedButton=dtl
                    infoText.visible=true
                    screenShot.visible=false
                }

                TabButton{
                    id:screens
                    text: "Screens"
                    platformInverted: true
                    visible: (screenshot) ? true : false
                    height: 50
                    onClicked: {
                        infoText.visible=false
                        screenShot.visible=true
                    }
                }
                TabButton{
                    id:dtl
                    text: "Details"
                    height: 50
                    platformInverted: true
                    onClicked: {
                        infoText.visible=true
                        screenShot.visible=false
                    }
                }
                TabButton{
                    id:review
                    text: "More"
                    height: 50
                    platformInverted: true
                    visible: (more) ? true : false
                    onClicked: {
                        infoText.visible=false
                        screenShot.visible=false
                    }
                }
            }
            Flickable {
                id:detailFlick
                contentHeight: (infoText.visible) ? infoText.height : screenShot.height+50
                clip: true
                opacity:0
                interactive: false
                flickableDirection: Flickable.VerticalFlick
                anchors { top: details.bottom; topMargin: 60;  left:parent.left; leftMargin: 15; bottom:parent.bottom; right:parent.right; rightMargin: 15}
                    Text {
                        id:infoText
                        text:dtltext
                        wrapMode: Text.Wrap
                        Behavior on visible { PropertyAnimation { duration: 150 } }
                        width:330
                    }
                    Image {
                        id:screenShot
                        source:screenshot
                        Behavior on visible { PropertyAnimation { duration: 150 } }
                        //width: 330
                        visible:false
                    }
            }

            states:
                State {
                name: "Details"
                PropertyChanges { target: recipe; enabled: false }
                PropertyChanges { target: recipe; height: window.height }
                PropertyChanges { target: rosterView; explicit: true; contentY: recipe.y+header.height }
                PropertyChanges { target: details; opacity: 1; x: 0 }
                PropertyChanges { target: rosterView; interactive: false }
                PropertyChanges { target: dButton; visible:true }
                PropertyChanges { target: backBnt; visible:true }
                PropertyChanges { target: buttonRow; opacity: 1 }  //this doesn't slow down the interface
                PropertyChanges { target: detailFlick; interactive:true;opacity:1 }
            }


            transitions: Transition {
                ParallelAnimation {
                    NumberAnimation { duration: 200; properties: "height,contentY,opacity" }
                }
            }
        }
    }
//---------------------END-DELEGATE--------------------------//

    Connections {
        id:connector
        target: dlhelper
        onDone: {
            finished = true
            downloading=false
        }
        onTam: {
            infobanner1.open();
        }
        onCancelled:
        {
            finished=false;
            downloading=false;
        }

    }
    Item {
        id:loader
        anchors { horizontalCenter: parent.horizontalCenter
                  verticalCenter: parent.verticalCenter
        }
        ProgressBar {
            id: progressbar
            anchors.verticalCenterOffset: 80
            anchors { horizontalCenter: parent.horizontalCenter
                      verticalCenter: parent.verticalCenter
            }
            visible: (model.progress<1) ? true : false
            indeterminate: true

        }
        Text {
            id:errorText
            visible:xmlError
            text:"<p>There was a problem opening the Store.</p>
                   <p> Check your connection and try again.</p>"
            anchors { horizontalCenter: parent.horizontalCenter
                      verticalCenter: parent.verticalCenter
                      verticalCenterOffset: 80
            }
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 6
        }
        Button {
            id:retryButton
            platformInverted: true
            text:"Retry"
            visible: xmlError
            anchors { horizontalCenter: parent.horizontalCenter; top:logo.bottom; topMargin:100 }
            onClicked: {
                retry()
            }
        }
        BorderImage {
            id: logo
            visible:(xmlError) ? true : (xmlLoaded) ? false : true
            anchors { verticalCenterOffset: -50; verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
            source: "ui/appstore.png"
        }
    }

//---------------------------MODEL-------------------------//
    ListModel {
        id:categoriesModel
        ListElement { name: "Network" }
        ListElement { name: "Utilities" }
        ListElement { name: "Games" }
        ListElement { name: "Clear" }
    }

    XmlListModel {
         id: model
         source:"http://storeage.eu.pn/data.xml"
         query: "/catalogue/book"
         XmlRole { name: "title"; query: "title/string()" }
         XmlRole { name: "picture"; query: "picture/string()"}
         XmlRole { name: "sis"; query: "sis/string()"}
         XmlRole { name: "screenshot"; query: "screenshot/string()"}
         XmlRole { name: "link"; query: "link/string()"}
         XmlRole { name: "version"; query: "version/string()"}
         XmlRole { name: "dtltext"; query: "dtltext/string()"}
         XmlRole { name: "dev"; query: "dev/string()" }
         XmlRole { name: "cat"; query: "cat/string()" }
         XmlRole { name: "more"; query: "more/string()" }
         onStatusChanged: {
             switch (status) {
             case XmlListModel.Error:  xmlErrorF();
             case XmlListModel.Ready:  xmlLoaded=(xmlError) ? false: true
             }
        }
    }

    InfoBanner {
        id: infobanner1
        timeout: 2500
        onClicked: {
            infobanner1.close();
        }
        text: "Application installed."
        iconSource: "ui/done.png"
    }
    states: [
        State {
                name:"Categories"
                PropertyChanges { target:columnContent; visible:false }
                PropertyChanges { target: catColumn;  visible:true }
                PropertyChanges { target: headerText;   text:"Categories" }
            },
        State {
                name:"Store"
                PropertyChanges { target: catColumn;  visible:false }
                PropertyChanges { target: headerText;   text:"Store" }
                PropertyChanges { target: columnContent;  visible:true }
            },
        State {
                name:"CView"
                PropertyChanges { target: catColumn;  visible:false }
                PropertyChanges { target: columnContent;  visible:true }
            }
    ]
    transitions: Transition {
        ParallelAnimation {
            PropertyAnimation { duration: 100; properties: "visible" }
        }
    }
}
