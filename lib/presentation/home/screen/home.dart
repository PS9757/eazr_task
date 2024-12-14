import 'package:carousel_slider/carousel_slider.dart';
import 'package:eazr/core/constants/sizedbox_ratio.dart';
import 'package:eazr/presentation/home/bloc/home_bloc/home_bloc.dart';
import 'package:eazr/presentation/home/bloc/top_stories_bloc/top_stories_bloc.dart';
import 'package:eazr/presentation/home/screen/popular_details_screen.dart';
import 'package:eazr/presentation/home/widgets/sub_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc homeBloc;
  late TopStoriesBloc topStoriesBloc;
  ScrollController topStoryScrollController = ScrollController();

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    topStoriesBloc = context.read<TopStoriesBloc>();
    homeBloc.add(GetPopularNewsEvent());
    topStoriesBloc.add(GetTopStoriesEvent());

    topStoryScrollController.addListener(_scrollListener);
    super.initState();
  }

  //function for max scroll extent
  void _scrollListener() {
    if (topStoryScrollController.position.pixels ==
        topStoryScrollController.position.maxScrollExtent) {
      debugPrint('End of List');
      topStoriesBloc.add(InfiniteScrollEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          homeBloc.add(GetPopularNewsEvent());
          topStoriesBloc.add(GetTopStoriesEvent());
        },
        color: Colors.red,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: size.width * SizedBoxRatio.sizedBoxWidth8,
              right: size.width * SizedBoxRatio.sizedBoxWidth8,
              top: size.height * SizedBoxRatio.sizedBoxHeight8,
              bottom: size.height * SizedBoxRatio.sizedBoxHeight2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubHeadingWidget(
                  headingTitle: 'Popular News',
                ),
                SizedBox(
                  height: size.height * SizedBoxRatio.sizedBoxHeight10,
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state) {
                      case HomeInitial():
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [1].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: size.width,
                                        height: size.height *
                                            SizedBoxRatio.sizedBoxHeight250,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        );
                      case HomeLoading():
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [1].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: size.width,
                                        height: size.height *
                                            SizedBoxRatio.sizedBoxHeight250,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          // image: DecorationImage(
                                          //   image: i.media.isNotEmpty &&
                                          //       i.media[0].mediaMetadata[2]
                                          //           .url.isNotEmpty
                                          //       ? NetworkImage(
                                          //     i.media[0].mediaMetadata[2]
                                          //         .url,
                                          //   )
                                          //       : const AssetImage(
                                          //       'assets/images/placeholder.jpg'),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        );
                      case HomeLoaded():
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: state.popularModel!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    debugPrint('Tapped');
                                    debugPrint('i ${i.toJson()}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PopularDetailsScreen(
                                                    popularModel: i)));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: size.width,
                                        height: size.height *
                                            SizedBoxRatio.sizedBoxHeight250,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: i.media.isNotEmpty &&
                                                    i.media[0].mediaMetadata[2]
                                                        .url.isNotEmpty
                                                ? NetworkImage(
                                                    i.media[0].mediaMetadata[2]
                                                        .url,
                                                  )
                                                : const AssetImage(
                                                    'assets/images/placeholder.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: size.width * 0.5,
                                          constraints: BoxConstraints(
                                            maxHeight: size.width *
                                                SizedBoxRatio.sizedBoxHeight100,
                                          ),
                                          // height: size.height * SizedBoxRatio.sizedBoxHeight100,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF5F5F5)
                                                .withAlpha((0.5 * 255).round()),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withAlpha(
                                                    (0.5 * 200).round()),
                                                blurRadius: 7,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              i.title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      case HomeError():
                        return SizedBox(
                          height: size.height * 0.4,
                          child: Center(
                            child: Column(
                              children: [
                                Text('Failure ${state.failure}'),
                                ElevatedButton(
                                  onPressed: () {
                                    homeBloc.add(GetPopularNewsEvent());
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                    }
                  },
                ),
                SizedBox(
                  height: size.height * SizedBoxRatio.sizedBoxHeight10,
                ),
                Text(
                  'Top Stories',
                  style: TextStyle(
                    fontSize: size.height * SizedBoxRatio.sizedBoxHeight18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * SizedBoxRatio.sizedBoxHeight10,
                ),
                BlocBuilder<TopStoriesBloc, TopStoriesState>(
                  bloc: topStoriesBloc,
                  builder: (context, state) {
                    switch (state) {
                      case TopStoriesInitial():
                        return SizedBox(
                          height: size.height * 0.51,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: size.height *
                                      SizedBoxRatio.sizedBoxHeight150,
                                  // width:
                                  //     size.width * SizedBoxRatio.sizedBoxWidth100,
                                  margin: EdgeInsets.only(
                                    top: index == 0
                                        ? 0
                                        : size.width *
                                            SizedBoxRatio.sizedBoxWidth10,
                                    bottom: index == 9
                                        ? 0
                                        : size.width *
                                            SizedBoxRatio.sizedBoxWidth10,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width *
                                        SizedBoxRatio.sizedBoxWidth10,
                                    vertical: size.height *
                                        SizedBoxRatio.sizedBoxHeight5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.amber,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      case TopStoriesLoading():
                        return SizedBox(
                          height: size.height * 0.51,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  height: size.height *
                                      SizedBoxRatio.sizedBoxHeight150,
                                  // width:
                                  //     size.width * SizedBoxRatio.sizedBoxWidth100,
                                  margin: EdgeInsets.only(
                                    top: index == 0
                                        ? 0
                                        : size.width *
                                            SizedBoxRatio.sizedBoxWidth10,
                                    bottom: index == 9
                                        ? 0
                                        : size.width *
                                            SizedBoxRatio.sizedBoxWidth10,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width *
                                        SizedBoxRatio.sizedBoxWidth10,
                                    vertical: size.height *
                                        SizedBoxRatio.sizedBoxHeight5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.amber,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      case TopStoriesLoaded():
                        return SizedBox(
                          height: size.height * 0.51,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.topStoriesModel.length,
                            controller: topStoryScrollController,
                            itemBuilder: (context, index) {
                              return Container(
                                height:
                                    size.height * SizedBoxRatio.sizedBoxHeight150,
                                // width:
                                //     size.width * SizedBoxRatio.sizedBoxWidth100,
                                margin: EdgeInsets.only(
                                  top: index == 0
                                      ? 0
                                      : size.width *
                                          SizedBoxRatio.sizedBoxWidth10,
                                  bottom:
                                      index == state.topStoriesModel.length - 1
                                          ? 0
                                          : size.width *
                                              SizedBoxRatio.sizedBoxWidth10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      size.width * SizedBoxRatio.sizedBoxWidth10,
                                  vertical:
                                      size.height * SizedBoxRatio.sizedBoxHeight5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      state.topStoriesModel[index].multimedia
                                              .isNotEmpty
                                          ? state.topStoriesModel[index]
                                              .multimedia[0].url
                                          : 'https://via.placeholder.com/150',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.topStoriesModel[index].title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height *
                                            SizedBoxRatio.sizedBoxHeight18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      state.topStoriesModel[index].byline,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height *
                                            SizedBoxRatio.sizedBoxHeight14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      case TopStoriesError():
                        return SizedBox(
                          height: size.height * 0.4,
                          child: Center(
                            child: Column(
                              children: [
                                Text('Failure ${state.failure}'),
                                ElevatedButton(
                                  onPressed: () {
                                    topStoriesBloc.add(GetTopStoriesEvent());
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
