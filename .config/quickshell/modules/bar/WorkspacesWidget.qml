import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 45
	height: 40 * Workspaces.niriWorkspaces.length + 5
	color: Colours.palette.surface

	anchors.top: parent.top
	anchors.topMargin: (parent.height / 2) - (height / 2)

	anchors.left: parent.left

	property int workspaceCount: 5

	ColumnLayout {
		anchors.fill: parent
		spacing: 3

		Repeater {
			model: Workspaces.niriWorkspaces

			Rectangle {
				property bool hovered: false

				Layout.alignment: Qt.AlignHCenter
				Layout.preferredWidth: Workspaces.niriWorkspaces[index].is_focused ? root.width - 17 : root.width - 18

				Layout.preferredHeight: {
					if (hovered)
						return 45;
					if (Workspaces.niriWorkspaces[index].is_focused)
						return 45;
					else
						return 40;
				}

				color: Workspaces.niriWorkspaces[index].is_focused ? Colours.palette.primary : Colours.palette.surface_container

				function getTopRadius() {
					if (hovered)
						return Config.settings.borderRadius;
					if (Workspaces.niriWorkspaces[index].is_focused)
						return Config.settings.borderRadius;
					if (index == 0)
						return Config.settings.borderRadius;
					return 4;
				}

				function getBottomRadius() {
					if (hovered)
						return Config.settings.borderRadius;
					if (Workspaces.niriWorkspaces[index].is_focused)
						return Config.settings.borderRadius;
					if (index + 1 == Workspaces.niriWorkspaces.length)
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
					color: Workspaces.niriWorkspaces[index].is_focused ? Colours.palette.on_primary : Colours.palette.outline

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
