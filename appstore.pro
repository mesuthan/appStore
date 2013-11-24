# Add more folders to ship with the application, here
folder_01.source = qml/appstore
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
DEPLOYMENT.display_name = "Store"
# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =
ICON = appstore.svg

LIBS += -lapgrfx -lswinstcli -lavkon -leikcdlg -leiksrv -lcone -leikcore -lws32 -lefsrv -lbafl -leikctl -laknnotify


DEFINES += QT_USE_FAST_CONCATENATION \
           QT_USE_FAST_OPERATOR_PLUS

symbian:{
TARGET.CAPABILITY += ReadUserData WriteUserData WriteDeviceData ReadDeviceData NetworkServices UserEnvironment SwEvent TrustedUI
TARGET.UID3 = 0xE6002CD5
rssresources = "SOURCEPATH	." \
"START RESOURCE appstore2.rss" \
"HEADER" \
"TARGETPATH resource\apps" \
"END"
MMP_RULES += rssresources
addFiles.pkg_postrules = "\"C:/QtSDK/Symbian/SDKs/SymbianSR1Qt474/epoc32/data/z/resource/apps/appstore2.rsc\" - \"!:\\resource\\apps\\appstore2.rsc\""
DEPLOYMENT += addFiles

gccOption = "OPTION gcce -fpermissive"
MMP_RULES += gccOption
}
# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable
QT += network
# Add dependency to Symbian components
CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
HEADERS += src/qtdownload.h fim.h

SOURCES += main.cpp \
           src/qtdownload.cpp fim.cpp

OTHER_FILES += nativesymbiandlg.hrh

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()


