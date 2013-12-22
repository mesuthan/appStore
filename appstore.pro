# Add more folders to ship with the application, here
folder_01.source = qml/appstore
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
DEPLOYMENT.display_name = "Store"
# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =
ICON = appstore.svg

LIBS += -lapgrfx -lswinstcli

DEFINES += QT_USE_FAST_CONCATENATION \
           QT_USE_FAST_OPERATOR_PLUS

symbian:{
TARGET.EPOCHEAPSIZE = 0x3700000 0x4100000
TARGET.CAPABILITY += ReadUserData WriteUserData WriteDeviceData ReadDeviceData NetworkServices UserEnvironment SwEvent TrustedUI #AllFiles
TARGET.UID3 = 0xE6002CD5

gccOption = "OPTION gcce -fpermissive"
MMP_RULES += gccOption
MMP_RULES += "OPTION gcce -march=armv6 -mfpu=vfp -mfloat-abi=softfp -marm"
}
# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable
QT += network
# Add dependency to Symbian components
CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
HEADERS += src/qtdownload.h src/fim.h src/download.h src/core.h

SOURCES += main.cpp src/qtdownload.cpp src/fim.cpp src/download.cpp src/core.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()



