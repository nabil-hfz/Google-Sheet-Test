import 'package:flutter/material.dart';
import 'package:google_sheet_test/core/localization/translations.dart';
import 'package:google_sheet_test/core/validators/base_validator.dart';

class EmailValidator extends BaseValidator {
  @override
  String getMessage(BuildContext context) {
    return Translations.of(context).translate('v_invalid_email');
  }

  @override
  bool validate(String value) {
    final regex = RegExp(
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$');
    return regex.hasMatch(value) || value == null || value.isEmpty;
  }
}
