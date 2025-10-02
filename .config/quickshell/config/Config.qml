
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
			}
			
			property string currentWallpaper: Quickshell.shellDir + "/assets/default_blank.png"
			
			onCurrentWallpaperChanged: {
				Wallpaper.loadWallpaper()
			}
			
			property string font: "SF Pro Display"
			property string iconFont: "Material Symbols Rounded"
			property int borderRadius: 20

			property int animationSpeed: 200
			
			property JsonObject colours: JsonObject {
				property string genType: "scheme-expressive"
				property string mode: "dark"
				
				onGenTypeChanged: {
					Wallpaper.changeColourProp()
				}
				
				onModeChanged: {
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
			
			onBorderRadiusChanged: {
				Quickshell.execDetached(["swaymsg", "corner_radius", `${root.settings.borderRadius}`])
			}
			
			
			property string weatherLocation: "REPLACE"
			
			onWeatherLocationChanged: {
				Weather.reload()
			}
		}
	}
}
