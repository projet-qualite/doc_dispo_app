import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/pages/patient/details/detail_hopital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HopitalTemplate extends StatelessWidget
{
  Hopital? hopital;
  List<dynamic>? listMedecin;
  List<dynamic>? listSpecialite;
  List<dynamic>? listAssurance;
  HopitalTemplate({required this.hopital,required this.listMedecin,required this.listSpecialite, required this.listAssurance});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    String image = "http://54.38.186.80/front/img/hopitaux/"+hopital!.img;

    return InkWell(
      child: templateElementsAccueil(title: hopital!.libelle, subtitle: listMedecin!.length.toString()+" Medecins", image: image, size: size),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailHopital(listMedecin: listMedecin, listSpecialite: listSpecialite, listAssurance: listAssurance, hopital: hopital)),
        );
      },
    );

  }

}