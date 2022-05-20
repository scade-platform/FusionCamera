import AVFoundation
import FusionCamera_Common

class Camera: NSObject {

  weak var previewLayer: AVCaptureVideoPreviewLayer?

  private var captureOutput: CaptureOutput?

  private var borderLayer: CAShapeLayer?

  private var resetTimer: Timer?

  init(previewLayer: AVCaptureVideoPreviewLayer) {
    self.previewLayer = previewLayer

    let borderLayer = CAShapeLayer()
    borderLayer.lineWidth = 2.0
    borderLayer.strokeColor = UIColor.green.cgColor
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.frame = previewLayer.bounds
    borderLayer.isHidden = true

    self.borderLayer = borderLayer
    self.previewLayer?.addSublayer(borderLayer)
  }

  private func updateBorder(_ points: [CGPoint]) {
    guard !points.isEmpty else { return }

    let path = CGMutablePath()
    for (index, point) in points.enumerated() {
      if index == 0 {
        path.move(to: point)
      }
      else {
        path.addLine(to: point)
      }
    }
    path.closeSubpath()

    self.borderLayer?.path = path
    self.borderLayer?.isHidden = false
  }

  private func hideBorder(after: Double) {
    self.resetTimer?.invalidate()
    self.resetTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval() + after,
                                           repeats: false) { [weak self] (timer) in
      self?.borderLayer?.isHidden = true
    }
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

      if let transformedObject =
           previewLayer?.transformedMetadataObject(for: object) as? AVMetadataMachineReadableCodeObject {
        updateBorder(transformedObject.corners)
        hideBorder(after: 0.25)
      }
    }
  }
}
#endif
