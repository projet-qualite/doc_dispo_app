import 'dart:convert';

Travailler TravaillerFromJson(String str) => Travailler.fromJson(json.decode(str));
String TravaillerToJson(Travailler data) => json.encode(data.toJson());

class Travailler
{
  int id;
  int id_specialite;
  int id_hopital;
  int id_medecin;

  Travailler({required this.id, required this.id_specialite, required this.id_hopital,  required this.id_medecin});


  factory Travailler.fromJson(Map<String, dynamic> json) => Travailler(
      id: json["id"],
      id_specialite: json["id_specialite"],
      id_hopital: json["id_hopital"],
      id_medecin: json["id_medecin"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "id_hopital": id_hopital,
    "id_specialite": id_specialite,
    "id_medecin": id_medecin
  };
}
