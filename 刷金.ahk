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


F5::
{   
Loop
{   
    pressR := Random(0.0, 0.2) * 1000
    releaseR := Random(0.0, 0.2) * 1000
    SendInput "{r down}"
    Sleep pressR
    SendInput "{r up}"
    Sleep releaseR
    pressT := Random(0.0, 0.2) * 1000
    releaseT := Random(0.0, 0.2) * 1000
    SendInput "{t down}"
    Sleep pressT
    SendInput "{t up}"
    Sleep releaseT
    press2 := Random(0.0, 0.2) * 1000
    release2 := Random(0.0, 0.2) * 1000
    SendInput "{2 down}"
    Sleep press2
    SendInput "{2 up}"
    Sleep release2
    pressLeft := Random(0.0, 0.2) * 1000
    releaseLeft := Random(0.0, 0.2) * 1000
    SendInput "{Left down}"
    Sleep pressLeft
    SendInput "{Left up}"
    Sleep releaseLeft
}Until GetKeyState("F6", "P")
}

GetColor(x, y) {
    color := PixelGetColor(x, y)
    return color
}