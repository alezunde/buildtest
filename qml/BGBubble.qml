import QtQuick 2.0
import Felgo 3.0

//An animated bubble graphical element.
//(Working)
Item {
    id: bgBubble

    anchors.fill: parent
    clip: true

    //The source Image of the bubble. (Complete)
    Image {
        id: bubImage

        //Size the bubble according to its scale.
        width: Math.random() * 20 + 4
        height: width
        x: Math.random() * parent.width
        y: bgBubble.height

        source: "../assets/gfx/bubble.png"

        property int dur: Math.random() * 4000 + 12000

        //Set a random opacity with a floor of 30%.
        opacity: Math.random() * 0.7 + 0.3

        ParallelAnimation {
            id: bubFloat
            running: true

            NumberAnimation {
                id: bubRise
                target: bubImage
                property: "y"
                duration: bubImage.dur
                to: 0
            } //Close NumberAnimation.

            NumberAnimation {
                id: bubSpin
                target: bubImage
                property: "rotation"
                duration: bubImage.dur
                from: 0
                to: {
                    if (Math.floor(Math.random() * 2) < 1)
                        return -360
                    else return 360
                } //Close to.
            } //Close NumberAnimation.

            onStopped: {
                bubImage.width = Math.random() * 20 + 4
                bubImage.x = Math.random() * bgBubble.width
                bubImage.y = (Math.random() * bgBubble.height / 4) + (bgBubble.height / 4) * 3
                bubImage.opacity = Math.random() * 0.8
                bubImage.dur = Math.random() * 4000 + 12000
                restart()
            } //Close onStopped.

        } //Close ParallelAnimation 'bubRise'.

                Timer {
                    id: bubPop
                    interval: Math.random() * 2000 + 6000
                    running: true
                    repeat: true
                    onTriggered: {
                        parent.width = Math.random() * 20 + 4
                        parent.x = Math.random() * bgBubble.width
                        parent.y = bgBubble.height
                        parent.opacity = Math.random() * 0.8
                    } //Close onTriggered.
                } //Close Timer 'bubPop'.

    } //Close Image 'bubImage'.

} //Close Item 'bgBubble'. (Working)
