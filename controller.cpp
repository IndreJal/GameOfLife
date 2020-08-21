#include "controller.h"
#include "worker.h"
#include <QDebug>

Controller::Controller(QObject *parent) : QObject(parent){
}

void Controller::doSetUp(){
    Worker *worker = new Worker;
    worker->moveToThread(&workerThread);
    connect(&workerThread, &QThread::finished, worker, &QObject::deleteLater);
    connect(this, &Controller::startWork, worker, &Worker::handleWork);
    connect(worker, &Worker::resultIsReady, this, &Controller::handleResult);
    Stop = false;
    workerThread.start();
}

void Controller::handleStartButton(const QVariant &in, int w, int h, int v){
    executionSpeed = v;
    doSetUp();
    emit startWork(in, w, h);
}

void Controller::handleRepeatCycle(const QVariant &in, int w, int h){
    if(!Stop){
        workerThread.msleep(executionSpeed);
        emit startWork(in, w, h);
    }
}

void Controller::handleResult(QVariant colorList, QVariant gridSize){
    emit setGridValues(colorList, gridSize);
}

void Controller::handleStopButton(){
    Stop = true;
    workerThread.exit();
}
