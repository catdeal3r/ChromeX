import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.settings
import qs.modules.settings.sidebar
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Rectangle {
    id: root
    color: "transparent"

    property int location: SettingsControl.settingsLocation

    Rectangle {
        height: 50
        width: parent.width - 20
        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)

        anchors.top: parent.top
        anchors.topMargin: 20 + 50 * root.location + 5 * root.location

        radius: Config.settings.borderRadius + 12
        color: Colours.palette.primary

        Behavior on anchors.topMargin {
            PropertyAnimation {
                duration: Config.settings.animationSpeed
                easing.type: Easing.InSine
            }
        }
    }

    ColumnLayout {
        width: parent.width - 20
        height: parent.height / 3
        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)

        anchors.top: parent.top
        anchors.topMargin: 20

        spacing: 5

        SidebarButton {
            rWidth: parent.width
            rHeight: 50
            bigText: "Desktop"
            iconCode: "shelf_auto_hide"
            toRun: () => SettingsControl.setLocation(0)
            number: 0
            selected: root.location
        }

        SidebarButton {
            rWidth: parent.width
            rHeight: 50
            bigText: "Theming"
            iconCode: "format_paint"
            toRun: () => SettingsControl.setLocation(1)
            number: 1
            selected: root.location
        }

        SidebarButton {
            rWidth: parent.width
            rHeight: 50
            bigText: "Notifications"
            iconCode: "notifications_active"
            iconSize: 23
            toRun: () => SettingsControl.setLocation(2)
            number: 2
            selected: root.location
        }

        SidebarButton {
            rWidth: parent.width
            rHeight: 50
            bigText: "Miscellaneous"
            iconCode: "flare"
            toRun: () => SettingsControl.setLocation(3)
            number: 3
            selected: root.location
        }

        SidebarButton {
            rWidth: parent.width
            rHeight: 50
            bigText: "Components"
            iconCode: "build"
            toRun: () => SettingsControl.setLocation(4)
            number: 4
            selected: root.location
        }

        SidebarButton {
            rWidth: parent.width
            rHeight: 50
            bigText: "About"
            iconCode: "info"
            toRun: () => SettingsControl.setLocation(5)
            number: 5
            selected: root.location
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: 10
        height: 10

        anchors.left: parent.left

        color: "transparent"

        Text {
            id: icon
            anchors.bottom: parent.bottom
            text: "info"
            font.family: Config.settings.iconFont
            font.pixelSize: 14
            color: Qt.alpha(Colours.palette.on_surface, 0.7)
        }

        Text {
            anchors.bottom: parent.bottom
            anchors.left: icon.right
            anchors.leftMargin: 5
            text: "Not all option are currently available in this window. Visit ~/.config/quickshell/settings/settings.json for the full list."
            font.family: Config.settings.font
            font.pixelSize: 13
            color: Qt.alpha(Colours.palette.on_surface, 0.7)
        }
    }
}