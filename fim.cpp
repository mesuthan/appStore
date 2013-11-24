#include <fim.h>
#include <aknnotewrappers.h>
#include <appstore2.rsg>
#include <eikprogi.h>
#include <aknwaitdialog.h>
Installer::Installer() {

    iSeck.iUpgrade = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iOCSP = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iLang = 1; //dont touch
    iSeck.iUntrusted = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iCapabilities = SwiUI::EPolicyNotAllowed; //dont touch

    eFla = 'E'; // install E drive;
    iSeck.iDrive = eFla; //drive selected
    iSeckPckg = iSeck;

}

Installer::~Installer() {

}

void Installer::process() {

    QString file = QString(hh);
    TPtrC16 nottr(reinterpret_cast<const TUint16*>(file.utf16()));
    iDoFe = nottr; //converted C++
    qDebug()<<"file installation started";
    User::LeaveIfError(iBasla.Connect());
    iBasla.SilentInstall(iDoFe,iSeckPckg); //intaller
    iBasla.Close(); //installer closed
    qDebug()<<"completed";

    QTimer::singleShot(1000,this,SLOT(ex()));

}
int Installer::filInst(const QString &uril, const QString &in)
{
    hh = uril;
    del = in;
    return 0;
}
void Installer::ex()
{
    emit ok();
    emit finished();
    QDir dir;
    QString path = "C:/private/e6002cd5/" + del;
    dir.remove(path);
    qDebug()<<"install completed and file deleted";
}

