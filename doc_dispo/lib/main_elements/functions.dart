import 'package:doc_dispo/classes/assurance.dart';
import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/classes/medecin.dart';
import 'package:doc_dispo/classes/motif.dart';
import 'package:doc_dispo/classes/proche.dart';
import 'package:intl/intl.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/data.dart';


List<Map<String, dynamic>> getRdvProche(int id) {
  List<Map<String, dynamic>> list = [];
  list_proche.forEach((key, proche) {
    if (proche.id_patient == id) {
      list_rdv.forEach((key2, rdv) {
        if (rdv.id_proche == proche.id) {
          Creneau? creneau = list_creneau[rdv.id_creneau];
          DateTime date = DateTime.parse(creneau!.jour);
          final difference = date.difference(DateTime.now()).inDays;
          if(difference > 0)
            {
              Medecin? medecin = list_medecin[creneau.id_medecin];
              Specialite? specialite = list_specialite[medecin!.id_specialite!];
              list.add(
                  {
                    "medecin": list_medecin[creneau!.id_medecin],
                    "creneau": creneau,
                    "specialite": specialite,
                    "rdv": rdv
                  }
              );
            }

        }
      });
    }
  });

  return list;
}

List<Map<String, dynamic>> getRdvPasseProche(int id) {
  List<Map<String, dynamic>> list = [];
  print(list_proche);
  list_proche.forEach((key, proche) {
    if (proche.id_patient == id) {
      list_rdv.forEach((key2, rdv) {
        if (rdv.id_proche == proche.id) {
          Creneau? creneau = list_creneau[rdv.id_creneau];
          DateTime date = DateTime.parse(creneau!.jour);
          final difference = date.difference(DateTime.now()).inDays;
          if(difference < 0)
          {
            Medecin? medecin = list_medecin[creneau.id_medecin];
            Specialite? specialite = list_specialite[medecin!.id_specialite!];
            list.add(
                {
                  "medecin": list_medecin[creneau!.id_medecin],
                  "creneau": creneau,
                  "specialite": specialite,
                  "rdv": rdv
                }
            );
          }

        }
      });
    }
  });

  return list;
}



List<Map<String, dynamic>> getRdvMedecins(int id) {
  List<Map<String, dynamic>> list = [];

  list_rdv.forEach((key, rdv) {
    Creneau? creneau = list_creneau[rdv.id_creneau];
    if(creneau!.id_medecin == currentUser.id)
      {
        DateTime date = DateTime.parse(creneau!.jour);
        final difference = date.difference(DateTime.now()).inDays;
        if(difference > 0)
        {
          Proche? proche = list_proche[rdv.id_proche];
          print(proche!.nom);
          Specialite? specialite = list_specialite[currentUser.id_specialite];
          list.add(
              {
                "proche": proche,
                "creneau": creneau,
                "specialite": specialite
              }
          );
        }
      }
  });



  return list;
}

List<Map<String, dynamic>> getRdvPasseMedecins(int id) {
  List<Map<String, dynamic>> list = [];
  list_rdv.forEach((key, rdv) {
    Creneau? creneau = list_creneau[rdv.id_creneau];
    if(creneau!.id_medecin == currentUser.id)
    {
      DateTime date = DateTime.parse(creneau!.jour);
      final difference = date.difference(DateTime.now()).inDays;
      if(difference < 0)
      {
        Proche? proche = list_proche[rdv.id_proche];
        Specialite? specialite = list_specialite[currentUser.id_specialite];
        list.add(
            {
              "proche": proche,
              "creneau": creneau,
              "specialite": specialite
            }
        );
      }
    }
  });

  return list;
}






List<Proche> getProcheOfPatient(int id) {
  List<Proche> list = [];
  list_proche.forEach((key, proche) {
    if (proche.id_patient == id) {
      list.add(proche);
    }
  });

  return list;
}


List<Creneau> getCreneauOfMedecin(int id) {

  List<Creneau> list = [];
  list_creneau.forEach((key, creneau) {
    if (creneau.id_medecin == id && creneau.etat == 1) {

      DateTime date = DateTime.parse(creneau!.jour);
      final difference = date.difference(DateTime.now()).inHours;
      if(difference > 0)
        {
          list.add(creneau);
        }

    }
  });

  return list;
}


Map<String, List<dynamic>> getAllInformationsHopital({required int id}) {
  Map<String, List<dynamic>> list = {};
  List<Medecin?> listMedecin = [];
  List<Specialite?> listSpecialite = [];
  List<Assurance?> listAssurance = [];

  list_medecin.forEach((key, value) {
    if (value.id_hopital == id) {
      listMedecin.add(list_medecin[value.id]);
    }
  });

  list_specialites_hopital.forEach((key, value) {
    if (value.id_hopital == id) {
      listSpecialite.add(list_specialite[value.id_specialite]);
    }
  });

  list_affilier.forEach((element) {
    if (element.id_hopital == id) {
      listAssurance.add(list_assurance[element.id_assurance]);
    }
  });

  list["medecins"] = listMedecin;
  list["specialites"] = listSpecialite;
  list["assurances"] = listAssurance;

  return list;
}


List<Hopital> getAllInformationsAssurance({required int id}) {
  List<Hopital> listHopitaux = [];


  list_affilier.forEach((element) {
    if (element.id_assurance == id) {
      listHopitaux.add(list_hopital[element.id_hopital] ?? Hopital(id: -1,
          slug: "",
          email: "",
          libelle: "",
          etat_compte: 0,
          img: ""));
    }
  });

  return listHopitaux;
}

List<Map<String, dynamic>> getMotifOfMedecin({required int id}) {
  List<Map<String, dynamic>> list = [];

  motifs_consultation.forEach((key, value) {
    if(value.id_medecin == id)
      {
        list.add(
          {
            "motif": motifs[value.id_motif],
            "id_motif_medecin": value.id,
            "id_motif_consult": key
          }

        );
      }
  });

  return list;
}


Specialite? getSpecialiteMedecin({required int id}) {
  Medecin? medecin = list_medecin[id];


  return list_specialite[medecin!.id_specialite];
}


bool getMedecinOfSpecialite({required List<Specialite> list, required int id}) {
    bool medecinHasSpecialite = false;
    Medecin? medecin = list_medecin[id];
    list.forEach((element) {
      if (element.id == medecin!.id_specialite) {
        medecinHasSpecialite = true;
      }
    });


    return medecinHasSpecialite;
}


bool getHopitalOfAssurance({required List<Assurance> list, required int id}) {
  bool hopitalHasAssurance = false;
  Hopital? hopital = list_hopital[id];
  list_affilier.forEach((value) {
    list.forEach((element) {
      if (element.id == value.id_assurance && value.id_hopital == id) {
        hopitalHasAssurance = true;
      }
    });
  });
  /*print(hopital!.libelle!);
  print(hopitalHasAssurance);*/
  return hopitalHasAssurance;
}


Map<String, List<Creneau>> getAllCreneauOfMedecin({required Medecin medecin, required int id_motif_consultation}) {
  Map<String, List<Creneau>>  creneaux = {};

  list_creneau.forEach((key, creneau) {
    if(creneau.id_medecin == medecin.id && creneau.etat == 0 && (creneau.id_motif_consult == 0 || creneau.id_motif_consult == id_motif_consultation))
      {
        print("YOO");
        if(creneaux[creneau.jour] != null)
          {
            creneaux[creneau.jour]!.add(creneau);
          }
        else{
          creneaux[creneau.jour] = [];
          creneaux[creneau.jour]!.add(creneau);
        }
      }
  });

  creneaux = trierHeureParOrdreCroissant(creneaux: creneaux);

  return creneaux;
}


Map<String, List<Creneau>> trierHeureParOrdreCroissant({required Map<String, List<Creneau>> creneaux}) {

  creneaux.forEach((key, value) {
    creneaux[key]!.sort((Creneau a, Creneau b)=>double.parse(a.heure).compareTo(double.parse(b.heure)));
  });


  return creneaux;
}


String showDate(String dateFormate)
{
  print(dateFormate);
  String jour = dateFormate.split(" ")[0];
  String mois = dateFormate.split(" ")[1];
  String annee = dateFormate.split(" ")[2];

  return jour.substring(0, 1).toUpperCase() + jour.substring(1)+" "+mois+" "+annee;
}

String showHour(String hour)
{
  String heure = hour.split(".")[0];
  String minute = hour.split(".")[1];

  return heure+":"+minute;
}


String hidePassword(String pswd)
{
  String hide = "";
  for(int i = 0 ; i < pswd.length; i++)
    {
      hide+=".";
    }

  return hide;
}

String avatar(String nom, String prenom)
{
  return nom.substring(0, 1).toUpperCase()+prenom.substring(0, 1).toUpperCase();
}

String dateNaissance(String date)
{
  DateTime dateTime = DateTime.parse(date);
  int age = DateTime.now().year - dateTime.year;

  String ageString = (age > 1) ? "("+ age.toString() +" ans)" : "("+ age.toString() +" an)";
  return dateTime.day.toString()+"/"+dateTime.month.toString()+"/"+dateTime.year.toString() + " "+ageString;
}


String dateRdv(String date, String hour)
{
  String dateFormate = DateFormat.yMMMMEEEEd("fr_FR").format(DateTime.parse(date));

  String jourS = dateFormate.split(" ")[0];
  String numeroJour = dateFormate.split(" ")[1];
  String mois = dateFormate.split(" ")[2];

  return jourS.substring(0, 1).toUpperCase() + jourS.substring(1,3)+", "+numeroJour+" "+mois.substring(0, 1).toUpperCase() +
      mois.substring(1,3)+", "+showHour(hour);

}



String formatDate(String date)
{
  String jour = date.split("-")[0];
  String mois = date.split("-")[1];
  String annee = date.split("-")[2];
  return annee+"-"+mois+"-"+jour;
}


String formatDate2(String date)
{
  String jour = date.split("-")[0];
  String mois = date.split("-")[1];
  String annee = date.split("-")[2];
  return jour+"-"+mois+"-"+annee;
}










