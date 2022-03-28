import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RdvTemplate extends StatelessWidget {
  dynamic concerne;
  Creneau creneau;
  String subtext;

  RdvTemplate(
      {Key? key, required this.concerne, required this.creneau, required this.subtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Container(
      padding: EdgeInsets.all(2),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                 margin: EdgeInsets.all(10),
                 child: CircleAvatar(
                   backgroundImage: (concerne is Medecin) ? NetworkImage(urlSite+"/front/img/medecins/${concerne.img_1}") :
                   NetworkImage(urlSite+"/front/img/avatar.png"),
                   radius: 20,
                 ),
               ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.0,
                    child: (concerne is Patient) ? Text(
                      concerne.type! +
                          " " +
                          concerne.nom! +
                          " " +
                          concerne.prenom!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17),
                    ) : Text(
                          concerne.nom! +
                          " " +
                          concerne.prenom!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                  ),
                  Text(
                    subtext,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 11),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_note),
                const SizedBox(
                  width: 15,
                ),
                Text(dateRdv(creneau.jour, creneau.heure))
              ],
            ),
          )
        ],
      ),
    );
  }
}
