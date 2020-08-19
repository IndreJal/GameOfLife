import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Window {
    property alias gridW: sizex.value
    property alias gridH: sizey.value
    property alias executionSpeed: speed.text
    property var cellsList: []

    signal goButtonClicked(var cells, int w, int h)

    id: window
    visible: true
    width: 500
    height: 500
    title: qsTr("Game of Life")
    objectName: "MainWindow"

    function setGridValues(values, n){
        console.log("sqml slot received");
        for (var i = 0; i < n; i++){
            repeater.itemAt(i).color = values[i];
        }
        //delay(1000);
        //populateCellValueList(repeater);
        //goButtonClicked(cellsList, gridW, gridH);

    }

    function delay(duration) { // In milliseconds
        var timeStart = new Date().getTime();

        while (new Date().getTime() - timeStart < duration) {
            // Do nothing
        }
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
            goButtonClicked2("sizex");
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
            goButtonClicked2("sizey");
            item.gridHeight = gridH;
            cellsList = [];
        }
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
            //goButtonClicked(gamegrid)
            populateCellValueList(repeater)
            goButtonClicked(cellsList, gridW, gridH)
        }

    }

    function populateCellValueList(rep){
        console.log("populateCellValueList start");
        for (var i = 0; i < rep.count; i++){
            cellsList[i] = rep.itemAt(i).color;
        }
        console.log("populateCellValueList end")
    }

    Item {
        property alias gridWidth: grid.columns
        property alias gridHeight: grid.rows

        id: item
        width: parent.width - 100
        anchors.top: goButton.bottom
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
