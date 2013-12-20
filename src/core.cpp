#include "core.h"

core::core(QObject *parent) :
    QObject(parent)
{
}

void core::setCatFilterName(const QString &name) {
    catFilterName=name;
    qDebug()<<catFilterName;
    categorieChanged(); //signal
}


QString core::getCatFilterName() {
    return catFilterName;
}

void core::testInstallGUI(const QString &sisname) {
    RApaLsSession apaLsSession;
    CleanupClosePushL(apaLsSession );
    User::LeaveIfError(apaLsSession.Connect());
    TThreadId threadId;
    QString path;
    path = "C:\\private\\e6002cd5\\" + sisname;
    TPtrC16 symbianpath(reinterpret_cast<const TUint16*>(path.utf16()));
    apaLsSession.StartDocument(symbianpath, threadId);
    CleanupStack::PopAndDestroy(&apaLsSession );
}
