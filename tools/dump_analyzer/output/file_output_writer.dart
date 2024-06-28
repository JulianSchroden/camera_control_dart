import 'dart:io';

import 'output_writer.dart';

class FileOutputWriter extends OutputWriter {
  final File outputFile;

  FileOutputWriter({required String fileName}) : outputFile = File(fileName) {
    outputFile.writeAsString('');
  }

  @override
  void write(String output) {
    outputFile.writeAsStringSync(output, mode: FileMode.append);
    outputFile.writeAsStringSync('\n', mode: FileMode.append);
  }
}
