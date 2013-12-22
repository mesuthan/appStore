#include <fim.h>
#include <QtCore>
Installer::Installer() {
    iSeck.iUpgrade = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iOCSP = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iLang = 1; //dont touch
    iSeck.iUntrusted = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iCapabilities = SwiUI::EPolicyNotAllowed; //dont touch
    iSeck.iKillApp = SwiUI::EPolicyAllowed;
    iSeck.iUpgrade = SwiUI::EPolicyAllowed;
    iSeck.iOverwrite = SwiUI::EPolicyAllowed;


    ppp = "0";
    acma = 0;
}
Installer::~Installer() {

}
void Installer::process() {

    QString file = QString(hh);
    TPtrC16 nottr(reinterpret_cast<const TUint16*>(file.utf16()));
    iDoFe = nottr; //converted C++
    qDebug()<<"file installation started";

    if((acma == 1)||(acma == 2)||(acma == 3))
    {
        if(acma == 1){eFla = 'E';}
        if(acma == 2){eFla = 'C';}
        if(acma == 3){eFla = 'F';}
        iSeck.iDrive = eFla;
        iSeckPckg = iSeck;
        qDebug()<<"fimmmm:::ss:"<<eFla;
        qDebug()<<"fimmmm:::ss:"<<acma;
        User::LeaveIfError(iBasla.Connect());
        iBasla.SilentInstall(iDoFe, iSeckPckg); //intaller
        iBasla.Close(); //installer closed
        qDebug()<<"completed";
        QTimer::singleShot(1000,this,SLOT(ex()));
    }
    else if(acma == 0){

        eFla = 'E';
        iSeck.iDrive = eFla;
        iSeckPckg = iSeck;
        qDebug()<<"fimmmm:::ee:"<<eFla;
        qDebug()<<"fimmmm:::ee:"<<acma;
        User::LeaveIfError(iBasla.Connect());
        iBasla.SilentInstall(iDoFe, iSeckPckg); //intaller
        iBasla.Close(); //installer closed
        qDebug()<<"completed";
        QTimer::singleShot(1000,this,SLOT(ex()));
    }

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
void Installer::drive(const QString &aa)
{
    if(!aa.isEmpty()){
        qDebug()<<"doluuuuu::::"<<aa;
        if(aa == "E")
        {
            acma = 1;
            qDebug()<<"fimmmm::::"<<acma;
            qDebug()<<"fimmmm::::"<<aa;
            eFla = 'E';
            qDebug()<<"fimmmm:::1:"<<eFla;
        }
        else if(aa == "C")
        {

            acma = 2;
            qDebug()<<"fimmmm::::"<<acma;
            qDebug()<<"fimmmm::::"<<aa;
            eFla = 'C';
            qDebug()<<"fimmmm:::2:"<<eFla;

        }
        else if(aa == "F")
        {
            acma = 3;
            qDebug()<<"fimmmm::::"<<acma;
            qDebug()<<"fimmmm::::"<<aa;
            eFla = 'F';
            qDebug()<<"fimmmm:::3:"<<eFla;

        }
    }
    else{
        qDebug()<<"bossss::::"<<aa;
        acma = 0;
    }
}
