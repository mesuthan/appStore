/****************************************************************************
** Meta object code from reading C++ file 'fim.h'
**
** Created: Sun 24. Nov 00:06:04 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../fim.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'fim.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Installer[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      11,   10,   10,   10, 0x05,
      22,   10,   10,   10, 0x05,

 // slots: signature, parameters, type, tag, flags
      27,   10,   10,   10, 0x0a,
      37,   10,   10,   10, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_Installer[] = {
    "Installer\0\0finished()\0ok()\0process()\0"
    "ex()\0"
};

const QMetaObject Installer::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Installer,
      qt_meta_data_Installer, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Installer::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Installer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Installer::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Installer))
        return static_cast<void*>(const_cast< Installer*>(this));
    return QObject::qt_metacast(_clname);
}

int Installer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: finished(); break;
        case 1: ok(); break;
        case 2: process(); break;
        case 3: ex(); break;
        default: ;
        }
        _id -= 4;
    }
    return _id;
}

// SIGNAL 0
void Installer::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void Installer::ok()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
