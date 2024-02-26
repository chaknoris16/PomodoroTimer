#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QScopedPointer>
#include "../include/timer_controller.h"
#include "../include/dialcontroller.h"
#include "../include/itemmodel.h"
#include "../include/i_db_manager.h"
#include "../include/db_manager.h"
#include <memory>

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
    QScopedPointer<IDBManager> dbManager(new DBManager());
    //IDBManager* dbManager = new DBManager();
    //itemModel.setItemsData(dbManager.data()->getData());
    engine.rootContext()->setContextProperty("itemModel", &itemModel);
    engine.rootContext()->setContextProperty("selector", &timeSelector);
    engine.rootContext()->setContextProperty("DialController", &dialController);
    engine.loadFromModule("PomodoroTimer", "Main");



    return app.exec();
}


