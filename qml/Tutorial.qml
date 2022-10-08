import QtQuick 2.0
import Felgo 3.0

Item {
    id: gameTut

    anchors.fill: parent

    property int tutStage: 0

    visible: tutStage >= 0

    Rectangle {
        id: backGrad
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: gameColors.iFaceCol}
            GradientStop { position: 1.0; color: gameColors.iFaceBGCol}
        }
        opacity: 0.4

        property double maxOpacity: 0.4

        function fade(out) {
            if (out === undefined || out === "out") {
                backFade.from = 0.4
                backFade.to = 0
                backFade.start()
            }
            if (out === "in") {
                backFade.from = 0
                backFade.to = 0.4
                backFade.start()
            }
        }

        NumberAnimation {
            id: backFade
            target: backGrad
            property: "opacity"
            duration: 200
        }
    }

    Item {
        id: topBotGrads
        anchors.fill: parent
        opacity: 0.8

        NumberAnimation {
            id: gradsFade
            target: topBotGrads
            property: "opacity"
            from: 0.8
            to: 0
            duration: 200
            onStopped: {
                intro19.opacity = 1
                target.opacity = 0.8
                tutStage = -1
            }
        }

        Rectangle {
            id: topGrad
            width: parent.width
            height: parent.height / 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceCol}
                GradientStop { position: 1.0; color: "transparent"}
            }
        }

        Rectangle {
            id: botGrad
            width: parent.width
            height: parent.height / 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            gradient: Gradient {
                GradientStop { position: 0.0; color: "transparent"}
                GradientStop { position: 1.0; color: gameColors.iFaceBGCol}
            }
        }

        Rectangle {
            width: 52
            height: width
            radius: height / 2
            color: gameColors.iFaceCol
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.top: parent.top
            anchors.topMargin: 64
        }

        Rectangle {
            width: 52
            height: 175
            color: gameColors.iFaceBGCol
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 113
        }
    }

    Item {
        id: backLadder
        width: 120
        height: 280
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        visible: tutStage === 2

        Rectangle {
            id: leftRail
            width: 8
            height: parent.height
            radius: width / 2
            anchors.horizontalCenter: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            color: "white"
        }
        Rectangle {
            id: rightRail
            width: 8
            height: parent.height
            radius: width / 2
            anchors.horizontalCenter: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            color: "white"
        }
        Rectangle {
            id: rung1
            width: parent.width
            height: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -140
            color: "white"
        }
        Rectangle {
            id: rung2
            width: parent.width
            height: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -100
            color: "white"
        }
        Rectangle {
            id: rung3
            width: parent.width
            height: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -60
            color: "white"
        }
        Rectangle {
            id: rung4
            width: parent.width
            height: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 60
            color: "white"
        }
        Rectangle {
            id: rung5
            width: parent.width
            height: 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 100
            color: "white"
        }
    }

    Item {
        id: colHLs
        anchors.fill: parent

        visible: tutStage === 3

        SequentialAnimation {
            id: colsFade
            running: colHLs.visible
            loops: Animation.Infinite

            property int duration: 1200

            ParallelAnimation {
                NumberAnimation {
                    target: leftHL
                    property: "opacity"
                    from: 0.2
                    to: 0.6
                    duration: colsFade.duration
                }
                NumberAnimation {
                    target: rightHL
                    property: "opacity"
                    from: 0.8
                    to: 0.4
                    duration: colsFade.duration
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: leftHL
                    property: "opacity"
                    from: 0.6
                    to: 0.2
                    duration: colsFade.duration
                }
                NumberAnimation {
                    target: rightHL
                    property: "opacity"
                    from: 0.4
                    to: 0.8
                    duration: colsFade.duration
                }
            }
        }

        Rectangle {
            id: leftHL
            width: 80
            height: 280
            radius: 6
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            color: gameColors.iFaceLightCol
            opacity: 0.6
        }

        Rectangle {
            id: leftHLBorder
            anchors.fill: leftHL
            radius: 6
            color: "transparent"
            border.color: gameColors.iFaceBrightCol
            border.width: 2
        }

        Item {
            id: upArrows
            width: leftHL.width
            height: 40
            anchors.horizontalCenter: leftHL.horizontalCenter
            anchors.bottom: leftHL.bottom
            anchors.bottomMargin: 6

            Image {
                width: parent.width - 12
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: "../assets/gfx/tri.png"
                rotation: 180
            }

            Image {
                width: parent.width - 12
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                source: "../assets/gfx/tri.png"
                rotation: 180
            }

            SequentialAnimation {
                running: colHLs.visible
                loops: Animation.Infinite

                NumberAnimation {
                    target: upArrows
                    property: "anchors.bottomMargin"
                    from: 6
                    to: 12
                    duration: 600
                    easing.type: Easing.OutCirc
                }
                NumberAnimation {
                    target: upArrows
                    property: "anchors.bottomMargin"
                    from: 12
                    to: 6
                    duration: 600
                    easing.type: Easing.InCirc
                }
            }

        }

        Rectangle {
            id: rightHL
            width: 80
            height: 280
            radius: 6
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -20
            color: gameColors.iFaceCol
            opacity: 0.6
        }

        Rectangle {
            id: rightHLBorder
            anchors.fill: rightHL
            radius: 6
            color: "transparent"
            border.color: gameColors.iFaceBrightCol
            border.width: 2
        }

        Item {
            id: downArrows
            width: rightHL.width
            height: 40
            anchors.horizontalCenter: rightHL.horizontalCenter
            anchors.bottom: rightHL.bottom
            anchors.bottomMargin: 6

            Image {
                width: parent.width - 12
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: "../assets/gfx/tri.png"
            }

            Image {
                width: parent.width - 12
                height: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                source: "../assets/gfx/tri.png"
            }

            SequentialAnimation {
                running: colHLs.visible
                loops: Animation.Infinite

                NumberAnimation {
                    target: downArrows
                    property: "anchors.bottomMargin"
                    from: 12
                    to: 6
                    duration: 600
                    easing.type: Easing.InCirc
                }
                NumberAnimation {
                    target: downArrows
                    property: "anchors.bottomMargin"
                    from: 6
                    to: 12
                    duration: 600
                    easing.type: Easing.OutCirc
                }
            }
        }
    }

    Item {
        id: tutPlat
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage >= 0 && tutStage < 17

        Rectangle {
            id: platDS
            width: plat.width
            height: plat.height
            anchors.centerIn: plat
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenterOffset: 3
            radius: plat.radius
            color: gameColors.iFaceDSCol
        }

        Rectangle {
            id: plat
            anchors.fill: parent
            radius: 6
            color: gameColors.iFaceDarkCol
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
                GradientStop { position: 1.0; color: gameColors.iFaceCol}
            }
            border.color: gameColors.iFaceBrightCol
            border.width: 2
        }

        Item {
            id: platBG
            width: plat.width - plat.border.width * 2
            height: plat.height - plat.border.width * 2
            anchors.centerIn: plat
            clip: true

            Image {
                width: 320
                height: 480
                anchors.centerIn: parent
                source: "../assets/gfx/tutBG.png"
                opacity: 0.2
            }
        }

        Item {
            id: backRect
            width: 100
            height: 20
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.verticalCenter
            anchors.topMargin: 8

            Rectangle {
                id: back
                anchors.fill: parent
                radius: 4
                color: gameColors.iFaceCol
                border.color: "black"
                border.width: 2

                visible: tutStage > 1

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        back.color = gameColors.iFaceLightCol
                        back.border.color = "white"
                        backTxt.color = "white"
                    }
                    onExited: {
                        back.color = gameColors.iFaceCol
                        back.border.color = "black"
                        backTxt.color = "black"
                    }
                    onClicked: {
                        bitClick.play()
                        if (tutStage === 2)
                            tutStage = 1
                        if (tutStage === 3) {
                            backFade.stop()
                            backGrad.opacity = backGrad.maxOpacity
                            tutStage = 2
                        }
                        if (tutStage === 4) {
                            backGrad.fade()
                            tutStage = 3
                        }
                        if (tutStage === 5) {
                            flipAnim.stop()
                            tutStage = 4
                        }
                        if (tutStage === 6) {
                            flipAnim2.stop()
                            flipAnim.start()
                            tutStage = 5
                        }
                        if (tutStage === 7) {
                            tutPlat2.stretch(0)
                            flipAnim2.start()
                            tutStage = 6
                        }
                        if (tutStage === 8) {
                            backGrad.fade("in")
                            tutStage = 7
                        }
                        if (tutStage === 9) {
                            sel1.stop()
                            sel2.stop()
                            sel3.stop()
                            sel4.stop()
                            sel5.stop()
                            bitSelectHL.anchors.horizontalCenterOffset = -80
                            backGrad.fade()
                            tutStage = 8
                        }
                        if (tutStage === 10) {
                            tutStage = 9
                        }
                        if (tutStage === 11) {
                            tutStage = 10
                        }
                        if (tutStage === 12) {
                            tutStage = 11
                        }
                        if (tutStage === 13) {
                            tutPlat2.stretch(3)
                            tutStage = 12
                        }
                        if (tutStage === 14)
                            tutStage = 13
                        if (tutStage === 15)
                            tutStage = 14
                        if (tutStage === 16)
                            tutStage = 15
                        if (tutStage === 17)
                            tutStage = 16
                    }
                }

                Text {
                    id: backTxtDS
                    anchors.centerIn: backTxt
                    anchors.horizontalCenterOffset: 1
                    anchors.verticalCenterOffset: 1
                    font.family: backTxt.font.family
                    font.pixelSize: backTxt.font.pixelSize
                    color: gameColors.iFaceDarkCol
                    text: backTxt.text
                }

                Text {
                    id: backTxt
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 1
                    font.family: gameFont.name
                    font.pixelSize: 14
                    color: "black"
                    text: "<< Back"
                }
            }

        }

        Item {
            id: nextRect
            width: 100
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 14
            anchors.top: parent.verticalCenter
            anchors.topMargin: 8

            visible: tutStage > 1

            Rectangle {
                id: next
                anchors.fill: parent
                radius: 4
                color: gameColors.iFaceCol
                border.color: "black"
                border.width: 2

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        next.color = gameColors.iFaceLightCol
                        next.border.color = "white"
                        nextTxt.color = "white"
                    }
                    onExited: {
                        next.color = gameColors.iFaceCol
                        next.border.color = "black"
                        nextTxt.color = "black"
                    }
                    onClicked: {
                        bitClick.play()
                        if (tutStage === 16) {
                            platSpread.start()
                            tutStage = 17
                        }
                        if (tutStage === 15)
                            tutStage = 16
                        if (tutStage === 14)
                            tutStage = 15
                        if (tutStage === 13)
                            tutStage = 14
                        if (tutStage === 12) {
                            tutPlat2.stretch(2)
                            tutStage = 13
                        }
                        if (tutStage === 11)
                            tutStage = 12
                        if (tutStage === 10)
                            tutStage = 11
                        if (tutStage === 9) {
                            sel1.stop()
                            sel2.stop()
                            sel3.stop()
                            sel4.stop()
                            sel5.stop()
                            bitSelectHL.anchors.horizontalCenterOffset = -80
                            backGrad.opacity = 0.4
                            tutStage = 10
                        }
                        if (tutStage === 8) {
                            backGrad.fade("in")
                            tutStage = 9
                        }
                        if (tutStage === 7) {
                            backGrad.fade()
                            tutStage = 8
                        }
                        if (tutStage === 6) {
                            flipAnim2.stop()
                            tutPlat2.stretch(1)
                            errorFade4.start()
                            tutStage = 7
                        }
                        if (tutStage === 5) {
                            flipAnim.stop()
                            flipAnim2.start()
                            tutStage = 6
                        }
                        if (tutStage === 4) {
                            flipAnim.start()
                            tutStage = 5
                        }
                        if (tutStage === 3) {
                            backGrad.fade("in")
                            tutStage = 4
                        }
                        if (tutStage === 2) {
                            backGrad.fade()
                            tutStage = 3
                        }
                        if (tutStage === 1)
                            tutStage = 2
                    }
                }

                Text {
                    id: nextTxtDS
                    anchors.centerIn: nextTxt
                    anchors.horizontalCenterOffset: 1
                    anchors.verticalCenterOffset: 1
                    font.family: nextTxt.font.family
                    font.pixelSize: nextTxt.font.pixelSize
                    color: gameColors.iFaceDarkCol
                    text: nextTxt.text
                }

                Text {
                    id: nextTxt
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 1
                    font.family: gameFont.name
                    font.pixelSize: 14
                    color: "black"
                    text: "Next >>"
                }
            }

        }

    }

    Item {
        id: tutPlat2
        width: 60
        height: 60

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: 50

        visible: {
            if (tutStage === 8)
                return false
            if (tutStage === 9)
                return false
            if (tutStage === 10)
                return false
            if (tutStage === 11)
                return false
            if (tutStage >= 14)
                return false
            return tutStage >= 4
        }

        NumberAnimation {
            id: platStretch
            target: tutPlat2
            duration: 200
        }

        Rectangle {
            id: plat2DS
            width: plat2.width
            height: plat2.height
            radius: plat2.radius
            anchors.centerIn: plat2
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenterOffset: 3
            color: gameColors.iFaceDSCol
        }

        Rectangle {
            id: plat2
            anchors.fill: parent
            radius: 6
            gradient: Gradient {
                GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
                GradientStop { position: 1.0; color: gameColors.iFaceCol}
            }
            border.color: gameColors.iFaceBrightCol
            border.width: 2

            Item {
                id: plat2BG
                width: parent.width - parent.border.width * 2
                height: parent.height - parent.border.width * 2
                anchors.centerIn: parent
                clip: true

                Image {
                    width: 320
                    height: 480
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    source: "../assets/gfx/tutBG.png"
                    opacity: 0.2
                }
            }
        }

        function stretch(phase) {
            if (phase === 0) {
                platStretch.property = "width"
                platStretch.to = 60
            }
            if (phase === 1) {
                platStretch.property = "width"
                platStretch.to = 220
            }
            if (phase === 2) {
                platStretch.property = "height"
                platStretch.to = 100
            }
            if (phase === 3) {
                platStretch.property = "height"
                platStretch.to = 60
            }
            if (phase !== undefined)
                platStretch.start()
        }
    }

    Rectangle {
        id: skipBut
        width: 120
        height: 20
        radius: 4
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        color: gameColors.iFaceCol
        border.color: "black"
        border.width: 2

        visible: tutStage > 1 && tutStage < 17

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                skipBut.color = gameColors.iFaceLightCol
                skipBut.border.color = "white"
                skipButTxt.color = "white"
            }
            onExited: {
                skipBut.color = gameColors.iFaceCol
                skipBut.border.color = "black"
                skipButTxt.color = "black"
            }
            onClicked: {
                bitClick.play()
                tutPlat2.width = 60
                tutPlat2.height = 60
                backGrad.fade()
                elementsEnabled = true
                tutStage = -1
            }
        }

        Text {
            id: skipButTxtDS
            anchors.centerIn: skipButTxt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            font.family: skipButTxt.font.family
            font.pixelSize: skipButTxt.font.pixelSize
            color: gameColors.iFaceDarkCol
            text: skipButTxt.text
        }

        Text {
            id: skipButTxt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            font.family: gameFont.name
            font.pixelSize: 14
            color: "black"
            text: "Skip Tutorial >>"
        }
    }

    Item {
        id: intro1
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 0

        Text {
            id: intro1txtDS
            font.family: intro1txt.font.family
            font.pixelSize: intro1txt.font.pixelSize
            horizontalAlignment: intro1txt.horizontalAlignment
            anchors.centerIn: intro1txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro1txt.text
        }

        Text {
            id: intro1txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Hi! I'm helperHand!<br/>Would you like a starting lesson?"
        }

        Rectangle {
            id: yBut
            width: 100
            height: 20
            radius: 4
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 8
            anchors.top: parent.verticalCenter
            anchors.topMargin: 8
            color: gameColors.iFaceCol
            border.color: "black"
            border.width: 2

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    yBut.color = gameColors.iFaceLightCol
                    yBut.border.color = "white"
                    yButTxt.color = "white"
                }
                onExited: {
                    yBut.color = gameColors.iFaceCol
                    yBut.border.color = "black"
                    yButTxt.color = "black"
                }
                onClicked: {
                    bitClick.play()
                    tutStage = 1
                }
            }

            Text {
                id: yButTxtDS
                anchors.centerIn: yButTxt
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                font.family: yButTxt.font.family
                font.pixelSize: yButTxt.font.pixelSize
                color: gameColors.iFaceDarkCol
                text: yButTxt.text
            }

            Text {
                id: yButTxt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                font.family: gameFont.name
                font.pixelSize: 14
                color: "black"
                text: "Yes, please!"
            }
        }

        Rectangle {
            id: nBut
            width: 100
            height: 20
            radius: 4
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 8
            anchors.top: parent.verticalCenter
            anchors.topMargin: 8
            color: gameColors.iFaceCol
            border.color: "black"
            border.width: 2

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    nBut.color = gameColors.iFaceLightCol
                    nBut.border.color = "white"
                    nButTxt.color = "white"
                }
                onExited: {
                    nBut.color = gameColors.iFaceCol
                    nBut.border.color = "black"
                    nButTxt.color = "black"
                }
                onClicked: {
                    bitClick.play()
                    backGrad.fade()
                    elementsEnabled = true
                    tutStage = -1
                }
            }

            Text {
                id: nButTxtDS
                anchors.centerIn: nButTxt
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                font.family: nButTxt.font.family
                font.pixelSize: nButTxt.font.pixelSize
                color: gameColors.iFaceDarkCol
                text: nButTxt.text
            }

            Text {
                id: nButTxt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                font.family: gameFont.name
                font.pixelSize: 14
                color: "black"
                text: "No, thanks."
            }
        }
    }

    Item {
        id: intro2
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 1

        Text {
            id: intro2txtDS
            font.family: intro2txt.font.family
            font.pixelSize: intro2txt.font.pixelSize
            horizontalAlignment: intro2txt.horizontalAlignment
            anchors.centerIn: intro2txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro2txt.text
        }

        Text {
            id: intro2txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Welcome!<br/>Let's talk about DNA!"
        }

        Rectangle {
            id: okayBut
            width: 100
            height: 20
            radius: 4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: 8
            color: gameColors.iFaceCol
            border.color: "black"
            border.width: 2

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    okayBut.color = gameColors.iFaceLightCol
                    okayBut.border.color = "white"
                    okayTxt.color = "white"
                }
                onExited: {
                    okayBut.color = gameColors.iFaceCol
                    okayBut.border.color = "black"
                    okayTxt.color = "black"
                }
                onClicked: {
                    bitClick.play()
                    tutStage = 2
                }
            }

            Text {
                id: okayTxtDS
                anchors.centerIn: okayTxt
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                font.family: okayTxt.font.family
                font.pixelSize: okayTxt.font.pixelSize
                color: gameColors.iFaceDarkCol
                text: okayTxt.text
            }

            Text {
                id: okayTxt
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                font.family: gameFont.name
                font.pixelSize: 14
                color: "black"
                text: "Okay!"
            }
        }
    }

    Item {
        id: intro3
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 2

        Text {
            id: intro3txtDS
            font.family: intro3txt.font.family
            font.pixelSize: intro3txt.font.pixelSize
            horizontalAlignment: intro3txt.horizontalAlignment
            anchors.centerIn: intro3txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro3txt.text
        }

        Text {
            id: intro3txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "When DNA is not twisted or coiled up<br/>like normal, it looks like a LADDER."
        }
    }

    Item {
        id: intro4
        anchors.fill: parent
        visible: tutStage === 3

        Item {
            id: plat4Box
            width: 260
            height: 80
            anchors.centerIn: parent

            Text {
                id: intro4txtDS
                font.family: intro4txt.font.family
                font.pixelSize: intro4txt.font.pixelSize
                horizontalAlignment: intro4txt.horizontalAlignment
                anchors.centerIn: intro4txt
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                color: "black"
                text: intro4txt.text
            }

            Text {
                id: intro4txt
                font.family: chatFont.name
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                color: "white"
                text: "The LEFT side goes UP, while<br/>the RIGHT side goes DOWN."
            }
        }
    }

    Item {
        id: intro5
        anchors.fill: parent
        visible: tutStage === 4

        Item {
            id: plat5Box
            width: 260
            height: 80
            anchors.centerIn: parent

            Text {
                id: intro5txtDS
                font.family: intro5txt.font.family
                font.pixelSize: intro5txt.font.pixelSize
                horizontalAlignment: intro5txt.horizontalAlignment
                anchors.centerIn: intro5txt
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                color: "black"
                text: intro5txt.text
            }

            Text {
                id: intro5txt
                font.family: chatFont.name
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                color: "white"
                text: "When a BIT is facing the wrong<br/>direction, it develops an ERROR."
            }

            Item {
                id: errorBox
                width: 60
                height: width

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: 10

                Image {
                    id: bitGlow
                    width: 40
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/highlight.png"
                    Timer {
                        running: true
                        repeat: true
                        interval: 60
                        onTriggered: bitGlow.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                    }
                }

                Image {
                    id: bitImage
                    width: 32
                    height: width

                    anchors.centerIn: parent

                    source: "../assets/gfx/dna_dr2.png"

                    SequentialAnimation {
                        id: errFade
                        running: intro5.visible
                        loops: Animation.Infinite

                        property int duration: 1200

                        ParallelAnimation {
                            NumberAnimation {
                                target: err1
                                property: "opacity"
                                duration: errFade.duration
                                from: 1
                                to: 0
                            }
                            NumberAnimation {
                                target: err2
                                property: "opacity"
                                duration: errFade.duration
                                from: 0
                                to: 1
                            }
                        }
                        ParallelAnimation {
                            NumberAnimation {
                                target: err1
                                property: "opacity"
                                duration: errFade.duration
                                from: 0
                                to: 1
                            }
                            NumberAnimation {
                                target: err2
                                property: "opacity"
                                duration: errFade.duration
                                from: 1
                                to: 0
                            }
                        }
                    }

                    Image {
                        id: err1
                        width: 40
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/error.png"
                    } //Close Image 'bitErrorSign'. (Complete)

                    //The image that appears if there is an error. (Complete)
                    Image {
                        id: err2
                        width: 40
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/error2.png"
                    } //Close Image 'bitErrorSign'. (Complete)

                }
            }
        }
    }

    Item {
        id: intro6
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 5

        Text {
            id: intro6txtDS
            font.family: intro6txt.font.family
            font.pixelSize: intro6txt.font.pixelSize
            horizontalAlignment: intro6txt.horizontalAlignment
            anchors.centerIn: intro6txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro6txt.text
        }

        Text {
            id: intro6txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Press and Hold any BIT to<br/>FLIP it and fix an ERROR."
        }

        Item {
            id: errorBox2
            width: 60
            height: width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 10

            Image {
                id: bitGlow2
                width: 40
                height: width
                anchors.centerIn: parent
                source: "../assets/gfx/highlight.png"
                Timer {
                    running: true
                    repeat: true
                    interval: 60
                    onTriggered: bitGlow2.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                }
            }

            Item {
                id: flipImage
                width: 40
                height: width

                anchors.centerIn: parent

                Image {
                    id: bitImage2
                    width: 32
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/dna_dr.png"

                    Image {
                        id: err1b
                        width: 40
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/error.png"
                    } //Close Image 'bitErrorSign'. (Complete)
                }

                Timer {
                    id: flashTimer
                    running: false
                    interval: 1500
                    onTriggered: flipAnim.start()
                }

                SequentialAnimation {
                    id: flipAnim
                    running: false

                    alwaysRunToEnd: false

                    onStarted: {
                        bitImage2.source = "../assets/gfx/dna_dr.png"
                        err1b.visible = true
                    }
                    onStopped: {
                        bitImage2.source = "../assets/gfx/dna_dr2.png"
                        err1b.visible = false
                        bitFlash.start()
                    }

                    NumberAnimation {
                        target: holdBar
                        property: "width"
                        from: 40
                        to: 0
                        duration: 800
                    }
                    NumberAnimation {
                        target: bitImage2
                        property: "rotation"
                        from: 0
                        to: 180
                        duration: 200
                    }
                }

                Rectangle {
                    id: holdBar
                    width: 40
                    height: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: height / 2
                    color: "white"
                    border.color: "black"
                    border.width: 2
                    anchors.bottom: parent.top
                }

                Rectangle {
                    id: bitFlash

                    signal start()
                    onStart: flashStart.start()

                    property int duration: 600

                    width: 36
                    height: width
                    radius: height / 2
                    anchors.centerIn: parent
                    color: "transparent"
                    border.width: width / 2
                    border.color: "white"

                    visible: false

                    Image {
                        id: flashShine
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        source: "../assets/gfx/shine.png"

                        NumberAnimation {
                            target: flashShine
                            property: "rotation"
                            running: bitFlash.visible
                            loops: Animation.Infinite
                            from: 0
                            to: {
                                if (Math.floor(Math.random() * 2) < 1)
                                    return -360
                                else return 360
                            }
                            duration: 600
                        }
                    }

                    SequentialAnimation {
                        id: flashStart

                        alwaysRunToEnd: false

                        onStarted: {
                            flashTimer.start()
                            bitFlash.visible = true
                        } //Close onStarted.

                        NumberAnimation {
                            target: bitFlash
                            property: "scale"
                            duration: bitFlash.duration / 3
                            from: 0
                            to: 1
                        } //Close NumberAnimation.

                        NumberAnimation {
                            target: bitFlash
                            property: "border.width"
                            duration: bitFlash.duration / 3
                            from: bitFlash.width / 2
                            to: 0
                            easing.type: Easing.OutCubic
                        } //Close NumberAnimation.

                        NumberAnimation {
                            target: bitFlash
                            property: "scale"
                            duration: bitFlash.duration / 3
                            from: 1
                            to: 0
                            easing.amplitude: Easing.InBack
                        } //Close NumberAnimation.

                        onStopped: {
                            bitFlash.border.width = bitFlash.width / 2
                            bitFlash.visible = false
                        } //Close onStarted.

                    } //Close SequentialAnimation.

                } //Close Rectangle 'flashIcon'.

            }
        }
    }

    Item {
        id: intro7
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 6

        Text {
            id: intro7txtDS
            font.family: intro7txt.font.family
            font.pixelSize: intro7txt.font.pixelSize
            horizontalAlignment: intro7txt.horizontalAlignment
            anchors.centerIn: intro7txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro7txt.text
        }

        Text {
            id: intro7txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "COLORED Bits can be flipped at<br/>any time. This uses a POLY."
        }

        Item {
            id: errorBox3
            width: 60
            height: width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 10

            Image {
                id: bitGlow3
                width: 40
                height: width
                anchors.centerIn: parent
                source: "../assets/gfx/highlight.png"
                Timer {
                    running: true
                    repeat: true
                    interval: 60
                    onTriggered: bitGlow3.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                }
            }

            Item {
                id: flipImage2
                width: 40
                height: width

                anchors.centerIn: parent

                Image {
                    id: bitImage3
                    width: 32
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/dna_dr.png"

                    Image {
                        id: err1c
                        width: 40
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/error.png"
                    } //Close Image 'bitErrorSign'. (Complete)
                }

                Timer {
                    id: flashTimer2
                    running: false
                    interval: 1500
                    onTriggered: flipAnim3.start()
                }

                Timer {
                    id: flashTimer3
                    running: false
                    interval: 1500
                    onTriggered: flipAnim2.start()
                }

                SequentialAnimation {
                    id: flipAnim2
                    running: false

                    alwaysRunToEnd: false

                    onStarted: {
                        bitImage3.source = "../assets/gfx/dna_a.png"
                        err1c.visible = true
                    }
                    onStopped: {
                        bitImage3.source = "../assets/gfx/dna_a2.png"
                        err1c.visible = false
                        bitFlash2.border.color = "white"
                        bitFlash2.start()
                    }
                    NumberAnimation {
                        duration: 400
                    }
                    NumberAnimation {
                        target: holdBar2
                        property: "width"
                        from: 40
                        to: 0
                        duration: 800
                    }
                    NumberAnimation {
                        target: bitImage3
                        property: "rotation"
                        from: 0
                        to: 180
                        duration: 200
                    }

                }

                SequentialAnimation {
                    id: flipAnim3
                    running: false

                    alwaysRunToEnd: false

                    onStarted: {
                        bitImage3.source = "../assets/gfx/dna_a2.png"
                        err1c.visible = false
                    }
                    onStopped: {
                        bitImage3.source = "../assets/gfx/dna_a.png"
                        err1c.visible = true
                        bitFlash2.border.color = "red"
                        bitFlash2.start()
                    }
                    NumberAnimation {
                        duration: 400
                    }
                    NumberAnimation {
                        target: holdBar2
                        property: "width"
                        from: 40
                        to: 0
                        duration: 800
                    }
                    NumberAnimation {
                        target: bitImage3
                        property: "rotation"
                        from: 0
                        to: 180
                        duration: 200
                    }

                }

                Rectangle {
                    id: holdBar2
                    width: 0 //40
                    height: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: height / 2
                    color: "white"
                    border.color: "black"
                    border.width: 2
                    anchors.bottom: parent.top
                }

                Rectangle {
                    id: bitFlash2

                    signal start()
                    onStart: flashStart2.start()

                    property int duration: 600

                    width: 36
                    height: width
                    radius: height / 2
                    anchors.centerIn: parent
                    color: "transparent"
                    border.width: width / 2
                    border.color: "white"

                    visible: false

                    Image {
                        id: flashShine2
                        width: parent.width
                        height: parent.height
                        anchors.centerIn: parent
                        source: "../assets/gfx/shine.png"

                        NumberAnimation {
                            target: flashShine2
                            property: "rotation"
                            running: bitFlash2.visible
                            loops: Animation.Infinite
                            from: 0
                            to: {
                                if (Math.floor(Math.random() * 2) < 1)
                                    return -360
                                else return 360
                            }
                            duration: 600
                        }
                    }

                    SequentialAnimation {
                        id: flashStart2

                        alwaysRunToEnd: false

                        onStarted: {
                            if (err1c.visible)
                                flashTimer3.start()
                            else flashTimer2.start()
                            bitFlash2.visible = true
                        } //Close onStarted.

                        NumberAnimation {
                            target: bitFlash2
                            property: "scale"
                            duration: bitFlash2.duration / 3
                            from: 0
                            to: 1
                        } //Close NumberAnimation.

                        NumberAnimation {
                            target: bitFlash2
                            property: "border.width"
                            duration: bitFlash2.duration / 3
                            from: bitFlash2.width / 2
                            to: 0
                            easing.type: Easing.OutCubic
                        } //Close NumberAnimation.

                        NumberAnimation {
                            target: bitFlash2
                            property: "scale"
                            duration: bitFlash2.duration / 3
                            from: 1
                            to: 0
                            easing.amplitude: Easing.InBack
                        } //Close NumberAnimation.

                        onStopped: {
                            bitFlash2.border.width = bitFlash2.width / 2
                            bitFlash2.visible = false
                        } //Close onStarted.

                    } //Close SequentialAnimation.

                } //Close Rectangle 'flashIcon'.

            }
        }
    }

    Item {
        id: intro8
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 7

        Text {
            id: intro8txtDS
            font.family: intro8txt.font.family
            font.pixelSize: intro8txt.font.pixelSize
            horizontalAlignment: intro8txt.horizontalAlignment
            anchors.centerIn: intro8txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro8txt.text
        }

        Text {
            id: intro8txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Earn Polys by fixing WHITE Bits,<br/>and by SCORING Colored Bits."
        }

        Item {
            id: errorBox4
            width: tutPlat2.width
            height: 60

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 10

            NumberAnimation {
                id: errorFade4
                target: errorBox4
                property: "opacity"
                from: 0
                to: 1
                duration: 400
            }

            Item {
                id: polyCirc
                width: 40
                height: width
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width + 6
                    height: width
                    radius: width / 2
                    color: gameColors.iFaceDSCol
                    anchors.centerIn: parent
                }

                Rectangle {
                    anchors.fill: parent
                    radius: width / 2
                    color: gameColors.iFaceBGCol
                    border.color: gameColors.iFaceCol
                    border.width: 3
                }

                Image {
                    id: poly
                    width: 32
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/poly.png"
                    NumberAnimation {
                        target: poly
                        property: "rotation"
                        from: 0
                        to: 360
                        duration: 6000
                        running: intro8.visible
                        loops: Animation.Infinite
                    }
                }
                Rectangle {
                    width: 10
                    height: width
                    radius: height / 2
                    anchors.centerIn: parent
                    color: gameColors.iFaceCol
                    border.color: gameColors.iFaceBGCol
                    border.width: 2
                }

            }

            Item {
                id: equals
                width: 16
                height: 12
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 32
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width
                    height: 4
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    color: "black"
                }

                Rectangle {
                    width: parent.width
                    height: 4
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -2
                    color: "black"
                }

                Rectangle {
                    width: parent.width
                    height: 4
                    anchors.left: parent.left
                    anchors.top: parent.top
                    color: "white"
                }

                Rectangle {
                    width: parent.width
                    height: 4
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    color: "white"
                }
            }

            Item {
                id: plus
                width: 16
                height: width
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: parent.width
                    height: 4
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 2
                    color: "black"
                }

                Rectangle {
                    width: 4
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 2
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    color: "black"
                }

                Rectangle {
                    width: parent.width
                    height: 4
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                }

                Rectangle {
                    width: 4
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    color: "white"
                }
            }

            Item {
                id: whiteBit
                width: 40
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -8
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: bitGlow4
                    width: 40
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/highlight.png"
                    Timer {
                        running: true
                        repeat: true
                        interval: 60
                        onTriggered: bitGlow4.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                    }
                }

                Image {
                    id: bitImage4
                    width: 32
                    height: width

                    anchors.centerIn: parent

                    source: "../assets/gfx/dna_dr2.png"

                    SequentialAnimation {
                        id: errFade4
                        running: intro8.visible
                        loops: Animation.Infinite

                        property int duration: 1200

                        ParallelAnimation {
                            NumberAnimation {
                                target: err1_4
                                property: "opacity"
                                duration: errFade4.duration
                                from: 1
                                to: 0
                            }
                            NumberAnimation {
                                target: err2_4
                                property: "opacity"
                                duration: errFade4.duration
                                from: 0
                                to: 1
                            }
                        }
                        ParallelAnimation {
                            NumberAnimation {
                                target: err1_4
                                property: "opacity"
                                duration: errFade4.duration
                                from: 0
                                to: 1
                            }
                            NumberAnimation {
                                target: err2_4
                                property: "opacity"
                                duration: errFade4.duration
                                from: 1
                                to: 0
                            }
                        }
                    }

                    Image {
                        id: err1_4
                        width: 40
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/error.png"
                    } //Close Image 'bitErrorSign'. (Complete)

                    //The image that appears if there is an error. (Complete)
                    Image {
                        id: err2_4
                        width: 40
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/error2.png"
                    } //Close Image 'bitErrorSign'. (Complete)

                }
            }

            Item {
                id: littleBits
                width: 66
                height: 56

                anchors.right: parent.right
                anchors.rightMargin: 2
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    id: bitsBack
                    anchors.fill: parent
                    radius: 2
                    color: gameColors.iFaceBGCol
                    //                                        opacity: 1
                }

                Image {
                    width: littleBits.height / 2
                    height: width
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    source: "../assets/gfx/highlight.png"
                    Image {
                        width: parent.width - 4
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_a.png"
                    }
                }
                Image {
                    width: littleBits.height / 2
                    height: width
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    source: "../assets/gfx/highlight.png"
                    Image {
                        width: parent.width - 4
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_c.png"
                    }
                }
                Image {
                    width: littleBits.height / 2
                    height: width
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    source: "../assets/gfx/highlight.png"
                    Image {
                        width: parent.width - 4
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_g.png"
                    }
                }
                Image {
                    width: littleBits.height / 2
                    height: width
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    //                    anchors.bottomMargin: 2
                    source: "../assets/gfx/highlight.png"
                    Image {
                        width: parent.width - 4
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_t.png"
                    }
                }
            }

        }
    }

    Item {
        id: intro9
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 8

        Text {
            id: intro9txtDS
            font.family: intro9txt.font.family
            font.pixelSize: intro9txt.font.pixelSize
            horizontalAlignment: intro9txt.horizontalAlignment
            anchors.centerIn: intro9txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro9txt.text
        }

        Text {
            id: intro9txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Pressing the DROP button will<br/>SCORE the bottom row of Bits."
        }

        Item {
            id: rowHLBox
            width: 160
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: 40

            SequentialAnimation {
                id: rowsHLFade
                running: intro9.visible
                loops: Animation.Infinite

                property int duration: 800

                NumberAnimation {
                    target: rowHL
                    property: "opacity"
                    from: 0.2
                    to: 0.6
                    duration: rowsHLFade.duration / 2
                }

                NumberAnimation {
                    target: rowHL
                    property: "opacity"
                    from: 0.6
                    to: 0.2
                    duration: rowsHLFade.duration / 2
                }
            }

            Rectangle {
                id: rowGrad
                width: parent.width
                height: parent.anchors.topMargin
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent"}
                    GradientStop { position: 1.0; color: gameColors.iFaceCol}
                }
            }

            Rectangle {
                id: rowHL
                anchors.fill: parent
                radius: 6
                color: gameColors.iFaceBrightCol
            }

            Rectangle {
                id: rowHLBorder
                anchors.fill: parent
                radius: 6
                color: "transparent"
                border.color: "white" //gameColors.iFaceBrightCol
                border.width: 4
            }

            Text {
                id: rowHLTxtDS
                font.family: rowHLTxt.font.family
                font.pixelSize: rowHLTxt.font.pixelSize
                color: gameColors.iFaceDSCol
                anchors.centerIn: rowHLTxt
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                text: rowHLTxt.text
                style: rowHLTxt.style
                styleColor: color
            }

            Text {
                id: rowHLTxt
                font.family: gameFont.name
                font.pixelSize: 20
                color: gameColors.iFaceLightCol
                anchors.centerIn: parent
                text: "Score!"
                style: Text.Outline
                styleColor: gameColors.iFaceDSCol
            }

        }

        Rectangle {
            id: dropButtonDS
            width: dropButton.width * 1.5
            height: width
            radius: 8
            anchors.centerIn: dropButton
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenterOffset: 3
            color: gameColors.iFaceDSCol
        }

        Item {
            id: dropButton
            width: 60
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 30

            Rectangle {
                width: parent.width * 1.5
                height: width
                radius: 8
                anchors.centerIn: parent
                color: gameColors.iFaceBGCol
                border.color: gameColors.iFaceBrightCol
                border.width: 3

                Item {
                    width: parent.width - parent.border.width * 2
                    height: width
                    anchors.centerIn: parent
                    clip: true

                    Image {
                        id: starfield
                        anchors.centerIn: parent
                        source: "../assets/gfx/bgStars.png"
                    }
                }
            }

            Image {
                id: dropHalo
                width: dropImg.width * 1.25
                height: width
                anchors.centerIn: dropImg
                source: "../assets/gfx/dropHalo.png"

                NumberAnimation {
                    target: dropHalo
                    property: "rotation"
                    duration: 2000
                    from: 45
                    to: 0
                    loops: Animation.Infinite
                    running: intro9.visible
                } //Close NumberAnimation

                SequentialAnimation {
                    id: haloGlow

                    loops: Animation.Infinite
                    running: intro9.visible

                    property int duration: 2000

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

            }

            Image {
                id: dropImg
                anchors.fill: parent
                source: "../assets/gfx/drop.png"
            }
            Image {
                id: dropImg2
                anchors.fill: parent
                source: "../assets/gfx/drop2.png"

                SequentialAnimation {
                    id: dropSwitch

                    loops: Animation.Infinite
                    running: intro9.visible

                    NumberAnimation {
                        target: dropImg2
                        property: "opacity"
                        duration: 400
                        from: 0
                        to: 1
                    } //Close NumberAnimation.

                    NumberAnimation {
                        duration: 1000
                    }

                    NumberAnimation {
                        target: dropImg2
                        property: "opacity"
                        duration: 400
                        from: 1
                        to: 0
                    } //Close NumberAnimation.

                    NumberAnimation {
                        duration: 1000
                    }

                } //Close SequentialAnimation.
            }
        }

    }

    Item {
        id: intro10
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 9

        Text {
            id: intro10txtDS
            font.family: intro10txt.font.family
            font.pixelSize: intro10txt.font.pixelSize
            horizontalAlignment: intro10txt.horizontalAlignment
            anchors.centerIn: intro10txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro10txt.text
        }

        Text {
            id: intro10txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Colored Bits and VOID Bits can be<br/>selected by pressing them."
        }

        Item {
            id: bitBox
            width: tutPlat2.width
            height: 60

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 10

            Rectangle {
                anchors.fill: parent
                //                width: parent.width
                //                height: parent.height
                radius: 6
                //                anchors.centerIn: parent
                color: gameColors.iFaceBGCol
                border.color: gameColors.iFaceBrightCol
                border.width: 3

                Item {
                    width: parent.width - parent.border.width * 2
                    height: parent.height - parent.border.width * 2
                    anchors.centerIn: parent
                    clip: true

                    Image {
                        id: bitField
                        anchors.centerIn: parent
                        source: "../assets/gfx/bgStars.png"
                    }
                }
            }

            //The circle graphic that indicates if a bit is selected. (Complete)
            Item {
                id: bitSelectHL
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -80
                anchors.verticalCenter: parent.verticalCenter

                property string color: "white"

                property int interval: 1000

                width: 32
                height: 8

                Timer {
                    id: sel1
                    interval: bitSelectHL.interval
                    running: intro10.visible
                    onTriggered: {
                        bitSelectHL.anchors.horizontalCenterOffset = -40
                        sel2.start()
                    }
                }

                Timer {
                    id: sel2
                    interval: bitSelectHL.interval
                    running: false
                    onTriggered: {
                        bitSelectHL.anchors.horizontalCenterOffset = 0
                        sel3.start()
                    }
                }

                Timer {
                    id: sel3
                    interval: bitSelectHL.interval
                    running: false
                    onTriggered: {
                        bitSelectHL.anchors.horizontalCenterOffset = 40
                        sel4.start()
                    }
                }

                Timer {
                    id: sel4
                    interval: bitSelectHL.interval
                    running: false
                    onTriggered: {
                        bitSelectHL.anchors.horizontalCenterOffset = 80
                        sel5.start()
                    }
                }

                Timer {
                    id: sel5
                    interval: bitSelectHL.interval
                    running: false
                    onTriggered: {
                        bitSelectHL.anchors.horizontalCenterOffset = -80
                        sel1.start()
                    }
                }

                Rectangle {
                    width: 38
                    height: width
                    anchors.centerIn: parent
                    radius: height / 2
                    color: "transparent"
                    border.color: parent.color
                    border.width: 4
                } //Close Rectangle.

                Rectangle {
                    width: 44
                    height: parent.height + 4
                    anchors.centerIn: parent
                    radius: 4
                    color: parent.color
                } //Close Rectangle.

                NumberAnimation {
                    target: bitSelectHL
                    property: "rotation"
                    duration: 1000 * 6 // Math.random() * 9000 + 9000
                    from: 0
                    to: 180
                    loops: Animation.Infinite
                    running: intro10.visible
                } //Close NumberAnimation.

            } //Close Item.

            Row {
                id: bitRow

                anchors.centerIn: parent

                property int duration: 1200

                Item {
                    id: boxA
                    width: 40
                    height: width

                    property double offsetA: 0

                    Image {
                        id: glowA
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glowA.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bitA
                        width: 32
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: parent.offsetA
                        source: "../assets/gfx/dna_a.png"
                    }

                    SequentialAnimation {
                        id: bobA
                        running: intro10.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: boxA
                            property: "offsetA"
                            from: -2
                            to: 2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: boxA
                            property: "offsetA"
                            from: 2
                            to: -2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }
                }

                Item {
                    id: boxC
                    width: 40
                    height: width

                    property double offsetC: 0

                    Image {
                        id: glowC
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glowC.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bitC
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: parent.offsetC
                        source: "../assets/gfx/dna_c.png"
                    }

                    SequentialAnimation {
                        id: bobC
                        running: intro10.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: boxC
                            property: "offsetC"
                            from: -2
                            to: 2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: boxC
                            property: "offsetC"
                            from: 2
                            to: -2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }
                }

                Item {
                    id: boxG
                    width: 40
                    height: width

                    property double offsetG: 0

                    Image {
                        id: glowG
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glowG.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bitG
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: parent.offsetG
                        source: "../assets/gfx/dna_g.png"
                    }

                    SequentialAnimation {
                        id: bobG
                        running: intro10.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: boxG
                            property: "offsetG"
                            from: -2
                            to: 2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: boxG
                            property: "offsetG"
                            from: 2
                            to: -2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }
                }

                Item {
                    id: boxT
                    width: 40
                    height: width

                    property double offsetT: 0

                    Image {
                        id: glowT
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glowT.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bitT
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        anchors.verticalCenterOffset: parent.offsetT
                        source: "../assets/gfx/dna_t.png"
                    }

                    SequentialAnimation {
                        id: bobT
                        running: intro10.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: boxT
                            property: "offsetT"
                            from: -2
                            to: 2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: boxT
                            property: "offsetT"
                            from: 2
                            to: -2
                            duration: bitRow.duration + Math.floor(Math.random() * bitRow.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }
                }

                Item {
                    id: boxV
                    width: 40
                    height: width

                    Image {
                        id: glowV
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glowV.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bitV
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/voidbit.png"
                    }

                    NumberAnimation {
                        id: voidSpin
                        target: bitV
                        property: "rotation"
                        duration: Math.random() * 4000 + 8000 //Twelve seconds. (Complete)
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        running: intro10.visible
                    } //Close NumberAnimation 'bitShrink'. (Complete)
                }

            }

            Image {
                width: 40
                height: width
                anchors.centerIn: bitSelectHL
                source: "../assets/gfx/highlight.png"
            }
        }

    }

    Item {
        id: intro11
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 10

        Text {
            id: intro11txtDS
            font.family: intro11txt.font.family
            font.pixelSize: intro11txt.font.pixelSize
            horizontalAlignment: intro11txt.horizontalAlignment
            anchors.centerIn: intro11txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro11txt.text
        }

        Text {
            id: intro11txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "The SWAP button will switch two<br/>selected Bits. This also uses a POLY."
        }

        Rectangle {
            id: swapButtonDS
            width: swapButton.width * 1.5
            height: width
            radius: 8
            anchors.centerIn: swapButton
            anchors.horizontalCenterOffset: 3
            anchors.verticalCenterOffset: 3
            color: gameColors.iFaceDSCol
        }

        Item {
            id: swapButton
            width: 60
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 30

            Rectangle {
                width: parent.width * 1.5
                height: width
                radius: 8
                anchors.centerIn: parent
                color: gameColors.iFaceBGCol
                border.color: gameColors.iFaceBrightCol
                border.width: 3

                Item {
                    width: parent.width - parent.border.width * 2
                    height: width
                    anchors.centerIn: parent
                    clip: true

                    Image {
                        id: starfield2
                        anchors.centerIn: parent
                        source: "../assets/gfx/bgStars.png"
                    }
                }
            }

            Image {
                id: swapHalo
                width: swapImg.width * 1.25
                height: width
                anchors.centerIn: swapImg
                source: "../assets/gfx/dropHalo.png"

                NumberAnimation {
                    target: swapHalo
                    property: "rotation"
                    duration: 2000
                    from: 45
                    to: 0
                    loops: Animation.Infinite
                    running: intro11.visible
                } //Close NumberAnimation

                SequentialAnimation {
                    id: swapGlow

                    loops: Animation.Infinite
                    running: intro11.visible

                    property int duration: 2000

                    NumberAnimation {
                        target: dropHalo
                        property: "opacity"
                        duration: swapGlow.duration / 2
                        from: 1
                        to: 0.4
                    } //Close NumberAnimation.

                    NumberAnimation {
                        target: dropHalo
                        property: "opacity"
                        duration: swapGlow.duration / 2
                        from: 0.4
                        to: 1
                    } //Close NumberAnimation.

                } //Close SequentialAnimation.

            }

            Image {
                id: swapImg
                anchors.fill: parent
                source: "../assets/gfx/swap.png"
            }
            Image {
                id: swapImg2
                anchors.fill: parent
                source: "../assets/gfx/swap2.png"

                SequentialAnimation {
                    id: swapSwitch

                    loops: Animation.Infinite
                    running: intro11.visible

                    NumberAnimation {
                        target: swapImg2
                        property: "opacity"
                        duration: 400
                        from: 0
                        to: 1
                    } //Close NumberAnimation.

                    NumberAnimation {
                        duration: 1000
                    }

                    NumberAnimation {
                        target: swapImg2
                        property: "opacity"
                        duration: 400
                        from: 1
                        to: 0
                    } //Close NumberAnimation.

                    NumberAnimation {
                        duration: 1000
                    }

                } //Close SequentialAnimation.
            }
        }

        Item {
            id: swapPlatBox
            width: 150
            height: 72

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: 10

            Rectangle {
                id: swapPlatDS
                width: swapPlat.width
                height: swapPlat.height
                radius: swapPlat.radius
                anchors.centerIn: swapPlat
                anchors.horizontalCenterOffset: 3
                anchors.verticalCenterOffset: 3
                color: gameColors.iFaceDSCol
            }

            Rectangle {
                id: swapPlat
                anchors.fill: parent
                radius: 6
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceCol}
                    GradientStop { position: 1.0; color: gameColors.iFaceBGCol}
                }
                border.color: gameColors.iFaceBrightCol
                border.width: 3

                property int duration: 1200

                property string swapSrc1: "../assets/gfx/dna_c.png"
                property string swapSrc2: "../assets/gfx/dna_g.png"

                property int popTime: swapTime
                property int popSpacing: 1000

                Timer {
                    id: popSwap1
                    running: false
                    interval: swapPlat.popSpacing + swapPlat.popTime / 2
                    onTriggered: {
                        swapBit1.source = "../assets/gfx/dna_t.png"
                        swapBit2.source = "../assets/gfx/dna_c.png"
                    }
                }

                SequentialAnimation {
                    id: bitPops1
                    running: intro11.visible
                    alwaysRunToEnd: false

                    onStarted: {
                        swapBit1.source = "../assets/gfx/dna_c.png"
                        swapBit2.source = "../assets/gfx/dna_t.png"
                        popSwap1.start()
                    }

                    onStopped: bitPops2.start()

                    NumberAnimation {
                        duration: swapPlat.popSpacing
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: swapBit1
                            property: "scale"
                            from: 1
                            to: 0
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.InCubic
                        }
                        NumberAnimation {
                            target: swapBit2
                            property: "scale"
                            from: 1
                            to: 0
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.InCubic

                        }
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: swapBit1
                            property: "scale"
                            from: 0
                            to: 1
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.OutElastic
                        }
                        NumberAnimation {
                            target: swapBit2
                            property: "scale"
                            from: 0
                            to: 1
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.OutElastic
                        }
                    }
                }

                Timer {
                    id: popSwap2
                    running: false
                    interval: swapPlat.popSpacing + swapPlat.popTime / 2
                    onTriggered: {
                        swapBit1.source = "../assets/gfx/dna_c.png"
                        swapBit2.source = "../assets/gfx/dna_t.png"
                    }
                }

                SequentialAnimation {
                    id: bitPops2
                    running: false
                    alwaysRunToEnd: false

                    onStarted: {
                        //                            swapBit1.source = "../assets/gfx/dna_t.png"
                        //                            swapBit2.source = "../assets/gfx/dna_c.png"
                        popSwap2.start()
                    }

                    onStopped: bitPops1.start()

                    NumberAnimation {
                        duration: swapPlat.popSpacing
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: swapBit1
                            property: "scale"
                            from: 1
                            to: 0
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.InCubic
                        }
                        NumberAnimation {
                            target: swapBit2
                            property: "scale"
                            from: 1
                            to: 0
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.InCubic

                        }
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: swapBit1
                            property: "scale"
                            from: 0
                            to: 1
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.OutElastic
                        }
                        NumberAnimation {
                            target: swapBit2
                            property: "scale"
                            from: 0
                            to: 1
                            duration: swapPlat.popTime / 2
                            easing.type: Easing.OutElastic
                        }
                    }
                }

                Rectangle {
                    id: starfieldBox3
                    width: parent.width - parent.border.width * 2
                    height: parent.height - parent.border.width * 2
                    radius: parent.radius
                    anchors.centerIn: parent
                    color: gameColors.iFaceBGCol
                    clip: true

                    Item {
                        width: parent.width - parent.border.width * 2
                        height: width
                        anchors.centerIn: parent
                        clip: true

                        Image {
                            id: starfield3
                            anchors.centerIn: parent
                            source: "../assets/gfx/bgStars.png"
                        }
                    }
                }

                Item {
                    id: swapSel1
                    anchors.centerIn: swap1

                    property string color: "white"

                    width: 32
                    height: 8

                    Rectangle {
                        width: 38
                        height: width
                        anchors.centerIn: parent
                        radius: height / 2
                        color: "transparent"
                        border.color: parent.color
                        border.width: 4
                    } //Close Rectangle.

                    Rectangle {
                        width: 44
                        height: parent.height + 4
                        anchors.centerIn: parent
                        radius: 4
                        color: parent.color
                    } //Close Rectangle.

                    NumberAnimation {
                        target: swapSel1
                        property: "rotation"
                        duration: 1000 * 6 // Math.random() * 9000 + 9000
                        from: 0
                        to: 180
                        loops: Animation.Infinite
                        running: intro11.visible
                    } //Close NumberAnimation.

                }

                Item {
                    id: swap1
                    width: 40
                    height: width

                    property double offset1: 0

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -30
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: swapGlow1
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: swapGlow1.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: swapBit1
                        width: 32
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: parent.offset1
                        source: swapPlat.swapSrc1
                    }

                    SequentialAnimation {
                        id: swapBob1
                        running: intro11.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: swap1
                            property: "offset1"
                            from: -2
                            to: 2
                            duration: swapPlat.duration + Math.floor(Math.random() * swapPlat.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: swap1
                            property: "offset1"
                            from: 2
                            to: -2
                            duration: swapPlat.duration + Math.floor(Math.random() * swapPlat.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }



                }

                Item {
                    id: swapSel2
                    anchors.centerIn: swap2

                    property string color: "white"

                    width: 32
                    height: 8

                    Rectangle {
                        width: 38
                        height: width
                        anchors.centerIn: parent
                        radius: height / 2
                        color: "transparent"
                        border.color: parent.color
                        border.width: 4
                    } //Close Rectangle.

                    Rectangle {
                        width: 44
                        height: parent.height + 4
                        anchors.centerIn: parent
                        radius: 4
                        color: parent.color
                    } //Close Rectangle.

                    NumberAnimation {
                        target: swapSel2
                        property: "rotation"
                        duration: 1000 * 6 // Math.random() * 9000 + 9000
                        from: 0
                        to: 180
                        loops: Animation.Infinite
                        running: intro11.visible
                    } //Close NumberAnimation.

                }

                Item {
                    id: swap2
                    width: 40
                    height: width

                    property double offset2: 0

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 30
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: swapGlow2
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: swapGlow2.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: swapBit2
                        width: 32
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: parent.offset2
                        source: swapPlat.swapSrc2
                    }

                    SequentialAnimation {
                        id: swapBob2
                        running: intro11.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: swap2
                            property: "offset2"
                            from: -2
                            to: 2
                            duration: swapPlat.duration + Math.floor(Math.random() * swapPlat.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: swap2
                            property: "offset2"
                            from: 2
                            to: -2
                            duration: swapPlat.duration + Math.floor(Math.random() * swapPlat.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }
                }

            }
        }

    }

    Item {
        id: intro12
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 11

        Text {
            id: intro12txtDS
            font.family: intro12txt.font.family
            font.pixelSize: intro12txt.font.pixelSize
            horizontalAlignment: intro12txt.horizontalAlignment
            anchors.centerIn: intro12txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro12txt.text
        }

        Text {
            id: intro12txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Colored Bits will fill in VOID Bits.<br/>This still uses a POLY."
        }

        Item {
            id: swapPlatBox2
            width: 150
            height: 72

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: 10

            Rectangle {
                id: swapPlat2DS
                width: swapPlat2.width
                height: swapPlat2.height
                radius: swapPlat2.radius
                anchors.centerIn: swapPlat2
                anchors.horizontalCenterOffset: 3
                anchors.verticalCenterOffset: 3
                color: gameColors.iFaceDSCol
            }

            Rectangle {
                id: swapPlat2
                anchors.fill: parent
                radius: 6
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceCol}
                    GradientStop { position: 1.0; color: gameColors.iFaceBGCol}
                }
                border.color: gameColors.iFaceBrightCol
                border.width: 3

                property int duration: 1200

                property string swapSrc1: "../assets/gfx/dna_g.png"
                property string swapSrc2: "../assets/gfx/voidBit.png"

                property int popTime: swapTime
                property int popSpacing: 1000

                Timer {
                    id: popSwap1b
                    running: false
                    interval: swapPlat2.popSpacing + swapPlat2.popTime / 2
                    onTriggered: {
                        swapSel1b.visible = false
                        swapSel2b.visible = false
                        swap1b.visible = false
                        swapBit1b.source = "../assets/gfx/voidbit.png"
                        swapBit2b.source = "../assets/gfx/dna_g.png"
                        swapBob1b.stop()
                        swapBob2b.start()
                        swapSpin.stop()
                        swapBit2b.rotation = 0
                    }
                }

                Timer {
                    id: popSwap2b
                    running: false
                    interval: swapPlat2.popSpacing + swapPlat2.popTime
                    onTriggered: swapFlash.start()
                }

                SequentialAnimation {
                    id: bitPops1b
                    running: intro12.visible
                    alwaysRunToEnd: false

                    onStarted: {
                        swapSel1b.visible = true
                        swapSel2b.visible = true
                        swap1b.visible = true
                        swapBit1b.source = "../assets/gfx/dna_g.png"
                        swapBit2b.source = "../assets/gfx/voidbit.png"
                        popSwap1b.start()
                        popSwap2b.start()
                        swapBob1b.start()
                        swapBob2b.stop()
                        swapBit2b.rotation = 0
                        swapSpin.start()
                    }

                    onStopped: {
                        popSwap1b.start()
                        bitPops1b.start()
                    }

                    NumberAnimation {
                        duration: swapPlat2.popSpacing
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: swapBit1b
                            property: "scale"
                            from: 1
                            to: 0
                            duration: swapPlat2.popTime / 2
                            easing.type: Easing.InCubic
                        }
                        NumberAnimation {
                            target: swapBit2b
                            property: "scale"
                            from: 1
                            to: 0
                            duration: swapPlat2.popTime / 2
                            easing.type: Easing.InCubic

                        }
                    }
                    ParallelAnimation {
                        NumberAnimation {
                            target: swapBit1b
                            property: "scale"
                            from: 0
                            to: 1
                            duration: swapPlat2.popTime / 2
                            easing.type: Easing.OutElastic
                        }
                        NumberAnimation {
                            target: swapBit2b
                            property: "scale"
                            from: 0
                            to: 1
                            duration: swapPlat2.popTime / 2
                            easing.type: Easing.OutElastic
                        }
                    }
                    NumberAnimation {
                        duration: swapPlat2.popSpacing * 2
                    }
                }

                Rectangle {
                    id: starfieldBox4
                    width: parent.width - parent.border.width * 2
                    height: parent.height - parent.border.width * 2
                    radius: parent.radius
                    anchors.centerIn: parent
                    color: gameColors.iFaceBGCol
                    clip: true

                    Item {
                        width: parent.width - parent.border.width * 2
                        height: width
                        anchors.centerIn: parent
                        clip: true

                        Image {
                            id: starfield4
                            anchors.centerIn: parent
                            source: "../assets/gfx/bgStars.png"
                        }
                    }
                }

                Item {
                    id: swapSel1b
                    anchors.centerIn: swap1b

                    property string color: "white"

                    width: 32
                    height: 8

                    Rectangle {
                        width: 38
                        height: width
                        anchors.centerIn: parent
                        radius: height / 2
                        color: "transparent"
                        border.color: parent.color
                        border.width: 4
                    } //Close Rectangle.

                    Rectangle {
                        width: 44
                        height: parent.height + 4
                        anchors.centerIn: parent
                        radius: 4
                        color: parent.color
                    } //Close Rectangle.

                    NumberAnimation {
                        target: swapSel1b
                        property: "rotation"
                        duration: 1000 * 6 // Math.random() * 9000 + 9000
                        from: 0
                        to: 180
                        loops: Animation.Infinite
                        running: intro12.visible
                    } //Close NumberAnimation.

                }

                Item {
                    id: swap1b
                    width: 40
                    height: width

                    property double offset1: 0

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -30
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: swapGlow1b
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: swapGlow1b.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: swapBit1b
                        width: 32
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: parent.offset1
                        source: swapPlat2.swapSrc1
                    }

                    SequentialAnimation {
                        id: swapBob1b
                        running: intro12.visible
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: swap1b
                            property: "offset1"
                            from: -2
                            to: 2
                            duration: swapPlat2.duration + Math.floor(Math.random() * swapPlat2.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: swap1b
                            property: "offset1"
                            from: 2
                            to: -2
                            duration: swapPlat2.duration + Math.floor(Math.random() * swapPlat2.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }

                }

                Item {
                    id: swapSel2b
                    anchors.centerIn: swap2b

                    property string color: "white"

                    width: 32
                    height: 8

                    Rectangle {
                        width: 38
                        height: width
                        anchors.centerIn: parent
                        radius: height / 2
                        color: "transparent"
                        border.color: parent.color
                        border.width: 4
                    } //Close Rectangle.

                    Rectangle {
                        width: 44
                        height: parent.height + 4
                        anchors.centerIn: parent
                        radius: 4
                        color: parent.color
                    } //Close Rectangle.

                    NumberAnimation {
                        target: swapSel2b
                        property: "rotation"
                        duration: 1000 * 6 // Math.random() * 9000 + 9000
                        from: 0
                        to: 180
                        loops: Animation.Infinite
                        running: intro12.visible
                    } //Close NumberAnimation.

                }

                Item {
                    id: swap2b
                    width: 40
                    height: width

                    property double offset2: 0

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 30
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: swapGlow2b
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: swapGlow2b.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: swapBit2b
                        width: 32
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: parent.offset2
                        source: swapPlat2.swapSrc2
                    }

                    Rectangle {
                        id: swapFlash

                        signal start()
                        onStart: swapFlashAnim.start()

                        property int duration: flashTime

                        width: 36
                        height: width
                        radius: height / 2
                        anchors.centerIn: parent
                        color: "transparent"
                        border.width: width / 2
                        border.color: "white"

                        visible: false

                        Image {
                            id: swapShine
                            width: parent.width
                            height: parent.height
                            anchors.centerIn: parent
                            source: "../assets/gfx/shine.png"

                            NumberAnimation {
                                target: swapShine
                                property: "rotation"
                                running: swapFlash.visible
                                loops: Animation.Infinite
                                from: 0
                                to: {
                                    if (Math.floor(Math.random() * 2) < 1)
                                        return -360
                                    else return 360
                                }
                                duration: 600
                            }
                        }

                        SequentialAnimation {
                            id: swapFlashAnim
                            alwaysRunToEnd: false

                            onStarted: {
                                swapFlash.visible = true
                            } //Close onStarted.

                            NumberAnimation {
                                target: swapFlash
                                property: "scale"
                                duration: swapFlash.duration / 3
                                from: 0
                                to: 1
                            } //Close NumberAnimation.

                            NumberAnimation {
                                target: swapFlash
                                property: "border.width"
                                duration: swapFlash.duration / 3
                                from: swapFlash.width / 2
                                to: 0
                                easing.type: Easing.OutCubic
                            } //Close NumberAnimation.

                            NumberAnimation {
                                target: swapFlash
                                property: "scale"
                                duration: swapFlash.duration / 3
                                from: 1
                                to: 0
                                easing.amplitude: Easing.InBack
                            } //Close NumberAnimation.

                            onStopped: {
                                swapFlash.border.width = swapFlash.width / 2
                                swapFlash.visible = false
                            } //Close onStarted.

                        } //Close SequentialAnimation.

                    } //Close Rectangle 'flashIcon'.

                    SequentialAnimation {
                        id: swapBob2b
                        running: false
                        loops: Animation.Infinite

                        NumberAnimation {
                            target: swap2b
                            property: "offset2"
                            from: -2
                            to: 2
                            duration: swapPlat2.duration + Math.floor(Math.random() * swapPlat2.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: swap2b
                            property: "offset2"
                            from: 2
                            to: -2
                            duration: swapPlat2.duration + Math.floor(Math.random() * swapPlat2.duration) / 2
                            easing.type: Easing.InOutSine
                        }
                    }

                    NumberAnimation {
                        id: swapSpin
                        target: swapBit2b
                        property: "rotation"
                        duration: Math.random() * 4000 + 8000 //Twelve seconds. (Complete)
                        from: 0
                        to: -360
                        loops: Animation.Infinite
                        running: false
                    } //Close NumberAnimation 'bitShrink'. (Complete)
                }

            }
        }

    }

    Item {
        id: intro13
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 12

        Text {
            id: intro13txtDS
            font.family: intro13txt.font.family
            font.pixelSize: intro13txt.font.pixelSize
            horizontalAlignment: intro13txt.horizontalAlignment
            anchors.centerIn: intro13txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro13txt.text
        }

        Text {
            id: intro13txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Fix ERRORS and fill VOID Bits<br/>to form Complete Rows."
        }

        Item {
            id: rowBox
            width: tutPlat2.width
            height: tutPlat2.height

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 10

            Rectangle {
                anchors.fill: parent
                radius: 6
                color: gameColors.iFaceBGCol
                border.color: gameColors.iFaceBrightCol
                border.width: 3

                Item {
                    width: parent.width - parent.border.width * 2
                    height: parent.height - parent.border.width * 2
                    anchors.centerIn: parent
                    clip: true

                    Image {
                        id: bitField2
                        anchors.centerIn: parent
                        source: "../assets/gfx/bgStars.png"
                        NumberAnimation {
                            target: bitField2
                            property: "rotation"
                            duration: 1000 * 180 //Three minutes.
                            from: 0
                            to: 360
                            loops: Animation.Infinite
                            running: intro13.visible
                        } //Close Timer 'starSpin'. (Complete)
                    }
                }
            }

            Rectangle {
                id: horiConn
                width: 120
                height: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30 - height / 2
                color: "black"

                Rectangle {
                    id: connDot1
                    width: parent.height + 2
                    height: width// + 2
                    radius: width / 2
                    x: parent.width / 2
                    y: -2
                    color: "white"
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: -40
                    Image {
                        width: parent.width * 2
                        height: parent.height * 2
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }
                Rectangle {
                    id: connDot2
                    width: parent.height + 2
                    height: width// + 2
                    radius: width / 2
                    x: parent.width / 2
                    y: -2
                    color: "white"
                    anchors.centerIn: parent
                    Image {
                        width: parent.width * 2
                        height: parent.height * 2
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }
                Rectangle {
                    id: connDot3
                    width: parent.height + 2
                    height: width// + 2
                    radius: width / 2
                    x: parent.width / 2
                    y: -2
                    color: "white"
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: 40
                    Image {
                        width: parent.width * 2
                        height: parent.height * 2
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }

            }

            Row {
                id: exRow

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10

                property int duration: 1200

                Item {
                    id: bitBox1
                    width: 40
                    height: width

                    Image {
                        id: glow1
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glow1.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bit1
                        width: 32
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../assets/gfx/dna_dr.png"
                    }
                }

                Item {
                    id: bitBox2
                    width: 40
                    height: width

                    Image {
                        id: bit2
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_c.png"
                    }
                }

                Item {
                    id: bitBox3
                    width: 40
                    height: width

                    Image {
                        id: bit3
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_a2.png"
                    }
                }

                Item {
                    id: bitBox4
                    width: 40
                    height: width

                    Image {
                        id: glow4
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glow4.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bit4
                        width: 32
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_dr2.png"
                    }
                }

            }

        }

    }

    Item {
        id: intro14
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 13

        Text {
            id: intro14txtDS
            font.family: intro14txt.font.family
            font.pixelSize: intro14txt.font.pixelSize
            horizontalAlignment: intro14txt.horizontalAlignment
            anchors.centerIn: intro14txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro14txt.text
        }

        Text {
            id: intro14txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Some Bits form special pairs.<br/>These will earn extra points!"
        }

        Rectangle {
            id: starBack
            width: tutPlat2.width
            height: tutPlat2.height
            radius: 6
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 10
            color: gameColors.iFaceBGCol
            border.color: gameColors.iFaceBrightCol
            border.width: 3

            Item {
                width: parent.width - parent.border.width * 2
                height: parent.height - parent.border.width * 2
                anchors.centerIn: parent
                clip: true

                Image {
                    id: bitField2b
                    anchors.centerIn: parent
                    source: "../assets/gfx/bgStars.png"
                    //The animation of the rotation of the stars. (Complete)
                    NumberAnimation {
                        target: bitField2b
                        property: "rotation"
                        duration: 1000 * 180 //Three minutes.
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        running: intro14.visible
                    } //Close Timer 'starSpin'. (Complete)
                }

                Rectangle {
                    id: vertConn1a
                    width: 8
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -60
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 70

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }

                    Rectangle {
                        width: 4
                        height: parent.height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        gradient: Gradient {
                            GradientStop { position: 0.5; color: "white"}
                            GradientStop { position: 1.0; color: "transparent"}
                        }
                    }
                }

                Rectangle {
                    id: vertConn1b
                    width: 8
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -60
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }

                    Rectangle {
                        width: 4
                        height: parent.height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        gradient: Gradient {
                            GradientStop { position: 0.5; color: "white"}
                            GradientStop { position: 1.0; color: "transparent"}
                        }
                    }
                }

                Rectangle {
                    id: vertConn1c
                    width: 8
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: -60
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -10

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }

                    Rectangle {
                        width: 4
                        height: parent.height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        gradient: Gradient {
                            GradientStop { position: 0.5; color: "white"}
                            GradientStop { position: 1.0; color: "transparent"}
                        }
                    }
                }

                Rectangle {
                    id: vertConn2a
                    width: 8
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 60
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 70

                    rotation: 180

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }

                    Rectangle {
                        width: 4
                        height: parent.height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        gradient: Gradient {
                            GradientStop { position: 0.5; color: "white"}
                            GradientStop { position: 1.0; color: "transparent"}
                        }
                    }
                }

                Rectangle {
                    id: vertConn2b
                    width: 8
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 60
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30

                    rotation: 180

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }

                    Rectangle {
                        width: 4
                        height: parent.height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        gradient: Gradient {
                            GradientStop { position: 0.5; color: "white"}
                            GradientStop { position: 1.0; color: "transparent"}
                        }
                    }
                }

                Rectangle {
                    id: vertConn2c
                    width: 8
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 60
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -10

                    rotation: 180

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white"}
                        GradientStop { position: 1.0; color: "transparent"}
                    }

                    Rectangle {
                        width: 4
                        height: parent.height
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        gradient: Gradient {
                            GradientStop { position: 0.5; color: "white"}
                            GradientStop { position: 1.0; color: "transparent"}
                        }
                    }
                }

                Item {
                    id: rowBox2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom

                    Rectangle {
                        id: horiConn2
                        width: 120
                        height: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 30 - height / 2 - starBack.border.width
                        color: "white"

                        Rectangle {
                            id: connDot1b
                            width: parent.height + 2
                            height: width// + 2
                            radius: width / 2
                            x: parent.width / 2
                            y: -2
                            color: "white"
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -40
                            Image {
                                width: parent.width * 2
                                height: parent.height * 2
                                anchors.centerIn: parent
                                source: "../assets/gfx/highlight.png"
                            }
                        }
                        Rectangle {
                            id: connDot2b
                            width: parent.height + 2
                            height: width// + 2
                            radius: width / 2
                            x: parent.width / 2
                            y: -2
                            color: "white"
                            anchors.centerIn: parent
                            Image {
                                width: parent.width * 2
                                height: parent.height * 2
                                anchors.centerIn: parent
                                source: "../assets/gfx/highlight.png"
                            }
                        }
                        Rectangle {
                            id: connDot3b
                            width: parent.height + 2
                            height: width// + 2
                            radius: width / 2
                            x: parent.width / 2
                            y: -2
                            color: "white"
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: 40
                            Image {
                                width: parent.width * 2
                                height: parent.height * 2
                                anchors.centerIn: parent
                                source: "../assets/gfx/highlight.png"
                            }
                        }

                    }

                    Row {
                        id: exRow2

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10 - starBack.border.width

                        property int duration: 1200

                        Item {
                            id: bitBox1b
                            width: 40
                            height: width

                            Image {
                                id: glow1b
                                anchors.fill: parent
                                source: "../assets/gfx/highlight.png"
                                Timer {
                                    running: true
                                    repeat: true
                                    interval: 60
                                    onTriggered: glow1b.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                                }
                            }

                            Image {
                                id: bit1b
                                width: 32
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                source: "../assets/gfx/dna_dr.png"
                            }
                        }

                        Item {
                            id: bitBox2b
                            width: 40
                            height: width

                            Image {
                                id: bit2b
                                width: 32
                                height: width
                                anchors.centerIn: parent
                                source: "../assets/gfx/dna_g.png"
                            }
                        }

                        Item {
                            id: bitBox3b
                            width: 40
                            height: width

                            Image {
                                id: bit3b
                                width: 32
                                height: width
                                anchors.centerIn: parent
                                source: "../assets/gfx/dna_c2.png"
                            }
                        }

                        Item {
                            id: bitBox4b
                            width: 40
                            height: width

                            Image {
                                id: glow4b
                                anchors.fill: parent
                                source: "../assets/gfx/highlight.png"
                                Timer {
                                    running: true
                                    repeat: true
                                    interval: 60
                                    onTriggered: glow4b.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                                }
                            }

                            Image {
                                id: bit4b
                                width: 32
                                height: width
                                anchors.centerIn: parent
                                source: "../assets/gfx/dna_dr2.png"
                            }
                        }

                    }

                }

                Item {
                    id: rowBox2b
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 40

                    Rectangle {
                        id: horiConn2b
                        width: 120
                        height: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 30 - height / 2
                        color: "white"

                        Rectangle {
                            id: connDot1c
                            width: parent.height + 2
                            height: width// + 2
                            radius: width / 2
                            x: parent.width / 2
                            y: -2
                            color: "white"
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -40
                            Image {
                                width: parent.width * 2
                                height: parent.height * 2
                                anchors.centerIn: parent
                                source: "../assets/gfx/highlight.png"
                            }
                        }
                        Rectangle {
                            id: connDot2c
                            width: parent.height + 2
                            height: width// + 2
                            radius: width / 2
                            x: parent.width / 2
                            y: -2
                            color: "white"
                            anchors.centerIn: parent
                            Image {
                                width: parent.width * 2
                                height: parent.height * 2
                                anchors.centerIn: parent
                                source: "../assets/gfx/highlight.png"
                            }
                        }
                        Rectangle {
                            id: connDot3c
                            width: parent.height + 2
                            height: width// + 2
                            radius: width / 2
                            x: parent.width / 2
                            y: -2
                            color: "white"
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: 40
                            Image {
                                width: parent.width * 2
                                height: parent.height * 2
                                anchors.centerIn: parent
                                source: "../assets/gfx/highlight.png"
                            }
                        }

                    }

                    Row {
                        id: exRow2b

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10

                        property int duration: 1200

                        Item {
                            id: bitBox1c
                            width: 40
                            height: width

                            Image {
                                id: glow1c
                                anchors.fill: parent
                                source: "../assets/gfx/highlight.png"
                                Timer {
                                    running: true
                                    repeat: true
                                    interval: 60
                                    onTriggered: glow1c.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                                }
                            }

                            Image {
                                id: bit1c
                                width: 32
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                source: "../assets/gfx/dna_dr.png"
                            }
                        }

                        Item {
                            id: bitBox2c
                            width: 40
                            height: width

                            Image {
                                id: bit2c
                                width: 32
                                height: width
                                anchors.centerIn: parent
                                source: "../assets/gfx/dna_a.png"
                            }
                        }

                        Item {
                            id: bitBox3c
                            width: 40
                            height: width

                            Image {
                                id: bit3c
                                width: 32
                                height: width
                                anchors.centerIn: parent
                                source: "../assets/gfx/dna_t2.png"
                            }
                        }

                        Item {
                            id: bitBox4c
                            width: 40
                            height: width

                            Image {
                                id: glow4c
                                anchors.fill: parent
                                source: "../assets/gfx/highlight.png"
                                Timer {
                                    running: true
                                    repeat: true
                                    interval: 60
                                    onTriggered: glow4c.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                                }
                            }

                            Image {
                                id: bit4c
                                width: 32
                                height: width
                                anchors.centerIn: parent
                                source: "../assets/gfx/dna_dr2.png"
                            }
                        }

                    }

                }

            }
        }


    }

    Item {
        id: intro15
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 14

        Text {
            id: intro15txtDS
            font.family: intro15txt.font.family
            font.pixelSize: intro15txt.font.pixelSize
            horizontalAlignment: intro15txt.horizontalAlignment
            anchors.centerIn: intro15txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro15txt.text
        }

        Text {
            id: intro15txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "This number shows how dangerous<br/>the environment is to the DNA."
        }

        Item {
            id: dmgBox

            width: 60
            height: width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 30

            property string color: "limegreen"

            Image {
                width: dmgIcon.width + 30
                height: dmgIcon.height + 30
                anchors.centerIn: dmgIcon
                source: "../assets/gfx/highlight.png"
            }

            Rectangle {
                id: dmgIcon

                anchors.fill: parent
                radius: height / 2
                color: parent.color

                border.color: gameColors.iFaceDSCol
                border.width: 6

                Rectangle {
                    width: dmgNum.implicitWidth + 16
                    height: dmgNum.implicitHeight + 10
                    radius: 12
                    color: parent.color
                    border.color: gameColors.iFaceDSCol
                    border.width: 4
                    anchors.centerIn: dmgNum
                    anchors.horizontalCenterOffset: -1
                    Image {
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }

                Text {
                    id: dmgNum
                    font.family: gameFont.name
                    font.pixelSize: 32

                    color: "black" //gameColors.iFaceBrightCol
                    //                    style: Text.Outline
                    //                        style: Text.Outline
                    styleColor: "white"

                    text: Math.floor(envDmg) + "%"

                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: 1

                } //Close Text 'swapText'. (Complete)

            }
        }

    }

    Item {
        id: intro16
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 15

        Text {
            id: intro16txtDS
            font.family: intro16txt.font.family
            font.pixelSize: intro16txt.font.pixelSize
            horizontalAlignment: intro16txt.horizontalAlignment
            anchors.centerIn: intro16txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro16txt.text
        }

        Text {
            id: intro16txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "Every time a ROW is scored, each<br/>Bit has a chance to randomly FLIP."
        }

        Item {
            id: dmgBox2

            width: 60
            height: width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 30

            property string color: "yellow"

            Image {
                width: dmgIcon2.width + 50
                height: dmgIcon2.height + 50
                anchors.centerIn: dmgIcon2
                source: "../assets/gfx/highlight.png"
            }

            Rectangle {
                id: dmgIcon2

                anchors.fill: parent
                radius: height / 2
                color: parent.color

                border.color: gameColors.iFaceDSCol
                border.width: 6

                Rectangle {
                    width: dmgNum2.implicitWidth + 16
                    height: dmgNum2.implicitHeight + 10
                    radius: 12
                    color: parent.color
                    border.color: gameColors.iFaceDSCol
                    border.width: 4
                    anchors.centerIn: dmgNum2
                    anchors.horizontalCenterOffset: -1
                    Image {
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }

                Text {
                    id: dmgNum2
                    font.family: gameFont.name
                    font.pixelSize: 32

                    color: "black" //gameColors.iFaceBrightCol
                    //                    style: Text.Outline
                    //                        style: Text.Outline
                    styleColor: "white"

                    text: "16%"

                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: 1

                } //Close Text 'swapText'. (Complete)

            }
        }

    }

    Item {
        id: intro17
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 16

        Text {
            id: intro17txtDS
            font.family: intro17txt.font.family
            font.pixelSize: intro17txt.font.pixelSize
            horizontalAlignment: intro17txt.horizontalAlignment
            anchors.centerIn: intro17txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro17txt.text
        }

        Text {
            id: intro17txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "This can give any Bit an ERROR.<br/>BUT it will sometimes fix errors!"
        }

        Item {
            id: dmgBox2b

            width: 60
            height: width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top
            anchors.bottomMargin: 30

            property string color: "red"

            Image {
                width: dmgIcon2b.width + 70
                height: dmgIcon2b.height + 70
                anchors.centerIn: dmgIcon2b
                source: "../assets/gfx/highlight.png"
            }

            Rectangle {
                id: dmgIcon2b

                anchors.fill: parent
                radius: height / 2
                color: parent.color

                border.color: gameColors.iFaceDSCol
                border.width: 6

                Rectangle {
                    width: dmgNum2b.implicitWidth + 16
                    height: dmgNum2b.implicitHeight + 10
                    radius: 12
                    color: parent.color
                    border.color: gameColors.iFaceDSCol
                    border.width: 4
                    anchors.centerIn: dmgNum2b
                    anchors.horizontalCenterOffset: -1
                    Image {
                        anchors.fill: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }

                Text {
                    id: dmgNum2b
                    font.family: gameFont.name
                    font.pixelSize: 32

                    color: "black" //gameColors.iFaceBrightCol
                    //                    style: Text.Outline
                    //                        style: Text.Outline
                    styleColor: "white"

                    text: "31%"

                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: 1

                } //Close Text 'swapText'. (Complete)

            }
        }

    }

    Item {
        id: intro18
        width: 260
        height: 80
        anchors.centerIn: parent

        visible: tutStage === 17

        ParallelAnimation {
            id: platSpread
            running: false
            NumberAnimation {
                target: intro18
                property: "width"
                from: 260
                to: 200
                duration: 200
            }
            NumberAnimation {
                target: intro18
                property: "height"
                from: 80
                to: 260
                duration: 200
            }
        }

        Item {
            id: platBox
            anchors.fill: parent

            Rectangle {
                id: finalPlatDS
                width: finalPlat.width
                height: finalPlat.height
                anchors.centerIn: finalPlat
                anchors.horizontalCenterOffset: 3
                anchors.verticalCenterOffset: 3
                radius: finalPlat.radius
                color: gameColors.iFaceDSCol
            }

            Rectangle {
                id: finalPlat
                anchors.fill: parent
                radius: 6
                color: gameColors.iFaceDarkCol
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
                    GradientStop { position: 1.0; color: gameColors.iFaceCol}
                }
                border.color: gameColors.iFaceBrightCol
                border.width: 2
            }

            Item {
                id: finalPlatBG
                width: finalPlat.width - finalPlat.border.width * 2
                height: finalPlat.height - finalPlat.border.width * 2
                anchors.centerIn: finalPlat
                clip: true

                Image {
                    width: 320
                    height: 480
                    anchors.centerIn: parent
                    source: "../assets/gfx/tutBG.png"
                    opacity: 0.2
                }

                Image {
                    id: starfield5
                    anchors.centerIn: parent
                    source: "../assets/gfx/bgStars.png"
                    opacity: 0.4
                    NumberAnimation {
                        target: starfield5
                        property: "rotation"
                        duration: 1000 * 180 //Three minutes.
                        from: 0
                        to: -360
                        loops: Animation.Infinite
                        running: intro18.visible
                    } //Close Timer 'starSpin'. (Complete)
                }
            }

        }

        ParallelAnimation {
            id: txtFade
            running: intro18.visible

            NumberAnimation {
                target: intro18txt
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
            NumberAnimation {
                target: intro18txtDS
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
            NumberAnimation {
                target: polyIcon
                property: "opacity"
                from: 0
                to: 1
                duration: 400
            }
            NumberAnimation {
                target: iconBox
                property: "opacity"
                from: 0
                to: 1
                duration: 400
            }
            NumberAnimation {
                target: dropIcon
                property: "opacity"
                from: 0
                to: 1
                duration: 800
            }
        }

        Text {
            id: intro18txtDS
            font.family: intro18txt.font.family
            font.pixelSize: intro18txt.font.pixelSize
            horizontalAlignment: intro18txt.horizontalAlignment
            lineHeightMode: intro18txt.lineHeightMode
            lineHeight: intro18txt.lineHeight
            anchors.centerIn: intro18txt
            anchors.horizontalCenterOffset: 1
            anchors.verticalCenterOffset: 1
            color: "black" //gameColors.iFaceDSCol
            text: intro18txt.text
        }

        Text {
            id: intro18txt
            font.family: chatFont.name
            font.pixelSize: 13
            horizontalAlignment: Text.AlignHCenter
            lineHeightMode: Text.FixedHeight
            lineHeight: 26
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            color: "white"
            text: "
Get POLYs.<br/><br/>
Build ROWs.<br/><br/>
Drop to SCORE."
        }

        Item {
            id: polyIcon

            width: 28
            height: width

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 28

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
                color: gameColors.iFaceCol
                border.width: 3
                border.color: gameColors.iFaceDarkCol

                Image {
                    id: polyImg
                    width: 20
                    height: width
                    anchors.centerIn: parent
                    source: "../assets/gfx/poly.png"
                    NumberAnimation {
                        target: polyImg
                        property: "rotation"
                        from: 0
                        to: 360
                        duration: 6000
                        running: intro18.visible
                        loops: Animation.Infinite
                    }
                } //Close Image 'poly1'.

            } //Close Rectangle.

        } //Close Item.

        Item {
            id: iconBox
            width: 80
            height: 20

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 84

            Rectangle {
                id: horiConnX
                width: 90
                height: 2
                anchors.centerIn: parent
                color: "black"

                Rectangle {
                    id: connDot1X
                    width: 4
                    height: width// + 2
                    radius: width / 2
                    x: parent.width / 2
                    y: -2
                    color: "white"
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: -27
                    Image {
                        width: parent.width * 2
                        height: parent.height * 2
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }
                Rectangle {
                    id: connDot2X
                    width: 4
                    height: width// + 2
                    radius: width / 2
                    x: parent.width / 2
                    y: -2
                    color: "white"
                    anchors.centerIn: parent
                    Image {
                        width: parent.width * 2
                        height: parent.height * 2
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }
                Rectangle {
                    id: connDot3X
                    width: 4
                    height: width// + 2
                    radius: width / 2
                    x: parent.width / 2
                    y: -2
                    color: "white"
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: 27
                    Image {
                        width: parent.width * 2
                        height: parent.height * 2
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                    }
                }

            }

            Row {
                id: exRowX
                anchors.centerIn: parent

                property int duration: 1200
                property int size: 26

                Item {
                    id: bitBox1X
                    width: exRowX.size
                    height: width

                    Image {
                        id: glow1X
                        width: parent.width + 8
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glow1X.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bit1X
                        width: exRowX.size
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../assets/gfx/dna_dr.png"
                    }
                }

                Item {
                    id: bitBox2X
                    width: exRowX.size
                    height: width

                    Image {
                        id: bit2X
                        width: exRowX.size
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_g.png"
                    }
                }

                Item {
                    id: bitBox3X
                    width: exRowX.size
                    height: width

                    Image {
                        id: bit3X
                        width: exRowX.size
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_t2.png"
                    }
                }

                Item {
                    id: bitBox4X
                    width: exRowX.size
                    height: width

                    Image {
                        id: glow4X
                        width: parent.width + 8
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/highlight.png"
                        Timer {
                            running: true
                            repeat: true
                            interval: 60
                            onTriggered: glow4X.opacity = (Math.floor(Math.random() * 40) + 40) / 100
                        }
                    }

                    Image {
                        id: bit4X
                        width: exRowX.size
                        height: width
                        anchors.centerIn: parent
                        source: "../assets/gfx/dna_dr2.png"
                    }
                }

            }

        }

        Item {
            id: dropIcon
            width: 60
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 134

            Image {
                id: iconHalo
                width: iconImg.width * 1.25
                height: width
                anchors.centerIn: iconImg
                source: "../assets/gfx/dropHalo.png"

                NumberAnimation {
                    target: iconHalo
                    property: "rotation"
                    duration: 2000
                    from: 45
                    to: 0
                    loops: Animation.Infinite
                    running: intro18.visible
                } //Close NumberAnimation

                SequentialAnimation {
                    id: iconGlow

                    loops: Animation.Infinite
                    running: intro9.visible

                    property int duration: 2000

                    NumberAnimation {
                        target: iconHalo
                        property: "opacity"
                        duration: iconGlow.duration / 2
                        from: 1
                        to: 0.4
                    } //Close NumberAnimation.

                    NumberAnimation {
                        target: iconHalo
                        property: "opacity"
                        duration: iconGlow.duration / 2
                        from: 0.4
                        to: 1
                    } //Close NumberAnimation.

                } //Close SequentialAnimation.

            }

            Image {
                id: iconImg
                anchors.fill: parent
                source: "../assets/gfx/drop.png"
            }
            Image {
                id: iconImg2
                anchors.fill: parent
                source: "../assets/gfx/drop2.png"

                SequentialAnimation {
                    id: iconSwitch

                    loops: Animation.Infinite
                    running: intro18.visible

                    NumberAnimation {
                        target: iconImg2
                        property: "opacity"
                        duration: 400
                        from: 0
                        to: 1
                    } //Close NumberAnimation.

                    NumberAnimation {
                        duration: 1000
                    }

                    NumberAnimation {
                        target: iconImg2
                        property: "opacity"
                        duration: 400
                        from: 1
                        to: 0
                    } //Close NumberAnimation.

                    NumberAnimation {
                        duration: 1000
                    }

                } //Close SequentialAnimation.
            }
        }

        Item {
            id: okButton
            width: 60
            height: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 36

            Rectangle {
                id: okBox
                anchors.fill: parent
                radius: 4
                color: gameColors.iFaceCol
                border.color: "black"
                border.width: 2

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        okBox.color = gameColors.iFaceLightCol
                        okBox.border.color = "white"
                        okTxt.color = "white"
                    }
                    onExited: {
                        okBox.color = gameColors.iFaceCol
                        okBox.border.color = "black"
                        okTxt.color = "black"
                    }
                    onClicked: tutStage = 18
                }

                Text {
                    id: okTxtDS
                    anchors.centerIn: okTxt
                    anchors.horizontalCenterOffset: 1
                    anchors.verticalCenterOffset: 1
                    font.family: okTxt.font.family
                    font.pixelSize: okTxt.font.pixelSize
                    color: gameColors.iFaceDarkCol
                    text: okTxt.text
                }

                Text {
                    id: okTxt
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 1
                    font.family: gameFont.name
                    font.pixelSize: 14
                    color: "black"
                    text: "OK!"
                }
            }

        }

        Item {
            id: backButton
            width: 100
            height: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10

            Rectangle {
                id: buttonBox
                anchors.fill: parent
                radius: 4
                color: gameColors.iFaceCol
                border.color: "black"
                border.width: 2

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        buttonBox.color = gameColors.iFaceLightCol
                        buttonBox.border.color = "white"
                        backTxt2.color = "white"
                    }
                    onExited: {
                        buttonBox.color = gameColors.iFaceCol
                        buttonBox.border.color = "black"
                        backTxt2.color = "black"
                    }
                    onClicked: tutStage = 16
                }

                Text {
                    id: backTxt2DS
                    anchors.centerIn: backTxt2
                    anchors.horizontalCenterOffset: 1
                    anchors.verticalCenterOffset: 1
                    font.family: backTxt2.font.family
                    font.pixelSize: backTxt2.font.pixelSize
                    color: gameColors.iFaceDarkCol
                    text: backTxt2.text
                }

                Text {
                    id: backTxt2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 1
                    font.family: gameFont.name
                    font.pixelSize: 14
                    color: "black"
                    text: "<< Back"
                }
            }

        }

    }

    Item {
        id: intro19
        anchors.fill: parent

        visible: tutStage === 18

        NumberAnimation {
            id: introFade
            target: intro19
            property: "opacity"
            from: 1
            to: 0
            duration: 200
        }

        Item {
            id: backBox
            width: 260
            height: 60
            anchors.centerIn: parent

            Rectangle {
                id: backPlatDS
                width: backPlat.width
                height: backPlat.height
                anchors.centerIn: backPlat
                anchors.horizontalCenterOffset: 3
                anchors.verticalCenterOffset: 3
                radius: backPlat.radius
                color: gameColors.iFaceDSCol
            }

            Rectangle {
                id: backPlat
                anchors.fill: parent
                radius: 6
                color: gameColors.iFaceDarkCol
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
                    GradientStop { position: 1.0; color: gameColors.iFaceCol}
                }
                border.color: gameColors.iFaceBrightCol
                border.width: 2
            }

            Item {
                id: backPlatBG
                width: backPlat.width - backPlat.border.width * 2
                height: backPlat.height - backPlat.border.width * 2
                anchors.centerIn: backPlat
                clip: true

                Image {
                    width: 320
                    height: 480
                    anchors.centerIn: parent
                    source: "../assets/gfx/tutBG.png"
                    opacity: 0.2
                }
            }

            Text {
                id: backTxtDSX
                font.family: backTxtX.font.family
                font.pixelSize: backTxtX.font.pixelSize
                horizontalAlignment: backTxtX.horizontalAlignment
                anchors.centerIn: backTxtX
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                color: "black" //gameColors.iFaceDSCol
                text: backTxtX.text
            }

            Text {
                id: backTxtX
                font.family: chatFont.name
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                text: "Tap my face any time you want<br/>to replay this tutorial."
            }
        }

        Item {
            id: startBox
            width: 160
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 130

            Rectangle {
                id: startPlatDS
                width: startPlat.width
                height: startPlat.height
                anchors.centerIn: startPlat
                anchors.horizontalCenterOffset: 3
                anchors.verticalCenterOffset: 3
                radius: startPlat.radius
                color: gameColors.iFaceDSCol
            }

            Rectangle {
                id: startPlat
                anchors.fill: parent
                radius: 6
                color: gameColors.iFaceDarkCol
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceCol}
                    GradientStop { position: 1.0; color: gameColors.iFaceBGCol}
                }
                border.color: gameColors.iFaceBrightCol
                border.width: 2
            }

            Item {
                id: startPlatBG
                width: startPlat.width - startPlat.border.width * 2
                height: startPlat.height - startPlat.border.width * 2
                anchors.centerIn: startPlat
                clip: true

                Image {
                    width: 320
                    height: 480
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    source: "../assets/gfx/tutBG.png"
                    opacity: 0.2
                }
            }

            Text {
                id: intro19txtDS
                font.family: intro19txt.font.family
                font.pixelSize: intro19txt.font.pixelSize
                horizontalAlignment: intro19txt.horizontalAlignment
                anchors.centerIn: intro19txt
                anchors.horizontalCenterOffset: 1
                anchors.verticalCenterOffset: 1
                color: "black" //gameColors.iFaceDSCol
                text: intro19txt.text
            }

            Text {
                id: intro19txt
                font.family: chatFont.name
                font.pixelSize: 13
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                color: "white"
                text: "You have "+ (stageLength - turnCount) +" rows<br/>left to score!"
            }

        }

        Item {
            id: turnCounter
            width: 80
            height: 36
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60

            Rectangle {
                width: parent.height
                height: parent.width
                anchors.centerIn: parent
                rotation: -90
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceCol}
                    GradientStop { position: 1.0; color: "transparent"}
                }
            }

            Rectangle {
                width: parent.height - 12
                height: parent.width
                anchors.centerIn: parent
                rotation: -90
                gradient: Gradient {
                    GradientStop { position: 0.0; color: gameColors.iFaceDarkCol}
                    GradientStop { position: 1.0; color: "transparent"}
                }
            }

            Text {
                id: turnTextDS
                anchors.centerIn: turnText
                anchors.horizontalCenterOffset: 2
                anchors.verticalCenterOffset: 2
                font.family: turnText.font.family
                font.pixelSize: turnText.font.pixelSize
                color: "black"
                text: turnText.text
            }

            Text {
                id: turnText
                anchors.left: parent.left
                anchors.leftMargin: 6
                anchors.verticalCenter: parent.verticalCenter
                font.family: gameFont.name
                font.pixelSize: 18
                color: "white"
                text: {
                    if (endLess)
                        return "Rows: ∞"
                    else return "Rows: " + (stageLength - turnCount)
                }
            }
        }

        Item {
            id: remBox
            width: 48
            height: width
            anchors.left: parent.left
            anchors.leftMargin: 45
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 55

            SequentialAnimation {
                id: remFade
                running: intro19.visible
                loops: Animation.Infinite

                property int duration: 800

                NumberAnimation {
                    target: remHL
                    property: "opacity"
                    from: 0.2
                    to: 0.6
                    duration: remFade.duration / 2
                }

                NumberAnimation {
                    target: remHL
                    property: "opacity"
                    from: 0.6
                    to: 0.2
                    duration: remFade.duration / 2
                }
            }

            Rectangle {
                id: remHL
                anchors.fill: parent
                radius: width / 2
                color: gameColors.iFaceBrightCol
            }

            Rectangle {
                id: remHLBorder
                anchors.fill: parent
                radius: width / 2
                color: "transparent"
                border.color: "white" //gameColors.iFaceBrightCol
                border.width: 4
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                elementsEnabled = true
                introFade.start()
                backGrad.fade()
                gradsFade.start()
            }
        }

    }

}
