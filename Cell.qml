import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Rectangle {
    property alias cellX: cell.x
    property alias cellY: cell.y
    property alias cellColor: cell.color
    property alias cellWidth: cell.width
    id: cell
    x: 0
    y: 0
    width: 20
    height: width
    color: "#ffffff"
    border.color: "black"
}
