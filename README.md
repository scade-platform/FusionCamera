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


## Contribution

<p>Consider contributing by creating a pull request (PR) or opening an issue. By creating an issue, you can alert the repository's maintainers to any bugs or missing documentation you've found. 🐛📝 If you're feeling confident and want to make a bigger impact, creating a PR, can be a great way to help others. 📖💡 Remember, contributing to open source is a collaborative effort, and any contribution, big or small, is always appreciated! 🙌 So why not take the first step and start contributing today? 😊</p>
