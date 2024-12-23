enum ZoomLiveView {
  x1,
  x5,
  x10,
}

extension ZoomLiveViewValueExtension on ZoomLiveView {
  int get value =>
    switch (this) {
      ZoomLiveView.x1 => 0x01,
      ZoomLiveView.x5 => 0x5,
      ZoomLiveView.x10 => 0x0a,
    };
}
