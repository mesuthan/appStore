import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage

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
        }
}


