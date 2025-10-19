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
    property bool option
    property string message: "Placeholder"
    property var toRun
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
        color: root.option ? Qt.alpha(Colours.palette.on_surface, 0.9) : Qt.alpha(Colours.palette.on_surface, 0.75)

        Behavior on color {
            PropertyAnimation {
                duration: Config.settings.animationSpeed
                easing.type: Easing.InSine
            }
        }
    }

    GenericToggle {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        rWidth: 60
        rHeight: 27
        isToggled: root.option
        toRun: root.toRun
    }
}
