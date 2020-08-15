import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

SpinBox {
    id: sizex
    height: gridsizelabel.height
    width: 150
    editable: true
    stepSize: 50
    to: 10000
    font.pixelSize: gridsizelabel.font.pixelSize
}
