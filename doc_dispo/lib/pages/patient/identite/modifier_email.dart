import 'dart:convert';

import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/validations_field.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/models/champ_formulaire.dart';
import 'package:doc_dispo/pages/patient/proche/liste_proche.dart';
import 'package:doc_dispo/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation.dart';


class ModifierEmail extends StatefulWidget {

  ModifierEmailState createState() => ModifierEmailState();
}

class ModifierEmailState extends State<ModifierEmail> {
  TextEditingController controller_mail = TextEditingController();

  late final _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    controller_mail.text = currentUser.email;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(210, 233, 236, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Modifier l'email",
          style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
        ),
        elevation: 0.0,
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            FormulaireField(
                              isPassword: false,
                              hint: "Email",
                              data: Icons.mail,
                              typeField: TypeField.MAIL,
                              controller: controller_mail,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Vous devez entrer l'adresse mail";
                                }
                                return validField(value, TypeField.MAIL);
                              },
                              number: false,
                              showDate: () {},
                              readOnly: false,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {

                                    if(currentUser is Patient)
                                    {
                                      updateEmailPatient(controller_mail.text,currentUser).then((value) => {
                                        if(value.statusCode == 200)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Enregistrer')),
                                            ),
                                            setState(() {
                                              currentUser = Patient.fromJson(json.decode(value.body));
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
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Une erreur s\'est produite')),
                                          )
                                        }
                                      });
                                    }
                                    else{
                                      updateEmailMedecin(controller_mail.text,currentUser).then((value) => {
                                        if(value.statusCode == 200)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Enregistrer')),
                                            ),
                                            setState(() {
                                              currentUser = Medecin.fromJson(json.decode(value.body));
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
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Une erreur s\'est produite')),
                                          )
                                        }
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(59, 139, 150, 1),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(
                                    child: Text(
                                      "Modifier",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))

                    ],
                  ),
                )),
          )),
    );
  }
}
