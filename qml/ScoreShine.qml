import QtQuick 2.0
import Felgo 3.0

Item {
    id: scoreShine

    width: parent.width + 36
    height: 6
    anchors.horizontalCenter: parent.horizontalCenter
    visible: false

    property int duration: gameScene.flashTime

    Timer {
        id: sndTimer
        interval: scoreShine.duration / 2
        onTriggered: gameScene.strandUp.play()
    }

    Image {
        id: glowLine
        anchors.fill: parent
        source: "../assets/gfx/highlight.png"
//        opacity: 0

        SequentialAnimation {
            id: lineFlash
            NumberAnimation {
                target: glowLine
                property: "opacity"
                from: 0
                to: 1
                duration: scoreShine.duration
                easing.type: Easing.InCirc
            }
            NumberAnimation {
                target: glowLine
                property: "opacity"
                from: 1
                to: 0
                duration: scoreShine.duration
                easing.type: Easing.OutCirc
            }
        }
    }

    Image {
        id: shine
        width: 24
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "../assets/gfx/shine.png"
//        opacity: 0

        NumberAnimation {
            target: shine
            property: "rotation"
            from: 0
            to: 360
            duration: scoreShine.duration
            running: true
            loops: Animation.Infinite
        }

        SequentialAnimation {
            id: shineShift
            running: false

            ParallelAnimation {

                NumberAnimation {
                    target: shine
                    property: "anchors.horizontalCenterOffset"
                    from: -parent.width
                    to: 0
                    duration: scoreShine.duration
                    easing.type: Easing.InCirc
                }
                NumberAnimation {
                    target: shine
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: scoreShine.duration
                    easing.type: Easing.InCirc
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: shine
                    property: "anchors.horizontalCenterOffset"
                    from: 0
                    to: parent.width
                    duration: scoreShine.duration
                    easing.type: Easing.OutCirc
                }
                NumberAnimation {
                    target: shine
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: scoreShine.duration
                    easing.type: Easing.OutCirc
                }
            }
        }
    }

    function scoreFlash() {
        scoreShine.visible = true
        sndTimer.start()
        shineShift.start()
        lineFlash.start()
    }

}
