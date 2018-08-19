# mikutter_fcmnotify
## これなん
mikutter_fcmを用いて，mikutterからリプライ，ふぁぼ，RT(BT)の通知を飛ばすプラグイン。
## 使い方
1. yuzumoneさん作成の[プラグイン](https://github.com/yuzumone/mikutter_fcm)をインストールし，使えるようにする。
2. このプラグインを下記のコマンドなどによりインストールする。
```
mkdir -p ~/.mikutter/plugin/ && \
git clone https://github.com/4pk/mikutter_fcmnotify.git ~/.mikutter/plugin/mikutter_fcmnotify
```
## 課題
1. BT通知が複数発生してしまうときがある  
2. ふぁぼ，リプライ，RT(BT)以外の通知の実装が出来ていない
