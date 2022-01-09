import 'dart:convert';

Proche ProcheFromJson(String str) => Proche.fromJson(json.decode(str));
String ProcheToJson(Proche data) => json.encode(data.toJson());

class Proche
{
  int id;
  String slug;
  String nom;
  String prenom;
  String date_naissance;
  String telephone;
  String sexe;
  int id_patient;

  Proche({required this.id, required this.slug, required this.nom, required this.prenom,
    required this.telephone, required this.sexe,required this.date_naissance,
    required this.id_patient});


  factory Proche.fromJson(Map<String, dynamic> json) => Proche(
      id: json["id"],
      slug: json["slug"],
      nom: json["nom"],
      prenom: json["prenom"],
      telephone: json["telephone"],
      sexe: json["sexe"],
      date_naissance: json["date_naissance"],
      id_patient: json["id_patient"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "nom": nom,
    "prenom": prenom,
    "telephone": telephone,
    "sexe": sexe,
    "date_naissance": date_naissance,
    "id_patient": id_patient,
  };
}
