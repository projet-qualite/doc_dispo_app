import 'dart:convert';

Hopital HopitalFromJson(String str) => Hopital.fromJson(json.decode(str));
String HopitalToJson(Hopital data) => json.encode(data.toJson());

class Hopital
{
  int id;
  String slug;
  String libelle;
  String? longitude;
  String? latitude;
  String email;
  String? telephone;
  String img;
  int etat_compte;

  Hopital({required this.id, required this.slug, required this.libelle,  this.longitude,
     this.latitude, required this.email,  this.telephone,
    required this.img, required this.etat_compte});




  factory Hopital.fromJson(Map<String, dynamic> json) => Hopital(
      id: json["id"],
      slug: json["slug"],
      libelle: json["libelle"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      email: json["email"],
      telephone: json["telephone"],
      img: json["img"],
      etat_compte: json["etat_compte"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "libelle": libelle,
    "longitude": longitude,
    "latitude": latitude,
    "email": email,
    "telephone": telephone,
    "img": img,
    "etat_compte": etat_compte
  };
}
