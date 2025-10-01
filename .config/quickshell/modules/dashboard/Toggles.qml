import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.dashboard
import qs.modules.dashboard.toggles
import qs.services
import qs.config
import qs.modules.common
import qs.modules


Rectangle {
    id: root
    property int fHeight: 350
    property int fWidth: parent.parent.width
    property int padding: 10
    property int spacing: 10

    property int rowHeight: 90
    property int wideBtnWidth: (rowHeight * 2) + 60
    property int cudeBtnWidth: (rowHeight - (spacing / 2)) + 30

    Layout.preferredWidth: fWidth
    Layout.preferredHeight: fHeight
    color: "transparent"

    ColumnLayout {
        height: root.fHeight - 20
        width: root.fWidth - 20
        
        anchors.top: parent.top
        anchors.topMargin: 15

        anchors.left: parent.left
        anchors.leftMargin: (root.fWidth / 2) - (width / 2)
        spacing: root.spacing

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.rowHeight
            spacing: root.spacing

            /*Rectangle {
                Layout.preferredHeight: root.rowHeight
                Layout.preferredWidth: root.wideBtnWidth
                radius: Config.settings.borderRadius
            }*/

            WideToggle {
                rWidth: root.wideBtnWidth
                rHeight: root.rowHeight

				isToggled: Network.getBool()
					
				bigText: Network.textLabel
                smallText: {
                    if (Network.textLabel == "Disconnected")
                        return "Not connected to Wifi"
                    else if (Network.textLabel == "Network Off")
                        return "Wifi disabled"
                    else
                        return "Connected"
                }

				iconCode: Network.getIcon()
					
				toRun: () => Quickshell.execDetached([ `${Quickshell.shellDir}/scripts/network.out` ])
			}

            CubeToggle {
                rWidth: root.cudeBtnWidth
                rHeight: root.rowHeight
			}

            CubeToggle {
                rWidth: root.cudeBtnWidth
                rHeight: root.rowHeight

				isToggled: Notifications.popupInhibited
					
				bigText: Notifications.popupInhibited ? "Do Not\nDisturb" : "Disturb"
				iconCode: Notifications.popupInhibited ? "do_not_disturb_on" : "do_not_disturb_off"

                iconSize: 25
	
				toRun: () => Notifications.toggleDND()
			}
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.rowHeight
            spacing: root.spacing

            WideToggle {
                rWidth: root.wideBtnWidth
                rHeight: root.rowHeight

				isToggled: Bluetooth.getBool()
					
				bigText: Bluetooth.textLabel
                smallText: {
                    if (Bluetooth.textLabel == "Not Connected")
                        return "No devices connected"
                    else if (Bluetooth.textLabel == "Bluetooth Off")
                        return "Wireless disabled"
                    else
                        return "Connected"
                }

				iconCode: Bluetooth.getIcon()
					
					
				toRun: () => Bluetooth.toggle()
			}


            WideToggle {
                rWidth: root.wideBtnWidth
                rHeight: root.rowHeight
			}
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.rowHeight
            spacing: 5
            
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: root.rowHeight
            spacing: 5
            
        }
    }
}