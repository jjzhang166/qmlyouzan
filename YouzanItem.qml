import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

Item{
    property string zanId: "ZB2129102102910290"
    property string zanorders: "校园小二的收款 数量：1 单价：300.0元 "
    property string zanordersContent: "\n应付：300 \n\n订单创建时间:2016年04月09日21:49:12"
    property string zantrade: "\n付款类型:微信支付"

    signal signalClicked();
    Rectangle {
           id: background
           anchors.fill: parent
           color: "white"
       }
       RectangularGlow {
           id: effect
           anchors.fill: rect
           glowRadius: 4
           spread: 0.2
           color: "black"
           cornerRadius: rect.radius + glowRadius
       }
    Rectangle {
        id:rect
        width: parent.width-140
        height: parent.height-20
        border.width: 0
        border.color: "grey"
        anchors.centerIn: parent
        radius: 2
        Rectangle{
            id: tid
            width: parent.width-2
            height: 30
            anchors.top: parent.top
            anchors.topMargin: 1
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#A0DDF2"
            Text {
                text: zanId
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
        }
        Rectangle{
            width: parent.width-2
            height: parent.height-80
            anchors.top: tid.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: name3.top
            border.color: "white"
            TextEdit {
                id: name2
                anchors.fill: parent
                readOnly: true
                textFormat: TextEdit.RichText
                text: zanorders+"<br><br>"+zanordersContent+"<br><br>"+zantrade
            }
        }
        Button {
            id: name3
            text: "打  印"
            width: 100
            height: 30
            style: ButtonStyle {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 25
                    border.width: control.activeFocus ? 2 : 1
                    border.color: "#888"
                    radius: 0
                    color: "#12AADF"
                }
            }
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                signalClicked();
            }
        }
    }

    function gethtmlcontents(){
        console.log("text is "+name2.text)
        return name2.text;
    }
}

