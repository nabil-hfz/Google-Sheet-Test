import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/resources/text_size.dart';
import 'package:flutter/material.dart';

class GlobalTextStyle {
  final hugeTSBasic = TextStyle(
    fontSize: textSize.huge,
    fontFamily: 'Hacen Tunisia Lt',
    fontWeight: FontWeight.w900,
    color: globalColor.textColor,
  );

  final lagerTSBasic = TextStyle(
    fontSize: textSize.lager,
    fontFamily: 'Hacen Tunisia Lt',
    color: globalColor.textColor,
  );

  final bigTSBasic =
      TextStyle(fontSize: textSize.big, fontFamily: 'Hacen Tunisia Lt');

  //========================subBig======================================

  final subBigTSBasic =
      TextStyle(fontSize: textSize.subBig, fontFamily: 'Hacen Tunisia Lt');

  //========================normal======================================

  final normalTSBasic =
      TextStyle(fontSize: textSize.normal, fontFamily: 'Hacen Tunisia Lt');

//=========================middle======================================

  final middleTSBasic =
      TextStyle(fontSize: textSize.middle, fontFamily: 'Hacen Tunisia Lt');

  //=========================small======================================

  final smallTSBasic =
      TextStyle(fontSize: textSize.small, fontFamily: 'Hacen Tunisia Lt');

  //========================min======================================
  final minTSBasic =
      TextStyle(fontSize: textSize.min, fontFamily: 'Hacen Tunisia Lt');

  //========================sub-min======================================

  final subMinTSBasic =
      TextStyle(fontSize: textSize.subMin, fontFamily: 'Hacen Tunisia Lt');

  //========================sub-2-min======================================

  final sub2MinTSBasic =
      TextStyle(fontSize: textSize.sub2Min, fontFamily: 'Hacen Tunisia Lt');

//================================================================================//

}

GlobalTextStyle textStyle = GlobalTextStyle();
