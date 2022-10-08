import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: dnaRow

    Component.onCompleted: rowCheck()

    entityType: "dnaRow"

    width: 160
    height: 40

    anchors.horizontalCenter: parent.horizontalCenter

    enabled: {
        if (!elementsEnabled)
            return false
        else return y > 60
    }
    visible: y >= 0

    property bool elementsEnabled: parent.elementsEnabled

    property bool sunk: false
    onSunkChanged: {
        bit0.sink()
        bit1.sink()
        bit2.sink()
        bit3.sink()
    }

    property bool error1: bit1.bitError
    property bool error2: bit2.bitError

    property var rowUp

    property int row
    property int errCount: 0
    property int voidCount: 0
    property bool rowComplete: false
    property bool rowMatch: false

    property int dropTime: parent.dropTime

    NumberAnimation {
        id: rowDrop
        target: dnaRow
        property: "y"
        to: target.y + parent.bitSize
        duration: dropTime
        easing.type: Easing.InBack
        onStarted: {
            if (target.y + parent.bitSize > parent.ladderBase && !sunk)
                sunk = true
            enabled = false
        }
        onStopped: {
            if (target.y <= parent.ladderBase && parent.errMutate)
                mutate()
            if (target.y > 60 && !sunk)
                enabled = true
            if (row < 0) {
                //                gameScene.dnaRows[row] = undefined
                gameEntities.removeEntityById(entityId)
            }
        }
    }

    DNA_BB {
        id: bit0

        width: parent.height
        height: width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        bitFlip: false
        bitError: {
            if (bitFlip)
                return true
            else return false
        }

        bitOffset: -4

        bitColumn: 0
        bitRow: row
    }

    DNABit {
        id: bit1

        width: parent.height
        height: width
        anchors.right: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        bitFlip: false
        bitError: {
            if (bitType > 4)
                return true
            if (bitFlip)
                return true
            else return false
        }

        bitOffset: -2

        bitColumn: 1
        bitRow: row
    }

    DNABit {
        id: bit2

        width: parent.height
        height: width
        anchors.left: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        bitFlip: true
        bitError: {
            if (bitType > 4)
                return true
            if (bitFlip)
                return false
            else return true
        }

        bitOffset: 2

        bitColumn: 2
        bitRow: row
    }

    DNA_BB {
        id: bit3

        width: parent.height
        height: width
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        bitFlip: true
        bitError: {
            if (bitFlip)
                return false
            else return true
        }

        bitOffset: 4

        bitColumn: 3
        bitRow: row
    }

    function newErrors(row) {
        var error0 = false
        var error1 = false
        var error2 = false
        var error3 = false

        if (Math.floor(Math.random() * 100) <= parent.stageErrors) {
            error0 = true
        }
        if (Math.floor(Math.random() * 100) <= parent.stageErrors) {
            error1 = true
        }
        if (Math.floor(Math.random() * 100) <= parent.stageErrors) {
            error2 = true
        }
        if (Math.floor(Math.random() * 100) <= parent.stageErrors) {
            error3 = true
        }

        if (error0) {
            bit0.bitFlip = !bit0.bitFlip
            errCount += 1
        }
        if (error1) {
            errCount += 1
            if (Math.floor(Math.random() * 4) > 0) {
                bit1.bitFlip = !bit1.bitFlip
            } else {
                voidCount += 1
                bit1.bitType = 5
                if (Math.floor(Math.random() * 2) < 1)
                    bit1.bitFlip = !bit1.bitFlip
                parent.addFloat(gameScene.turnBuffer + gameScene.stageWindow)
            }
        }
        if (error2) {
            errCount += 1
            if (Math.floor(Math.random() * 4) > 0) {
                bit2.bitFlip = !bit2.bitFlip
            } else {
                voidCount += 1
                bit2.bitType = 5
                if (Math.floor(Math.random() * 2) < 1)
                    bit2.bitFlip = !bit2.bitFlip
                parent.addFloat(gameScene.turnBuffer + gameScene.stageWindow)
            }
        }
        if (error3) {
            bit3.bitFlip = !bit3.bitFlip
            errCount += 1
        }
    }

    function addError() {

        var errCheck = false

        while (errCheck === false) {
            var col = Math.floor(Math.random() * 4)
            if (col === 0)
                if (!bit0.bitError) {
                    bit0.bitFlip = !bit0.bitFlip
                    errCount += 1
                    errCheck = true }
            if (col === 1)
                if (!bit1.bitError) {
                    bit1.bitFlip = !bit1.bitFlip
                    errCount += 1
                    errCheck = true }
            if (col === 2)
                if (!bit2.bitError) {
                    bit2.bitFlip = !bit2.bitFlip
                    errCount += 1
                    errCheck = true }
            if (col === 3)
                if (!bit3.bitError) {
                    bit3.bitFlip = !bit3.bitFlip
                    errCount += 1
                    errCheck = true }
        }
        return errCheck
    }

    function addVoid() {

        var voidCheck = false

        while (voidCheck === false) {
            var col = Math.floor(Math.random() * 2)
            if (col === 0)
                if (!bit1.bitError) {
                    bit1.bitType = 5
                    errCount += 1
                    voidCount += 1
                    voidCheck = true }
            if (col === 1)
                if (!bit2.bitError) {
                    bit2.bitType = 5
                    errCount += 1
                    voidCount += 1
                    voidCheck = true }
        }
        return voidCheck
    }

    function rowCheck(col) {
        var errors = 0
        if (bit0.bitError) {
            errors += 1
            if (col !== undefined)
                if (col === 0)
                    return true
        }
        if (bit1.bitError) {
            errors += 1
        }
        if (bit2.bitError) {
            errors += 1
        }
        if (bit3.bitError) {
            errors += 1
            if (col !== undefined)
                if (col === 3)
                    return true
        }

        if (errors === 0)
            rowComplete = true
        else rowComplete = false

        if (bit1.bitType + bit2.bitType === 5)
            rowMatch = true
        else rowMatch = false

        errCount = errors
    }

    function bitFlash(col) {
        if (col === 0)
            bit0.flash()
        if (col === 1)
            bit1.flash()
        if (col === 2)
            bit2.flash()
        if (col === 3)
            bit3.flash()
    }

    function bitChange(newType,newFlip,col) {
        if (col === 1)
            bit1.bitChange(newType,newFlip)
        if (col === 2)
            bit2.bitChange(newType,newFlip)
    }

    function mutate() {
        bit1.errCheck()
        bit2.errCheck()
    }

    function rowFlip(flip0,flip1,flip2,flip3) {
        if (flip0)
            if (bit0.errorTurns < 2)
                bit0.flip()
        if (flip1)
            if (bit1.errorTurns < 2)
                bit1.flip()
        if (flip2)
            if (bit2.errorTurns < 2)
                bit2.flip()
        if (flip3)
            if (bit3.errorTurns < 2)
                bit3.flip()
    }

    function drop() {
        row -= 1
        rowDrop.start()
    }

    function rowFlash() {
        if (!bit0.bitError)
            bit0.flash()
        if (!bit1.bitError)
            bit1.flash()
        if (!bit2.bitError)
            bit2.flash()
        if (!bit3.bitError)
            bit3.flash()
    }

}
