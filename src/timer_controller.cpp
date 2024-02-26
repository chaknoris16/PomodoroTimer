#include "../include/timer_controller.h"
#include <QDebug>

TimeSelectorController::TimeSelectorController(QObject *parent)
    : QObject{parent},
    m_minutes{25}
{
   connect(this, &TimeSelectorController::buttonStartClicked, this, [](int time){qDebug()<< "Handle signal in TimeSelectorController" << time;});
}

int TimeSelectorController::minutes()
{
    return m_minutes;
}

void TimeSelectorController::setMinutes(int newTime)
{
    if(m_minutes != newTime && newTime > 0 && newTime < 240) {
        m_minutes = newTime;
        qDebug() << "time changing" << newTime;
        emit minutesChanged();
    }
}

