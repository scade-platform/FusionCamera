public enum CaptureOutput {
  
  case qrCode(onSuccess: CameraProtocol.OnSuccess)
}

public protocol CameraProtocol {
  typealias OnSuccess = (String) -> Void

  func registerCaptureOutput(_ output: CaptureOutput)
}
