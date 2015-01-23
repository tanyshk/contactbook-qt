#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>
#include <QTextCodec>
#include "qtquick2applicationviewer.h"

#include "controller.h"
#include "photoimageprovider.h"

//#include <jni.h>
//#include "QtGui/5.1.0/QtGui/qpa/qplatformnativeinterface.h"
//#include <qpa/qplatformnativeinterface.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //JavaVM* javavm = (JavaVM*)app.platformNativeInterface()->nativeResourceForIntegration("JavaVM");

    Controller *controller = new Controller(/*javavm*/);

    qputenv("QML_USE_GLYPHCACHE_WORKAROUND", QByteArray("1"));

    QQmlApplicationEngine engine(QUrl("qrc:/qml/qcontactbook/main.qml"));

    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("controller", controller);

    qmlRegisterUncreatableType<Person>("Person", 1, 0, "PersonItem", "UNCREATABLE");

    engine.addImageProvider(QLatin1String("photo"), new PhotoImageProvider(controller));

//    QTextCodec::setCodecForTr(QTextCodec::codecForName("UTF-8"));
//    QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF-8"));

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);
    if ( !window ) {
        qWarning("Error: Your root item has to be a Window.");
        return -1;
    }
    window->show();

    return app.exec();
}
