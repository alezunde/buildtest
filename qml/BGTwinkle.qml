//--**COMPLETE**--\\

import QtQuick 2.0
import Felgo 3.0

//A nice twinkle star effect for the backgrounds. (Complete)
Item {
    id: bgTwinkle

    //This will be the maxiumum size of the twinkle effect. Also it is square. (Complete)
    anchors.fill: parent
    clip: true

    //The source Image of the star twinkle. (Complete)
    Image {
        id: twinkleImage

        //The "star" of the effect. (Complete)
        width: 24
        height: width //This image is square.

        //Randomly position the star within its parent.
        //(This is atemporary code. It needs more flexibility.
        x: Math.random() * bgTwinkle.width
        y: Math.random() * bgTwinkle.height

        source: "../assets/gfx/shine.png"

        property int spin: Math.floor(Math.random() * 5200) + 800
        property bool dir: {
            if (Math.floor(Math.random() * 2) < 1)
                return false
            else return true
        } //Close property bool dir.


        //A timer that randomly resets opacity, and randomly relocates
        //the star within its parent.
        Timer {
            id: twinkleTime
            running: true
            repeat: true
            interval: Math.floor(Math.random() * 5200) + 800
            onTriggered: {
                parent.x = Math.random() * bgTwinkle.width
                parent.y = Math.random() * bgTwinkle.height
                parent.opacity = Math.random() * 0.4 + 0.4
                parent.spin = Math.floor(Math.random() * 5200) + 800
                parent.dir = Math.floor(Math.random() * 2)
            } //Close onTriggered.
        } //Close Timer 'twinkleTime'.

        ParallelAnimation {
            id: starTwinkle
            loops: Animation.Infinite
            running: true

            NumberAnimation {
                id: spinTime
                target: twinkleImage
                property: "rotation"
                duration: target.spin
                from: 0
                to: {
                if (parent.dir)
                    return 360
                else return -360
                } //Close to.
                loops: Animation.Infinite
            } //Close PropertyAnimation.

            PropertyAnimation {
                id: blinkTime
                target: twinkleImage
                property: "scale"
                duration: target.spin
                //Randomly reset the scale.
                from: Math.random() * 1.5
                to: 0
                loops: Animation.Infinite
            } //Close PropertyAnimation.

        } //Close ParallelAnimation 'starSpin.

    } //Close Image 'twinkleImage'. (Complete)

    //Just a test box. (Complete)
    Rectangle {
        id: testRect

        anchors.fill: parent
        color: "blue"
        opacity: 0.4
        visible: false
    } //Close Rectangle 'testRect'. (Complete)

} //Close Item 'bgTwinkle'. (Complete)
