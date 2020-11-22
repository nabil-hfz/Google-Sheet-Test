import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/resources/text_size.dart';
import 'package:google_sheet_test/core/resources/text_style.dart';
import 'package:flutter/material.dart';

abstract class GlobalDecorations {
  static InputDecoration get kNormalFieldInputDecoration => InputDecoration(
      labelStyle: textStyle.smallTSBasic.copyWith(color: globalColor.textLabel),
      errorStyle: textStyle.smallTSBasic.copyWith(
        color: Colors.red,
        fontSize: textSize.subMin,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: globalColor.enabledBorder),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: globalColor.focusedBorder),
      ));

  static InputDecoration get normalFieldUerManagementNInputDecoration =>
      InputDecoration(
        hintStyle: TextStyle(color: globalColor.globalGrey),
        alignLabelWithHint: true,
        fillColor: globalColor.globalWhite,
        filled: true,
        labelStyle:
            textStyle.smallTSBasic.copyWith(color: globalColor.textLabel),
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.subMin,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      );

  static InputDecoration get kBorderFieldInputDecoration => InputDecoration(
        alignLabelWithHint: false,
        labelStyle: textStyle.normalTSBasic,
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.subMin,
        ),
        filled: false,
      );

  static InputDecoration get underLineVerificationCOdeFieldInputDecoration =>
      InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: globalColor.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: globalColor.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        filled: false,
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.middle,
        ),
      );
}
