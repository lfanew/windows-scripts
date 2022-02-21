IDLING := False

While(True) {
    Random, delay, 100, 5000
    Sleep, delay
    if (IDLING) {
        Random, x, -100, 100
        Random, y, -100, 100
        Random, speed, 2, 10
        MouseMove, x, y, speed, R
        
        Random, shouldSendKey, 0, 9
        if (shouldSendKey > 7) {
            Random, key, 0, 4
            switch key {
                case 0:
                    Send, {Left}
                case 1:
                    Send, {Up}
                case 2:
                    Send, {Right} 
                case 3:
                    Send, {Down}
                case 4:
                    Send, !{Tab}
            }
        }
    }
}

^CtrlBreak::
    IDLING := !IDLING
    if (IDLING) {
        MsgBox, Press OK to start idling...
    }
return
