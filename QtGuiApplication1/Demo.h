#ifndef DEMO_H
#define DEMO_H

#include <QtQuick/QQuickPaintedItem>

class Demo : public QObject
{
	Q_OBJECT
		//�궨��ö������
		Q_ENUMS(GenerateAlgorithm)
		//�궨�����ԣ�ͬʱ�趨�������ƣ���ȡд�뷽���Լ�����ֵ�仯���źŲ�����
		Q_PROPERTY(QColor color READ getColor WRITE setColor NOTIFY colorChange)
		Q_PROPERTY(QColor timeColor READ timeColor)
public:
	Demo(QObject *parent = 0);
	~Demo();


	enum GenerateAlgorithm {
		RandomRGB,
		RandomRed,
		RandomGreen,
		RandomBlue,
		LinerIncrease
	};

	const QColor getColor();
	void setColor(const QColor & color);
	const QColor timeColor();

	Q_INVOKABLE QString demoPrint();
	Q_INVOKABLE const GenerateAlgorithm algorithm();
	Q_INVOKABLE void setAlgorithm(GenerateAlgorithm algorithm);

signals:
	void colorChange(const QColor & color);
	void currentTime(const QString &strTime);

protected:
	void timerEvent(QTimerEvent *e);
public:
	void start();
	void stop();
private:
	GenerateAlgorithm m_algorithm;
	QColor m_currentColor;
	int m_nColorTimer;

};

#endif // DEMO_H
