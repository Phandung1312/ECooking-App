

import 'package:uq_system_app/domain/entities/params/search.params.dart';
import 'package:uq_system_app/domain/entities/search_result.dart';

abstract class SearchRepository {
  Future<SearchResult> search(SearchParams params);
  Future<List<String>> getSuggestions(String keyword);
}