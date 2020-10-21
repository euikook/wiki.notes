# Python 기본 인터프리터 설정 하기

```
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

sudo update-alternatives --config pip
sudo update-alternatives --config python
```

아래와 같이 직접 `--set` 옵션을 사용하여 설정 한다. 

```
sudo update-alternatives --set python /usr/bin/python3
sudo update-alternatives --set pip /usr/bin/pip3
```
