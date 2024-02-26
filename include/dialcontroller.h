#ifndef DIALCONTROLLER_H
#define DIALCONTROLLER_H

#include <QObject>
#include <QDebug>
#include <qqml.h>
#include <QTimer>
class DialController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int minutes READ minutes WRITE setMinutes NOTIFY minutesChanged FINAL)
public:
    explicit DialController(QObject *parent = nullptr);
    int minutes();
public slots:
    void setMinutes(int newTime);
signals:
    void minutesChanged();
    void startDial(int time);
    void divisionsColorChanged(int divNumber, bool divState);
    void dialTimerTimeout();
private:
    double divPrice{};
    int currentDivision{0};
    double determinateDivPrice(int minutes);
    const int divisionsNumber = 24;
    const int min = 60'000;
    int m_minutes;
    QTimer* minsTimer = new QTimer(this);
    QTimer* divisionTimer = new QTimer(this);
};

#endif // DIALCONTROLLER_H
