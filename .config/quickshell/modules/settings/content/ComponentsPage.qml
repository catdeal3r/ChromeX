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
                    text: "Components"
                    iconCode: "build"
                }

                GenericSeperator {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.topMargin: 5
                    Layout.preferredWidth: pageWrapper.width
                    Layout.preferredHeight: 3
                }

                GenericToggleOption {
                    message: "Bar"
                    option: Config.settings.componentControl.barIsEnabled
                    toRun: () => Config.settings.componentControl.barIsEnabled = !Config.settings.componentControl.barIsEnabled
                    withIcon: true
                    iconCode: "bottom_navigation"
                }

                GenericToggleOption {
                    message: "Dashboard"
                    option: Config.settings.componentControl.dashboardIsEnabled
                    toRun: () => Config.settings.componentControl.dashboardIsEnabled = !Config.settings.componentControl.dashboardIsEnabled
                    withIcon: true
                    iconCode: "devices_other"
                }

                GenericToggleOption {
                    message: "Notification Server"
                    option: Config.settings.componentControl.notifsIsEnabled
                    toRun: () => Config.settings.componentControl.notifsIsEnabled = !Config.settings.componentControl.notifsIsEnabled
                    withIcon: true
                    iconCode: "notifications_active"
                }

                GenericToggleOption {
                    message: "Launcher"
                    option: Config.settings.componentControl.launcherIsEnabled
                    toRun: () => Config.settings.componentControl.launcherIsEnabled = !Config.settings.componentControl.launcherIsEnabled
                    withIcon: true
                    iconCode: "rocket_launch"
                }

                GenericToggleOption {
                    message: "Dock"
                    option: Config.settings.componentControl.dockIsEnabled
                    toRun: () => Config.settings.componentControl.dockIsEnabled = !Config.settings.componentControl.dockIsEnabled
                    withIcon: true
                    iconCode: "call_to_action"
                }

                GenericToggleOption {
                    message: "Desktop"
                    option: Config.settings.componentControl.desktopIsEnabled
                    toRun: () => Config.settings.componentControl.desktopIsEnabled = !Config.settings.componentControl.desktopIsEnabled
                    withIcon: true
                    iconCode: "shelf_auto_hide"
                }

                GenericToggleOption {
                    message: "Lockscreen"
                    option: Config.settings.componentControl.lockscreenIsEnabled
                    toRun: () => Config.settings.componentControl.lockscreenIsEnabled = !Config.settings.componentControl.lockscreenIsEnabled
                    withIcon: true
                    iconCode: "lock_person"
                }
            }
        }
    }
}
