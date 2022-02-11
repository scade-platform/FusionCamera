import AVFoundation
import FusionCamera_Common

class Camera: NSObject {

  weak var previewLayer: AVCaptureVideoPreviewLayer?

  private var captureOutput: CaptureOutput?

  init(previewLayer: AVCaptureVideoPreviewLayer) {
    self.previewLayer = previewLayer
  }
}

extension Camera: CameraProtocol {

  func registerCaptureOutput(_ output: CaptureOutput) {
    self.captureOutput = output

    switch output {
    case .qrCode:
      registerQRCodeCaptureOutput()
    }
  }

  private func registerQRCodeCaptureOutput() {
    guard let previewLayer = self.previewLayer,
          let session = previewLayer.session else { return }
#if os(iOS)
    let output = AVCaptureMetadataOutput()
    session.addOutput(output)
    
    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
#endif
  }
}

#if os(iOS)
extension Camera: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput,
                      didOutput metadataObjects: [AVMetadataObject],
                      from connection: AVCaptureConnection) {
    if metadataObjects.count > 0,
       let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
       object.type == AVMetadataObject.ObjectType.qr,
       let qrCode = object.stringValue,
       case let .qrCode(handler) = self.captureOutput {
      handler(qrCode)
    }
  }
}
#endif
