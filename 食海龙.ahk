#Requires AutoHotkey v2.0

SetWorkingDir A_ScriptDir

; if !A_IsAdmin 
;     Run A_AhkPath " " A_ScriptFullPath

F12::
{
    MouseGetPos &xpos, &ypos
    color := PixelGetColor(xpos, ypos)
    A_Clipboard := "(" xpos "," ypos ")==" color ""
}
return


; CheckImage(imageFileName, &readyVar) {
;     global
;     if ImageSearch(&FoundX, &FoundY, 1100, 900, 2570, 2129, imageFileName)
;         readyVar := true
;     else
;         readyVar := false
;     return readyVar
; }


; checkLianhua() {
;     return CheckImage("img\莲花指.png", &lianhua_ready)
; }

; checkLiuxing() {
;     return CheckImage("img\流星.png", &lianhua_ready)
; }

CheckImage(left_top, right_low, imageFileName) {
    if ImageSearch(&FoundX, &FoundY, left_top[1], left_top[2], right_low[1], right_low[2], imageFileName) {
        return [FoundX, FoundY]
    }
    else {
        return false
    }
}

changeChannel(num)
{   
    SendInput "{Alt down}"
    ; position := CheckImage([2915, 23], [3025, 64], "*100 " "img\切换频道按钮.png")
    ; if not position {
    ;     position := CheckImage([2915, 23], [3025, 64], "*100 " "img\切换频道按钮亮.png")
    ;     if not position {
    ;         MsgBox "寻找频道按钮失败"
    ;         return
    ;     }
    ; }
    MouseMove(2948, 50)
    Click
    Sleep 200
    position := CheckImage([2772, 0], [3124, 489], "*10 " "img\食海龙\频道" num ".png")
    if position {
        MouseMove(position[1], position[2])
        Click   
        SendInput "y"
        SendInput "{Alt up}" 
        return
    }
    return
}

; getCurrentChannel() {
;     ImageSearch(&FoundX, &FoundY, 2012, 28, A_ScreenWidth, A_ScreenHeight, imageFileName)
; }

checkIfSuccess() {
    return not CheckImage([78, 1926], [837, 1987],"*200 img\无法切换频道.png")
}

fightAndChangeChannel(num) {
    SendInput "rt2"
    sleep 200
    if CheckImage([1870, 740], [2494, 1392], "img\食海龙\拾取物品.png") {
        SendInput "f"
        Sleep 300
        SendInput "f"
        Sleep 10000
        changeChannel(num)
    }
    Sleep 200
}


F5::
{  
    startChannel := 6
    endChannel := 8
    channel := startChannel
    loop {
        channel := channel + 1
        fightAndChangeChannel(channel)
        if channel == endChannel {
            channel := startChannel - 1
        }
    } until GetKeyState("F6", "P")
}

; F6::
; {   
;     SetTimer fightAndChangeChannel, 0
;     Reload
; }

GetColor(x, y) {
    color := PixelGetColor(x, y)
    return color
}