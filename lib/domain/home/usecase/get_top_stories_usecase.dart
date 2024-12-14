import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/core/usecase/usecase_with_either.dart';
import 'package:eazr/data/home/model/top_stories_model.dart';
import 'package:eazr/domain/home/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetTopStoriesUseCase
    extends UsecaseWithEither<List<TopStoriesModel>, void> {
  final HomeRepository homeRepository;

  GetTopStoriesUseCase(this.homeRepository);

  @override
  Future<Either<Failure, List<TopStoriesModel>>> call(void params) {
    return homeRepository.getTopStories();
  }
}
