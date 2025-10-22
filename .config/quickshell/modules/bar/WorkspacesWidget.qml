import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 45
	height: 40 * (Workspaces.niriWorkspaces?.length) + 3 * (Workspaces.niriWorkspaces?.length - 1) + 5
	color: "transparent"

	anchors.top: parent.top
	anchors.topMargin: Config.settings.bar.workspacesCenterAligned ? (parent.height / 2) - (height / 2) : 60				

	anchors.left: parent.left

	property int workspaceCount: 5

	Behavior on anchors.topMargin {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}

	ColumnLayout {
		anchors.fill: parent
		spacing: 3

		Repeater {
			model: Workspaces.niriWorkspaces

			Rectangle {
				property bool hovered: false

				Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
				Layout.preferredWidth: Workspaces.niriWorkspaces[index].is_focused ? root.width - 17 : root.width - 18
				Layout.rightMargin: 2

				Layout.preferredHeight: {
					if (hovered)
						return 45;
					if (Workspaces.niriWorkspaces[index].is_focused)
						return 45;
					else
						return 40;
				}

				color: {
					if (Workspaces.niriWorkspaces[index].is_focused)
						return Colours.palette.primary
					else if (Workspaces.niriWorkspaces[index].active_window_id != null)
						return Colours.palette.surface_container
					else
						return "transparent"
				}

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

					anchors.topMargin: Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused ? parent.height / 2 - 6 : parent.height / 2 - 7
					anchors.leftMargin: Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused ? parent.width / 2 - 4.8 : parent.width / 2 - 6.5

					text: Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused ? "" : ""
					color: {
						if (Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused)
							return Qt.alpha(Colours.palette.on_surface, 0.8)
						else if (Workspaces.niriWorkspaces[index].is_focused)
							return Colours.palette.on_primary
						else
							return Colours.palette.outline
					}

					Behavior on color {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}

					font.family: Config.settings.font
					font.pixelSize: Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused ? 11 : 13
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
