import QtQuick 2.0
import QtMultimedia 5.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import an.qt.Demos 1.0



Window{
    id:myPlayer
    width: 1024
    height: 650
    x:settings.x
    y:settings.y
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    property int isMaxStatus : 0 //存储窗口是否最大化
    property int status: 1  //默认播放(播放状态)
    property int langrageSize: 15 //配置窗体checkbox控件相关参数


    //蒙层
    Mask{
        id: mainWinMask
        visible: false
    }

    //config窗体
    ConfigWindow {
        id: cfgWin
        width: 400; height: 250
        x: myPlayer.x + 300; y:myPlayer.y + 150;
        opacity: 1
        visible: false;
        //常规设置选择分页
        Button{
            id:baseConfigTab
            anchors.top:parent.top
            anchors.topMargin: 25
            anchors.left: parent.left
            width: 50
            height:(parent.height - 25) / 2
            Rectangle{
                id:baseTabRec
                width: parent.width
                height:parent.height
                color:"lightblue"
                border.color:"white"
                Text {
                    text: qsTr("常规" + '\n' + "设置")
                    anchors.centerIn: parent
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        baseTabRec.state = 'clicked'
                        baseTabCfgColumn.visible = "true"
                        otherTabRec.state = ''
                        otherTabRec.border.width = 1
                        otherTabRec.color = "lightblue"

                        otherTabCfgColumn.visible = ""
                        //le.log("MouseClicked-baseTabRec-onclicked");
                    }
                    onEntered: {
                        if(baseTabRec.state == 'clicked')
                            return;
                        baseTabRec.border.width = 2
                        baseTabRec.color = "#7B7B7B"
                    }
                    onExited: {
                        if(baseTabRec.state == 'clicked')
                            return;
                        baseTabRec.border.width = 1
                        baseTabRec.color = "lightblue"
                    }
                }
                states:[
                    State{
                        name:'clicked'
                        PropertyChanges {
                            target: baseTabRec
                            color:"#7B7B7B"
                        }
                    }
                ]
            }
        }
        //其他设置选择分页
        Button{
            id:otherConfigTab
            anchors.top:parent.top
            anchors.topMargin: 24 + (parent.height - 25) / 2
            anchors.left:parent.left
            width: 50
            height:(parent.height - 25) / 2
            Rectangle{
                id:otherTabRec
                width: parent.width
                height:parent.height
                color:"lightblue"
                border.color:"white"
                Text {
                    text: qsTr("其他" + '\n' + "设置")
                    anchors.centerIn: parent
                    font.pixelSize: 15
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        otherTabRec.state = 'clicked'
                        baseTabCfgColumn.visible = ""
                        baseTabRec.state = ''
                        baseTabRec.border.width = 1
                        baseTabRec.color = "lightblue"

                        otherTabCfgColumn.visible = "true"
                        //console.log("MouseClicked-otherTabRec-onclicked + " + baseTabCfgColumn.visible);
                    }
                    onEntered: {
                       // console.log("MouseClicked-otherTabRec-onEntered")
                        if(otherTabRec.state == 'clicked')
                            return;
                        otherTabRec.border.width = 2
                        otherTabRec.color = "#7B7B7B"
                    }
                    onExited: {
                        if(otherTabRec.state == 'clicked')
                            return;
                        otherTabRec.border.width = 1
                        otherTabRec.color = "lightblue"
                    }
                }
                states:[
                    State{
                        name:'clicked'
                        PropertyChanges {
                            target: otherTabRec
                            color:"#7B7B7B"
                            border.width: 2
                        }
                    }
                ]
            }
        }
        //常规设置面板
        Column{
            id:baseTabCfgColumn
            anchors.top:parent.top
            anchors.topMargin: 35 + 70
            anchors.left: parent.left
            anchors.leftMargin: 20 + 50 + 30
            width: parent.width
            height: parent.height - 35
            //anchors.verticalCenter: parent
            //anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Row{
                spacing: 20
                CheckBox{
                    id:cb_SavePos
                    checked: settings.isSavePosChecked
                    style:CheckBoxStyle{
                        indicator:Rectangle{//复选框外圈
                            implicitHeight:langrageSize
                            implicitWidth:langrageSize
                            //radius:langrageSize
                            border.width: (control.hovered || control.pressed) ? 2 : 1
                            border.color:(control.hovered || control.pressed) ? "#7B7B7B" : "white"
                            Rectangle{//是否Check的内圈Rec显示
                                visible: settings.isSavePosChecked
                                color: "#555"
                                border.color: "#333"
                                anchors.margins: 1.8
                                anchors.fill: parent

                            }

                        }
                        label: Label{
                            text:"保存窗口位置"
                            font.bold:true
                        }
                    }
                    onClicked: {
                        if(settings.isSavePosChecked)
                            settings.isSavePosChecked = false
                        else
                            settings.isSavePosChecked = true
                    }

                }
                CheckBox{
                    id:cb_saveSize
                    checked: settings.isSaveSizeChecked
                    style:CheckBoxStyle{
                        indicator:Rectangle{//复选框外圈
                            implicitHeight:langrageSize
                            implicitWidth:langrageSize
                            //radius:langrageSize
                            border.width: (control.hovered || control.pressed) ? 2 : 1
                            border.color:(control.hovered || control.pressed) ? "#7B7B7B" : "white"
                            Rectangle{//是否Check的内圈Rec显示
                                visible: settings.isSaveSizeChecked
                                color: "#555"
                                border.color: "#333"
                                anchors.margins: 1.8
                                anchors.fill: parent

                            }

                        }
                        label: Label{
                            text:"保存窗口大小"
                            font.bold:true
                        }
                    }
                    onClicked: {
                        if(settings.isSaveSizeChecked)
                            settings.isSaveSizeChecked = false
                        else
                            settings.isSaveSizeChecked = true
                    }

                }
            }
            Row{
                spacing: 20
                CheckBox{
                    id:cb_saveProgress
                    checked: settings.isSaveProgressChecked
                    style:CheckBoxStyle{
                        indicator:Rectangle{//复选框外圈
                            implicitHeight:langrageSize
                            implicitWidth:langrageSize
                            //radius:langrageSize
                            border.width: (control.hovered || control.pressed) ? 2 : 1
                            border.color:(control.hovered || control.pressed) ? "#7B7B7B" : "white"
                            Rectangle{//是否Check的内圈Rec显示
                                visible: settings.isSaveProgressChecked
                                color: "#555"
                                border.color: "#333"
                                anchors.margins: 1.8
                                anchors.fill: parent

                            }

                        }
                        label: Label{
                            text:"记忆播放进度"
                            font.bold:true
                        }
                    }
                    onClicked: {
                        if(settings.isSaveProgressChecked)
                            settings.isSaveProgressChecked = false
                        else
                            settings.isSaveProgressChecked = true
                    }

                }
                CheckBox{
                    id:cb_clearList
                    checked: settings.isSaveClearListChecked
                    style:CheckBoxStyle{
                        indicator:Rectangle{//复选框外圈
                            implicitHeight:langrageSize
                            implicitWidth:langrageSize
                            //radius:langrageSize
                            border.width: (control.hovered || control.pressed) ? 2 : 1
                            border.color:(control.hovered || control.pressed) ? "#7B7B7B" : "white"
                            Rectangle{//是否Check的内圈Rec显示
                                visible: settings.isSaveClearListChecked
                                color: "#555"
                                border.color: "#333"
                                anchors.margins: 1.8
                                anchors.fill: parent

                            }

                        }
                        label: Label{
                            text:"清空播放列表"
                            font.bold:true
                        }
                    }
                    onClicked: {
                        if(settings.isSaveClearListChecked)
                            settings.isSaveClearListChecked = false
                        else
                            settings.isSaveClearListChecked = true
                    }

                }
            }
            TextInput{
                id:textInput
                text:settings.input
                selectByMouse:true
            }

        }
        //其他设置面板
        Rectangle{
            id:otherTabCfgColumn
            anchors.top:parent.top
            anchors.topMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 50
            width: parent.width - 50
            height: parent.height - 25
            visible:false
            color:"lightblue"
            //anchors.verticalCenter: parent
            //anchors.horizontalCenter: parent.horizontalCenter
            Button{
                id:cPlusPlusConnectionButton
                width: 150
                height: 50
                anchors.centerIn: parent
                style:ButtonStyle{
                    background:Rectangle{
                        id:connectionBtnRec
                        border.width: (control.hovered || control.pressed) ? 2 : 1
                        border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                        color: "#7B7B7B"
                        Text {
                            id: connBtnName
                            text: qsTr("C++ Connectioning...")
                            anchors.centerIn: parent
                            font.bold: true
                            color: "black"
                        }
                    }
                }
                onClicked: {
                    console.log(qmlDemo.demoPrint());
                }
            }
            //C++交互 - Demo类
            QmlDemo{
                id:qmlDemo

            }

        }
        //配置信息
        Settings{
            id:settings
            //配置说明信息
            property string input: "----this is myPlayer Config----"

            //窗口位置信息----初始化为屏幕中点，差量为程序窗体的一半
            property double x : Screen.width/2 - myPlayer.width/2
            property double y : Screen.height/2 - myPlayer.height/2
            property bool isSavePosChecked : false
            property bool isSaveSizeChecked: false
            property bool isSaveProgressChecked: false
            property bool isSaveClearListChecked: false

        }

        Component.onDestruction: {
            settings.input = textInput.text;
            if(cb_SavePos.checked){
                settings.x = myPlayer.x
                settings.y = myPlayer.y
            }
            //保存各个CheckBox的状态
            settings.isSavePosChecked = cb_SavePos.checked
            settings.isSaveClearListChecked = cb_clearList.checked
            settings.isSaveProgressChecked = cb_saveProgress.checked
            settings.isSaveSizeChecked = cb_saveSize.checked
            console.log("ondestructioning|x:" + settings.x + "y:" + settings.y);
        }

    }
    //获取正在播放的视频文件名称
    function getVedioName(str)
    {
        //console.log("into getVideoName function");
        var url=fd.fileUrl.toString();
        var strList=new Array();
        strList=url.split("/");
        var name=strList[strList.length-1];
        return name;
    }

    //标题栏区域
    Rectangle {
            id: mainTitle                       //创建标题栏
            anchors.top: parent.top             //对标题栏定位
            anchors.left: parent.left
            anchors.right: parent.right
            height: 25                          //设置标题栏高度
            color: "#7B7B7B"                    //设置标题栏背景颜色
            z:20
            MouseArea { //为窗口添加鼠标事件
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton //只处理鼠标左键
                property point clickPos: "0,0"
                onPressed: { //接收鼠标按下事件
                        clickPos  = Qt.point(mouse.x,mouse.y)
                }
                onPositionChanged: { //鼠标按下后改变位置
                        //鼠标偏移量
                        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)

                        //如果mainwindow继承自QWidget,用setPos
                        myPlayer.setX(myPlayer.x+delta.x)
                        myPlayer.setY(myPlayer.y+delta.y)
                }
            }
            Row{
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                //窗口图片
                Image{
                    source: "qrc:/myPlayerIcon.ico"
                    sourceSize.width: 30
                    sourceSize.height: 25
                }
                //窗口标题
                Text{
                    anchors.top:parent.top
                    anchors.topMargin: 4
                    text: getVedioName(fd.fileUrl.toString()) ? "MyPlayer   Playing:" + getVedioName(fd.fileUrl.toString()) : "MyPlayer"
                    color:"white"
                    font.bold: true
                    font.pixelSize: 15
                }
            }
            Row{
                anchors.right: parent.right
                anchors.top:parent.top
                width:170
                height: 25

                //设置
                Button{
                    id:cfgButton
                    width: 50
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            Text {
                                id: cfgButtonTxt
                                text: qsTr("Config")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {
                        mainWinMask.visible = true;
                        //animationType: ["fade", "width", "height", "size", "flyDown", "flyUp", "flyLeft", "flyRight"]
                        cfgWin.animationType = "fade";
                        cfgWin.show();

                    }
                }

                //最小化
                Button{
                    id:minButton
                    width: 40
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            Text {
                                id: minButtonTxt
                                text: qsTr("Min")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {
                          myPlayer.visibility = Window.Minimized
                    }
                }
                //最大化
                Button{
                    id:maxButton
                    width: 40
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "white" : "#7B7B7B"
                            Text {
                                id: maxButtonTxt
                                text: qsTr("Max")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {

                        if(isMaxStatus == 0){
                            myPlayer.visibility = Window.Maximized
                            isMaxStatus = 1;
                            //隐藏下方控制区域
                            playerControlArea.visible = null
                            //隐藏标题栏
                            mainTitle.visible = ""
                            //焦点
                            screen.focus = true
                        }else{
                            myPlayer.visibility = Window.Windowed
                            isMaxStatus = 0;
                            //显示下方控制区域
                            playerControlArea.visible = "true"
                            //显示标题栏
                            mainTitle.visible = "true"
                            //焦点失去
                            screen.focus = false
                        }
                    }
                }
                //退出
                Button{
                    id:quitButton
                    width: 40
                    height: 25
                    style:ButtonStyle{
                        background: Rectangle{
                            border.width: control.hovered ? 2 : 1
                            border.color: (control.hovered || control.pressed) ? "red" : "#7B7B7B"
                            color: (control.hovered || control.pressed) ? "red" : "#7B7B7B"
                            Text {
                                id: quitButtonTxt
                                text: qsTr("Quit")
                                anchors.centerIn: parent
                                color: "black"
                            }
                        }
                    }
                    onClicked: {
                        fd.close();
                        Qt.quit();
                    }
                }
            }
    }
    //主窗体区域
    Rectangle{
        id:screen
        color:"black"
        anchors.top:parent.top
        anchors.left: parent.left
        width:myPlayer.width
        height: myPlayer.height
        Keys.enabled: true
        focus: true
        z:10
        //推出全屏按键响应
        Keys.onEscapePressed: {

            //恢复标题栏
            mainTitle.visible = "true"
            //恢复控制区域
            playerControlArea.visible = "true"
            //焦点消失
            screen.focus = false
            //窗口模式
            myPlayer.visibility = Window.Windowed
            isMaxStatus = 0

        }

        Keys.onPressed: {
            switch(event.key)
            {
                case Qt.Key_Left: if (player.seekable){player.seek(player.position - 10000);}break;
                case Qt.Key_Right: if (player.seekable){player.seek(player.position + 10000);}break;
                case Qt.Key_Space:
                    if (player.seekable){
                        if(status===1)
                        {
                            player.pause();
                            playOrpauseButton.tooltip="Start";
                            playOrpauseButton.text = "Start"
                            status=0;
                        }
                        else{
                            player.play() ;
                            playOrpauseButton.tooltip="Pause";
                            playOrpauseButton.text = "Pause"
                            status=1
                        }
                        var pos = player.position
                        player.seek(pos)
                    }
                    break;
                default:
            }

        }

        MouseArea{
            //控制区域鼠标响应事件
            id:controlAreaMouseArea
            x:0
            anchors.bottom: parent.bottom
            width: parent.width
            height: 80
            hoverEnabled: true
            onEntered: {
                //console.log("into playerControlArea -- screen")
                if(isMaxStatus == 0)
                    return
                if(playerControlArea.visible)
                    return
                else playerControlArea.visible = "true"
                screen.focus = true
            }
            onExited: {
                //console.log("out playerControlArea -- screen")
                if(isMaxStatus == 0)
                    return
                if(playerControlArea.visible === "")
                    return
                else playerControlArea.visible = ""
                screen.focus = true
            }

        }
        MouseArea { //为窗口添加鼠标事件
            id: mouseRegion
            anchors.fill: parent;
            acceptedButtons: Qt.LeftButton | Qt.RightButton // 激活右键（别落下这个）
            onClicked: {
                if (mouse.button === Qt.RightButton) { // 右键菜单
                            //
                    contentMenu.popup()
                 }else if(mouse.button === Qt.LeftButton){ //左键单击 播放/暂停
                    if (player.seekable){
                        if(status===1)
                        {
                            player.pause();
                            //playOrpauseButton.tooltip="Start";
                            //console.log("start")
                            startBtnName.text = "Start"
                            status=0;
                            //iconSource="./Images/play.png"
                        }
                        else{
                            player.play() ;
                            //playOrpauseButton.tooltip="Pause";
                            //console.log("pause")
                            startBtnName.text = "Pause"
                            status=1;
                            //iconSource="./Images/pause.png"
                        }
                        var pos = player.position
                        player.seek(pos)
                    }
                }
            }
        }
        Menu { // 播放器右键菜单
            //title: "Edit"
            id: contentMenu

            MenuItem {
                text: "PreserveAspectFit"
                shortcut: "Ctrl+X"
                onTriggered: {
                    videoFillMode.fillMode = Image.PreserveAspectFit
                }
            }
            MenuItem {
                text: "PreserveAspectCrop"
                shortcut: "Ctrl+X"
                onTriggered: {
                    videoFillMode.fillMode = Image.PreserveAspectCrop
                }
            }
            MenuItem {
                text: "Tile"
                shortcut: "Ctrl+X"
                onTriggered: {
                    videoFillMode.fillMode = Image.Tile
                }
            }
            MenuItem {
                text: "TileVertically"
                shortcut: "Ctrl+X"
                onTriggered: {
                    videoFillMode.fillMode = Image.TileVertically
                }
            }
            MenuItem {
                text: "TileHorizontally"
                shortcut: "Ctrl+X"
                onTriggered: {
                    videoFillMode.fillMode = Image.TileHorizontally
                }
            }
        }
        //播放器初始背景图片
        Image{
            id:img
            source: ""
            anchors.fill: parent
        }
        /*播放器引擎---------------------------------------------------------------------------*/
        MediaPlayer{
            id:player
            source: fd.fileUrl
            //source:"http://www.iqiyi.com/w_19rtyw588t.html?src=sharemodclk131212"
            autoPlay: true
            volume: voice.value
        }
        VideoOutput {
            id:videoFillMode
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: player
        }
    }
    //播放器控制区域
    Column{
        id:playerControlArea
        z:20
        anchors.bottom: parent.bottom
        height: 50
        width: parent.width
        Rectangle{
            color: "#7B7B7B"
            x:0
            y:0
            width: parent.width
            height: parent.height
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
                y:20
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
                        height: 25
                        //iconSource: "./Images/pause.png"
                        Rectangle{
                            id:startBtnRec
                            anchors.fill: parent
                            MouseArea{
                                //控制区域鼠标响应事件
                                id:startBtnMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    startBtnRec.border.width = 2;
                                    startBtnRec.border.color =  "red"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible)
                                        return
                                    else playerControlArea.visible = "true"
                                    screen.focus = true
                                }
                                onExited: {
                                    startBtnRec.border.width = 1;
                                    startBtnRec.border.color =  "#7B7B7B"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible === "")
                                        return
                                    else playerControlArea.visible = ""
                                    screen.focus = true
                                }
                                onClicked: {
                                    if (player.seekable){
                                        if(status===1)
                                        {
                                            player.pause();
                                            //playOrpauseButton.tooltip="Start";
                                            //console.log("start")
                                            startBtnName.text = "Start"
                                            status=0;
                                            //iconSource="./Images/play.png"
                                        }
                                        else{
                                            player.play() ;
                                            //playOrpauseButton.tooltip="Pause";
                                            //console.log("pause")
                                            startBtnName.text = "Pause"
                                            status=1;
                                            //iconSource="./Images/pause.png"
                                        }
                                        var pos = player.position
                                        player.seek(pos)
                                    }
                                }

                            }
                            Text {
                                id: startBtnName
                                text: qsTr("Start")
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }
                    }
                    Button{
                        id:stopBtn
                        width: 60
                        height: 25
                        Rectangle{
                            id:stopBtnRec
                            anchors.fill: parent
                            MouseArea{
                                //控制区域鼠标响应事件
                                id:stopBtnMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    stopBtnRec.border.width = 2;
                                    stopBtnRec.border.color =  "red"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible)
                                        return
                                    else playerControlArea.visible = "true"
                                    screen.focus = true
                                }
                                onExited: {
                                    stopBtnRec.border.width = 1;
                                    stopBtnRec.border.color =  "#7B7B7B"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible === "")
                                        return
                                    else playerControlArea.visible = ""
                                    screen.focus = true
                                }
                                onClicked:
                                {
                                    player.stop()
                                    player.seek(0)
                                    if(player.seekable){
                                        status = 0
                                        playOrpauseButton.text = "Start"
                                    }

                                }

                            }
                            Text {
                                id: name2
                                text: qsTr("Stop")
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }
                        //text:"Stop"
                        //tooltip: "Stop"
                        //iconSource: "./Images/stop.png"
                    }
                    //快进快退10s
                    Button{
                        id:backBtn
                        width: 60
                        height: 25
                        //text: "Back"
                        Rectangle{
                            id:backBtnRec
                            anchors.fill: parent
                            MouseArea{
                                //控制区域鼠标响应事件
                                id:backBtnMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    backBtnRec.border.width = 2;
                                    backBtnRec.border.color =  "red"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible)
                                        return
                                    else playerControlArea.visible = "true"
                                    screen.focus = true
                                }
                                onExited: {
                                    backBtnRec.border.width = 1;
                                    backBtnRec.border.color =  "#7B7B7B"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible === "")
                                        return
                                    else playerControlArea.visible = ""
                                    screen.focus = true
                                }
                                onClicked: {
                                    if (player.seekable){
                                        var pos = player.position-10000
                                        player.seek(pos)
                                    }
                                }

                            }
                            Text {
                                id: backBtnName
                                text: qsTr("Back")
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }
                        //tooltip: "Back"
                        //iconSource: "./Images/back.png"
                    }
                    Button{
                        id:forwardBtn
                        width: 60
                        height: 25
                        //text: "Forward"
                        Rectangle{
                            id:forwardBtnRec
                            anchors.fill: parent
                            MouseArea{
                                //控制区域鼠标响应事件
                                id:forwardBtnMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    forwardBtnRec.border.width = 2;
                                    forwardBtnRec.border.color =  "red"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible)
                                        return
                                    else playerControlArea.visible = "true"
                                    screen.focus = true
                                }
                                onExited: {
                                    forwardBtnRec.border.width = 1;
                                    forwardBtnRec.border.color =  "#7B7B7B"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible === "")
                                        return
                                    else playerControlArea.visible = ""
                                    screen.focus = true
                                }
                                onClicked: {
                                    if (player.seekable){
                                        var pos = player.position+10000
                                        player.seek(pos)
                                    }
                                }

                            }
                            Text {
                                id: forwardBtnName
                                text: qsTr("Forward")
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }
                        //tooltip: "Forward"
                        //iconSource: "./Images/pass.png"
                    }
                    Button{
                        id:openBtn
                        width: 60
                        height: 25
                        //tooltip: "Open"
                        //text: "Open"
                        Rectangle{
                            id:openBtnRec
                            anchors.fill: parent
                            MouseArea{
                                //控制区域鼠标响应事件
                                id:openBtnMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    openBtnRec.border.width = 2;
                                    openBtnRec.border.color =  "red"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible)
                                        return
                                    else playerControlArea.visible = "true"
                                    screen.focus = true
                                }
                                onExited: {
                                    openBtnRec.border.width = 1;
                                    openBtnRec.border.color =  "#7B7B7B"
                                    if(isMaxStatus == 0)
                                        return
                                    if(playerControlArea.visible === "")
                                        return
                                    else playerControlArea.visible = ""
                                    screen.focus = true
                                }
                                onClicked: fd.open()

                            }
                            Text {
                                id: openBtnName
                                text: qsTr("Open")
                                anchors.centerIn: parent
                                font.bold: true
                            }
                        }
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
                    //播放时间进度显示
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
    }

}




