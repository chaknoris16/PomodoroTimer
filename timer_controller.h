#ifndef TIMER_CONTROLLER_H
#define TIMER_CONTROLLER_H

#include <QObject>
#include <qqml.h>

class TimeSelectorController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int minutes READ minutes WRITE setMinutes NOTIFY minutesChanged FINAL)

public:
    explicit TimeSelectorController(QObject *parent = nullptr);
    int minutes();
signals:
    void minutesChanged();
    void handleStart(int time);
    void buttonStartClicked(int time);
public slots:
    void setMinutes(int newTime);
private:
    int m_minutes;

};

#endif // TIMER_CONTROLLER_H
