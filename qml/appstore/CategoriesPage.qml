// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1


Page {
    id:page
    tools:
        ToolBarLayout {
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: window.pageStack.depth <= 1 ? Qt.quit() : window.pageStack.pop()
        }
    }
    property bool invTheme: null


Column {
    ListHeading {
        id:header
        ListItemText {
            text: "Categories"
        }
    }
    Repeater {
        id:rep

        delegate: categoriesDel
        model: XmlListModel {
            id: model
            source:"http://storeage.eu.pn/categories.xml"
            query: "/catalogue/book"
            XmlRole { name: "name"; query: "name/string()" }
            XmlRole { name: "picture"; query: "picture/string()"}
       }

    }

    Component {
        id:categoriesDel
        ListItem {
           height: 60
           platformInverted: invTheme
           onClicked: {
               page.pageStack.pop()
               core.setCatFilterName(name)
           }
               Text {
                   id:catext
                   text: name
                   color: (invTheme == true) ? "black" : "white"
                   x:60
                   font.pointSize: 7.5;
                   anchors { verticalCenter: parent.verticalCenter;  }
               }
        }
    }
}
}
