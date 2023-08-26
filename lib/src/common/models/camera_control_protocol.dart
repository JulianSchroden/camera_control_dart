/// The protocol used to communicate with the camera.
///
/// The CameraControlProtocol is used to select the appropriate implementation when connecting to a camera.
enum CameraControlProtocol {
  demo,
  eosCineHttp,
  eosPtpIp,
}
