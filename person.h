#ifndef PERSON_H
#define PERSON_H

#include <QObject>
#include "sqliteadapter.h"

class Person: public QObject
{
    Q_OBJECT

    Q_PROPERTY(const QString& id         READ id         CONSTANT)
    Q_PROPERTY(const QString& name       READ name       CONSTANT)
    Q_PROPERTY(const QString& title      READ title      CONSTANT)
    Q_PROPERTY(const QString& filial     READ filial     CONSTANT)
    Q_PROPERTY(const QString& department READ department CONSTANT)
    Q_PROPERTY(const QString& mobile     READ mobile     CONSTANT)
    Q_PROPERTY(const QString& phone      READ phone      CONSTANT)
    Q_PROPERTY(const QString& home       READ home       CONSTANT)
    Q_PROPERTY(const QString& birth      READ birth      CONSTANT)
public:
    Person();

    const QString& id()         const { return m_id; }
    const QString& name()       const { return m_name; }
    const QString& title()      const { return m_title; }
    const QString& filial()     const { return m_filial; }
    const QString& department() const { return m_department; }
    const QString& mobile()     const { return m_mobile; }
    const QString& phone()      const { return m_phone; }
    const QString& home()       const { return m_home; }
    const QString& birth()      const { return m_birth; }

    void fill(const QMap<QString, QString>& map);

private:
    QString m_id;
    QString m_name;
    QString m_title;
    QString m_filial;
    QString m_department;
    QString m_mobile;
    QString m_phone;
    QString m_home;
    QString m_birth;
};

#endif // PERSON_H
