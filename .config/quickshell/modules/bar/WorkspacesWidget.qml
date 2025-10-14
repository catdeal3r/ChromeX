import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 45
	height: 40 * Workspaces.niriWorkspaces.length + 5
	color: "transparent"

	anchors.top: parent.top
	anchors.topMargin: (parent.height / 2) - (height / 2)

	anchors.left: parent.left

	property int workspaceCount: 5

	Rectangle {
		height: root.height + 100
		width: barBase.width
		anchors.top: parent.top
		anchors.topMargin: (parent.height / 2) - (height / 2)
		color: "transparent"

		RRCorner {
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			corner: RRCorner.CornerEnum.TopRight
			size: Config.settings.borderRadius + 5
			color: Colours.palette.surface_container
		}

		Rectangle {
			height: parent.height - ((Config.settings.borderRadius + 5) * 2)
			color: Colours.palette.surface_container
			width: parent.width
			anchors.top: parent.top
			anchors.topMargin: (parent.height / 2) - (height / 2)

			RRCorner {
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				corner: RRCorner.CornerEnum.BottomLeft
				size: Config.settings.borderRadius
				color: Colours.palette.surface
			}

			RRCorner {
				anchors.top: parent.top
				anchors.left: parent.left
				corner: RRCorner.CornerEnum.TopLeft
				size: Config.settings.borderRadius
				color: Colours.palette.surface
			}
		}

		RRCorner {
			anchors.top: parent.top
			anchors.right: parent.right
			corner: RRCorner.CornerEnum.BottomRight
			size: Config.settings.borderRadius + 5
			color: Colours.palette.surface_container
		}
	}

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
					anchors.leftMargin: Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused ? parent.width / 2 - 4.8 : parent.width / 2 - 6.5

					text: Workspaces.niriWorkspaces[index].active_window_id != null && !Workspaces.niriWorkspaces[index].is_focused ? "" : ""
					color: Workspaces.niriWorkspaces[index].is_focused ? Colours.palette.on_primary : Colours.palette.outline

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
