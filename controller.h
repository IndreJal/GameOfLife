#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QThread>
#include <QVariant>

class Controller : public QObject
{
    Q_OBJECT
    QThread workerThread;
public:
    explicit Controller(QObject *parent = nullptr);
    void doSetUp();
    bool Stop;
    int executionSpeed;

signals:
   void startWork(const QVariant &in, int w, int h);
   void setGridValues(QVariant colorList, QVariant gridSize);

public slots:
    void handleResult(QVariant colorList, QVariant gridSize);
    void handleStartButton(const QVariant &in, int w, int h, int v);
    void handleStopButton();
    void handleRepeatCycle(const QVariant &in, int w, int h);
};

#endif // CONTROLLER_H
