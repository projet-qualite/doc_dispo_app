import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:flutter/material.dart';

class FormulaireField extends TextFormField
{
  IconData? data;
  String hint;
  TextEditingController controller;
  TypeField typeField;
  final String? Function(String?)? validation;
  final void Function()? showDate;
  bool isPassword = false;
  bool number = false;
  bool readOnly = false;
  Widget? suffix;


  FormulaireField( {required this.validation, required this.hint,required this.isPassword, required this.number,required this.readOnly
                    ,this.suffix,this.data,required this.typeField,required this.controller, required this.showDate}):
      super(
        controller: controller,
        readOnly: readOnly,
        keyboardType: (number) ? TextInputType.number : TextInputType.text,
        obscureText: (isPassword) ? true : false,
        decoration: InputDecoration(
            hintText: hint,
            border: border,
            enabledBorder: border,
            prefixIcon: Icon(data),
          suffixIcon: suffix,
          contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
        ),
        validator: validation,
        onTap: showDate
      );


}