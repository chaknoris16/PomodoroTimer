#ifndef DBMANAGER_H
#define DBMANAGER_H

#include "i_db_manager.h"
#include <QSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

class DBManager : public IDBManager
{
    Q_OBJECT
public:
    explicit DBManager(QObject *parent = nullptr);
    ~DBManager() override;
    virtual void insertRecord(const Item& listItem);
    virtual QList<Item> getData() const override;
    virtual void updateRecord(int id, const QString &newName) override;
    virtual void deleteRecord(int id) override;
private:
    const QString dbName = "TimerDatabase";
    QSqlDatabase db;
    void createDB(QSqlDatabase &db, const QString &dbName);
    void setQuery(const QSqlDatabase &db, const QString& dbName);
    void closeDB(QSqlDatabase &db);
    bool isRecordExists(const QString& name);

};

#endif // DBMANAGER_H
