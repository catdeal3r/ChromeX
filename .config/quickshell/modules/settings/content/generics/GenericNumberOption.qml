import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.settings.content
import qs.config

RowLayout {
    id: root
    property string message: "Placeholder"
    required property var value
    required property var maxValue
    required property var minValue
    required property var amountIncrease
    required property var amountDecrease
    required property bool isFloat

    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    Layout.preferredWidth: pageWrapper.width
    Layout.preferredHeight: 50

    Text {
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        text: root.message
        font.family: Config.settings.font
        font.pixelSize: 15
        color: Qt.alpha(Colours.palette.on_surface, 0.9)

        Behavior on color {
            PropertyAnimation {
                duration: Config.settings.animationSpeed
                easing.type: Easing.InSine
            }
        }
    }

    GenericNumber {
        value: root.value
        maxValue: root.maxValue
        minValue: root.minValue
        amountIncrease: root.amountIncrease
        amountDecrease: root.amountDecrease
        isFloat: root.isFloat
    }
}
