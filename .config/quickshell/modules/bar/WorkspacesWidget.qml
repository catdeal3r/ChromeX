import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 40
	height: 40 * workspaceCount
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
				Layout.alignment: Qt.AlignHCenter
				Layout.preferredWidth: index + 1 == Workspaces.focusedWorkspace ? root.width - 15 : root.width - 17
				Layout.preferredHeight: 40
				Layout.rightMargin: 2

				color: index + 1 == Workspaces.focusedWorkspace ? Colours.palette.primary : Colours.palette.surface_container

				function getTopRadius() {
					if (index + 1 == Workspaces.focusedWorkspace)
						return Config.settings.borderRadius;
					if (index == 0)
						return Config.settings.borderRadius;
					return 4;
				}

				function getBottomRadius() {
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
						duration: 200
						easing.type: Easing.InSine
					}
				}

				Behavior on topRightRadius {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}

				Behavior on bottomLeftRadius {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}

				Behavior on bottomRightRadius {
					PropertyAnimation {
						duration: 200
						easing.type: Easing.InSine
					}
				}

				Text {
					anchors.left: parent.left
					anchors.top: parent.top

					anchors.topMargin: parent.height / 2 - 8
					anchors.leftMargin: parent.width / 2 - 6.5

					text: ""//index + 1
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
			}
		}
	}
}
