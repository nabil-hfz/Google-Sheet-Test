import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sheet_test/core/bloc/application_bloc.dart';
import 'package:google_sheet_test/core/bloc/application_events.dart';
import 'package:google_sheet_test/core/bloc/application_state.dart';
import 'package:google_sheet_test/core/localization/specific_localization_delegate.dart';
import 'package:google_sheet_test/core/localization/translations_delegate.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/utils/utils.dart';
import 'package:google_sheet_test/features/form/presentation/screens/form_screen.dart';
import 'package:google_sheet_test/features/splash/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'list_of_sheets/presentation/screens/sheets_list_screen.dart';

class MyApp extends StatelessWidget {
  final String lang;

  const MyApp({this.lang});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Builder(builder: (context) {
        return BlocBuilder<ApplicationBloc, ApplicationState>(
          bloc: BlocProvider.of<ApplicationBloc>(context),
          builder: (context, state) {
            print(
                "===== Application Language ===== ${state.language} ===============");

            final localeOverrideDelegate =
                SpecificLocalizationDelegate(Locale(state.language ?? lang));

            //for insert lang if  you don't use bloc
            utils.setLang(state.language ?? lang);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Google Sheet Test',
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (context) => SplashScreen(),
                FormScreen.routeName: (context) => FormScreen(),
                SheetsListScreen.routeName: (context) => SheetsListScreen(),
              },
              theme: ThemeData(
                primaryColor: globalColor.primary,
                accentColor: globalColor.accentColor,
              ),
              locale: localeOverrideDelegate.overriddenLocale,
              localizationsDelegates: [
                localeOverrideDelegate,
                const TranslationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales:
                  BlocProvider.of<ApplicationBloc>(context).supportedLocales,
            );
          },
        );
      }),
      providers: [
//          BlocProvider<ApplicationBloc>.value(
//            value: ApplicationBloc()..add(ApplicationStartedEvent(context)),
//
//          ),
        //         ChangeNotifierProvider(create: (_) => QuizProvider()),
        BlocProvider<ApplicationBloc>.value(
          value: ApplicationBloc()..add(ApplicationStartedEvent(context)),
        ),
      ],
    );
  }
}
