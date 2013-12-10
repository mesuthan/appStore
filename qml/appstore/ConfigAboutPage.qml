// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage

Item {
Column {
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


