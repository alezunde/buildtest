import QtQuick 2.0
import Felgo 3.0
import QtMultimedia 5.0

//This is the main game scene where all of the game interactions will take place.
//This is also the the active scene, and contains all of the game entitites.
//Here, values are relative to the logical scene size of 320 x 480px with an origin of 0, 0.
//(Working)
Scene {
    id: gameScene

    clip: true
    enabled: gameOn

    property int theme: Math.floor(Math.random() * gameColors.themes) //0: Enceladus (Default). 1: Earth. 2: Mars.
    property string themeTitle: "Luna"

    property bool logoShown: false

    //Declare some global variables, starting with inputReg, a flag
    //that enables regular input. It should start false. (Complete)
    property bool inputReg: false

    //Whether or not the splash screen is showing. If it is set to true, the game starts
    //on the main splash screen. (Complete)
    property bool splashUp
    //Whether or not the intro is being played; This should start as false. (Complete)
    property bool introPlaying
    //Whether or not the game menu is open. Intitially, this is false. (Complete)
    property bool menuUp
    property bool inSpect

    property bool elementsEnabled: false

    //0: The default starting mode of the game.
    //1: Start the game directly.
    //2: Start the game with the menu open.
    //3: Start the game with the inspection layer visible and regular input disabled.
    //4: Start the game at the beginning of the intro cinematic.
    //5: Start the game at the splash, without the logo.

    property int startMode: 1

    Component.onCompleted: {

        if (startMode > 0) {

            //Start the game directly.
            if (startMode === 1) {
                logoShown = true
                splashUp = false
                introPlaying = false
                menuUp = false
                inSpect = false
                bgMusic.play()
                underWater.play()
            } //EndIf.

            //Start the game with the menu open.
            if (startMode === 2) {
                logoShown = true
                splashUp = false
                introPlaying = false
                menuUp = true
                inSpect = false
                bgMusic.play()
                underWater.play()
            } //EndIf.

            //Start the game with the inspection layer visible and regular input disabled.
            if (startMode === 3) {
                logoShown = true
                splashUp = false
                introPlaying = false
                menuUp = false
                inSpect = true
                bgMusic.play()
                underWater.play()
            } //EndIf.

            //Start the game at the beginning of the intro cinematic.
            if (startMode === 4) {
                logoShown = true
                splashUp = false
                introPlaying = true
                menuUp = false
                inSpect = false
            } //EndIf.

            //Start the game at the splash, without the logo.
            if (startMode === 5) {
                logoShown = true
                splashUp = true
                introPlaying = false
                menuUp = false
                inSpect = false
                //                titleMusic.play()
            } //EndIf.

        } else {

            //The default starting mode of the game.
            //After showing the Alexary logo, the main splash appears.
            logoShown = false
            splashUp = true
            introPlaying = false
            menuUp = false
            inSpect = false

        } //EndElse: (startMode > 0).

        dnaArray.resetLadder()

    } //Close Component.onCompleted.

    property bool sfxOn: true
    property bool musicOn: true
    property bool ambOn: true

    property double sfxVol: 0.5
    property double musicVol: 0.5
    property double ambVol: 0.5

    //Unless the game is started from the main splash screen, this should start as false.
    //It is the flag that indicates active gameplay. (Complete)
    property bool gameOn: true
    property bool gameOver: false

    //If the swap mode is active. This will be false until swap mode is made active. (Complete)
    property bool swapMode: false
    //If the click box is visible. This should start as false until called directly. (Complete)
    property bool bitClickBox: false

    //    //An alarm flag in case there are not enough Polys, or Polys are maxed out.
    //    //It should always start false. (Complete)
    //    property bool outOfPolys: false

    //The number of Polys at the start of the game. Two seems like a good value.
    property int gamePolys: 2
    //The maximum number of Polys available at any given time. Four seems to work okay.
    property int maxPolys: 4

    //NEW PROPERTIES
    property int bitSize: 40
    property int ladderBase: 320

    property var dnaRows: []
    property var floatGrid: []
    property var floatBits: []
    //    property var addedRows: []

    property var swap1
    property var swap2

    property int turnBuffer: 3
    property int floatBuffer: 2
    property int dmgBuffer: 1

    //This determines how many rows are being handled at once.
    property int stageWindow: 12
    //The total length of the stage.
    property int stageLength: 12
    //Whether or not the stage is endless.
    property bool endLess: false

    //The number of errors the stage begins with, in percent.
    //Each error will have a chance to generate a void bit, and susequently, a floating bit.
    property int stageErrors: 20 //%

    //The amount of damage caused by the environment (via chemical or radiation) in percentage.
    property double envDmg: 5 //%
    //Whether or not environmental damage applies.
    property bool dmgOn: true
    //Whether or not environmental damage increases per level.
    property bool dmgGain: true
    //Whether or not leaving an error for too long can mutate a bit.
    property bool errMutate: true
    //
    property int startVoids: 4
    property int mutVoids: 10

    //A timer function that can be enabled to increase the gameplay difficulty. Setting it to 0 disables the timer.
    property int turnTimer: 0

    property int maxPossible

    //The number of turns that have passed during the stage. This starts at 0.
    property int turnCount: 0
    property int breakTurns: 0

    //The length of a continuous strand achieved by the player. This starts at 0.
    property int strChain: 0
    property int bestChain: 0

    //The length of a perfect strand achieved by the player. This starts at 0.
    property int strPerfect: 0
    property int bestPerfect: 0

    property int compRows: 0
    property int matchRows: 0
    property int exBits: 0

    //The amount of points counting toward the next game level.
    //This starts at zero. (Complete)
    property int levelScore: 0
    //The amount of points needed to advance a game level.
    property int scoreLevel: 20
   //The variable needed to reset the leveling system.
    property int levelStart: scoreLevel

    //The game score. Always starts at zero. (Complete)
    property int gameScore: 0

    //The current game level. It always starts at zero. (Complete)
    property int gameLevel: 0

    property int flipTime: 200
    property int dropTime: 600
    property int swapTime: 400
    property int sinkTime: dropTime
    property int fadeTime: 200
    property int flashTime: 800

    property string hdrSource
    property string fnlSource

    Timer {
        id: finalTimer
        running: false
        interval: dropTime
        onTriggered: finalScreen.reveal()
    }

    BackgroundMusic {
        id: underWater

        property double range: 0.6

        autoPlay: false
        source: "../assets/sfx/255597__akemov__underwater-ambience.wav"
        volume: range * ambVol
        muted: !ambOn
        autoPauseInBackground: true
    } //Close BackgroundMusic.

    BackgroundMusic {
        id: titleMusic

        property double range: 0.1

        autoPlay: false
        source: "../assets/sfx/Voices-From-Heaven.mp3"
        volume: range * musicVol
        muted: !splashUp
        autoPauseInBackground: true
    } //Close BackgroundMusic.

    BackgroundMusic {
        id: bgMusic

        property double range: 0.3

        autoPlay: false
        source: "../assets/sfx/00_officina-zanchi_medieval-4695.mp3" //range: 0.3
        volume: range * musicVol
        muted: !gameOn || !musicOn
        autoPauseInBackground: true
    } //Close BackgroundMusic.

    property alias startSound: startSound

    SoundEffect {
        id: startSound

        property double range: 0.2

        source: "../assets/sfx/582630__ironcross32__dong.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'startSound'.

    property alias reSound: reSound

    SoundEffect {
        id: reSound

        property double range: 0.2

        source: "../assets/sfx/582631__ironcross32__long-crackle-04.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'reSound'.

    property alias bitClick: bitClick

    SoundEffect {
        id: bitClick

        property double range: 0.2

        source: "../assets/sfx/582902__ironcross32__snap-click-05.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'bitClick'.

    property alias boxClick: boxClick

    SoundEffect {
        id: boxClick

        property double range: 0.2

        source: "../assets/sfx/582898__ironcross32__snap-click-01.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'boxClick'.

    property alias ladderDrop: ladderDrop

    SoundEffect {
        id: ladderDrop

        property double range: 0.2

        source: "../assets/sfx/582654__ironcross32__long-rising-tones-17.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'ladderDrop'.

    property alias strandUp: strandUp

    SoundEffect {
        id: strandUp

        property double range: 0.2

        source: "../assets/sfx/582649__ironcross32__long-rising-tones-14.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'strandUp'.

    property alias strandBreak: strandBreak

    SoundEffect {
        id: strandBreak

        property double range: 0.2

        source: "../assets/sfx/582631__ironcross32__long-crackle-04.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'strandBreak'.

    property alias flipSound: flipSound

    SoundEffect {
        id: flipSound

        property double range: 0.3

        source: "../assets/sfx/582895__ironcross32__short-woosh-04.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'polyDown'.

    property alias swapSound: swapSound

    SoundEffect {
        id: swapSound

        property double range: 0.5

        source: "../assets/sfx/582896__ironcross32__short-woosh-03.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'polyDown'.

    property alias polyOut: polyOut

    SoundEffect {
        id: polyOut

        property double range: 0.2

        source: "../assets/sfx/582667__ironcross32__lowering-deactivate-04.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'polyOut'.

    property alias polyUp: polyUp

    SoundEffect {
        id: polyUp

        property double range: 0.2

        source: "../assets/sfx/582895__ironcross32__short-woosh-04.wav"
        volume: range * sfxVol
        muted: !sfxOn
    } //Close SoundEffect 'polyUp'.

    //Here, we insert 'gameColors', which is a list of colors used throughout the game.
    //It has no visible elements. (Complete)
    GameColors { id: gameColors }

    //The background is set to appear behind everything else in the game.
    //It is only visible during gameplay. (Complete)
    BackGround { z: 0; visible: gameOn }

    //The DNA array generates and handles all of the DNA bits.
    //It has no visual elements. (Complete)
    DNAArray { id: dnaArray; }

    DNALadder { z: 0; id: dnaLadder }

    //The top interface, which includes the header bar at the top, the rung lights on the left,
    //and the drop button and level progress meter on the right. (Working)
    InterFace { z: 200; id: interFace; visible: gameOn }

    //    The game menu, where the helper can be accessed.
    //    It is only visible while MenuUp is set to true. (Working)
    FinalScreen { id: finalScreen; z: 200; }

    Tutorial { id: gameTut; z: 210 }

    GameHelper { id: gameHelper; z: 300 }

    //ExamLayer { z: 15; id: examLayer; visible: inSpect }

    //The click box that appears when a bit is clicked,, allowing to flip or swap a bit.
    //It is only only visible while bitClickBox is true. (Working)
    //ClickBox { z: 10; id: clickBox; visible: bitClickBox }

    //The game helper. This 'handy' (haha) guy shows the footer bar and brings up the game menu.
    //It has animated elements that are triggered throughout gameplay.
    //Helper is visible only during gameplay. (Working)
    //GameHelper { z: 10; id: gameHelper; visible: gameOn }

    //The 'icon' that shows during a ladder reset, and starts not visible.
    //This item is activated by changing its visible state to true. (Complete)
    //ResetIcon { z: 20; id: resetIcon; visible: false }

    //The transition circle that initially covers the scene after entering
    //active gameplay. It is only made visible by clicking the start
    //button in the main spash screen. (Complete)
    //StartCircle { z: 20; id: startCircle; visible: false }

    //The main splash screen. From here, either the game can be started, or the intro played.
    //It is rendered in front of all other elements, with the exception of the intro cinematic.
    //It is only visible while splashUp is true. (Working)
    //GameSplash { z: 30; visible: splashUp; }

    //The intro cinematic; It is only visible while the intro is playing. (Working)
    //GameIntro { z: 30; id: gameIntro; visible: introPlaying }

    function swap() {
        var swap1 = gameScene.swap1
        var swap2 = gameScene.swap2

        if (!swap1.floatBit && !swap2.floatBit) {
            var rowId = swap1.rowCont
            var col = swap1.bitColumn
            rowId.bitChange(swap2.bitType,swap2.bitFlip,col)
            rowId = swap2.rowCont
            col = swap2.bitColumn
            rowId.bitChange(swap1.bitType,swap1.bitFlip,col)
        } else {
            var floatCopy = floatBits

            if (swap1.floatBit) {
                rowId = swap2.rowCont
                rowId.bitChange(swap1.bitType,swap1.bitFlip,swap2.bitColumn)
                if (swap2.bitType > 4) {
                    var floatId = swap1.bitId
                    floatId = gameEntities.getEntityById(floatId)
                    floatId.vanish()
                } else {
                    floatId = swap1.bitId
                    floatId = gameEntities.getEntityById(floatId)
                    floatId.bitChange(swap2.bitType,swap2.bitFlip)
                }
            }
            if (swap2.floatBit) {
                rowId = swap1.rowCont
                rowId.bitChange(swap2.bitType,swap2.bitFlip,swap1.bitColumn)
                if (swap1.bitType > 4) {
                    floatId = swap2.bitId
                    floatId = gameEntities.getEntityById(floatId)
                    floatId.vanish()
                } else {
                    floatId = swap2.bitId
                    floatId = gameEntities.getEntityById(floatId)
                    floatId.bitChange(swap1.bitType,swap1.bitFlip)
                }
            }
        }

        swap1.used = false
        swap1.voidBit = false
        swap1.floatBit = false

        swap2.used = false
        swap2.voidBit = false
        swap2.floatBit = false

        swapMode = false

        swapSound.play()
    }

    function drop() {

        if (turnCount + stageWindow <= stageLength || endLess) {
            var row = dnaRows.length
            var rowsCopy = dnaRows
            var rowId = dnaArray.addRow(row,dnaRows)
            rowId.y += turnCount * bitSize
            rowId.newErrors(row)
            rowsCopy[row] = rowId
            rowId = rowsCopy[row - 1]
            rowId.rowUp = rowsCopy[row]
            dnaRows = rowsCopy
        }

        for (row = turnCount; row < dnaRows.length; row ++) {
            rowId = dnaRows[row]

            if (rowId !== undefined) {

                if (row - turnCount > turnBuffer + dmgBuffer) {

                    if (dmgOn) {
                        var error0 = Math.floor(Math.random() * 100)
                        var error1 = Math.floor(Math.random() * 100)
                        var error2 = Math.floor(Math.random() * 100)
                        var error3 = Math.floor(Math.random() * 100)
                        var bit0 = false
                        var bit1 = false
                        var bit2 = false
                        var bit3 = false
                        if (error0 <= envDmg)
                            bit0 = true
                        if (error1 <= envDmg)
                            bit1 = true
                        if (error2 <= envDmg)
                            bit2 = true
                        if (error3 <= envDmg)
                            bit3 = true
                        rowId.rowFlip(bit0,bit1,bit2,bit3)
                    }
                }
                rowId.drop()
            }
        }

        swap1.drop()
        swap2.drop()

        var floatCopy = floatBits

        for (var index = 0; index < floatCopy.length; index ++) {
            var floatId = floatCopy[index]
            floatId.drop()
        }

        var gridCopy = floatGrid

        for (row = 0; row < stageWindow + turnBuffer; row ++) {
            index = row * 2
            gridCopy[index] = gridCopy[index + 2]
            index = row * 2 + 1
            gridCopy[index] = gridCopy[index + 2]
        }

        index = stageWindow * 2
        gridCopy[index] = false
        index = stageWindow * 2 + 1
        gridCopy[index] = false

        floatGrid = gridCopy

        rowId = dnaRows[turnBuffer + turnCount + 1]

        var scoreGain = 0
        var polyGain = 0

        if (rowId !== undefined) {
            rowId.rowCheck()

            if (rowId.rowComplete) {
                scoreGain += 2
                strChain += 1
                if (breakTurns > 0)
                    breakTurns -= 1
                if (strChain > bestChain)
                    bestChain = strChain
                if (rowId.rowMatch) {
                    matchRows += 1
                    scoreGain += 2
                    strPerfect += 1
                    if (strPerfect > bestPerfect)
                        bestPerfect = strPerfect
                    strandUp.play()
                } else {
                    compRows += 1
                    ladderDrop.play()
                }

            } else {
                var exPts = 0
                if (!rowId.error1)
                    exPts += 1
                if (!rowId.error2)
                    exPts += 1
                scoreGain += exPts
                exBits += exPts
                if (breakTurns > 0) {
                    gameOver = true
                    enabled = false
                    finalResults()
                }
                if (strChain > 1)
                    breakTurns = 3
                strChain = 0
                strPerfect = 0
                strandBreak.play()
            }

            if (!rowId.error1)
                polyGain += 1
            if (!rowId.error2)
                polyGain += 1

            rowId.rowFlash()

            levelScore += scoreGain
            gameScore += scoreGain
            interFace.polyPlus(polyGain)

            if (levelScore >= scoreLevel) {
                var scoreLeft = levelScore - scoreLevel
                levelScore = scoreLeft
                gameLevel += 1
                scoreLevel = scoreLevel + gameLevel * 5
            }

        }

        interFace.goalFlash()

        if (dmgGain)
            envDmg += 0.2

        turnCount += 1

        if (turnCount >= stageLength) {
            gameScore += bestChain + bestPerfect + (gameLevel * 5)
            finalResults()
        }

    }

    function polyWarn() {
        interFace.polyWarn()
    }

    function polyPlus(num) {
        interFace.polyPlus(num)
    } //Close function.

    function addFloat(row) {

        var floatCopy = floatBits
        var gridCopy = floatGrid

        var iter = 0
        var floatCheck = false

        while (!floatCheck) {
            var floatRow = row + Math.floor(Math.random() * 5) - 2// - turnCount
            if (floatRow < turnBuffer + floatBuffer + 1)
                floatRow = turnBuffer + floatBuffer + 1
            if (floatRow >= stageWindow + turnBuffer)
                floatRow = stageWindow + turnBuffer - 1
            var col = Math.floor(Math.random() * 2)
            var index = floatRow * 2 + col
            if (gridCopy[index] === false) {
                var bitProps = {
                    x: col * bitSize,
                    y: height - floatRow * bitSize,
                    z: 100,
                    col: col,
                    row: floatRow
                } //Close bitProps. (Complete)
                var bitId = gameEntities.createEntityFromUrlWithProperties(
                            Qt.resolvedUrl("FloatBit.qml"), bitProps)
                var floatId = gameEntities.getEntityById(bitId)

                var floatIndex = floatCopy.length
                floatCopy[floatIndex] = floatId
                floatId.floatIndex = floatIndex
                floatId.pop()
                floatId.flash()
                gridCopy[index] = true

                floatCheck = true
            }
            iter += 1
            if (iter >= 10)
                break
        }

        floatBits = floatCopy
        floatGrid = gridCopy
    }

    function finalResults() {
        bgMusic.stop()
        interFace.enabled = false
        finalTimer.start()
    }

} //Close Scene 'gameScene' (Working)
