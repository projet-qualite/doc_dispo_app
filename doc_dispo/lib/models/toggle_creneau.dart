import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/rdv/choix_proche.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToggleCreneau extends StatefulWidget {
  String index;
  List<Creneau>? creneaux;
  bool selected;
  int id_motif_consultation;
  Medecin medecin;

  ToggleCreneau({required this.index, required this.creneaux, this.selected = false,
    required this.id_motif_consultation, required this.medecin});

  ToggleCreneauState createState() => ToggleCreneauState();
}

class ToggleCreneauState extends State<ToggleCreneau> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Container(
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
                  CrossAxisAlignment.center,
                  children: [
                    Text(showDate(
                        DateFormat.yMMMMEEEEd("fr_FR")
                            .format(DateTime.parse(
                            widget.index)))),
                    InkWell(
                        onTap: () {
                          setState(() {
                            widget.selected = !widget.selected;
                          });
                        },
                        child: (widget.selected)
                            ? const Icon(Icons
                            .keyboard_arrow_up)
                            : const Icon(Icons
                            .keyboard_arrow_down))
                  ],
                )),
            Visibility(
                visible: widget.selected,
                child: Flexible(
                  child: GridView.count(
                      childAspectRatio: 1.5,
                      shrinkWrap: true,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: widget.creneaux!.map(
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
        ));
  }
}
