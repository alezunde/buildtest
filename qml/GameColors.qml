import QtQuick 2.0
import Felgo 3.0

//A palette of colors used throughout the game.
//(Complete)
Item {
    id: gameColors

    property int themes: 5

    Component.onCompleted: reColor(theme)

    //Theme: Default - Titan.

    //--SPLASH SCREEN COLORS--\\

    //- 1 - The tint of the splash screen background image.
    property string splashBGCol: "#2C386A"
    //- 2 - The color of the splash screen text.
    property string splashTextCol: "#000000"
    //- 3 - The color of the splash screen button when highighted.
    property string splashHLCol: "#627CE6"
    //- 4 -The color of the splash screen highlight text.
    property string splashTextHLCol: "#FFFFFF"

    //--GAME INTERFACE COLORS--\\

    //- 7 - The color of the background haze.
    property var iFaceBGCol//: "#2C386A"
    //- 5 - The color of header drop shadow.
    property var iFaceDSCol//: "#000000"
    //- 4 - The color of the darker-colored elements.
    property var iFaceDarkCol//: "#264156"
    //- 1 - The color of header itself.
    property var iFaceCol//: "#466984"
    //- 2 - The color of the lighter-colored elements.
    property var iFaceLightCol//: "#88AFCE"
    //- 3 - The color of the lighter-colored elements.
    property var iFaceBrightCol//: "#BDE2FF"
    //- 6 - The color of the interface highlights.
    property var iFaceHLCol//: "#FFFFFF"

    function reColor(theme) {

        if (theme === 0) {
            //Theme: Enceladus (Default).
            themeTitle = "Enceladus"
            hdrSource = "../assets/gfx/hdrEnceladus.png"
            fnlSource = "../assets/gfx/totBG_enceladus.png"

            iFaceBGCol = "#1C424C"
            iFaceDSCol = "#0E1925"
            iFaceDarkCol = "#264156"
            iFaceCol = "#466984"
            iFaceLightCol = "#88AFCE"
            iFaceBrightCol = "#E7F1F9"
            iFaceHLCol = "#FFFFFF"

        } //EndIf: (theme === 0).

        if (theme === 1) {
            //Theme: Earth.
            themeTitle = "Earth"
            hdrSource = "../assets/gfx/hdrEarth.png"
            fnlSource = "../assets/gfx/totBG_earth.png"

            iFaceBGCol = "#096069"
            iFaceDSCol = "#481800"
            iFaceDarkCol = "#82421C"
            iFaceCol = "#5A9E36"
            iFaceLightCol = "#9DDA7C"
            iFaceBrightCol = "#E9F3FB"
            iFaceHLCol = "#FFFFFF"

        } //EndIf: (theme === 1).

        if (theme === 2) {
            //Theme: Mars.
            themeTitle = "Mars"
            hdrSource = "../assets/gfx/hdrMars.png"
            fnlSource = "../assets/gfx/totBG_mars.png"

            //--GAME INTERFACE COLORS--\\
            iFaceBGCol = "#6B2304" //1.
            iFaceDSCol = "#3A0000" //2.
            iFaceDarkCol = "#8C3A0F" //3.
            iFaceCol = "#B55725" //4.
            iFaceLightCol = "#DC7B47" //5.
            iFaceBrightCol = "#FFEACB" //6.
            iFaceHLCol = "#FFFFFF" //7.

        } //EndIf: (theme === 2).

        if (theme === 3) {
            //Theme: Atlantia.
            themeTitle = "Atlantia"
            hdrSource = "../assets/gfx/hdrAtlantia.png"
            fnlSource = "../assets/gfx/totBG_atlantia.png"

            //--GAME INTERFACE COLORS--\\
            iFaceBGCol = "#2D6A82" //1.
            iFaceDSCol = "#30173A" //2.
            iFaceDarkCol = "#396360" //3.
            iFaceCol = "#967F92" //4.
            iFaceLightCol = "#CDBED0" //5.
            iFaceBrightCol = "#F5FFD1" //6.
            iFaceHLCol = "#FFFFFF" //7.

        } //EndIf: (theme === 3).

        if (theme === 4) {
            //Theme: Luna.
            themeTitle = "Luna"
            hdrSource = "../assets/gfx/hdrLuna.png"
            fnlSource = "../assets/gfx/totBG_luna.png"

            //--GAME INTERFACE COLORS--\\
            iFaceBGCol = "#3D3C54"
            iFaceDSCol = "#111423"
            iFaceDarkCol = "#565656"
            iFaceCol = "#828282"
            iFaceLightCol = "#C5C5C5"
            iFaceBrightCol = "#FFECC9"
            iFaceHLCol = "#FFFFFF"

        } //EndIf: (theme === 4).

    } //Close function reColor(theme).

} //Close Item 'gameColors'. (Complete)
