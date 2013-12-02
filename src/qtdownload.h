#include <QObject>
#include <QString>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkReply>

#include <fim.h>
#include <aknwaitdialog.h>
#include <download.h>
class QtDownload : public QObject {
    Q_OBJECT
public:
    explicit QtDownload(QWidget *parent = 0);
    ~QtDownload();
    QString r;
    QString t;
    QString i;
    Q_INVOKABLE void setTarget(const QString& t);
    Q_INVOKABLE void setLink(const QString& l);
    Q_INVOKABLE void delFile(const QString& file);
    Q_INVOKABLE void installDownload(const QString &ii);
    Q_INVOKABLE void cancelDownload();

private:
    Q_INVOKABLE QString target;
    CAknWaitDialog* m_waitDialog;
    QString flNa;
    Download* downll;
signals:
    Q_INVOKABLE void done();
    Q_INVOKABLE void error();
    Q_INVOKABLE void donefile();
    Q_INVOKABLE void tam();//info banner
    Q_INVOKABLE void cancelled();//cancel download
private slots:

public slots:
    Q_INVOKABLE  void download();
    void ok();

    void proccc(int val);
    void statech(State st);
    void empty();
    void downComp();
};
