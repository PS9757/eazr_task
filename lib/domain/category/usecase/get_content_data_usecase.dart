import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/core/usecase/usecase_with_either.dart';
import 'package:eazr/data/category/model/category_model.dart';
import 'package:eazr/domain/home/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetContentDataUseCase
    extends UsecaseWithEither<List<CategoryModel>, String> {
  final HomeRepository homeRepository;

  GetContentDataUseCase(this.homeRepository);

  @override
  Future<Either<Failure, List<CategoryModel>>> call(String params) {
    return homeRepository.getContentData(section: params);
  }
}
