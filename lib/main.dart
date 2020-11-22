import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sheet_test/core/bloc/simple_bloc_delegate.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/features/app.dart';
import 'package:google_sheet_test/features/form/data/datasources/add_sheet_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/resources/constants.dart';
import 'core/ui/restart_widget.dart';
import 'features/form/data/datasources/add_sheet_remote_data_source.dart';
import 'features/form/data/datasources/concrete_add_sheet_remote_data_source.dart';
import 'features/form/data/repositories/concrete_add_sheet_repository.dart';
import 'features/form/domain/repositories/my_ticket_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  //===================================
  //    Add Google Sheet Repo
  //===================================
  locator.registerFactory<AddSheetRemoteDataSource>(
    () => ConcreteAddSheetRemoteDataSource(),
  );
  locator.registerFactory<AddSheetRepository>(
    () => ConcreteAddSheetRepository(locator<AddSheetRemoteDataSource>()),
  );
}

void setupBloc() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
}

Future<String> _getLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  var lang = prefs.getString(KEY_LANG);
  if (lang == null || lang.isEmpty) {
    await prefs.setString(KEY_LANG, LANG_EN);
    lang = LANG_EN;
  }
  return lang;
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: globalColor.primary,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  String lang = await _getLanguage();

  setupLocator();
  setupBloc();

  runApp(RestartWidget(child: MyApp(lang: lang)));
}
//flutter packages pub run build_runner build --delete-conflicting-outputs
