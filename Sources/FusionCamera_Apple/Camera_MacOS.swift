import AVFoundation
import FusionCamera_Common

#if os(macOS)

class Camera: NSObject, CameraProtocol {

  weak var previewLayer: AVCaptureVideoPreviewLayer?

  private var onSuccess: CameraProtocol.OnSuccess?

  init(previewLayer: AVCaptureVideoPreviewLayer) {
    self.previewLayer = previewLayer
  }

  func setup(_ onSuccess: @escaping CameraProtocol.OnSuccess) {
    self.onSuccess = onSuccess
  }
}

#endif
