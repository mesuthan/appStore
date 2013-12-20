/***************************************************************
****************************************************************
**Ported from QML MeeGo Components by Lucas Facchini************
****************************************************************
****************************************************************/

import QtQuick 1.1
import com.nokia.symbian 1.1


Item {
    id: root

    width: parent ? parent.width : 0
    height: parent ? parent.height : 0

    property alias title: titleBar.text
    property alias content: contentField.children
    property alias buttons: buttonRow.children
    property Item visualParent
    property bool platformInverted: false
    property bool toolBarVisible: true
    property int status: DialogStatus.Closed
    property alias acceptButtonText: acceptButton.text
    property alias rejectButtonText: rejectButton.text

    property alias acceptButton: acceptButton
    property alias rejectButton: rejectButton

    signal accepted
    signal rejected

    //property QtObject platformStyle: SheetStyle {}

    //Deprecated, TODO Remove this on w13
    //property alias style: root.platformStyle

    function reject() {
        close();
        rejected();
    }

    function accept() {
        close();
        accepted();
    }

    visible: status != DialogStatus.Closed;

    function open() {
        parent = visualParent || __findParent();
        sheet.state = "";
    }

    function close() {
        sheet.state = "closed";
    }

    function __findParent() {
        var next = parent;
        while (next && next.parent
               && next.objectName != "appWindowContent"
               && next.objectName != "windowContent") {
            next = next.parent;
        }
        return next;
    }

    function getButton(name) {
        for (var i=0; i<buttons.length; ++i) {
            if (buttons[i].objectName == name)
                return buttons[i];
        }
        return undefined;
    }

    MouseArea {
        id: blockMouseInput
        anchors.fill: parent
    }

    Item {
        id: sheet

        //when the sheet is part of a page do nothing
        //when the sheet is a direct child of a PageStackWindow, consider the status bar
        property int statusBarOffset: (typeof __isPage != "undefined") ? 0
                                     : (typeof __statusBarHeight == "undefined") ? 0
                                     :  __statusBarHeight

        width: parent.width
        height: parent.height - statusBarOffset

        y: statusBarOffset

        clip: true

        property int transitionDurationIn: 300
        property int transitionDurationOut: 450

        state: "closed"

        function transitionStarted() {
            status = (state == "closed") ? DialogStatus.Closing : DialogStatus.Opening;
        }

        function transitionEnded() {
            status = (state == "closed") ? DialogStatus.Closed : DialogStatus.Open;
        }

        states: [
            // Closed state.
            State {
                name: "closed"
                // consider input panel height when input panel is open
                PropertyChanges { target: sheet; y: !inputContext.softwareInputPanelVisible
                                                    ? height : inputContext.softwareInputPanelRect.height + height; }
            }
        ]

        transitions: [
            // Transition between open and closed states.
            Transition {
                from: ""; to: "closed"; reversible: false
                SequentialAnimation {
                    ScriptAction { script: if (sheet.state == "closed") { sheet.transitionStarted(); } else { sheet.transitionEnded(); } }
                    PropertyAnimation { properties: "y"; easing.type: Easing.InOutQuint; duration: sheet.transitionDurationOut }
                    ScriptAction { script: if (sheet.state == "closed") { sheet.transitionEnded(); } else { sheet.transitionStarted(); } }
                }
            },
            Transition {
                from: "closed"; to: ""; reversible: false
                SequentialAnimation {
                    ScriptAction { script: if (sheet.state == "") { sheet.transitionStarted(); } else { sheet.transitionEnded(); } }
                    PropertyAnimation { properties: "y"; easing.type: Easing.OutQuint; duration: sheet.transitionDurationIn }
                    ScriptAction { script: if (sheet.state == "") { sheet.transitionEnded(); } else { sheet.transitionStarted(); } }
                }
            }
        ]

        Rectangle {

            color:(platformInverted) ? "#F1F1F1" : "Black"
            width: parent.width
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            Item {
                id: contentField
                anchors.fill: parent
            }
        }

        Rectangle {
            id: header
            color:(platformInverted) ? "Black" : "Grey"
            width: parent.width
            y:(toolBarVisible) ? 25 : 1
            height:50

            Item {
                id: buttonRow
                anchors.fill: parent
                anchors.bottom:parent.bottom
                Button {
                    id: rejectButton
                    width:100
                    objectName: "rejectButton"
                    anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                    visible: text != ""
                    onClicked: close()
                    checked: true
                }
                Button {
                    id: acceptButton
                    width:100
                    objectName: "acceptButton"
                    anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
                    visible: text != ""
                    onClicked: close()
                    checked: true
                }
                Component.onCompleted: {
                    acceptButton.clicked.connect(accepted)
                    rejectButton.clicked.connect(rejected)
                }
            }
            Text {
                id: titleBar
                color:"White"; font.pointSize: 8.5;
                anchors { verticalCenter: parent.verticalCenter; left:parent.left; leftMargin: 10 }
            }
        }
    }
}
