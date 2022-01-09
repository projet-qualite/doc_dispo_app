import 'package:doc_dispo/classes/assurance.dart';
import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../hopital.dart';

class ListHopital extends StatefulWidget {
  ListHopital();

  ListHopitalState createState() => ListHopitalState();
}

class ListHopitalState extends State<ListHopital> {
  List<Hopital> hopitaux = [];
  List<Assurance> assurances = [];
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hopitaux = list_hopital.entries.map((e) => e.value).toList();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Liste des hôpitaux",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
          ),
          elevation: 0.0,
        ),
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
                        "Un Hôpital",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),

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
                        if (assurances.isEmpty) {
                          hopitaux =
                              list_hopital.entries.map((e) => e.value).toList();
                        } else {
                          hopitaux = list_hopital.entries
                              .map((e) => e.value)
                              .toList()
                              .where((element) => getHopitalOfAssurance(
                                  list: assurances, id: element.id))
                              .toList();
                        }
                      } else {
                        hopitaux = hopitaux
                            .where((element) => element.libelle!
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                      }
                    });
                  },
                )),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list_assurance.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(right: 2, left: 30),
                        padding: const EdgeInsets.all(10),
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: list_assurance[index + 1]!.selected!
                                ? colorWidget
                                : Colors.grey[400]),
                        child: Center(
                          child: Text(list_assurance[index + 1]!.libelle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: list_assurance[index + 1]!.selected!
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          //print(list_assurance[index + 1]!.selected);
                          list_assurance[index + 1]!.selected =
                              !list_assurance[index + 1]!.selected!;

                          if (list_assurance[index + 1]!.selected!) {
                            assurances.add(list_assurance[index + 1]!);
                            hopitaux = hopitaux
                                .where((element) => getHopitalOfAssurance(
                                    list: assurances, id: element.id))
                                .toList();
                          } else {
                            assurances.remove(list_assurance[index + 1]!);
                            if (assurances.isEmpty) {
                              hopitaux = list_hopital.entries
                                  .map((e) => e.value)
                                  .toList();
                            }
                            else{
                              hopitaux = list_hopital.entries.map((e) => e.value).toList().where((element) => getHopitalOfAssurance(list: assurances, id: element.id)).toList();
                            }
                          }
                        });
                      },
                    );
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: hopitaux.map((e) {
                    Map<String, List<dynamic>> listM =
                        getAllInformationsHopital(id: list_hopital[e.id]!.id);
                    return HopitalTemplate(
                      hopital: list_hopital[e.id],
                      listAssurance: listM["assurances"],
                      listMedecin: listM["medecins"],
                      listSpecialite: listM["specialites"],
                    );
                  }).toList()),
            )
          ],
        ));
  }
}
