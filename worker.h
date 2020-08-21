#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QVariant>

class Worker : public QObject
{
    Q_OBJECT

public:
    explicit Worker(QObject *parent = nullptr);
    int countAdjacent(int s, int width, int height, bool list[]);
    bool survives(bool currentCellStatus, int liveNeighbours);
    bool convertColorToBool(QVariant color);
    QColor convertBoolToColor(bool isLive);

private:

signals:
    void resultIsReady(QVariant text, QVariant size);

public slots:
    void handleWork(const QVariant &in, int w, int h);
};

#endif // WORKER_H
