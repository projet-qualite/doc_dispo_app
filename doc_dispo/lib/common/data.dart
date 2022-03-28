//PageView textes

// PageView 1
import 'dart:collection';

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


String img_url_1 = "images/icon-home-1.png";
String title_1 = "Trouvez un praticien";
String texte_1 = "Sur la plateforme cherchez un praticien selon vos besoins, l’assurance ainsi que l’hôpital";


// PageView 2
String img_url_2 = "images/icon-home-2.png";
String title_2 = "Prenez un Rdv";
String texte_2 = "Sélectionnet et valider le rendez-vous qui vous convient.";


// PageView 3
String img_url_3 = "images/icon-home-3.png";
String title_3 = "Rappel";
String texte_3 = "Recevez des rappels automatiques par SMS ou par email.";



var urlSite = 'https://doc-et-moi.com/';


// Données fictives




List<Affilier> list_affilier = [

];


Map<int, Assurance> list_assurance = {

};

Map<int, Creneau> list_creneau = {

};


Map<int, Creneau> list_all_creneau = {

};


Map<int, Hopital> list_hopital = {
};





Map<int, Proche> list_proche = {
};

Map<int, Rdv> list_rdv_passe = {

};


Map<int, Rdv> list_rdv_futur = {

};


Map<int, Specialite> list_specialite = {

};

Map<int, Motif> motifs = {

};

Map<int, MotifConsultation> motifs_consultation = {

};

Map<int, SpecialitesHopital> list_specialites_hopital = {

};





Map<int, Patient> list_patient = {

};

Map<int, Medecin> list_medecin = {

};



//dynamic currentUser = list_patient[1];
dynamic currentUser;
int selectedIndex = 0;



