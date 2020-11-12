
# Disable <kbd>RALT</kbd>  as <kbd>ISO_Level3_Shift</kbd>


그놈을 최신 버전으로 업그레이드 하면서 <kbd>Right ALT</kbd> 키가  <kbd>ISO_Level3_Shift</kbd> 로 인식 되는 경우 가 있다. 

```
xev
```
`xev` 등의 명령으로 확인해보면 `RALT` 키가 `ISO_Level3_shift`로 설정 된 경우가 있다. 이 경우  `Tweak` > `Keyboard @ Mouse` > `Additional Layout Options` > `Key to choose the 3rd level` > `Right Alt` 선택을 해제한다.
<!--stackedit_data:
eyJoaXN0b3J5IjpbOTA4MjQ1NDRdfQ==
-->