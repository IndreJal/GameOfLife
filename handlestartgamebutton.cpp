#include "handlestartgamebutton.h"

HandleStartGameButton::HandleStartGameButton(QObject *parent) : QObject(parent)
{

}

void HandleStartGameButton::handleStartGameButtonClick(const QString &in)
{
    qDebug() << "HandleStartGameButton::handleStartGameButtonClick - " << in;
}
