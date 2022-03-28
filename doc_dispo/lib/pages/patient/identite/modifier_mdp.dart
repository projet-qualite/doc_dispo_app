import 'dart:convert';

import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/validations_field.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/models/champ_formulaire.dart';
import 'package:doc_dispo/pages/patient/proche/liste_proche.dart';
import 'package:doc_dispo/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation.dart';


class ModifierMdp extends StatefulWidget {

  ModifierMdpState createState() => ModifierMdpState();
}

class ModifierMdpState extends State<ModifierMdp> {
  TextEditingController controllerAMdp = TextEditingController();
  TextEditingController controllerMdp = TextEditingController();
  TextEditingController controllerCMdp = TextEditingController();
  bool isPassword = true;
  bool isPassword1 = true;
  bool isPassword2 = true;

  late final _formKey;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(210, 233, 236, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Modifier le mot de passe",
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
                              "Mot de passe",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            FormulaireField(
                              isPassword: isPassword,
                              suffix: (isPassword)
                                  ? IconButton(
                                  onPressed: () => setState(
                                          () => isPassword = !isPassword),
                                  icon: const Icon(Icons.visibility))
                                  : IconButton(
                                  onPressed: () => setState(
                                          () => isPassword = !isPassword),
                                  icon: const Icon(Icons.visibility_off)),
                              hint: "Ancien mot de passe",
                              data: Icons.lock,
                              typeField: TypeField.PWD,
                              controller: controllerAMdp,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Vous devez entrer le mot de passe";
                                }
                                return validField(value, TypeField.PWD);
                              }, number: false, showDate: () {  }, readOnly: false,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            FormulaireField(
                              isPassword: isPassword1,
                              suffix: (isPassword1)
                                  ? IconButton(
                                  onPressed: () => setState(
                                          () => isPassword1 = !isPassword1),
                                  icon: const Icon(Icons.visibility))
                                  : IconButton(
                                  onPressed: () => setState(
                                          () => isPassword1 = !isPassword1),
                                  icon: const Icon(Icons.visibility_off)),
                              hint: "Nouveau mot de passe",
                              data: Icons.lock,
                              typeField: TypeField.PWD,
                              controller: controllerMdp,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Vous devez entrer le mot de passe";
                                }
                                return validField(value, TypeField.PWD);
                              }, number: false, showDate: () {  }, readOnly: false,
                            ),

                            const SizedBox(height: 15,),
                            FormulaireField(
                              isPassword: isPassword2,
                              suffix: (isPassword2)
                                  ? IconButton(
                                  onPressed: () => setState(
                                          () => isPassword2 = !isPassword2),
                                  icon: const Icon(Icons.visibility))
                                  : IconButton(
                                  onPressed: () => setState(
                                          () => isPassword2 = !isPassword2),
                                  icon: const Icon(Icons.visibility_off)),
                              hint: "Confirmer le mot de passe",
                              data: Icons.lock,
                              typeField: TypeField.PWD,
                              controller: controllerCMdp,
                              validation: (value){
                                if(value == null || value.isEmpty)
                                {
                                  return "Confirmez le mot de passe";
                                }
                                return validField(value,TypeField.C_PWD, valueMdp: controllerMdp.text);
                              }, number: false, showDate: () {  }, readOnly: false,
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    if(currentUser is Patient)
                                    {
                                      updatePasswordPatient(controllerAMdp.text, controllerMdp.text,currentUser).then((value) => {
                                        setState(() {
                                          isLoading = false;
                                        }),
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
                                          if(value.statusCode == 404)
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content: Text('Une erreur s\'est produite')),
                                              )
                                            }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Mot de passe incorrect')),
                                            )
                                          }
                                        }
                                      });
                                    }
                                    else{
                                      updatePasswordMedecin(controllerAMdp.text, controllerMdp.text,currentUser).then((value) => {
                                        setState(() {
                                          isLoading = false;
                                        }),
                                        if(value.statusCode == 200)
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Enregistré')),
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
                                          if(value.statusCode == 404)
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content: Text('Une erreur s\'est produite')),
                                              )
                                            }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text('Mot de passe incorrect')),
                                            )
                                          }

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
                                  child: buttonRequest(isLoading, "Modifier")
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
