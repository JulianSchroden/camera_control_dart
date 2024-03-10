import 'package:rxdart/rxdart.dart';

import '../../../camera_control_dart.dart';
import 'camera_discovery_adapter.dart';
import 'camera_discovery_configurator.dart';

class CameraDiscovery {
  final List<CameraDiscoveryAdapter> _adapters;

  static CameraDiscoveryConfigurator configure() =>
      CameraDiscoveryConfigurator();

  CameraDiscovery(this._adapters);

  Stream<CameraDiscoveryEvent> discover() {
    return MergeStream(_adapters.map((a) => a.discover()));
  }
}
