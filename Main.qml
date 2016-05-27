import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3

/*
A simple program, written as a learning exercise to get familiar with programming in qml, that lets you explore the hexadecimal
value of the colour you have selected using the 3 sliders.

The background colour can be easily changed from the settings menu.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "hexexplorer.phelion"

    width: units.gu(100)
    height: units.gu(75)

    property var defaultpagecolour: UbuntuColors.darkAubergine

    property var pagecolour : defaultpagecolour
    property var dividecolour: Qt.darker(pagecolour)

    property var red : 0
    property var redhex : (red < 16) ? "0" + red.toString(16) : red.toString(16)

    property var green : 0
    property var greenhex: (green < 16) ? "0" + green.toString(16) : green.toString(16)

    property var blue : 0
    property var bluehex : (blue < 16) ? "0" + blue.toString(16) : blue.toString(16)

    property var hexstring : "#" + redhex + greenhex + bluehex


    Page {

        header: PageHeader {
            id: pageHeader
            title: i18n.tr("Hex Explorer")

            StyleHints {
                foregroundColor: UbuntuColors.orange
                backgroundColor: pagecolour
                dividerColor: dividecolour
            }

            trailingActionBar {

                actions: [
                    Action {
                        id: getsettings
                        iconName: "settings"
                        text: i18n.tr("Settings")
                        onTriggered: PopupUtils.open(settingspopover)
                    }
                ]
            } //trailingActionBar

        } //pageHeader

        Component {
            id: settingspopover

            Popover {

                Column {
                    id: bgColourChooser
                    height: pagewrapper.height
                    width: parent.width
                    spacing: units.gu(.5)

                    Rectangle {
                        height: parent.height/5
                        width: parent.width

                        Text {
                            text: i18n.tr("Background Colour")
                            font.bold: true
                            font.pixelSize: units.gu(3)
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        id: "currenthex"
                        height: parent.height/5 - units.gu(1)
                        width: parent.width - units.gu(2)
                        color: hexstring
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: 3
                        border.color: "#090909"

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                pagecolour = hexstring
                                dividecolour = Qt.darker(hexstring)
                                hide()
                            }
                        }

                        Label {
                            text: i18n.tr("Current Hex")
                            font.pixelSize: units.gu(2)
                            anchors.centerIn: parent
                            color: "#ffffff"
                        }

                    } //currenthex



                    Rectangle {
                        id: "default"
                        height: parent.height/5 - units.gu(1)
                        width: parent.width - units.gu(2)
                        color: UbuntuColors.darkAubergine
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: 3
                        border.color: "#090909"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pagecolour = defaultpagecolour
                                dividecolour = Qt.darker(defaultpagecolour)
                                hide()
                            }
                        }

                        Label {
                            text: i18n.tr("Default")
                            font.pixelSize: units.gu(2)
                            anchors.centerIn: parent
                            color: UbuntuColors.orange
                        }

                    } //darkAubergine(default)

                    Rectangle {
                        id: "light"
                        height: parent.height/5 - units.gu(1)
                        width: parent.width - units.gu(2)
                        color: UbuntuColors.porcelain
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: 3
                        border.color: "#090909"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pagecolour = UbuntuColors.porcelain
                                dividecolour = "#606060"
                                hide()
                            }
                        }

                        Label {
                            text: i18n.tr("Light")
                            font.pixelSize: units.gu(2)
                            color: "#101010"
                            anchors.centerIn: parent
                        }

                    } //light

                    Rectangle {
                        id: "dark"
                        height: parent.height/5 - units.gu(1)
                        width: parent.width - units.gu(2)
                        color: "#0a0a0a"
                        anchors.horizontalCenter: parent.horizontalCenter
                        radius: 3
                        border.color: "#dddddd"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pagecolour = "#0a0a0a"
                                dividecolour = "#000000"
                                hide()
                            }
                        }

                        Label {
                            text: i18n.tr("Dark")
                            font.pixelSize: units.gu(2)
                            anchors.centerIn: parent
                            color: "#dddddd"
                        }

                    } //dark

                } //Column (bgColourChooser)

            } //Popover
        } //Component

        Rectangle {
            id: pagewrapper
            width: parent.width
            height: parent.height - pageHeader.height
            anchors.top: pageHeader.bottom
            color: pagecolour

            Rectangle {
                id: topsection
                width: parent.width
                height: parent.height/2 - hashlabel.height
                color: parent.color

                Rectangle {
                    id: colourrect
                    height: parent.height - units.gu(6)
                    width: parent.width/3 * 2
                    anchors.centerIn: parent
                    border.width: units.gu(.3)
                    border.color: Qt.darker(hexstring)
                    color: hexstring
                    radius: 16
                }

            } //topsection

            Rectangle {
                id: hexsection
                width: parent.width
                height: units.gu(3)
                anchors.top: topsection.bottom
                color: parent.color

                Label {
                    id: hashlabel
                    color: UbuntuColors.orange
                    text: hexstring
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: units.gu(3)
                }

            }


            Rectangle {
                id: slidersection
                width: parent.width
                height: parent.height/2
                anchors.top: hexsection.bottom
                color: parent.color


                Column {
                    id: slidercolumn
                    width: parent.width - units.gu(4)
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: redslidercontainer
                        width: parent.width
                        height: parent.height/3
                        color: pagecolour

                        Rectangle {
                            id: colourblockred
                            color: "#" + redhex + "0000"
                            width: parent.width/6
                            height: parent.height/3
                            anchors.centerIn: parent
                            border.width: units.gu(.3)
                            border.color: Qt.darker(color)
                            radius: 12

                        } //colourblockred


                        Slider {
                            id: redslider

                            function formatValue(v) { return red = parseInt(v) }

                            minimumValue: 0
                            maximumValue: 255
                            stepSize: 1
                            value: red
                            live: true

                            width: parent.width - units.gu(4)
                            anchors.centerIn: parent

                        } //redslider

                    } //redslidercontainer


                    Rectangle {
                        id: greenslidercontainer
                        width: parent.width
                        height: parent.height/3
                        color: pagecolour

                        Rectangle {
                            id: colourblockgreen
                            color: "#00" + greenhex + "00"
                            width: parent.width/6
                            height: parent.height/3
                            anchors.centerIn: parent
                            border.width: units.gu(.3)
                            border.color: Qt.darker(color)
                            radius: 12

                        } //colourblockgreen

                        Slider {
                            id: greenslider

                            function formatValue(v) { return green = parseInt(v) }

                            minimumValue: 0
                            maximumValue: 255
                            stepSize: 1
                            value: green
                            live: true

                            width: parent.width - units.gu(4)
                            anchors.centerIn: parent

                        } //greenslider

                    } //greenslidercontainer




                    Rectangle {
                        id: blueslidercontainer
                        width: parent.width
                        height: parent.height/3
                        color: pagecolour

                        Rectangle {
                            id: colourblockblue
                            color: "#0000" + bluehex
                            width: parent.width/6
                            height: parent.height/3
                            anchors.centerIn: parent
                            border.width: units.gu(.3)
                            border.color: Qt.darker(color)
                            radius: 12

                        } //colourblockblue

                        Slider {
                            id: blueslider

                            function formatValue(v) { return blue = parseInt(v) }

                            minimumValue: 0
                            maximumValue: 255
                            stepSize: 1
                            value: blue
                            live: true

                            width: parent.width - units.gu(4)
                            anchors.centerIn: parent

                        } //blueslider

                    } //blueslidercontainer


                } //slidercolumn

            } //slidersection

        } //pagewrapper

    } //Page
}  //MainView
