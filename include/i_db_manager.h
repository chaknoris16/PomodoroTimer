#ifndef IDBMANAGER_H
#define IDBMANAGER_H

#include <QObject>
#include <QString>
#include <QList>
#include "ListItem.h"
class IDBManager : public QObject
{
public:
    explicit IDBManager(QObject *parent = nullptr)
        : QObject(parent) {}
    virtual ~IDBManager() = default;
    virtual void insertRecord(const Item& listItem) = 0;
    virtual QList<Item> getData() const = 0;
    virtual void updateRecord(int itemId, const QString& newName) = 0;
    virtual void deleteRecord(int itemId) = 0;
};

#endif // IDBMANAGER_H
