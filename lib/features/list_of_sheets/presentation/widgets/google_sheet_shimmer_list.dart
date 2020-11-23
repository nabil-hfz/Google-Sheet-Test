import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/ui/base_shimmer.dart';
import 'package:google_sheet_test/core/utils/width_height.dart';

class GoogleSheetsShimmerList extends StatelessWidget {
  final Random rand = new Random();

  int next(int min, int max) => min + rand.nextInt(max - min);

  buildOneSection(context, width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 12, bottom: 6),
          width: next(60, 185).toDouble(),
          height: next(12, 15).toDouble(),
          color: globalColor.globalWhite,
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, bottom: 6, right: 12),
          width: width * 0.92,
          height: next(16, 18).toDouble(),
          color: globalColor.globalWhite,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = globalSize.setWidthPercentage(100, context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: BaseShimmerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                buildOneSection(context, width),
                buildOneSection(context, width),
                buildOneSection(context, width),
                buildOneSection(context, width),
                buildOneSection(context, width),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(90),
                      height: ScreenUtil().setHeight(40),
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: globalColor.globalWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
