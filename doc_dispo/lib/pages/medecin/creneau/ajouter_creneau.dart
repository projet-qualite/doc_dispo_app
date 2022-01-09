import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/validations_field.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/models/champ_formulaire.dart';
import 'package:doc_dispo/models/drop_down.dart';
import 'package:doc_dispo/pages/medecin/creneau/list_creneau.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';


class AjouterCreneau extends StatefulWidget {
  AjouterCreneauState createState() => AjouterCreneauState();
}

class AjouterCreneauState extends State<AjouterCreneau> {
  TextEditingController controller_date = TextEditingController();

  List<String?> options = [
    "8.30",
    "9.00",
    "9.30",
    "10.00",
    "10.30",
    "11.00",
    "11.30",
    "12.00",
    "12.30",
    "13.00",
    "13.30",
    "14.00",
    "14.30",
    "15.00",
    "15.30",
    "16.00",
    "16.30",
    "17.00",
    "17.30"
  ];

  List<Object>? val = [];
  late final _formKey;

  String? default_value = null;
  List<Map<String, dynamic>> listMotif = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    listMotif = getMotifOfMedecin(id: currentUser.id);

    listMotif.forEach((element) {
      print(element["motif"]);
    });
  }

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        locale: Locale("fr"),
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(currentDate.year+2));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        controller_date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(210, 233, 236, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ajouter un créneau",
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
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(
                              height: 15,
                            ),

                            DropDownField(
                              hintText: "Motif de consultation",
                              defaultValue: default_value,
                              personne: listMotif.map((e) => e["motif"].toString()).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  default_value = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Vous devez sélectionner une option";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            InkWell(
                              onTap: () {
                                print("FFFFFFF");
                              },
                              child: FormulaireField(
                                isPassword: false,
                                hint: "Date",
                                data: Icons.date_range,
                                typeField: TypeField.NORMAL,
                                controller: controller_date,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Vous devez entrer la date";
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
                            MultiSelectDialogField(
                              searchHint: "Selectionner l'heure",
                              cancelText: const Text("Annuler"),
                              confirmText: const Text("Confirmer"),
                              title: const Text("Selectionner l'heure"),
                              items: options.map((e) => MultiSelectItem(e, e!)).toList(),
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (values){
                                val = values.cast<Object>();
                              },
                              validator: (values){
                                if(values!.isEmpty)
                                  {
                                    return "Vous devez entrer une heure";
                                  }
                              },
                            ),


                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {

                                    if(!val!.isEmpty)
                                    {
                                      List<Creneau> list = getCreneauOfMedecin(currentUser.id);

                                      for(int i = 0 ; i < val!.length; i++)
                                        {
                                          String? heure =  val![i].toString();
                                          int motif = listMotif.where((element) => element["motif"].libelle == default_value).toList()[0]["id_motif_consult"];
                                          int id = 6+i;
                                          list_creneau[id] = Creneau(
                                                id: 6+i,
                                                slug: formatDate(controller_date.text),
                                                jour: formatDate(controller_date.text),
                                                heure: heure,
                                                id_motif_consult: motif,
                                                id_medecin: currentUser.id,
                                                etat: 0
                                          );


                                        }

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Enregistrer')),
                                      );

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => ListeCreneau(),
                                        ),
                                            (route) => false,
                                      );
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Vous devez sélectionner au moins une heure')),
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
                                  child: const Center(
                                    child: Text(
                                      "Ajouter",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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
