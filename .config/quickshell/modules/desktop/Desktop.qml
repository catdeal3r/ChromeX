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

			Connections {
				target: Config.settings

				function onWallpaperToSetChanged() {
					realWallpaper.opacity = 0;
				}
			}

			ClippingWrapperRectangle {
				id: wallpaperUnderlay
				anchors.top: parent.top
				anchors.left: parent.left
				width: Config.settings.desktop.desktopRoundingShown ? parent.width - 10 : parent.width
				height: Config.settings.desktop.desktopRoundingShown ? parent.height - 10 : parent.height
				anchors.topMargin: (parent.height / 2) - (height / 2)
				anchors.leftMargin: (parent.width / 2) - (width / 2)
				radius: Config.settings.desktop.desktopRoundingShown ? Config.settings.borderRadius : 0
				color: "transparent"
				opacity: 1

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
					id: backgroundUnderlay
					source: Config.settings.wallpaperToSet
					fillMode: Image.PreserveAspectCrop

					MultiEffect {
						id: darkenEffectUnderlay
						source: backgroundUnderlay
						anchors.fill: background
						opacity: Config.settings.desktop.dimDesktopWallpaper ? 1 : 0

						Behavior on opacity {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}
						
						brightness: -0.1
					}
				}
			}

			ClippingWrapperRectangle {
				id: realWallpaper
				anchors.top: parent.top
				anchors.left: parent.left
				width: Config.settings.desktop.desktopRoundingShown ? parent.width - 10 : parent.width
				height: Config.settings.desktop.desktopRoundingShown ? parent.height - 10 : parent.height
				anchors.topMargin: (parent.height / 2) - (height / 2)
				anchors.leftMargin: (parent.width / 2) - (width / 2)
				radius: Config.settings.desktop.desktopRoundingShown ? Config.settings.borderRadius : 0
				color: "transparent"
				opacity: 1

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

				Behavior on opacity {
					PropertyAnimation {
						duration: Config.settings.animationSpeed + 400
						easing.type: Easing.InSine
					}
				}

				onOpacityChanged: {
					if (opacity === 0) {
						Config.settings.currentWallpaper = Config.settings.wallpaperToSet
						realWallpaper.opacity = 1;
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
						opacity: Config.settings.desktop.dimDesktopWallpaper ? 1 : 0

						Behavior on opacity {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}
						
						brightness: -0.1
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
				height: {
					if (!Config.settings.componentControl.dockIsEnabled)
						return parent.height - 77
					if (Config.settings.dock.pinned)
						return parent.height - 114
					else
						return parent.height - 77
				}
				width: Config.settings.borderRadius + 5
				anchors.top: parent.top
				anchors.topMargin: Config.settings.dock.pinned ? 37 : (parent.height / 2) - (height / 2)
				anchors.left: parent.left
				anchors.leftMargin: {
					if (Config.settings.bar.smoothEdgesShown && Config.settings.desktop.desktopRoundingShown)
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
