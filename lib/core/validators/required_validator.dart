import 'package:google_sheet_test/core/localization/translations.dart';
import 'package:flutter/material.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  bool isFromVerificationPage;
  RequiredValidator({this.isFromVerificationPage});
  @override
  String getMessage(BuildContext context) {
    if(isFromVerificationPage!= null && isFromVerificationPage) return '*';
    return Translations.of(context).translate('text_field_required');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty;
  }
}
