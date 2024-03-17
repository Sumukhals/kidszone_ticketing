import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrgenscan/model/app_constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextFieldType textFieldType;

  CustomTextField(
      {Key? key, this.textFieldType = CustomTextFieldType.ALPHA_NUMERIC})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String qrData = 'https://www.github.com/kamranhccp';
  final qrTextPhoneNumber = TextEditingController();
  final qrTextTicketCount = TextEditingController();
  bool isQrVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
