# GLTFQuickLook
macOS用glTF QuickLookプラグイン (.gltf/.glb)

> [!IMPORTANT]
> **GLTFQuickLookの開発は終了しました。** 後継はMac App Storeの **[3D Quick Viewer](https://apps.apple.com/app/id6804688390)** です。[詳しくは下記](#3d-quick-viewerへの移行について)をご覧ください。

## 3D Quick Viewerへの移行について

2017年からGLTFQuickLookを使ってくださった皆さま、Issueやプルリクエストを送ってくださった皆さま、ありがとうございました。

GLTFQuickLookは`.qlgenerator`という古い形式のQuickLookプラグインです。macOS 10.15で後継のQuickLook拡張が用意され、macOS 12でこの形式のAPIは非推奨になり、macOS 15 Sequoiaからは読み込まれなくなりました。そこで、Appleが現在サポートしているQuickLook拡張の仕組みを使って、新しいアプリとして作り直しました。

### [3D Quick Viewer](https://apps.apple.com/app/id6804688390)

<a href="https://apps.apple.com/app/id6804688390"><img src="../3dquickviewer-ja.png" alt="3D Quick ViewerでQuickLook表示した3Dモデル" width="400"></a>

- **使い方は同じ:** Finderでファイルを選んでスペースキーを押すだけ。Finderのアイコンもモデルのサムネイルになります。
- **インストールが簡単:** Mac App Storeから入れて一度起動するだけ。ターミナルでの操作は要りません。
- **glTFの対応を強化:** PBR、スキニング、モーフ、アニメーション、Draco圧縮、カメラ、各種`KHR_`拡張（テクスチャ変換、発光の強さ、スペキュラ・グロシネス、透過、ライトなど）。
- **ほかの形式も:** VRM、MikuMikuDance（.pmx / .pmd / .vmd）、FBX、USD、STL、OBJ、3MFなど全22形式。
- **ビューアアプリとしても:** 軌道カメラと、頂点・材質・ボーン・モーフを確認できる情報欄。

**macOS 15以降**が必要です。**買い切りの有料アプリ**です。売り上げは、新しいmacOSへの対応を含む今後の開発に充てます。

### このリポジトリについて

- リポジトリは公開したままにします。ソースコードと過去のリリースはMITライセンスで引き続き利用できます。
- 新しいリリースは出しません。Issueとプルリクエストへの対応も終了します。
- フォークは歓迎します。
- macOS 14以前では、これまでどおり動作します。そのための手順は下に残してあります。

---

*ここから下は、macOS 14以前のために残しているGLTFQuickLookの元の説明です。*

![ScreenShot](https://github.com/magicien/GLTFQuickLook/blob/master/screenshot.png)

![ScreenShot2](https://github.com/magicien/GLTFQuickLook/blob/master/screenshot2.gif)

## 対応システム

- macOS 10.13 (High Sierra) 〜 macOS 14 (Sonoma)
- macOS 15 (Sequoia) 以降では動作しません。[3D Quick Viewer](https://apps.apple.com/app/id6804688390)をお使いください。

## インストール方法

### [Homebrew Cask](https://github.com/phinze/homebrew-cask)でインストール

- `gltfquicklook`は2026年9月にHomebrew側で無効化され、インストールできなくなりました。手動でインストールしてください。

### 手動インストール

1. [Releases](https://github.com/magicien/GLTFQuickLook/releases/latest)ページから最新の「**GLTFQuickLook_vX.X.X.zip**」をダウンロードする
2. ZIPファイル中の「**GLTFQuickLook.qlgenerator**」を `/Library/QuickLook` (全ユーザ用) か`~/Library/QuickLook` (使用中のユーザ用)にコピーする
3. ターミナルで`sudo xattr -r -d com.apple.quarantine /Library/QuickLook/GLTFQuickLook.qlgenerator`か`xattr -r -d com.apple.quarantine ~/Library/QuickLook/GLTFQuickLook.qlgenerator`を実行して、GLTFQuickLook.qlgeneratorの実行を許可する
4. ターミナルで`qlmanage -r`を実行してQuickLookプラグインの再読み込みをする

## アンインストール方法

3D Quick Viewerに切り替えたら、古いプラグインは削除できます。

1. `/Library/QuickLook` か `~/Library/QuickLook` から「**GLTFQuickLook.qlgenerator**」を削除する（Homebrewでインストールした場合は`~/Library/QuickLook`にあります）
2. ターミナルで`qlmanage -r`を実行してQuickLookプラグインの再読み込みをする

## ビルド方法（改造したい人向け）

[Carthage](https://github.com/Carthage/Carthage)が無い場合はインストールする。
その後、下記コマンドを実行する。
```
$ git clone https://github.com/magicien/GLTFQuickLook.git
$ cd GLTFQuickLook
$ carthage bootstrap --platform mac
$ xcodebuild
```

## 関連リポジトリ

- [3D Quick Viewer](https://apps.apple.com/app/id6804688390) - このプラグインの後継。glTF、VRM、MMD、FBX、USD、STL、OBJなどに対応したQuickLook拡張つきの3Dビューア
- [GLTFSceneKit](https://github.com/magicien/GLTFSceneKit/) - SceneKit用glTFローダ
