import 'package:flutter/cupertino.dart';

class AddNewRecordArgs {
  final String name;
  final String mobileNumber;
  final String modelNumber;
  final String purchaseDate;
  final String email;

  AddNewRecordArgs({
    @required this.name,
    @required this.mobileNumber,
    @required this.modelNumber,
    @required this.purchaseDate,
    @required this.email,
  });
}
