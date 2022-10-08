import QtQuick 2.0
import Felgo 3.0

Item {

    id: dnaArray

    //Fill game field with blocks. (Complete)
    function resetLadder() {

        //The game is not ready until the ladder has been repopulated with bits. (Complete)
        gameOn = false

        gameEntities.removeAllEntities()

        if (stageLength < stageWindow)
            stageLength = stageWindow

        dnaRows = []
        floatGrid = []

        var gameRow = 0

        //Top to bottom. (Complete)
        for(var row = 0; row < stageWindow + turnBuffer; row++) {

            if (row > turnBuffer) {
                dnaRows[row] = addRow(row,dnaRows)
                //                gameRow += 1

                if (row > turnBuffer + 1) {
                    var rowId = dnaRows[row - 1]
                    rowId.rowUp = dnaRows[row]
                }
            } else
                dnaRows[row] = undefined

            floatGrid[row * 2] = false
            floatGrid[row * 2 + 1] = false

        } //EndFor: (var row = 0; row < rows; row++). (Complete)

        row = stageWindow + turnBuffer
        floatGrid[row * 2] = false
        floatGrid[row * 2 + 1] = false

        startErrors()

        var swapId = gameEntities.createEntityFromUrl(
                    Qt.resolvedUrl("SwapBit.qml"))
        var entity = gameEntities.getEntityById(swapId)
        swap1 = entity

        swapId = gameEntities.createEntityFromUrl(
                    Qt.resolvedUrl("SwapBit.qml"))
        entity = gameEntities.getEntityById(swapId)
        swap2 = entity

        turnCount = 0
        breakTurns = 0
        strChain = 0
        bestChain = 0
        strPerfect = 0
        bestPerfect = 0
        compRows = 0
        matchRows = 0
        exBits = 0
        levelScore = 0
        scoreLevel = levelStart
        gameScore = 0
        gameLevel = 0

        gamePolys = 2

        //Indicate that the ladder has been filled successfully, and that the game is ready. (Complete)
        gameOn = true
        //        elementsEnabled = true

    } //Close function resetLadder(). (Complete)

    //Create a new bit at specific position. (Complete)
    function addRow(row,array) {

        var rowsCopy = array

        //Now, all of the reset variables have been accordingly altered and marked.
        //Here the variables are placed onto an attributes map for the generation of a new bit. (Complete)
        var bitProps = {
            row: row,
            y: parent.height - row * bitSize,
            z: 100
        } //Close bitProps. (Complete)

        //Add bit to game area, returning its id as var id. (Complete)
        var bitId = gameEntities.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("DNARow.qml"), bitProps)

        //Grab the EntityId from the newly-created bit. (Complete)
        var entity = gameEntities.getEntityById(bitId)

        //Return the EntityId of the newly-created bit. (Complete)
        return entity

    } //Close function addBit(column, row). (Complete)

    function startErrors() {

        var rowsCopy = dnaRows

        var totErrors = (stageWindow * 4) * (stageErrors / 100)
        var errors = 0

        var row = Math.floor(Math.random() * stageWindow) + turnBuffer

        while (errors < totErrors) {
            row = Math.floor(Math.random() * stageWindow) + turnBuffer
            var rowId = rowsCopy[row]
            if (rowId !== undefined)
                if (rowId.errCount < 4) {
                    if (Math.floor(Math.random() * startVoids) > 0) {
                        rowId.addError()
                        errors += 1
                    } else
                        if (rowId.voidCount < 2) {
                            rowId.addVoid()
                            addFloat(row)
                            errors += 1
                        }
                }
        }

        for (row = turnBuffer; row < stageWindow + turnBuffer; row++) {
            rowId = rowsCopy[row]
            if (rowId !== undefined)
                rowId.rowCheck()
        }
    }



}
