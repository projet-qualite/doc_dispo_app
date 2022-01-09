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





// Données fictives




List<Affilier> list_affilier = [
  Affilier(id: 1, id_hopital: 1, id_assurance: 1),
  Affilier(id: 2, id_hopital: 1, id_assurance: 2),
  Affilier(id: 3, id_hopital: 2, id_assurance: 1),
];


Map<int, Assurance> list_assurance = {
  1: Assurance(id: 1, slug: "alianz", libelle: "Alianz Assurance", logo: "alianz.png"),
  2: Assurance(id: 2, slug: "axa", libelle: "Axa Assurance", logo: "axa.png"),
};

Map<int, Creneau> list_creneau = {
  1: Creneau(id: 1, slug: "2021-12-25", jour: "2021-12-25", heure: "9.30", id_motif_consult: 1, id_medecin: 1, etat: 0),
  2: Creneau(id: 2, slug: "2021-12-25", jour: "2021-12-25", heure: "10.30",  id_motif_consult: 2, id_medecin: 1, etat: 0),
  3: Creneau(id: 3, slug: "2021-12-25", jour: "2021-12-25", heure: "11.30", id_motif_consult: 1, id_medecin: 2, etat: 0),
  4: Creneau(id: 4, slug: "2021-12-25", jour: "2021-12-25", heure: "15.30", id_motif_consult: 1, id_medecin: 2, etat: 0),
  5: Creneau(id: 5, slug: "2021-05-23", jour: "2021-12-26", heure: "08.30", id_motif_consult: 1, id_medecin: 1, etat: 1),
  6: Creneau(id: 6, slug: "2021-12-25", jour: "2021-12-25", heure: "13.30", id_motif_consult: 1, id_medecin: 2, etat: 1)
};


Map<int, Hopital> list_hopital = {
  1: Hopital(id: 1, slug: "pisam", libelle: "Pisam", longitude: "45 rue de la fonderie", latitude: "",email: "hopital@pisam.ci", telephone: "+2250912189",etat_compte: 1, img: "pisam.png"),
  2: Hopital(id: 2, slug: "chu", libelle: "Chu cocody", longitude: "45 rue de la fonderie", latitude: "",email: "hopital@pisam.ci", telephone: "+2250912189",etat_compte: 1, img: "pisam.png"),
};





Map<int, Proche> list_proche = {
  1: Proche(id: 1, slug: "fry", nom: "Ablaha", prenom: "Andréa",  telephone: "+2250912189",sexe: "F", date_naissance: "1995-20-12", id_patient: 1),
  2: Proche(id: 2, slug: "fry", nom: "Ange", prenom: "Morrel", telephone: "+2250912189",sexe: "M", date_naissance: "2004-10-04", id_patient: 1),
  3: Proche(id: 3, slug: "fry", nom: "Ablaha", prenom: "Andréa",telephone: "+2250912189",sexe: "F", date_naissance: "1995-20-12", id_patient: 1),
  4: Proche(id: 4, slug: "fryffffffff", nom: "Angffffffe", prenom: "Morrel", telephone: "+2250912189",sexe: "M", date_naissance: "2004-10-04", id_patient: 1),
};

Map<int, Rdv> list_rdv = {
  1: Rdv(id: 1,slug: "", etat: 0, id_creneau: 5, id_proche: 1, compte_rendu: ""),
  2: Rdv(id: 2,slug: "", etat: 0, id_creneau: 6, id_proche: 2, compte_rendu: ""),
  3: Rdv(id: 3,slug: "", etat: 0, id_creneau: 4, id_proche: 2, compte_rendu: ""),
};


Map<int, Specialite> list_specialite = {
  1: Specialite(id: 1, slug: "", libelle: "Pédiatrie"),
  2: Specialite(id: 2, slug: "", libelle: "Ophtamologie"),
  3: Specialite(id: 3, slug: "", libelle: "Chirurgie"),
  4: Specialite(id: 4, slug: "", libelle: "Dermatologie"),
  5: Specialite(id: 5, slug: "", libelle: "Deontologie"),
  6: Specialite(id: 6, slug: "", libelle: "Généraliste"),
  7: Specialite(id: 7, slug: "", libelle: "Gynécologie"),
};

Map<int, Motif> motifs = {
  1: Motif(id: 1, slug: "consultation", libelle: "Consultation"),
  2: Motif(id: 2, slug: "controle", libelle: "Contrôle"),
  3: Motif(id: 3, slug: "rappel", libelle: "Rappel"),
  4: Motif(id: 4, slug: "vaccin", libelle: "Vaccin"),
};

Map<int, MotifConsultation> motifs_consultation = {
  1: MotifConsultation(id: 1, id_motif: 1, id_medecin: 1),
  2: MotifConsultation(id: 2, id_motif: 2, id_medecin: 1),
  3: MotifConsultation(id: 3, id_motif: 3, id_medecin: 1),
  4: MotifConsultation(id: 4, id_motif: 1, id_medecin: 2),
};

Map<int, SpecialitesHopital> list_specialites_hopital = {
  1: SpecialitesHopital(id: 1, id_specialite: 1, id_hopital: 1),
  2: SpecialitesHopital(id: 2, id_specialite: 1, id_hopital: 2),

  3: SpecialitesHopital(id: 3, id_specialite: 2, id_hopital: 1),
  4: SpecialitesHopital(id: 4, id_specialite: 2, id_hopital: 2),

  5: SpecialitesHopital(id: 5, id_specialite: 3, id_hopital: 1),
  6: SpecialitesHopital(id: 6, id_specialite: 3, id_hopital: 2),

  7: SpecialitesHopital(id: 7, id_specialite: 4, id_hopital: 1),
  8: SpecialitesHopital(id: 8, id_specialite: 4, id_hopital: 2),

  9: SpecialitesHopital(id: 9, id_specialite: 5, id_hopital: 1),
  10: SpecialitesHopital(id: 10, id_specialite: 5, id_hopital: 2),

};





Map<int, Patient> list_patient = {
  1: Patient(id: 1, slug: "marshal@gmail.com", email: "marshal@gmail.com", telephone: "091289812", mdp: "12345678"),
  2: Patient(id: 2,slug: "cedric@gmail.com", email: "cedric@gmail.com", telephone: "091289812", mdp: "12345678"),
};

Map<int, Medecin> list_medecin = {
  1: Medecin(id: 1, slug: "fry", nom: "Fry", prenom: "Adou", email: "fry@medecin.ci", telephone: "+2250912189",mdp: "12345678",type: "Dr.",sexe: "H",biographie: "Lorem ipsum dolor sit amet, consectetur adipiscingelit. Sed non risus. Suspendisse lectus tortor,dignissim sit amet, adipiscing nec, ultricies sed, dolor.Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proinporttitor, orci nec nonummy molestie",
      etat_compte: 1, img_1: "fry.png", img_2: "", img_3: "", id_hopital: 1, id_specialite: 3),
  2: Medecin(id: 2, slug: "kouassi", nom: "Kouassi", prenom: "Grâce", email: "kouassi@medecin.ci", telephone: "+2250912189",mdp: "12345678",type: "Inf.",sexe: "F",biographie: "Je suis un medecin sérieux",
      etat_compte: 1, img_1: "kouassi.png", img_2: "", img_3: "",id_hopital: 1, id_specialite: 1),
};



//dynamic currentUser = list_patient[1];
dynamic currentUser = list_medecin[2];
int selectedIndex = 0;



