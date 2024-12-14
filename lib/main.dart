import 'package:eazr/presentation/bottom_nav_bar/screen/bottom_nav_bar_screen.dart';
import 'package:eazr/presentation/category/bloc/category_bloc/category_bloc.dart';
import 'package:eazr/presentation/home/bloc/home_bloc/home_bloc.dart';
import 'package:eazr/presentation/home/bloc/top_stories_bloc/top_stories_bloc.dart';
import 'package:eazr/presentation/home/screen/home.dart';
import 'package:eazr/presentation/search/bloc/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injectable_modules/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => di<HomeBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => di<SearchBloc>(),
        ),
        BlocProvider<TopStoriesBloc>(
          create: (context) => di<TopStoriesBloc>(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => di<CategoryBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyCustomBottomNavigationBar(),
      ),
    );
  }
}
