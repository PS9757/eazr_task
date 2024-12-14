import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/exception.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/category/model/category_model.dart';
import 'package:eazr/data/home/datasource/home_remote_datasource.dart';
import 'package:eazr/data/home/model/most_popular_model.dart';
import 'package:eazr/data/home/model/top_stories_model.dart';
import 'package:eazr/domain/home/repository/home_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImplementation extends HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImplementation(this.homeRemoteDatasource);

  @override
  Future<Either<Failure, List<PopularModel>>> getLatestNews() async {
    try {
      final List<PopularModel> getPagesModel =
          await homeRemoteDatasource.getLatestNews();
      return Right<Failure, List<PopularModel>>(getPagesModel);
    } on NotFoundException {
      return Left<Failure, List<PopularModel>>(NotFoundFailure());
    } on ServerUnavailableException {
      return Left<Failure, List<PopularModel>>(ServerUnavailableFailure());
    } on InternalServerException {
      return Left<Failure, List<PopularModel>>(InternalServerFailure());
    } on BadRequestException {
      return Left<Failure, List<PopularModel>>(BadRequestFailure());
    } on NoInternetConnectionException {
      return Left<Failure, List<PopularModel>>(NoInternetConnectionFailure());
    } on ParseJsonException {
      return Left<Failure, List<PopularModel>>(ParseJsonFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getSectionData() async {
    try {
      final List<Map<String, dynamic>> getSectionData =
          await homeRemoteDatasource.getSectionData();
      return Right<Failure, List<Map<String, dynamic>>>(getSectionData);
    } on NotFoundException {
      return Left<Failure, List<Map<String, dynamic>>>(NotFoundFailure());
    } on ServerUnavailableException {
      return Left<Failure, List<Map<String, dynamic>>>(
          ServerUnavailableFailure());
    } on InternalServerException {
      return Left<Failure, List<Map<String, dynamic>>>(InternalServerFailure());
    } on BadRequestException {
      return Left<Failure, List<Map<String, dynamic>>>(BadRequestFailure());
    } on NoInternetConnectionException {
      return Left<Failure, List<Map<String, dynamic>>>(
          NoInternetConnectionFailure());
    } on ParseJsonException {
      return Left<Failure, List<Map<String, dynamic>>>(ParseJsonFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getContentData({
    required String section,
  }) async {
    try {
      final List<CategoryModel> getContentData =
          await homeRemoteDatasource.getContentData(
        section: section,
      );
      return Right<Failure, List<CategoryModel>>(getContentData);
    } on NotFoundException {
      return Left<Failure, List<CategoryModel>>(NotFoundFailure());
    } on ServerUnavailableException {
      return Left<Failure, List<CategoryModel>>(ServerUnavailableFailure());
    } on InternalServerException {
      return Left<Failure, List<CategoryModel>>(InternalServerFailure());
    } on BadRequestException {
      return Left<Failure, List<CategoryModel>>(BadRequestFailure());
    } on NoInternetConnectionException {
      return Left<Failure, List<CategoryModel>>(NoInternetConnectionFailure());
    } on ParseJsonException {
      return Left<Failure, List<CategoryModel>>(ParseJsonFailure());
    }
  }

  @override
  Future<Either<Failure, List<TopStoriesModel>>> getTopStories() async {
    try {
      final List<TopStoriesModel> getPopularData =
          await homeRemoteDatasource.getTopStories();
      return Right<Failure, List<TopStoriesModel>>(getPopularData);
    } on NotFoundException {
      return Left<Failure, List<TopStoriesModel>>(NotFoundFailure());
    } on ServerUnavailableException {
      return Left<Failure, List<TopStoriesModel>>(ServerUnavailableFailure());
    } on InternalServerException {
      return Left<Failure, List<TopStoriesModel>>(InternalServerFailure());
    } on BadRequestException {
      return Left<Failure, List<TopStoriesModel>>(BadRequestFailure());
    } on NoInternetConnectionException {
      return Left<Failure, List<TopStoriesModel>>(
          NoInternetConnectionFailure());
    } on ParseJsonException {
      return Left<Failure, List<TopStoriesModel>>(ParseJsonFailure());
    }
  }
}
