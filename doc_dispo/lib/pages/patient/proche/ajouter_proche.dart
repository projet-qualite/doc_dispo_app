import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/common/validations_field.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/models/champ_formulaire.dart';
import 'package:doc_dispo/models/drop_down.dart';
import 'package:doc_dispo/pages/patient/proche/liste_proche.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import '../../navigation.dart';

class AjouterProche extends StatefulWidget {
  AjouterProcheState createState() => AjouterProcheState();
}

class AjouterProcheState extends State<AjouterProche> {
  TextEditingController password = TextEditingController();
  TextEditingController controller_mail = TextEditingController();
  TextEditingController controller_nom = TextEditingController();
  TextEditingController controller_prenom = TextEditingController();
  TextEditingController controller_date = TextEditingController();
  TextEditingController controller_phone = TextEditingController();

  String val = "";
  late final _formKey;
  String? default_value;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        locale: Locale("fr"),
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: currentDate);
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        controller_date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
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
          "Ajouter un proche",
          style: TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w800),
        ),
        elevation: 0.0,
      ),
      body: Container(
          height: size.height,
          width: size.width,
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
                          "Civilit??",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Text("Masculin"),
                                Radio<String>(
                                  value: "m",
                                  groupValue: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Feminin"),
                                Radio<String>(
                                  value: "f",
                                  groupValue: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        FormulaireField(
                          isPassword: false,
                          hint: "Nom",
                          data: Icons.drive_file_rename_outline,
                          typeField: TypeField.NORMAL,
                          controller: controller_nom,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vous devez entrer le nom";
                            }
                            return validField(value, TypeField.NORMAL);
                          },
                          number: false,
                          readOnly: false,
                          showDate: () {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormulaireField(
                          isPassword: false,
                          hint: "Prenom",
                          data: Icons.drive_file_rename_outline,
                          typeField: TypeField.NORMAL,
                          controller: controller_prenom,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vous devez entrer le pr??nom";
                            }
                            return validField(value, TypeField.NORMAL);
                          },
                          number: false,
                          showDate: () {},
                          readOnly: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: FormulaireField(
                            isPassword: false,
                            hint: "Date de naissance",
                            data: Icons.date_range,
                            typeField: TypeField.NORMAL,
                            controller: controller_date,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Vous devez entrer la date de naissance";
                              }
                              return validField(value, TypeField.NORMAL);
                            },
                            number: false,
                            showDate: () {
                              _selectDate(context);
                            },
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormulaireField(
                          isPassword: false,
                          number: true,
                          hint: "T??l??phone",
                          data: Icons.phone,
                          typeField: TypeField.TELEPHONE,
                          controller: controller_phone,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Vous devez entrer le num??ro de t??l??phone";
                            }
                            else if(value.length < 10)
                              {
                                return "Le num??ro doit contenir au moins 10 chiffres";
                              }
                            return validField(value, TypeField.TELEPHONE);
                          },
                          readOnly: false,
                          showDate: () {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        (definedOwner(currentUser.id) == false) ? DropDownField(
                          hintText: "C'est bien vous ?",
                          defaultValue: default_value,
                          personne: ["Oui", "Non"],
                          onChanged: (String? newValue) {
                            setState(() {
                              default_value = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value != "Oui" &&
                                value != "Non") {
                              return "Vous devez s??lectionner une option";
                            }
                            return null;
                          },

                        ) : Text(''),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if (val != "") {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  int id = list_proche.length + 1;

                                  int owner = 0;
                                  if(default_value == "Oui")
                                  {
                                    owner = 1;
                                  }

                                  Proche proche = Proche(
                                      id: id,
                                      slug: controller_nom.text,
                                      nom: controller_nom.text,
                                      prenom: controller_prenom.text,
                                      telephone: controller_phone.text,
                                      sexe: val,
                                      owner: owner,
                                      date_naissance:
                                          formatDate(controller_date.text),
                                      id_patient: currentUser.id);
                                  creerProche(proche).then((value) => {
                                        setState((){
                                          isLoading = false;
                                        }),
                                        if (value.statusCode == 201)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: Text('Enregistr??')),
                                            ),
                                            setState((){
                                              selectedIndex = 3;
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
                                        else
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Une erreur s\'est produite')),
                                            ),
                                          }
                                      });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Vous devez s??lectionner le genre')),
                                  );
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(59, 139, 150, 1),
                              ),
                              padding: const EdgeInsets.all(15),
                              child:  buttonRequest(isLoading, "Ajouter")
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
          )),
    );
  }
}
