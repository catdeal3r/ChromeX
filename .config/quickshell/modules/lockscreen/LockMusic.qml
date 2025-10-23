import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.modules.dashboard.music
import qs.services
import qs.config
import qs.modules.common
import qs.modules

Rectangle {
    id: root
    property int fHeight: 110
    property int fWidth: 490
    property int spacing: 1

    width: fWidth
    height: fHeight
    color: "transparent"
    anchors.centerIn: parent

    function cleanMusicTitle(title) {
		if (!title) return "";
		// Brackets
		title = title.replace(/^ *\([^)]*\) */g, " "); // Round brackets
		title = title.replace(/^ *\[[^\]]*\] */g, " "); // Square brackets
		title = title.replace(/^ *\{[^\}]*\} */g, " "); // Curly brackets
		// Japenese brackets
		title = title.replace(/^ *【[^】]*】/, "") // Touhou
		title = title.replace(/^ *《[^》]*》/, "") // ??
		title = title.replace(/^ *「[^」]*」/, "") // OP/ED thingie
		title = title.replace(/^ *『[^』]*』/, "") // OP/ED thingie

		return title.trim();
	}

    function isRealPlayer(player) {
        // return true
        return (
            // Remove unecessary native buses from browsers if there's plasma integration
            !(false && player.dbusName.startsWith('org.mpris.MediaPlayer2.firefox')) &&
            !(false && player.dbusName.startsWith('org.mpris.MediaPlayer2.chromium')) &&
            // playerctld just copies other buses and we don't need duplicates
            !player.dbusName?.startsWith('org.mpris.MediaPlayer2.playerctld') &&
            // Non-instance mpd bus
            !(player.dbusName?.endsWith('.mpd') && !player.dbusName.endsWith('MediaPlayer2.mpd'))
        );
    }
    function filterDuplicatePlayers(players) {
        let filtered = [];
        let used = new Set();

        for (let i = 0; i < players.length; ++i) {
            if (used.has(i)) continue;
            let p1 = players[i];
            let group = [i];

            // Find duplicates by trackTitle prefix
            for (let j = i + 1; j < players.length; ++j) {
                let p2 = players[j];
                if (p1.trackTitle && p2.trackTitle &&
                    (p1.trackTitle.includes(p2.trackTitle) 
                        || p2.trackTitle.includes(p1.trackTitle))
                        || (p1.position - p2.position <= 2 && p1.length - p2.length <= 2)) {
                    group.push(j);
                }
            }

            // Pick the one with non-empty trackArtUrl, or fallback to the first
            let chosenIdx = group.find(idx => players[idx].trackArtUrl && players[idx].trackArtUrl.length > 0);
            if (chosenIdx === undefined) chosenIdx = group[0];

            filtered.push(players[chosenIdx]);
            group.forEach(idx => used.add(idx));
        }
        return filtered;
    }
	
	readonly property var realPlayers: Mpris.players.values.filter(player => isRealPlayer(player))
    readonly property var meaningfulPlayers: filterDuplicatePlayers(realPlayers)
    property var player: meaningfulPlayers[0]

    RowLayout {
        height: root.fHeight - 20
        width: root.fWidth - 40
        
        anchors.top: parent.top
        anchors.topMargin: 10

        anchors.left: parent.left
        anchors.leftMargin: (root.fWidth / 2) - (width / 2)
        spacing: root.spacing

		
		ClippingWrapperRectangle { //image
			id: art
			
			radius: Config.settings.borderRadius
			width: 90
			height: 90
			
			Layout.alignment: Qt.AlignLeft
								
			color: Colours.palette.surface_container
			
			Rectangle {
				anchors.fill: parent
				color: "transparent"
			
				Loader {
					anchors.fill: parent
					active: ( root.player?.trackArtUrl != "" )
				
					sourceComponent: Item {
						anchors.fill: parent

						Image {
							id: backgroundImage
							anchors.fill: parent
							source: root.player?.trackArtUrl
							fillMode: Image.PreserveAspectCrop
                            layer.enabled: true
                            layer.effect: MultiEffect {
                                saturation: Config.settings.colours.genType == "scheme-monochrome" && !Config.settings.colours.useCustom ? -1.0 : 1.0
                            }
						}
					}
				}

				Loader {
					anchors.centerIn: parent
					active: ( root.player?.trackArtUrl == "" ) || root.meaningfulPlayers.length == 0
				
					sourceComponent: Text {
						anchors.centerIn: parent
						
						color: Colours.palette.outline
						text: "music_note"
						font.family: Config.settings.iconFont
						font.pixelSize: art.width / 3
					}
				}
			}
        }
        
        Rectangle {
			Layout.preferredHeight: 50
            Layout.preferredWidth: 180
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
			
			color: "transparent"

            Text {
				anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 12
				font.pixelSize: 18
				font.family: Config.settings.font

                opacity: (root.meaningfulPlayers.length == 0) ? 1 : 0
					
				color: Colours.palette.on_surface
				text: "No media playing"

                Behavior on opacity {
                    PropertyAnimation {
                        duration: Config.settings.animationSpeed
                        easing.type: Easing.InSine
                    }
                }	
			}
		
			ColumnLayout {
                spacing: 10

                opacity: (root.meaningfulPlayers.length == 0) ? 0 : 1

                Behavior on opacity {
                    PropertyAnimation {
                        duration: Config.settings.animationSpeed
                        easing.type: Easing.InSine
                    }
                }
				
				TextMetrics {
					id: titleMetrics
										
					text: root.cleanMusicTitle(root.player?.trackTitle) || "Untitled"
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 110
				}

				Text {
					Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
					font.pixelSize: 20
					font.family: Config.settings.font
                    font.weight: 600

                    Layout.preferredHeight: 20
                    Layout.preferredWidth: 60
					
					color: Colours.palette.on_surface
					text: titleMetrics.elidedText
					
				}
					
				Text {
					Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
					color: Qt.alpha(Colours.palette.on_surface, 0.7)
					font.pixelSize: 18
					font.family: Config.settings.font

                    Layout.preferredHeight: 20
                    Layout.preferredWidth: 60
						
					text: artistMetrics.elidedText
				}
				
				TextMetrics {
					id: artistMetrics
										
					text: root.cleanMusicTitle(root.player?.trackArtist) || "Unknown Artist"
					font.family: Config.settings.font
										
					elide: Qt.ElideRight
					elideWidth: 110
				}
			}
		}

        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: 120
            Layout.alignment: Qt.AlignVCenter

            color: "transparent"

            RowLayout {
                spacing: 10

                opacity: (root.meaningfulPlayers.length == 0) ? 0 : 1

                Behavior on opacity {
                    PropertyAnimation {
                        duration: Config.settings.animationSpeed
                        easing.type: Easing.InSine
                    }
                }

                PlayerControl {
                    Layout.alignment: Qt.AlignHCenter
                    iconName: "skip_previous"
                    toRun: () => root.player?.previous()
                }
                
                PlayerControl {
                    Layout.alignment: Qt.AlignHCenter
                    iconName: root.player?.isPlaying ? "pause" : "play_arrow"

                    toRun: () => root.player.togglePlaying()

                    width: 40
                    height: 40

                    bgColour: Colours.palette.surface
	                colour: Colours.palette.on_surface
	
	                bgColourHovered: Colours.palette.primary
	                colourHovered: Colours.palette.on_primary
                }
                
                PlayerControl {
                    Layout.alignment: Qt.AlignHCenter
                    iconName: "skip_next"
                    toRun: () => root.player?.next()
                }
            }
        }
	}
}

