import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/medecin/creneau/list_creneau.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_email.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_mdp.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_telephone.dart';
import 'package:doc_dispo/pages/patient/proche/liste_proche.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
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


  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Mon compte",
            style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
          ),
          elevation: 0.0,
        ),
        body: (currentUser != null) ?
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Identité",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      color: Color.fromRGBO(150, 150, 150, 1)),
                ),
              ),
            ),
            const Divider(
              height: 20,
              color: Color.fromRGBO(120, 120, 120, 1),
              thickness: 1,
            ),
            Column(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Icon(
                          (currentUser is Patient) ? Icons.people : Icons.lock_clock,
                          size: 25,
                          color: const Color.fromRGBO(59, 139, 150, 1),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              (currentUser is Patient) ? "Proches" : "Créneaux",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              (currentUser is Patient) ? "Ajouter et gérer vos proches" : "Ajouter et gérer vos créneaux",
                              style: const TextStyle(
                                  color: Color.fromRGBO(109, 109, 109, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if(currentUser is Patient)
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListeProche()),
                        );
                      }
                    else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListeCreneau()),
                      );
                    }

                  },
                ),
                const Divider(
                  height: 20,
                  color: Color.fromRGBO(120, 120, 120, 1),
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifierTelephone()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 25,
                          color: Color.fromRGBO(59, 139, 150, 1),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Téléphone",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              currentUser.telephone,
                              style: const TextStyle(
                                  color: Color.fromRGBO(109, 109, 109, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Color.fromRGBO(120, 120, 120, 1),
                  thickness: 1,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifierEmail()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.email,
                          size: 25,
                          color: Color.fromRGBO(59, 139, 150, 1),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              currentUser.email!,
                              style: const TextStyle(
                                  color: Color.fromRGBO(109, 109, 109, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Color.fromRGBO(120, 120, 120, 1),
                  thickness: 1,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ModifierMdp()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.people,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mot de passe",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              hidePassword(currentUser.mdp),
                              style: const TextStyle(
                                  color: Color.fromRGBO(109, 109, 109, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              color: Color.fromRGBO(120, 120, 120, 1),
              thickness: 1,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      currentUser = null;
                      selectedIndex = 0;
                    });
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/navigation", (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 25,
                          color: Color.fromRGBO(59, 139, 150, 1),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Déconnexion",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Color.fromRGBO(120, 120, 120, 1),
                  thickness: 1,
                ),

                /*InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Column(
                          children: const [
                            Text(
                              "Supprimer le compte",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ],
        ): LogIn()
    ) ;
  }
}
