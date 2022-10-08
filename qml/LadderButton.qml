import QtQuick 2.0
import Felgo 3.0

//A button that either drops each column by one row, generating a new row at the top,
// or exits the swap mode in the playing area, depending on whether or not swap
// mode is active. (Complete)
Item {
    id: ladderButton

    visible: !menuUp

    anchors.fill: parent

    Item {
        id: dropSwitch

        width: 60
        height: width

        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 12

        Image {
            id: dropHalo

            width: 60
            height: width

            anchors.centerIn: dropButton

            source: "../assets/gfx/dropHalo.png"

            NumberAnimation {
                target: dropHalo
                property: "rotation"
                duration: 6750
                from: 45
                to: 0
                loops: Animation.Infinite
                running: true
            } //Close NumberAnimation

            SequentialAnimation {
                id: haloGlow

                loops: Animation.Infinite
                running: true

                property int duration: 3000

                NumberAnimation {
                    target: dropHalo
                    property: "opacity"
                    duration: haloGlow.duration / 2
                    from: 1
                    to: 0.4
                } //Close NumberAnimation.

                NumberAnimation {
                    target: dropHalo
                    property: "opacity"
                    duration: haloGlow.duration / 2
                    from: 0.4
                    to: 1
                } //Close NumberAnimation.

            } //Close SequentialAnimation.

            NumberAnimation {
                id: haloFade
                target: dropHalo
                property: "opacity"
                duration: 400
                from: 1
                to: 0
                onStopped: {
                    target.opacity = 1
                    target.visible = false
                } //onStopped.
            } //Close NumberAnimation.

        } //Close Image.

        //The button that lowers all bits on the ladder by one rung,
        // removes bits lower than the bottom rung, and generates a new
        // row of bits across the top rung. (Complete)
        Image {
            id: dropButton

            width: 48
            height: width

            anchors.centerIn: parent

            //The source image.
            source: "../assets/gfx/drop.png"

            //The mouse area, that drop the bits. (Complete)
            MouseArea {
                id: buttonArea
                hoverEnabled: true
                anchors.fill: parent

                onPositionChanged: dropButton.source = "../assets/gfx/drop2.png"

                onExited: dropButton.source = "../assets/gfx/drop.png"

                onClicked: {
                    gameScene.drop()
                    parent.source = "../assets/gfx/drop2.png"
                    haloFade.start()
                    bitClick.play()
                    buttonArea.enabled = false
                    inputDelay.start()
                } //Close onClicked.

                Timer {
                    id: inputDelay
                    interval: 600
                    onTriggered: {
                        dropButton.source = "../assets/gfx/drop.png"
                        dropHalo.visible = true
                        buttonArea.enabled = true
                    } //Close onTriggered.
                } //Close Timer 'inputDelay'.

            }//Close MouseArea 'buttonArea'. (Complete)

        } //Close Image 'dropButton'. (Complete)

    }

    Item {
        id: swapSwitch

        width: 60
        height: width

        anchors.horizontalCenter: dropSwitch.horizontalCenter
        anchors.top: dropSwitch.bottom
        anchors.topMargin: -4

        Image {
            id: swapHalo

            width: 60
            height: width

            anchors.centerIn: swapButton

            source: "../assets/gfx/dropHalo.png"

            visible: swapButton.visible

            NumberAnimation {
                target: swapHalo
                property: "rotation"
                duration: 6750
                from: 45
                to: 0
                loops: Animation.Infinite
                running: true
            } //Close NumberAnimation

            SequentialAnimation {
                id: swapGlow

                loops: Animation.Infinite
                running: true

                property int duration: 3000

                NumberAnimation {
                    target: swapHalo
                    property: "opacity"
                    duration: swapGlow.duration / 2
                    from: 1
                    to: 0.4
                } //Close NumberAnimation.

                NumberAnimation {
                    target: swapHalo
                    property: "opacity"
                    duration: swapGlow.duration / 2
                    from: 0.4
                    to: 1
                } //Close NumberAnimation.

            } //Close SequentialAnimation.

            NumberAnimation {
                id: swapHaloFade
                target: swapHalo
                property: "opacity"
                duration: 400
                from: 1
                to: 0
                onStopped: {
                    target.opacity = 1
                    target.visible = false
                } //onStopped.
            } //Close NumberAnimation.

        } //Close Image.

        //The button that exits swap mode, visible only in swap mode. (Complete)
        Image {
            id: swapButton

            width: 48
            height: width

            anchors.centerIn: parent

            //The source image. (Complete)
            source: "../assets/gfx/swap.png"

            //The exit button only appears in swap mode. (Complete)
            visible: {
                if (buttonFade.running)
                    return true
                else return swapMode
            }

            //The mouse area, that exits swap mode. (Complete)
            MouseArea {
                id: swapMouseArea

                anchors.fill: parent

                hoverEnabled: true

                onEntered: parent.source = "../assets/gfx/swap2.png"
                onExited: parent.source = "../assets/gfx/swap.png"

                onClicked: {
                    if (gamePolys > 0) {
                        polyPlus(-1)
                        gameScene.swap()
                        bitClick.play()
                        buttonFade.start()
                    } else polyWarn()
                } //Close onClicked. (Complete)

            }//Close MouseArea 'exitMouseArea'. (Complete)

            NumberAnimation {
                id: buttonFade
                target: swapSwitch
                property: "opacity"
                from: 1
                to: 0
                duration: gameScene.fadeTime
                running: false
                onStopped: {
                    target.opacity = 1
                    //                target.visible = false
                }
            }

        } //Close Image 'exitButton'. (Complete)

        Image {
            width: strandText.implicitWidth + 12
            height: strandText.implicitHeight + 4
            source: "../assets/gfx/highlight.png"
            //            opacity: 0.8
            anchors.centerIn: strandText
            visible: strandText.visible
        }

        //The text below the drop button, showing the total continuous strandlength.
        Text {
            id: strandText

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: swapButton.bottom
            anchors.topMargin: 3

            font.family: gameFont.name
            font.bold: true
            font.pixelSize: 18

            style: Text.Outline
            styleColor: "darkcyan" //gameColors.iFaceDarkCol

            //Change the color if the click box is visible.
            color: "white"

            text: "Swap"

            visible: swapButton.visible

        } //Close Text 'strandText'.

    }

} //Close Item 'ladderButton'. (Complete)
