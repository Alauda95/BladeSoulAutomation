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

CheckImage(imageFileName) {
    return ImageSearch(&FoundX, &FoundY, 1100, 900, 2570, 2129, imageFileName)
}

checkEnermysBuff(imageFileName) {
    return ImageSearch(&FoundX, &FoundY, 967, 1, 2666, 599, imageFileName)
}

checkBingheBuff() {
    if checkEnermysBuff("img\雪冰掌buff.png") {
        ; MsgBox "OK"
        return true
    }
}

checkLianhua(){
    global 
    if CheckImage("img\莲花指.png") {
        lianhua_ready := true
    }
    else {
        lianhua_ready := false
    }
    return lianhua_ready
}

loopLiuxing(){
    global
    liuxing_ready := true
}

checkLiuxing(){
    global 
    if CheckImage("img\流星.png") {
        liuxing_ready := true
    }
    else {
        liuxing_ready := false
    }
    return liuxing_ready
}

checkHuoyan(){
    global 
    if CheckImage("img\火炎.png") {
        huoyan_ready := true
    }
    else {
        huoyan_ready := false
    }
    return huoyan_ready
}

checkXinghuo(){
    global 
    if CheckImage("img\星火.png") {
        xinghuo_ready := true
    }
    else {
        xinghuo_ready := false
    }
    return xinghuo_ready
}

checkHanfeng(){
    global 
    if CheckImage("img\寒风.png") {
        ; MsgBox "?OK"
        hanfeng_ready := true
    }
    else {
        hanfeng_ready := false
    }
    return hanfeng_ready
}


pressC() {
    SendInput "c"
}

pressX() {
    SendInput "x"
}

pressZ() {
    SendInput "z"
}

pressF() {
    SendInput "f"
}

press3() {
    SendInput "3"
}

press4() {
    SendInput "4"
}

press2() {
    SendInput "2"
}


setALLTimer(is_start) {
    if is_start == true {
        SetTimer checkLiuxing, 500
        SetTimer checkLianhua, 500
        ; SetTimer pressC, 100
        ; SetTimer pressF, 0 
        ; SetTimer pressX, 1 
        SetTimer pressZ, 50
        SetTimer press3, 50
        ; SetTimer press2, 50
    }
    else {
        SetTimer checkLiuxing, 0
        SetTimer checkLianhua, 0
        SetTimer pressC, 0
        SetTimer pressF, 0
        SetTimer pressX, 0
        SetTimer pressZ, 0
        SetTimer press3, 0
        SetTimer press2, 0
    }
}


checkAndStart(param, keys, checkFunc, skip_check := false) {
    if param{
        Sleep 100
        if checkFunc() or skip_check{
            Send "{" keys " down}"
            Sleep 200
            Send "{" keys " up}"
            return checkFunc()
        }
    }
}

XButton1::
{   
    global
    lianhua_ready := true
    liuxing_ready := true
    ; huoyan_ready := checkHuoyan()
    ; xinghuo_ready := checkXinghuo()
    ; hanfeng_ready := checkHanfeng()
    setALLTimer(true)
    send "t"
    Sleep 300
    SendInput "z"
    Sleep 10
Loop
{   
    global lianhua_ready
    global liuxing_ready
    ; global huoyan_ready
    ; global xinghuo_ready
    ; global hanfeng_ready
    checkAndStart(lianhua_ready, "c", checkLianhua)
    ; SendInput "2f"
    ; SendInput "r"
    ; Sleep 20
    ; SendInput "c"
    ; liuxing_ready := checkAndStart(liuxing_ready, "v", checkLiuxing)
    ; Sleep 20
    ; SendInput "t"
    ; Sleep 20
    ; SendInput "z"
    ; Sleep 20
    ; SendInput "x2f"

    SendInput "tzxf2rf2f2"
    if checkBingheBuff() or GetColor(1853,1817)=="0xFFFFEE" {
        Loop 4
        {
            SendInput "223t"
            Sleep 10
        }
    }
    if lianhua_ready or liuxing_ready {
        Sleep 300
    }
    checkAndStart(lianhua_ready, "c", checkLianhua) 
    checkAndStart(liuxing_ready, "v", checkLiuxing)
    ; liuxing_ready := checkAndStart(liuxing_ready, "v", checkLiuxing)
    ; checkAndStart(huoyan_ready, "x", checkHuoyan, true)
    ; checkAndStart(xinghuo_ready, "z", checkXinghuo, true)
    ; SendInput "r"
    ; checkAndStart(lianhua_ready, "c", checkLianhua)
    ; Sleep latency * 2
    ; checkAndStart(hanfeng_ready, "X", checkHanfeng, true)
    ; SendInput "2" 
    Sleep 20
}Until not GetKeyState("XButton1", "P")
setALLTimer(false)
}

GetColor(x, y) {
    color := PixelGetColor(x, y)
    return color
}