import 'package:eazr/core/constants/sizedbox_ratio.dart';
import 'package:eazr/presentation/search/bloc/search_bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc searchBloc;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchBloc = context.read<SearchBloc>();
    searchBloc.add(SearchInitialEvent());
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        debugPrint('scrolling');
        searchBloc.add(ScrollToBottomEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          searchBloc.add(SearchInitialEvent());
        },
        color: Colors.red,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(size.width * SizedBoxRatio.sizedBoxWidth8),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * SizedBoxRatio.sizedBoxHeight50,
                  child: TextFormField(
                    onTapOutside: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    onFieldSubmitted: (value) {
                      searchBloc.add(SearchQueryChangedEvent(query: value));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    switch (state) {
                      case SearchInitial():
                        return SizedBox(
                          height: size.height * 0.8,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case SearchLoading():
                        return SizedBox(
                          height: size.height * 0.8,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case SearchLoaded():
                        debugPrint('length: ${state.searchData.length}');
                        return Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: state.isLoadingMoreData
                                ? state.searchData.length + 1
                                : state.searchData.length,
                            itemBuilder: (context, index) {
                              if (index == state.searchData.length &&
                                  state.isLoadingMoreData) {
                                return SizedBox(
                                  height: size.height *
                                      SizedBoxRatio.sizedBoxHeight100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final searchData = state.searchData[index];
                              return Stack(
                                children: [
                                  Container(
                                    height: size.height *
                                        SizedBoxRatio.sizedBoxHeight200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.only(
                                      bottom: size.height *
                                          SizedBoxRatio.sizedBoxHeight10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(size.height *
                                              SizedBoxRatio.sizedBoxHeight5),
                                          width: size.width * 0.47,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: size.height *
                                                    SizedBoxRatio
                                                        .sizedBoxHeight45,
                                                child: Text(
                                                  searchData.headline.main,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: size.height *
                                                        SizedBoxRatio
                                                            .sizedBoxHeight14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Published: ${DateFormat.yMMMd().format(DateTime.parse(searchData.pubDate))}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: size.height *
                                                      SizedBoxRatio
                                                          .sizedBoxHeight10,
                                                ),
                                              ),
                                              Text(
                                                'BY: ${searchData.byline.original}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: size.height *
                                                      SizedBoxRatio
                                                          .sizedBoxHeight10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height *
                                                    SizedBoxRatio
                                                        .sizedBoxHeight80,
                                                width: size.width * 0.47,
                                                child: Text(
                                                  searchData.snippet,
                                                  // overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: size.height *
                                                        SizedBoxRatio
                                                            .sizedBoxHeight10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //image
                                        Container(
                                          width: size.width * 0.47,
                                          padding: EdgeInsets.all(size.height *
                                              SizedBoxRatio.sizedBoxHeight5),
                                          child: searchData.multimedia.isEmpty
                                              ? Image.asset(
                                                  'assets/images/placeholder.jpg')
                                              : Image.network(
                                                  'https://static01.nyt.com/${searchData.multimedia[0].url}',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        launchUrl(Uri.parse(searchData.webUrl));
                                      },
                                      icon: Image.asset(
                                        'assets/images/web.png',
                                        width: size.width *
                                            SizedBoxRatio.sizedBoxWidth20,
                                        height: size.height *
                                            SizedBoxRatio.sizedBoxHeight20,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        );
                      case SearchError():
                        return Column(
                          children: [
                            Text('Error ${state.message}'),
                            IconButton(
                              onPressed: () {
                                searchBloc.add(SearchInitialEvent());
                              },
                              icon: Icon(Icons.refresh),
                            ),
                          ],
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
