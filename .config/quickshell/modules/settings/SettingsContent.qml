import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.settings
import qs.modules.settings.content
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Rectangle {
    color: "transparent"

    SwipeView {
        anchors.fill: parent
        currentIndex: SettingsControl.settingsLocation
        interactive: false
        orientation: Qt.Vertical

        DesktopPage {}

        ThemingPage {}

        GenericPageWrapper {
            page: 2
        }

        GenericPageWrapper {
            page: 3
        }

        ComponentsPage {}

        AboutPage {}
    }
}