import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RdvTemplate2 extends StatefulWidget {
  dynamic concerne;
  Creneau creneau;
  Specialite specialite;

  RdvTemplate2(
      {Key? key, required this.concerne, required this.creneau, required this.specialite}) : super(key: key);
  RdvTemplate2State createState() => RdvTemplate2State();
}

class RdvTemplate2State extends State<RdvTemplate2>
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width / 1.3,
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 50, right: 50, top: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: //(medecin.img_1 == null) ?
                    AssetImage('images/avatar.png'),
                //: AssetImage('images/'+medecin.img_1!),
                radius: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      widget.concerne.type! +
                          " " +
                          widget.concerne.nom! +
                          " " +
                          widget.concerne.prenom!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17),
                    ),
                  ),
                  Text(
                    widget.specialite.libelle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 11),
                  )
                ],
              ),
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
                Text(dateRdv(widget.creneau.jour, widget.creneau.heure))
              ],
            ),
          )
        ],
      ),
    );
  }
}
