import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Window {
    property alias gridW: sizex.value
    property alias gridH: sizey.value
    property alias executionSpeed: speed.text
    property var cellsList: []

    signal startButtonClicked(var cells, int w, int h, int v)
    signal stopButtonClicked()
    signal repeatCycle(var cells, int w, int h)

    id: window
    visible: true
    width: 500
    height: 500
    title: qsTr("Game of Life")
    objectName: "MainWindow"

    function onSetGridValues(values, n){
        for (var i = 0; i < n; i++){
            repeater.itemAt(i).color = values[i];
        }
        populateCellValueList(repeater)
        repeatCycle(cellsList, gridW, gridH);
    }


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
        onValueChanged: {
            item.gridWidth = gridW;
            cellsList = [];
        }
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
        onValueChanged: {
            item.gridHeight = gridH;
            cellsList = [];
        }
    }

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
        text: "500"
    }

    Button {
        id: startButton
        text: "Start game"
        anchors.right: stopButton.left
        anchors.rightMargin: 10
        anchors.top: speed.bottom
        anchors.topMargin: 10

        onClicked: {
            populateCellValueList(repeater)
            startButtonClicked(cellsList, gridW, gridH, executionSpeed)
        }
    }

    Button {
        id: stopButton
        text: "Stop game"
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: speed.bottom
        anchors.topMargin: 10

        onClicked: {
            stopButtonClicked()
        }
    }

    function populateCellValueList(rep){
        for (var i = 0; i < rep.count; i++){
            cellsList[i] = rep.itemAt(i).color;
        }
    }

    Item {
        property alias gridWidth: grid.columns
        property alias gridHeight: grid.rows

        id: item
        width: parent.width - 100
        anchors.top: startButton.bottom
        anchors.topMargin: 10
        anchors.left: speedlabel.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        objectName: "gameGrid"

        ScrollView {
            id: gamegrid
            anchors.fill: parent
            clip: true
            contentHeight: grid.height
            contentWidth: grid.width

            Grid {
                id: grid
                rows: 10
                columns: 10
                spacing: 0
                objectName: "gridItem"

                Repeater {
                    id: repeater
                    model: grid.rows * grid.columns
                    objectName: "repeaterItem"

                    Rectangle {
                        id: cell
                        width: 10
                        height: 10
                        border.color: "black"
                        border.width: 0.5
                        objectName: "cell" + index

                        MouseArea {
                            anchors.fill:  cell
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button == Qt.RightButton)
                                    parent.color = 'white'
                                else
                                    parent.color = 'black'
                            }
                        }
                    }
                }
            }
        }
    }
}
