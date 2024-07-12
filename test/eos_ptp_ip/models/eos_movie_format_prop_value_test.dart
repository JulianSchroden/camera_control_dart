import 'package:camera_control_dart/src/eos_ptp_ip/extensions/dump_bytes_extensions.dart';
import 'package:camera_control_dart/src/eos_ptp_ip/models/eos_movie_format_prop_value.dart';
import 'package:test/test.dart';

void main() {
  group('mapData', () {
    test('maps `3840x2160 4k Fine 25,00 fps Standard (IPB)` correctly', () {
      final expected = '''
[
28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 10 00 00 00
]
'''
          .trim();

      final movieFormat = EosMovieFormatPropValue.f4kFine(
        frameRate: EosFrameRate.fps_25_00,
        codec: EosCodec.ipbStandard,
      );

      final mappedData = movieFormat.mapData();

      expect(mappedData.dumpAsHex(indentationCount: 0), expected);
    });
  });

  test('maps `3840x2160 4k Fine 25,00 fps Light (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 10 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4kFine(
      frameRate: EosFrameRate.fps_25_00,
      codec: EosCodec.ipbLight,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `3840x2160 4k 25,00 fps Standard (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4k(
      frameRate: EosFrameRate.fps_25_00,
      codec: EosCodec.ipbStandard,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `3840x2160 4k 25,00 fps Light (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 c4 09 00 00  05 00 00 00 03 00 00 00
01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4k(
      frameRate: EosFrameRate.fps_25_00,
      codec: EosCodec.ipbLight,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `3840x2160 4k 50,00 fps Standard (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4k(
      frameRate: EosFrameRate.fps_50_00,
      codec: EosCodec.ipbStandard,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `3840x2160 4k 50,00 fps Light (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4k(
      frameRate: EosFrameRate.fps_50_00,
      codec: EosCodec.ipbLight,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `3840x2160 4k Crop 50,00 fps Standard (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 08 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4kCropped(
      frameRate: EosFrameRate.fps_50_00,
      codec: EosCodec.ipbStandard,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `3840x2160 4k Crop 50,00 fps Light (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 88 13 00 00  05 00 00 00 03 00 00 00
01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 08 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.f4kCropped(
      frameRate: EosFrameRate.fps_50_00,
      codec: EosCodec.ipbLight,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `1920x1080 25,00 fps Standard (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 c4 09 00 00  00 00 00 00 03 00 00 00
01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.fullHD(
      frameRate: EosFrameRate.fps_25_00,
      codec: EosCodec.ipbStandard,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `1920x1080 25,00 fps Light (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 c4 09 00 00  00 00 00 00 03 00 00 00
01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.fullHD(
      frameRate: EosFrameRate.fps_25_00,
      codec: EosCodec.ipbLight,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `1920x1080 50,00 fps Standard (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 88 13 00 00  00 00 00 00 03 00 00 00
01 00 00 00 00 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.fullHD(
      frameRate: EosFrameRate.fps_50_00,
      codec: EosCodec.ipbStandard,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });

  test('maps `1920x1080 50,00 fps Light (IPB)` correctly', () {
    final expected = '''
[
28 00 00 00 88 13 00 00  00 00 00 00 03 00 00 00
01 00 00 00 01 00 00 00  00 00 00 00 02 00 00 00
0a 00 00 00 00 00 00 00
]
'''
        .trim();

    final movieFormat = EosMovieFormatPropValue.fullHD(
      frameRate: EosFrameRate.fps_50_00,
      codec: EosCodec.ipbLight,
    );

    final mappedData = movieFormat.mapData();

    expect(mappedData.dumpAsHex(indentationCount: 0), expected);
  });
}
