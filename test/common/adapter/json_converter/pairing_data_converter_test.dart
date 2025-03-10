import 'dart:typed_data';

import 'package:camera_control_dart/src/common/adapter/json_converter/pairing_data_converter.dart';
import 'package:camera_control_dart/src/demo/demo_camera_pairing_data.dart';
import 'package:camera_control_dart/src/eos_cine_http/eos_cine_http_camera_pairing_data.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/eos_ptp_ip_camera_pairing_data.dart';
import 'package:test/test.dart';

void main() {
  late PairingDataConverter sut;

  setUp(() {
    sut = const PairingDataConverter();
  });

  group('fromJson', () {
    test('parses Demo PairingData correctly', () {
      final jsonData = {'pairingDataType': 'demo'};

      final pairingData = sut.fromJson(jsonData);

      expect(pairingData, const DemoCameraPairingData());
    });

    test('parses EosCineHttpCameraPairingData correctly', () {
      const ipAddress = '192.168.178.55';
      const jsonData = {
        'pairingDataType': 'eosCineHttp',
        'address': ipAddress,
      };

      final pairingData = sut.fromJson(jsonData);

      expect(
        pairingData,
        const EosCineHttpCameraPairingData(
          address: ipAddress,
        ),
      );
    });

    test('parses EosPtpIpCameraPairingData correctly', () {
      const ipAddress = '192.168.178.55';
      const clientName = 'my phone';
      final guidData = [1, 2, 3, 4, 5];
      final jsonData = {
        'pairingDataType': 'eosPtpIp',
        'address': ipAddress,
        'guid': guidData,
        'clientName': clientName,
      };

      final pairingData = sut.fromJson(jsonData);

      expect(
        pairingData,
        EosPtpIpCameraPairingData(
          address: ipAddress,
          guid: Uint8List.fromList(guidData),
          clientName: clientName,
        ),
      );
    });
  });

  group('toJson', () {
    test('encodes Demo PairingData correctly', () {
      final expectedJson = {'pairingDataType': 'demo'};

      final jsonData = sut.toJson(const DemoCameraPairingData());

      expect(jsonData, expectedJson);
    });

    test('parses EosCineHttpCameraPairingData correctly', () {
      const ipAddress = '192.168.178.55';
      const expectedJson = {
        'pairingDataType': 'eosCineHttp',
        'address': ipAddress,
      };

      final jsonData = sut.toJson(const EosCineHttpCameraPairingData(
        address: ipAddress,
      ));

      expect(jsonData, expectedJson);
    });

    test('parses EosPtpIpCameraPairingData correctly', () {
      const ipAddress = '192.168.178.55';
      const clientName = 'my phone';
      final guidData = [1, 2, 3, 4, 5];
      final expectedJson = {
        'pairingDataType': 'eosPtpIp',
        'address': ipAddress,
        'guid': guidData,
        'clientName': clientName,
      };

      final jsonData = sut.toJson(EosPtpIpCameraPairingData(
        address: ipAddress,
        guid: Uint8List.fromList(guidData),
        clientName: clientName,
      ));

      expect(
        jsonData,
        expectedJson,
      );
    });
  });
}
