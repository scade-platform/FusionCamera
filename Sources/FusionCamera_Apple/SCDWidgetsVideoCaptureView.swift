import ScadeKit
import AVFoundation

public extension SCDWidgetsVideoCaptureView {

  var camera: CameraProtocol? {
    guard let ptr = self.ptr,
          let view = Unmanaged<AnyObject>.fromOpaque(ptr).takeUnretainedValue() as? UIView,
          let previewLayer =
            view.layer.sublayers?.first(where: {$0 is AVCaptureVideoPreviewLayer}) as? AVCaptureVideoPreviewLayer
    else { return nil }

    return Camera(previewLayer: previewLayer)
  }
  
}
