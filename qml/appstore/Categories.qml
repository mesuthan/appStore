// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Column {

    Repeater {
        id:rep
        delegate: categoriesDel
        model: CatModel {}
    }
    Component {
        id:categoriesDel
        ListItem {
           platformInverted: true
           onClicked: {rep.visible=false; cateFilter=name; window.state="CView"; headerText.text=name; catView=true  }
               Text {
                   id:catext
                   text: name
                   x:60
                   color: (invertedTheme) ? "black" : "white"
                   font.pointSize: 7.5;
                   anchors { verticalCenter: parent.verticalCenter;  }
               }
        }
    }
}
