import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.settings
import qs.modules.settings.content
import qs.modules.settings.content.generics
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Rectangle {
    id: root
    color: "transparent"
    
    Rectangle {
        id: pageWrapper
        width: parent.width - 30
        height: parent.height - 60

        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (height / 2)

        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)
        color: "transparent"


        ScrollView {
            anchors.fill: parent
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: pageWrapper.width - 20
                spacing: 10

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "Wallpaper"
                    iconCode: "image"
                }

                GenericSeperator {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.topMargin: 5
                    Layout.preferredWidth: pageWrapper.width
                    Layout.preferredHeight: 3
                }

                RowLayout {
                    Layout.preferredWidth: pageWrapper.width
                    Layout.preferredHeight: pageWrapper.width / 2
                    spacing: 5

                    ClippingWrapperRectangle {
                        color: "transparent"
                        radius: Config.settings.borderRadius
                        Layout.preferredWidth: {
                            if (Config.settings.currentWallpaper === Config.settings.previousWallpaper && Config.settings.currentWallpaper === Config.settings.secondPreviousWallpaper)
                                return pageWrapper.width
                            else
                                return pageWrapper.width - ((pageWrapper.width / 4) + 10)
                        }
                        Layout.preferredHeight: pageWrapper.width / 2

                        Behavior on Layout.preferredWidth {
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

                    ColumnLayout {
                        Layout.preferredWidth: pageWrapper.width / 4
                        Layout.preferredHeight: pageWrapper.width / 2

                        spacing: 8

                        ClippingWrapperRectangle {
                            color: "transparent"
                            radius: Config.settings.borderRadius
                            Layout.preferredWidth: pageWrapper.width / 4
                            Layout.preferredHeight: {
                                if (Config.settings.previousWallpaper === Config.settings.secondPreviousWallpaper)
                                    return pageWrapper.width / 2
                                else
                                    return (pageWrapper.width / 4) - 5
                            }

                            Behavior on Layout.preferredHeight {
                                PropertyAnimation {
                                    duration: Config.settings.animationSpeed
                                    easing.type: Easing.InSine
                                }
                            }

                            Image {
                                source: Config.settings.previousWallpaper
                                fillMode: Image.PreserveAspectCrop

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: Wallpaper.setNewWallpaper(Config.settings.previousWallpaper)
                                }
                            }
                        }

                        ClippingWrapperRectangle {
                            color: "transparent"
                            radius: Config.settings.borderRadius
                            Layout.preferredWidth: pageWrapper.width / 4
                            Layout.preferredHeight: (pageWrapper.width / 4) - 5
                            opacity: Config.settings.previousWallpaper === Config.settings.secondPreviousWallpaper ? 0 : 1

                            Behavior on opacity {
                                PropertyAnimation {
                                    duration: Config.settings.animationSpeed
                                    easing.type: Easing.InSine
                                }
                            }

                            Image {
                                source: Config.settings.secondPreviousWallpaper
                                fillMode: Image.PreserveAspectCrop

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor

                                    onClicked: Wallpaper.setNewWallpaper(Config.settings.secondPreviousWallpaper)
                                }
                            }
                        }
                    }
                }

                /*

                    Need to rethink this .... a bit too clunky currently

                Rectangle {
                    id: wallpaperPickerBtn
                    property bool hovered: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 200
                    color: hovered ? Colours.palette.surface_container : Colours.palette.surface

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: wallpaperPickerBtn.hovered = true
                        onExited: wallpaperPickerBtn.hovered = false
                        onClicked: wallpaperDialog.open()
                    }
                }

                FileDialog {
                    id: wallpaperDialog
                    currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                    onAccepted: Wallpaper.setNewWallpaper(selectedFile)
                }*/

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "Style"
                    iconCode: "brush"
                }

                GenericSeperator {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.topMargin: 5
                    Layout.preferredWidth: pageWrapper.width
                    Layout.preferredHeight: 3
                }

                GenericNumberOption {
                    message: "Border radius"
                    value: Config.settings.borderRadius
                    maxValue: 30
                    minValue: 5
                    amountIncrease: () => {
                        Config.settings.borderRadius += 1;
                    }
                    amountDecrease: () => {
                        Config.settings.borderRadius -= 1;
                    }
                    isFloat: false
                    withIcon: true
                    iconCode: "rounded_corner"
                }

                GenericNumberOption {
                    message: "Animation speed (seconds)"
                    value: Config.settings.animationSpeed / 1000
                    maxValue: 2
                    minValue: 0.1
                    amountIncrease: () => {
                        Config.settings.animationSpeed += 100;
                    }
                    amountDecrease: () => {
                        Config.settings.animationSpeed -= 100;
                    }
                    isFloat: true
                    withIcon: true
                    iconCode: "speed"
                }

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "Colours"
                    iconCode: "colors"
                }

                GenericSeperator {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.topMargin: 5
                    Layout.preferredWidth: pageWrapper.width
                    Layout.preferredHeight: 3
                }

                GenericToggleOption {
                    message: "Use dark mode"
                    option: Config.settings.colours.mode === "dark"
                    toRun: () => {
                        if (Config.settings.colours.mode === "dark")
                            Config.settings.colours.mode = "light"
                        else
                            Config.settings.colours.mode = "dark"
                    }
                    withIcon: true
                    iconCode: "dark_mode"
                }

                GenericToggleOption {
                    message: "Use custom colours (overrides generated colours for widgets)"
                    option: Config.settings.colours.useCustom
                    toRun: () => Config.settings.colours.useCustom = !Config.settings.colours.useCustom
                    withIcon: true
                    iconCode: "category"
                }
            }
        }
    }
}
