/// Remote control supported Canon EOS cameras.
///
library;

export 'src/camera_control_logging.dart';

export 'src/interface/camera.dart';
export 'src/interface/camera_factory.dart';
export 'src/interface/camera_factory_provider.dart';

export 'src/interface/models/camera_descriptor.dart';
export 'src/interface/models/camera_handle.dart';
export 'src/interface/models/pairing_data.dart';
export 'src/interface/models/camera_update_event.dart';
export 'src/interface/models/control_prop.dart';
export 'src/interface/models/control_prop_type.dart';
export 'src/interface/models/control_prop_value.dart';
export 'src/interface/models/properties/auto_focus_mode.dart';
export 'src/interface/models/properties/camera_mode.dart';
export 'src/interface/models/properties/exposure_mode.dart';

export 'src/interface/models/camera_model.dart';
export 'src/interface/models/camera_control_protocol.dart';

// capabilities
export 'src/interface/models/capabilities/camera_capability.dart';
export 'src/interface/models/capabilities/control_prop_capability.dart';
export 'src/interface/models/capabilities/image_capture_capability.dart';
export 'src/interface/models/capabilities/live_view_capability.dart';

// discovery
export 'src/interface/discovery/discovery_handle.dart';
export 'src/common/discovery/default_camera_discovery_service.dart';
export 'src/interface/discovery/camera_discovery_service.dart';
export 'src/interface/discovery/wifi_info_adapter.dart';
export 'src/interface/discovery/wifi_info.dart';
export 'src/eos_ptp_ip/discovery/eos_ptp_ip_discovery_handle.dart';
export 'src/eos_cine_http/models/eos_cine_http_discovery_handle.dart';
export 'src/interface/discovery/camera_discovery_event.dart';

// pairing
export 'src/demo/demo_camera_pairing_data.dart';
export 'src/eos_ptp_ip/eos_ptp_ip_camera_pairing_data.dart';
export 'src/eos_cine_http/eos_cine_http_camera_pairing_data.dart';

// exceptions
export 'src/interface/exceptions/camera_communication_exception.dart';
export 'src/interface/exceptions/camera_connection_exception.dart';
export 'src/interface/exceptions/unsupported_capability_exception.dart';

// live view
export 'src/interface/models/live_view_data.dart';
export 'src/interface/models/touch_autofocus_state.dart';
export 'src/interface/models/properties/autofocus_position.dart';
