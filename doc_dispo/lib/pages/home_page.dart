import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/assurance.dart';
import 'package:doc_dispo/pages/patient/hopital.dart';
import 'package:doc_dispo/pages/patient/listes/list_hopital.dart';
import 'package:doc_dispo/pages/patient/rdv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> rdvs = [];
  void requetes()
  {
    getHopital().then((response) {
      setState(() {
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
        list_rdv_futur = response[0];
        list_rdv_passe = response[1];
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
      });
    });

    getAllCreneau().then((response) {
      setState(() {
        list_all_creneau = response;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requetes();
    if(currentUser != null)
      {
        if(currentUser is Patient)
        {
          rdvs = getRdvProche(currentUser.id);
        }
        else{
          rdvs = getRdvMedecins(currentUser.id);
        }
      }


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              width: size.width,
              decoration: BoxDecoration(
                  color: colorWidget,
              ),
              child: Column(
                children: [

                  (rdvs.isNotEmpty) ? Column(children: [Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    padding: const EdgeInsets.only(top: 20,left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Mes rendez vous",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ), Container(
                      height: size.height / 6.5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rdvs.length,
                          itemBuilder: (context, index) {
                            var rdv = rdvs[index];
                            return RdvTemplate(
                                key: ValueKey(rdv["creneau"].id),
                                concerne: (currentUser is Patient) ? rdv["medecin"] : rdv["proche"],
                                creneau: rdv["creneau"],
                                subtext: (currentUser is Patient) ? rdv["specialite"].libelle : rdv["date_naissance"]
                            );
                          }))],) :
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        margin: const EdgeInsets.only(top: 50, left: 10),
                        child: Image.asset(
                          "images/logo.png",
                          height: size.height / 30,
                        )
                    ),
                  )
                ],
              ),
            ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hopitaux",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 23),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ListHopital()),
                          );
                        },
                        child: const Text(
                          "Voir tout",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        )
                      )

                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list_hopital.length,
                      itemBuilder: (context, index) {
                        Map<String, List<dynamic>> listM =
                            getAllInformationsHopital(
                                id: list_hopital[index + 1]!.id);
                        return HopitalTemplate(
                          hopital: list_hopital[index + 1],
                          listAssurance: listM["assurances"],
                          listMedecin: listM["medecins"],
                          listSpecialite: listM["specialites"],
                        );
                      }),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Assurances",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 23),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 3,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list_assurance.length,
                      itemBuilder: (context, index) {
                        List<Hopital> listH = getAllInformationsAssurance(
                            id: list_assurance[index + 1]!.id);
                        return AssuranceTemplate(
                          assurance: list_assurance[index + 1],
                          listHopitaux: listH,
                        );
                      }),
                )
              ],
            ),
          ))
        ],
        ),

    );
  }
}
