import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/core/usecase/usecase_with_either.dart';
import 'package:eazr/data/home/model/most_popular_model.dart';
import 'package:eazr/domain/home/entity/most_popular_entity.dart';
import 'package:eazr/domain/home/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetPopularNewsUseCase
    extends UsecaseWithEither<List<MostPopularEntity>, void> {
  GetPopularNewsUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Either<Failure, List<PopularModel>>> call(void params) {
    return homeRepository.getLatestNews();
  }
}
