import 'dart:typed_data';

import '../../common/extensions/list_extensions.dart';
import 'int_as_hex_string_extension.dart';

extension DumpHexDataExtension on Uint8List {
  String dumpAsHex({
    bool asValidList = false,
    bool withLineNumbers = false,
    int indentationCount = 3,
  }) {
    if (isEmpty) {
      return '[]';
    }

    final hexValues =
        map((value) => value.asHex(withPrefix: asValidList, padLeft: 2))
            .toList();

    var line = 0;
    final indent = ' ' * indentationCount;
    final startOfDump = withLineNumbers
        ? '↓↓↓↓ [\n${_formatLineNumber(line)}$indent'
        : '[\n$indent';
    final buffer = StringBuffer(startOfDump);

    var counter = 1;
    for (var (index, value) in hexValues.indexed) {
      final isLastValue = index == hexValues.lastIndex;
      buffer.write(value);
      if (asValidList) {
        buffer.write(',');
      }

      if (counter % 16 == 0) {
        line++;
        if (counter != hexValues.length) {
          final newLineStart = withLineNumbers
              ? '\n${_formatLineNumber(line)}$indent'
              : '\n$indent';

          buffer.write(newLineStart);
        }
      } else if (counter % 8 == 0 && !isLastValue) {
        buffer.write('  ');
      } else if (!isLastValue) {
        buffer.write(' ');
      }

      counter++;
    }

    final endOfDump = withLineNumbers ? '\n↑↑↑↑ ]' : '\n]';
    buffer.write(endOfDump);

    return buffer.toString();
  }

  String _formatLineNumber(int line) =>
      line.asHex(withPrefix: false, padLeft: 4);
}
