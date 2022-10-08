import QtQuick 2.0
import Felgo 3.0

Item {
    id: polyBar

    width: polyRow.width
    height: polyRow.height

    Row {
        id: polyRow

        height: 28
        anchors.centerIn: parent

        spacing: 6

        property var color: gameColors.iFaceCol
        property var borCol: gameColors.iFaceDarkCol
        property int borWid: 3

        Item {
            id: poly1

            width: parent.height
            height: width

            Rectangle {
                width: parent.height
                height: width
                radius: height / 2
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                color: gameColors.iFaceDSCol
            } //Close Rectangle.

            Rectangle {
                width: parent.width
                height: width
                radius: height / 2
                anchors.centerIn: parent
                color: polyRow.color
                border.width: polyRow.borWid
                border.color: polyRow.borCol

                Image {
                    width: 20
                    height: width
                    anchors.centerIn: parent
                    source:
                        if (gamePolys >= 1)
                            return "../assets/gfx/poly.png"
                        else return "../assets/gfx/poly2.png"
                } //Close Image 'poly1'.

            } //Close Rectangle.

        } //Close Item.

        Item {
            id: poly2

            width: parent.height
            height: width

            Rectangle {
                width: parent.height
                height: width
                radius: height / 2
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                color: gameColors.iFaceDSCol
            } //Close Rectangle.

            Rectangle {
                width: parent.width
                height: width
                radius: height / 2
                anchors.centerIn: parent
                color: polyRow.color
                border.width: polyRow.borWid
                border.color: polyRow.borCol

                Image {
                    width: 20
                    height: width
                    anchors.centerIn: parent
                    source:
                        if (gamePolys >= 2)
                            return "../assets/gfx/poly.png"
                        else return "../assets/gfx/poly2.png"
                } //Close Image 'poly2'.

            } //Close Rectangle.

        } //Close Item.

        Item {
            id: poly3

            width: parent.height
            height: width

            Rectangle {
                width: parent.height
                height: width
                radius: height / 2
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                color: gameColors.iFaceDSCol
            } //Close Rectangle.

            Rectangle {
                width: parent.width
                height: width
                radius: height / 2
                anchors.centerIn: parent
                color: polyRow.color
                border.width: polyRow.borWid
                border.color: polyRow.borCol

                Image {
                    width: 20
                    height: width
                    anchors.centerIn: parent
                    source:
                        if (gamePolys >= 3)
                            return "../assets/gfx/poly.png"
                        else return "../assets/gfx/poly2.png"
                } //Close Image 'poly2'.

            } //Close Rectangle.

        } //Close Item.

        Item {
            id: poly4
            width: parent.height
            height: width

            Rectangle {
                width: parent.height
                height: width
                radius: height / 2
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                color: gameColors.iFaceDSCol
            } //Close Rectangle.

            Rectangle {
                width: parent.width
                height: width
                radius: height / 2
                anchors.centerIn: parent
                color: polyRow.color
                border.width: polyRow.borWid
                border.color: polyRow.borCol

                Image {
                    width: 20
                    height: width
                    anchors.centerIn: parent
                    source:
                        if (gamePolys >= 4)
                            return "../assets/gfx/poly.png"
                        else return "../assets/gfx/poly2.png"
                } //Close Image 'poly2'.

            } //Close Rectangle.

        } //Close Item.

    } //Close Row 'polyRow'.

    Row {
        id: polyFlashes

        height: 18
        anchors.centerIn: parent

        spacing: 16

        visible: false

        property var color: gameColors.iFaceCol
        property var borCol: gameColors.iFaceDarkCol
        property int borWid: 3

        Image {
            width: parent.height
            height: width
            source: "../assets/gfx/poly.png"
        } //Close Image 'poly1'.

        Image {
            width: parent.height
            height: width
            source: "../assets/gfx/poly.png"
        } //Close Image 'poly2'.

        Image {
            width: parent.height
            height: width
            source: "../assets/gfx/poly.png"
        } //Close Image 'poly3'.

        Image {
            width: parent.height
            height: width
            source: "../assets/gfx/poly.png"
        } //Close Image 'poly4'.

    } //Close Row 'polyRow'.

    PolyFlash {
        id: polyFlash
        width: parent.height
        height: width
        anchors.centerIn: parent
    }

    NumberAnimation {
        id: polyWarning
        target: polyFlashes
        property: "opacity"
        from: 1
        to: 0
        duration: 200

        property int flashes: 0

        onStarted: {
            if (flashes ===0)
                polyOut.play()
            polyFlashes.visible = true
        }

        onStopped: {
            if (polyWarning.flashes <= 3) {
                polyWarning.flashes += 1
                polyWarning.start()
            } else {
                polyFlashes.opacity = 1
                polyFlashes.visible = false
                polyWarning.flashes = 0
            }
        }
    }

    function polyWarn() {
        polyWarning.start()
    }

    function polyPlus(num) {

        var polySum = gamePolys + num
        var polysMaxed = false
        var polyGain = false

        if (polySum < 0)
            polySum = 0
        else
            if (polySum >= maxPolys) {
                polySum = maxPolys
                polysMaxed = true
            }

        if (polySum > gamePolys) {
            polyGain = true
            strandUp.play()
        } else {
            if (polySum !== gamePolys)
                strandBreak.play()
            polyGain = false
        }

        gamePolys = polySum

        var flashOffset

        if (gamePolys === 0)
            flashOffset = -51
        if (gamePolys === 1)
            flashOffset = -17
        if (gamePolys === 2)
            flashOffset = 17
        if (gamePolys === 3)
            flashOffset = 51
        if (gamePolys === 4)
            flashOffset = 85

        if (polyGain)
            flashOffset -= 34

        polyFlash.anchors.horizontalCenterOffset = flashOffset
        if (gamePolys < maxPolys)
            polyFlash.flash(polyGain)
        else if (polyGain) polyFlash.flash(polyGain)

    } //Close function.

} //Close Item 'polyBar'.
