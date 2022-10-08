//--**COMPLETE**--\\`

import QtQuick 2.0
import Felgo 3.0

Item {
    id: bitIcon
    width: 12
    height: width

    property int bitType
    property bool bitError: true

    visible: !bitError

    Rectangle {
        id: bitCircle
        width: 8
        height: width
        radius: height / 2
        anchors.centerIn: parent

        color: {
            if (bitType === 0)
                return "white"
            if (bitType === 1)
                return "#2c25d6"
            if (bitType === 2)
                return "#FFB000"
            if (bitType === 3)
                return "#FE6100"
            if (bitType === 4)
                return "#DC267F"
            return "transparent"
        }
    }

} //Close EntityBase 'dnaBit'. (Complete)
