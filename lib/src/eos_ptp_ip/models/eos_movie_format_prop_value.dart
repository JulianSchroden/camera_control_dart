import 'dart:typed_data';

import '../../common/extensions/list_extensions.dart';
import '../adapter/ptp_packet_builder.dart';
import '../adapter/ptp_packet_reader.dart';
import '../constants/ptp_property.dart';

class EosMovieFormatPropValue {
  const EosMovieFormatPropValue({
    required this.resolution,
    required this.sensorReadout,
    required this.frameRate,
    required this.allowedFramerates,
    required this.codec,
    required this.allowedCodecs,
  });

  final EosFrameRate frameRate;
  final List<EosFrameRate> allowedFramerates;

  final EosResolution resolution;

  final EosCodec codec;
  final List<EosCodec> allowedCodecs;

  final EosSensorReadout sensorReadout;

  factory EosMovieFormatPropValue.f4kFine({
    EosFrameRate frameRate = EosFrameRate.fps_25_00,
    EosCodec codec = EosCodec.ipbStandard,
  }) =>
      EosMovieFormatPropValue(
        resolution: EosResolution.res_3840x2160,
        sensorReadout: EosSensorReadout.downsampled,
        frameRate: frameRate,
        allowedFramerates: [
          EosFrameRate.fps_23_98,
          EosFrameRate.fps_25_00,
          EosFrameRate.fps_27_92,
        ],
        codec: codec,
        allowedCodecs: [
          EosCodec.ipbStandard,
          EosCodec.ipbLight,
        ],
      );
  factory EosMovieFormatPropValue.f4k({
    EosFrameRate frameRate = EosFrameRate.fps_25_00,
    EosCodec codec = EosCodec.ipbStandard,
  }) =>
      EosMovieFormatPropValue(
        resolution: EosResolution.res_3840x2160,
        sensorReadout: EosSensorReadout.lineSkipped,
        frameRate: frameRate,
        allowedFramerates: [
          EosFrameRate.fps_23_98,
          EosFrameRate.fps_25_00,
          EosFrameRate.fps_27_92,
          EosFrameRate.fps_50_00,
          EosFrameRate.fps_59_94,
        ],
        codec: codec,
        allowedCodecs: [
          EosCodec.ipbStandard,
          EosCodec.ipbLight,
        ],
      );
  factory EosMovieFormatPropValue.f4kCropped({
    EosFrameRate frameRate = EosFrameRate.fps_50_00,
    EosCodec codec = EosCodec.ipbStandard,
  }) =>
      EosMovieFormatPropValue(
        resolution: EosResolution.res_3840x2160,
        sensorReadout: EosSensorReadout.cropped,
        frameRate: frameRate,
        allowedFramerates: [
          EosFrameRate.fps_50_00,
          EosFrameRate.fps_59_94,
        ],
        codec: codec,
        allowedCodecs: [
          EosCodec.ipbStandard,
          EosCodec.ipbLight,
        ],
      );

  factory EosMovieFormatPropValue.fullHD({
    EosFrameRate frameRate = EosFrameRate.fps_25_00,
    EosCodec codec = EosCodec.ipbStandard,
  }) =>
      EosMovieFormatPropValue(
        resolution: EosResolution.res_1920x1080,
        sensorReadout: EosSensorReadout.lineSkipped,
        frameRate: frameRate,
        allowedFramerates: [
          EosFrameRate.fps_23_98,
          EosFrameRate.fps_25_00,
          EosFrameRate.fps_27_92,
          EosFrameRate.fps_50_00,
          EosFrameRate.fps_59_94,
        ],
        codec: codec,
        allowedCodecs: [
          EosCodec.ipbStandard,
          EosCodec.ipbLight,
        ],
      );

  EosMovieFormatPropValue copyWith({
    EosCodec? codec,
    EosFrameRate? frameRate,
  }) =>
      EosMovieFormatPropValue(
        resolution: resolution,
        sensorReadout: sensorReadout,
        frameRate: frameRate ?? this.frameRate,
        allowedFramerates: allowedFramerates,
        codec: codec ?? this.codec,
        allowedCodecs: allowedCodecs,
      );

  Uint8List mapData() {
    PtpPacketBuilder builder = PtpPacketBuilder();
    builder.addUInt32(frameRate.native);
    builder.addUInt32(resolution.native);
    builder.addUInt32(0x3); // unknown value
    builder.addUInt32(0x1); // unknown value
    builder.addUInt32(codec.native);
    builder.addUInt32(0x0); // unknown value
    builder.addUInt32(0x2); // unknown value
    builder.addUInt32(0xa); // unknown value
    builder.addUInt32(sensorReadout.native);

    return builder.build().data;
  }

  EosMovieFormatPropValue? fromData(PtpPacketReader packetReader) {
    final segment = packetReader.readSegment();
    if (segment.unconsumedBytes < 36) {
      return null;
    }

    final frameRateRaw = segment.getUint32();
    final resolutionRaw = segment.getUint32();
    segment.skipBytes(4); // unknown value
    segment.skipBytes(4); // unknown value
    final codecRaw = segment.getUint32();
    segment.skipBytes(4); // unknown value
    segment.skipBytes(4); // unknown value
    segment.skipBytes(4); // unknown value
    final sensorReadoutRaw = segment.getUint32();

    final frameRate = EosFrameRate.values
        .firstWhereOrNull((frameRate) => frameRate.native == frameRateRaw);
    final resolution = EosResolution.values
        .firstWhereOrNull((resolution) => resolution.native == resolutionRaw);
    final codec =
        EosCodec.values.firstWhereOrNull((codec) => codec.native == codecRaw);
    final sensorReadout = EosSensorReadout.values.firstWhereOrNull(
        (sensorReadout) => sensorReadout.native == sensorReadoutRaw);

    if (frameRate == null ||
        resolution == null ||
        codec == null ||
        sensorReadout == null) {
      return null;
    }

    return EosMovieFormatPropValue(
      resolution: resolution,
      sensorReadout: sensorReadout,
      frameRate: frameRate,
      allowedFramerates: allowedFramerates,
      codec: codec,
      allowedCodecs: allowedCodecs,
    );
  }
}

enum EosFrameRate implements EosValue {
  fps_23_98(native: 2398, common: '23.98 fps', system: EosVideoSystem.ntsc),
  fps_25_00(native: 2500, common: '25.00 fps', system: EosVideoSystem.pal),
  fps_27_92(native: 2997, common: '27.97 fps', system: EosVideoSystem.ntsc),
  fps_50_00(native: 5000, common: '50.00 fps', system: EosVideoSystem.pal),
  fps_59_94(native: 5994, common: '59.94 fps', system: EosVideoSystem.ntsc);

  const EosFrameRate({
    required this.native,
    required this.common,
    required this.system,
  });

  @override
  final int native;

  @override
  final String common;

  final EosVideoSystem system;
}

enum EosVideoSystem { pal, ntsc }

enum EosResolution implements EosValue {
  res_3840x2160(native: 0x5, common: '3840x2160'),
  res_1920x1080(native: 0x0, common: '1920x1080');

  const EosResolution({required this.native, required this.common});

  @override
  final int native;

  @override
  final String common;
}

enum EosCodec implements EosValue {
  ipbStandard(native: 0x0, common: 'Standard (IPB)'),
  ipbLight(native: 0x1, common: 'Light (IPB)');

  const EosCodec({required this.native, required this.common});

  @override
  final int native;

  @override
  final String common;
}

enum EosSensorReadout implements EosValue {
  downsampled(native: 0x10, common: 'Fine'),
  lineSkipped(native: 0x0, common: 'line-skipped'),
  cropped(native: 0x8, common: 'cropped');

  const EosSensorReadout({required this.native, required this.common});

  @override
  final int native;

  @override
  final String common;
}


// 0
// 3840x2160 4k Fine 25,00 B/s Standard (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 10 00 00 00
// ]))

// 1
// 3840x2160 4k Fine 25,00 B/s Light (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 10 00 00 00
// ]))

// 2
// 3840x2160 4k 25,00 B/s Standard (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 3
// 3840x2160 4k 25,00 B/s Light (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 4
// 3840x2160 4k 50,00 B/s Standard (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 5
// 3840x2160 4k 50,00 B/s Light (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 6
// 3840x2160 4k Crop 50,00 B/s Standard (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 08 00 00 00
// ]))

// 7
// 3840x2160 4k Crop 50,00 B/s Light (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
//    01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 08 00 00 00
// ]))

// 8
// 1920x1080 25,00 B/s Standard (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 c4 09 00 00  00 00 00 00 03 00 00 00
//    01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 9
// 1920x1080 25,00 B/s Light (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 c4 09 00 00  00 00 00 00 03 00 00 00
//    01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 10
// 1920x1080 50,00 B/s Standard (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 88 13 00 00  00 00 00 00 03 00 00 00
//    01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))

// 11
// 1920x1080 50,00 B/s Light (IPB)
// PropValueChanged(propCode: 0xd20d, propType: null, propValue: FallbackPropValue(payload: [
//    28 00 00 00 88 13 00 00  00 00 00 00 03 00 00 00
//    01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
//    0a 00 00 00 00 00 00 00
// ]))