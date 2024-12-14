// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:eazr/core/api/api.dart' as _i831;
import 'package:eazr/core/errors/api_expection_handler.dart' as _i878;
import 'package:eazr/core/injectable_modules/hive_injectable_module.dart'
    as _i99;
import 'package:eazr/core/injectable_modules/network_injectable_module.dart'
    as _i48;
import 'package:eazr/data/home/datasource/home_remote_datasource.dart' as _i138;
import 'package:eazr/data/home/repository_implementation/home_repository_implementation.dart'
    as _i53;
import 'package:eazr/data/search/datasource/search_datasource.dart' as _i764;
import 'package:eazr/data/search/repository_implementation/search_repository_implementation.dart'
    as _i788;
import 'package:eazr/domain/category/usecase/get_content_data_usecase.dart'
    as _i510;
import 'package:eazr/domain/category/usecase/get_section_list_usecase.dart'
    as _i532;
import 'package:eazr/domain/home/repository/home_repository.dart' as _i543;
import 'package:eazr/domain/home/usecase/get_popular_news_usecase.dart' as _i12;
import 'package:eazr/domain/home/usecase/get_top_stories_usecase.dart' as _i879;
import 'package:eazr/domain/search/repository/search_repository.dart' as _i43;
import 'package:eazr/domain/search/usecase/search_usecase.dart' as _i185;
import 'package:eazr/presentation/category/bloc/category_bloc/category_bloc.dart'
    as _i225;
import 'package:eazr/presentation/home/bloc/home_bloc/home_bloc.dart' as _i636;
import 'package:eazr/presentation/home/bloc/top_stories_bloc/top_stories_bloc.dart'
    as _i586;
import 'package:eazr/presentation/search/bloc/search_bloc/search_bloc.dart'
    as _i551;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveInjectableModule = _$HiveInjectableModule();
    final networkInjectableModule = _$NetworkInjectableModule();
    gh.singleton<_i878.ApiExceptionHandler>(() => _i878.ApiExceptionHandler());
    gh.lazySingleton<_i986.HiveInterface>(() => hiveInjectableModule.hive);
    gh.lazySingleton<_i519.Client>(() => networkInjectableModule.client);
    gh.lazySingleton<_i831.API>(() => networkInjectableModule.api);
    gh.singleton<_i764.SearchDatasource>(() => _i764.SearchDatasourceImpl(
          gh<_i878.ApiExceptionHandler>(),
          gh<_i519.Client>(),
          gh<_i831.API>(),
        ));
    gh.singleton<_i138.HomeRemoteDatasource>(
        () => _i138.HomeRemoteDatasourceImpl(
              gh<_i878.ApiExceptionHandler>(),
              gh<_i519.Client>(),
              gh<_i831.API>(),
            ));
    gh.lazySingleton<_i543.HomeRepository>(() =>
        _i53.HomeRepositoryImplementation(gh<_i138.HomeRemoteDatasource>()));
    gh.lazySingleton<_i43.SearchRepository>(() =>
        _i788.SearchRepositoryImplementation(gh<_i764.SearchDatasource>()));
    gh.lazySingleton<_i185.SearchUseCase>(
        () => _i185.SearchUseCase(gh<_i43.SearchRepository>()));
    gh.factory<_i551.SearchBloc>(
        () => _i551.SearchBloc(gh<_i185.SearchUseCase>()));
    gh.lazySingleton<_i532.GetSectionListUseCase>(
        () => _i532.GetSectionListUseCase(gh<_i543.HomeRepository>()));
    gh.lazySingleton<_i12.GetPopularNewsUseCase>(
        () => _i12.GetPopularNewsUseCase(gh<_i543.HomeRepository>()));
    gh.lazySingleton<_i879.GetTopStoriesUseCase>(
        () => _i879.GetTopStoriesUseCase(gh<_i543.HomeRepository>()));
    gh.lazySingleton<_i510.GetContentDataUseCase>(
        () => _i510.GetContentDataUseCase(gh<_i543.HomeRepository>()));
    gh.factory<_i636.HomeBloc>(
        () => _i636.HomeBloc(gh<_i12.GetPopularNewsUseCase>()));
    gh.factory<_i225.CategoryBloc>(() => _i225.CategoryBloc(
          gh<_i532.GetSectionListUseCase>(),
          gh<_i510.GetContentDataUseCase>(),
        ));
    gh.factory<_i586.TopStoriesBloc>(
        () => _i586.TopStoriesBloc(gh<_i879.GetTopStoriesUseCase>()));
    return this;
  }
}

class _$HiveInjectableModule extends _i99.HiveInjectableModule {}

class _$NetworkInjectableModule extends _i48.NetworkInjectableModule {}
