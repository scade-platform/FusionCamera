import ScadeKit
import AVFoundation

public extension SCDWidgetsVideoCaptureView {

#if os(macOS)
  typealias NativeView = NSView
#elseif os(iOS)
  typealias NativeView = UIView
#endif

  var camera: CameraProtocol? {
    guard let ptr = self.ptr,
          let view = Unmanaged<AnyObject>.fromOpaque(ptr).takeUnretainedValue() as? NativeView,
          let previewLayer =
            view.layer.sublayers?.first(where: {$0 is AVCaptureVideoPreviewLayer}) as? AVCaptureVideoPreviewLayer
    else { return nil }

    return Camera(previewLayer: previewLayer)
  }
  
}
