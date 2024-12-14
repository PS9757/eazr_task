import 'package:eazr/core/constants/sizedbox_ratio.dart';
import 'package:flutter/material.dart';

class SubHeadingWidget extends StatelessWidget {
  final String headingTitle;

  const SubHeadingWidget({super.key, required this.headingTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headingTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // TextButton(
        //   onPressed: () {},
        //   child: Row(
        //     children: [
        //       Text(
        //         'See All',
        //         style: TextStyle(
        //           color: Colors.blue,
        //           fontSize: size.height * SizedBoxRatio.sizedBoxHeight12,
        //         ),
        //       ),
        //       SizedBox(
        //         width: size.width * SizedBoxRatio.sizedBoxWidth5,
        //       ),
        //       Icon(
        //         Icons.arrow_forward,
        //         color: Colors.blue,
        //         size: size.height * SizedBoxRatio.sizedBoxHeight14,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
