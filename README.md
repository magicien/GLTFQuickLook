# GLTFQuickLook
macOS QuickLook plugin for glTF files. (.gltf/.glb)

![ScreenShot](https://github.com/magicien/GLTFQuickLook/blob/master/screenshot.png)

![ScreenShot2](https://github.com/magicien/GLTFQuickLook/blob/master/screenshot2.gif)

## System Requirements

- macOS 10.13 (High Sierra) or later

## Install

### Using [Homebrew Cask](https://github.com/phinze/homebrew-cask)

- Run `brew install gltfquicklook`
- Run `xattr -r -d com.apple.quarantine ~/Library/QuickLook/GLTFQuickLook.qlgenerator` to allow GLTFQuickLook.qlgenerator to run.

### Manually

1. Download **GLTFQuickLook_vX.X.X.zip** from [Releases](https://github.com/magicien/GLTFQuickLook/releases/latest).
2. Put **GLTFQuickLook.qlgenerator** (in the zip file) into `/Library/QuickLook` (for all users) or `~/Library/QuickLook` (only for the logged-in user).
3. Run `sudo xattr -r -d com.apple.quarantine /Library/QuickLook/GLTFQuickLook.qlgenerator` or `xattr -r -d com.apple.quarantine ~/Library/QuickLook/GLTFQuickLook.qlgenerator` to allow GLTFQuickLook.qlgenerator to run.
4. Run `qlmanage -r` command to reload QuickLook plugins.

## Build

It needs to install [Carthage](https://github.com/Carthage/Carthage) to get frameworks.
```
$ git clone https://github.com/magicien/GLTFQuickLook.git
$ cd GLTFQuickLook
$ carthage bootstrap --platform mac
$ xcodebuild
```

## See also

- [GLTFSceneKit](https://github.com/magicien/GLTFSceneKit/) - glTF loader for SceneKit
