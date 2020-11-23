import 'dart:convert' as convert;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/http/http.dart';
import 'package:google_sheet_test/core/resources/constants.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/entities/google_sheet_entity.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/repositories/sheets_list_repository.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/usecase/get_all_google_sheets.dart';
import 'package:google_sheet_test/main.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class GetAllGoogleSheetsState extends Equatable {}

class GetAllGoogleSheetsUninitializedState extends GetAllGoogleSheetsState {
  @override
  String toString() => 'GetAllGoogleSheetsUninitializedState';

  @override
  List<Object> get props => [];
}

class GetAllGoogleSheetsLoadingState extends GetAllGoogleSheetsState {
  @override
  String toString() => 'GetAllGoogleSheetsLoadingState';

  @override
  List<Object> get props => [];
}

class DeleteGoogleSheetsLoadingState extends GetAllGoogleSheetsState {
  @override
  String toString() => 'DeleteGoogleSheetsLoadingState';

  @override
  List<Object> get props => [];
}

class GetAllGoogleSheetsDoneState extends GetAllGoogleSheetsState {
  @override
  String toString() => 'GetAllGoogleSheetsDoneState';
  final List<GoogleSheetEntity> list;

  GetAllGoogleSheetsDoneState({this.list});

  @override
  List<Object> get props => [];
}

class DeleteGoogleSheetsDoneState extends GetAllGoogleSheetsState {
  final List<GoogleSheetEntity> list;

  @override
  String toString() => 'DeleteGoogleSheetsDoneState';

  DeleteGoogleSheetsDoneState(this.list);

  @override
  List<Object> get props => [this.list];
}

class GetAllGoogleSheetsFailureState extends GetAllGoogleSheetsState {
  final BaseError error;

  GetAllGoogleSheetsFailureState(this.error);

  @override
  String toString() => 'GetAllGoogleSheetsFailureState';

  @override
  List<Object> get props => [error];
}

class DeleteGoogleSheetsFailureState extends GetAllGoogleSheetsState {
  final BaseError error;

  DeleteGoogleSheetsFailureState(this.error);

  @override
  String toString() => 'DeleteGoogleSheetsFailureState';

  @override
  List<Object> get props => [error];
}

abstract class GoogleSheetsEvent extends Equatable {}

class GetAllGoogleSheetsEvent extends GoogleSheetsEvent {
  final CancelToken cancelToken;

  GetAllGoogleSheetsEvent({
    @required this.cancelToken,
  });

  @override
  String toString() => 'GetAllGoogleSheetsEvent';

  @override
  List<Object> get props => [this.cancelToken];
}

class DeleteGoogleSheetEvent extends GoogleSheetsEvent {
  final CancelToken cancelToken;
  final GoogleSheetRequest googleSheetRequest;

  DeleteGoogleSheetEvent({
    @required this.cancelToken,
    @required this.googleSheetRequest,
  });

  @override
  String toString() => 'DeleteGoogleSheetsEvent';

  @override
  List<Object> get props => [
        this.cancelToken,
        this.googleSheetRequest,
      ];
}

class GoogleSheetsListBloc
    extends Bloc<GoogleSheetsEvent, GetAllGoogleSheetsState> {
  List<GoogleSheetEntity> list;

  @override
  GetAllGoogleSheetsState get initialState =>
      GetAllGoogleSheetsUninitializedState();

  @override
  Stream<GetAllGoogleSheetsState> mapEventToState(
      GoogleSheetsEvent event) async* {
    if (event is GetAllGoogleSheetsEvent) {
      yield GetAllGoogleSheetsLoadingState();
      final result =
          await GetAllGoogleSheetsUseCase(locator<SheetsListRepository>())(
        GetAllGoogleSheetsParams(
          cancelToken: event.cancelToken,
        ),
      );
      if (result.hasDataOnly) {
        list = result.data;
         yield GetAllGoogleSheetsDoneState(list: list);
      } else {
        final error = result.error;
        yield GetAllGoogleSheetsFailureState(error);
      }
    }
    if (event is DeleteGoogleSheetEvent) {
       yield DeleteGoogleSheetsLoadingState();
      try {
        final result =
            await http.post(API_BASE, body: event.googleSheetRequest.toJson());
        if ((result).statusCode == 302) {
          var url = (result).headers['location'];
          final res = await http.get(url);
          list.removeWhere(
              (element) => event.googleSheetRequest.id == element.id);

           yield DeleteGoogleSheetsDoneState(list);
        }
      } catch (e) {
        yield DeleteGoogleSheetsFailureState(e);
        print(e);
      }
    }
  }
}
