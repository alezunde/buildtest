import Felgo 3.0
import QtQuick 2.0

//The GameWindow 'gameWindow' determines the screen size, contains the playable area,
// and defines the EntityManager: gameEntities. It also loads the game fonts.
//(Complete)
GameWindow {
    id: gameWindow

    screenWidth: 640
    screenHeight: 960

    activeScene: gameScene

    //Define the entity manager for the playable game area,
    // making sure that it is linked to the active Scene. (Complete)
    EntityManager {
        id: gameEntities
        entityContainer: gameScene
//        poolingEnabled: true
    } //Close EntityManager 'dnaEntities'. (Complete)

    //FontLoader 'gameFont': Load the default font for the game and interface elements. (Complete)
    FontLoader {
        id: gameFont
        source: "../assets/fonts/r_fallouty.ttf"
    } //Close FontLoader 'gameFont'. (Complete)

    //FontLoader 'chatFont': Load the font for readable text blocks. (Complete)
    FontLoader {
        id: chatFont
        source: "../assets/fonts/arial-rounded-mt-bold.ttf"
    } //Close FontLoader 'chatFont'. (Complete)

    SoundEffect {
        id: bitClick1
        source: "../assets/sfx/582902__ironcross32__snap-click-05.wav"
        volume: 0.5
    } //Close SoundEffect 'bitClick1'.

    //Scene 'gameScene': This creates the playable area,
    // and determines the logical size of the game. (Complete)
    GameScene {
        id: gameScene

        width: 320
        height: 480

        anchors.centerIn: gameWindow.gameWindowAnchorItem

    } //Close Scene 'gameScene'. (Complete)

} //Close GameWindow 'gameWindow'. (Complete)
