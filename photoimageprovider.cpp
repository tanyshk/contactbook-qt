#include "photoimageprovider.h"

PhotoImageProvider::PhotoImageProvider(Controller* controller)
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    //m_db = new SqliteAdapter("contacts.db");
    m_controller = controller;
}

PhotoImageProvider::~PhotoImageProvider()
{
    //delete m_db;
}

QPixmap PhotoImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    QPixmap pixmap;
    QByteArray data = m_controller->getPhoto(id.toInt());

    if (!pixmap.loadFromData(data)){
        qDebug() << Q_FUNC_INFO << " error load from data id = " << id;
        return pixmap;
    }

    if (size) {
        *size = pixmap.size();
    }

    if (requestedSize.width() > 0){
        pixmap.scaledToWidth(requestedSize.width());
    }

    if (requestedSize.height() > 0){
        pixmap.scaledToHeight(requestedSize.height());
    }

    return pixmap;
}
