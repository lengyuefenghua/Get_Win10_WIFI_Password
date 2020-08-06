;WIFI密码获取
#SingleInstance force
Gui New,,Wifi密码获取器(双击复制密码)
Gui -MaximizeBox
Gui -MinimizeBox
Gui, add, listview,NoSortHdr r20 w400 grid gDoubleClick, 网络名称|网络密匙
Gui, Add, Text,,%A_Tab% %A_Tab% %A_Tab%  %A_Tab% %A_Tab%By 冷月风华 2020/5/7
LV_ModifyCol(1,198)
LV_ModifyCol(2,198)
Gui show 

runwait, %comspec% /c netsh wlan show profile | clip,, hide
Loop, parse, clipboard,`n,`r
{
    if a_index > 10
    {
         ;LV_Add("",SubStr(A_LoopField, 16))
         SSID .= SubStr(A_LoopField, 16) "`n"
    }  
}
Clipboard = 
Loop, parse, SSID, `n, `r
{
          ; MsgBox  %A_LoopField%
          runwait, %comspec% /c netsh wlan show profile "%A_LoopField%" key=clear | clip,, hide
          RegExMatch(clipboard,"关键内容            : (.*)",pp)
         LV_Add("",A_LoopField,SubStr(pp, 19))
}
SoundPlay *64
Clipboard = 
return

DoubleClick:
   LV_GetText(OutputVar1, A_EventInfo ,1)
   LV_GetText(OutputVar2, A_EventInfo ,2)
   Clipboard = %OutputVar2%
   MsgBox ,64,复制提示,网络名称:%OutputVar1%`n网络密匙:%OutputVar2%`n密码已成功复制至剪贴板！
return

GuiEscape:
GuiClose:
    ExitApp
