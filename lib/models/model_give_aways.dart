// To parse this JSON data, do
//
//     final modelGiveAways = modelGiveAwaysFromJson(jsonString);

import 'dart:convert';

List<ModelGiveAways> modelGiveAwaysFromJson(String str) =>
    List<ModelGiveAways>.from(
      json.decode(str).map((x) => ModelGiveAways.fromJson(x)),
    );

String modelGiveAwaysToJson(List<ModelGiveAways> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// Detail API returns a single object instead of a list
ModelGiveAways modelGiveAwayDetailFromJson(String str) =>
    ModelGiveAways.fromJson(json.decode(str));

class ModelGiveAways {
  int id;
  String title;
  String worth;
  String thumbnail;
  String image;
  String description;
  String instructions;
  String openGiveawayUrl;
  String publishedDate;
  String type;
  String platforms;
  String endDate;
  int users;
  String status;
  String gamerpowerUrl;
  String openGiveaway;

  ModelGiveAways({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.openGiveawayUrl,
    required this.publishedDate,
    required this.type,
    required this.platforms,
    required this.endDate,
    required this.users,
    required this.status,
    required this.gamerpowerUrl,
    required this.openGiveaway,
  });

  factory ModelGiveAways.fromJson(Map<String, dynamic> json) => ModelGiveAways(
    id: json["id"],
    title: json["title"].toString(),
    worth: json["worth"].toString(),
    thumbnail: json["thumbnail"].toString(),
    image: json["image"].toString(),
    description: json["description"].toString(),
    instructions: json["instructions"].toString(),
    openGiveawayUrl: json["open_giveaway_url"].toString(),
    publishedDate: json["published_date"].toString(),
    type: json["type"].toString(),
    platforms: json["platforms"].toString(),
    endDate: json["end_date"].toString(),
    users: json["users"],
    status: json["status"].toString(),
    gamerpowerUrl: json["gamerpower_url"].toString(),
    openGiveaway: json["open_giveaway"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "worth": worth,
    "thumbnail": thumbnail,
    "image": image,
    "description": description,
    "instructions": instructions,
    "open_giveaway_url": openGiveawayUrl,
    "published_date": publishedDate,
    "type": type,
    "platforms": platforms,
    "end_date": endDate,
    "users": users,
    "status": status,
    "gamerpower_url": gamerpowerUrl,
    "open_giveaway": openGiveaway,
  };
}
