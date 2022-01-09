import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_email.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_mdp.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_telephone.dart';
import 'package:doc_dispo/pages/patient/proche/liste_proche.dart';
import 'package:doc_dispo/pages/patient/rdv2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation.dart';

class Rdv extends StatefulWidget {
  RdvState createState() => RdvState();
}

class RdvState extends State<Rdv> {
  List<Map<String, dynamic>> rdvs = [];
  List<Map<String, dynamic>> rdvspasses = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRdv().then((response) {
      setState(() {
        list_rdv = response;
        if(currentUser is Medecin )
        {
          rdvs = getRdvMedecins(currentUser.id);
          rdvspasses = getRdvPasseMedecins(currentUser.id);
        }
        else{
          rdvs = getRdvProche(currentUser.id);
          rdvspasses = getRdvPasseProche(currentUser.id);
        }
      });
    });



  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Color.fromRGBO(210, 233, 236, 1),
            appBar: AppBar(
              title: const Text(
                "Mes Rendez-vous",
                style: TextStyle(
                    fontFamily: "Roboto", fontWeight: FontWeight.w800),
              ),
              elevation: 0.0,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      width: size.width / 1.3,
                      height: 50,
                      child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: const Color.fromRGBO(59, 139, 150, 1),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey,
                        ),
                        tabs: const [
                          Tab(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("A venir")),
                          ),
                          Tab(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Passé")),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                              itemCount: rdvs.length,
                              itemBuilder: (context, index) {
                                var rdv = rdvs[index];
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
                                                child: (currentUser is Patient) ?
                                                Text(
                                                  rdv["medecin"].type! +
                                                      " " +
                                                      rdv["medecin"].nom! +
                                                      " " +
                                                      rdv["medecin"].prenom!,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w700, fontSize: 17),
                                                ) : Text(
                                                      rdv["proche"].nom! +
                                                      " " +
                                                      rdv["proche"].prenom!,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w700, fontSize: 17),
                                                )
                                              ),
                                              Text(
                                                rdv["specialite"].libelle,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300, fontSize: 11),
                                              )
                                            ],
                                          ),
                                          (currentUser is Patient) ?
                                          IconButton(onPressed: (){

                                            supprimerRdv(rdv["rdv"]).then((value) => {
                                              if(value.statusCode == 204)
                                                {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                        content: Text('Suppression éffectuée')),
                                                  ),
                                                  getRdv().then((response) {
                                                    setState(() {
                                                      list_rdv = response;
                                                      rdvs = getRdvProche(currentUser.id);
                                                      rdvspasses = getRdvPasseProche(currentUser.id);
                                                    });
                                                  }),
                                                }
                                              else{
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                      content: Text('Une erreur s\'est produite')),
                                                ),
                                              }

                                            });
                                            setState(() {
                                              rdvs.remove(rdv);
                                            });
                                          }, icon: Icon(Icons.delete, color: Colors.red,)) : const Text('')
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.event_note),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(dateRdv(rdv["creneau"].jour, rdv["creneau"].heure))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );


                                  /*RdvTemplate2(
                                      key: ValueKey(rdv["creneau"].id),
                                      medecin: rdv["medecin"],
                                      creneau: rdv["creneau"],
                                      specialite: rdv["specialite"]
                                );*/
                              }),

                          (currentUser is Patient) ?
                          ListView.builder(
                              itemCount: rdvspasses.length,
                              itemBuilder: (context, index) {
                                var rdv = rdvspasses[index];
                                return RdvTemplate2(
                                    key: ValueKey(rdv["creneau"].id),
                                    concerne: rdv["medecin"],
                                    creneau: rdv["creneau"],
                                    specialite: rdv["specialite"]
                                );
                              }) :
                          ListView.builder(
                              itemCount: rdvspasses.length,
                              itemBuilder: (context, index) {
                                var rdv = rdvspasses[index];
                                return RdvTemplate2(
                                    key: ValueKey(rdv["creneau"].id),
                                    concerne: rdv["proche"],
                                    creneau: rdv["creneau"],
                                    specialite: rdv["specialite"]
                                );
                              })
                        ],
                      ),
                )
              ],
            )));
  }
}
