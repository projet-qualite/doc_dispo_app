import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/medecin/creneau/list_creneau.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_email.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_mdp.dart';
import 'package:doc_dispo/pages/patient/identite/modifier_telephone.dart';
import 'package:doc_dispo/pages/patient/proche/liste_proche.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Mon Identité",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    (currentUser is Medecin) ?  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [

                          identite("Civilité: ",
                              ( currentUser.sexe != null) ?
                                ( currentUser.sexe == "m") ? "Monsieur" : "Madame"
                              : null),
                          identite("Nom: ", currentUser.nom),
                          identite("Prénom(s): ", currentUser.prenom),
                          identite("Date de naissance: ", currentUser.date_naissance,),
                        ],
                      ),
                    ) :
                    (getOwner(currentUser.id) != false ) ? Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          identite("Civilité: ", ( getOwner(currentUser.id).sexe == "m") ? "Monsieur" : "Madame"),
                          identite("Nom: ", getOwner(currentUser.id).nom),
                          identite("Prénom(s): ", getOwner(currentUser.id).prenom),
                          identite("Date de naissance: ", getOwner(currentUser.id).date_naissance,),
                        ],
                      ),
                    ) : Text('')

                  ],
                )
            ),
            const Divider(
              height: 20,
              color: Color.fromRGBO(120, 120, 120, .4),
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
                           color: Color.fromRGBO(59, 139, 150, 1),
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
                              (currentUser is Patient) ? "Ajouter et gérer vos proches" : "Gérer vos créneaux",
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
                  color: Color.fromRGBO(120, 120, 120, .4),
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
                  color: Color.fromRGBO(120, 120, 120, .4),
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
                  color: Color.fromRGBO(120, 120, 120, .4),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.lock,
                          size: 25,
                          color: Color.fromRGBO(59, 139, 150, 1),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Mot de passe",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              color: Color.fromRGBO(120, 120, 120, .4),
              thickness: 1,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setInt('currentUser', 0);
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
                  color: Color.fromRGBO(120, 120, 120, .4),
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
