import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RdvTemplate2 extends StatefulWidget {
  dynamic concerne;
  Creneau creneau;
  String subtext;

  RdvTemplate2(
      {Key? key,
      required this.concerne,
      required this.creneau,
      required this.subtext})
      : super(key: key);

  RdvTemplate2State createState() => RdvTemplate2State();
}

class RdvTemplate2State extends State<RdvTemplate2> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1.3,
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 50, right: 50, top: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: (currentUser is Medecin) ?
                NetworkImage(urlSite+"/front/img/avatar.png") :
                NetworkImage(urlSite+"/front/img/medecins/"+widget.concerne.img_1!),
                radius: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.0,
                    child: (currentUser is Medecin)
                        ? Text(
                            widget.concerne.nom + " " + widget.concerne.prenom,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )
                        : Text(
                            widget.concerne.type! +
                                " " +
                                widget.concerne.nom +
                                " " +
                                widget.concerne.prenom,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.subtext,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 11),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_note),
                const SizedBox(
                  width: 15,
                ),
                Text(dateRdv(widget.creneau.jour, widget.creneau.heure))
              ],
            ),
          )
        ],
      ),
    );
  }
}
