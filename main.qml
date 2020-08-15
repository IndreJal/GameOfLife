import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Window {
    property alias gridW: sizex.value
    property alias gridH: sizey.value
    //property alias cellWidth: cellsize.text
    property alias executionSpeed: speed.text

    signal goButtonClicked(msg: string)

    id: window
    visible: true
    width: 500
    height: 500
    title: qsTr("Game of Life")

    DataEntryLabel {
        id: gridsizelabel
        text: qsTr("Grid size:")
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 50
    }

    ValueBox {
        id: sizex
        anchors.bottom: gridsizelabel.bottom
        anchors.left: gridsizelabel.right
        anchors.top: gridsizelabel.top
    }

    DataEntryLabel {
        id: labelx
        width: 50
        text: qsTr("x")
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.left: sizex.right
        anchors.bottom: sizex.bottom
        anchors.top: sizex.top
    }

    ValueBox {
        id: sizey
        anchors.bottom: gridsizelabel.bottom
        anchors.left: labelx.right
        anchors.top: gridsizelabel.top
    }

/*
    DataEntryLabel {
        id: cellsizelabel
        width: 120
        text: qsTr("Cell size in pixels:")
        anchors.top: gridsizelabel.bottom
        anchors.topMargin: 10
        anchors.left: gridsizelabel.left
    }

    Dataentrycell {
        id: cellsize
        anchors.left: cellsizelabel.right
        anchors.bottom: cellsizelabel.bottom
        anchors.top: cellsizelabel.top
    }
*/
    DataEntryLabel {
        id: speedlabel
        width: 150
        text: qsTr("Execution speed in ms:")
        anchors.top: sizey.bottom
        anchors.left: gridsizelabel.left
        anchors.topMargin: 10
    }

    DataEntryCell {
        id: speed
        anchors.left: speedlabel.right
        anchors.bottom: speedlabel.bottom
        anchors.top: speedlabel.top
    }

    Button {
        id: goButton
        text: "Start game"
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: speed.bottom
        anchors.topMargin: 10



        onClicked: {
            console.debug("Signal emitted")
            goButtonClicked("Hello from QML")

        }

    }

    GameGrid {
        id: gamegrid
        width: parent.width - 100
        anchors.top: goButton.bottom
        anchors.topMargin: 10
        anchors.left: speedlabel.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        gridWidth: gridW
        gridHeight: gridH
    }
}
