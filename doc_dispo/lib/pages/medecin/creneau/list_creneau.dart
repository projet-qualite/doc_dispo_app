import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/medecin/creneau/ajouter_creneau.dart';
import 'package:doc_dispo/pages/patient/proche/ajouter_proche.dart';
import 'package:doc_dispo/pages/patient/proche/modifier_proche.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListeCreneau extends StatefulWidget {
  ListeCreneauState createState() => ListeCreneauState();
}

class ListeCreneauState extends State<ListeCreneau> {
  List<Creneau> creneaux = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creneaux = getCreneauOfMedecin(currentUser.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color.fromRGBO(210, 233, 236, 1),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Mes créneaux",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
          ),
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                  itemCount: creneaux.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    Creneau creneau = creneaux[index];
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Text(
                                  avatar(currentUser.nom, currentUser.prenom),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                    dateRdv(creneau.jour, creneau.heure),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                            ],
                          ),
                          Row(
                            children: [

                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      list_creneau.remove(creneau.id);
                                      creneaux = getCreneauOfMedecin(currentUser.id);
                                    });
                                  },
                                  child: const Text(
                                    "SUPPRIMER",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                        fontSize: 12),
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorWidget),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lock_clock_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "AJOUTER UN CRENEAU",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AjouterCreneau()),
                      );
                    },
                  ),
                ))
          ],
        ));
  }
}
