camera_control_dart allows you to remote control supported Canon EOS cameras wirelessly.

## Features
- Camera discovery
- Camera pairing
- Control properties like ISO, aperture, shutter speed and white balance
- Start and stop movie recording
- Image capturing
- Live view preview
- Demo mode

## Getting started

As of right now, `camera_control_dart` is not published on [pub.dev](). Therefore, you may depend on it by referencing this GitHub repository or a local copy using its relative path.

```yaml
dependencies:
  camera_control_dart:
    # Option A: Referencing the package using its GitHub repository
    git:
      url: https://github.com/JulianSchroden/camera_control_dart.git
      ref: v0.0.2
    # Option B: Referencing a local copy of the repository
    path: ../camera_control_dart/
```

## Initialization

`camera_control_dart` provides a builder-like initialization to configure the library to your project needs. The library does not create a singleton instance, so it is your responsibility to manage the `CameraControl` instance.

```dart
final cameraControl = CameraControl.init()
  .withDiscovery((discoverySetup) => discoverySetup
      .withDemo()
      .withEosPtpIp()
      .withEosCineHttp(WifiInfoAdapterImpl()))
  .withLogging(
    logger: CameraControlLoggerImpl(),
    enabledTopics: [
      const EosPtpTransactionQueueTopic(),
      const EosPtpIpDiscoveryTopic(),
    ]
  ).create();
```

### Camera Discovery Configuration
Camera discovery is the process of scanning for nearby cameras. Within the configuration, you specify which camera types you want to discover.

- Use `withEosPtpIp()` to enable the discovery of PTP/IP Cameras by listening for UPNP advertisements.
- Use `withEosCineHttp()` to check whether your phone is connected to the access point of a Canon C100 II. Since I wanted to keep the library in pure dart, `withEosCineHttp` requires you to pass in an implementation of the [WifiInfoAdapter](/lib/src/common/discovery/wifi_info_adapter.dart) interface. Check out my [cine_remote](https://github.com/JulianSchroden/cine_remote) project for a [flutter implementation](https://github.com/JulianSchroden/cine_remote/blob/5daac7a1131d1d8e49e5bcadc15562596ddb0ee0/lib/adapter/wifi_info_adapter.dart).
- Use `withDemo()` if you do not own any supported camera to play around with the library using its demo implementation.

### Logger Configuration
While reverse-engineering camera protocols, I had to rely heavily on debugging using logs since breakpoints pause the execution too long, causing cameras to disconnect. Therefore, I added a configurable logging infrastructure that allows you to specify the topics you are interested in.

#### Available Topics:
- [UnspecifiedLoggerTopic](/lib/src/common/logging/camera_control_logger_config.dart#L10): Fallback topic to ensure logs that do not specify a `LoggerChannel` are logged.
- [EosPtpRawEventLoggerTopic](/lib/src/eos_ptp_ip/logging/topics/eos_event_topics.dart#L14): Raw event data logs of the GetEventData (0x9116) operation.
- [EosPtpPropertyChangedLoggerTopic](/lib/src/eos_ptp_ip/logging/topics/eos_event_topics.dart#L29): Property changed event logs.
- [EosPtpTransactionQueueTopic](/lib/src/eos_ptp_ip/logging/topics/transaction_queue_topics.dart#L14): PTP/IP transaction queue logs.
- [EosPtpIpDiscoveryTopic](/lib/src/eos_ptp_ip/logging/topics/eos_ptp_ip_discovery_topic.dart#L10): UPNP alive and bye-bye advertisements logs.

## Discovery
Use the `discover` method to listen for [CameraUpdateEvents](/lib/src/common/discovery/camera_discovery_event.dart#L5). Whenever a camera is detected, a `alive` event is emitted. On the contrary, a `byebye` event is emitted when a camera disappears. Note that the Stream returned by `discover` does not filter out duplicates.

```dart
final discoveryStreamSubscription =
    cameraControl.discover().listen((discoveryEvent) {
  // TODO: process discovery events
});
```
### Alive Event
The [CameraDiscoveryEventAlive](/lib/src/common/discovery/camera_discovery_event.dart#L24) contains a [DiscoveryHandle](/lib/src/common/discovery/discovery_handle.dart#L6) that contains the following properties:
- `id`: Identifier to reference the specific camera.
- `model`: A [CameraModel](/lib/src/common/models/camera_model.dart#L5) instance containing a model-specific `id`, `name`, and the underlying `protocol`.
- `pairingData`: Optional [PairingData](/lib/src/common/models/pairing_data.dart#L3) instance. Only present when the camera model does not require the user to enter pairing data.

### Byebye Event
The [CameraDiscoveryEventByeBye](/lib/src/common/discovery/camera_discovery_event.dart#L41) only contains the `id` property and notifies that the camera is no longer available.


## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
