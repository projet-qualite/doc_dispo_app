import 'dart:convert';

Rdv RdvFromJson(String str) => Rdv.fromJson(json.decode(str));

String RdvToJson(Rdv data) => json.encode(data.toJson());

class Rdv {
  int id;
  String slug;
  int etat;
  int id_creneau;
  int id_proche;
  String? compte_rendu;

  Rdv(
      {required this.id,
      required this.slug,
      required this.etat,
      required this.id_creneau,
      required this.id_proche,
      required this.compte_rendu});

  factory Rdv.fromJson(Map<String, dynamic> json) => Rdv(
      id: json["id"],
      slug: json["slug"],
      etat: json["etat"],
      id_creneau: json["id_creneau"],
      id_proche: json["id_proche"],
      compte_rendu: json["compte_rendu"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "etat": etat,
        "id_creneau": id_creneau,
        "id_proche": id_proche,
        "compte_rendu": compte_rendu
      };
}
