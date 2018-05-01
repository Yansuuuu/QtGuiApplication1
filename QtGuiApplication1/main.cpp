#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include "demo.h"


int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;

	app.setOrganizationName("GuangHai");
	app.setOrganizationDomain("yancaiguancom@sina.com");
	app.setApplicationName("MyPlayerPro");

	//C++ / QML ½»»¥
	qmlRegisterType<Demo>("an.qt.Demos", 1, 0, "QmlDemo");

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}


