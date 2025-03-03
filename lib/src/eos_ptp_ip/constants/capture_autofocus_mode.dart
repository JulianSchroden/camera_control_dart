enum CaptureAutofocusMode {
  withAutofocus,
  noAutofocus,
}

extension CaptureAutofocusModeValueExtension on CaptureAutofocusMode {
  int get value {
    switch (this) {
      case CaptureAutofocusMode.withAutofocus:
        return 0x00;
      case CaptureAutofocusMode.noAutofocus:
        return 0x01;
    }
  }
}
