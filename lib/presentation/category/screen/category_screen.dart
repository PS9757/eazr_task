import 'package:eazr/core/constants/sizedbox_ratio.dart';
import 'package:eazr/presentation/category/bloc/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    categoryBloc.add(CategoryLoad());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          categoryBloc.add(CategoryLoad());
        },
        color: Colors.red,
        child: SafeArea(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            bloc: categoryBloc,
            builder: (context, state) {
              switch (state) {
                case CategoryInitial():
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case CategoryLoading():
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case CategoryLoaded():
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * SizedBoxRatio.sizedBoxHeight35,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  categoryBloc.add(CategorySelect(state
                                      .categories[index]['section']
                                      .toString()));
                                },
                                child: Container(
                                  height: size.height *
                                      SizedBoxRatio.sizedBoxHeight30,
                                  // width:
                                  //     size.width * SizedBoxRatio.sizedBoxWidth100,
                                  margin: EdgeInsets.only(
                                    left: index == 0
                                        ? 0
                                        : size.width *
                                            SizedBoxRatio.sizedBoxWidth10,
                                    right: index == state.categories.length - 1
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
                                    color:
                                        state.selectedCategory.toLowerCase() ==
                                                state.categories[index]
                                                        ['display_name']
                                                    .toString()
                                                    .toLowerCase()
                                            ? Colors.red
                                            : Colors.transparent,
                                    border: Border.all(
                                      color: state.selectedCategory
                                                  .toLowerCase() ==
                                              state.categories[index]
                                                      ['display_name']
                                                  .toString()
                                                  .toLowerCase()
                                          ? Colors.transparent
                                          : Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.categories[index]['display_name']
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: state.selectedCategory
                                                    .toLowerCase() ==
                                                state.categories[index]
                                                        ['display_name']
                                                    .toString()
                                                    .toLowerCase()
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * SizedBoxRatio.sizedBoxHeight10,
                        ),
                        SizedBox(
                          height: size.height * 0.825,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.contents.length,
                            itemBuilder: (context, index) {
                              final searchData = state.contents[index];

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
                                                  searchData
                                                      .categoryEntityAbstract,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: size.height *
                                                        SizedBoxRatio
                                                            .sizedBoxHeight14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Published: ${DateFormat.yMMMd().format(searchData.publishedDate)}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: size.height *
                                                      SizedBoxRatio
                                                          .sizedBoxHeight10,
                                                ),
                                              ),
                                              Text(
                                                'BY: ${searchData.byline}',
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
                                                  searchData.title,
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
                                                  searchData.multimedia[1].url,
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
                                        launchUrl(Uri.parse(searchData.url));
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
                        ),
                      ],
                    ),
                  );
                case CategoryError():
                  return SizedBox(
                    height: size.height * 0.4,
                    child: Center(
                      child: Column(
                        children: [
                          Text('Failure ${state.message}'),
                          ElevatedButton(
                            onPressed: () {
                              categoryBloc.add(CategoryLoad());
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
        ),
      ),
    );
  }
}
