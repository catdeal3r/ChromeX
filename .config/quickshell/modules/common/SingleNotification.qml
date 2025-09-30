import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick.Layouts
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
    radius: Config.settings.borderRadius + 5
    color: Colours.palette.surface
    implicitHeight: expanded ? 100 : 70
    implicitWidth: 400
    
    Behavior on implicitHeight {
        PropertyAnimation {
            duration: 150
            easing.type: Easing.InSine
        }
    }
    
    anchors.topMargin: 20

    MouseArea {
		property int startX

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
		acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        onClicked: singleNotif.popup ? Notifications.timeoutNotification(modelData.id) : Notifications.discardNotification(modelData.id)

		onPressed: event => {
			startX = event.x;
			if (event.button === Qt.MiddleButton)
				Notifications.discardNotification(modelData.id)
		}

		onPositionChanged: event => {
			if (event.x > startX) {
				if (singleNotif.popup)
					Notifications.timeoutNotification(modelData.id)
				else 
					Notifications.discardNotification(modelData.id)
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
                
                IconImage {
                    visible: (modelData.appIcon == "") ? false : true
                    source: Qt.resolvedUrl(modelData.appIcon)
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
                    text: "view_object_track"
                    font.family: Config.settings.iconFont
                    font.pixelSize: 19
                    color: Colours.palette.on_primary
                }
            }
        }

        Rectangle {
            id: textContent
            property int cWidth: singleNotif.implicitWidth - iconImage.size - (Config.settings.borderRadius * 3)
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.topMargin: Config.settings.borderRadius
            Layout.preferredHeight: singleNotif.expanded ? iconImage.size + 30 : iconImage.size
            Layout.preferredWidth: cWidth
            
            Behavior on Layout.preferredHeight {
                PropertyAnimation {
                    duration: 150
                    easing.type: Easing.InSine
                }
            }

            color: "transparent"

            ColumnLayout {
                spacing: 5

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
                        text: "·"
                        color: Colours.palette.on_surface
                        font.family: Config.settings.font
                        font.weight: 600
                        font.pixelSize: 11
                    }

                    Text {
                        color: Colours.palette.outline
                        text: NotificationUtils.getFriendlyNotifTimeString(modelData.time)
                        font.family: Config.settings.font
                        font.weight: 600
                        font.pixelSize: 11
                    }
                }

                TextMetrics {
                    id: bodyElided
                    text: modelData.body
                    font.family: Config.settings.font
                    elideWidth: textContent.cWidth - 10
                    elide: Text.ElideRight
                }

                Text {
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                    text: bodyElided.elidedText
                    font.family: Config.settings.font
                    font.weight: 500
                    font.pixelSize: 11
                    visible: !singleNotif.expanded
                    color: Qt.alpha(Colours.palette.on_surface, 0.7)
                }

                ScrollView {
                    visible: singleNotif.expanded
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
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
                            duration: 150
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
                        duration: 150
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
                            duration: 150
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
        }
    }
}
