import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_descriptor_mapper.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_event_mapper.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/allowed_values_changed.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/prop_value_changed.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/communication/events/ptp_event.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_property.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_property_code.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/models/eos_ptp_int_prop_value.dart';
import 'package:camera_control_dart/src/common/models/camera_update_event.dart';
import 'package:camera_control_dart/src/common/property_control/control_prop_type.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class FakePtpEvent extends Fake implements PtpEvent {}

class MockPtpDescriptorMapper extends Mock implements PtpDescriptorMapper {}

void main() {
  late PtpEventMapper sut;
  late MockPtpDescriptorMapper mockPtpDescriptorMapper;

  setUp(() {
    mockPtpDescriptorMapper = MockPtpDescriptorMapper();
    sut = PtpEventMapper(mockPtpDescriptorMapper);
  });

  test('returns null when source events has unknown type', () {
    final result = sut.mapToCommon(FakePtpEvent());

    expect(result, isNull);
  });

  group('on propValueChanged event', () {
    test('returns null when event has unknown propType', () {
      const unknownPropChanged = PropValueChanged(
        0xF0F0,
        null,
        EosPtpIntPropValue('99', 0xFF),
      );

      final result = sut.mapToCommon(unknownPropChanged);
      expect(result, isNull);
    });

    test('maps aperture changed event', () {
      const apertureChanged = PropValueChanged(
        PtpPropertyCode.aperture,
        ControlPropType.aperture,
        EosPtpIntPropValue('16', 0x48),
      );

      final result = sut.mapToCommon(apertureChanged);

      expect(
        result,
        const CameraUpdateEvent.propValueChanged(
          ControlPropType.aperture,
          EosPtpIntPropValue('16', 0x48),
        ),
      );
    });

    test('maps iso changed event', () {
      const isoChanged = PropValueChanged(
        PtpPropertyCode.iso,
        ControlPropType.iso,
        EosPtpIntPropValue('Auto', 0x00),
      );

      final result = sut.mapToCommon(isoChanged);

      expect(
        result,
        const CameraUpdateEvent.propValueChanged(
          ControlPropType.iso,
          EosPtpIntPropValue('Auto', 0x00),
        ),
      );
    });
  });

  group('on allowedValuesChanged event', () {
    test('maps allowedValuesChanged event', () {
      const allowedIsoValuesChanged = AllowedValuesChanged(
        PtpPropertyCode.iso,
        ControlPropType.iso,
        [
          EosPtpIntPropValue('100', 0x48),
          EosPtpIntPropValue('200', 0x50),
          EosPtpIntPropValue('400', 0x58),
        ],
      );

      final result = sut.mapToCommon(allowedIsoValuesChanged);

      expect(
        result,
        const CameraUpdateEvent.propAllowedValuesChanged(
          ControlPropType.iso,
          [
            EosPtpIntPropValue('100', 0x48),
            EosPtpIntPropValue('200', 0x50),
            EosPtpIntPropValue('400', 0x58),
          ],
        ),
      );
    });
  });
}
