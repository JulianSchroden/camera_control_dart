/// A remote control library currently supporting selected Canon EOS cameras.
///
library;

export 'src/camera_control.dart';
export 'src/common/camera.dart';
export 'src/camera_models.dart';

// discovery
export 'src/common/discovery/camera_discovery_event.dart';
export 'src/common/discovery/discovery_handle.dart';
export 'src/common/discovery/wifi_info_adapter.dart';

// connection
export 'src/common/models/camera_connection_handle.dart';
export 'src/common/models/pairing_data.dart';
export 'src/common/models/camera_control_protocol.dart';
export 'src/common/models/camera_model.dart';
export 'src/common/models/camera_descriptor.dart';

// capabilities
export 'src/common/models/capabilities/camera_capability.dart';
export 'src/common/models/capabilities/control_prop_capability.dart';
export 'src/common/models/capabilities/image_capture_capability.dart';
export 'src/common/models/capabilities/live_view_capability.dart';

// property control
export 'src/common/property_control/control_prop.dart';
export 'src/common/property_control/control_prop_type.dart';
export 'src/common/property_control/control_prop_value.dart';

export 'src/common/models/camera_update_event.dart';
export 'src/common/models/properties/auto_focus_mode.dart';
export 'src/common/models/properties/autofocus_position.dart';
export 'src/common/models/properties/camera_mode.dart';
export 'src/common/models/properties/exposure_mode.dart';

// live view
export 'src/common/live_view/live_view_data.dart';
export 'src/common/live_view/touch_autofocus_state.dart';

// exceptions
export 'src/common/exceptions/camera_communication_exception.dart';
export 'src/common/exceptions/camera_connection_exception.dart';
export 'src/common/exceptions/unsupported_capability_exception.dart';

// logging
export 'src/common/logging/log_level.dart';
export 'src/common/logging/logger.dart';
export 'src/common/logging/logger_channel.dart';
export 'src/common/logging/logger_topic.dart';

// demo implementation
export 'src/demo/demo_camera_pairing_data.dart';

// eos cine http implementation
export 'src/eos_cine_http/eos_cine_http_camera_pairing_data.dart';
export 'src/eos_cine_http/discovery/eos_cine_http_discovery_handle.dart';

// eos ptp/ip implementation
export 'src/eos_ptp_ip/discovery/eos_ptp_ip_discovery_handle.dart';
export 'src/eos_ptp_ip/eos_ptp_ip_camera_pairing_data.dart';
export 'src/eos_ptp_ip/logging/eos_ptp_ip_logger_topics.dart';
