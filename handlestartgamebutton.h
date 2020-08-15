#ifndef HANDLESTARTGAMEBUTTON_H
#define HANDLESTARTGAMEBUTTON_H

#include <QObject>
#include <QDebug>

class HandleStartGameButton : public QObject
{
    Q_OBJECT
public:
    explicit HandleStartGameButton(QObject *parent = nullptr);

public slots:
    void handleStartGameButtonClick(const QString& in);

};

#endif // HANDLESTARTGAMEBUTTON_H
