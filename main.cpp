#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "src/qtdownload.h"
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
#include <QtDeclarative/QDeclarativeEngine>
#include <QDebug>
#include <QtDeclarative>
#include <QCoreApplication>
#include <core.h>
#include <download.h>
//#include <fim.h>
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QApplication::setGraphicsSystem("raster");
    QmlApplicationViewer viewer;
    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
    viewer.setAttribute(Qt::WA_NoSystemBackground);
    viewer.setAttribute(Qt::WA_LockPortraitOrientation);
    QtDownload dl;
    viewer.rootContext()->setContextProperty("dlhelper",&dl);
    Download pHas;
    viewer.rootContext()->setContextProperty("dllS",&pHas);
    core f;
    viewer.rootContext()->setContextProperty("core",&f);
//    Installer hp;
//    viewer.rootContext()->setContextProperty("sldr",&hp);
    //internet connection opening
    QNetworkConfigurationManager ppp;
    QNetworkSession *nnn = new QNetworkSession(ppp.defaultConfiguration());
    nnn->open();

    viewer.setMainQmlFile(QLatin1String("qml/appstore/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
