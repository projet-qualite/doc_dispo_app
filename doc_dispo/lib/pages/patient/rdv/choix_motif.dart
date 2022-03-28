import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/motif.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/rdv/choix_date.dart';
import 'package:flutter/material.dart';

class ChoixMotif extends StatefulWidget {
  Medecin? medecin;

  ChoixMotif({required this.medecin});

  ChoixMotifState createState() => ChoixMotifState();
}

class ChoixMotifState extends State<ChoixMotif> {
  List<Map<String, dynamic>> listMotif = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listMotif = getMotifOfMedecin(id: widget.medecin!.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool active = false;

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: colorWidget,
          elevation: 0.0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage(
                        ( widget.medecin!.img_1 != null ) ?
                        urlSite+"/front/img/medecins/" + widget.medecin!.img_1! : urlSite+"/front/img/default.jpg"
                       ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Prenez rendez-vous",
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  Text(
                    widget.medecin!.type! +
                        " " +
                        widget.medecin!.nom! +
                        " " +
                        widget.medecin!.prenom!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Choisissez votre motif de consultation",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                    ),
                    itemCount: listMotif.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> motif = listMotif[index];
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(motif["motif"].libelle),
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChoixDate(id_motif_consultation: motif["id_motif_medecin"],medecin: widget.medecin)),
                          );
                        },
                      );
                    })
            ),

          ],
        ));
  }
}
