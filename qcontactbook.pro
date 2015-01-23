# Add more folders to ship with the application, here
folder_01.source = qml/qcontactbook
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=
QT += qml quick sql androidextras

qtHaveModule(widgets) {
    QT += widgets
}

#EXAMPLE_FILES = contacts.db

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
    main.cpp \
    controller.cpp \
    sqliteadapter.cpp \
    person.cpp \
    photoimageprovider.cpp

HEADERS += \
    controller.h \
    sqliteadapter.h \
    person.h \
    photoimageprovider.h

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    resources.qrc

OTHER_FILES += \
    android-sources/AndroidManifest.xml \
    android-sources/src/org/qtproject/qcontactbook/ContactBookActivity.java

#INCLUDEPATH +=/usr/lib/jvm/java-6-openjdk-amd64/include \
#   /usr/lib/jvm/java-6-openjdk-amd64/include/linux

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources
