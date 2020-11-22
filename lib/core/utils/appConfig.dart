import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/errors/connection_error.dart';
import 'package:google_sheet_test/core/errors/custom_error.dart';
import 'package:google_sheet_test/core/errors/error_widgets.dart';
import 'package:google_sheet_test/core/errors/forbidden_error.dart';
import 'package:google_sheet_test/core/errors/internal_server_error.dart';
import 'package:google_sheet_test/core/errors/unauthorized_error.dart';
import 'package:google_sheet_test/core/resources/text_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './utils.dart';
import '../resources/constants.dart';

typedef void LocaleChangeCallback(Locale locale);

class AppConfig {
  // Supported languages.
  final supportedLanguages = [LANG_AR, LANG_EN];

  // Supported locales
  Iterable<Locale> get supportedLocales => supportedLanguages.map(
        (language) => Locale(language, ''),
      );

  // Function to be invoked when changing the working language
  LocaleChangeCallback onLocaleChanged;

  Future<String> get currentLanguage async {
    final prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString(KEY_LANG);
    if (lang == null || lang.isEmpty) {
      await prefs.setString(KEY_LANG, LANG_EN);
      lang = LANG_EN;
    }
    return lang;
  }

  Future<void> setLanguage(String lang) async {
    if (await currentLanguage == lang) return;

    utils.setLang(lang);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_LANG, lang);
    this.onLocaleChanged(Locale(lang, ''));
  }

  Future<void> setArabicLanguage() async {
    await setLanguage(LANG_AR);
  }

  Future<void> setEnglishLanguage() async {
    await setLanguage(LANG_EN);
  }

  bool notNullOrEmpty(String value) {
    return value != null && value.isNotEmpty;
  }

  showToast(
      {String msg, Toast toastLength, Color backgroundColor, Color textColor}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: textSize.small);
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  showError({
    @required BaseError error,
    @required BuildContext context,
    @required ScaffoldState scaffoldState,
    @required callback,
  }) {
    if (error is ConnectionError) {
      ErrorViewer.showConnectionError(
        context,
        callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is CustomError) {
      ErrorViewer.showCustomError(
        context,
        error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is UnauthorizedError) {
      ErrorViewer.showCustomError(
        context,
        'UnauthorizedError',
        // error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is ForbiddenError) {
      ErrorViewer.showCustomError(
        context,
        'ForbiddenError', //error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else if (error is InternalServerError) {
      ErrorViewer.showCustomError(
        context,
        'InternalServerError', //  error.message,
        //      callback,
        scaffoldState: scaffoldState,
      );
    } else {
      print(error);
      ErrorViewer.showUnexpectedError(
        context,
        scaffoldState: scaffoldState,
      );
    }
  }
}

AppConfig appConfig = AppConfig();
