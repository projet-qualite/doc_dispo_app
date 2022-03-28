import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/rdv2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Rdv extends StatefulWidget {
  RdvState createState() => RdvState();
}

class RdvState extends State<Rdv> {
  late List<Map<String, dynamic>> rdvs;
  late List<Map<String, dynamic>> rdvspasses = [];

  bool isLoad = true;


  void showDialogF(String titre, String soustitre, dynamic rdv)
  {
    (Theme.of(context).platform == TargetPlatform.iOS) ? showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title:  Text(titre),
          content: Text(soustitre),
          actions: [
            CupertinoDialogAction(
                child: const Text("Oui"),
                onPressed: ()
                {
                  supprimerRdv(rdv)
                      .then((value) =>
                  {
                    if(value.statusCode == 204)
                      {
                        snackbar('Rendez-vous annulé', context),
                        getRdv().then((response) {
                          setState(() {
                            list_rdv_futur = response[0];
                            list_rdv_passe = response[1];
                            rdvs = getRdvProche(currentUser.id);
                            rdvspasses = getRdvPasseProche(currentUser.id);
                          });
                        }),
                      }
                    else
                      {
                        if(value.statusCode == 403)
                          {
                            snackbar('Vous ne pouvez pas annuler ce rdv', context)
                          }
                        else
                          {
                            snackbar('Une erreur s\'est produite', context)
                          }
                      },
                  Navigator.of(context).pop()
                  });
                }
            ),
            CupertinoDialogAction(
              child: const Text("Non"),
              onPressed: (){
                Navigator.of(context).pop();
              }
              ,
            )
          ],
        );
      },
    ) :

    showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(titre),
            content: Text(soustitre),
            actions: [
              TextButton(
                onPressed: () {
                  supprimerRdv(rdv)
                      .then((value) =>
                  {
                    if(value.statusCode == 204)
                      {
                        snackbar('Rendez-vous annulé', context),
                        getRdv().then((response) {
                          setState(() {
                            list_rdv_futur = response[0];
                            list_rdv_passe = response[1];
                            rdvs = getRdvProche(currentUser.id);
                            rdvspasses = getRdvPasseProche(currentUser.id);
                          });
                        }),
                      }
                    else
                      {
                        if(value.statusCode ==
                            403)
                          {
                            snackbar('Vous ne pouvez pas annuler ce rdv', context),
                          }
                        else
                          {
                            snackbar('Une erreur s\'est produite', context),
                          }
                      },
                    Navigator.of(context).pop()
                  });
                },
                child: const Text('Oui', style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Non', style: TextStyle(color: Colors.black),),
              ),
            ],
          );
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRdv().then((response) {
      setState(() {
        list_rdv_futur = response[0];
        list_rdv_passe = response[1];
        if(currentUser is Medecin )
        {
          rdvs = getRdvMedecins(currentUser.id);
          rdvspasses = getRdvPasseMedecins(currentUser.id);
        }
        else{
          rdvs = getRdvProche(currentUser.id);
          rdvspasses = getRdvPasseProche(currentUser.id);
        }

        isLoad = false;
      });
    });




  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(210, 233, 236, 1),
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
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      width: size.width / 1.2,
                      height: 50,
                      child: TabBar(
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: const Color.fromRGBO(59, 139, 150, 1),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.grey[400],
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
                (isLoad) ?
                Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const CircularProgressIndicator(),
                    )
                ) :
                Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                              itemCount: rdvs.length,
                              itemBuilder: (context, index) {
                                var rdv = rdvs[index];
                                return Container(
                                  width: size.width / 1.1,
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(left: 40, right: 40, top: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            child: CircleAvatar(
                                              backgroundImage:
                                              (currentUser is Patient) ?
                                                (rdv["medecin"].img_1 != null) ? NetworkImage(urlSite+"/front/img/medecins/${rdv["medecin"].img_1}") :
                                                  NetworkImage(urlSite+"/front/img/avatar.png")
                                              : NetworkImage(urlSite+"/front/img/avatar.png"),
                                              radius: 20,
                                            ),
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
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              (currentUser is Patient) ? Text(
                                                rdv["specialite"].libelle,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300, fontSize: 11),
                                              ) : Text(
                                                rdv["date_naissance"],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300, fontSize: 11),
                                              )
                                            ],
                                          ),
                                          (currentUser is Patient) ?
                                          Container(
                                            margin: const EdgeInsets.only(left: 30),
                                            child: InkWell(
                                                child: const Icon(Icons.delete, color: Colors.red,),
                                                onTap: () {
                                                  showDialogF("Confirmer l'annulation",
                                                      "Voulez-vous annuler ce rdv ?",
                                                      rdv["rdv"]);
                                                }
                                            ),
                                          ): const Text('')
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                                  )
                                );



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
                                    subtext: rdv["specialite"].libelle
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
                                    subtext: rdv["date_naissance"]!
                                );
                              })
                        ],
                      ),
                )
              ],
            )));
  }
}
