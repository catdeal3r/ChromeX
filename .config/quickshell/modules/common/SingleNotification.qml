import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Widgets
import QtQuick.Controls

import qs.config
import qs.services
import "root:/scripts/notification_utils.js" as NotificationUtils
import qs.modules.common

/*
Summary:     modelData.summary
Body:        modelData.body
Icon Path:   Qt.resolvedUrl(modelData.appIcon)
Time:        NotificationUtils.getFriendlyNotifTimeString(modelData.time)
App Name:    modelData.appName
*/

Rectangle {
    id: singleNotif
    property bool popup: false
    property bool expanded: false

    property bool areActions: !(modelData.actions.length == 0)

    property var actions: modelData.actions

    radius: Config.settings.borderRadius + 5
    color: singleNotif.popup ? Colours.palette.surface : Qt.alpha(Colours.palette.surface_container_low, 0.6)

    Timer {
        running: true
        repeat: false
        interval: 5000
        onTriggered: Notifications.timeoutNotification(modelData.notificationId)
    }

    implicitHeight: {
        if (expanded)
        {
            if (areActions)
                return 140
            else
                return 100
        }
        else
            return 70
    }

    implicitWidth: 400
    
    Behavior on implicitHeight {
        PropertyAnimation {
            duration: Config.settings.animationSpeed
            easing.type: Easing.InSine
        }
    }
    
    anchors.topMargin: 20

    MouseArea {
		property int startX
        property int startY

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
		acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        onClicked: singleNotif.popup ? Notifications.timeoutNotification(modelData.notificationId) : Notifications.discardNotification(modelData.notificationId)

		onPressed: event => {
            if (singleNotif.popup)
                startY = event.y
            else
		    	startX = event.x;

			if (event.button === Qt.MiddleButton)
				Notifications.discardNotification(modelData.notificationId)
		}

		onPositionChanged: event => {
            if (singleNotif.popup) {
                if (event.y < startY) {
                    Notifications.timeoutNotification(modelData.notificationId)
                }
            } else {
                if (event.x > startX) {
                    Notifications.discardNotification(modelData.notificationId)
                }
            }
		}
    }

    RowLayout {
        anchors.fill: parent
        spacing: Config.settings.borderRadius - 5
        
        Rectangle {
            id: iconImage
            property int size: 40
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.topMargin: Config.settings.borderRadius
            Layout.leftMargin: Config.settings.borderRadius
            Layout.preferredHeight: size
            Layout.preferredWidth: size
            color: "transparent"

            ClippingWrapperRectangle {
                visible: (modelData.appIcon == "") ? false : true
                radius: 1000
                height: iconImage.size
                width: iconImage.size
                color: "transparent"
                
                child: IconImage {
                    id: iconRaw
                    visible: (modelData.appIcon == "" && modelData.image == "") ? false : true
                    source: {
                        if (modelData.image != "")
                            return Qt.resolvedUrl(modelData.image)
                        else if (modelData.appIcon != "")
                            return Quickshell.iconPath(modelData.appIcon)
                    }

                    MultiEffect {
                        source: iconRaw
                        anchors.fill: iconRaw
                        saturation: Config.settings.colours.genType == "scheme-monochrome" ? -1.0 : 1.0
                    }
                }
            }

            Rectangle {
                visible: (modelData.appIcon == "")
                radius: 1000
                height: iconImage.size
                width: iconImage.size
                color: Colours.palette.primary
                
                Text {
                    anchors.centerIn: parent
                    text: "notifications"
                    font.family: Config.settings.iconFont
                    font.pixelSize: 20
                    color: Colours.palette.on_primary
                }
            }
        }

        Rectangle {
            id: textContent
            property int cWidth: singleNotif.implicitWidth - iconImage.size - (Config.settings.borderRadius * 3)
            property int padding: 10

            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.topMargin: Config.settings.borderRadius

            Layout.preferredHeight: {
                if (singleNotif.expanded)
                {
                    if (singleNotif.areActions)
                        return iconImage.size + 60
                    else
                        return iconImage.size + 30
                }
                else
                    return iconImage.size
            }

            Layout.preferredWidth: cWidth
            
            Behavior on Layout.preferredHeight {
                PropertyAnimation {
                    duration: Config.settings.animationSpeed
                    easing.type: Easing.InSine
                }
            }

            color: "transparent"

            ColumnLayout {
                spacing: 3
                anchors.fill: parent

                Rectangle {
                    Layout.preferredHeight: (singleNotif.modelData.body == "") ? 20 : 15
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    Layout.preferredWidth: textContent.cWidth - textContent.padding * 3
                    color: "transparent"

                    RowLayout {
                        spacing: 5
                        
                        TextMetrics {
                            id: summaryElided
                            text: modelData.summary
                            font.family: Config.settings.font
                            elideWidth: textContent.cWidth - 130
                            elide: Text.ElideRight
                        }

                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: summaryElided.elidedText
                            font.family: Config.settings.font
                            font.weight: 500
                            font.pixelSize: 14
                            color: Colours.palette.on_surface
                        }

                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            text: "·"
                            color: Colours.palette.on_surface
                            font.family: Config.settings.font
                            font.weight: 600
                            font.pixelSize: 11
                        }

                        Text {
                            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            color: Colours.palette.outline
                            text: NotificationUtils.getFriendlyNotifTimeString(modelData.time)
                            font.family: Config.settings.font
                            font.weight: 600
                            font.pixelSize: 11
                        }
                    }
                }

                TextMetrics {
                    id: bodyElided
                    text: modelData.body
                    font.family: Config.settings.font
                    elideWidth: textContent.cWidth - textContent.padding
                    elide: Text.ElideRight
                }

                Text {
                    Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                    text: bodyElided.elidedText
                    font.family: Config.settings.font
                    font.weight: 500
                    font.pixelSize: 11
                    visible: {
                        if (singleNotif.expanded) return false
                        if (singleNotif.modelData.body == "") return false
                        return true
                    }

                    color: Qt.alpha(Colours.palette.on_surface, 0.7)
                }

                ScrollView {
                    visible: singleNotif.expanded
                    Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                    implicitWidth: textContent.cWidth - 25
                    implicitHeight: singleNotif.expanded ? 40 : 10

                    ScrollBar.horizontal: ScrollBar {
                        policy: ScrollBar.AlwaysOff
                    }

                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOff
                    }

                    Text {
                        width: 240
                        height: 50
                        text: modelData.body
                        visible: singleNotif.expanded
                        wrapMode: Text.Wrap
                        font.family: Config.settings.font
                        font.weight: 500
                        font.pixelSize: 11
                        color: Qt.alpha(Colours.palette.on_surface, 0.7)
                    }

                    Behavior on implicitHeight {
                        PropertyAnimation {
                            duration: Config.settings.animationSpeed
                            easing.type: Easing.InSine
                        }
                    }
                }
            }

            Rectangle {
                property bool hovered: false
                anchors.top: parent.top
                anchors.right: parent.right
                height: 25
                width: 25
                radius: 1000
                color: hovered ? Colours.palette.surface_container_highest : "transparent"
                visible: bodyElided.elidedText == modelData.body ? false : true
                
                Behavior on color {
                    PropertyAnimation {
                        duration: Config.settings.animationSpeed
                        easing.type: Easing.InSine
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: "keyboard_arrow_up"
                    color: Colours.palette.on_surface
                    font.family: Config.settings.iconFont
                    font.weight: 600
                    font.pixelSize: 13
                    rotation: singleNotif.expanded ? 180 : 0
                    visible: parent.visible
                    
                    Behavior on rotation {
                        PropertyAnimation {
                            duration: Config.settings.animationSpeed
                            easing.type: Easing.InSine
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                    onClicked: singleNotif.expanded = !singleNotif.expanded
                }
            }

            Rectangle {
                id: actionsButtons
                anchors.bottom: parent.bottom
                width: textContent.cWidth - textContent.padding * 3
                height: 25
                visible: singleNotif.areActions && singleNotif.expanded
                color: "transparent"

                RowLayout {
                    spacing: 5

                    Repeater {
                        model: singleNotif.actions

                        delegate: Rectangle {
                            property bool hovered: false
                            Layout.preferredWidth: (actionsButtons.width / singleNotif.actions.length) - 5
                            Layout.preferredHeight: 32
                            radius: hovered ? Config.settings.borderRadius : 5
                            color: {
                                if (singleNotif.popup) {
                                    if (hovered) 
                                        return Qt.alpha(Colours.palette.primary_container, 0.8)
                                    else
                                        return Colours.palette.surface
                                } else {
                                    if (hovered) 
                                        return Qt.alpha(Colours.palette.primary_container, 0.8)
                                    else
                                        return Qt.alpha(Colours.palette.surface_container_low, 0.6)
                                }
                            }

                            Behavior on color {
                                PropertyAnimation {
                                    duration: Config.settings.animationSpeed
                                    easing.type: Easing.InSine
                                }
                            }

                            Behavior on radius {
                                PropertyAnimation {
                                    duration: Config.settings.animationSpeed
                                    easing.type: Easing.InSine
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: modelData.text
                                color: parent.hovered ? Colours.palette.on_primary_container : Colours.palette.on_surface
                                font.family: Config.settings.font
                                font.pixelSize: 10

                                Behavior on color {
                                    PropertyAnimation {
                                        duration: Config.settings.animationSpeed
                                        easing.type: Easing.InSine
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onEntered: parent.hovered = true
                                onExited: parent.hovered = false

                                onClicked: Notifications.attemptInvokeAction(singleNotif.modelData.notificationId, modelData.identifier);
                            }
                        }
                    }
                }
            }
        }
    }
}
