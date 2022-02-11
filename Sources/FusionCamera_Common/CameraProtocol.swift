public enum CaptureOutput {
  
  case qrCode(handler: CameraProtocol.QRCodeHandler)
}

public protocol CameraProtocol {
  typealias QRCodeHandler = (String) -> Void

  func registerCaptureOutput(_ output: CaptureOutput)
}

public extension CameraProtocol {

  func captureQRCode(with handler: @escaping QRCodeHandler) {
    self.registerCaptureOutput(.qrCode(handler: handler))
  }
}
