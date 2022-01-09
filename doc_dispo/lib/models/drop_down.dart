import 'package:doc_dispo/common/widgets.dart';
import 'package:flutter/material.dart';

class DropDownField extends DropdownButtonFormField<String> {

  List<String> personne;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;
  String? defaultValue;
  String? hintText = "Vous êtes ?";

  DropDownField({required this.personne,required this.onChanged, required this.validator,required this.defaultValue, this.hintText}) :
        super(
        decoration: InputDecoration(
          hintText: hintText,
          border: border,
          enabledBorder: border,
          contentPadding:EdgeInsets.fromLTRB(10,0,10,0),
        ),
        value: defaultValue,
        isExpanded: true,
        onChanged: onChanged,
        validator: validator,
        style: const TextStyle(color: Colors.blue),
        selectedItemBuilder: (BuildContext context) {
          return personne.map((String value) {
            return Text(
              value,
              style: const TextStyle(color: Colors.brown),
            );
          }).toList();
        },
        items: personne.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
}