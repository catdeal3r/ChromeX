import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.modules
import qs.modules.desktop
import qs.config
import qs.modules.common

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: desktopWindow
			
			property var modelData
			screen: modelData
			
			anchors {
				top: true
				bottom: true
				left: true
				right: true
			}

			color: Colours.palette.surface
			
			visible: true
			aboveWindows: false
			
			exclusionMode: ExclusionMode.Ignore
			exclusiveZone: 0


			ClippingWrapperRectangle {
				anchors.top: parent.top
				anchors.left: parent.left
				width: Config.settings.bar.desktopRoundingShown ? parent.width - 10 : parent.width
				height: Config.settings.bar.desktopRoundingShown ? parent.height - 10 : parent.height
				anchors.topMargin: (parent.height / 2) - (height / 2)
				anchors.leftMargin: (parent.width / 2) - (width / 2)
				radius: Config.settings.bar.desktopRoundingShown ? Config.settings.borderRadius : 0
				color: "transparent"

				Behavior on radius {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on height {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on width {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}
			
				Image {
					id: background
					source: Config.settings.currentWallpaper
					fillMode: Image.PreserveAspectCrop

					MultiEffect {
						id: darkenEffect
						source: background
						anchors.fill: background
						opacity: {
							if (Config.settings.currentRice == "cavern") {
								if (colorQuantizer.colors[0].hslLightness > 0.5)
									return 1
							}
							return 0
						}
						
						brightness: -0.5
					}
				}
			}
			
			ColorQuantizer {
				id: colorQuantizer
				source: Qt.resolvedUrl(Config.settings.currentWallpaper)
				depth: 0 
				rescaleSize: 128
			}

			Rectangle {
				height: parent.height - 77
				width: Config.settings.borderRadius + 5
				anchors.top: parent.top
				anchors.topMargin: (parent.height / 2) - (height / 2)
				anchors.left: parent.left
				anchors.leftMargin: {
					if (Config.settings.bar.smoothEdgesShown && Config.settings.bar.desktopRoundingShown)
						return 5
					else if (Config.settings.bar.smoothEdgesShown)
						return 0
					else
						return -1 * (Config.settings.borderRadius + 5)
				}
				color: "transparent"

				Behavior on anchors.leftMargin {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Rectangle {
					width: parent.width
					height: parent.height - ((Config.settings.borderRadius + 5) * 2)
					color: Colours.palette.surface
					anchors.top: parent.top
					anchors.topMargin: (parent.height / 2) - (height / 2)
				}

				RRCorner {
					anchors.top: parent.top
					anchors.left: parent.left
					corner: RRCorner.CornerEnum.BottomLeft
					size: Config.settings.borderRadius + 5
					color: Colours.palette.surface
				}

				RRCorner {
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					corner: RRCorner.CornerEnum.TopLeft
					size: Config.settings.borderRadius + 5
					color: Colours.palette.surface
				}
			}
		}
	}
}
