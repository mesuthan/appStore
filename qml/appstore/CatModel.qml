// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

XmlListModel {
     id: model
     source:"http://storeage.eu.pn/categories.xml"
     query: "/catalogue/book"
     XmlRole { name: "name"; query: "name/string()" }
     XmlRole { name: "picture"; query: "picture/string()"}
}
