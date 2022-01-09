import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/rdv/choix_proche.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChoixDate extends StatefulWidget {
  int id_motif_consultation;
  Medecin? medecin;

  ChoixDate({required this.id_motif_consultation, required this.medecin});

  ChoixDateState createState() => ChoixDateState();
}

class ChoixDateState extends State<ChoixDate> {
  Map<String, List<Creneau>> listCreneau = {};
  List<String> keys = [];

  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listCreneau = getAllCreneauOfMedecin(
        medecin: widget.medecin!,
        id_motif_consultation: widget.id_motif_consultation);
    keys = listCreneau.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool active = false;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(233, 252, 255, 1),
        appBar: AppBar(
          backgroundColor: colorWidget,
          elevation: 0.0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage("http://54.38.186.80/front/img/medecins/" + widget.medecin!.img_1!),
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
              "Choisissez la date et l'heure",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                child: ListView.builder(
                    itemCount: keys.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Creneau>? creneaux = listCreneau[keys[index]];
                      return Column(
                            children: [
                              Container(
                                  width: size.width,
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [BoxShadow(blurRadius: 2)]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 1),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(showDate(
                                                  DateFormat.yMMMMEEEEd("fr_FR")
                                                      .format(DateTime.parse(
                                                          keys[index])))),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selected = !selected;
                                                    });
                                                  },
                                                  child: (selected)
                                                      ? const Icon(Icons
                                                          .keyboard_arrow_up)
                                                      : const Icon(Icons
                                                          .keyboard_arrow_down))
                                            ],
                                          )),
                                      Visibility(
                                          visible: selected,
                                          child: Flexible(
                                            child: GridView.count(
                                              childAspectRatio: 1.5,
                                                shrinkWrap: true,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                crossAxisCount: 3,
                                                children: creneaux!.map(
                                                        (e) => InkWell(child: styleCreneau(e), onTap: (){
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => ChoixProche(id_motif_consultation: widget.id_motif_consultation,medecin: widget.medecin, creneau: e,)),
                                                          );
                                                          },
                                                        )
                                                ).toList()),
                                          ))
                                    ],
                                  )),
                            ],
                          );
                    })),
          ],
        ));
  }
}
