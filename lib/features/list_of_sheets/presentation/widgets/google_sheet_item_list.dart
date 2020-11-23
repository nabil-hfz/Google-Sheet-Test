import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_sheet_test/core/localization/translations.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/resources/text_style.dart';
import 'package:google_sheet_test/core/utils/appConfig.dart';
import 'package:google_sheet_test/core/utils/width_height.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/entities/google_sheet_entity.dart';

class GoogleSheetItemList extends StatelessWidget {
  final GoogleSheetEntity entity;
  final Function fireHandler;

  GoogleSheetItemList({
    this.entity,
    this.fireHandler,
  });

  buildOneSection(context, width, String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.9),
          margin: const EdgeInsets.only(left: 12, bottom: 6),
          child: Text(
            title,
            style: textStyle.middleTSBasic,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12, bottom: 6, right: 12),
          constraints: BoxConstraints(maxWidth: width * 0.9),
          child: Text(
            data,
            style: textStyle.middleTSBasic,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthS = globalSize.setWidthPercentage(100, context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          buildOneSection(context, widthS,
              Translations.of(context).translate('name'), entity.name),
          buildOneSection(
              context,
              widthS,
              Translations.of(context).translate('mobile_number'),
              entity.purchaseDate),
          buildOneSection(
              context,
              widthS,
              Translations.of(context).translate('model_number'),
              appConfig.notNullOrEmpty(entity.modelNumber)
                  ? entity.modelNumber
                  : '-'),
          buildOneSection(
              context,
              widthS,
              Translations.of(context).translate('purchase_date'),
              appConfig.notNullOrEmpty(entity.purchaseDate)
                  ? entity.purchaseDate
                  : '-'),
          buildOneSection(
              context,
              widthS,
              Translations.of(context).translate('email'),
              appConfig.notNullOrEmpty(entity.email) ? entity.email : '-'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: ScreenUtil().setWidth(90),
                height: ScreenUtil().setHeight(40),
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () =>fireHandler(),
                  child: Text(
                    Translations.of(context).translate('delete'),
                    style: textStyle.middleTSBasic
                        .copyWith(color: globalColor.globalWhite),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
