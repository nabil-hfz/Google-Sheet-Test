import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sheet_test/core/errors/connection_error.dart';
import 'package:google_sheet_test/core/errors/custom_error.dart';
import 'package:google_sheet_test/core/errors/error_widgets.dart';
import 'package:google_sheet_test/core/http/http.dart';
import 'package:google_sheet_test/core/localization/translations.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/resources/text_style.dart';
import 'package:google_sheet_test/core/utils/width_height.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/list_of_sheets/presentation/blocs/get_all_google_sheets_bloc.dart';
import 'package:google_sheet_test/features/list_of_sheets/presentation/widgets/google_sheet_item_list.dart';
import 'package:google_sheet_test/features/list_of_sheets/presentation/widgets/google_sheet_shimmer_list.dart';

class SheetsListScreen extends StatefulWidget {
  static const routeName = 'screens/sheets_list_screen';

  @override
  _SheetsListScreenState createState() => _SheetsListScreenState();
}

class _SheetsListScreenState extends State<SheetsListScreen> {
  GoogleSheetsListBloc _bloc;
  CancelToken _cancelToken;

  @override
  void initState() {
    super.initState();
    _bloc = GoogleSheetsListBloc();
    _cancelToken = CancelToken();
    _bloc.add(GetAllGoogleSheetsEvent(cancelToken: _cancelToken));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: globalColor.primary,
      title: Text(
        Translations.of(context).translate('sheets_list'),
        style: textStyle.subBigTSBasic.copyWith(
          color: globalColor.globalWhite,
        ),
      ),
      centerTitle: true,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: globalColor.globalWhite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = buildAppBar(context);
    double widthS = globalSize.setWidthPercentage(100, context);
    double heightS = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: appBar,
      body: BlocListener<GoogleSheetsListBloc, GetAllGoogleSheetsState>(
          listener: (context, state) {
            if (state is GetAllGoogleSheetsDoneState) {}
            if (state is GetAllGoogleSheetsFailureState) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showConnectionError(context, null);
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                print(error);
                ErrorViewer.showUnexpectedError(context);
              }
            }
            if (state is DeleteGoogleSheetsFailureState) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showConnectionError(context, null);
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                print(error);
                ErrorViewer.showUnexpectedError(context);
              }
            }
          },
          bloc: _bloc,
          child: RefreshIndicator(
            child: BlocBuilder<GoogleSheetsListBloc, GetAllGoogleSheetsState>(
              bloc: _bloc,
              builder: (context, state) {
                return Container(
                  width: widthS,
                  height: heightS,
                  child: state is GetAllGoogleSheetsLoadingState ||
                          state is DeleteGoogleSheetsLoadingState
                      ? GoogleSheetsShimmerList()
                      : buildMainContent(state, widthS),
                );
              },
            ),
            onRefresh: () {
              _bloc.add(GetAllGoogleSheetsEvent(cancelToken: _cancelToken));
              return Future.value(null);
            },
          )),
    );
  }

  buildMainContent(GetAllGoogleSheetsState state, double widthS) {
    if (state is GetAllGoogleSheetsDoneState) {
      if (state.list != null && state.list.isNotEmpty) {
        return ListView.builder(
          itemCount: state.list.length,
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (BuildContext context, int index) {
            return GoogleSheetItemList(
              entity: state.list[index],
              fireHandler: () {
                _bloc.add(
                  DeleteGoogleSheetEvent(
                    googleSheetRequest: GoogleSheetRequest(
                      id: state.list[index].id,
                      email: state.list[index].email,
                      name: state.list[index].name,
                      purchaseDate: state.list[index].purchaseDate,
                      modelNumber: state.list[index].modelNumber,
                      mobileNumber: state.list[index].mobileNumber,
                      httpMethod: "DELETE",
                    ),
                    cancelToken: _cancelToken,
                  ),
                );
              },
            );
          },
        );
      } else {
        return Container(
          alignment: Alignment.center,
          child: Text(
            Translations.of(context).translate('there_is_no_item'),
            style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
          ),
        );
      }
    }
    if (state is DeleteGoogleSheetsDoneState) {
      if (state.list != null && state.list.isNotEmpty) {
        return ListView.builder(
          itemCount: state.list.length,
          padding: const EdgeInsets.only(bottom: 12),
          itemBuilder: (BuildContext context, int index) {
            return GoogleSheetItemList(
              entity: state.list[index],
              fireHandler: () {
                _bloc.add(
                  DeleteGoogleSheetEvent(
                    googleSheetRequest: GoogleSheetRequest(
                      id: state.list[index].id,
                      email: state.list[index].email,
                      name: state.list[index].name,
                      purchaseDate: state.list[index].purchaseDate,
                      modelNumber: state.list[index].modelNumber,
                      mobileNumber: state.list[index].mobileNumber,
                      httpMethod: "DELETE",
                    ),
                    cancelToken: _cancelToken,
                  ),
                );
              },
            );
          },
        );
      } else {
        return Container(
          alignment: Alignment.center,
          child: Text(
            Translations.of(context).translate('there_is_no_item'),
            style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
          ),
        );
      }
    }
  }
}
