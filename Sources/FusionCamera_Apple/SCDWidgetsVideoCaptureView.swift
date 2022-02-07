import ScadeKit
import AVFoundation
import FusionCamera_Common

#if os(iOS)

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

#endif

#if os(macOS)

public extension SCDWidgetsVideoCaptureView {

  var camera: CameraProtocol? {
    guard let ptr = self.ptr,
          let view = Unmanaged<AnyObject>.fromOpaque(ptr).takeUnretainedValue() as? NSView,
          let previewLayer =
            view.layer?.sublayers?.first(where: {$0 is AVCaptureVideoPreviewLayer}) as? AVCaptureVideoPreviewLayer
    else { return nil }

    return Camera(previewLayer: previewLayer)
  }
}

#endif

