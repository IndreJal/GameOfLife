import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

//NOT USED

Item {
    property alias gridWidth: grid.columns
    property alias gridHeight: grid.rows
    property alias repeaterItem: repeater
    id: item




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
