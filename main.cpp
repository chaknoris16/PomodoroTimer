#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "timer_controller.h"
#include "dialcontroller.h"
#include <QQmlContext>
#include <QObject>
#include "itemmodel.h"
int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    TimeSelectorController timeSelector;
    DialController dialController;

    QQmlApplicationEngine engine;
    qmlRegisterType<TimeSelectorController>("TimeSelectorController", 1, 0, "TimeSelector");
    qmlRegisterType<DialController>("DialController", 1, 0, "DialController");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    ItemModel itemModel;
    engine.rootContext()->setContextProperty("itemModel", &itemModel);
    engine.rootContext()->setContextProperty("selector", &timeSelector);
    engine.rootContext()->setContextProperty("DialController", &dialController);
    engine.loadFromModule("PomodoroTimer", "Main");

    return app.exec();
}


