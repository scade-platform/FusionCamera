import ScadeKit
import AVFoundation

#if os(macOS)
class Camera: NSObject, CameraProtocol {
#elseif os(iOS)
class Camera: NSObject, CameraProtocol, AVCaptureMetadataOutputObjectsDelegate {
#endif

  weak var previewLayer: AVCaptureVideoPreviewLayer?

  private var onSuccess: OnSuccess?

  init(previewLayer: AVCaptureVideoPreviewLayer) {
    self.previewLayer = previewLayer
  }

  func setup(_ onSuccess: @escaping OnSuccess) {
    guard let previewLayer = self.previewLayer,
          let session = previewLayer.session else { return }

    self.onSuccess = onSuccess

#if os(iOS)
    let output = AVCaptureMetadataOutput()
    session.addOutput(output)
    
    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
#endif

  }

#if os(iOS)
  func metadataOutput(_ output: AVCaptureMetadataOutput,
                      didOutput metadataObjects: [AVMetadataObject],
                      from connection: AVCaptureConnection) {
    if metadataObjects.count > 0,
       let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
       object.type == AVMetadataObject.ObjectType.qr,
       let qrCode = object.stringValue,
       let onSuccess = self.onSuccess {
      onSuccess(qrCode)
    }
  }
#endif
}
