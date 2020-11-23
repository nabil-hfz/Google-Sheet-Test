import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sheet_test/core/bloc/simple_bloc_delegate.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/features/app.dart';
import 'package:google_sheet_test/features/form/data/datasources/add_sheet_remote_data_source.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/datasources/concrete_sheets_list_remote_data_source.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/repositories/sheets_list_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'core/resources/constants.dart';
import 'core/ui/restart_widget.dart';
import 'features/form/data/datasources/add_sheet_remote_data_source.dart';
import 'features/form/data/datasources/concrete_add_sheet_remote_data_source.dart';
import 'features/form/data/repositories/concrete_add_sheet_repository.dart';
import 'features/form/domain/repositories/add_sheet_repository.dart';
import 'features/list_of_sheets/data/datasources/sheets_list_remote_data_source.dart';
import 'features/list_of_sheets/data/repositories/concrete_sheets_list_repository.dart';

final locator = GetIt.instance;
final uuid = Uuid();

void setupLocator() {
  //===================================
  //    Add Google Sheet Repo
  //===================================
 /* locator.registerFactory<AddSheetRemoteDataSource>(
    () => ConcreteAddSheetRemoteDataSource(),
  );
  locator.registerFactory<AddGoogleSheetRepository>(
    () => ConcreteAddSheetRepository(locator<AddSheetRemoteDataSource>()),
  ); //===================================
  //    Add Google Sheet Repo
  //===================================
  locator.registerFactory<SheetsListRemoteDataSource>(
    () => ConcreteSheetsListRemoteDataSource(),
  );
  locator.registerFactory<SheetsListRepository>(
    () => ConcreteSheetsListRepository(locator<SheetsListRemoteDataSource>()),
  );*/
  locator.registerFactory<AddSheetRemoteDataSource>(
        () => ConcreteAddSheetRemoteDataSource(),
  );
  locator.registerFactory<AddGoogleSheetRepository>(
        () => ConcreteAddSheetRepository(locator<AddSheetRemoteDataSource>()),
  );
locator.registerFactory<SheetsListRemoteDataSource>(
        () => ConcreteSheetsListRemoteDataSource(),
  );
  locator.registerFactory<SheetsListRepository>(
        () => ConcreteSheetsListRepository(locator<SheetsListRemoteDataSource>()),
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
