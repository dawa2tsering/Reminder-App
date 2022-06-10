// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Reminder categoryFromJson(String str) => Reminder.fromJson(json.decode(str));

String categoryToJson(Reminder data) => json.encode(data.toJson());

class Reminder {
  Reminder({
    this.id,
    this.memo,
    this.time,
    this.place,
    this.status,
    this.category,
  });

  int? id;
  String? memo;
  String? time;
  String? place;
  String? status;
  int? category;

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
      id: json["id"],
      memo: json["memo"],
      time: json["time"],
      place: json["place"],
      status: json["status"],
      category: json["category"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "memo": memo,
        "time": time,
        "place": place,
        "status": status,
        "category": category,
      };
}
