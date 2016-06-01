import QtQuick 2.6
import QtQuick.Controls 1.5

// Comment out
import QtMultimedia 5.6

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Poor Man's Snapchat")

    property int xpos
    property int ypos

    Rectangle
    {
        id: big_wrapper
        anchors.fill: parent
        Camera{
            id: front_facing
        }

        VideoOutput{
            id: video
            source: front_facing
            anchors.fill: parent
            focus: visible
        }

        Image
        {
            id: img_crayon
            source: "../../img/crayon.png"
            height: 50
            width: 50
            opacity: 1
            anchors.right: big_wrapper.right
            anchors.rightMargin: 20
            z: 4

            MouseArea
            {
                id: ma_mousearea_crayon
                anchors.fill: parent

                onPressed:
                {
                    img_crayon.opacity = 0.2
                }

                onReleased:
                {
                    img_crayon.opacity = 1
                }

                preventStealing: false
            }
        }
        TextInput{
            id: textinput
            text: "Enter Text Here"
            visible: false
            color: canvas_canvas.colors
            font.pointSize: 25
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            z:5
            focus: textinput.visible
        }

        Image
        {
            id: img_text
            source: "../../img/text.png"
            height: 50
            width: 50
            opacity: 1
            anchors.right: img_crayon.left
            anchors.rightMargin: 20
            z: 4

            MouseArea
            {
                id: ma_mousearea_text
                anchors.fill: parent

                onPressed:
                {
                    textinput.visible = !textinput.visible
                    img_text.opacity = 0.2
                }

                onReleased:
                {
                    img_text.opacity = 1
                }

                preventStealing: false
            }
        }

        Image
        {
            id: img_pen
            source: "../../img/pen.png"
            height: 50
            width: 50
            opacity: 1
            anchors.right: img_text.left
            anchors.rightMargin: 20
            z: 4

            MouseArea
            {
                id: ma_mousearea_pen
                anchors.fill: parent

                onPressed:
                {
                    canvas_canvas.draw = !canvas_canvas.draw
                    img_pen.opacity = 0.2
                }

                onReleased:
                {
                    img_pen.opacity = 1
                }

                preventStealing: false
            }
        }

        Canvas
        {
            property bool draw: false
            property string colors: "blue"
            id: canvas_canvas
            anchors.fill: parent
            z: 3
            onPaint:{
                if(draw === true){
                    var cxt = getContext("2d");
                    cxt.fillStyle = colors;
                    cxt.lineCap = "round"
                    cxt.fillRect(xpos-1, ypos-1, 25, 25)
                }
            }

            MouseArea{
                anchors.fill: parent
                onPressed: {
                    xpos = mouseX
                    ypos = mouseY
                    canvas_canvas.requestPaint()
                }
                onMouseXChanged: {
                    xpos = mouseX
                    ypos = mouseY
                    canvas_canvas.requestPaint()
                }
                onMouseYChanged: {
                    xpos = mouseX
                    ypos = mouseY
                    canvas_canvas.requestPaint()
                }
            }
        }

        Image
        {
            id: img_camera
            source: "../../img/camera.png"
            height: 50
            width: 50
            opacity: 1

            z:5

            anchors.horizontalCenter: big_wrapper.horizontalCenter
            anchors.bottom: big_wrapper.bottom
            anchors.bottomMargin: 60

            MouseArea
            {
                id: ma_mousearea
                anchors.fill: parent

                onPressed:
                {
                    img_camera.opacity = 0.2
                    front_facing.imageCapture.capture()
                }

                onReleased:
                {
                    img_camera.opacity = 1
                    se_shutter_camera.play()
                }

                preventStealing: false
            }
        }


        Audio
        {
            id: se_shutter_camera
            source: "../../sound_effects/shutter_camera.mp3"
        }
    }

}
