# FusionCamera

## Example:

```swift
class MainPageAdapter: SCDLatticePageAdapter {

  var camera: CameraProtocol?

  // page adapter initialization
  override func load(_ path: String) {
    super.load(path)

    self.camera = self.videoCaptureView.camera

    // vanilla API:
    // self.camera?.registerCaptureOutput(.qrCode { [weak self] data in
    //   print(data)
    //   self?.videoCaptureView.stop()
    // })

    // syntax sugar API:
    self.camera?.captureQRCode { [weak self] data in
      print(data)
      self?.videoCaptureView.stop()
    }
  }
}
```
