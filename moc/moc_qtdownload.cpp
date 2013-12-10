/****************************************************************************
** Meta object code from reading C++ file 'qtdownload.h'
**
** Created: Sun 1. Dec 23:28:34 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/qtdownload.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'qtdownload.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_QtDownload[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x05,
      19,   11,   11,   11, 0x05,
      27,   11,   11,   11, 0x05,
      38,   11,   11,   11, 0x05,
      44,   11,   11,   11, 0x05,

 // slots: signature, parameters, type, tag, flags
      56,   11,   11,   11, 0x0a,
      67,   11,   11,   11, 0x0a,
      76,   72,   11,   11, 0x0a,
      91,   88,   11,   11, 0x0a,
     106,   11,   11,   11, 0x0a,
     114,   11,   11,   11, 0x0a,

 // methods: signature, parameters, type, tag, flags
     127,  125,   11,   11, 0x02,
     148,  146,   11,   11, 0x02,
     170,  165,   11,   11, 0x02,
     190,  187,   11,   11, 0x02,
     215,   11,   11,   11, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_QtDownload[] = {
    "QtDownload\0\0done()\0error()\0donefile()\0"
    "tam()\0cancelled()\0download()\0ok()\0val\0"
    "proccc(int)\0st\0statech(State)\0empty()\0"
    "downComp()\0t\0setTarget(QString)\0l\0"
    "setLink(QString)\0file\0delFile(QString)\0"
    "ii\0installDownload(QString)\0"
    "cancelDownload()\0"
};

const QMetaObject QtDownload::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QtDownload,
      qt_meta_data_QtDownload, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &QtDownload::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *QtDownload::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *QtDownload::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_QtDownload))
        return static_cast<void*>(const_cast< QtDownload*>(this));
    return QObject::qt_metacast(_clname);
}

int QtDownload::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: done(); break;
        case 1: error(); break;
        case 2: donefile(); break;
        case 3: tam(); break;
        case 4: cancelled(); break;
        case 5: download(); break;
        case 6: ok(); break;
        case 7: proccc((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 8: statech((*reinterpret_cast< State(*)>(_a[1]))); break;
        case 9: empty(); break;
        case 10: downComp(); break;
        case 11: setTarget((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 12: setLink((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 13: delFile((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 14: installDownload((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 15: cancelDownload(); break;
        default: ;
        }
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void QtDownload::done()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void QtDownload::error()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void QtDownload::donefile()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void QtDownload::tam()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void QtDownload::cancelled()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE
