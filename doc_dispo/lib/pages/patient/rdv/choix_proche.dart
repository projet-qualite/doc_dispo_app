import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/motif.dart';
import 'package:doc_dispo/classes/motif_consultation.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/classes/rdv.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/navigation.dart';
import 'package:doc_dispo/pages/patient/proche/ajouter_proche.dart';
import 'package:flutter/cupertino.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    proches = getProcheOfPatient(currentUser.id);
  }

  void creation(Rdv rdv)
  {
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

          getRdv().then((response) => {
            list_rdv_futur = response[0],
            list_rdv_passe = response[1],
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                    Navigation(),
              ),
                  (route) => false,
            )
          }),

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
  }

  void showDialogF(String titre, String soustitre, Rdv rdv)
  {
    Creneau creneau = list_creneau[rdv.id_creneau]!;
    Medecin medecin = list_medecin[creneau.id_medecin]!;
    String nom = medecin.type! +" "+medecin.nom! + " "+ medecin.prenom!;
    Hopital hopital = list_hopital[medecin.id_hopital]!;
    Specialite specialite = list_specialite[medecin.id_specialite]!;

    int id_motif_consultation = motifs_consultation[widget.id_motif_consultation]!.id_motif;
    String motif = motifs[id_motif_consultation]!.libelle;
    (Theme.of(context).platform == TargetPlatform.iOS) ? showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title:  Text(titre),
          content: Column(
            children: [
              recapitulatif("Medecin", nom),
              recapitulatif("Specialité", specialite.libelle),
              recapitulatif("Hôpital", hopital.libelle),
              recapitulatif("Motif", motif),
              recapitulatif("Date", dateRdv(creneau.jour, creneau.heure)),
            ],
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Valider"),
                onPressed: ()
                {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                  });
                  creation(rdv);
                }
            ),
            CupertinoDialogAction(
              child: const Text("Annuler"),
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
      content: Column(
        children: [
          recapitulatif("Medecin", nom),
          recapitulatif("Specialité", specialite.libelle),
          recapitulatif("Hôpital", hopital.libelle),
          recapitulatif("Motif", motif),
          recapitulatif("Date", dateRdv(creneau.jour, creneau.heure)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              isLoading = true;
            });
            creation(rdv);
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
    );}
    );
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
                (widget.medecin!.img_1 != null) ?
                NetworkImage(urlSite+"/front/img/medecins/" + widget.medecin!.img_1!)
                    : NetworkImage(urlSite+"/front/img/default.jpg")
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
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjouterProche()),
              );
            }, child: Text("Ajouter un proche")),

            InkWell(
                onTap: (){
                  int id = list_rdv_futur.length+1;

                    Rdv rdv = Rdv(
                      id: id, id_creneau: widget.creneau!.id, etat: 0, slug: '', compte_rendu: '', id_proche: val,
                    );
                    list_creneau[widget.creneau!.id]!.etat = 1;
                    showDialogF("Récapitulatif", "", rdv);



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
