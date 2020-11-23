import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/errors/unknown_error.dart';
import 'package:google_sheet_test/core/http/http.dart';
import 'package:google_sheet_test/core/resources/constants.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class AddSheetState extends Equatable {}

class AddSheetUninitializedState extends AddSheetState {
  @override
  String toString() => 'AddSheetUninitializedState';

  @override
  List<Object> get props => [];
}

class AddSheetLoadingState extends AddSheetState {
  @override
  String toString() => 'AddSheetLoadingState';

  @override
  List<Object> get props => [];
}

class AddSheetDoneState extends AddSheetState {
  @override
  String toString() => 'AddSheetDoneState';

  @override
  List<Object> get props => [];
}

class AddSheetFailureState extends AddSheetState {
  final dynamic error;

  AddSheetFailureState(this.error);

  @override
  String toString() => 'AddSheetFailureState';

  @override
  List<Object> get props => [error];
}

class AddSheetEvent {
  final GoogleSheetRequest addSheetRequest;
  final CancelToken cancelToken;

  AddSheetEvent({
    @required this.addSheetRequest,
    @required this.cancelToken,
  });
}

class AddSheetBloc extends Bloc<AddSheetEvent, AddSheetState> {
  @override
  AddSheetState get initialState => AddSheetUninitializedState();

  @override
  Stream<AddSheetState> mapEventToState(AddSheetEvent event) async* {
    yield AddSheetLoadingState();
    try {
      final result =
          await http.post(API_BASE, body: event.addSheetRequest.toJson());
      if (result.statusCode == 302 || result.statusCode == 200) {
        yield AddSheetDoneState();
      } else {
        yield AddSheetFailureState(UnknownError());
      }
    } catch (e) {
      print(e);

      yield AddSheetFailureState(e);
    }
    /* final result = await AddSheetUseCase(locator<AddGoogleSheetRepository>())(
      AddSheetParams(
        addSheetRequest: event.addSheetRequest,
        cancelToken: event.cancelToken,
      ),
    );
    if (result.hasDataOnly) {
      yield AddSheetDoneState();
    } else {
      final error = result.error;
      yield AddSheetFailureState(error);
    }*/
  }
}
