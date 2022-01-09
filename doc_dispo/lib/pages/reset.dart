import 'package:doc_dispo/common/validations_field.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/models/champ_formulaire.dart';
import 'package:doc_dispo/models/drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class Reset extends StatefulWidget
{
  ResetState createState() => ResetState();
}

class ResetState extends State<Reset>
{
  String? default_value = null;
  bool isPassword = true;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerMdp = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    List<String> personnes = <String> ["Un medecin", "Un patient"];

    return Scaffold(
      backgroundColor: Colors.white,
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
                      header(width: size.width, mainTitle: "Réinitialisation",
                          subtitle1: "",subtitle2: "",
                          back: true,
                          context: context,
                          route: ''
                      ),

                      const SizedBox(height: 70,),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DropDownField(
                              hintText: "Vous êtes ?",
                              defaultValue: default_value,
                              personne: personnes,
                              onChanged: (String? newValue){
                                setState(() {
                                  default_value = newValue!;
                                });
                              },
                              validator: (value){
                                if(value != "Un medecin" && value != "Un patient")
                                {
                                  return "Vous devez sélectionner une option";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30,),
                            FormulaireField(
                              isPassword: false,
                              hint: "Entrez l'adresse",
                              data: Icons.mail,
                              typeField: TypeField.MAIL,
                              controller: controllerEmail,
                              validation: (value){
                                if(value == null || value.isEmpty)
                                {
                                  return "Vous devez entrer l'adresse mail";
                                }
                                return validField(value,TypeField.MAIL);
                              }, number: false, readOnly: false, showDate: () {  },
                            ),


                            const SizedBox(height: 80,),


                            InkWell(
                                onTap: (){
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(59, 139, 150, 1),
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: const Center(
                                    child: Text(
                                      "Réinitialiser",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                )

                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                )
            ),
          )
      ),
    );

  }

}