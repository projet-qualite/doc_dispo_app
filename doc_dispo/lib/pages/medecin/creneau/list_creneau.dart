import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creneaux = getCreneauOfMedecin(currentUser.id);
  }


  void suppression(Creneau creneau)
  {
    supprimerCreneau(creneau).then((value) => {
      setState(() {
        isLoading = false;
      }),
      if(value.statusCode == 400)
        {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
                content: Text(
                    'Vous ne pouvez pas supprimer ce créneau.')),
          )
        }
      else{
        getCreneau().then((response) {
          setState(() {
            list_creneau = response;
            creneaux = getCreneauOfMedecin(currentUser.id);
          });
        }),
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
              content: Text(
                  'Créneau supprimé')),
        )

      }

    });
  }

  void showDialogF(String titre, String soustitre, Creneau creneau)
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
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                  });
                  suppression(creneau);
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
              Navigator.of(context).pop();
              setState(() {
                isLoading = true;
              });
              suppression(creneau);
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
            "Mes créneaux",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
          ),
          elevation: 0.0,
        ),
        body: (!isLoading) ? Stack(
          children: [
            Container(
              child: ListView.builder(
                  itemCount: creneaux.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    Creneau creneau = creneaux[index];
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  dateRdv(creneau.jour, creneau.heure),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis)),
                              IconButton(
                                  onPressed: () {
                                    showDialogF("Supression", "Voulez-vous supprimer ce creneau ?", creneau);
                                  }, icon: const Icon(
                                  Icons.delete,
                                color: Colors.red,
                              ),
                                  )
                            ],
                          ),
                          const Divider(
                            height: 20,
                            color: Color.fromRGBO(120, 120, 120, .4),
                            thickness: 1,
                          ),
                        ],
                      )
                    );
                  }),
            ),
          ],
        ) : const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
