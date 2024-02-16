#include "itemmodel.h"
#include <QVariant>
ItemModel::ItemModel(QObject *parent)
: QAbstractListModel(parent)
{
    m_items.append({5, "Work", "15.02.2024"});
    m_items.append({25, "Hobbi", "14.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
    m_items.append({30, "Cook", "16.02.2024"});
}

int ItemModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant ItemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.count())
        return QVariant();

    const Item &item = m_items.at(index.row());

    switch (role) {
    case Qt::UserRole + 1: // Mins
        return item.mins;
    case Qt::UserRole + 2: // Name
        return item.name;
    case Qt::UserRole + 3: // Date
        return item.date;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole + 1] = "mins";
    roles[Qt::UserRole + 2] = "name";
    roles[Qt::UserRole + 3] = "date";
    return roles;
}

void ItemModel::updateItem(int index, const QString &name)
{
    if (index < 0 || index >= m_items.count())
        return;

    Item &item = m_items[index];
    item.name = name;

    // Оповістіть про оновлення даних
    QModelIndex modelIndex = createIndex(index, 0);
    qDebug() << "New name:" << name;
    emit dataChanged(modelIndex, modelIndex, {Qt::UserRole + 2});
}
