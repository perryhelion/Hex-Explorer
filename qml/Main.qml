/*
 * Copyright (C) 2020  P Helion
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * HexExplorer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3 as UT

ApplicationWindow {
    id: theApplication
    visible: true
    width: 400
    height: 600
    minimumWidth: 360
    minimumHeight: 450
    title: i18n.tr("Hex Explorer")
    color: backgroundColour
    
    // Main Hex Values
    property int redHexValue: sliderRed.value
    property int greenHexValue: sliderGreen.value
    property int blueHexValue: sliderBlue.value
    
    property string redHexString: (redHexValue < 16) ? "0" + redHexValue.toString(16) : redHexValue.toString(16)
    property string greenHexString: (greenHexValue < 16) ? "0" + greenHexValue.toString(16) : greenHexValue.toString(16)
    property string blueHexString: (blueHexValue < 16) ? "0" + blueHexValue.toString(16) : blueHexValue.toString(16)
    
    property string hexString: "#" + redHexString + greenHexString + blueHexString
    
    // Background Values
    property int backgroundRedValue: backgroundRedSlider.value
    property int backgroundGreenValue: backgroundGreenSlider.value
    property int backgroundBlueValue: backgroundBlueSlider.value
    
    property string backgroundRedString: (backgroundRedValue < 16)  ? "0" + backgroundRedValue.toString(16) : backgroundRedValue.toString(16)
    property string backgroundGreenString: (backgroundGreenValue < 16)  ? "0" + backgroundGreenValue.toString(16) : backgroundGreenValue.toString(16)
    property string backgroundBlueString: (backgroundBlueValue < 16)  ? "0" + backgroundBlueValue.toString(16) : backgroundBlueValue.toString(16)
    
    property string backgroundColour: "#" + backgroundRedString + backgroundGreenString + backgroundBlueString
    
    // Ink Values
    property int inkRedValue: inkRedSlider.value
    property int inkGreenValue: inkGreenSlider.value
    property int inkBlueValue: inkBlueSlider.value
    
    property string inkRedString: (inkRedValue < 16) ? "0" + inkRedValue.toString(16): inkRedValue.toString(16)
    property string inkGreenString: (inkGreenValue < 16) ? "0" + inkGreenValue.toString(16): inkGreenValue.toString(16)
    property string inkBlueString: (inkBlueValue < 16) ? "0" + inkBlueValue.toString(16): inkBlueValue.toString(16)
    
    property string inkColour: "#" + inkRedString + inkGreenString + inkBlueString
    
    // Main Page Checker
    property bool onMainPage: true
    
    // Default Background and Ink Values
    property int defaultBackgroundRed: 0x2c
    property int defaultBackgroundGreen: 0x00
    property int defaultBackgroundBlue: 0x1e
    
    property int defaultInkRed: 0xe9
    property int defaultInkGreen: 0x54
    property int defaultInkBlue: 0x20
    
    // Popup Colours
    property string popupBackgroundColour: "#101010"
    property string popupInkColour: "white"
    
    
    // Font Sizes
    property int bigFontSize: 20
    property int standardFontSize: 12
    property int smallFontSize: 10
    
    // Application Header
    property int headerHeight: 50
    
    
    // Settings
    Settings {
        id: settings
        
        property alias persistentRedHexValue: sliderRed.value
        property alias persistentGreenHexValue: sliderGreen.value
        property alias persistentBlueHexValue: sliderBlue.value
        
        property alias persistentBackgroundRedValue: backgroundRedSlider.value
        property alias persistentBackgroundGreenValue: backgroundGreenSlider.value
        property alias persistentBackgroundBlueValue: backgroundBlueSlider.value
        
        property alias persistentInkRedValue: inkRedSlider.value
        property alias persistentInkGreenValue: inkGreenSlider.value
        property alias persistentInkBlueValue: inkBlueSlider.value
        
    } //persistentSettings
    
    
    // ****************
    //    mainHeader
    // ****************
    
    header: ToolBar {
        id: mainHeader
        //width: parent.width
        
        background: Rectangle {
            id: headerBackgroundRectangle
            implicitHeight: headerHeight
            color: "transparent"
            
            Rectangle {
                id: headerBottomLine
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
                color: "transparent"
                border.color: Qt.darker(backgroundColour)
                
            } //headerBottomLine
            
        } //headerBackgroundRectangle
        
        RowLayout {
            anchors.fill: parent
            
            Label {
                id: appTitle
                text: i18n.tr("HexExplorer")
                color: inkColour
                font.pointSize: standardFontSize
                Layout.fillWidth: true
                Layout.leftMargin: standardFontSize
            } //appTitle
            
            ToolButton {
                id: manualEntryButton
                text: i18n.tr("txt") 
                font.pointSize: smallFontSize
                
                contentItem: Text {
                    text: manualEntryButton.text
                    color: inkColour
                    verticalAlignment: Text.AlignVCenter
                }
                
                background: Rectangle {
                    implicitWidth: headerHeight/2
                    implicitHeight: headerHeight
                    color: "transparent"
                }
                
                onClicked: {
                    optionsPopup.open()
                    hexInput.focus = true
                    hexInput.clear()
                    hexInput.cursorPosition = 0
                    
                } //onClicked
                
            } //manualEntryButton
            
            ToolButton {
                id: settingsButton
                text: "⋮"
                width: headerHeight
                
                contentItem: Text {
                    text: settingsButton.text
                    color: inkColour
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                
                
                background: Rectangle {
                    implicitWidth: headerHeight
                    implicitHeight: headerHeight
                    anchors.fill: parent
                    color: "transparent"
                } //background
                
                onClicked: {
                    if (onMainPage) {
                        page0.visible = false
                        page1.visible = true
                        appTitle.text = i18n.tr("Settings")
                        onMainPage = false
                    }
                    else {
                        page1.visible = false
                        page0.visible = true
                        appTitle.text = i18n.tr("HexExplorer")
                        onMainPage = true
                    }
                } //onClicked
            
            } //settingsButton
            
            
        } //RowLayout
        
            // Popup Begins **************************
            
            Popup {
                id: optionsPopup
                x: page0.width/12
                y: mainHeader.height + hexSection.height + colorSection.height/20
                width: colorRectangle.width
                height: colorRectangle.height
                focus: true
                modal: true
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                //opacity: 0.9
                
                background: Rectangle {
                    id: popupRect
                    anchors.fill: parent
                    color: popupBackgroundColour
                    
                } //popupRect
                    
                    Rectangle {
                        id: option1
                        width: parent.width
                        height: parent.height
                        anchors.top: parent.top
                        color: "transparent"
                        //opacity: optionsPopup.opacity
                            
                        Rectangle {
                            id: option1LabelWrapper
                            width: parent.width
                            height: parent.height/2
                            anchors.top: parent.top
                            color: parent.color
                            //opacity: parent.opacity
                            
                            Rectangle {
                                id: enterHexLabelWrapper 
                                width: parent.width/2
                                height: parent.height
                                color: parent.color
                                anchors.left: parent.left
                            
                                Label {
                                    id: enterHexLabel
                                    text: i18n.tr("Enter Hex:  #")
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    color: popupInkColour
                                    font.pointSize: standardFontSize
                                } //enterHexLabel
                            
                            } //enterHexLabelWrapper
                            
                            Rectangle {
                                id: textfieldWrapper
                                width: parent.width/2
                                height: parent.height
                                anchors.right: parent.right
                                color: parent.color
                                
                                TextField {
                                    id: hexInput
                                    width: enterHexLabel.width
                                    //height: parent.height/3 * 2
                                    anchors.left: parent.left
                                    anchors.verticalCenter: parent.verticalCenter
                                    maximumLength: 6
                                    inputMask: "HHHHHH"
                                    font.pointSize: standardFontSize
                                    selectByMouse: true
                                    inputMethodHints: Qt.ImhPreferNumbers
                                    
                                } //hexInput
                                        
                            }//textfieldWrapper
                            
                            
                        } //option1LabelWrapper
                                
                        Rectangle {
                            id: buttonWrapper
                            width: parent.width
                            height: parent.height/2
                            anchors.bottom: parent.bottom
                            color: parent.color
                            
                            Button {
                                id: changeHexButton
                                anchors.centerIn: parent
                                text: i18n.tr("Apply")
                                height: parent.height/2
                                width: parent.width/3
                                
                                onClicked: {
                                    
                                    if (hexInput.text.length == 6) {
                                        sliderRed.value = parseInt(hexInput.text[0] + hexInput.text[1] , 16);
                                        sliderGreen.value = parseInt(hexInput.text[2] + hexInput.text[3], 16);
                                        sliderBlue.value = parseInt(hexInput.text[4] + hexInput.text[5], 16);
                                        optionsPopup.close();
                                    }
                                
                                    else if (hexInput.text.length == 0) {
                                        hexInput.cursorPosition = 0;
                                        hexInput.focus = true;
                                    }
                                    
                                    else {
                                        hexInput.cursorPosition = hexInput.text.length;
                                        hexInput.focus = true;
                                    }
                                
                                } //onClicked
                                
                            } //changeHexButton
                            
                        } //buttonWrapper
                        
                        Rectangle {
                            id: option1Spacer
                            width: parent.width
                            height: 1
                            anchors.bottom: parent.bottom
                            color: "transparent"
                            border.color: Qt.darker(backgroundColour)
                                
                        } //option1Spacer
                        
                    } //option1
                
            } //optionsPopup
                
            // Popup End ***********************
            
        
    } //mainHeader
    
    
    // *********
    //   page0 
    // *********
    
    Rectangle {
        id: page0
        width: parent.width
        height: parent.height // - mainHeader.height
        color: "transparent"
        anchors.top: mainHeader.bottom
        visible: true
        
        Rectangle {
            id: hexSection
            width: parent.width
            height: parent.height/11
            anchors.top: parent.top
            color: parent.color
            
            TextInput {
                id: sliderValue
                anchors.centerIn: parent
                color: inkColour
                text: hexString
                font.pointSize: bigFontSize
                readOnly: true
                selectByMouse: true
                mouseSelectionMode: TextInput.SelectCharacters
                //selectByKeyboard: true
                } //sliderValue
                
        } //hexSection
        
        Rectangle {
            id: colorSection
            width: parent.width
            height: parent.height/11 * 5
            anchors.top: hexSection.bottom
            color: "transparent"
            
            Rectangle {
                id: colorRectangle
                width: parent.width/6 * 5
                height: parent.height/10 * 9
                anchors.centerIn: parent
                color: hexString
                border.color: Qt.darker(hexString)
                border.width: 2
                radius: 10
                
            } //colorRectangle
            
        } //colorSection
        
        Rectangle {
            id: sliderSection
            width: parent.width
            height: parent.height/11 * 5
            anchors.top: colorSection.bottom
            color: "transparent"
            
            Rectangle {
                id: sliderWrapper
                width: parent.width/6 * 5
                height: parent.height/5 * 4
                color: "transparent"
                anchors.centerIn: parent
            
                Rectangle {
                    id: redSliderSection
                    width: parent.width
                    height: parent.height/3
                    anchors.top: parent.top
                    color: parent.color
                    
                    Rectangle {
                        id: redSliderRect
                        color: "#" + redHexString + "0000"
                        width: parent.width/6
                        height: parent.height/2
                        anchors.centerIn: parent
                        radius: 15
                        border.color: Qt.darker(redSliderRect.color)
                        border.width: 2
                    } //redSliderRect
                    
                    Slider {
                    id: sliderRed
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height/3
                    from: 0x00
                    value: 0x00
                    to: 0xff
                    stepSize: 0x01
                    snapMode: Slider.SnapAlways
                        
                    } //sliderRed
                    
                } //redSliderSection
                
                Rectangle {
                    id: greenSliderSection
                    width: parent.width
                    height: parent.height/3
                    anchors.top: redSliderSection.bottom
                    color: "transparent"
                    
                    Rectangle {
                        id: greenSliderRect
                        color: "#00" + greenHexString + "00"
                        width: parent.width/6
                        height: parent.height/2
                        anchors.centerIn: parent
                        radius: 15
                        border.color: Qt.darker(greenSliderRect.color)
                        border.width: 2
                    } //greenSliderRect
                    
                    Slider {
                    id: sliderGreen
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height/3
                    from: 0x00
                    value: 0x00
                    to: 0xff
                    stepSize: 0x01
                    snapMode: Slider.SnapAlways
                        
                    } //sliderGreen
                    
                } //greenSliderSection
                
                Rectangle {
                    id: blueSliderSection
                    width: parent.width
                    height: parent.height/3
                    anchors.top: greenSliderSection.bottom
                    color: "transparent"
                    
                    Rectangle {
                        id: blueSliderRect
                        color: "#0000" + blueHexString
                        width: parent.width/6
                        height: parent.height/2
                        anchors.centerIn: parent
                        radius: 15
                        border.color: Qt.darker(blueSliderRect.color)
                        border.width: 2
                    } //blueSliderRect
                    
                    Slider {
                    id: sliderBlue
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height/3
                    from: 0x00
                    value: 0x00
                    to: 0xff
                    stepSize: 0x01
                    snapMode: Slider.SnapAlways
                        
                    } //sliderBlue
                    
                } //blueSliderSection
            
            } //sliderWrapper
            
        } //sliderSection
        
    } //page0
    
    
    // *********
    //   page1
    // *********
    
    Rectangle {
        id: page1
        width: parent.width
        height: parent.height //- mainHeader.height
        anchors.top: mainHeader.bottom
        color: "transparent"
        visible: false
        
        Rectangle {
            id: quickChangeSection
            width: parent.width
            height: parent.height/11
            color: parent.color
            anchors.top: parent.top
                
            Rectangle {
                id: hexRectangle
                width: parent.width/6 * 5
                height: parent.height/3 * 2
                anchors.centerIn: parent
                color: hexString
                
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        backgroundRedSlider.value = redHexValue
                        backgroundGreenSlider.value = greenHexValue
                        backgroundBlueSlider.value = blueHexValue
                        optionsPopup.close()
                    }
                
            } //MouseArea
                
            } //hexRectangle
            
            Label {
                id: changeLabel
                text: i18n.tr("Set Background to ") + hexString
                anchors.centerIn: parent
                color: ( (redHexValue > 0x70) && (greenHexValue > 0x70) && (blueHexValue > 0x70) ) ? "black" : "white"
                font.pointSize: smallFontSize
            }
                    
                    
        } //quickChangeSection
        
        Rectangle {
            id: page1TopSection
            width: parent.width
            height: parent.height/11 * 5
            anchors.top: quickChangeSection.bottom
            color: parent.color
            
            Rectangle {
                id: page1TopHeading
                width: parent.width
                height: parent.height/7
                anchors.top: parent.top
                color: Qt.darker(backgroundColour)
                    
                Label {
                    text: i18n.tr("Background")
                    color: inkColour
                    font.pointSize: smallFontSize
                    anchors.verticalCenter: parent.verticalCenter
                    x: 10
                } //Label
                    
                Label {
                    text: backgroundColour
                    color: inkColour
                    font.pointSize: standardFontSize
                    anchors.centerIn: parent
                } //Label
                    
                
                Rectangle {
                    id: page1TopHeadingSpacer
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    border.color: Qt.darker(backgroundColour)
                } //page1TopHeadingSpacer
                
                
            } //page1TopHeading
            
            
            Rectangle {
                id: backgroundRedSliderSection
                width: parent.width
                height: parent.height/7 * 2
                anchors.top: page1TopHeading.bottom
                color: parent.color
                
                Slider {
                    id: backgroundRedSlider 
                    width: parent.width/5 * 4
                    anchors.centerIn: parent
                    from: 0x00
                    value: defaultBackgroundRed
                    to: 0xff
                    stepSize: 0x01
                } //backgroundRedSlider
                
            } //backgroundRedSliderSection
            
            Rectangle {
                id: backgroundGreenSliderSection
                width: parent.width
                height: parent.height/7 * 2
                anchors.top: backgroundRedSliderSection.bottom
                color: parent.color
                
                Slider {
                    id: backgroundGreenSlider 
                    width: parent.width/5 * 4
                    anchors.centerIn: parent
                    from: 0x00
                    value: defaultBackgroundGreen
                    to: 0xff
                    stepSize: 0x01
                } //backgroundGreenSlider
                
            } //backgroundGreenSliderSection
            
            Rectangle {
                id: backgroundBlueSliderSection
                width: parent.width
                height: parent.height/7 * 2
                anchors.bottom: parent.bottom
                color: parent.color
                
                Slider {
                    id: backgroundBlueSlider 
                    width: parent.width/5 * 4
                    anchors.centerIn: parent
                    from: 0x00
                    value: defaultBackgroundBlue
                    to: 0xff
                    stepSize: 0x01
                } //backgroundBlueSlider
                
            } //backgroundBlueSliderSection
            
            Rectangle {
                id: page1TopSectionSpacer
                width: parent.width
                height: 2
                anchors.bottom: parent.bottom
                color: "transparent"
                border.color: Qt.darker(backgroundColour)
            } //page1TopSectionSpacer
                
        } //page1TopSection
        
        Rectangle {
            id: page1BottomSection
            width: parent.width
            height: parent.height/11 * 5
            anchors.bottom: parent.bottom
            color: parent.color
            
            Rectangle {
                id: page1BottomHeading
                width: parent.width
                height: parent.height/7
                anchors.top: parent.top 
                color: Qt.darker(backgroundColour)
                    
                Label {
                    id: bottomHeadingLabel
                    text: i18n.tr("Text")
                    color: inkColour
                    anchors.verticalCenter: parent.verticalCenter
                    x: 10
                    font.pointSize: smallFontSize
                } //bottomHeadingLabel
                
                Label {
                    id: bottomHeadingHex
                    text: inkColour
                    color: inkColour
                    font.pointSize: standardFontSize
                    anchors.centerIn: parent
                } //bottomHeadingHex
                    
                Rectangle {
                    id: page1BottomHeadingSpacer
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "transparent"
                    border.color: Qt.darker(backgroundColour)
                } //page1BottomHeadingSpacer
                
            } //page1BottomHeading
            
            Rectangle {
                id: inkRedSliderSection
                width: parent.width
                height: parent.height/7 * 2
                anchors.top: page1BottomHeading.bottom
                color: parent.color
                
                Slider {
                    id: inkRedSlider 
                    width: parent.width/5 * 4
                    anchors.centerIn: parent
                    from: 0x00
                    value: defaultInkRed
                    to: 0xff
                    stepSize: 0x01
                } //inkRedSlider
                
            } //inkRedSliderSection
            
            Rectangle {
                id: inkGreenSliderSection
                width: parent.width
                height: parent.height/7 * 2
                anchors.top: inkRedSliderSection.bottom
                color: parent.color
                
                Slider {
                    id: inkGreenSlider 
                    width: parent.width/5 * 4
                    anchors.centerIn: parent
                    from: 0x00
                    value: defaultInkGreen
                    to: 0xff
                    stepSize: 0x01
                } //inkGreenSlider
                
            } //inkGreenSliderSection
            
            Rectangle {
                id: inkBlueSliderSection
                width: parent.width
                height: parent.height/7 * 2
                anchors.bottom: parent.bottom
                color: parent.color
                
                Slider {
                    id: inkBlueSlider 
                    width: parent.width/5 * 4
                    anchors.centerIn: parent
                    from: 0x00
                    value: defaultInkBlue
                    to: 0xff
                    stepSize: 0x01
                } //inkBlueSlider
                
            } //inkBlueSliderSection
            
        } //page1BottomSection
        
    } //page1
    
}//ApplicationWindow
