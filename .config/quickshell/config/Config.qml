
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config
import qs.services

Singleton {
	id: root
	
	// Load settings from json
	property var settings: jsonAdapterConfig
	property bool isLoaded: false
	
	FileView {
		id: jsonFileSink
		path: Quickshell.shellDir + "/settings/settings.json"
		
		watchChanges: true
		onFileChanged: {
			root.isLoaded = false
			reload()
		}
		
		onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }
        
        onLoaded: {
			root.isLoaded = true
		}
		
        JsonAdapter {
			id: jsonAdapterConfig
			
			property int minutesBetweenHealthNotif: 30
			
			property JsonObject bar: JsonObject {
				property string barLocation: "bottom"
				property bool smoothEdgesShown: false
				property bool desktopRoundingShown: true
				property bool workspacesCenterAligned: true
			}
			
			property string currentWallpaper: Quickshell.shellDir + "/assets/default_blank.png"
			
			property string font: "SF Pro Display"
			property string iconFont: "Material Symbols Rounded"
			property int borderRadius: 20

			property JsonObject dock: JsonObject {
				property bool pinned: false
				property bool seperator: true
				property bool colouredIcons: false
				property real colouredIconsAmount: 0.5
				property list<string> pinnedApps: [ "org.gnome.Nautilus", "firefox" ]
			}

			property int animationSpeed: 200

			property bool usePfpInsteadOfLogo: false
			property string pfpLocation: "~/.face"
			
			property JsonObject colours: JsonObject {
				property string genType: "scheme-expressive"
				property string mode: "dark"
				property bool useCustom: false
				
				onGenTypeChanged: {
					Wallpaper.changeColourProp()
				}
				
				onModeChanged: {
					Wallpaper.changeColourProp()
				}

				onUseCustomChanged: {
					if (useCustom == false)
						Wallpaper.changeColourProp()
				}
			}

			property JsonObject recorder: JsonObject {
				property string screen: "eDP-1"
				property string encoder: "libx264"
				property string output_loc: "/home/catdealer/"
			}

			property string nightmodeColourTemp: "4500K"
			property bool nightmodeOnStartup: true
			
			property string weatherLocation: "REPLACE"
			
			onWeatherLocationChanged: {
				Weather.reload()
			}
		}
	}
}
