import 'dart:convert';

Patient ProcheFromJson(String str) => Patient.fromJson(json.decode(str));
String ProcheToJson(Patient data) => json.encode(data.toJson());

class Patient
{
  int id;
  String slug;
  String email;
  String mdp;
  String? telephone;

  Patient({required this.id, required this.slug, required this.email, required this.mdp, this.telephone});


  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
      id: json["id"],
      slug: json["slug"],
      email: json["email"],
      mdp: json["mdp"],
      telephone: json["telephone"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "email": email,
    "mdp": mdp,
    "telephone": telephone,
  };
}
