class CameraConfig {
  final Duration eventPollingInterval;

  const CameraConfig({
    this.eventPollingInterval = const Duration(milliseconds: 500),
  });
}
