#include <QtGui>
#include <QtCore>
#include <QtNetwork>
#include <download.h>
Download::Download(QObject *parent) : QObject(parent)
{
    man = new QNetworkAccessManager(this);
    kOn = READY;
}
Download::~Download(){
    delete file;
    delete reply;
}
int Download::down(const QString &url, const QString &name){
    qDebug()<<"down( : "<<url;
    qDebug()<<"down ( : "<<name;
    QString filename = name;
    if(man->networkAccessible() != QNetworkAccessManager::Accessible)
    {
        delete man;
        man = new QNetworkAccessManager(this);
    }
    abortted = false;
    file = new QFile(filename);
    if(!file->open(QIODevice::WriteOnly)){
        kOn = READY;
        emit satatechan(kOn);
        delete file;
        file = NULL;
        return;
    }
    QNetworkRequest req(url);
    reply = man->get(req);
    if(reply)
    {
        connect(reply,SIGNAL(finished()),this,SLOT(com()));
        connect(reply,SIGNAL(downloadProgress(qint64,qint64)),this,SLOT(data(qint64,qint64)));
        connect(reply,SIGNAL(readyRead()),this,SLOT(ready()));
        kOn = DOWNLOADNG;
        emit satatechan(kOn);
    }
    else
    {
        delete file;
        file = NULL;
        emit progress(0);
        kOn = READY;
        emit satatechan(kOn);
    }
    return 0;
}
void Download::com(){
    if(abortted){
        qDebug()<<"cancelled - DOWNLOAD::COM";
        if(file){
            file->close();
            file->remove();
            delete file;
            file = 0;
        }
        reply->deleteLater();
        reply = 0;
        emit progress(0);
        kOn = READY;
        emit satatechan(kOn);
        qDebug()<<"iki";
        return;
    }
    file->flush();
    file->close();
    if(reply->error()){
        qDebug()<<"ERROR - COM ; "<<reply->error();        
        file->remove();
        emit cda();
    }
    reply->deleteLater();
    reply = 0;
    delete file;
    file = 0;
    kOn = READY;
    emit satatechan(kOn);
    emit downComp();
}
void Download::data(qint64 by, qint64 total){
    if(total > 0){
        int value = by * 100 / total;
        emit progress(value);
    }
}
void Download::ready(){
    if(file)
        file->write(reply->readAll());
}
int Download::cancelDownload(){
    if(kOn == DOWNLOADNG){
        abortted = true;
        reply->abort();
    }
    emit cda();
    qDebug()<<"bir";
    return 0;
}
State Download::state(){
    return kOn;
}
