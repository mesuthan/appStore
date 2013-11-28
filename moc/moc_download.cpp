/****************************************************************************
** Meta object code from reading C++ file 'download.h'
**
** Created: Thu 28. Nov 19:36:53 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/download.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'download.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Download[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      14,   10,    9,    9, 0x05,
      33,   28,    9,    9, 0x05,
      51,    9,    9,    9, 0x05,
      57,    9,    9,    9, 0x05,

 // slots: signature, parameters, type, tag, flags
      68,    9,    9,    9, 0x08,
      74,    9,    9,    9, 0x08,
      91,   82,    9,    9, 0x0a,
     115,    9,  111,    9, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_Download[] = {
    "Download\0\0pro\0progress(int)\0stat\0"
    "satatechan(State)\0cda()\0downComp()\0"
    "com()\0ready()\0by,total\0data(qint64,qint64)\0"
    "int\0cancelDownload()\0"
};

const QMetaObject Download::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Download,
      qt_meta_data_Download, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Download::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Download::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Download::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Download))
        return static_cast<void*>(const_cast< Download*>(this));
    return QObject::qt_metacast(_clname);
}

int Download::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: progress((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: satatechan((*reinterpret_cast< State(*)>(_a[1]))); break;
        case 2: cda(); break;
        case 3: downComp(); break;
        case 4: com(); break;
        case 5: ready(); break;
        case 6: data((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 7: { int _r = cancelDownload();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void Download::progress(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Download::satatechan(State _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void Download::cda()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void Download::downComp()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}
QT_END_MOC_NAMESPACE
