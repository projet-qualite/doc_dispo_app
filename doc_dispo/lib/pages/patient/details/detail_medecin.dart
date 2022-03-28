import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/jour.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/rdv/choix_motif.dart';
import 'package:flutter/material.dart';
import 'package:doc_dispo/common/colors.dart';

class DetailMedecin extends StatefulWidget {
  Medecin? medecin;

  DetailMedecin({required this.medecin});

  DetailMedecinState createState() => DetailMedecinState();
}

class DetailMedecinState extends State<DetailMedecin> {
  String specialite = "";
  String hopital = "";
  Map<String, List<Creneau>> list = {};
  List<Creneau> creneaux = [];
  bool lire_plus = false;
  late Jour jour;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    specialite = getSpecialiteMedecin(id: widget.medecin!.id)!.libelle;
    hopital = list_hopital[widget.medecin!.id_hopital]!.libelle!;

    getMotifConsultation().then((response) => {
      setState(() {
        motifs_consultation = response;
      })
    });

    list_creneau.forEach((key, value) => {
          if (value != null && value.id_medecin == widget.medecin!.id!)
            {
              if (list[value.jour] == null)
                {
                  list[value.jour] = [value]
                }
              else
                {
                  creneaux = list[value.jour]!,
                  creneaux.add(value),
                  list[value.jour] = creneaux
                }
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail medecin"),
        elevation: 0.0,
      ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: size.height / 2,
                width: size.width,
                color: Colors.green,
                child: Image.network(
                  ( widget.medecin!.img_1 != null ) ?
                  urlSite+"/front/img/medecins/" + widget.medecin!.img_1! : urlSite+"/front/img/default.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  height: size.height / 2,
                  width: size.width,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.medecin!.type! +
                                  " " +
                                  widget.medecin!.nom! +
                                  " " +
                                  widget.medecin!.prenom!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              hopital,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              specialite,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.medecin!.biographie!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),


                          ],
                        ),
                      )),
                )),


            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: (currentUser is Patient) ? InkWell(
                  child: Container(
                    height: (Theme.of(context).platform == TargetPlatform.iOS) ? 80 : 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: colorWidget,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight:  Radius.circular(30)) ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 9),
                      child: Center(
                        child: Text(
                          "Prendre rendez-vous en ligne",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    if(currentUser != null)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChoixMotif(medecin: widget.medecin)),
                        );
                      }
                    else{
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Vous devez vous inscrire ou créer un compte')),
                      );
                    }
                  },
                ) : const Text('')
            ),
          ],
        ));
  }
}
