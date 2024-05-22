import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/search_result.dart';

import '../../domain/entities/params/search.params.dart';
import '../../domain/repositories/search.repository.dart';
import '../sources/network/network.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  final NetworkDataSource _networkDataSource;

  SearchRepositoryImpl(this._networkDataSource);

  @override
  Future<SearchResult> search(SearchParams params) async {
    var result = await _networkDataSource.search(
        title: params.title,
        page: params.page,
        perPage: params.perPage,
        searchType: params.type.name);
    return result.data.mapToEntity();
  }

  @override
  Future<List<String>> getSuggestions(String keyword) async {
    var result = await _networkDataSource.getSuggestSearch(keyword);
    return result.data;
  }
}
