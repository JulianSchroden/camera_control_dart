import 'dart:io';

import 'package:camera_control_dart/src/eos_cine_http/adapter/http_adapter.dart';
import 'package:camera_control_dart/src/eos_cine_http/communication/action_factory.dart';
import 'package:camera_control_dart/src/eos_cine_http/communication/actions/get_info_action.dart';
import 'package:camera_control_dart/src/eos_cine_http/communication/actions/login_action.dart';
import 'package:camera_control_dart/src/eos_cine_http/models/http_adapter_response.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpAdapter extends Mock implements HttpAdapter {}

class MockHttpAdapterResponse extends Mock implements HttpAdapterResponse {}

// Actions
class MockActionFactory extends Mock implements ActionFactory {}

class MockLoginAction extends Mock implements LoginAction {}

class MockGetInfoAction extends Mock implements GetInfoAction {}
