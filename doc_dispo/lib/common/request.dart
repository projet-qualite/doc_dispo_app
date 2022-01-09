import 'dart:convert';

import 'package:doc_dispo/classes/affilier.dart';
import 'package:doc_dispo/classes/assurance.dart';
import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/motif.dart';
import 'package:doc_dispo/classes/motif_consultation.dart';
import 'package:doc_dispo/classes/patient.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:doc_dispo/classes/rdv.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/classes/specialites_hopital.dart';
import 'package:http/http.dart' as http;


var url = 'http://54.38.186.80/api/';

Future<List<Affilier>> getAffilier() async {

  final response = await http.get(
      Uri.parse(url+'affilier'),
      //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyAffilier = json.decode(response.body);
    List<Affilier> listAffilier = [];
    bodyAffilier.forEach((affilier) {
      listAffilier.add(Affilier.fromJson(affilier));
    });

    return listAffilier;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<Map<int, Assurance>> getAssurance() async {

  final response = await http.get(
    Uri.parse(url+'assurance'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyAssurance = json.decode(response.body);
    print(bodyAssurance);
    Map<int, Assurance> listAssurance = {};
    int index = 1;
    bodyAssurance.forEach((assurance) {
      Assurance ass = Assurance.fromJson(assurance);
      listAssurance[ass.id] = ass;
    });

    return listAssurance;

  } else {
    throw Exception('Failed to load ');
  }
}

Future<Map<int, Creneau>> getCreneau() async {

  final response = await http.get(
    Uri.parse(url+'creneau'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyCreneau = json.decode(response.body);
    Map<int, Creneau> listCreneau = {};
    bodyCreneau.forEach((creneau) {
      Creneau c = Creneau.fromJson(creneau);
      listCreneau[c.id] = c;
    });

    return listCreneau;

  } else {
    throw Exception('Failed to load ');
  }
}



Future<Map<int, Hopital>> getHopital() async {

  final response = await http.get(
    Uri.parse(url+'hopital'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyHopital = json.decode(response.body);
    Map<int, Hopital> listHopital = {};
    bodyHopital.forEach((hopital) {
      Hopital h = Hopital.fromJson(hopital);
      listHopital[h.id] = h;
    });

    return listHopital;

  } else {
    throw Exception('Failed to load ');
  }
}

Future<Map<int, Medecin>> getMedecin() async {

  final response = await http.get(
    Uri.parse(url+'medecin'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyMedecin = json.decode(response.body);
    Map<int, Medecin> listMedecin = {};
    bodyMedecin.forEach((medecin) {
      Medecin m = Medecin.fromJson(medecin);
      listMedecin[m.id] = m;
    });

    return listMedecin;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<List<Motif>> getMotif() async {

  final response = await http.get(
    Uri.parse(url+'motif'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyMotif = json.decode(response.body);
    List<Motif> listMotif = [];
    bodyMotif.forEach((motif) {
      listMotif.add(Motif.fromJson(motif));
    });

    return listMotif;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<List<MotifConsultation>> getMotifConsultation() async {

  final response = await http.get(
    Uri.parse(url+'/motif_consultation'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyMotifConsultation = json.decode(response.body);
    List<MotifConsultation> listMotifConsultation = [];
    bodyMotifConsultation.forEach((motifConsultation) {
      listMotifConsultation.add(MotifConsultation.fromJson(motifConsultation));
    });

    return listMotifConsultation;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<Map<int, Patient>> getPatient() async {

  final response = await http.get(
    Uri.parse(url+'patient'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyPatient = json.decode(response.body);
    Map<int, Patient> listPatient = {};
    bodyPatient.forEach((patient) {
      Patient p = Patient.fromJson(patient);
      listPatient[p.id] = p;
    });

    return listPatient;

  } else {
    throw Exception('Failed to load ');
  }
}

Future<Map<int, Proche>> getProche() async {

  final response = await http.get(
    Uri.parse(url+'proche'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyProche = json.decode(response.body);
    Map<int, Proche> listProchet = {};
    bodyProche.forEach((proche) {
      Proche p = Proche.fromJson(proche);
      listProchet[p.id] = p;
    });

    return listProchet;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<Map<int, Rdv>> getRdv() async {

  final response = await http.get(
    Uri.parse(url+'rdv'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodyRdv = json.decode(response.body);
    Map<int, Rdv> listRdv = {};
    bodyRdv.forEach((rdv) {
      Rdv r = Rdv.fromJson(rdv);
      listRdv[r.id] = r;
    });

    return listRdv;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<Map<int, Specialite>> getSpecialite() async {

  final response = await http.get(
    Uri.parse(url+'specialite'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodySpecialite = json.decode(response.body);
    Map<int, Specialite> listSpecialite = {};
    bodySpecialite.forEach((rdv) {
      Specialite spe = Specialite.fromJson(rdv);
      listSpecialite[spe.id] = spe;
    });

    return listSpecialite;

  } else {
    throw Exception('Failed to load ');
  }
}


Future<Map<int, SpecialitesHopital>> getSpecialiteHopital() async {

  final response = await http.get(
    Uri.parse(url+'specialite_hopital'),
    //headers: {"APP_KEY": header}
  );

  if (response.statusCode == 200) {
    var bodySpecialiteHopital = json.decode(response.body);
    Map<int, SpecialitesHopital> listSpecialiteHopital = {};
    int index = 1;
    bodySpecialiteHopital.forEach((rdv) {
      SpecialitesHopital speH = SpecialitesHopital.fromJson(rdv);
      listSpecialiteHopital[speH.id] = speH;
    });

    return listSpecialiteHopital;

  } else {
    throw Exception('Failed to load ');
  }
}


Future logPatient(String email, String pwd) async {

  final response = await http.get(
    Uri.parse(url+"connexion/patient/${email}/${pwd}"),
    //headers: {"APP_KEY": header}
  );

  return response;
}

Future logMedecin(String email, String pwd) async {

  final response = await http.get(
    Uri.parse(url+"connexion/medecin/${email}/${pwd}"),
    //headers: {"APP_KEY": header}
  );

  return response;
}


Future creerCreneau(Creneau creneau) async {

  final response = await http.post(
    Uri.parse(url+"creneau?jour=${creneau.jour}&heure=${creneau.heure}&etat=0&id_motif_consult=${creneau.id_motif_consult}&id_medecin=${creneau.id_medecin}"),
  );

  return response;
}

Future supprimerCreneau(Creneau creneau) async {

  final response = await http.delete(
    Uri.parse(url+"creneau/${creneau.id}"),
  );

  return response;
}

Future supprimerRdv(Rdv rdv) async {

  final response = await http.delete(
    Uri.parse(url+"rdv/${rdv.id}"),
  );

  return response;
}

Future supprimerProche(Proche proche) async {

  final response = await http.delete(
    Uri.parse(url+"proche/${proche.id}"),
  );

  return response;
}

Future creerRdv(Rdv rdv) async {

  final response = await http.post(
    Uri.parse(url+"rdv?etat=0&id_creneau=${rdv.id_creneau}&id_proche=${rdv.id_proche}"),
  );

  return response;
}

Future creerProche(Proche proche) async {

  final response = await http.post(
    Uri.parse(url+"proche?nom=${proche.nom}&prenom=${proche.prenom}&telephone=${proche.telephone}&date_naissance=${proche.date_naissance}&sexe=${proche.sexe}&id_patient=${proche.id_patient}"),
  );

  return response;
}

Future updateProche(Proche proche) async {

  final response = await http.put(
    Uri.parse(url+"proche/${proche.id}?nom=${proche.nom}&prenom=${proche.prenom}&telephone=${proche.telephone}&date_naissance=${proche.date_naissance}&sexe=${proche.sexe}&id_patient=${proche.id_patient}"),
  );

  return response;
}


Future updatePasswordPatient(String ancien, String nouveau, Patient patient) async {

  final response = await http.put(
    Uri.parse(url+"password/patient/${ancien}/${nouveau}/${patient.id}"),
  );

  return response;
}

Future updatePasswordMedecin(String ancien, String nouveau, Medecin medecin) async {

  final response = await http.put(
    Uri.parse(url+"password/medecin/${ancien}/${nouveau}/${medecin.id}"),
  );

  return response;
}



Future updateTelephonePatient(String telephone, Patient patient) async {

  final response = await http.put(
    Uri.parse(url+"telephone/patient/${telephone}/${patient.id}"),
  );

  return response;
}

Future updateTelephoneMedecin(String telephone, Medecin medecin) async {

  final response = await http.put(
    Uri.parse(url+"telephone/medecin/${telephone}/${medecin.id}"),
  );

  return response;
}


Future updateEmailPatient(String email, Patient patient) async {

  final response = await http.put(
    Uri.parse(url+"email/patient/${email}/${patient.id}"),
  );

  return response;
}

Future updateEmailMedecin(String email, Medecin medecin) async {

  final response = await http.put(
    Uri.parse(url+"email/medecin/${email}/${medecin.id}"),
  );

  return response;
}