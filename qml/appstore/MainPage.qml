import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1


Page {
    id: window
    function xmlErrorF() { retryButton.visible=true; errorText.visible=true;  model.source=""; xmlLoaded=false; xmlError=true}
    function retry() { retryButton.visible=false; errorText.visible=false;  model.source="http://storeage.eu.pn/data.xml"; xmlError=false }
    function updateViewContentHeight() { rosterView.contentHeight=(repeater.count*itemHeight)+headerheight; }
//------------------------------PAGE---------------------------//
    Flickable {
        id: rosterView
        anchors { fill: parent; }
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
                    color:(!invertedTheme) ? "grey" : "#F1F1F1"
                    Rectangle {
                        height:16
                        color:(!invertedTheme) ? "grey" :"#F1F1F1"
                        width:header.width
                        anchors { bottom:parent.bottom }
                        Rectangle {
                            id:divider
                            anchors {
                                bottom:parent.bottom
                            }
                            color: "grey"
                            visible:invertedTheme
                            height:2
                            width:header.width
                        }
                    }

                    Text {
                        id:headerText
                        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; }
                        text: "Store"; font.pointSize: 9;
                        color: (invertedTheme) ? "black" : "white"
                    }
                }
        }

        TextField {
            id: searchField
            width:parent.width
            height:fieldSpace
            Behavior on height { NumberAnimation { duration:200 } }
            anchors {bottom:columnContent.top; top:header.bottom }
            placeholderText: "Search Here"
            onTextChanged: {
                searchString=text
            }
        }
//------------------------ALL-APP-LIST--------------------------------//
        Column {
                id: columnContent
                anchors { top: header.bottom; bottom:parent.bottom; topMargin: fieldSpace }
                Behavior on y { PropertyAnimation {} }
                Repeater {
                    id:repeater
                    delegate: recipeDelegate
                    model:model
                }
            }

    }
//-----------------------------DELEGATE----------------------------------------//

    Component {
        id: recipeDelegate

        ListItem {
            id: recipe
            height: itemHeight
            /*onVisibleChanged: {
                console.log("visibility changed")
                updateViewContentHeight();
            }*/

            visible: {
                if(searching==true) {
                    var patt = searchString.toLowerCase()
                    if(patt.toLowerCase().indexOf(title.toLowerCase()))
                    {
                        return false;

                    }
                    else
                    {
                        return true;
                    }
                } else {
                    return (!cateFilter=="") ? (cat==cateFilter) ? true : false : true;
                }
            }
            platformInverted: invertedTheme
            onClicked: {
                recipe.state = 'Details';
                searching=false
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
                platformInverted: invertedTheme
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
                platformInverted: invertedTheme
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

                            core.sisInstallGUI(sis);  // this way is better
                            //dlhelper.installDownload(sis) than this
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
                    BusyIndicator{
                        anchors.centerIn: parent
                        platformInverted: invertedTheme
                        visible:appIcon.progress<1.0
                        running:appIcon.progress<1.0
                    }
                }
                Text {
                    id:appName
                    text: title
                    font.pointSize: 7.5;
                    anchors { verticalCenter: appIcon.verticalCenter; verticalCenterOffset: -10 }
                    color: (invertedTheme) ? "black" : "white"
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
            Flickable {
                id:detailFlick
                contentHeight: infoText.height+screenShot.height
                clip: true
                opacity:0
                interactive: false
                flickableDirection: Flickable.VerticalFlick
                anchors { top: details.bottom; topMargin: 10;  left:parent.left; leftMargin: 15; bottom:parent.bottom; right:parent.right; rightMargin: 15}
                Column {
                    Text {
                        id:infoText
                        text:dtltext
                        wrapMode: Text.Wrap
                        width:330
                        color: (invertedTheme) ? "black" : "white"
                    }
                    Image {
                        id:screenShot
                        source:screenshot
                        visible:(screenshot) ? true : false
                        height:(screenshot) ? 600 : 0
                        width:330
                        BusyIndicator {
                            platformInverted: invertedTheme
                            anchors.centerIn: parent
                            visible:screenShot.progress<1.0
                            running:screenShot.progress<1.0
                        }
                    }
                }
            }

           states: [
                State {
                name: "Details"
                PropertyChanges { target: recipe; enabled: false }
                PropertyChanges { target: recipe; height: window.height }
                PropertyChanges { target: rosterView; explicit: true; contentY: recipe.y+header.height }
                PropertyChanges { target: details; opacity: 1; x: 0 }
                PropertyChanges { target: rosterView; interactive: false }
                PropertyChanges { target: dButton; visible:true }
                PropertyChanges { target: backBnt; visible:true }
                //PropertyChanges { target: buttonRow; opacity: 1 }  //this doesn't slow down the interface
                PropertyChanges { target: detailFlick; interactive:true;opacity: 1 }

            }
            ]
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
            infobanner.open();
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
            color: (invertedTheme) ? "black" : "white"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 6
        }
        Button {
            id:retryButton
            platformInverted: invertedTheme
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
        id: infobanner
        timeout: 2500
        onClicked: {
            infobanner.close();
        }
        text: "Application installed."
        iconSource: "ui/done.png"
    }
    states: [
        State {
                name:"Categories" //categories view
                AnchorChanges { target:columnContent; anchors.right:parent.left }
                AnchorChanges { target:catColumn; anchors.left:parent.left }
                PropertyChanges { target: headerText;   text:"Categories" }
            },
        State {
                name:"Store" // default view
                PropertyChanges { target: headerText;   text:"Store" }
            },
        State {
                name:"CView" //showing the categories
                PropertyChanges { target: catColumn;  visible:false }
            },
        State {
                name: "Search"
                PropertyChanges {
                    target: searchField
                    height:40
                }

        }
    ]
    transitions: Transition {
        ParallelAnimation {
            AnchorAnimation { duration: 200; }
            PropertyAnimation { duration: 200; properties: "height" }
        }
    }

}
