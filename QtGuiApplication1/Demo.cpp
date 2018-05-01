#include "demo.h"
#include <QTimerEvent>
#include <QDateTime>

Demo::Demo(QObject *parent)
	: QObject(parent),
	m_algorithm(RandomRGB),
	m_currentColor(Qt::black),
	m_nColorTimer(0)
{
	qsrand(QDateTime::currentDateTime().toTime_t());
}

Demo::~Demo()
{


}

QString Demo::demoPrint()
{
	return "C++ Funciton Connecting Test...";
}

const QColor Demo::getColor()
{
	return m_currentColor;

}

void Demo::setColor(const QColor &color)
{
	m_currentColor = color;
	emit colorChange(m_currentColor);
}

const QColor Demo::timeColor()
{
	QTime time = QTime::currentTime();
	int r = time.hour();
	int g = time.minute() * 2;
	int b = time.second() * 4;
	return QColor::fromRgb(r, g, b);
}

const Demo::GenerateAlgorithm Demo::algorithm()
{
	return m_algorithm;
}

void Demo::setAlgorithm(GenerateAlgorithm algorithm)
{
	m_algorithm = algorithm;
}

void Demo::start()
{
	if (m_nColorTimer == 0)
	{
		m_nColorTimer = startTimer(1000);
	}
}

void Demo::stop()
{
	if (m_nColorTimer > 0)
	{
		killTimer(m_nColorTimer);
		m_nColorTimer = 0;
	}
}

void Demo::timerEvent(QTimerEvent *e)
{
	if (e->timerId() == m_nColorTimer)
	{
		switch (m_algorithm)
		{
		case RandomRGB:
			m_currentColor.setRgb(qrand() % 255, qrand() % 255, qrand() % 255);
			break;
		case RandomRed:
			m_currentColor.setRed(qrand() % 255); break;
		case RandomBlue:
			m_currentColor.setBlue(qrand() % 255); break;
		case RandomGreen:
			m_currentColor.setGreen(qrand() % 255); break;
		case LinerIncrease:
		{
			int r = m_currentColor.red() + 10;
			int g = m_currentColor.green() + 10;
			int b = m_currentColor.black() + 10;
			m_currentColor.setRgb(r % 255, g % 255, b % 255);
		}
		break;
		}
		emit colorChange(m_currentColor);
		emit currentTime(QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
	}
	else
		QObject::timerEvent(e);
}
