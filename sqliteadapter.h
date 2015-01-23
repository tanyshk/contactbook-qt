#ifndef SQLITEADAPTER_H
#define SQLITEADAPTER_H

#include <QtSql>

struct ListItem
{
    int id;
    QString name;
};

class SqliteAdapter
{
public:
    SqliteAdapter();
    ~SqliteAdapter();

    bool connect(const QString& path);
    QList<ListItem> getList(const int parent);
    QList<ListItem> getDataField(const int id, const int field);
    int getFieldId(const QString& name);
    QMap<QString, QString> getPerson(const int id);
    QByteArray getPhoto(const int id);
    QList<ListItem> search(const QString& name, const QString& mobile, const int limit);
    QString getError() { return m_error; }

private:
    QSqlDatabase m_db;
    QString m_path;
    QString m_error;
};

#endif // SQLITEADAPTER_H
