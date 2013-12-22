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

#include <QtNetwork>

QtDownload::QtDownload(QWidget *parent) : QObject(parent) {
    i = "C:\\private\\e6002cd5\\";
    downll = new Download(this);
    connect(downll,SIGNAL(progress(int)),this,SLOT(proccc(int)));
    connect(downll,SIGNAL(satatechan(State)),this,SLOT(statech(State)));
    connect(downll,SIGNAL(downComp()),this,SLOT(downComp()));
    connect(downll,SIGNAL(cda()),this,SLOT(empty()));
}
QtDownload::~QtDownload() {
    QString path = tr("C:\\private\\e6002cd5") + "/" + flNa;
    QFile ii(path);
    ii.remove();
}

void QtDownload::setTarget(const QString &t) {
    flNa = t;
    QString lB = t.section("/", -1, -1);
    QFile localFile(lB);
    if (localFile.exists(lB)) {
        emit done();
    } else {
    this->target = QString("http://www.storeage.eu.pn/"+t);
    }
}
void QtDownload::setLink(const QString &l) {
    flNa = l;
    QString lB = l.section("/", -1, -1);
    QFile localFile(lB);
    if (localFile.exists(lB)) {
        emit done();
    } else {
    this->target = l;
    }
}
void QtDownload::installDownload(const QString &ii) {
    QThread* thread = new QThread;
    Installer* iiHf = new Installer();
    iiHf->drive(pan);
    QString sol = i + ii;
    qDebug()<< sol;

    iiHf->filInst(sol,ii);
    iiHf->moveToThread(thread);
    QObject::connect(iiHf,SIGNAL(ok()),this,SLOT(ok()),Qt::QueuedConnection);
    QObject::connect(thread, SIGNAL(started()), iiHf, SLOT(process()));
    QObject::connect(iiHf, SIGNAL(finished()), thread, SLOT(quit()));
    QObject::connect(iiHf, SIGNAL(finished()), iiHf, SLOT(deleteLater()));
    QObject::connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    thread->start();
    return;
}

void QtDownload::delFile(const QString &file){
    QString path = tr("C:\\private\\e6002cd5") + "/" + file;
    QFile ii(path);
    ii.remove();
}
void QtDownload::download() {
    QUrl url = QUrl::fromEncoded(target.toLocal8Bit());
    QString lastBit = target.section("/", -1, -1);
    qDebug()<<lastBit;
    downll->down(url.toString(),lastBit);
}
void QtDownload::cancelDownload() {
    QTimer::singleShot(50,downll,SLOT(cancelDownload()));
}
void QtDownload::ok(){
    emit tam();
}
void QtDownload::proccc(int val)
{
    qDebug()<<"......"<<QString::number(val);
}
void QtDownload::statech(State st)
{
    qDebug()<<"xxx : "<<st;
}
void QtDownload::downComp(){
    qDebug()<<"Bitttttttiii";
    emit done();
}
void QtDownload::empty()
{
    emit cancelled();
}
void QtDownload::path(const QString &pa)
{
    pan.clear();
    pan = pa;
}
