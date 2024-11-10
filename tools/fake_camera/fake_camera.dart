import 'dart:async';
import 'dart:io';

import 'package:camera_control_dart/src/common/extensions/list_extensions.dart';

import 'ptp_server.dart';

const ptpIpPort = 15740;

void handleConnection(Socket commandSocket) {
  final ptpServer = PtpServer(commandSocket);
  ptpServer.listen();
}

Future<InternetAddress?> getWifiIpAddress() async {
  final networkInterfaces =
      await NetworkInterface.list(type: InternetAddressType.IPv4);
  final wifiInterface = networkInterfaces
      .firstWhereOrNull((interface) => interface.name == 'en0');

  return wifiInterface?.addresses.firstOrNull;
}

void main() async {
  final wifiIpAddress = await getWifiIpAddress();
  if (wifiIpAddress == null) {
    print('Failed to obtain wifi ip address');
    return;
  }

  print("Starting Server on ${wifiIpAddress.address}:$ptpIpPort");
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, ptpIpPort);
  server.listen(handleConnection);
}
