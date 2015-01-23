#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "sqliteadapter.h"
#include "person.h"

#include <jni.h>

class ModelItem: public QObject
{
    Q_OBJECT

    Q_PROPERTY(int     id   READ id       CONSTANT)
    Q_PROPERTY(QString name READ name     CONSTANT)

public:
    ModelItem(int id, QString name)
        : m_id(id)
        , m_name(name){};

    int id() const { return m_id; }
    QString name() const { return m_name; }

private:
    int     m_id;
    QString m_name;
};

class Controller : public QObject
{
    Q_OBJECT

    //Q_PROPERTY(Person* person READ person NOTIFY personChanged)

public:
    explicit Controller(/*JavaVM *javaVM = 0*/);
    ~Controller();

    Q_INVOKABLE QVariant getModel(const int id);
    Q_INVOKABLE QVariant getStaff(const int id_struct);
    Q_INVOKABLE Person* getPerson(const int id);
    Q_INVOKABLE QVariant searchResult(const QString& name, const QString& mobile);
    Q_INVOKABLE void call(const QString& number);
    Q_INVOKABLE void addContact(const QString& name, const QString& number, const QString& number2, const QString& filial, const QString& title);

    QByteArray getPhoto(const int id);
    Q_INVOKABLE QString getError();

    //Person* person() { return m_person; }

signals:
    //void personChanged();

private:
    int getNameId();

private:
    SqliteAdapter * m_db;
    int m_nameId;
    Person * m_person;
    QString m_errorStr;
    //JavaVM *m_javaVM;

};

#endif // CONTROLLER_H
