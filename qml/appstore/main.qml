import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage
import "drive.js" as Driver

PageStackWindow {
    id: window
    initialPage: MainPage {tools: toolBarLayout}
    showStatusBar: true
    showToolBar: xmlLoaded
    property int driverse:1
    property bool metHol: true
    property bool invertedTheme: null
    platformInverted: invertedTheme
    Component.onCompleted: {
        Storage.getDatabase(); // do not remove this
        Storage.initialize(); // do not remove this
        invertedTheme = (Storage.getSetting("invertedTheme")=="Unknown") ? true : Storage.getSetting("invertedTheme");
//        Driver.getDatabase();
//        Driver.initialize();
//        driverse = (Driver.getSetting("driverr")=="Unknown") ? true : Driver.getSetting("driverr")
        Driver.gtDb()
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
    property bool storeView: true
    property bool catView: false
    property int fieldSpace: (searching) ? 50 : 0
    property bool searching: false
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
    ToolBarLayout {
        id: toolBarLayout

        ToolButton {
            flat: true
            platformInverted: invertedTheme
            iconSource: "toolbar-back"
            onClicked: {
                if(cateFilter=="") {
                if(window.pageStack.depth <= 1)  {
                           closeYesNo.open()
                       } else {
                           window.pageStack.pop()
                       }
                } else {
                    cateFilter=""
                    core.setCatFilterName("")
                }
            }
        }
        ToolButton {
            flat: true
            platformInverted: invertedTheme
            iconSource: "toolbar-list"
            onClicked: window.pageStack.push(Qt.createComponent("CategoriesPage.qml"),{invTheme:window.invertedTheme})

        }
        ToolButton {
            flat: true
            platformInverted: invertedTheme
            iconSource: "toolbar-search"
            onClicked: {
                if(searching) {
                    searching=false
                    checked=false
                }
                else
                {
                    searching=true
                    checked=true
                }
            }
            checkable: true
            checked: false
        }
        ToolButton {
            flat: true
            platformInverted: invertedTheme
            iconSource:(invertedTheme) ? "ui/settings-inv.svg" : "ui/settings.svg"
            onClicked: window.pageStack.push(Qt.resolvedUrl("ConfigPage.qml"))
        }
    }

    Connections {
        id:connector
        target: core
        onCategorieChanged: {
            cateFilter = core.getCatFilterName()
        }
        }
}
