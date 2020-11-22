
class ApplicationState {
  // Current user language.
  final String language;

  ApplicationState({
    this.language,
  });

  ApplicationState copyWith({
    String language,
  }) =>
      ApplicationState(
        language: language ?? this.language,
      );

  static ApplicationState get initialState => ApplicationState();
}
