import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/search/model/search_docs_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchDocsModel>>> getSearchData({
    required String query,
    required int page,
  });
}
