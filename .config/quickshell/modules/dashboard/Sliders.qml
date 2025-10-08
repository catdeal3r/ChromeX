import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.dashboard
import qs.modules.dashboard.sliders
import qs.services
import qs.config
import qs.modules.common
import qs.modules


Rectangle {
    id: root
    property int fHeight: 125
    property int fWidth: parent.parent.width
    property int spacing: 1

    Layout.preferredWidth: fWidth
    Layout.preferredHeight: fHeight
    color: "transparent"

    ColumnLayout {
        height: root.fHeight - 20
        width: root.fWidth - 40
        
        anchors.top: parent.top
        anchors.topMargin: 10

        anchors.left: parent.left
        anchors.leftMargin: (root.fWidth / 2) - (width / 2)
        spacing: root.spacing

        MSlider {
            rWidth: 440
            iconCode: Audio.muted ? "volume_off" : "volume_up"
            value: Audio.volume
            isEnabled: !Audio.muted
            onMoved: Audio.setVolume(value)
        }

        MSlider {
            rWidth: 440
            iconCode: "brightness_medium"
            value: Brightness.brightnessPercent
            onMoved: Brightness.setBrightnessPercent(value)
            to: 100
        }
    }
}