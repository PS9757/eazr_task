import 'package:dartz/dartz.dart';
import 'package:eazr/core/errors/failures.dart';
import 'package:eazr/data/category/model/category_model.dart';
import 'package:eazr/data/home/model/most_popular_model.dart';
import 'package:eazr/data/home/model/top_stories_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PopularModel>>> getLatestNews();

  Future<Either<Failure, List<Map<String, dynamic>>>> getSectionData();

  Future<Either<Failure, List<CategoryModel>>> getContentData({
    required String section,
  });

  Future<Either<Failure, List<TopStoriesModel>>> getTopStories();
}
