import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

TextField {
    height: gridsizelabel.height
    width: 50
    placeholderText: qsTr("1000")
    font.pixelSize: gridsizelabel.font.pixelSize
}
