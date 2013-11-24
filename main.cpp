#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "src/qtdownload.h"
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
#include <QtDeclarative/QDeclarativeEngine>
#include <QDebug>
#include <QtDeclarative>
#include <QCoreApplication>

#include <eikenv.h>
#include <eikapp.h>
#include <eikappui.h>

void loadResFile(const QString& Name)
{
    TPtrC resFileNameDescriptor (reinterpret_cast<const TText*>(Name.constData()), Name.length());
    _LIT(KResourcePath, "c:\\resource\\apps\\");
    TFileName appNamePath = CEikonEnv::Static()->EikAppUi()->Application()->AppFullName();
    TFileName resFile(KResourcePath);
    resFile[0] = appNamePath[0];
    resFile.Append(resFileNameDescriptor);
    QT_TRAP_THROWING(CCoeEnv::Static()->AddResourceFileL(resFile));
}
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QApplication::setGraphicsSystem("raster");
    loadResFile("appstore2.rsc");
    QmlApplicationViewer viewer;
    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.setAttribute(Qt::WA_LockPortraitOrientation);
    QtDownload dl;
    viewer.rootContext()->setContextProperty("dlhelper",&dl);


    viewer.setMainQmlFile(QLatin1String("qml/appstore/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
