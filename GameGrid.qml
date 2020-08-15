import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Item {
    property alias gridWidth: grid.columns
    property alias gridHeight: grid.rows

    id: item

    ScrollView {


        id: gamegrid
        anchors.fill: parent
        clip: true
        contentHeight: grid.height
        contentWidth: grid.width

        Grid {
            id: grid
            rows: 195
            columns: 195
            spacing: 0

            Repeater {
                id: repeater
                model: grid.rows * grid.columns


                Rectangle {
                    id: cell
                    width: 10
                    height: 10
                    border.color: "black"
                    border.width: 0.5

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
/*
ScrollView {
    id: gamegrid
    anchors.topMargin: 10
    anchors.right: parent.right
    anchors.rightMargin: 50
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    anchors.left: parent.left
    anchors.leftMargin: 50
*/
/*
    {
        for(var i = 0; i < 9; i++)  {
            console.log(i)
            i++
        }
    }
    */


    /*
    TextArea {
        //anchors.fill: parent
        text: "The Qt QML module provides a framework for developing applications and libraries with the QML language.
        It defines and implements the language and engine infrastructure, and provides an API to enable application developers to
        extend the QML language with custom types and integrate QML code with JavaScript and C++.

        The Qt QML module provides both a QML API and a C++ API.
        Note that while the Qt QML module provides the language and infrastructure for QML applications,
        the Qt Quick module provides many visual components, model-view support, an animation framework,
        and much more for building user interfaces.
        For those new to QML and Qt Quick, please see QML Applications for an introduction to writing QML applications.

The Qt QML module provides a framework for developing applications and libraries with the QML language.
        It defines and implements the language and engine infrastructure, and provides an API to enable application developers to
        extend the QML language with custom types and integrate QML code with JavaScript and C++.

        The Qt QML module provides both a QML API and a C++ API.
        Note that while the Qt QML module provides the language and infrastructure for QML applications,
        the Qt Quick module provides many visual components, model-view support, an animation framework,
        and much more for building user interfaces.
        For those new to QML and Qt Quick, please see QML Applications for an introduction to writing QML applications.

The Qt QML module provides a framework for developing applications and libraries with the QML language.
        It defines and implements the language and engine infrastructure, and provides an API to enable application developers to
        extend the QML language with custom types and integrate QML code with JavaScript and C++.

        The Qt QML module provides both a QML API and a C++ API.
        Note that while the Qt QML module provides the language and infrastructure for QML applications,
        the Qt Quick module provides many visual components, model-view support, an animation framework,
        and much more for building user interfaces.
        For those new to QML and Qt Quick, please see QML Applications for an introduction to writing QML applications."
        wrapMode: TextArea.Wrap
        font.pixelSize: 12
    }
    */
//}
