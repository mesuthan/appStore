/****************************************************************************
** Meta object code from reading C++ file 'core.h'
**
** Created: Fri 20. Dec 13:58:50 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/core.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'core.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_core[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
       6,    5,    5,    5, 0x05,

 // methods: signature, parameters, type, tag, flags
      30,   25,    5,    5, 0x02,
      64,    5,   56,    5, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_core[] = {
    "core\0\0categorieChanged()\0name\0"
    "setCatFilterName(QString)\0QString\0"
    "getCatFilterName()\0"
};

const QMetaObject core::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_core,
      qt_meta_data_core, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &core::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *core::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *core::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_core))
        return static_cast<void*>(const_cast< core*>(this));
    return QObject::qt_metacast(_clname);
}

int core::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: categorieChanged(); break;
        case 1: setCatFilterName((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: { QString _r = getCatFilterName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void core::categorieChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
