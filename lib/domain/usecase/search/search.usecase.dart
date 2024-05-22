


import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';
import 'package:uq_system_app/domain/entities/params/search.params.dart';
import 'package:uq_system_app/domain/entities/search_result.dart';

import '../../repositories/search.repository.dart';

@injectable
class SearchUseCase extends UseCase<SearchResult, SearchParams>{
  final SearchRepository repository;
  const SearchUseCase(this.repository);
  @override
  Future<SearchResult> call(SearchParams params) {
    return repository.search(params);
  }

}