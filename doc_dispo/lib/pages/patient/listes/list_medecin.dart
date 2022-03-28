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
  bool specialiteLoading = true;
  bool medecinLoading = true;

  void requetes()
  {

    getSpecialite().then((response) {
      setState(() {
        list_specialite = response;
        bool specialiteLoading = false;
      });
    });

    getMedecin().then((response) {
      setState(() {
        list_medecin = response;
        medecinLoading = false;
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
        appBar: AppBar(
          title: const Text(
            "Trouver un medecin",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
          ),
          elevation: 0.0,
        ),
        body: Column(
          children: [

            Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: (Theme.of(context).platform == TargetPlatform.android) ?
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      hintText: "Rechercher",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
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
                ) : CupertinoSearchTextField(
                  controller: controller,
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
                )
            ),
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
                      child: libelle(list_specialite[index + 1]!.selected!
                          ? colorWidget
                          : Colors.grey[200]!,
                        list_specialite[index + 1]!.libelle,
                          list_specialite[index + 1]!.selected!
                              ? Colors.white
                              : Colors.black
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
            const SizedBox(height: 30,),
            (medecinLoading && specialiteLoading) ?
            Center(child: Container(
              margin: EdgeInsets.only(top: 50),
                child: new CircularProgressIndicator(),
            )) : Expanded(
              child: GridView.count(
                  mainAxisSpacing: 10,
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
                              image: ( e.img_1 != null ) ?
                                  urlSite+"front/img/medecins/" + e.img_1! : urlSite+"front/img/default.jpg")))
                      .toList()),
            )
          ],
        ));
  }
}
