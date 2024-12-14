import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/core/usecase/usecase_with_either.dart';
import 'package:eazr/domain/home/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetSectionListUseCase
    extends UsecaseWithEither<List<Map<String, dynamic>>, void> {
  GetSectionListUseCase(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(void params) {
    return homeRepository.getSectionData();
  }
}
