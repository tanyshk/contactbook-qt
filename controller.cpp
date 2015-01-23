#include "controller.h"
#include <QDebug>
#include "person.h"
#include <QtAndroidExtras/QAndroidJniObject>

Controller::Controller(/*JavaVM* javaVM*/)
    : m_nameId(-1)
    , m_errorStr(QString())
    //, m_javaVM(javaVM)
{
//    QString path(QDir::homePath());
//    path.append(QDir::separator())
//        .append("MyDocs")
//        .append(QDir::separator())
//        .append(".contactbook")
//        .append(QDir::separator())
//        .append("contacts.db");
//    path = QDir::toNativeSeparators(path);
#if defined(Q_OS_ANDROID)
    QString path = "/mnt/sdcard/Download/contactbook/contacts.db";
#elif defined(Q_OS_LINUX)
    QString path = "/home/tanya/work/meego/qcontactbook/contacts.db";
#endif
    //QString path = ":/contacts.db";


    m_db = new SqliteAdapter();

    m_db->connect(path);
    m_errorStr = m_db->getError();

    m_person = new Person();

}
QString Controller::getError()
{
    qDebug() << Q_FUNC_INFO << m_errorStr;
    return m_errorStr;
}

Controller::~Controller()
{
    delete m_db;
    delete m_person;
}

QVariant Controller::getModel(const int id)
{
    qDebug() << Q_FUNC_INFO << " id = " << id;
    QList<ListItem> list = m_db->getList(id);
    QList<QObject*> structList;
    for (int i = 0; i < list.size(); ++i) {
        structList.append(new ModelItem(list.at(i).id, list.at(i).name));
    }
    return QVariant::fromValue(structList);
}

QVariant Controller::getStaff(const int id_struct)
{
    int field = getNameId();
    QList<ListItem> list = m_db->getDataField(id_struct, field);
    QList<QObject*> staffList;
    for (int i = 0; i < list.size(); ++i) {
        staffList.append(new ModelItem(list.at(i).id, list.at(i).name));
    }
    return QVariant::fromValue(staffList);
}

int Controller::getNameId()
{
    if (m_nameId > -1)
        return m_nameId;
    m_nameId = m_db->getFieldId("cn");
    return m_nameId;
}

Person* Controller::getPerson(const int id)
{
    QMap<QString, QString> map = m_db->getPerson(id);
    map["id"] = QString::number(id);
    m_person->fill(map);
    //emit personChanged();
    //return QVariant::fromValue(person);
    return m_person;
}

QByteArray Controller::getPhoto(const int id)
{
    return m_db->getPhoto(id);
}

QVariant Controller::searchResult(const QString &name, const QString &mobile)
{
    qDebug() << Q_FUNC_INFO << " name = " << name << " mobile " << mobile;

    QList<ListItem> list = m_db->search(name, mobile, 50);
    QList<QObject*> structList;
    for (int i = 0; i < list.size(); ++i) {
        structList.append(new ModelItem(list.at(i).id, list.at(i).name));
    }
    qDebug() << "found " << structList.count() << " persons";
    return QVariant::fromValue(structList);
}

void Controller::call(const QString &number)
{
    qDebug() << Q_FUNC_INFO << number;

    QAndroidJniObject javaNumber = QAndroidJniObject::fromString(number);
    QAndroidJniObject::callStaticMethod<void>("org/qtproject/qcontactbook/ContactBookActivity",
                                              "call",
                                              "(Ljava/lang/String;)V",
                                              javaNumber.object<jstring>());

    //QProcess::execute(QString("am start tel:%1").arg(number));
}

void Controller::addContact(const QString& name, const QString& number, const QString& number2, const QString& filial, const QString& title)
{
    QAndroidJniObject javaName = QAndroidJniObject::fromString(name);
    QAndroidJniObject javaNumber = QAndroidJniObject::fromString(number);
    QAndroidJniObject javaNumber2 = QAndroidJniObject::fromString(number2);
    QAndroidJniObject javaFilial = QAndroidJniObject::fromString(filial);
    QAndroidJniObject javaTitle = QAndroidJniObject::fromString(title);
    QAndroidJniObject::callStaticMethod<void>("org/qtproject/qcontactbook/ContactBookActivity",
                                              "addContact",
                                              "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V",
                                              javaName.object<jstring>(),
                                              javaNumber.object<jstring>(),
                                              javaNumber2.object<jstring>(),
                                              javaFilial.object<jstring>(),
                                              javaTitle.object<jstring>());

}
