#ifndef ITEMMODEL_H
#define ITEMMODEL_H

#include <QAbstractListModel>
#include <QList>

class ItemModel : public QAbstractListModel
{
    Q_OBJECT
public:
    struct Item {
        int mins;
        QString name;
        QString date;
    };

    explicit ItemModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
    QList<Item> m_items;

    // QAbstractItemModel interface
public:
    virtual QHash<int, QByteArray> roleNames() const override;
public slots:
    void updateItem(int index, const QString &name);
};

#endif // ITEMMODEL_H
