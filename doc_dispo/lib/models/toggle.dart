import 'package:flutter/material.dart';

class Toogle extends Container
{
  bool? selected = false;

  Toogle({this.selected}): super(

  );


  void selectionner(bool select)
  {
    this.selected = select;
  }


}