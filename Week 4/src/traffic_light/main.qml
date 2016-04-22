import QtQuick 2.6
import QtQuick.Controls 1.5
import Qt.labs.settings 1.0
import QtQml 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Traffic Light")

    property int index: 0

    Rectangle
    {
        id: big_wrapper
        anchors.fill: parent
        Timer {
            id: red
            interval:2000; running: false; repeat: false;
            onTriggered: {
                rect_red_light.color = "red"
                rect_yellow_light.color = "black"
                green.start()
            }
        }
        Timer {
            id: yellow
            interval:2000; running: false; repeat: false;
            onTriggered: {
                rect_yellow_light.color = "yellow"
                rect_green_light.color = "black"
                red.start()
            }
        }
        Timer {
            id: green
            interval:2000; running: true; repeat: false;
            onTriggered: {
                rect_green_light.color = "green"
                rect_red_light.color = "black"
                yellow.start()
            }
        }
        Settings{
            property alias green_light: green.running
            property alias yellow_light: yellow.running
            property alias red_light: red.running
            property alias green_color: rect_green_light.color
            property alias yellow_color: rect_yellow_light.color
            property alias red_color: rect_red_light.color
        }

        Rectangle
        {
            id: rect_traffic_light_head
            anchors.horizontalCenter: big_wrapper.horizontalCenter
            anchors.verticalCenter: big_wrapper.verticalCenter

            height: parent.height * .9;
            width: parent.width/3;
            border.color: "brown"

            //transform: Scale{xScale: .3; yScale: .3}

            Rectangle
            {
                id: rect_red_light
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                height: 100;
                width: 100;
                radius: width/2;
                border.width: 10
                border.color: "black"
                color: "black"

            }

            Rectangle
            {
                id: rect_yellow_light
                anchors.top: rect_red_light.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                height: 100;
                width: 100;
                radius: width/2;
                border.width: 10
                border.color: "black"
                color: "black"
            }

            Rectangle
            {
                id: rect_green_light
                anchors.top: rect_yellow_light.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                height: 100;
                width: 100;
                radius: width/2;
                border.color: "black"
                border.width: 10
                color: "black"
            }
        }

    }
}
