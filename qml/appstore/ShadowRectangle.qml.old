import Qt 4.7

Item {
    property alias color : rectangle.color

    BorderImage {
        anchors.fill: rectangle
        anchors { leftMargin: -6; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "ui/shadow.png"; smooth: true
        visible:false
    }

    Rectangle { id: rectangle; anchors.fill: parent; radius: 8 }
}
