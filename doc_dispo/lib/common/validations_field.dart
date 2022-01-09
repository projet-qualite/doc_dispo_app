import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/utilisateur.dart';
import 'package:doc_dispo/enums/type_field.dart';
import 'package:doc_dispo/common/data.dart';


bool validationLoginPatient(String email, String mdp)
{
  bool result = false;
  list_patient.forEach((key, value) {
    if(value.email == email && value.mdp == mdp) {
      result = true;
    }
  });

  return result;
}


Patient? getUser(String email, String mdp)
{
  Patient? result;
  list_patient.forEach((key, value) {
    if(value.email == email && value.mdp == mdp) {
      result = value;
    }
  });
  return result;
}


Medecin? getMedecin(String email, String mdp)
{
  Medecin? result;
  list_medecin.forEach((key, value) {
    if(value.email == email && value.mdp == mdp) {
      result = value;
    }
  });
  return result;
}


bool validationLoginMedecin(String email, String mdp)
{
  bool result = false;
  list_medecin.forEach((key, value) {
    if(value.email == email && value.mdp == mdp) {
      result = true;
    }
  });

  return result;
}


String? validField(String value, TypeField typeField, {String? valueMdp=null})
{
  switch(typeField)
  {
    case TypeField.MAIL:
      if(! ( value.contains("@") && value.contains(".") ) )
      {
        return "L'adresse email est incorrecte";
      }
      return null;
      break;

    case TypeField.PWD:
      if(value.length < 8)
      {
        return "Mot de passe trop court (Minimim 8 caractères)";
      }
      return null;
      break;

    case TypeField.C_PWD:
      if(value != valueMdp)
      {
        return "Les mots de passes doivent être égaux";
      }
      return null;
      break;



    default:
      return null;
  }
}