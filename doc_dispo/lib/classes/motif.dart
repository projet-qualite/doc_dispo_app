import 'dart:convert';

Motif MotifFromJson(String str) => Motif.fromJson(json.decode(str));
String MotifToJson(Motif data) => json.encode(data.toJson());

class Motif
{
  int id;
  String slug;
  String libelle;

  Motif({required this.id, required this.slug, required this.libelle});


  factory Motif.fromJson(Map<String, dynamic> json) => Motif(
      id: json["id"],
      slug: json["slug"],
      libelle: json["libelle"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "libelle": libelle
  };

  String toString()
  {
    return libelle;
  }
}
