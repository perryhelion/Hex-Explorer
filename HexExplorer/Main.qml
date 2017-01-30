import QtQuick 2.4
import Ubuntu.Components 1.3
import Qt.labs.settings 1.0

/*
    A simple program, written as a learning exercise to get familiar with programming in qml, that lets you explore the hexadecimal
value of the colour you have selected using the 3 sliders.

    The background colour and ink colour can be changed in the settings section.

    Many thanks to the Translators:
    French - Anne017

    (I've temporarily added a few new strings & attempted to translate them myself, so
    if there's badly translated French in there then it's my fault and not Anne017's)
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "hexexplorer.phelion"

    width: units.gu(100)
    height: units.gu(75)

    // ****************** Define All the Variables **********************

    property string defaultbgcolour: "#2c001e"   //UbuntuColours.darkAubergine
    property string defaultinkcolour: "#e95420"   //UbuntuColors.orange
    property string backbuttoncolour: "#37a65a"

    property int whichpage: 0
    property bool settingstoggle: false

    property string hexentered: "000000"

    // Main Hex Section

    property int red: 0
    property string redhex : (red < 16) ? "0" + red.toString(16) : red.toString(16)

    property int green: 0
    property string greenhex: (green < 16) ? "0" + green.toString(16) : green.toString(16)

    property int blue: 0
    property string bluehex : (blue < 16) ? "0" + blue.toString(16) : blue.toString(16)

    property string hexstring : "#" + redhex + greenhex + bluehex


    // Background Colour Hex Section

    property int bgred: 44
    property string bgredhex: (bgred < 16) ? "0" + bgred.toString(16) : bgred.toString(16)

    property int bggreen: 0
    property string bggreenhex: (bggreen < 16) ? "0" + bggreen.toString(16) : bggreen.toString(16)

    property int bgblue: 30
    property string bgbluehex: (bgblue < 16) ? "0" + bgblue.toString(16) : bgblue.toString(16)

    property string bghexstring: "#" + bgredhex + bggreenhex + bgbluehex

    // Ink Colour Hex Section

    property int inkred: 233
    property string inkredhex: (inkred < 16) ? "0" + inkred.toString(16) : inkred.toString(16)

    property int inkgreen: 84
    property string inkgreenhex: (inkgreen < 16) ? "0" + inkgreen.toString(16) : inkgreen.toString(16)

    property int inkblue: 32
    property string inkbluehex: (inkblue < 16) ? "0" + inkblue.toString(16) : inkblue.toString(16)

    property string inkhexstring: "#" + inkredhex + inkgreenhex + inkbluehex

    //need to use aliases to 'change' slider values without wrecking the bindings

    property alias redvalue: redslider.value
    property alias greenvalue: greenslider.value
    property alias bluevalue: blueslider.value

    property alias bgredvalue: bgredslider.value
    property alias bggreenvalue: bggreenslider.value
    property alias bgbluevalue: bgblueslider.value

    Settings {
        id: persistent
        property alias persistentred: redslider.value
        property alias persistentgreen: greenslider.value
        property alias persistentblue: blueslider.value
        property alias persistentbgred: bgredslider.value
        property alias persistentbggreen: bggreenslider.value
        property alias persistentbgblue: bgblueslider.value
        property alias persistentinkred: inkredslider.value
        property alias persistentinkgreen: inkgreenslider.value
        property alias persistentinkblue: inkblueslider.value
    } //Settings


    // ****************** End of Variables *******************


    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("Hex Explorer")
            StyleHints {
                foregroundColor: inkhexstring
                backgroundColor: bghexstring
                dividerColor: Qt.darker(bghexstring)
            }

            trailingActionBar {

                actions: [

                    Action {
                        id: settingsclick
                        iconName: "settings"
                        text: i18n.tr("Settings")
                        onTriggered: {
                            if (whichpage == 0)
                            {
                                page0.visible = false
                                page1.visible = true
                                whichpage = 1
                                settingstoggle = true
                            }
                            else if (settingstoggle == true)
                            {
                                page1.visible = false
                                page0.visible = true
                                whichpage = 0
                                settingstoggle = false
                            }

                        } //onTriggered

                    } //settingsclick

                ] //actions[]

            } //trailingActionBar

        } //pageHeader

        // *********************** pagewrapper begins *************************

        Rectangle {
            id: pagewrapper
            width: parent.width
            height: parent.height - pageHeader.height
            anchors.top: pageHeader.bottom
            color: bghexstring

            Rectangle {
                id: page0
                anchors.fill: parent
                anchors.top: parent.top
                color: parent.color

                Rectangle {
                    id: hexsection
                    width: parent.width
                    height: units.gu(6)
                    anchors.top: parent.top
                    color: parent.color

                    Label {
                        id: hexlabel
                        anchors.centerIn: parent
                        font.pixelSize: units.gu(3)
                        color: inkhexstring
                        text: hexstring

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                hexlabel.visible = false
                                hexchangesection.visible = true
                            }
                        }

                    } //hexlabel

                } //hexsection

                Rectangle {
                    id: colourrecsection
                    width: parent.width
                    height: parent.height/2 - hexsection.height
                    anchors.top: hexsection.bottom
                    color: parent.color

                    Rectangle {
                        id: colourrec
                        width: parent.width - units.gu(12)
                        height: parent.height - units.gu(3)
                        anchors.centerIn: parent
                        color: hexstring
                        border.width: units.gu(.3)
                        border.color: Qt.darker(hexstring)
                        radius: 16

                    } //colourrec

                } //colourrecsection

                Rectangle {
                    id: hexchangesection
                    width: parent.width
                    height: units.gu(12)
                    anchors.top: parent.top
                    color: "transparent"
                    visible: false

                    Rectangle {
                        id: inputrect
                        width: parent.width
                        height: parent.height/2
                        anchors.top: parent.top
                        color: bghexstring

                        Label {
                            id: hextochange
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: units.gu(4)
                            text: hexstring
                            font.pixelSize: units.gu(3)
                            color: inkhexstring
                        }

                        Rectangle {
                            id: hexinputrect
                            width: parent.width/3
                            height: parent.height
                            anchors.left: hextochange.right
                            anchors.leftMargin: units.gu(4)
                            color: parent.color

                            Label {
                                id:hexsign
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                color: inkhexstring
                                font.pixelSize: units.gu(3)
                                text: "#"
                            }

                            TextField {
                                id: hexinput
                                width: parent.width
                                anchors.left: hexsign.right
                                anchors.verticalCenter: parent.verticalCenter
                                maximumLength: 6
                                inputMask: "HHHHHH"
                                placeholderText: i18n.tr("Enter Hex")
                                inputMethodHints: Qt.ImhPreferNumbers
                                onCanUndoChanged: {
                                    if (text.length == 0)
                                        cursorPosition = 0
                                }
                            } //hexinput

                        } //hexinputrect

                    } //inputrect

                    Rectangle {
                        id: buttonsrect
                        width: parent.width
                        height: parent.height/2
                        anchors.top: inputrect.bottom
                        color: "transparent"

                        Button {
                            id: cancelbutton
                            anchors.right: parent.horizontalCenter
                            anchors.rightMargin: units.gu(2)
                            anchors.verticalCenter: parent.verticalCenter
                            text: i18n.tr("Cancel")
                            color: UbuntuColors.red

                            onClicked: {
                                hexlabel.visible = true
                                hexchangesection.visible = false
                            }
                        }

                        Button {
                            id: hexchangebutton
                            anchors.left: parent.horizontalCenter
                            anchors.leftMargin: units.gu(2)
                            anchors.verticalCenter: parent.verticalCenter
                            text: i18n.tr("Change")
                            color: UbuntuColors.green

                            onClicked: {
                                /*Textfield ensures that only 6 valid hexadecimal characters can be entered
                                  thanks to maximumLength and inputMask BUT if less than 6 characters are entered
                                  then the missing characters are spaces so we need to check for them */

                                var invalidhex = false
                                var tempred, tempgreen, tempblue
                                hexentered = hexinput.displayText

                                for (var x=0; x<6; x++)
                                {
                                    if(hexentered[x] == " ")
                                        invalidhex = true
                                }

                                if (!invalidhex)
                                {
                                    redvalue = parseInt(hexentered[0] + hexentered[1], 16)
                                    greenvalue = parseInt(hexentered[2] + hexentered[3], 16)
                                    bluevalue = parseInt(hexentered[4] + hexentered[5], 16)

                                    hexchangesection.visible = false
                                    hexlabel.visible = true
                                }

                            } //onClicked
                        } //hexchangebutton

                    } //buttonsrect

                } //hexchangesection


                Rectangle {
                    id: slidersection
                    width: parent.width
                    height: parent.height/2
                    anchors.top: colourrecsection.bottom
                    color: parent.color

                    Rectangle {
                        id: redslidersection
                        width: parent.width
                        height: parent.height/3
                        anchors.top: parent.top
                        color: parent.color

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
                            width: parent.width - units.gu(6)
                            anchors.centerIn: parent
                            function formatValue(v) { return red = parseInt(v) }
                            minimumValue: 0
                            maximumValue: 255
                            stepSize: 1
                            value: red
                            live: true
                        } //redslider

                    } //redslidersection

                    Rectangle {
                        id: greenslidersection
                        width: parent.width
                        height: parent.height/3
                        anchors.top: redslidersection.bottom
                        color: parent.color

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
                            width: parent.width - units.gu(6)
                            anchors.centerIn: parent
                            function formatValue(v) { return green = parseInt(v) }
                            minimumValue: 0
                            maximumValue: 255
                            stepSize: 1
                            value: green
                            live: true
                        } //greenslider

                    } //greenslidersection

                    Rectangle {
                        id: blueslidersection
                        width: parent.width
                        height: parent.height/3
                        anchors.top: greenslidersection.bottom
                        color: parent.color

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
                            width: parent.width - units.gu(6)
                            anchors.centerIn: parent
                            function formatValue(v) { return blue = parseInt(v) }
                            minimumValue: 0
                            maximumValue: 255
                            stepSize: 1
                            value: blue
                            live: true
                        } //blueslider


                    } //blueslidersection

                } //slidersection

            } //page0 *************************************

            Rectangle {
                id: page1
                anchors.fill: parent
                anchors.top: parent.top
                color: parent.color
                visible: false

                Rectangle {
                    id: settingspagewrapper
                    width: parent.width
                    height: parent.height - settingsbackbuttonsection.height
                    anchors.top: parent.top
                    color: parent.color

                    Rectangle {
                        id: currenthexsection
                        width: parent.width
                        height: units.gu(12)
                        color: parent.color

                        Rectangle {
                            id: hexdisplaysection
                            width: parent.width
                            height: parent.height/2
                            anchors.top: parent.top
                            color: parent.color

                            Rectangle {
                                id: hextextrect
                                width: parent.width/2
                                height: parent.height
                                anchors.left: parent.left
                                color: parent.color

                                Label {
                                    id: hextext
                                    anchors.centerIn: parent
                                    font.pixelSize: units.gu(3)
                                    font.bold: true
                                    text: hexstring
                                    color: inkhexstring
                                } //hextext

                            } //hextextrect

                            Rectangle {
                                id: colourblockhexrect
                                width: parent.width/2
                                height: parent.height
                                anchors.right: parent.right
                                color: parent.color

                                Rectangle {
                                    id: currenthexrect
                                    width: parent.width/3 * 2
                                    height: parent.height/4 * 3
                                    anchors.centerIn: parent
                                    color: hexstring
                                    //border.width: units.gu(.2)
                                    //border.color: Qt.darker(color)
                                    radius: 6

                                } //currenthexrect


                            } //colourblockhexrect

                        } //hexdisplaysection

                        Rectangle {
                            id: changebgtohexsection
                            width: parent.width
                            height: parent.height/2
                            anchors.top: hexdisplaysection.bottom
                            color: parent.color

                            Button {
                                id: changebgtohex
                                width: parent.width/2
                                anchors.centerIn: parent
                                text: i18n.tr("Background to Hex")
                                color: hexstring

                                onClicked: {
                                    // In this case hexstring[0] is "#" so fetch 1 - 6 (instead of 0 - 5 for the Textfield)
                                    bgredvalue = parseInt(hexstring[1] + hexstring[2], 16)
                                    bggreenvalue = parseInt(hexstring[3] + hexstring[4], 16)
                                    bgbluevalue = parseInt(hexstring[5] + hexstring[6], 16)
                                }

                            } //changebgtohex

                        } //changebgtohexsection

                    } //currenthexsection

                    Rectangle {
                        id: bgcoloursection
                        width: parent.width
                        height: (parent.height - currenthexsection.height) / 2
                        anchors.top: currenthexsection.bottom
                        color: parent.color

                        Rectangle {
                            id: bgheader
                            width: parent.width
                            height: parent.height/5
                            anchors.top: parent.top
                            color: Qt.darker(bghexstring, 1.2)

                            Label {
                                id: bgcolourlabel
                                anchors.centerIn: parent
                                text: i18n.tr("Background Colour")
                                font.pixelSize: units.gu(2)
                                color: inkhexstring
                            } //bgcolourlabel

                        } //bgheader

                        Rectangle {
                            id: bghexrect
                            width: parent.width
                            height: parent.height/5
                            anchors.top: bgheader.bottom
                            color: parent.color

                            Label {
                                id: bghexlabel
                                anchors.centerIn: parent
                                text: bghexstring
                                color: inkhexstring
                            } //bghexlabel

                        } //bghexrect

                        Rectangle {
                            id: bgredslidersection
                            width: parent.width - units.gu(6)
                            height: parent.height/5
                            anchors.top: bghexrect.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.color

                            Slider {
                                id: bgredslider
                                width: parent.width - units.gu(4)
                                anchors.centerIn: parent
                                function formatValue(v) { return bgred = parseInt(v) }
                                minimumValue: 0
                                maximumValue: 255
                                stepSize: 1
                                value: bgred
                                live: true
                            } //bgredslider

                        } //bgredslidersection

                        Rectangle {
                            id: bggreenslidersection
                            width: parent.width - units.gu(6)
                            height: parent.height/5
                            anchors.top: bgredslidersection.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.color

                            Slider {
                                id: bggreenslider
                                width: parent.width - units.gu(4)
                                anchors.centerIn: parent
                                function formatValue(v) { return bggreen = parseInt(v) }
                                minimumValue: 0
                                maximumValue: 255
                                stepSize: 1
                                value: bggreen
                                live: true
                            } //bggreenslider

                        } //bggreenslidersection

                        Rectangle {
                            id: bgblueslidersection
                            width: parent.width - units.gu(6)
                            height: parent.height/5
                            anchors.top: bggreenslidersection.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.color

                            Slider {
                                id: bgblueslider
                                width: parent.width - units.gu(4)
                                anchors.centerIn: parent
                                function formatValue(v) { return bgblue = parseInt(v) }
                                minimumValue: 0
                                maximumValue: 255
                                stepSize: 1
                                value: bgblue
                                live: true
                            } //bgblueslider

                        } //bgblueslidersection

                    } //bgcoloursection

                    Rectangle {
                        id: inkcoloursection
                        width: parent.width
                        height: (parent.height - currenthexsection.height) / 2
                        anchors.top: bgcoloursection.bottom
                        color: parent.color

                        Rectangle {
                            id: inkheader
                            width: parent.width
                            height: parent.height/5
                            anchors.top: parent.top
                            color: Qt.darker(bghexstring, 1.2)

                            Label {
                                id: inkheaderlabel
                                anchors.centerIn: parent
                                text: i18n.tr("Ink Colour")
                                font.pixelSize: units.gu(2)
                                color: inkhexstring
                            } //inkheaderlabel

                        } //inkheader

                        Rectangle {
                            id: inkhexrect
                            width: parent.width
                            height: parent.height/5
                            anchors.top: inkheader.bottom
                            color: parent.color

                            Label {
                                id: inkhex
                                anchors.centerIn: parent
                                color: inkhexstring
                                text: inkhexstring
                            }

                        } //inkhexrect

                        Rectangle {
                            id: inkredslidersection
                            width: parent.width - units.gu(6)
                            height: parent.height/5
                            anchors.top: inkhexrect.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.color

                            Slider {
                                id: inkredslider
                                width: parent.width - units.gu(4)
                                anchors.centerIn: parent
                                function formatValue(v) { return inkred = parseInt(v) }
                                minimumValue: 0
                                maximumValue: 255
                                stepSize: 1
                                value: inkred
                                live: true
                            } //inkredslider

                        } //inkredslidersection

                        Rectangle {
                            id: inkgreenslidersection
                            width: parent.width - units.gu(6)
                            height: parent.height/5
                            anchors.top: inkredslidersection.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.color

                            Slider {
                                id: inkgreenslider
                                width: parent.width - units.gu(4)
                                anchors.centerIn: parent
                                function formatValue(v) { return inkgreen = parseInt(v) }
                                minimumValue: 0
                                maximumValue: 255
                                stepSize: 1
                                value: inkgreen
                                live: true
                            } //inkgreenslider

                        } //inkgreenslidersection

                        Rectangle {
                            id: inkblueslidersection
                            width: parent.width - units.gu(6)
                            height: parent.height/5
                            anchors.top: inkgreenslidersection.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: parent.color

                            Slider {
                                id: inkblueslider
                                width: parent.width - units.gu(4)
                                anchors.centerIn: parent
                                function formatValue(v) { return inkblue = parseInt(v) }
                                minimumValue: 0
                                maximumValue: 255
                                stepSize: 1
                                value: inkblue
                                live: true
                            } //inkblueslider

                        } //inkblueslidersection

                    } //inkcoloursection

                } //settingspagewrapper


                Rectangle {
                    id: settingsbackbuttonsection
                    width: parent.width
                    height: units.gu(6)
                    anchors.bottom: parent.bottom
                    color: parent.color

                    Button {
                        id: settingsbackbutton
                        anchors.centerIn: parent
                        color: backbuttoncolour
                        text: i18n.tr("Back")
                        onClicked: {
                            page0.visible = true
                            page1.visible = false
                            whichpage = 0
                            settingstoggle = false
                        }

                    } //settingsbackbutton

                } //settingsbackbuttonsection

            } //page1

        } //pagewrapper *******************************

    } //Page
} //MainView
