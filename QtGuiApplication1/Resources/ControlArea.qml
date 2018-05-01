import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

Item {
    id:playerControlArea
    height: 50
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            if(isMaxStatus == 0)
                return
            playerControlArea.visible = "true"
            console.log("into playerControlArea")
        }
        onExited: {
            if(isMaxStatus == 0)
                return
            playerControlArea.visible = ""
            console.log("out playerControlArea")
        }
    }
    //进度条
    Rectangle{
        id:control
        color:"#80202020"
        border.color: "gray"
        border.width: 1
        width:myPlayer.width
        height: 20
        Row{
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            anchors.left: parent.left
            //调节播放速度
            Slider{
                id:playPos
                width: myPlayer.width
                height: 10
                maximumValue: player.duration
                minimumValue: 0
                value:player.position
                anchors.verticalCenter: parent.verticalCenter
                stepSize:1000
                style: SliderStyle {
                    groove: Rectangle {
                        width: myPlayer.width
                        height: 8
                        color: "white"
                        radius: 2
                        Rectangle {
                            id:sliderRect
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            //进度条进展
                            width: player.duration>0?parent.width*player.position/player.duration:0
                            color: "blue"
                        }
                    }
                    //进度条圆点浮标定制
                    handle: Rectangle {
                        anchors.centerIn: parent
                        color: control.pressed ? "white" : "yellow"
                        border.color: "gray"
                        border.width: 2
                        implicitWidth: 15
                        implicitHeight: 15
                        radius:7.5
                        Rectangle{
                            width: parent.width-8
                            height: width
                            radius: width/2
                            color: "blue"
                            anchors.centerIn: parent
                        }
                    }
                }
                //点击鼠标设置播放位置
                MouseArea {
                    property int pos
                    anchors.fill: parent
                    onClicked: {
                        if (player.seekable)
                            pos = player.duration * mouse.x/parent.width
                        player.seek(pos)
                    }
                }
            }

        }
    }
    //控制区域
    Rectangle{
        id:bottom
        color:"#80202020"
        border.color: "gray"
        border.width: 1
        width: myPlayer.width
        height: 30
        Row{
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: 10
            Button{
                id:playOrpauseButton
                width: 60
                height: 30
                text: "Start"
                property int status: 1  //默认播放
                //iconSource: "./Images/pause.png"
                onClicked: {
                    if (player.seekable){
                        if(status===1)
                        {
                            player.pause();
                            tooltip="Start";
                            //console.log("start")
                            playOrpauseButton.text = "Start"
                            status=0;
                            //iconSource="./Images/play.png"
                        }
                        else{
                            player.play() ;
                            tooltip="Pause";
                            //console.log("pause")
                            playOrpauseButton.text = "Pause"
                            status=1;
                            //iconSource="./Images/pause.png"
                        }
                        var pos = player.position
                        player.seek(pos)
                    }
                }
            }
            Button{
                width: 60
                height: 30
                onClicked:
                {
                    player.stop()
                    player.seek(0)
                    playOrpauseButton.status = 0
                    playOrpauseButton.text = "Start"
                }
                text:"Stop"
                tooltip: "Stop"
                //iconSource: "./Images/stop.png"
            }
            //快进快退10s
            Button{
                width: 60
                height: 30
                text: "Back"
                onClicked: {
                    if (player.seekable){
                    var pos = player.position-10000
                    player.seek(pos)
                    }
                }
                tooltip: "Back"
                //iconSource: "./Images/back.png"
            }
            Button{
                width: 60
                height: 30
                text: "Forward"
                onClicked: {
                    if (player.seekable){
                    var pos = player.position+10000
                    player.seek(pos)
                    }
                }
                tooltip: "Forward"
                //iconSource: "./Images/pass.png"
            }
            Button{
                width: 60
                height: 30
                tooltip: "Open"
                text: "Open"
                onClicked: fd.open()
                //iconSource: "./Images/add.png"
                FileDialog{
                    id:fd
                    nameFilters: ["Vedio Files(*.avi *.mp4 *rmvb *.rm)"]  //格式过滤
                    selectMultiple: false
                }
            }
        }
        Row{
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            spacing: 10
            Text{
                id:movieTimeText
                anchors.verticalCenter: parent.verticalCenter
                text:parent.currentTime(player.position)+"/"+parent.currentTime(player.duration)
                color: "white"
            }
            //调节音量
            Slider{
                id:voice
                width: myPlayer.width*0.2
                height: 10
                value:0.5
                stepSize: 0.01
                maximumValue: 1
                minimumValue: 0
                anchors.verticalCenter: parent.verticalCenter
                style: SliderStyle {
                    groove: Rectangle {
                        implicitWidth: myPlayer.width*0.2
                        implicitHeight: 8
                        color: "white"
                        radius: 2
                        Rectangle {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: player.volume>0?parent.width*player.volume:0
                            color: "blue"
                        }
                    }
                    handle: Rectangle {
                        anchors.centerIn: parent
                        color: control.pressed ? "white" : "darkgray"
                        border.color: "gray"
                        border.width: 2
                        implicitWidth: 15
                        implicitHeight: 15
                        radius:7.5
                        Rectangle{
                            width: parent.width-8
                            height: width
                            radius: width/2
                            color: "blue"
                            anchors.centerIn: parent
                        }
                    }
                }
            }
            //时间格式化
            function currentTime(time)
            {
                var sec= Math.floor(time/1000);
                var hours=Math.floor(sec/3600);
                var minutes=Math.floor((sec-hours*3600)/60);
                var seconds=sec-hours*3600-minutes*60;
                var hh,mm,ss;
                if(hours.toString().length<2)
                    hh="0"+hours.toString();
                else
                    hh=hours.toString();
                if(minutes.toString().length<2)
                    mm="0"+minutes.toString();
                else
                    mm=minutes.toString();
                if(seconds.toString().length<2)
                    ss="0"+seconds.toString();
                else
                    ss=seconds.toString();
                return hh+":"+mm+":"+ss
            }
        }
    }
}
