import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/exception.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/search/datasource/search_datasource.dart';
import 'package:eazr/data/search/model/search_docs_model.dart';
import 'package:eazr/domain/search/repository/search_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImplementation implements SearchRepository {
  SearchRepositoryImplementation(this.searchDatasource);

  final SearchDatasource searchDatasource;

  @override
  Future<Either<Failure, List<SearchDocsModel>>> getSearchData({
    required String query,
    required int page,
  }) async {
    try {
      final List<SearchDocsModel> getSearchData =
          await searchDatasource.getSearchData(
        page: page,
        query: query,
      );
      return Right<Failure, List<SearchDocsModel>>(getSearchData);
    } on NotFoundException {
      return Left<Failure, List<SearchDocsModel>>(NotFoundFailure());
    } on ServerUnavailableException {
      return Left<Failure, List<SearchDocsModel>>(ServerUnavailableFailure());
    } on InternalServerException {
      return Left<Failure, List<SearchDocsModel>>(InternalServerFailure());
    } on BadRequestException {
      return Left<Failure, List<SearchDocsModel>>(BadRequestFailure());
    } on NoInternetConnectionException {
      return Left<Failure, List<SearchDocsModel>>(
          NoInternetConnectionFailure());
    } on ParseJsonException {
      return Left<Failure, List<SearchDocsModel>>(ParseJsonFailure());
    }
  }
}
