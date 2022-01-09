import 'dart:convert';

Creneau CreneauFromJson(String str) => Creneau.fromJson(json.decode(str));
String CreneauToJson(Creneau data) => json.encode(data.toJson());

class Creneau
{
  int id;
  String slug;
  String jour;
  String heure;
  int etat;
  int id_motif_consult;
  int id_medecin;

  Creneau({required this.id, required this.slug,required this.jour, required this.heure, required this.etat,
   required this.id_motif_consult, required this.id_medecin});


  factory Creneau.fromJson(Map<String, dynamic> json) => Creneau(
      id: json["id"],
      slug: json["slug"],
      jour: json["jour"],
      heure: json["heure"],
      etat: json["etat"],
      id_motif_consult: json["id_motif_consult"],
      id_medecin: json["id_medecin"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "jour": jour,
    "heure": heure,
    "etat": etat,
    "id_motif_consult": id_motif_consult,
    "id_medecin": id_medecin,
  };
}
