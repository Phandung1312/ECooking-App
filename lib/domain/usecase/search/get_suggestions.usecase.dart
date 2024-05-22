

import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/search.repository.dart';

@injectable
class GetSuggestionsUseCase extends UseCase<List<String>, String> {
  final SearchRepository repository;
  const GetSuggestionsUseCase(this.repository);
  @override
  Future<List<String>> call(String params) {
    return repository.getSuggestions(params);
  }

}