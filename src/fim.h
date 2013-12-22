#ifndef FIM_H
#define FIM_H
#include <QObject>
#include <QtGui>
#include <QtCore>
#include <SWInstApi.h>
#include <SWInstDefs.h>

class Installer : public QObject {
    Q_OBJECT
public:
    explicit Installer();
    ~Installer();
    int filInst(const QString& uril,const QString &in);
    Q_INVOKABLE void drive(const QString& aa);
public slots:
    void process();
    void ex();
signals:
    void finished();
    void ok();
private:
    QString hh;
    QString del;
    TChar * eFla; //select drive
    TFileName iDoFe; //file name convert C++
    SwiUI::RSWInstSilentLauncher iBasla; //dont touch
    SwiUI::TInstallOptions iSeck; //dont touch
    SwiUI::TInstallOptionsPckg iSeckPckg; //dont touch
    int acma;
    QString ppp;
};
#endif // FIM_H
