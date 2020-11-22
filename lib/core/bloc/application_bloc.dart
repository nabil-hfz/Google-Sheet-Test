import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:google_sheet_test/core/resources/constants.dart';
import 'package:google_sheet_test/core/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application_events.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  // Indicates if the application is initialized or not.
  var _isInitialized = false;

  // Supported languages.
  final _supportedLanguages = [LANG_AR, LANG_EN];

  // Supported locales
  Iterable<Locale> get supportedLocales => _supportedLanguages.map(
        (language) => Locale(language, ''),
      );

  @override
  ApplicationState get initialState => ApplicationState.initialState;

  bool get isInitialized => _isInitialized;

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is ApplicationStartedEvent) {
      final newState = await _handleApplicationStartedEvent(event);
      if (newState != null) yield newState;
    }
    if (event is SetApplicationLanguageEvent) {
      yield await _handleSetApplicationLanguageEvent(event);
    }
  }

  Future<ApplicationState> _handleApplicationStartedEvent(
    ApplicationStartedEvent event,
  ) async {
    // If we already started the app -> stop.
    if (_isInitialized) return null;

    //  await UserRepository.initSharedPreferences();

    // Init language.
    final language = await _getCurrentLanguage();

    // Mark this app as initialized.
    _isInitialized = true;

    return ApplicationState(language: language);
  }

  Future<ApplicationState> _handleSetApplicationLanguageEvent(
    SetApplicationLanguageEvent event,
  ) async {
    switch (event.language) {
      case LANG_AR:
        // If the language is already arabic -> don't change anything.
        if (this.state.language == LANG_AR) return this.state;

        final setLanguageResult = await _setLanguage(LANG_AR);
        if (setLanguageResult) {
          return this.state.copyWith(language: LANG_AR);
        }

        return this.state;
      case LANG_EN:
        // If the language is already english -> don't change anything.
        if (this.state.language == LANG_EN) return this.state;

        final setLanguageResult = await _setLanguage(LANG_EN);
        if (setLanguageResult) {
          return this.state.copyWith(language: LANG_EN);
        }

        return this.state;
    }
    return this.state;
  }

  Future<String> _getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    var lang = prefs.getString(KEY_LANG);
    if (lang == null || lang.isEmpty) {
      await prefs.setString(KEY_LANG, LANG_AR);
      lang = LANG_AR;
    }
    return lang;
  }

  Future<bool> _setLanguage(String language) async {
    utils.setLang(language);
    // Persist the new language.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_LANG, language);
    return true;
  }
}
