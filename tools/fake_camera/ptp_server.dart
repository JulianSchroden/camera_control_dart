import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_packet_builder.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/adapter/ptp_packet_reader.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_data_mode.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_package_type.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/constants/ptp_response_code.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/extensions/int_as_hex_string_extension.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/models/ptp_packet.dart';

class PtpServer {
  final Socket commandSocket;
  StreamSubscription<Uint8List>? commandStreamSubscription;
  BytesBuilder bufferBuilder = BytesBuilder();
  bool isIncomingDataMode = false;

  PtpServer(this.commandSocket);

  void listen() {
    commandStreamSubscription = commandSocket.listen((data) {
      print('\nRecieved data of length ${data.length}');
      print(data.dumpAsHex());
      bufferBuilder.add(data);

      final buffer = Uint8List.fromList(bufferBuilder.takeBytes());
      handleRequest(buffer);
    }, onError: (error) {
      print("An error occured");
      print(error);
    }, onDone: () {
      print('Connection closed');
    });
  }

  void sendResponse(PtpPacket responsePacket) async {
    final responseBytes = responsePacket.data;
    print('Responding with response of length ${responseBytes.length}');
    print(responseBytes.dumpAsHex());

    await Future.delayed(Duration(seconds: 3));

    commandSocket.add(responsePacket.data);
  }

  void sendOkayResponse(int transactionId) {
    final packetBuiler = PtpPacketBuilder();
    packetBuiler.addUInt32(PtpPacketType.operationResponse);
    packetBuiler.addUInt16(PtpResponseCode.okay);
    packetBuiler.addUInt32(transactionId);

    final responsePacket = packetBuiler.build();
    sendResponse(responsePacket);
  }

  void handleRequest(Uint8List data) {
    final reader = PtpPacketReader.fromBytes(data);

    if (!reader.hasValidSegment()) {
      return;
    }

    final segmentReader = reader.readSegment();
    final packetType = segmentReader.getUint32();

    switch (packetType) {
      case PtpPacketType.initCommandRequest:
        {
          final packetBuilder = PtpPacketBuilder();
          packetBuilder.addUInt32(PtpPacketType.initCommandAck);
          packetBuilder.addUInt32(1); // connection number
          packetBuilder.add([
            0x00,
            0x00,
            0x00,
            0x00,
            0x00,
            0x00,
            0x00,
            0x00,
            0x00,
            0x01,
            0xf8,
            0xa2,
            0x6d,
            0xae,
            0x50,
            0x68
          ]);
          packetBuilder.addString("Mock Camera Server");
          packetBuilder.addUInt16(0); // version minor
          packetBuilder.addUInt16(1); // version mayor

          final responsePacket = packetBuilder.build();
          sendResponse(responsePacket);
        }
      case PtpPacketType.initEventRequest:
        {
          final packetBuilder = PtpPacketBuilder();
          packetBuilder.addUInt32(PtpPacketType.initEventAck);

          final responsePacket = packetBuilder.build();
          sendResponse(responsePacket);
        }
      case PtpPacketType.operationRequest:
        {
          final dataMode = segmentReader.getUint32();
          if (dataMode == PtpDataMode.withData.value) {
            isIncomingDataMode = true;
          }

          final operationCode = segmentReader.getUint16();
          final transactionId = segmentReader.getUint32();
          print(
              'Handling operation ${operationCode.asHex()}, transactionId: $transactionId');
          if (segmentReader.unconsumedBytes > 0) {
            print('Operation has additional bytes');
            final requestPayload = segmentReader.getRemainingBytes();
            print(requestPayload.dumpAsHex());
          }

          if (isIncomingDataMode) {
            return;
          }

          sendOkayResponse(transactionId);
        }
      case PtpPacketType.startDataPacket:
        {
          final transactionId = segmentReader.getUint32();
          final totalBytes = segmentReader.getUint64();
          print(
              'Received startDataPacket. transactionId: $transactionId, totalByte: $totalBytes');
        }
      case PtpPacketType.endDataPacket:
        {
          final transactionId = segmentReader.getUint32();
          final dataPayload = segmentReader.getRemainingBytes();
          print(
              'Received endDataPacket. transactionId: $transactionId, payload.length = ${dataPayload.length}');
          print(dataPayload.dumpAsHex());
        }
    }
  }
}
