// To parse this JSON data, do
//
//     final exerciseDetailsModel = exerciseDetailsModelFromJson(jsonString);

import 'dart:convert';

ExerciseDetailsModel exerciseDetailsModelFromJson(String str) => ExerciseDetailsModel.fromJson(json.decode(str));

String exerciseDetailsModelToJson(ExerciseDetailsModel data) => json.encode(data.toJson());

class ExerciseDetailsModel {
  String? bodyPart;
  String? equipment;
  String? gifUrl;
  String? id;
  String? name;
  String? target;

  ExerciseDetailsModel({
    this.bodyPart,
    this.equipment,
    this.gifUrl,
    this.id,
    this.name,
    this.target,
  });

  factory ExerciseDetailsModel.fromJson(Map<String, dynamic> json) => ExerciseDetailsModel(
    bodyPart: json["bodyPart"],
    equipment: json["equipment"],
    gifUrl: json["gifUrl"],
    id: json["id"],
    name: json["name"],
    target: json["target"],
  );

  Map<String, dynamic> toJson() => {
    "bodyPart": bodyPart,
    "equipment": equipment,
    "gifUrl": gifUrl,
    "id": id,
    "name": name,
    "target": target,
  };
}
