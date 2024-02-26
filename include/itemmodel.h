#ifndef ITEMMODEL_H
#define ITEMMODEL_H

#include <QAbstractListModel>
#include <QList>
#include "ListItem.h"

class ItemModel : public QAbstractListModel
{
    Q_OBJECT
public:


    explicit ItemModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual bool removeRows(int row, int count, const QModelIndex &parent) override;
    void setItemsData(const QList<Item>& items);
    virtual QHash<int, QByteArray> roleNames() const override;
private:
    QList<Item> m_items;

public slots:
    void updateItem(int index, const QString &name);
signals:
    void deletingElement(int index);

};

#endif // ITEMMODEL_H
