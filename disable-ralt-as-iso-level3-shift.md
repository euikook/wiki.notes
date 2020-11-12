
# Disable <kbd>RALT</kbd>  as <kbd>ISO_Level3_Shift</kbd>


그놈을 최신 버전으로 업그레이드 하면서 <kbd>Right ALT</kbd> 키가  <kbd>ISO_Level3_Shift</kbd> 로 인식 되는 경우 가 있다. 

```
xev
```
아래오
```
KeyRelease event, serial 37, synthetic NO, window 0x1400001,
    root 0x529, subw 0x0, time 107702472, (862,0), root:(2932,214),
    state 0x90, keycode 108 (keysym 0xfe03, ISO_Level3_Shift), same_screen YES,
    XKeysymToKeycode returns keycode: 92
    XLookupString gives 0 bytes: 
    XFilterEvent returns: False

```

`xev` 등의 명령으로 확인해보면 `RALT` 키가 `ISO_Level3_shift`로 설정 된 경우가 있다. 이 경우  `Tweak` > `Keyboard @ Mouse` > `Additional Layout Options` > `Key to choose the 3rd level` > `Right Alt` 선택을 해제한다.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTkwOTkwMDQ3Nl19
-->