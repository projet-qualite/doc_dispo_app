import 'package:doc_dispo/classes/assurance.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssuranceTemplate extends StatelessWidget
{
  Assurance? assurance;
  List<dynamic>? listHopitaux;
  AssuranceTemplate({required this.assurance,required this.listHopitaux});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    String image = urlSite+"front/img/assurances/"+assurance!.logo;

    String subtitle = listHopitaux!.length > 1 ? " Hôpitaux" : " Hôpital";

    return InkWell(
      child: templateElementsAccueil(title: assurance!.libelle, subtitle: listHopitaux!.length.toString()+subtitle, image: image, size: size),
      onTap: (){

      },
    );

  }

}