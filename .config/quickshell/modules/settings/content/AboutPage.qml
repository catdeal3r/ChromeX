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

                IconImage {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.preferredWidth: pageWrapper.width / 3
                    Layout.preferredHeight: pageWrapper.width / 4
					source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/icon.png")
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.preferredHeight: 2
                    Layout.bottomMargin: 40
                    text: "ChromeX"
                    font.family: Config.settings.font
                    font.pixelSize: 26
                    color: Colours.palette.on_surface
                }

                GenericTitle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredHeight: 20
                    Layout.topMargin: 10
                    text: "People involved"
                    iconCode: "account_circle"
                }

                GenericSeperator {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.topMargin: 5
                    Layout.preferredWidth: pageWrapper.width
                    Layout.preferredHeight: 3
                }

                RowLayout {
                    Layout.topMargin: 20
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredWidth: pageWrapper.width
        
                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_catdeal3r_.png")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "catdeal3r"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Lead Developer and Designer"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }

                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_hauntedcupoftea_.jpg")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "hauntedcupoftea"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Bluetooth tooth fairy"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }

                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_sillyman_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Sillyman"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Playtester"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }
                }

                RowLayout {
                    Layout.topMargin: 20
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredWidth: pageWrapper.width
        
                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_soramane_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Soramane"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Design inspiration and service code"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }

                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_rexiel_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Rexiel"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "ListView animations and notification code"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }

                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_end_4_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "End_4"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Notification daemon and much, much more"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }
                }

                RowLayout {
                    Layout.topMargin: 20
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.preferredWidth: pageWrapper.width
        
                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_tiffany_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Tiffany"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Literally cheat-code-like design critique"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }

                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_eve_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Eve"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "General linux stuff and design critique"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }

                    ColumnLayout {
                        Layout.topMargin: 20
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                        Layout.preferredWidth: pageWrapper.width / 4

                        spacing: 6
                    
                        ClippingWrapperRectangle {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            Layout.preferredWidth: pageWrapper.width / 10
                            Layout.preferredHeight: Layout.preferredWidth
                            color: "transparent"
                            radius: Config.settings.borderRadius

                            IconImage {
                                source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/authors/author_chadcat7_.webp")
                            }

                        }

                        Text {
                            Layout.topMargin: 5
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Chadcat7"
                            font.family: Config.settings.font
                            font.pixelSize: 20
                            color: Colours.palette.on_surface
                        }

                        GenericSeperator {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.topMargin: 5
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 3
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            text: "Biggest design inspiration"
                            font.family: Config.settings.font
                            font.pixelSize: 12
                            color: Qt.alpha(Colours.palette.on_surface, 0.7)
                        }
                    }
                }

                Text {
                    Layout.topMargin: 30
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    text: "Nothing in this project would have been achieved without these amazing people."
                    font.family: Config.settings.font
                    font.pixelSize: 20
                    color: Colours.palette.on_surface
                }
            }
        }
    }
}
