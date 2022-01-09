import 'dart:convert';

SpecialitesHopital SpecialitesHopitalFromJson(String str) => SpecialitesHopital.fromJson(json.decode(str));
String SpecialitesHopitalToJson(SpecialitesHopital data) => json.encode(data.toJson());

class SpecialitesHopital
{
  int id;
  int id_specialite;
  int id_hopital;

  SpecialitesHopital({required this.id, required this.id_specialite, required this.id_hopital});


  factory SpecialitesHopital.fromJson(Map<String, dynamic> json) => SpecialitesHopital(
      id: json["id"],
      id_specialite: json["id_specialite"],
      id_hopital: json["id_hopital"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "id_hopital": id_hopital,
    "id_specialite": id_specialite
  };
}
