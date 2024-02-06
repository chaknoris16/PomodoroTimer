#include "dialcontroller.h"

DialController::DialController(QObject *parent)
    : QObject{parent}
{
    connect(this, &DialController::startDial, this, [this](int time) {
        this->setMinutes(time);
        this->minsTimer->start(min);
        this->divPrice = determinateDivPrice(this->m_minutes);
        this->divisionTimer->start(divPrice * min);
        this->currentDivision = 0;
    });
    connect(this->minsTimer, &QTimer::timeout, this, [this]() {
        if(this->m_minutes >= 0) {
            this->setMinutes( m_minutes - 1 );
            this->minsTimer->start(min);
            qDebug() << "One minutes timeout";
        } else {
            emit dialTimerTimeout();
        }
    });

    connect(this->divisionTimer, &QTimer::timeout, this, [this]() {
        if(currentDivision < divisionsNumber) {
            emit divisionsColorChanged(currentDivision, false);
            ++currentDivision;
        } else {
            emit dialTimerTimeout();
        }
    });
}

int DialController::minutes()
{
    return m_minutes;
}

void DialController::setMinutes(int newTime)
{
    if(m_minutes != newTime || newTime >= 0) {
        m_minutes = newTime;
        emit minutesChanged();
    }
}

double DialController::determinateDivPrice(int minutes)
{
    if(minutes > 0)
    {
        return static_cast<double>(minutes) / this->divisionsNumber;
    }
    return 0.0;
}


