import 'dart:io';

import 'package:camera_control_dart/src/common/camera_config.dart';
import 'package:camera_control_dart/src/eos_cine_http/eos_cine_http_camera.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../camera_control_mocks.dart';

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

void main() {
  late EosCineHttpCamera sut;
  late MockHttpAdapter mockHttpAdapter;

  setUp(() {
    mockHttpAdapter = MockHttpAdapter();
    sut = EosCineHttpCamera(mockHttpAdapter, CameraConfig());
  });
}
