import '../adapter/http_adapter.dart';
import '../logging/eos_cine_http_logger.dart';

abstract class GetAction<T> {
  final EosCineHttpLogger logger = const EosCineHttpLogger();

  final HttpAdapter httpAdapter;

  const GetAction(this.httpAdapter);

  Future<T> call();
}
