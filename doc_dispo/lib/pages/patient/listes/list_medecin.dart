import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/details/detail_medecin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ListMedecin extends StatefulWidget {
  ListMedecin();

  ListMedecinState createState() => ListMedecinState();
}

class ListMedecinState extends State<ListMedecin> {
  List<Medecin> medecins = [];
  List<Specialite> specialites = [];
  late TextEditingController controller;

  void requetes()
  {
    getHopital().then((response) {
      setState(() {
        print(response);
        list_hopital = response;
      });
    });

    getAssurance().then((response) {
      setState(() {
        list_assurance = response;
      });
    });


    getAffilier().then((response) {
      setState(() {
        list_affilier = response;
      });
    });

    getSpecialite().then((response) {
      setState(() {
        list_specialite = response;
      });
    });

    getMedecin().then((response) {
      setState(() {
        list_medecin = response;
      });
    });


    getSpecialiteHopital().then((response) {
      setState(() {
        list_specialites_hopital = response;
      });
    });


    getRdv().then((response) {
      setState(() {
        list_rdv = response;
      });
    });

    getProche().then((response) {
      setState(() {
        list_proche = response;
      });
    });

    getCreneau().then((response) {
      setState(() {
        list_creneau = response;
        print(list_creneau);
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requetes();
    medecins = list_medecin.entries.map((e) => e.value).toList();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Trouver",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      Text(
                        "Un medecin",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset("images/avatar.png"),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Rechercher",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onChanged: (text) {
                    setState(() {
                      if (text == "") {
                        if (specialites.length == 0) {
                          medecins =
                              list_medecin.entries.map((e) => e.value).toList();
                        } else {
                          medecins = list_medecin.entries
                              .map((e) => e.value)
                              .toList()
                              .where((element) => getMedecinOfSpecialite(
                                  list: specialites, id: element.id))
                              .toList();
                        }
                      } else {
                        medecins = medecins
                            .where((element) =>
                                element.nom!
                                    .toLowerCase()
                                    .contains(text.toLowerCase()) ||
                                element.prenom!
                                    .toLowerCase()
                                    .contains(text.toLowerCase()))
                            .toList();
                      }
                    });
                  },
                )),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list_specialite.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(right: 2, left: 30),
                        padding: const EdgeInsets.all(10),
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: list_specialite[index + 1]!.selected!
                                ? colorWidget
                                : Colors.grey[400]),
                        child: Center(
                          child: Text(list_specialite[index + 1]!.libelle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: list_specialite[index + 1]!.selected!
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          list_specialite[index + 1]!.selected =
                              !list_specialite[index + 1]!.selected!;

                          if (list_specialite[index + 1]!.selected!) {
                            specialites.add(list_specialite[index + 1]!);
                            medecins = list_medecin.entries
                                .map((e) => e.value)
                                .toList()
                                .where((element) => getMedecinOfSpecialite(
                                    list: specialites, id: element.id))
                                .toList();
                          } else {
                            specialites.remove(list_specialite[index + 1]!);
                            if (specialites.length == 0) {
                              medecins = list_medecin.entries
                                  .map((e) => e.value)
                                  .toList();
                            } else {
                              medecins = list_medecin.entries
                                  .map((e) => e.value)
                                  .toList()
                                  .where((element) => getMedecinOfSpecialite(
                                      list: specialites, id: element.id))
                                  .toList();
                            }
                          }
                        });
                      },
                    );
                  }),
            ),
            Expanded(
              child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: medecins
                      .map((e) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailMedecin(medecin: e)),
                            );
                          },
                          child: cardElementMedecin(
                              title: e.type! + " " + e.nom! + " " + e.prenom!,
                              subtitle: getSpecialiteMedecin(id: e.id),
                              size: size,
                              image: "http://54.38.186.80/front/img/medecins/" + e!.img_1!)))
                      .toList()),
            )
          ],
        ));
  }
}
