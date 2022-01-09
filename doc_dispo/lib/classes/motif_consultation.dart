import 'dart:convert';

MotifConsultation MotifFromJson(String str) => MotifConsultation.fromJson(json.decode(str));
String MotifToJson(MotifConsultation data) => json.encode(data.toJson());

class MotifConsultation
{
  int id;
  int id_motif;
  int id_medecin;

  MotifConsultation({required this.id, required this.id_motif, required this.id_medecin});


  factory MotifConsultation.fromJson(Map<String, dynamic> json) => MotifConsultation(
      id: json["id"],
      id_motif: json["id_motif"],
      id_medecin: json["id_medecin"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "id_motif": id_motif,
    "id_medecin": id_medecin
  };
}
