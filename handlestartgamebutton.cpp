#include "handlestartgamebutton.h"
#include <QObject>
#include <QtGui/QGuiApplication>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QDebug>
#include <QQuickWindow>
#include <QMetaObject>
#include <QMetaMethod>
#include <QVariant>
#include <QQmlContext>
#include <QQuickItem>
#include <QRect>
#include <cmath>
#include <chrono>
#include <thread>

HandleStartGameButton::HandleStartGameButton(QObject *parent) : QObject(parent)
{

}

void HandleStartGameButton::handleStartGameButtonClick0(const QVariant &in, int gridWidth, int gridHeight)
{
    qDebug() << "HandleStartGameButton::handleStartGameButtonClick0 - " << in;

    QVariantList cellsList = in.toList();
    bool isPopulated;
    int gridSize = cellsList.size();

    bool cellsListInBool[gridSize];
    for(int i = 0; i < gridSize; i++){
        if(cellsList.at(i) == "black")
            isPopulated = 1;
        else
            isPopulated = 0;

        cellsListInBool[i] = isPopulated;
    }

    //for(int i = 0; i < 10; i++){
        //Check cells statuses and update a new list(colorValuesToUpdateBool) accordingly
        bool colorValuesToUpdateBool[gridSize];
        int counter = 0;
        int countAdjacent(int s, int width, int height, bool list[]);
        for(int i = 0; i < gridSize; i++){
            counter = countAdjacent(i, gridWidth, gridHeight, cellsListInBool);
            switch(counter) {
                case 2 :
                    //Cell status doesnt change
                    colorValuesToUpdateBool[i] = cellsListInBool[i];
                    break;
                case 3 :
                    //Cell status becomes true for dead and live cells
                    colorValuesToUpdateBool[i] = true;
                    break;
                default :
                    //Cell status becomes false for live and dead cells
                    colorValuesToUpdateBool[i] = false;
            }
        }

        //Convert bool list into QStringList
        QStringList colorValuesToReturn;
        QString colorValue
                ;
        for(int i = 0; i < gridSize; i++){
            colorValue = "white";
            if(colorValuesToUpdateBool[i] == true)
                colorValue = "black";
            colorValuesToReturn.append(colorValue);
        }

        //Sleep(1000);
        //Send signal back to QML to update grid
        emit setGridValues(colorValuesToReturn, gridSize);

        //Reset values
        //colorValuesToReturn.clear();
        //for(int i = 0; i < gridSize; i++){
        //    cellsListInBool[i] = colorValuesToUpdateBool[i];
        //}

        //Pause

        //emit handleStartGameButtonClick0(colorValuesToReturn, gridWidth, gridHeight);
    //}
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

void HandleStartGameButton::handleStartGameButtonClick(const QVariant &in)
{

    qDebug() << "HandleStartGameButton::handleStartGameButtonClick - " << in.type();

    QQuickItem *item = qobject_cast<QQuickItem*>(in.value<QObject*>());

    //qDebug() << "TREE:";
    //item->dumpObjectTree();
    //qDebug() << "INFO:";
    //item->dumpObjectInfo();

    QQuickItem * gridItem = item->findChild<QQuickItem *>("gridItem");
    qDebug() << "grid height :" << gridItem->property("rows") << "; grid width: " << gridItem->property("columns");

    QQuickItem * repeaterItem = item->findChild<QQuickItem *>("repeaterItem");
    qDebug() << "repeater name " << repeaterItem->objectName();
    qDebug() << "repeater size: " << repeaterItem->property("model");

    QObject * rep = item->findChild<QQuickItem *>("repeaterItem");
    //qDebug() << "repeater size: " << rep->property("model");



    //QQmlProperty prop(r, "color");
    //qDebug() << "rect color " << prop.read();

    //qDebug() << "comp size: " << comp->qmlAttachedProperties();

    qDebug() << "done";
    QStringList values;
    int listSize = rep->property("model").toInt();

    for (int i = 0; i < listSize; i++){
        if (i%2 == 0){
            values.append("black");
        }
        else
            values.append("white");
    }

    qDebug() << "string list size " << values.size();

    emit setGridValues(values, listSize);

    qDebug() << "signal emitted " ;


//    QList<QQuickItem *> itemChildren = item->findChildren<QQuickItem *>();
//    for(int i = 0; i < itemChildren.size(); i++)
//    {
//        qDebug() << "Child num " << i << " : ";
//        qDebug() << itemChildren.at(i);
//    }

}

void HandleStartGameButton::handleStartGameButtonClick2(const QString &in)
{
    qDebug() << "HandleStartGameButton::handleStartGameButtonClick2 - " << in;
    //QObject *grid = object->findChild*>
}
