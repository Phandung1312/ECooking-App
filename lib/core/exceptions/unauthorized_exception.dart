import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/core/languages/translation_keys.g.dart';

class UnauthorizedException extends BaseException {
  UnauthorizedException() : super(LocaleKeys.Errors_NetworkError);
}
