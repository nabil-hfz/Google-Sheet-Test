import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sheet_test/core/resources/constants.dart';
@immutable
abstract class ApplicationEvent extends Equatable {}

class ApplicationStartedEvent extends ApplicationEvent {
  final BuildContext context;

  ApplicationStartedEvent(this.context);

  @override
  String toString() => 'ApplicationStartedEvent';

  @override
  List<Object> get props => [context];
}

abstract class SetApplicationLanguageEvent extends ApplicationEvent {
  final String language;

  SetApplicationLanguageEvent(this.language);

  @override
  String toString() => 'SetApplicationLanguageEvent { language: $language }';

  @override
  List<Object> get props => [language];
}

class SetArabicLanguageEvent extends SetApplicationLanguageEvent {
  SetArabicLanguageEvent() : super(LANG_AR);
}

class SetEnglishLanguageEvent extends SetApplicationLanguageEvent {
  SetEnglishLanguageEvent() : super(LANG_EN);
}


