#ifndef HANDLESTARTGAMEBUTTON_H
#define HANDLESTARTGAMEBUTTON_H

#include <QObject>
#include <QDebug>

class HandleStartGameButton : public QObject
{
    Q_OBJECT
public:
    explicit HandleStartGameButton(QObject *parent = nullptr);

private:
    int countAdjacent(int s, int width, int height, bool list[]);

signals:
    void setGridValues(QVariant text, QVariant size);

public slots:
    void handleStartGameButtonClick0(const QVariant &in, int w, int h);
    void handleStartGameButtonClick(const QVariant &in);
    void handleStartGameButtonClick2(const QString &in);

};

#endif // HANDLESTARTGAMEBUTTON_H
