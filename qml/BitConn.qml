import QtQuick 2.0
import Felgo 3.0

Item {
    id: bitConn

    anchors.fill: parent

    property int bitOffset: {
        if (parent.bitColumn === 0)
            return -4
        if (parent.bitColumn === 1)
            return 0
        if (parent.bitColumn === 2)
            return 4
        return 0
    }

    property int fadeTime: 600

    Rectangle {
        id: vertConn
        width: 8
        height: parent.height - 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.topMargin: {
            if (bitColumn === 0)
                return 10
            if (bitColumn === 3)
                return -7
            return 0
        }
        rotation: {
            if (bitColumn === 3)
                return 180
            return 0
        }

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

        visible: {
            if (rowUp === undefined)
                return false
            if (bitError)
                return false
            if (bitColumn === 1 || bitColumn === 2)
                return false
            return upCheck()
        }
    }

    Rectangle {
        id: horiConn
        width: parent.width
        height: {
            if (rowMatch)
                return 4
            else return 4
        }
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: parent.width / 2
        anchors.verticalCenterOffset: bitOffset
        color: {
            if (rowMatch)
                return "white"
            else return "black"
        }

        visible: {
            if (bitError)
                return false
            if (bitColumn >= 3)
                return false
            if (bitColumn === 0)
                if (bit1.bitError)
                    return false
            if (bitColumn === 1)
                if (bit2.bitError)
                    return false
            if (bitColumn === 2)
                if (bit3.bitError)
                    return false
            if (bitType > 4)
                return false
            return true
        }

        Image {
            id: dotGlow
            width: connDot.width * 2
            height: connDot.height * 2
            anchors.centerIn: connDot
            source: "../assets/gfx/highlight.png"
        }

        Rectangle {
            id: connDot
            width: parent.height + 2
            height: width// + 2
            radius: width / 2
            x: parent.width / 2
            y: -2
            color: {
                if (rowComplete || rowMatch)
                    return "white"
                else return "black"
            }
            anchors.centerIn: parent
        }

    }

    NumberAnimation {
        id: connFade
        target: bitConn
        property: "opacity"
        duration: fadeTime
        from: 1
        to: 0.6
    }

    function upCheck() {
        if (rowUp !== undefined) {
            if (bitColumn === 0)
                if (rowUp.rowCheck(0))
                    return false
            if (bitColumn === 3)
                if (rowUp.rowCheck(3))
                    return false
            return true
        }
        return true
    }

    function fade() {
        connFade.start()
    }

}
