import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sheet_test/core/resources/edge_margin.dart';
import 'package:google_sheet_test/core/resources/global_color.dart';
import 'package:google_sheet_test/core/resources/global_decorations.dart';
import 'package:google_sheet_test/core/resources/text_style.dart';

class NormalFormField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextNode;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormat;
  final String label;
  final TextInputType keyboardType;

  const NormalFormField({
    Key key,
    this.validator,
    this.inputFormat,
    this.label,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: textStyle.smallTSBasic.copyWith(color: globalColor.primaryColor),
        cursorColor: globalColor.primaryColor,
        decoration: GlobalDecorations.kNormalFieldInputDecoration
            .copyWith(labelText: label),
        validator: validator,
        inputFormatters: inputFormat,
        keyboardType: keyboardType,
        autovalidate: true,
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, focusNode, nextNode);
        });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

class BorderFormField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextNode;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormat;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final TextEditingController controller;
  final int maxLines;
  final bool isEnableFocusOnTextField;
  final bool readOnly;
  final Function onTap;
  final ValueChanged<String> onFieldSubmitted;
  final bool isAutoValidate;

  const BorderFormField({
    Key key,
    this.validator,
    this.isEnableFocusOnTextField = true,
    this.inputFormat,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.onFieldSubmitted,
    @required this.decoration,
    this.isAutoValidate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        style: textStyle.minTSBasic.copyWith(
            color: globalColor.primaryColor,
            decorationThickness: 0,
            height: ScreenUtil().setHeight(1)),
        cursorColor: globalColor.primaryColor,
        decoration: decoration,
        validator: validator,
        enabled: isEnableFocusOnTextField,
        inputFormatters: inputFormat,
        keyboardType: keyboardType,
        autovalidate: isAutoValidate,
        onChanged: onChanged,
        focusNode: focusNode,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap != null ? onTap : () {},
        onFieldSubmitted: onFieldSubmitted != null
            ? onFieldSubmitted
            : (term) {
                _fieldFocusChange(context, focusNode, nextNode);
              });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}

class CustomFormField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final String label;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextInputAction textInputAction;
  final isPasswordField;
  final isNeedPadding;
  final initialValue;

  const CustomFormField({
    Key key,
    this.validator,
    this.initialValue,
    this.inputFormatters,
    this.isPasswordField,
    this.label,
    this.keyboardType,
    this.onChanged,
    this.textInputAction,
    this.isNeedPadding = true,
    this.focusNode,
    this.nextNode,
  })  : assert(isPasswordField != null),
        super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isSecure = true;

  @override
  Widget build(BuildContext context) {
    if (!widget.isPasswordField) {
      return Wrap(
        runAlignment: WrapAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: widget.isNeedPadding != null && widget.isNeedPadding
                      ? EdgeInsets.symmetric(
                          horizontal: EdgeMargin.normal,
                          vertical: EdgeMargin.normal,
                        )
                      : null,
                  child: TextFormField(
                      initialValue: widget.initialValue ?? "",
                      style: textStyle.smallTSBasic,
                      cursorColor: globalColor.primaryColor,
                      focusNode: widget.focusNode,
                      textInputAction: widget.textInputAction,
                      decoration: GlobalDecorations
                          .normalFieldUerManagementNInputDecoration
                          .copyWith(
                        hintText: widget.label,
                      ),
                      validator: widget.validator,
                      inputFormatters: widget.inputFormatters,
                      keyboardType: widget.keyboardType,
                      autovalidate: true,
                      onChanged: widget.onChanged,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, widget.focusNode, widget.nextNode);
                      }),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child: Container(
                //              height: 95,
                child: TextFormField(
                    style: textStyle.smallTSBasic,
                    cursorColor: globalColor.primaryColor,
                    focusNode: widget.focusNode,
                    textInputAction: widget.textInputAction,
                    decoration: GlobalDecorations
                        .normalFieldUerManagementNInputDecoration
                        .copyWith(
                      hintText: widget.label,
                      suffixIcon: IconButton(
                        color: globalColor.textLabel,
                        icon: Icon(
                          _isSecure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSecure = !_isSecure;
                          });
                        },
                      ),
                    ),
                    validator: widget.validator,
                    inputFormatters: widget.inputFormatters,
                    keyboardType: widget.keyboardType,
                    autovalidate: true,
                    onChanged: widget.onChanged,
                    obscureText: _isSecure,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, widget.focusNode, widget.nextNode);
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
