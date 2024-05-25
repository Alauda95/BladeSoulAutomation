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


F9::
{   
Loop
{   
    Click 2
    SendInput "y"
    Sleep 1
}Until GetKeyState("F10", "P")
}

GetColor(x, y) {
    color := PixelGetColor(x, y)
    return color
}