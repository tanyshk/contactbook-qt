#ifndef PHOTOIMAGEPROVIDER_H
#define PHOTOIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include "sqliteadapter.h"
#include "controller.h"

class PhotoImageProvider: public QQuickImageProvider
{
public:
    PhotoImageProvider(Controller* controller);
    ~PhotoImageProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);

private:
    SqliteAdapter * m_db;
    Controller * m_controller;
};

#endif // PHOTOIMAGEPROVIDER_H
