#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QString>

#include <QDebug>
class core : public QObject
{
    Q_OBJECT
public:
    explicit core(QObject *parent = 0);
    Q_INVOKABLE QString catFilterName;
    Q_INVOKABLE void setCatFilterName(const QString &name);
    Q_INVOKABLE QString getCatFilterName();

signals:
    Q_INVOKABLE void categorieChanged();
public slots:

};

#endif // CORE_H
