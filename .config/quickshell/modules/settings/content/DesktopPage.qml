import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.settings
import qs.modules.settings.content
import qs.modules.settings.content.generics
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Rectangle {
    id: root
    color: "transparent"
    
    Rectangle {
        id: pageWrapper
        width: parent.width - 30
        height: parent.height - 60

        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (height / 2)

        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent
            spacing: 10

            Text {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 20
                text: "Desktop"
                font.family: Config.settings.font
                font.pixelSize: 20
                color: Colours.palette.on_surface
            }

            GenericSeperator {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 5
                Layout.preferredWidth: pageWrapper.width
                Layout.preferredHeight: 3
            }

            GenericToggleOption {
                message: "Show a rounded border"
                option: Config.settings.desktop.desktopRoundingShown
                toRun: () => Config.settings.desktop.desktopRoundingShown = !Config.settings.desktop.desktopRoundingShown
            }

            GenericToggleOption {
                message: "Dim the wallpaper"
                option: Config.settings.desktop.dimDesktopWallpaper
                toRun: () => Config.settings.desktop.dimDesktopWallpaper = !Config.settings.desktop.dimDesktopWallpaper
            }

            Text {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 20
                text: "Bar"
                font.family: Config.settings.font
                font.pixelSize: 20
                color: Colours.palette.on_surface
            }

            GenericSeperator {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 5
                Layout.preferredWidth: pageWrapper.width
                Layout.preferredHeight: 3
            }

            GenericToggleOption {
                message: "Show smooth edges around bar"
                option: Config.settings.bar.smoothEdgesShown
                toRun: () => Config.settings.bar.smoothEdgesShown = !Config.settings.bar.smoothEdgesShown
            }

            GenericToggleOption {
                message: "Align the workspaces to be in the center of the bar"
                option: Config.settings.bar.workspacesCenterAligned
                toRun: () => Config.settings.bar.workspacesCenterAligned = !Config.settings.bar.workspacesCenterAligned
            }

            Text {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 20
                text: "Dock"
                font.family: Config.settings.font
                font.pixelSize: 20
                color: Colours.palette.on_surface
            }

            GenericSeperator {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 5
                Layout.preferredWidth: pageWrapper.width
                Layout.preferredHeight: 3
            }

            GenericToggleOption {
                message: "Always show dock"
                option: Config.settings.dock.pinned
                toRun: () => Config.settings.dock.pinned = !Config.settings.dock.pinned
            }

            GenericToggleOption {
                message: "Display a seperator between the pinned and unpinned apps"
                option: Config.settings.dock.seperator
                toRun: () => Config.settings.dock.seperator = !Config.settings.dock.seperator
            }

            GenericToggleOption {
                message: "Colour the app icons with the current colourscheme's primary colour"
                option: Config.settings.dock.colouredIcons
                toRun: () => Config.settings.dock.colouredIcons = !Config.settings.dock.colouredIcons
            }

            GenericNumberOption {
                message: "Amount to colour the app icons by"
                value: Config.settings.dock.colouredIconsAmount
                maxValue: 1.0
                minValue: 0.1
                amountIncrease: () => {
                    Config.settings.dock.colouredIconsAmount += 0.1;
                    Config.settings.dock.colouredIconsAmount.toFixed(1);
                }
                amountDecrease: () => {
                    Config.settings.dock.colouredIconsAmount -= 0.1;
                    Config.settings.dock.colouredIconsAmount.toFixed(1);
                }
                isFloat: true
            }
        }
    }
}
