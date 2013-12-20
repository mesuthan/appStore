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

