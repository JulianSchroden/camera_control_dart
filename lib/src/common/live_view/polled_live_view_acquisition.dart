import '../adapter/polled_data_stream_controller.dart';
import '../camera.dart';
import 'live_view_data.dart';

mixin PolledLiveViewAcquisition on Camera {
  @override
  Stream<LiveViewData> liveView({
    Duration pollInterval = const Duration(milliseconds: 200),
  }) {
    final controller = PolledDataStreamController<LiveViewData>(
      pollInterval: pollInterval,
      onListen: () => startLiveView(),
      pollData: (sink) async {
        try {
          final data = await getLiveViewData();
          sink.add(data);
        } catch (e, s) {
          sink.addError(e, s);
        }
      },
      onCancel: () => stopLiveView(),
    );

    return controller.stream;
  }

  Future<void> startLiveView();
  Future<void> stopLiveView();
  Future<LiveViewData> getLiveViewData();
}
