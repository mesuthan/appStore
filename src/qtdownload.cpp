#include "qtdownload.h"
#include <QCoreApplication>
#include <apgcli.h>  //RApaLsSession
#include <apgtask.h> //TApaTaskList
#include <w32std.h>  //RWsSession
#include <QUrl>
#include <QNetworkRequest>
#include <QFile>
#include <QDebug>
#include <QDesktopServices>
#include <QDir>

#include <appstore2.rsg>
#include <eikprogi.h>
#include <aknwaitdialog.h>

QtDownload::QtDownload() : QObject(0) {
    QObject::connect(&manager, SIGNAL(finished(QNetworkReply*)),this, SLOT(downloadFinished(QNetworkReply*)));
    //i = "file:///C:/private/e6002cd5/"; old
    i = "C:\\private\\e6002cd5\\";
}

QtDownload::~QtDownload() {

}

QString QtDownload::progressr() {
    return r;
}
QString QtDownload::progresst() {
    return t;
}

void QtDownload::setTarget(const QString &t) {
    QString lB = t.section("/", -1, -1);
    QFile localFile(lB);
    if (localFile.exists(lB)) {
        emit done();
    } else {
    this->target = QString("http://www.storeage.eu.pn/"+t);
    }
}

void QtDownload::downloadFinished(QNetworkReply *data) {
    if(data->error()==0) {
        QString lastBit = target.section("/", -1, -1);
        QFile localFile(lastBit);
        if (!localFile.open(QIODevice::WriteOnly))
            return;
        const QByteArray sdata = data->readAll();
        localFile.write(sdata);
        localFile.close();
        emit done();
    } else {
        emit error();
        data->abort();
    }
}

void QtDownload::installDownload(const QString &ii) {
    QString sol = i + ii;
    QThread* thread = new QThread;

    Installer* iiHf = new Installer();

    iiHf->filInst(sol,ii);

    m_waitDialog = new (ELeave) CAknWaitDialog(REINTERPRET_CAST(CEikDialog**, &m_waitDialog));
    QT_TRAP_THROWING(m_waitDialog->ExecuteLD(R_WAIT_NOTE_SOFTKEY_CANCEL));

    iiHf->moveToThread(thread);
    QObject::connect(iiHf,SIGNAL(ok()),this,SLOT(ok()),Qt::QueuedConnection);

    QObject::connect(thread, SIGNAL(started()), iiHf, SLOT(process()));
    QObject::connect(iiHf, SIGNAL(finished()), thread, SLOT(quit()));
    QObject::connect(iiHf, SIGNAL(finished()), iiHf, SLOT(deleteLater()));
    QObject::connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    thread->start();
}

void QtDownload::delFile(const QString &file){
    QDir dir;
    QString path = "C:/private/e6002cd5/" + file;
    dir.remove(path);
}

void QtDownload::cancelDownload() {
    reply->deleteLater(); // not working
}

void QtDownload::download() {
    QUrl url = QUrl::fromEncoded(this->target.toLocal8Bit());
    QNetworkRequest request(url);
    QObject::connect(manager.get(request), SIGNAL(downloadProgress(qint64,qint64)), this, SLOT(downloadProgress(qint64,qint64)));

}

void QtDownload::downloadProgress(qint64 recieved, qint64 total) {
    r = QString::number(recieved);
    t = QString::number(total);
    qDebug() << r << t;
}
void QtDownload::ok(){
    QT_TRAP_THROWING(m_waitDialog->ProcessFinishedL());
    emit tam();
}
