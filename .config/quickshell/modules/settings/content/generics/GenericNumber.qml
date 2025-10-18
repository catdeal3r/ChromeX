import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config

Rectangle {
    id: root
    required property var value
    required property var maxValue
    required property var minValue
    required property var amountIncrease
    required property var amountDecrease
    required property bool isFloat

    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    color: Colours.palette.surface_container
    radius: Config.settings.borderRadius - 5
    Layout.preferredHeight: 27
    Layout.preferredWidth: 60

    function format() {
        if (root.isFloat)
            return root.value.toFixed(1)
        else
            return root.value
    }

    RowLayout {
        width: parent.width - 10
        height: parent.height - 10

        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (height / 2)

        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)

        Text {
            text: "-"
            font.family: Config.settings.font
            font.pixelSize: 14
            color: root.format() == root.minValue ? Qt.alpha(Colours.palette.on_surface, 0.4) : Colours.palette.on_surface
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (root.isFloat) {
                        if (root.value > root.minValue + 0.1) {
                            root.amountDecrease()
                        }
                    } else {
                        if (root.value > root.minValue + 1) {
                            root.amountDecrease()
                        }
                    }
                }
            }
        }

        Text {
            text: `${root.format()}`
            font.family: Config.settings.font
            font.pixelSize: 13
            color: Colours.palette.on_surface
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }

        Text {
            text: "+"
            font.family: Config.settings.font
            font.pixelSize: 14
            color: root.format() == root.maxValue ? Qt.alpha(Colours.palette.on_surface, 0.4) : Colours.palette.on_surface
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    if (root.isFloat) {
                        if (root.value < root.maxValue - 0.1) {
                            root.amountIncrease()
                        }
                    } else {
                        if (root.value < root.maxValue - 1) {
                            root.amountIncrease()
                        }
                    }
                }
            }
        }
    }
}
