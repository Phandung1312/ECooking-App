import 'package:uq_system_app/core/languages/translation_keys.g.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

class NetworkException extends BaseException {
  NetworkException() : super(LocaleKeys.Errors_UnauthorizedError);
}
