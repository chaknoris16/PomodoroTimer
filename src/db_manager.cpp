#include "../include/db_manager.h"

DBManager::DBManager(QObject *parent)
    : IDBManager{parent}
{
    createDB(this->db, dbName);
    setQuery(this->db, dbName);
}

DBManager::~DBManager()
{
    closeDB(this->db);
    qDebug() << "delete dbManager";
}

void DBManager::createDB(QSqlDatabase& db, const QString& dbName)
{
    if (!db.isValid()) {
        db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName(dbName);

        if (db.open()) {
            qDebug() << "Database opened successfully.";
        } else {
            qDebug() << "Failed to open database:" << db.lastError().text();
        }

    } else {
        qDebug() << "Cannot create or open database";
    }
}

void DBManager::setQuery(const QSqlDatabase& db, const QString &dbName)
{
    if(db.isOpen()) {
        QSqlQuery query(db);
        query.exec("CREATE TABLE IF NOT EXISTS " + dbName + "query" + " ("
                   "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "mins INTEGER, "
                   "name TEXT, "
                   "date TEXT)");
        if (!query.isActive()) { qDebug() << "Error: Could not create table " << dbName ;}
    } else {
        qDebug() << "Error opening database:" << db.lastError().text();
    }
}

QList<Item> DBManager::getData() const
{
    QList<Item> items;

    if (db.isOpen()) {
        QSqlQuery query(db);
        while (query.next()) {
            items.append({
                query.value("mins").toInt(),
                query.value("name").toString(),
                query.value("date").toString()
            });
        }
    } else {
        qDebug() << "Failed to open database:" << db.lastError().text();
    }

    return items;
}

void DBManager::insertRecord(const Item &listItem)
{
    if (db.isOpen()) {
        if(!this->isRecordExists(listItem.name)) {
            QSqlQuery query(db);
            query.prepare("INSERT INTO " + dbName + "query" + " (mins, name, date) VALUES (:mins, :name, :date)");
            query.bindValue(":mins", listItem.mins);
            query.bindValue(":name", listItem.name);
            query.bindValue(":date", listItem.date);

            if (query.exec()) {
                qDebug() << "Record inserted successfully!";
            } else {
                qDebug() << "Error inserting record:" << query.lastError().text();
            }
        } else {
            qDebug() << "A record with the name " + listItem.name + " already exists.";
        }
    } else {

        qDebug() << "Failed to open database:" << db.lastError().text();
    }
}

void DBManager::updateRecord(int id, const QString &newName)
{
    if (db.isOpen()) {
        if(!this->isRecordExists(newName)) {
            QSqlQuery query(db);
            query.prepare("UPDATE " + this->dbName + "query" + " SET name = :newName WHERE id = :id");
            query.bindValue(":newName", newName);
            query.bindValue(":id", id);

            if (query.exec()) {
                qDebug() << "Name updated successfully";
            } else {
                qDebug() << "Error updating name:" << query.lastError().text();
            }
        } else {
            qDebug() << "A record with the name " + newName + " already exists.";
        }
    } else {
        qDebug() << "Error opening database to change name:" << db.lastError().text();
    }
}

bool DBManager::isRecordExists(const QString &name)
{
    if(db.isOpen()) {
        QSqlQuery query(db);
        query.prepare("SELECT COUNT(*) FROM " + this->dbName + "query" + " WHERE name = :name");
        query.bindValue(":name", name);

        if (query.exec() && query.next()) {
            int count = query.value(0).toInt();
            return count > 0;
        } else {
            qDebug() << "Error checking record existence:" << query.lastError().text();
            return false;
        }
    } else {
        qDebug() << "Error opening database:" << this->db.lastError().text();
        return false;
    }
}

void DBManager::deleteRecord(int id)
{
    if (db.isOpen()) {
        QSqlQuery query(db);
        query.prepare("DELETE FROM " + this->dbName + "query" + " WHERE id = :id");
        query.bindValue(":id", id);

        if (query.exec()) {
            qDebug() << "Record delete successfully";
        } else {
            qDebug() << "Error delete record:" << query.lastError().text();
        }
    } else {
        qDebug() << "Error opening database to delete record:" << db.lastError().text();
    }
}

void DBManager::closeDB(QSqlDatabase& db)
{
    if(db.isValid() && db.isOpen()) {
        db.close();
    } else {
        qDebug() << "Error closing database";
    }
}
