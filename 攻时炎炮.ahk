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


setALLTimer(is_start) {
    if is_start == true {
        SetTimer checkLiuxing, 200
        ; SetTimer loopLiuxing, 29000
        SetTimer pressC, 100
        SetTimer pressF, 100 
        SetTimer pressX, 100 
        SetTimer pressZ, 100
        SetTimer press3, 100
        ; SetTimer press4, 100
    }
    else {
        ; SetTimer checkLianhua, 0
        SetTimer checkLiuxing, 0
        SetTimer pressC, 0
        SetTimer pressF, 0
        SetTimer pressX, 0
        SetTimer pressZ, 0
        SetTimer press3, 0
        SetTimer press4, 0
    }
}


checkAndStart(param, keys, checkFunc, skip_check := false) {
    if param{
        Sleep 250
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
Loop
{   
    global lianhua_ready
    global liuxing_ready
    ; global huoyan_ready
    ; global xinghuo_ready
    ; global hanfeng_ready
    checkAndStart(lianhua_ready, "c", checkLianhua)
    SendInput "2fr"
    ; checkAndStart(lianhua_ready, "c", checkLianhua) 
    liuxing_ready := checkAndStart(liuxing_ready, "v", checkLiuxing)
    ; checkAndStart(huoyan_ready, "x", checkHuoyan, true)
    ; checkAndStart(xinghuo_ready, "z", checkXinghuo, true)
    ; todo 识别火F和冰F再释放，且当火玉3（识别大小3层）层时不释放火F，冰F同理
    SendInput "tf"
    ; Sleep latency * 2
    ; checkAndStart(hanfeng_ready, "X", checkHanfeng, true)
    SendInput "2f" 
    Sleep 10
}Until not GetKeyState("XButton1", "P")
    setALLTimer(false)
}

GetColor(x, y) {
    color := PixelGetColor(x, y)
    return color
}