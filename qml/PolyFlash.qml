import QtQuick 2.0
import Felgo 3.0


Item {
    id: polyFlash

    property int duration: 400

    visible: false

    Image {
        id: polyIcon
        width: 18
        height: width
        source: "../assets/gfx/poly.png"
        anchors.centerIn: parent
//        anchors.fill: parent

        ParallelAnimation {
            id: polyShrink

             NumberAnimation {
                 target: polyIcon
                 property: "scale"
                 from: 1
                 to: 0
                 duration: polyFlash.duration
             }

             NumberAnimation {
                 target: polyIcon
                 property: "rotation"
                 from: 0
                 to: {
                     if (Math.floor(Math.random() * 2) < 1)
                         return -360
                     else return 360
                 }
                 duration: polyFlash.duration
             }
        }

        ParallelAnimation {
            id: polyGrow

             NumberAnimation {
                 target: polyIcon
                 property: "scale"
                 from: 0
                 to: 1
                 duration: polyFlash.duration
             }

             NumberAnimation {
                 target: polyIcon
                 property: "rotation"
                 from: 0
                 to: {
                     if (Math.floor(Math.random() * 2) < 1)
                         return -360
                     else return 360
                 }
                 duration: polyFlash.duration
             }
        }

    }

    Rectangle {
        id: flashCircle
        width: 36
        height: width
        radius: height / 2
        anchors.centerIn: parent
        color: "transparent"
        border.width: width / 2
        border.color: "white"

        SequentialAnimation {
            id: flashStart

            property int duration: 800

            onStarted: polyFlash.visible = true

            NumberAnimation {
                target: flashCircle
                property: "scale"
                duration: polyFlash.duration / 2
                from: 0
                to: 1
            } //Close NumberAnimation.

            NumberAnimation {
                target: flashCircle
                property: "border.width"
                duration: polyFlash.duration / 2
                from: target.width / 2
                to: 0
                easing.type: Easing.OutCubic
            } //Close NumberAnimation.

            onStopped: {
                flashCircle.scale = 1
                flashCircle.border.width = flashCircle.width / 2
                polyFlash.visible = false
            } //Close onStarted.

        } //Close SequentialAnimation.

    } //Close Rectangle.

    function flash(gain) {
        if (gain)
            polyGrow.start()
        else polyShrink.start()
        flashStart.start()
    } //Close function flash().

} //Close Item 'flashIcon'.
