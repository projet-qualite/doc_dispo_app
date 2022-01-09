import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/utilisateur.dart';
import 'package:doc_dispo/common/validations_field.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/models/champ_formulaire.dart';
import 'package:doc_dispo/models/drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:doc_dispo/common/data.dart';
class SignIn extends StatefulWidget
{
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn>
{
  String? default_value = null;
  bool isPassword1 = true;
  bool isPassword2 = true;
  TextEditingController password = TextEditingController();
  TextEditingController controller_mail = TextEditingController();
  TextEditingController controller_mdp = TextEditingController();
  TextEditingController controller_cmdp = TextEditingController();
  late final _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

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
                      header(width: size.width, mainTitle: "Inscription",
                          subtitle1: "Vous avez déjà un compte ? / ",subtitle2: "Connexion.",
                          context: context,
                          route: '/navigation'
                      ),

                      const SizedBox(height: 40,),


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
                                hint: "Email",
                                data: Icons.mail,
                                typeField: TypeField.MAIL,
                                controller: controller_mail,
                                validation: (value){
                                  if(value == null || value.isEmpty)
                                  {
                                    return "Vous devez entrer l'adresse mail";
                                  }
                                  return validField(value,TypeField.MAIL);
                                }, number: false, showDate: () {  }, readOnly: false,
                              ),



                            const SizedBox(height: 30,),

                            FormulaireField(
                              isPassword: isPassword1,
                              suffix: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isPassword1=!isPassword1;
                                    });
                                  }, child: Icon( (isPassword1) ? Icons.visibility : Icons.visibility_off)
                              ),
                              hint: "Mot de passe",
                              data: Icons.lock,
                              typeField: TypeField.PWD,
                              controller: controller_mdp,
                              validation: (value){
                                if(value == null || value.isEmpty)
                                {
                                  return "Entrez le mot de passe";
                                }
                                return validField(value,TypeField.PWD);
                              }, number: false, showDate: () {  }, readOnly: false,
                            ),

                            const SizedBox(height: 30,),
                            FormulaireField(
                              isPassword: isPassword2,
                              suffix: IconButton(onPressed: () => setState(() => isPassword2=!isPassword2),
                                  icon: (isPassword2) ? const Icon(Icons.visibility) : const Icon(Icons.visibility)),
                              hint: "Confirmer le mot de passe",
                              data: Icons.lock,
                              typeField: TypeField.PWD,
                              controller: controller_cmdp,
                              validation: (value){
                                if(value == null || value.isEmpty)
                                {
                                  return "Confirmez le mot de passe";
                                }
                                return validField(value,TypeField.C_PWD, valueMdp: controller_mdp.text);
                              }, number: false, showDate: () {  }, readOnly: false,
                            ),

                            const SizedBox(height: 40,),




                            InkWell(
                                onTap: (){
                                  if (_formKey.currentState!.validate()) {

                                    var index;
                                    if(default_value == "Un patient")
                                      {
                                        index = list_patient.length+1;
                                        list_patient[index] = Patient(id: index, slug: controller_mail.text,email: controller_mail.text, mdp: controller_mdp.text);
                                      }
                                    else{
                                      index = list_medecin.length+1;
                                      list_medecin[index] = Medecin(id: index, email: controller_mail.text, mdp: controller_mdp.text);
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(59, 139, 150, 1),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: const Center(
                                    child: Text(
                                      "S'inscrire",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
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