#ifndef DOWNLOAD_H
#define DOWNLOAD_H
#include <QtGui>
#include <QtCore>
#include <QtNetwork>
enum State{
    READY,DOWNLOADNG
};
class Download : public QObject
{
    Q_OBJECT
public:
    explicit Download(QObject *parent = 0);
    ~Download();

    int down(const QString& url, const QString& name);
    State state();
signals:
    void progress(int pro);
    void satatechan(State stat);
    void cda();
    void downComp();
private slots:
    void com();
    void ready();
public slots:
    void data(qint64 by, qint64 total);
    int cancelDownload();
private:
    QNetworkAccessManager* man;
    QNetworkReply *reply;
    QFile* file;
    bool abortted;
    State kOn;
};
#endif // DOWNLOAD_H
