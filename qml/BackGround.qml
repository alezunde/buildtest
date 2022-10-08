import QtQuick 2.0
import Felgo 3.0

//Item 'backGround' contains and animates the background visual elements.
//Here, values are relative to the logical scene size of 320 x 480px with an origin of 0, 0.
//(Complete)
Item {
    id: backGround

    anchors.fill: parent

    //There are some graphical elements that need to be clipped. (Complete)
    clip: true

    //The main static background image. (Complete)
    Image {
        id: bgImage

        width: parent.width
        height: parent.height
        anchors.bottom: parent.bottom

        //Call function bgSwitch(). (Complete)
        source: "../assets/gfx/bgSand.png" //bgSwitch()

    } //Close Image 'bgImage'. (Complete)

    //Add a tint of color to the background image. (Complete)
    Rectangle {
        id: bgTint

        anchors.fill: parent

        //Change the color of that background while swap mode is active. (Complete)
        color: {

//            if (swapMode)
//                return gameColors.iFaceDarkCol
//            else
                return gameColors.iFaceCol

        } //Cloee color.
        opacity: 0.6

    }//Close Rectangle 'bgTint'. (Complete)

    //BackGround gradient to fade the bottom half of the background to the background color. (Complete)
    Rectangle {
        id: topRect
        width: parent.width
        height: parent.height / 2
        anchors.top: parent.top
        gradient: Gradient {
            GradientStop { position: 0.0; color: "black"}
            GradientStop { position: 1.0; color: gameColors.iFaceBGCol}
        } //Close Gradient

    } //Close Rectangle 'bottomGrad'. (Complete)

    Rectangle {
        id: topGrad
        width: parent.width
        height: parent.height / 4
        anchors.top: topRect.bottom
        gradient: Gradient {
            GradientStop { position: 0.0; color: gameColors.iFaceBGCol}
            GradientStop { position: 1.0; color: "transparent"}
        } //Close Gradient

    }  //Close Rectangle 'topGrad'. (Complete)

    //Show the stars in the background. (Complete)
    BGStars { opacity: 0.8 }

    //Add some twinkles. (Complete)
    Item {
        id: bgTwinkles
        anchors.fill: parent
        BGTwinkle {} //1
        BGTwinkle {} //2
        BGTwinkle {} //3
        BGTwinkle {} //4
        BGTwinkle {} //5
        BGTwinkle {} //6
    } //Close item bgTwinkles. (Complete)

    //The animated bubble elements. (Complete)
    Item {
        id: bgBubbles
        anchors.fill: parent
        BGBubble {} //1
        BGBubble {} //2
        BGBubble {} //3
        BGBubble {} //4
        BGBubble {} //5
        BGBubble {} //6
        BGBubble {} //7
        BGBubble {} //8
    } //Close Item 'bgBubbles'. (Complete)

    //The black gradient at the top of the background area. (Complete)
    Rectangle {
        id: bgGradTop

        visible: false
        width: parent.width
        height: 64

        //The gradient goes from black (top), to transparent (bottom).(Complete)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "black"}
            GradientStop { position: 1.0; color: "transparent" }
        } //Close Gradient

    }  //Close Rectangle 'bgGradTop'. (Complete)

    //The black gradient at the bottom. (Complete)
    Rectangle {
        id: bgGradBot
        width: parent.width
        height: 64
        y: 496

        visible: false

        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent"}
            GradientStop { position: 1.0; color: "black" }
        } //Close Gradient

    }  //Close Rectangle 'bgGradBot'. (Complete)

    //Function bgSwitch() randomly chooses one of several backgrounds. (Complete)
    function bgSwitch() {

        //Generate a random number from 0 through 2. (Complete)
        var bg = Math.floor(Math.random() * 3)

        if (bg < 1) return "../assets/gfx/bg1.png"
        if (bg === 1) return "../assets/gfx/bg2.png"
        if (bg === 2) return "../assets/gfx/bg3.png"

    } //Close function bgSwitch(). (Complete)

} //Close Item 'backGround'. (Complete)
