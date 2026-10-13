[日本語](https://github.com/magicien/GLTFQuickLook/blob/master/lang/README.ja.md)

# GLTFQuickLook
macOS QuickLook plugin for glTF files. (.gltf/.glb)

> [!IMPORTANT]
> **GLTFQuickLook is no longer developed.** Its successor is **[3D Quick Viewer](https://apps.apple.com/app/id6804688390)** on the Mac App Store. [Details below](#moving-to-3d-quick-viewer).

## Moving to 3D Quick Viewer

Thank you to everyone who has used GLTFQuickLook since 2017, and to everyone who reported issues and sent pull requests.

GLTFQuickLook is a `.qlgenerator`, the older kind of Quick Look plugin. Apple introduced its replacement, Quick Look app extensions, in macOS 10.15, deprecated the old plugin API in macOS 12, and macOS 15 Sequoia no longer loads it at all. So I rebuilt glTF previews as a new app that uses the Quick Look extension mechanism Apple supports today.

### [3D Quick Viewer](https://apps.apple.com/app/id6804688390)

<a href="https://apps.apple.com/app/id6804688390"><img src="3dquickviewer.png" alt="A 3D model shown in Quick Look by 3D Quick Viewer" width="400"></a>

- **Same workflow:** select a file in Finder and press Space. Finder icons show thumbnails of the model too.
- **Simple install:** get it from the Mac App Store and open it once. No Terminal, no `xattr`, no `qlmanage -r`.
- **Better glTF support:** glTF 2.0 with PBR, skinning, morph targets, animation, Draco compression, cameras, and many `KHR_` extensions (texture transform, emissive strength, specular-glossiness, transmission, punctual lights and more).
- **More formats:** VRM, MikuMikuDance (.pmx / .pmd / .vmd), FBX, USD, STL, OBJ, 3MF and others. 22 formats in total.
- **A viewer app as well:** an orbit camera, and an inspector that lists vertices, materials, bones and morphs.

It requires **macOS 15 or later**. It is a **paid app with a one-time purchase**. Sales pay for continued development, including support for new macOS versions.

### What happens to this repository

- The repository stays public, and the source code and past releases remain available under the MIT License.
- There will be no new releases, and issues and pull requests will no longer be handled.
- Forks are welcome.
- On macOS 14 or earlier, the plugin keeps working as before. The instructions below are kept for those systems.

---

*Everything below is the original GLTFQuickLook documentation, kept for macOS 14 and earlier.*

![ScreenShot](https://github.com/magicien/GLTFQuickLook/blob/master/screenshot.png)

![ScreenShot2](https://github.com/magicien/GLTFQuickLook/blob/master/screenshot2.gif)

## System Requirements

- macOS 10.13 (High Sierra) to macOS 14 (Sonoma)
- It does not work on macOS 15 (Sequoia) or later. Use [3D Quick Viewer](https://apps.apple.com/app/id6804688390) instead.

## Install

### Using [Homebrew Cask](https://github.com/phinze/homebrew-cask)

- The `gltfquicklook` cask was disabled by Homebrew in September 2026 and can no longer be installed. Install it manually instead.

### Manually

1. Download **GLTFQuickLook_vX.X.X.zip** from [Releases](https://github.com/magicien/GLTFQuickLook/releases/latest).
2. Put **GLTFQuickLook.qlgenerator** (in the zip file) into `/Library/QuickLook` (for all users) or `~/Library/QuickLook` (only for the logged-in user).
3. Run `sudo xattr -r -d com.apple.quarantine /Library/QuickLook/GLTFQuickLook.qlgenerator` or `xattr -r -d com.apple.quarantine ~/Library/QuickLook/GLTFQuickLook.qlgenerator` to allow GLTFQuickLook.qlgenerator to run.
4. Run `qlmanage -r` command to reload QuickLook plugins.

## Uninstall

When you switch to 3D Quick Viewer, you can remove the old plugin:

1. Delete **GLTFQuickLook.qlgenerator** from `/Library/QuickLook` or `~/Library/QuickLook`. (Homebrew installed it into `~/Library/QuickLook`.)
2. Run `qlmanage -r` command to reload QuickLook plugins.

## Build

It needs to install [Carthage](https://github.com/Carthage/Carthage) to get frameworks.
```
$ git clone https://github.com/magicien/GLTFQuickLook.git
$ cd GLTFQuickLook
$ carthage bootstrap --platform mac
$ xcodebuild
```

## See also

- [3D Quick Viewer](https://apps.apple.com/app/id6804688390) - The successor to this plugin. A 3D viewer with a Quick Look extension for glTF, VRM, MMD, FBX, USD, STL, OBJ and more.
- [GLTFSceneKit](https://github.com/magicien/GLTFSceneKit/) - glTF loader for SceneKit
