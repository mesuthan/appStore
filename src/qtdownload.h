#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>

#include <fim.h>
#include <aknwaitdialog.h>

class QtDownload : public QObject {
    Q_OBJECT
public:
    explicit QtDownload();
    ~QtDownload();
    QString r;
    QString t;
    Q_INVOKABLE QString progressr();
    Q_INVOKABLE QString progresst();
    QString i;
    Q_INVOKABLE void setTarget(const QString& t);
    Q_INVOKABLE void delFile(const QString& file);
    Q_INVOKABLE void installDownload(const QString &ii);
    Q_INVOKABLE void cancelDownload();

private:
    QNetworkAccessManager manager;
    Q_INVOKABLE QString target;
    QNetworkReply* reply;
    CAknWaitDialog* m_waitDialog;

signals:
    Q_INVOKABLE void done();
    Q_INVOKABLE void error();
    Q_INVOKABLE void donefile();

    Q_INVOKABLE void tam();//info banner

public slots:
    Q_INVOKABLE  void download();
    void downloadFinished(QNetworkReply* data);
    Q_INVOKABLE void downloadProgress(qint64 recieved, qint64 total);

    void ok();//finished m_waitDialog

};
