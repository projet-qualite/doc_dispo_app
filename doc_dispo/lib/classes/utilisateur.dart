import 'dart:convert';

Utilisateur UtilisateurFromJson(String str) => Utilisateur.fromJson(json.decode(str));
String UtilisateurToJson(Utilisateur data) => json.encode(data.toJson());

class Utilisateur
{
  int id;
  String email;
  String? telephone;
  String mot_de_passe;

  Utilisateur({required this.id, required this.email,  this.telephone, required this.mot_de_passe});


  factory Utilisateur.fromJson(Map<String, dynamic> json) => Utilisateur(
    id: json["id"],
    email: json["email"],
    telephone: json["telephone"],
    mot_de_passe: json["mot_de_passe"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "telephone": telephone,
    "mot_de_passe": mot_de_passe,
  };
}
