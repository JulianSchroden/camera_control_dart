camera_control_dart allows you to remote control supported Canon EOS cameras wirelessly.

## Features

- Camera discovery
- Camera pairing
- Control properties like ISO, aperture, shutter speed and white balance
- Start and stop movie recording
- Image capturing
- Live view preview
- Demo mode

</br>

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

</br>

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

</br>

## Discovery

Use the `discover` method to listen for [CameraDiscoveryEvent](/lib/src/common/discovery/camera_discovery_event.dart#L5). Whenever a camera is detected, a `alive` event is emitted. On the contrary, a `byebye` event is emitted when a camera disappears. Note that the Stream returned by `discover` does not filter out duplicates.

```dart
final discoveryStreamSubscription =
    cameraControl.discover().listen((discoveryEvent) {
  // TODO: process discovery events
});
```

### Alive Event

The [CameraDiscoveryEventAlive](/lib/src/common/discovery/camera_discovery_event.dart#L24) contains a [DiscoveryHandle](/lib/src/common/discovery/discovery_handle.dart#L6) with the following properties:
- `id`: Identifier to reference the specific camera.
- `model`: A [CameraModel](/lib/src/common/models/camera_model.dart#L5) instance containing a model-specific `id`, `name`, and the underlying `protocol`.
- `pairingData`: Optional [PairingData](/lib/src/common/models/pairing_data.dart#L3) instance. Only present when the camera model does not require the user to enter pairing data.

### Byebye Event

The [CameraDiscoveryEventByeBye](/lib/src/common/discovery/camera_discovery_event.dart#L41) only contains the `id` property and notifies that the camera is no longer available.


</br>

## Pairing

Pairing is only required when connecting to a Canon EOS PTP/IP camera and only when connecting for the first time.
1. Navigate to your camera's `Wi-Fi function` menu.
2. Choose `Remote control (EOS Utility)`.
3. Create a new setup and follow the instructions until the message `Start paring devices` is displayed.
4. At this point, ensure your camera control application listens to discovery events.
5. On your camera, confirm the start of the pairing procedure with `OK`. The `discover` Stream should emit a `alive` event.
6. Using the [DiscoveryHandle](/lib/src/common/discovery/discovery_handle.dart#L6) of the `alive` event and the [EosPtpIpCameraPairingData](/lib/src/eos_ptp_ip/eos_ptp_ip_camera_pairing_data.dart#L5) entered by the user, construct a [CameraConnectionHandle](/lib/src/common/models/camera_connection_handle.dart#L7) and call `cameraControl.pair(cameraHandle)`.
7. Confirm the pairing procedure on the camera's screen.
8. Store the `PairingData` used for pairing with the camera for future connections.
9. Turn off the camera, wait a few seconds, and turn it back on. After the camera sends another `alive` message, you can connect using the stored `PairingData`.


```dart
final cameraHandle = CameraConnectionHandle(
  id: discoveryHandle.id,
  model: discoveryHandle.model,
  pairingData: EosPtpIpCameraPairingData(
    address: discoveryHandle.address,
    guid: Uint8List.fromList(List.generate(16, (index) => index)),
    clientName: 'myClient',
  ),
);

await cameraControl.pair(cameraHandle)

// TODO: store pairingData for future connections.
```

When the `pair` method completes without throwing, the camera pairing process is successful.

</br>

## Connecting to a Camera

Call `connect` and provide a [CameraConnectionHandle](/lib/src/common/models/camera_connection_handle.dart#L7) to establish a connection to a camera. For camera models that do not require a pairing procedure, map the properties of a [DiscoveryHandle](/lib/src/common/discovery/discovery_handle.dart#L6) to a [CameraConnectionHandle](/lib/src/common/models/camera_connection_handle.dart#L7).
Otherwise, look at the [Paring section](#pairing) for more info.
```dart
try {
  final camera = await cameraControl.connect(cameraHandle);
} catch (e) {
  // Failed to connect to camera
}
```
When establishing a connection succeeds, the Future completes with a camera instance; otherwise, it completes with an error.

</br>

## Camera Control

With a camera connected, you can start controlling it using the methods exposed by the [Camera](/lib/src/common/camera.dart#L9) interface.

### Listening to Events

To ensure property updates are handled correctly, use the `events()` method to listen to CameraUpdateEvents. Internally, the  implementation polls for events as long as you listen to the Stream and uses the event data to update its internal PropertyCache.

```dart
final eventStreamSubscription = camera.events().listen((cameraUpdateEvent) {
  // TODO: handle cameraUpdateEvent
  cameraUpdateEvent.when(
    descriptorChanged: (descriptor) {
      // TODO: handle descriptor change
    },
    propValueChanged: (propType, propValue) {
      // TODO: handle prop value change
    },
    propAllowedValuesChanged: (propType, allowedValues) {
      // TODO: handle allowed values change
    },
    recordState: (isRecording) {
      // TODO: handle record state change
    },
    focusMode: (focusMode) {
      // TODO: handle focus mode change
    },
    ndFilter: (mdStops) {
      // TODO: handle ND filter change
    },
  );
})
```

### Capturing Images

For image capturing, first ensure the camera has the `ImageCaptureCapability`. Then call `captureImage()` to take a photo.

```dart
final descriptor = await camera.getDescriptor();
if(!descriptor.hasCapability<ImageCaptureCapability>()) {
  // the camera does not support capturing images
  return;
}

await camera.captureImage();
```

### Controlling Properties

To control properties like aperture, ISO, and shutter speed:
- validate that the camera has the `ControlPropCapability`
- if yes, get the supported `ControlPropTypes` from the capability
- with the `supportedProps`, you can request the `ControlProp` by calling `getProp`
- the `ControlProp` contains the `propType`, `currentValue`, and `allowedValues` 
- now you can call `setProp` using the ControlPropType and one of its allowed values. 

```dart
final descriptor = await camera.getDescriptor();
if (!descriptor.hasCapability<ControlPropCapability>()) {
  // TODO: notify user
  return;
}

// Get a list of all supported ControlPropTypes 
final propCapability = descriptor.getCapability<ControlPropCapability>();
final supportedPropTypes = propCapability.supportedProps;

// Initialize a list of all supported properties including their current and allowed values
final supportedProps = <ControlProp>[];
for (final propType in supportedPropTypes) {
  final controlProp = await camera.getProp(propType);
  if (controlProp != null) {
    supportedProps.add(controlProp);
  }
}

// TODO: Dummy function to simulate some user interaction to pick a value for a type
final (propType, propValue) = await pickValue(supportedProps);


// Set the property to one of its allowed values
await camera.setProp(propType, propValue);
```

### Live View Image Acquisition

To acquire a Stream of Live View images, use the `liveView()` method. When listening to the stream, the camera enters `LiveView` Mode, and the Stream starts to emit `LiveViewData`. Canceling the StreamSubscription stops the `LiveView` Mode.  

The `LiveViewData` contains two properties:
-  `imageBytes`: Uint8List of JPEG-encoded image
-  `autofocusState`: represents the current autofocus state and the position of the autofocus rectangle

```dart
final liveViewStreamSubscription = camera.liveView().listen(
    (liveViewData) {
      const imageBytes = liveViewData.imageBytes
      const autofocusState = liveViewData.autofocusState

      // TODO: handle imageBytes and autofoucsState
    },
  );
```

### Set Autofocous Position in Live View

When the `LiveView` mode is enabled, you can change the autofocus position using the `setAutofocusPosition()` method. The method takes a single parameter of type `AutofocusPosition` that has two members, `x` and `y`, describing the position based on a normalized range between `[0, 1]`.

```dart
// Set the autofocus rectangle to the center
await camera.setAutofocusPosition(AutofocusPosition(x: 0.5, y: 0.5));
```

### Start and Stop Movie recordings

When the camera supports the `MovieRecordCapility`, you can use `triggerRecord` to start/stop a movie recording. Note that the capability is only supported when the camera is in movie mode.

```dart
final descriptor = await camera.getDescriptor();
if(!descriptor.hasCapability<MovieRecordCapility>()) {
  // the camera does not support recording movies
  return;
}

await camera.triggerRecord();
await Future.delayed(const Duration(seconds: 5));
await camera.triggerRecord();
```



