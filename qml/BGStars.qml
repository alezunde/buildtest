import QtQuick 2.0
import Felgo 3.0

//A field of stars that slowly spins. (Complete)
Image {
    id: bgStars

    //Center in and fill the parent. (Complete)
    anchors.fill: parent
    //Clip any outside graphical elements. (Complete)
    clip: true

    Image {
        id: starField

        //Make the starfield just large enough so that there are no
        // blank areas that appear in the corners of the parent as it spins.
        //This method calculates the diagonal of the parent, setting that as the diameter of the circle.
        width: Math.sqrt(parent.width * parent.width + parent.height * parent.height)
        height: width

        //Center in the parent. (Complete)
        anchors.centerIn: parent

        //The source image.
        source: "../assets/gfx/bgStars.png"

        //The animation of the rotation of the stars. (Complete)
        NumberAnimation {
            id: starSpin
            target: starField
            property: "rotation"
            duration: 1000 * 180 //Three minutes.
            from: 0
            to: 360
            loops: Animation.Infinite
            running: true
        } //Close Timer 'starSpin'. (Complete)

    } //Close Image 'starField'. (Complete)

} //Close Item 'bgStars'. (Complete)
