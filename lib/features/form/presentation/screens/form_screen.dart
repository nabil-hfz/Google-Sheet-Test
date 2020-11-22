import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sheet_test/core/errors/error_widgets.dart';
import 'package:google_sheet_test/core/localization/translations.dart';
import 'package:google_sheet_test/core/resources/edge_margin.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/resources/text_size.dart';
import 'package:google_sheet_test/core/resources/text_style.dart';
import 'package:google_sheet_test/core/ui/normal_form_field.dart';
import 'package:google_sheet_test/core/utils/appConfig.dart';
import 'package:google_sheet_test/core/utils/width_height.dart';
import 'package:google_sheet_test/core/validators/base_validator.dart';
import 'package:google_sheet_test/core/validators/email_validator.dart';
import 'package:google_sheet_test/core/validators/required_validator.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/form/presentation/blocs/add_google_sheet_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FormScreen extends StatefulWidget {
  static const routeName = 'screens/form_screen';

  const FormScreen();

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  //=========================================================================
  //   for text field
  //=========================================================================
  bool _nameValidation = false;
  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameEditingController =
      new TextEditingController();

  bool _mobileNumberValidation = false;
  final FocusNode _mobileNumberFocusNode = FocusNode();
  final TextEditingController _mobileNumberEditingController =
      new TextEditingController();

  final FocusNode _modelNumberFocusNode = FocusNode();
  final TextEditingController _modelNumberEditingController =
      new TextEditingController();

  final FocusNode _datePickerFocusNode = FocusNode();
  TextEditingController _datePickerController = TextEditingController();

  bool _emailValidation = false;
  final FocusNode _emailFocusNode = FocusNode();
  TextEditingController _emailEditingController = new TextEditingController();

  Function _forceOnTap;
  final CancelToken _cancelToken = CancelToken();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AddSheetBloc _bloc = AddSheetBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    _emailFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    _datePickerFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: globalColor.primary,
      title: Text(
        Translations.of(context).translate('google_sheet'),
        style: textStyle.subBigTSBasic.copyWith(
          color: globalColor.globalWhite,
        ),
      ),
      centerTitle: true,
      brightness: Brightness.light,
      iconTheme: IconThemeData(
        color: globalColor.accentColor,
      ),
    );
  }

  buildNameTextField(double widthS) {
    return Container(
      margin: const EdgeInsets.only(left: 2, right: 2),
      width: widthS * .9,
      child: BorderFormField(
        isAutoValidate: true,
        controller: _nameEditingController,
        decoration: decorationTextForm(
          borderRadius: widthS * .04,
          labelText: Translations.of(context).translate('name'),
          //  hintText: Translations.of(context).translate('name'),
        ),
        validator: (value) {
          return BaseValidator.validateValue(
            context,
            value,
            [RequiredValidator()],
            _nameValidation,
          );
        },
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            _nameValidation = true;
          });
        },
        focusNode: _nameFocusNode,
        nextNode: _mobileNumberFocusNode,
      ),
    );
  }

  buildMobileNumberTextField(double widthS) {
    return Container(
      margin: EdgeInsets.only(left: 2, right: 2),
      width: widthS * .9,
      child: BorderFormField(
        isAutoValidate: true,
        controller: _mobileNumberEditingController,
        decoration: decorationTextForm(
          borderRadius: widthS * .04,

          labelText: Translations.of(context).translate('mobile_number'),
          //   hintText: Translations.of(context).translate('number'),
        ),
        validator: (value) {
          return BaseValidator.validateValue(
            context,
            value,
            [RequiredValidator()],
            _mobileNumberValidation,
          );
        },
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _mobileNumberValidation = true;
          });
        },
        focusNode: _mobileNumberFocusNode,
        nextNode: _modelNumberFocusNode,
      ),
    );
  }

  buildModelNumberTextField(double widthS) {
    return Container(
      width: widthS * .9,
      child: Container(
        margin: const EdgeInsets.only(left: 2, right: 2),
        child: BorderFormField(
          controller: _modelNumberEditingController,
          decoration: decorationTextForm(
            borderRadius: widthS * .04,
            labelText: Translations.of(context).translate('model_number'),
            // hintText: Translations.of(context).translate('model_number'),
          ),
          keyboardType: TextInputType.number,
          focusNode: _modelNumberFocusNode,
          nextNode: _datePickerFocusNode,
        ),
      ),
    );
  }

  buildTitle(String title) {
    return Container(
      margin:
          const EdgeInsets.only(left: EdgeMargin.big, right: EdgeMargin.big),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildTitle(Translations.of(context).translate('purchase_date')),
        Container(
          margin: EdgeInsets.only(left: EdgeMargin.big, right: EdgeMargin.big),
          child: TextFormField(
            // style: textStyle.smallTextSecondry,
            focusNode: _datePickerFocusNode,
            cursorColor: globalColor.primary,
            controller: _datePickerController,
            decoration: InputDecoration(
              hintText: Translations.of(context).translate('purchase_date'),
            ),
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime(1995, 1, 1),
                firstDate: DateTime(1700, 1, 1),
                lastDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.year,
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData(
                      primaryColor: globalColor.primary,
                      accentColor: globalColor.accentColor,
                      buttonBarTheme: ButtonBarThemeData(
                        buttonTextTheme: ButtonTextTheme.accent,
                      ),
                    ),
                    child: child,
                  );
                },
              );
              if (date != null) {
                var formatter = DateFormat('MM/dd/yyyy');
                _datePickerController.text = formatter.format(date);
                _purchaseDate = date.toString();
                _fieldFocusChange(
                    context, _datePickerFocusNode, _emailFocusNode);
              }
            },
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  buildEmailTextField(widthS) => Container(
        margin: EdgeInsets.only(left: 2, right: 2),
        width: widthS * .9,
        child: BorderFormField(
          controller: _emailEditingController,
          isAutoValidate: true,
          decoration: decorationTextForm(
            borderRadius: widthS * .04,
            labelText: Translations.of(context).translate('email'),
            //  hintText: Translations.of(context).translate('email'),
          ),
          validator: (value) {
            return BaseValidator.validateValue(
              context,
              value,
              [EmailValidator()],
              _emailValidation,
            );
          },
          maxLines: 1,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            _emailValidation = true;
          },
          focusNode: _emailFocusNode,
        ),
      );

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  String _purchaseDate = ''; //empty

  @override
  Widget build(BuildContext context) {
    AppBar appBar = buildAppBar();
    double widthS = globalSize.setWidthPercentage(100, context);
    double heightS = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: () {},
      ),
      body: Container(
        width: widthS,
        height: heightS,
        child: Form(
          key: _formKey,
          child: BlocListener<AddSheetBloc, AddSheetState>(
            bloc: _bloc,
            listener: (context, state) async {
              /*
              if (state is ExternalLoginSuccess) {
                BlocProvider.of<ApplicationBloc>(context)
                    .add(SetUserProfileEvent());
                while (Navigator.of(context).canPop())
                  Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(MainPage.routeName);
              }
              if (state is ExternalLoginFailure) {
                final error = state.error;
                if (error is ConnectionError) {
                  ErrorViewer.showConnectionError(context, state.callback);
                } else if (error is CustomError) {
                  ErrorViewer.showCustomError(context, error.message);
                } else {
                  print(error);
                  ErrorViewer.showUnexpectedError(context);
                }
              }*/
            },
            child: BlocBuilder<AddSheetBloc, AddSheetState>(
              bloc: _bloc,
              builder: (context, state) {
                return ModalProgressHUD(
                  dismissible: true,
                  inAsyncCall: state is AddSheetLoadingState,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.h),

                        // name textField
                        buildNameTextField(widthS),

                        SizedBox(height: 15.h),

                        // Number textField
                        buildMobileNumberTextField(widthS),

                        SizedBox(height: 15.h),

                        //   model number
                        buildModelNumberTextField(widthS),

                        SizedBox(height: 15.h),

                        // Date textField
                        _buildDatePickerField(context),

                        SizedBox(height: 15.h),

                        // email textField
                        buildEmailTextField(widthS),

                        SizedBox(height: 30.h),

                        _buildSaveDataButton(
                          width: widthS * .9,
                          color: globalColor.secondaryColor,
                          title:
                              Translations.of(context).translate('upload_it'),
                          action: () {
                            setState(() {
                              _nameValidation = true;
                              _mobileNumberValidation = true;
                              _emailValidation = true;
                            });
                            String _name = _nameEditingController.text;
                            String _mobilNumber =
                                _mobileNumberEditingController.text;
                            String _modelNumber =
                                _modelNumberEditingController.text;
                            String _email = _emailEditingController.text;

                            if (appConfig.notNullOrEmpty(_name) &&
                                appConfig.notNullOrEmpty(_mobilNumber)) {
                              _bloc.add(
                                AddSheetEvent(
                                  cancelToken: _cancelToken,
                                  addSheetRequest: AddSheetRequest(
                                    name: _name,
                                    mobileNumber: _mobilNumber,
                                    modelNumber: _modelNumber,
                                    purchaseDate: _purchaseDate,
                                    email: _email,
                                  ),
                                ),
                              );
                            }
                          },
                        ),

                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration decorationTextForm({
    double borderRadius,
    String labelText,
    String hintText,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: globalColor.focusedBorder,
          style: BorderStyle.solid,
          width: 1.sp,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(borderRadius) //         <--- border radius here
            ),
      ),
      labelText: labelText,
      hintText: hintText,
      alignLabelWithHint: false,
      labelStyle:
          textStyle.normalTSBasic.copyWith(color: globalColor.textLabel),
      errorStyle: textStyle.smallTSBasic.copyWith(
        color: Colors.red,
        fontSize: textSize.subMin,
      ),
      filled: false,
    );
  }

//  InputDecoration decorationTextForm(
//      {double borderRadius, String labelText, String hintText}) {
//    return InputDecoration(
//        border: OutlineInputBorder(
//          borderSide: BorderSide(
//            color: Colors.black,
//            style: BorderStyle.solid,
//            width: 1.sp,
//          ),
//          borderRadius: BorderRadius.all(
//              Radius.circular(borderRadius) //         <--- border radius here
//              ),
//        ),
//        labelText: labelText,
//        hintText: hintText,
//        alignLabelWithHint: false,
//        errorStyle: textStyle.smallTSBasic.copyWith(
//          color: Colors.red,
//          fontSize: textSize.subMin,
//        ),
//        labelStyle: textStyle.normalTSBasic,
//        filled: false);
//  }

  buildSendButton(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* ProgressButtonWidget(
            label: Translations.of(context).translate('send'),
            workHandler: makeRegisterRequest,
            extraValidation: () {
              setState(() {
                _phoneNumberValidation = true;
                _emailValidation = true;
                _fullNameValidation = true;
                _messageValidation = true;
                _reasonContactValidation = true;
              });

              if (_formKey.currentState.validate()) {
                if (selectedCallNumber.id == -1) {
                  buildFillAllInfoMessageError();
                  return false;
                }
                return true;
              }
              return false;
            },
            forceOnTap: (voidCallback) {
              _forceOnTap = voidCallback;
            },
          ),*/
        ],
      );

  buildFillAllInfoMessageError() {
    ErrorViewer.showCustomError(
      context,
      Translations.of(context).translate(
        "please_fill_all_required_field",
      ),
      scaffoldState: _scaffoldKey.currentState,
    );
  }

  Future<void> makeRegisterRequest() async {
    /* final result = await AddContactUsUseCase(locator<CoreRepository>())(
      AddContactUsParams(
        data: AddContactUsRequest(
          email: emailEditingController.text?.trim() ?? '',
          message: messageEditingController.text?.trim() ?? '',
          username: fullNameEditingController.text?.trim() ?? '',
          reason: reasonContactEditingController.text?.trim() ?? '',
          phoneNumber: phoneNumberEditingController.text?.trim() ?? '',
          phoneNumberCountryId: selectedCallNumber.id,
        ),
      ),
    );
    if (result.hasDataOnly) {
      Navigator.of(context).pop();
    } else {
      appConfig.showError(
        error: result.error,
        context: context,
        scaffoldState: _scaffoldKey.currentState,
        callback: callback,
      );
    }*/
    return null;
  }

  void callback() {
    _forceOnTap();
  }

  Widget _buildSaveDataButton({
    @required double width,
    @required Color color,
    @required String title,
    @required Function action,
  }) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: width,
        height: 50.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(width * .04)),
        ),
        child: Center(
          child: Text(
            "${title.toUpperCase()}",
            style: textStyle.normalTSBasic
                .copyWith(color: globalColor.globalWhite),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
