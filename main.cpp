#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QMetaObject>
#include <QMetaMethod>
#include <QQuickView>
#include "controller.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    Controller controller;

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    // connect our QML signal to our C++ slot
    QObject::connect(window, SIGNAL(startButtonClicked(QVariant, int, int, int)),
                         &controller, SLOT(handleStartButton(QVariant, int, int, int)));

    QObject::connect(window, SIGNAL(stopButtonClicked()),
                         &controller, SLOT(handleStopButton()));

    QObject::connect(window, SIGNAL(repeatCycle(const QVariant, int, int)),
                         &controller, SLOT(handleRepeatCycle(const QVariant, int, int)));

    // connect our C++ signal to our QML slot
    QObject::connect(&controller, SIGNAL(setGridValues(QVariant, QVariant)),
                         window, SLOT(onSetGridValues(QVariant, QVariant)));

    return app.exec();
}
