import 'package:eazr/core/constants/sizedbox_ratio.dart';
import 'package:eazr/presentation/category/screen/category_screen.dart';
import 'package:eazr/presentation/home/screen/home.dart';
import 'package:eazr/presentation/search/screen/search_screen.dart';
import 'package:flutter/material.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  const MyCustomBottomNavigationBar({super.key});

  @override
  MyCustomBottomNavigationBarState createState() =>
      MyCustomBottomNavigationBarState();
}

class MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  var currentIndex = 0;

  List<Widget> listOfScreens = [
    Home(),
    SearchScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xffF15F60),
      extendBodyBehindAppBar: true,
      body: IndexedStack(
        index: currentIndex,
        children: listOfScreens,
      ),
      bottomNavigationBar: Container(
        height: size.height * SizedBoxRatio.sizedBoxHeight50,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xffec5c5c),
              width: size.width * .002,
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.width * .014),
                Icon(
                  listOfIcons[index],
                  size: size.width * .076,
                  color: index == currentIndex
                      ? Color(0xffF15F60)
                      : Color(0xffA6A6A6),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    top: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .235,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? Color(0xffF15F60)
                        : Color(0xffA6A6A6),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.search,
    Icons.category_outlined,
  ];
}
