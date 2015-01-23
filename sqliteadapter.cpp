#include "sqliteadapter.h"
#include <QString>

SqliteAdapter::SqliteAdapter()
{
    //m_error = QString("");
}

bool SqliteAdapter::connect(const QString& path)
{
    if (!QSqlDatabase::isDriverAvailable("QSQLITE")){
        m_error = "qsqlite driver is not available";
        qDebug() << "qsqlite driver is not available";
        return false;
    }else {
        m_error = "qsqlite driver is available";
        qDebug() << "qsqlite driver is available";
    }

    m_db = QSqlDatabase::addDatabase("QSQLITE");
    if (!m_db.isValid()) {
        m_error = QString("db is not valid %1").arg(m_db.lastError().text());
        qDebug() << "db is not valid " << m_db.lastError();
        return false;
    }else {
        m_error += " db is valid";
        qDebug() << "db is valid";
    }

    m_db.setDatabaseName(path);
    if (!m_db.open()) {
        m_error = QString("db is not open %1 %2").arg(m_db.lastError().text()).arg(path);
        qDebug() << "db is not open " << m_db.lastError() << path;
        return false;
    } else {
        m_error += QString(" db is open %1").arg(path);
        qDebug() << "db is open";
    }
    return true;
}

SqliteAdapter::~SqliteAdapter()
{
    m_db.close();

}

QList<ListItem> SqliteAdapter::getList(const int parent)
{
    QList<ListItem> list;
    QString str = QString("select id, name from struct where parent=%1 order by name").arg(parent);

    QSqlQuery query(str, m_db);
    qDebug() << str << " isActive " << query.isActive();
    if (!query.exec()){
        qDebug() << Q_FUNC_INFO << "error in query " << query.lastError();
        return list;
    }

    ListItem item;
    while (query.next()) {
        item.id = query.value(0).toInt();
        item.name = query.value(1).toString();
        list.push_back(item);
        qDebug() << query.value(0) << " " << query.value(1);
    }
    return list;
}

QList<ListItem> SqliteAdapter::getDataField(const int id, const int field)
{
    QList<ListItem> list;
    QString str = QString("select relation.data_id, data.value from relation left join data on relation.data_id=data.id where struct_id=%1 and data.field_id=%2")
                  .arg(id).arg(field);

    QSqlQuery query(str, m_db);
    qDebug() << str << " isActive " << query.isActive();
    if (!query.exec()){
        qDebug() << Q_FUNC_INFO << "error in query " << query.lastError();
        return list;
    }
    ListItem item;
    while (query.next()) {
        item.id = query.value(0).toInt();
        item.name = query.value(1).toString();
        list.push_back(item);
        qDebug() << query.value(0) << " " << query.value(1);
    }
    return list;
}

int SqliteAdapter::getFieldId(const QString& name)
{
    QString str = QString("select id from fields where name=\"%1\"").arg(name);

    QSqlQuery query(str, m_db);
    if (!query.exec()){
        qDebug() << Q_FUNC_INFO << "error in query " << str;
        return -1;
    }
    if (!query.first()){
        qDebug() << Q_FUNC_INFO << "empty result " << str;
        return -1;
    }
    return query.value(0).toInt();
}

QMap<QString, QString> SqliteAdapter::getPerson(const int id)
{
    QMap<QString, QString> map;
    QString str = QString("select fields.name, value from data left join fields on fields.id=data.field_id where data.id=%1")
                  .arg(id);

    QSqlQuery query(str, m_db);
    if (!query.exec()){
        qDebug() << Q_FUNC_INFO << "error in query " << str;
        return map;
    }
    while (query.next()) {
        map[query.value(0).toString()] = query.value(1).toString();
    }
    return map;
}

QByteArray SqliteAdapter::getPhoto(const int id)
{
    QString str = QString("select photo from photo where data_id=%1").arg(id);

    QSqlQuery query(str, m_db);
    if (!query.exec()){
        qDebug() << Q_FUNC_INFO << "error in query " << str;
        return QByteArray();
    }
    if (!query.first()){
        qDebug() << Q_FUNC_INFO << "empty result " << str;
        return QByteArray();
    }
    return query.value(0).toByteArray();
}

QList<ListItem> SqliteAdapter::search(const QString &name, const QString &mobile, const int limit)
{
    QList<ListItem> list;
    int field_name = getFieldId("cn");
    int field_mobile = getFieldId("mobile");
    QString cap_name;
    cap_name = name.toLower();
    if (cap_name.count() > 0)
        cap_name[0] = cap_name.at(0).toTitleCase();
    QString str = QString("select id, value from data where field_id=%1 and value like '%2%' ")
            .arg(field_name)
            .arg(cap_name);
    if (!mobile.isEmpty()) {
        str = str + QString(" and id in (select id from data where field_id=%1 and value like '%%2%') ")
                        .arg(field_mobile)
                        .arg(mobile);
    }
    str = str + QString(" limit %1").arg(limit);

    QSqlQuery query(str, m_db);
    qDebug() << str << " isActive " << query.isActive();
    if (!query.exec()){
        qDebug() << Q_FUNC_INFO << "error in query " << query.lastError();
        return list;
    }

    ListItem item;
    while (query.next()) {
        item.id = query.value(0).toInt();
        item.name = query.value(1).toString();
        list.push_back(item);
        qDebug() << query.value(0) << " " << query.value(1);
    }
    return list;
}
//https://groups.google.com/forum/#!topic/android-qt/Sf9w-5u1AUw
