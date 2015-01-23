#include "person.h"

Person::Person()
{
}

void Person::fill(const QMap<QString, QString> &map)
{
    m_id = map["id"];
    m_name = map["cn"];
    m_title = map["title"];
    m_filial = map["o"];
    m_department = map["ou"];
    m_mobile = map["mobile"];
    m_phone = map["telephoneNumber"];
    m_home = map["homePhone"];
    m_birth = map["dateOfBirth"];
}
