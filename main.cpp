#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <handlestartgamebutton.h>
#include <QQuickWindow>
#include <QMetaObject>
#include <QMetaMethod>


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


    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    HandleStartGameButton handleStartGameButton;

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);



    // connect our QML signal to our C++ slot
    QObject::connect(window, SIGNAL(goButtonClicked(QString)),
                         &handleStartGameButton, SLOT(handleStartGameButtonClick(QString)));


    // Assuming you've instantiated QQuickItem* item
    // This will print out the signature for every signal/slot on the object
    // Make sure you include <QMetaObject>, <QMetaMethod>
    /*
    const QMetaObject* metaObj = window->metaObject();
    for (int i = 0; i < metaObj->methodCount(); ++i) {
        QMetaMethod method = metaObj->method(i);
        qDebug() << method.methodSignature();
    }
    */

    return app.exec();
}
