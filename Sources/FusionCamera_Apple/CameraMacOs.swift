import ScadeKit
import AVFoundation

#if os(macOS)

class Camera: NSObject, CameraProtocol {

  weak var previewLayer: AVCaptureVideoPreviewLayer?

  private var onSuccess: CameraProtocol.OnSuccess?

  init(previewLayer: AVCaptureVideoPreviewLayer) {
    self.previewLayer = previewLayer
  }

  func setup(_ onSuccess: @escaping CameraProtocol.OnSuccess) {
    guard let previewLayer = self.previewLayer,
          let session = previewLayer.session else { return }

    self.onSuccess = onSuccess
  }
}

#endif
