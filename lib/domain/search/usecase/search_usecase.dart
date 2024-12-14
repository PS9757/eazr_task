import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/core/usecase/usecase_with_either.dart';
import 'package:eazr/data/search/model/search_docs_model.dart';
import 'package:eazr/domain/search/repository/search_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SearchUseCase
    extends UsecaseWithEither<List<SearchDocsModel>, SearchUseCaseParams> {
  SearchUseCase(this.searchRepository);

  final SearchRepository searchRepository;

  @override
  Future<Either<Failure, List<SearchDocsModel>>> call(
      SearchUseCaseParams params) {
    return searchRepository.getSearchData(
      page: params.page,
      query: params.query,
    );
  }
}

class SearchUseCaseParams {
  final String query;
  final int page;

  SearchUseCaseParams({
    required this.query,
    required this.page,
  });
}
