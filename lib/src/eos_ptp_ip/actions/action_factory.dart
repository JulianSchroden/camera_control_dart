import '../../common/models/camera_connection_handle.dart';
import '../../common/models/properties/autofocus_position.dart';
import '../../common/models/properties/live_view_magnification.dart';
import '../../common/property_control/control_prop_type.dart';
import '../actions/get_events_action.dart';
import '../adapter/eos_ptp_event_processor.dart';
import '../cache/ptp_property_cache.dart';
import '../constants/properties/live_view_output.dart';
import '../models/eos_ptp_int_prop_value.dart';
import '../models/eos_sensor_info.dart';
import 'capture_image_action.dart';
import 'deinit_session_action.dart';
import 'get_device_info_action.dart';
import 'get_live_view_image_action.dart';
import 'init_session_action.dart';
import 'set_live_view_magnification_action.dart';
import 'set_live_view_output_action.dart';
import 'set_prop_action.dart';
import 'set_touch_af_position_action.dart';
import 'start_bulb_capture_action.dart';
import 'stop_bulb_capture_action.dart';
import 'trigger_record_action.dart';

class ActionFactory {
  const ActionFactory();

  GetDeviceInfoAction createGetDeviceInfoAction() => GetDeviceInfoAction();

  InitSessionAction createInitSessionAction(
    CameraConnectionHandle connectionHandle,
  ) =>
      InitSessionAction(connectionHandle);

  DeinitSessionAction createDeinitSessionAction() => DeinitSessionAction();

  GetEventsAction createGetEventsAction() => GetEventsAction();

  SetPropAction createSetPropAction(
    ControlPropType propType,
    EosPtpIntPropValue propValue,
  ) =>
      SetPropAction(propType, propValue);

  CaptureImageAction createCaptureImageAction() => CaptureImageAction();

  StartBulbCaptureAction createStartBulbCapture() => StartBulbCaptureAction();
  StopBulbCaptureAction createStopBulbCapture() => StopBulbCaptureAction();

  SetLiveViewOutputAction createSetLiveViewOutputAction(
    EosPtpEventProcessor eventProcessor,
    LiveViewOutput liveViewOutput,
  ) =>
      SetLiveViewOutputAction(eventProcessor, liveViewOutput);

  GetLiveViewImageAction createGetLiveViewImageAction(
          PtpPropertyCache propertyCache) =>
      GetLiveViewImageAction(propertyCache);

  SetLiveViewMagnificationAction createSetLiveViewMagnification(
    LiveViewMagnification magnification,
  ) =>
      SetLiveViewMagnificationAction(magnification);

  SetTouchAfPositionAction createSetTouchAfPositionAction(
    AutofocusPosition focusPosition,
    EosSensorInfo sensorInfo,
    Duration focusDuration,
  ) =>
      SetTouchAfPositionAction(
        focusPosition,
        sensorInfo,
        focusDuration,
      );

  TriggerRecordAction createTriggerRecordAction(bool shouldRecord) =>
      TriggerRecordAction(shouldRecord);
}
