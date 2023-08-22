import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../../../common/adapter/date_time_adapter.dart';
import '../../../common/extensions/list_extensions.dart';
import '../../../interface/models/live_view_data.dart';
import '../../constants/api_endpoint_path.dart';
import '../get_acion.dart';

class GetLiveViewImageAction extends GetAction<LiveViewData> {
  final DateTimeAdapter dateTimeAdapter;

  const GetLiveViewImageAction(
    super.httpAdapter, [
    this.dateTimeAdapter = const DateTimeAdapter(),
  ]);

  @override
  Future<LiveViewData> call() async {
    final timeStamp = DateTime.now().toIso8601String();

    final response = await httpAdapter.getRaw(
      ApiEndpointPath.liveViewGetImage,
      {'d': timeStamp},
    );

    final imageBytes = await consolidateHttpClientResponseBytes(response);

    return LiveViewData(imageBytes: imageBytes);
  }

  Future<Uint8List> consolidateHttpClientResponseBytes(
    HttpClientResponse response, {
    bool autoUncompress = true,
  }) {
    final completer = Completer<Uint8List>.sync();
    final chunks = <List<int>>[];

    response.listen((chunk) {
      chunks.add(chunk);
    }, onDone: () {
      completer.complete(Uint8List.fromList(List.from(flatten(chunks))));
    }, onError: completer.completeError, cancelOnError: true);

    return completer.future;
  }
}
