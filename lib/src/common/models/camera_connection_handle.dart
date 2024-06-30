import 'package:equatable/equatable.dart';

import 'camera_model.dart';
import 'pairing_data.dart';

/// Describes the connection data required to connect to a camera.
class CameraConnectionHandle extends Equatable {
  final String id;
  final CameraModel model;
  final PairingData pairingData;

  const CameraConnectionHandle({
    required this.id,
    required this.model,
    required this.pairingData,
  });

  @override
  List<Object?> get props => [model];

  @override
  String toString() {
    return 'CameraConnectionHandle(id: $id, model: $model)';
  }
}
