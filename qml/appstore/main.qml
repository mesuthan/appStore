import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1
import "storage.js" as Storage
PageStackWindow {
    id: window
    showStatusBar: true
    showToolBar: false
    property bool invertedTheme: null
    platformInverted: invertedTheme
    Component.onCompleted: {
        invertedTheme = (Storage.getSetting("invertedTheme")=="Unknown") ? true : Storage.getSetting("invertedTheme")  // Default = (true)
    }
    property bool downloading: false
    property bool finished: false
    property bool cancel: false
    property int headerheight: 70
    property int itemHeight: 80
    property bool xmlLoaded: false
    property bool xmlError: false
    property string cateFilter: ""
    property bool categoriesView: false
    property string searchString: ""
    property bool showDownBar:true
    property bool storeView: true
    property bool catView: false
    function xmlErrorF() { retryButton.visible=true; errorText.visible=true;  model.source=""; xmlLoaded=false; xmlError=true}
    function retry() { retryButton.visible=false; errorText.visible=false;  model.source="http://storeage.eu.pn/data.xml"; xmlError=false }
//------------------------------PAGE---------------------------//
    Flickable {
        id: rosterView
        anchors { fill: parent; topMargin: 25;}
        contentWidth: columnContent.width
        clip:true
        contentHeight:(repeater.count*itemHeight)+headerheight+toolbar.height
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.VerticalFlick
        Sheet {
            id:sheet
            acceptButtonText: "Save"
            toolBarVisible: true
            title:"Options"
            platformInverted: invertedTheme
            content: ConfigAboutPage { }
            onAccepted: { Storage.initialize(); Storage.setSetting("invertedTheme",invertedTheme) }
        }

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
                        MouseArea {
                            anchors.fill:parent
                            onClicked: {
                                sheet.open()
                            }
                        }
                    }
                    TextField {
                        id: searchField
                        width:parent.width-80
                        height:50
                        onTextChanged: {
                            searchString=searchField.text
                        }
                        anchors { top:parent.top;  topMargin: 10; right:parent.left }
                        placeholderText: "Search Here"
                    }
                    ToolButton{
                        id:catButton
                        iconSource: "toolbar-list"
                        platformInverted: invertedTheme
                        visible:(catView) ? false : (categoriesView) ? false : true
                        onClicked: {
                            window.state="Categories"
                            storeView=false
                            categoriesView=true
                        }
                        anchors { right:parent.right; verticalCenter: parent.verticalCenter; }
                    }
                    ToolButton {
                        id:catBack
                        anchors { left:parent.left; verticalCenter: parent.verticalCenter; }
                        visible:true
                        platformInverted: invertedTheme
                        iconSource:"toolbar-back"
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
                                storeView=true
                                return
                            }
                            if(window.state == "Search") {
                                window.state="Store"
                                searchString=""
                            }

                            else {
                                //Qt.quit()
                                closeYesNo.open();
                            }
                        }
                    }
                }
        }
        QueryDialog {
            id:closeYesNo
            titleText: "Warning"
            message: "Are you sure do you want to close the Store?"
            acceptButtonText: "Close"
            rejectButtonText: "Back"
            platformInverted: invertedTheme
            onAccepted: {
                Qt.quit()
            }
            onRejected: {
                close();
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
            anchors { left: parent.right; top: header.bottom; bottom:parent.bottom }
            //visible:false
        }
    }
//-----------------------------DELEGATE----------------------------------------//

    Component {
        id: recipeDelegate

        ListItem {
            id: recipe
            height: itemHeight
            visible: {
                if(window.state=="Search") {
                    var patt = searchString.toLowerCase()
                    var t = title
                    if(patt.toLocaleLowerCase().indexOf(title.toLowerCase()) != -1)
                    {
                        return true;

                    }
                    else
                    {
                        return false;
                    }
                } else {
                    return (!cateFilter=="") ? (cat==cateFilter) ? true : false : true
                }
            }
                //(!cateFilter=="") ? (cat==cateFilter) ? true : false : true
            platformInverted: invertedTheme
            onClicked: {
                recipe.state = 'Details';
                showDownBar=false
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
                    showDownBar=true
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
                    //clip:true // this is needed
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
                    platformInverted: invertedTheme
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
                    platformInverted: invertedTheme
                    onClicked: {
                        infoText.visible=true
                        screenShot.visible=false
                    }
                }
                TabButton{
                    id:review
                    text: "More"
                    height: 50
                    platformInverted: invertedTheme
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
                        color: (invertedTheme) ? "black" : "white"
                    }
                    Image {
                        id:screenShot
                        source:screenshot
                        Behavior on visible { PropertyAnimation { duration: 150 } }
                        //width: 330
                        visible:false
                        BusyIndicator{
                            platformInverted: invertedTheme
                            anchors.centerIn: parent
                            visible:screenShot.progress<1.0
                            running:screenShot.progress<1.0
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
                PropertyChanges { target: buttonRow; opacity: 1 }  //this doesn't slow down the interface
                PropertyChanges { target: detailFlick; interactive:true;opacity:1 }

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
                //AnchorChanges { target: header; anchors.right: parent.left }
                AnchorChanges { target: searchField; anchors.horizontalCenter: parent.horizontalCenter }
                AnchorChanges { target: searchField; anchors.right:null }
                AnchorChanges { target: toolbar; anchors.top: parent.bottom }
                AnchorChanges { target: toolbar; anchors.bottom: null }
        }
    ]
    transitions: Transition {
        ParallelAnimation {
            AnchorAnimation { duration: 200; }
        }
    }
    ToolBar {
        id:toolbar
        platformInverted: invertedTheme
        anchors.bottom:parent.bottom
        visible:xmlLoaded && showDownBar
        Behavior on visible { PropertyAnimation { duration:200 }  }
        opacity:0.95
        tools:ToolBarLayout {
            ButtonRow {
                checkedButton: null
                ToolButton {
                    iconSource:"toolbar-list"
                    onClicked: {
                        window.state="Categories"
                        storeView=false
                        categoriesView=true
                    }
                }
                ToolButton {
                iconSource: "toolbar-search"
                onClicked: {
                    window.state = "Search"
                }
                }
            }
            ToolButton {
                iconSource:"toolbar-menu"

            }
        }
    }
}
