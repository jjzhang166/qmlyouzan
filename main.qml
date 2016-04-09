import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("有赞API测试----亲爱的厦门ViVi美女")
    width: 500
    height: 480
    visible: true

    //顶部的标题栏
    Rectangle{
        id: tid
        width: parent.width
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#12AADF"
        z:10
        Text {
            text: "新订单"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
    }
    //中间的列表
    YouZanApi{
        id:yz
        anchors.top: tid.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }
    //左边的批量打印按钮
    Rectangle{
        id:prinfBtn
        width: 80
        height: 40
        radius: 20
        anchors.left: parent.left
        anchors.margins: 10
        anchors.verticalCenter: parent.verticalCenter
        color: "#12AADF"
        border.width: 1
        border.color: "grey"
        MouseArea{
            id:ma2
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                refreshBtn.color = "#12aacc";
            }
            onExited: {
                refreshBtn.color = "#12AADF";
            }
            onClicked: {

            }
        }

        Text {
            text: "批量打印"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 18
        }
    }
    //右侧的刷新按钮
    Rectangle{
        id:refreshBtn
        width: 80
        height: 80
        radius: 40
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        color: "#12AADF"
        border.width: 1
        border.color: "grey"
        MouseArea{
            id:ma
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                refreshBtn.color = "#12aacc";
            }
            onExited: {
                refreshBtn.color = "#12AADF";
            }
            onClicked: {

            }
        }

        Text {
            text: "刷新订单"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 18
        }
    }
}
