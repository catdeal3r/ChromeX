import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 40
	height: 40 * workspaceCount + 5
	color: Colours.palette.surface

	anchors.top: parent.top
	anchors.topMargin: (parent.height / 2) - (height / 2)

	anchors.left: parent.left

	required property string monitor

	Component.onCompleted: {
		Workspaces.setMonitor(monitor);
	}
	
	property int workspaceCount: 5

	ColumnLayout {
		anchors.fill: parent
		spacing: 3

		Repeater {
			model: workspaceCount

			Rectangle {
				property bool hovered: false

				Layout.alignment: Qt.AlignHCenter
				Layout.preferredWidth: index + 1 == Workspaces.focusedWorkspace ? root.width - 15 : root.width - 16

				Layout.preferredHeight: {
					if (hovered)
						return 45;
					if (index + 1 == Workspaces.focusedWorkspace)
						return 45
					else
						return 40
				}

				color: index + 1 == Workspaces.focusedWorkspace ? Colours.palette.primary : Colours.palette.surface_container

				function getTopRadius() {
					if (hovered)
						return Config.settings.borderRadius;
					if (index + 1 == Workspaces.focusedWorkspace)
						return Config.settings.borderRadius;
					if (index == 0)
						return Config.settings.borderRadius;
					return 4;
				}

				function getBottomRadius() {
					if (hovered)
						return Config.settings.borderRadius;
					if (index + 1 == Workspaces.focusedWorkspace)
						return Config.settings.borderRadius;
					if (index + 1 == root.workspaceCount)
						return Config.settings.borderRadius;
					return 4;
				}

				topLeftRadius: getTopRadius()
				topRightRadius: getTopRadius()

				bottomLeftRadius: getBottomRadius()
				bottomRightRadius: getBottomRadius()

				Behavior on topLeftRadius {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on topRightRadius {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on bottomLeftRadius {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on bottomRightRadius {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on Layout.preferredHeight {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Text {
					anchors.left: parent.left
					anchors.top: parent.top

					anchors.topMargin: parent.height / 2 - 8
					anchors.leftMargin: parent.width / 2 - 6.5

					text: ""
					color: index + 1 == Workspaces.focusedWorkspace ? Colours.palette.on_primary : Colours.palette.outline

					Behavior on color {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}

					font.family: Config.settings.font
					font.pixelSize: 13
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onEntered: parent.hovered = true
					onExited: parent.hovered = false
				}
			}
		}
	}
}
