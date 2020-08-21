#include "worker.h"
#include <QDebug>
#include <QColor>
#include <QVariant>

Worker::Worker(QObject *parent) : QObject(parent){
}

void Worker::handleWork(const QVariant &in, int gridWidth, int gridHeight){
    QVariantList cellsList = in.toList();
    int gridSize = cellsList.size();
    bool cellsListInBool[gridSize];

    bool convertColorToBool(QVariant color);
    for(int i = 0; i < gridSize; i++){
        cellsListInBool[i] = convertColorToBool(cellsList.at(i));
    }

    //Check cells statuses and update a new list(colorValuesToUpdateBool) accordingly
    int countAdjacent(int s, int width, int height, bool list[]);
    bool survives(bool currentCellStatus, int liveNeighbours);
    bool colorValuesToUpdateBool[gridSize];
    int counter = 0;
    for(int i = 0; i < gridSize; i++){
        counter = countAdjacent(i, gridWidth, gridHeight, cellsListInBool);
        colorValuesToUpdateBool[i] = survives(cellsListInBool[i], counter);
    }

    //Convert bool list into QVariantList
    cellsList.clear();
    QColor convertBoolToColor(bool isLive);

    for(int i = 0; i < gridSize; i++){
        cellsList.append(convertBoolToColor(colorValuesToUpdateBool[i]));
    }

    //Send signal with a calculated result
    emit resultIsReady(cellsList, gridSize);
}

int countAdjacent(int s, int width, int height, bool list[]){
    int counter = 0;

    if(s%width > 0 and int(s/width) > 0)
        counter += list[s-width-1];

    if(int(s/width > 0))
        counter += list[s-width];

    if((s%width != width - 1) and int(s/width) > 0)
        counter += list[s-width+1];

    if(s%width > 0)
        counter += list[s-1];

    if(s%width != width - 1)
        counter += list[s+1];

    if(s%width > 0 and int(s/width) != height - 1)
        counter += list[s+width-1];

    if(int(s/width) != height - 1)
        counter += list[s+width];

    if(int(s/width) != width - 1 and int(s/width) != height - 1)
        counter += list[s+width+1];

    return counter;
}

bool survives(bool currentCellStatus, int liveNeighbours){
    bool returnValue;

    switch(liveNeighbours) {
    case 2 :
        //Cell status doesnt change
        returnValue = currentCellStatus;
        break;
    case 3 :
        //Cell status becomes true for dead and live cells
        returnValue = true;
        break;
    default :
        //Cell status becomes false for live and dead cells
        returnValue = false;
    }

    return returnValue;
}

bool convertColorToBool(QVariant color){
    bool returnValue;

    if(color == "black")
        returnValue = 1;
    else
        returnValue = 0;

    return returnValue;
}

QColor convertBoolToColor(bool isLive){
    QColor returnValue;

    if(isLive)
        returnValue = "black";
    else
        returnValue = "white";

    return returnValue;
}
