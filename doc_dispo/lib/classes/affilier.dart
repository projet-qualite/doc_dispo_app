import 'dart:convert';

Affilier AffilierFromJson(String str) => Affilier.fromJson(json.decode(str));
String AffilierToJson(Affilier data) => json.encode(data.toJson());

class Affilier
{
  int id;
  int id_hopital;
  int id_assurance;

  Affilier({required this.id, required this.id_hopital, required this.id_assurance});


  factory Affilier.fromJson(Map<String, dynamic> json) => Affilier(
      id: json["id"],
      id_hopital: json["id_hopital"],
      id_assurance: json["id_assurance"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "id_hopital": id_hopital,
    "id_assurance": id_assurance
  };
}
