public protocol CameraProtocol {
  typealias OnSuccess = (String) -> Void

  func setup(_ onSuccess: @escaping OnSuccess)
}
