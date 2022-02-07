# FusionCamera

## Example:

```swift
class MainPageAdapter: SCDLatticePageAdapter {

  var camera: CameraProtocol?
  
  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

    self.camera = self.videoCaptureView.camera
    self.camera?.setup { print($0) }
  }
}
```
