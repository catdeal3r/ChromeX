
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

Singleton {
	id: root
	
	function setNewWallpaper(path) {
		Config.settings.secondPreviousWallpaper = `${Config.settings.previousWallpaper}`;
		Config.settings.previousWallpaper = `${Config.settings.currentWallpaper}`;
		Config.settings.wallpaperToSet = `${path}`;
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${path}`]);

		Quickshell.execDetached(["notify-send", "Wallpaper and theme set!", "Log out and in for the gtk4 theme to take effect."]);
	}
	
	function changeColourProp() {
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${Config.settings.currentWallpaper}`]);
	}
}
