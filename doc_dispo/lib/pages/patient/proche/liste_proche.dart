import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/proche/ajouter_proche.dart';
import 'package:doc_dispo/pages/patient/proche/modifier_proche.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation.dart';

class ListeProche extends StatefulWidget {
  ListeProcheState createState() => ListeProcheState();
}

class ListeProcheState extends State<ListeProche> {
  List<Proche> proches = [];
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProche().then((response) {
      setState(() {
        list_proche = response;
        proches = getProcheOfPatient(currentUser.id);
        isLoad = false;
      });
    });

  }

  void showDialogF(String titre, String soustitre, Proche proche)
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
                  supprimerProche(proche).then((value) => {
                    if(value.statusCode == 204)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                            content: Text('Suppression éffectuée')),
                      ),
                      getProche().then((response) {
                        setState(() {
                          list_proche = response;
                          proches = getProcheOfPatient(currentUser.id);
                        });
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
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Une erreur s\'est produite')),),
                    }

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
              supprimerProche(proche).then((value) => {
                if(value.statusCode == 204)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Suppression éffectuée')),
                    ),
                    getProche().then((response) {
                      setState(() {
                        list_proche = response;
                        proches = getProcheOfPatient(currentUser.id);
                      });
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
                else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Une erreur s\'est produite')),),
                }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color.fromRGBO(210, 233, 236, 1),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Mes proches",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
          ),
          elevation: 0.0,
        ),
        body: (!isLoad) ?
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                  itemCount: proches.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    Proche proche = proches[index];
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
                                  avatar(proche.nom, proche.prenom),
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
                                    "M. " +
                                        proche.prenom +
                                        " " +
                                        proche.nom.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(dateNaissance(proche.date_naissance),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),

                              SizedBox(
                                width: 120,
                                child: Text(proche.telephone,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ModifierProche(proche: proche)),
                                    );
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        "MODIFIER",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10),
                                      )
                                    ],
                                  )),
                              TextButton(
                                  onPressed: () {
                                    showDialogF("Suppression",
                                        "Voulez-vous supprimer ce proche ? ( Supression impossible dans le cas où le proche ait déjà eu des rendez-vous )",
                                        proche
                                    );
                                  },
                                  child: const Text(
                                    "SUPPRIMER",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red,
                                        fontSize: 10),
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
                  padding: EdgeInsets.all(20),
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
                            Icons.person_add,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "AJOUTER UN PROCHE",
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
                            builder: (context) => AjouterProche()),
                      );
                    },
                  ),
                ))
          ],
        ) :

          Center(
            child: new CircularProgressIndicator(),
          ),

    );
  }
}
