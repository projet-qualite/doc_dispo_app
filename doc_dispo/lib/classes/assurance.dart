import 'dart:convert';

Assurance AssuranceFromJson(String str) => Assurance.fromJson(json.decode(str));
String AssuranceToJson(Assurance data) => json.encode(data.toJson());

class Assurance
{
  int id;
  String slug;
  String libelle;
  String logo;
  bool? selected = false;

  Assurance({required this.id, required this.slug, required this.libelle, required this.logo, this.selected = false});


  factory Assurance.fromJson(Map<String, dynamic> json) => Assurance(
      id: json["id"],
      slug: json["slug"],
      libelle: json["libelle"],
      logo: json["logo"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "libelle": libelle,
    "logo": logo,
  };
}
