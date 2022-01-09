import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/motif.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/classes/rdv.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChoixProche extends StatefulWidget {
  int id_motif_consultation;
  Medecin? medecin;
  Creneau? creneau;

  ChoixProche({required this.id_motif_consultation, required this.medecin, required this.creneau});

  ChoixProcheState createState() => ChoixProcheState();
}

class ChoixProcheState extends State<ChoixProche> {

  List<Proche> proches = [];
  int procheSelected = -1;
  int val = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    proches = getProcheOfPatient(currentUser.id);
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
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Pour qui prenez vous le rendez-vous ?",
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
                  shrinkWrap: true,
                    itemCount: proches.length,
                    itemBuilder: (BuildContext context, int index) {
                      Proche proche = proches[index];
                      return ListTile(
                        title: Text(proche.prenom+" "+proche.nom),
                        leading: Radio<int>(
                          value: proche.id,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value!;
                            });
                          },
                        ),
                      );
                    }
                    )
            ),
            TextButton(onPressed: (){}, child: Text("Ajouter un proche")),

            InkWell(
                onTap: (){
                  int id = list_rdv.length+1;

                    Rdv rdv = Rdv(
                      id: id, id_creneau: widget.creneau!.id, etat: 0, slug: '', compte_rendu: '', id_proche: val,
                    );
                    list_creneau[widget.creneau!.id]!.etat = 1;

                  creerRdv(rdv).then((value) => {
                    if (value.statusCode == 201)
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                              content: Text('Rdv enregistré')),
                        ),
                        setState((){
                          selectedIndex = 2;
                        }),
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                                Navigation(),
                          ),
                              (route) => false,
                        )
                      }
                    else
                      {
                        if(value.statusCode == 404)
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Ce créneau est déjà pris')),
                            ),
                          }
                        else{
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Une erreur s\'est produite')),
                          ),
                        }

                      }
                  });


                },
                child: Container(
                  width: size.width/1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: const Color.fromRGBO(59, 139, 150, 1),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      "Confirmer le rendez-vous",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )

            ),
          ],
        )
    );
  }
}
