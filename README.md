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
      ],
    ).create();
```

### Camera Discovery Configuration
Within the configuration, you specify which camera types you want to discover. 

If you do not own any supported camera, you can still play around with `camera_control_dart` by utilizing its demo implementation. To do so, make sure to call `withDemo` on the `discoverySetup`.

### Logger Configuration
While reverse engineering camera protocols during the development of the library, I had to rely heavily on debugging using logs since breakpoints pause the execution too long, causing cameras to disconnect. Therefore, I added a logging infrastructure that is configurable by specifying the topics you are interested in. For example, to see logs from the PTP/IP transaction queue, add `EosPtpTransactionQueueTopic` to the list of `enabledTopics`.


```

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
