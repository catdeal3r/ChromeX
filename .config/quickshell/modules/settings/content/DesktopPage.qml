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


        ScrollView {
            anchors.fill: parent
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: pageWrapper.width - 20
                spacing: 10

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "Desktop"
                    iconCode: "shelf_auto_hide"
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
                    withIcon: true
                    iconCode: "capture"
                }

                GenericToggleOption {
                    message: "Dim the wallpaper"
                    option: Config.settings.desktop.dimDesktopWallpaper
                    toRun: () => Config.settings.desktop.dimDesktopWallpaper = !Config.settings.desktop.dimDesktopWallpaper
                    withIcon: true
                    iconCode: "brightness_6"
                }

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "Bar"
                    iconCode: "bottom_navigation"
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
                    withIcon: true
                    iconCode: "line_curve"
                }

                GenericToggleOption {
                    message: "Center workspaces in bar"
                    option: Config.settings.bar.workspacesCenterAligned
                    toRun: () => Config.settings.bar.workspacesCenterAligned = !Config.settings.bar.workspacesCenterAligned
                    withIcon: true
                    iconCode: "align_vertical_center"
                }

                GenericToggleOption {
                    message: "Show profile picture instead of icon"
                    option: Config.settings.usePfpInsteadOfLogo
                    toRun: () => Config.settings.usePfpInsteadOfLogo = !Config.settings.usePfpInsteadOfLogo
                    withIcon: true
                    iconCode: "account_circle"
                }

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "Dock"
                    iconCode: "call_to_action"
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
                    withIcon: true
                    iconCode: "bottom_drawer"
                }

                GenericToggleOption {
                    message: "Show a seperator between the pinned and running apps"
                    option: Config.settings.dock.seperator
                    toRun: () => Config.settings.dock.seperator = !Config.settings.dock.seperator
                    withIcon: true
                    iconCode: "splitscreen_right"
                }

                GenericToggleOption {
                    message: "Colour the dock icons with the current colourscheme"
                    option: Config.settings.dock.colouredIcons
                    toRun: () => Config.settings.dock.colouredIcons = !Config.settings.dock.colouredIcons
                    withIcon: true
                    iconCode: "colors"
                }

                GenericNumberOption {
                    message: "Amount to colour the dock icons by"
                    value: Config.settings.dock.colouredIconsAmount
                    maxValue: 1.0
                    minValue: 0.1
                    amountIncrease: () => {
                        if (Config.settings.dock.colouredIconsAmount.toFixed(1) < 1.0) {
                            Config.settings.dock.colouredIconsAmount += 0.1;
                        }
                    }
                    amountDecrease: () => {
                        if (Config.settings.dock.colouredIconsAmount.toFixed(1) > 0.1) {
                            Config.settings.dock.colouredIconsAmount -= 0.1;
                        }
                    }
                    isFloat: true
                    withIcon: true
                    iconCode: "subdirectory_arrow_right"
                }
            }
        }
    }
}
