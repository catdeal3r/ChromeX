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
    property bool withIcon: false
    property string iconCode: "settings"
    property int iconSize: 20

    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    Layout.preferredWidth: pageWrapper.width
    Layout.preferredHeight: 50

    Text {
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        Layout.preferredWidth: 5
        text: root.iconCode
        font.family: Config.settings.iconFont
        font.pixelSize: root.iconSize
        visible: root.withIcon
        color: root.option ? Qt.alpha(Colours.palette.on_surface, 0.9) : Qt.alpha(Colours.palette.on_surface, 0.75)

        Behavior on color {
            PropertyAnimation {
                duration: Config.settings.animationSpeed
                easing.type: Easing.InSine
            }
        }
    }

    Text {
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        Layout.preferredWidth: 100
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
