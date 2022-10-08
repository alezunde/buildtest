//--**COMPLETE**--\\

import QtQuick 2.0
import Felgo 3.0

//The background graphics for the DNA Ladder. (Complete)
//Here, values are relative to the logical scene size of 320 x 480px with an origin of 0, 0.
Item {
    id: dnaLadder

    anchors.fill: parent

    MouseArea {
        id: cancelSelect
        enabled: true
        width: parent.width
        height: parent.height - 113
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: bgPool
        width: parent.width
        height: 113
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        color: gameColors.iFaceBGCol
        opacity: 0.4
    }

    Item {
        id: dnaStripes

        width: 160
        height: parent.height

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        //        anchors.horizontalCenterOffset: -20

        Rectangle {
            id: leftGrad
            height: 60
            width: parent.height
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -50
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceBrightCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
            opacity: 0.3
            rotation: 90
        } //Close Rectangle.

        Item {
            id: upStripe

            width: 60
            height: parent.height - 113
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 20
            anchors.top: parent.top

            clip: true

            Rectangle {
                id: upScan
                width: parent.width - 20
                height: 3
                color: gameColors.iFaceBrightCol
                opacity: 0.8

                anchors.right: parent.right

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: parent.color
                    y: -upStripe.height / 4
                } //Close Rectangle.

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: parent.color
                    y: upStripe.height / 4
                } //Close Rectangle.

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: parent.color
                    y: upStripe.height / 2
                } //Close Rectangle.

                NumberAnimation {
                    target: upScan
                    property: "y"
                    duration: 9000
                    from: upStripe.height * 0.5
                    to: upStripe.height * 0.25
                    loops: Animation.Infinite
                    running: true
                } //Close NumberAnimation.

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: {
                        upScan.opacity = Math.random() * 0.2 + 0.2
                    } //Close onTriggered.
                } //Close Timer.

            } //Close Rectangle.

        } //Close Item 'upStripe'.

        Rectangle {
            id: centerStripe
            width: 40
            height: parent.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceBrightCol}
                GradientStop { position: 1.0; color: gameColors.iFaceBrightCol}
            }
            opacity: 0.3
        }

        Rectangle {
            id: rightGrad
            height: 60
            width: parent.height
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 50
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceBrightCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
            opacity: 0.3
            rotation: -90
        } //Close Rectangle.

        Item {
            id: downStripe

            width: 60
            height: parent.height - 113
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 20
            anchors.top: parent.top

            clip: true

            Rectangle {
                id: downScan
                width: parent.width - 20
                height: 3
                color: gameColors.iFaceBrightCol
                opacity: 0.8

                anchors.left: parent.left

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: parent.color
                    y: -upStripe.height / 4
                } //Close Rectangle.

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: parent.color
                    y: upStripe.height / 4
                } //Close Rectangle.

                Rectangle {
                    width: parent.width
                    height: parent.height
                    color: parent.color
                    y: -upStripe.height / 2
                } //Close Rectangle.

                NumberAnimation {
                    target: downScan
                    property: "y"
                    duration: 9000
                    from: upStripe.height * 0.5
                    to: upStripe.height * 0.75
                    loops: Animation.Infinite
                    running: true
                } //Close NumberAnimation.

                Timer {
                    interval: 100
                    running: true
                    repeat: true
                    onTriggered: {
                        downScan.opacity = Math.random() * 0.2 + 0.2
                    } //Close onTriggered.
                } //Close Timer.

            } //Close Rectangle.

        } //Close Item 'upStripe'.

        Item {
            id: centerBeam
            height: 20
            width: parent.height
            anchors.centerIn: parent
            opacity: 0.4
            rotation: 90

            Rectangle {
                width: parent.width
                height: parent.height / 2
                anchors.bottom: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent"}
                    GradientStop { position: 1.0; color: "white"}
                }
            }

            Rectangle {
                width: parent.width
                height: parent.height / 2
                anchors.top: parent.verticalCenter
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "white"}
                    GradientStop { position: 1.0; color: "transparent"}
                }
            }

            SequentialAnimation {
                running: true
                loops: Animation.Infinite

                NumberAnimation {
                    duration: 1200
                    target: centerBeam
                    property: "height"
                    from: 20
                    to: 40
                }

                NumberAnimation {
                    duration: 1200
                    target: centerBeam
                    property: "height"
                    from: 40
                    to: 20
                }

            }

        }

    } //Close Item 'dnaStripes'.

    Item {
        id: strandIcons

        width: 52
        height: 280
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.top: parent.top
        anchors.topMargin: 197

        opacity: 0.6

        Rectangle {
            width: 6
            height: parent.height
            anchors.left: parent.left
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceDarkCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
            //            opacity: 0.6
        }

        Rectangle {
            width: 12
            height: parent.height / 3
            anchors.horizontalCenter: parent.horizontalCenter
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceLightCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
            //            opacity: 0.6
        }

        Rectangle {
            width: 6
            height: parent.height
            anchors.right: parent.right
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceDarkCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
            //            opacity: 0.6
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: gameColors.iFaceDSCol
            border.width: 2
            //            opacity: 0.8
        }

        Rectangle {
            id: iconScan1
            width: parent.width - 4
            height: 2
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter

            NumberAnimation {
                running: true
                loops: Animation.Infinite
                target: iconScan1
                property: "y"
                from: 2
                to: 170
                duration: 6000
            }

            Timer {
                running: true
                repeat: true
                interval: 60
                onTriggered: iconScan1.opacity = (Math.floor(Math.random() * 40) + 20) / 100
            }
        }

        Rectangle {
            id: iconScan2
            width: parent.width - 4
            height: 2
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter

            NumberAnimation {
                running: true
                loops: Animation.Infinite
                target: iconScan2
                property: "y"
                from: 2
                to: 170
                duration: Math.floor(Math.random() * 4000) + 4000
            }

            Timer {
                running: true
                repeat: true
                interval: 60
                onTriggered: iconScan2.opacity = (Math.floor(Math.random() * 40) + 20) / 100
            }
        }
    }
    Rectangle {
        width: strandIcons.width
        height: 5
        anchors.horizontalCenter: strandIcons.horizontalCenter
        anchors.bottom: strandIcons.top
//        anchors.bottomMargin: -2
        color: gameColors.iFaceCol

        Rectangle {
            width: 2
            height: parent.width
            color: "white"
            gradient: Gradient {
                GradientStop { position: 0.0; color: "white"}
                GradientStop { position: 1.0; color: "transparent"}
            }
            rotation: -90
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -2
            visible: swapMode
        }
    }

    Item {
        id: downArrows

        anchors.left: parent.left
        anchors.leftMargin: 42
        anchors.top: parent.top
        //        anchors.topMargin: 88 + rows * 50

        visible: false

        Row {
            id: arrowRow

            property int arrowSize: 24

            Item {
                width: 50
                height: width

                Image {
                    width: arrowRow.arrowSize
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/downArrow.png"
                } //Close Image.

            } //Close Item.

            Item {
                width: 50
                height: width

                Image {
                    width: arrowRow.arrowSize
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/downArrow.png"
                } //Close Image.

            } //Close Item.

            Item {
                width: 50
                height: width

                Image {
                    width: arrowRow.arrowSize
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/downArrow.png"
                } //Close Image.

            } //Close Item.

            Item {
                width: 50
                height: width

                Image {
                    width: arrowRow.arrowSize
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/downArrow.png"
                } //Close Image.

            } //Close Item.

        } //Close Row.

        ParallelAnimation {
            id: arrowAnim

            loops: Animation.Infinite
            running: true

            property int duration: 2000

            NumberAnimation {
                id: arrowBlink
                target: downArrows
                property: "opacity"
                duration: arrowAnim.duration
                from: 0.8
                to: 0
                easing.type: Easing.OutQuart
            } //Close NumberAnimation.

            NumberAnimation {
                id: arrowBounce
                target: arrowRow
                property: "y"
                duration: arrowAnim.duration
                from: y - 8
                to: y + 24
                easing.type: Easing.OutQuart
            } //Close NumberAnimation.

        } //Close ParallelAnimation.

    } //Close Item 'downArrows'.

} //Close Item 'dnaLadder'. (Complete)
