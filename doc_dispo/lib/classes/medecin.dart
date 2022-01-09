import 'dart:convert';

Medecin MedecinFromJson(String str) => Medecin.fromJson(json.decode(str));
String MedecinToJson(Medecin data) => json.encode(data.toJson());

class Medecin
{
  int id;
  String? slug;
  String? nom;
  String? prenom;
  String? date_naissance;
  String? sexe;
  String email;
  String mdp;
  String? telephone;
  String? type;
  String? ville;
  String? biographie;
  String? img_1;
  String? img_2;
  String? img_3;
  int etat_compte;
  int? id_hopital;
  int? id_specialite;

  Medecin({required this.id,  this.slug,  this.nom,  this.prenom, this.date_naissance, this.sexe,required this.email,required this.mdp,
    this.telephone,  this.type, this.ville,this.biographie, this.img_1,  this.img_2, this.img_3,this.etat_compte=0,
     this.id_hopital,  this.id_specialite});


  factory Medecin.fromJson(Map<String, dynamic> json) => Medecin(
      id: json["id"],
      slug: json["slug"],
      nom: json["nom"],
      prenom: json["prenom"],
      email: json["email"],
      telephone: json["telephone"],
      mdp: json["mdp"],
      sexe: json["sexe"],
      biographie: json["biographie"],
      etat_compte: json["etat_compte"],
      type: json["type"],
      img_1: json["img_1"],
      img_2: json["img_2"],
      img_3: json["img_3"],
      id_hopital: json["id_hopital"],
      id_specialite: json["id_specialite"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "nom": nom,
    "prenom": prenom,
    "email": email,
    "telephone": telephone,
    "mdp": mdp,
    "sexe": sexe,
    "biographie": biographie,
    "etat_compte": etat_compte,
    "type": type,
    "img_1": img_1,
    "img_2": img_2,
    "img_3": img_3,
    "id_hopital": id_hopital,
    "id_specialite": id_specialite
  };
}
