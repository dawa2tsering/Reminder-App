// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.categoryName,
  });

  int? id;
  String? categoryName;

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["id"], categoryName: json["category_name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
      };
}
