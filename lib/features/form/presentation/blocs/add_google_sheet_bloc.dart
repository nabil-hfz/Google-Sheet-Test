import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/http/http.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/form/domain/repositories/my_ticket_repository.dart';
import 'package:google_sheet_test/features/form/domain/usecases/add_sheet_usecase.dart';
import 'package:google_sheet_test/main.dart';

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
  final BaseError error;

  AddSheetFailureState(this.error);

  @override
  String toString() => 'AddSheetFailureState';

  @override
  List<Object> get props => [error];
}

class AddSheetEvent {
  final AddSheetRequest addSheetRequest;
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
    final result = await AddSheetUseCase(locator<AddSheetRepository>())(
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
    }
  }
}
