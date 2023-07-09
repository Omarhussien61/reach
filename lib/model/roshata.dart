
import 'dart:convert';

Roshata roshataFromJson(String str) => Roshata.fromJson(json.decode(str));

String roshataToJson(Roshata data) => json.encode(data.toJson());

class Roshata {
  int id;
  dynamic image;
  DateTime created;

  Roshata({
    this.id,
    this.image,
    this.created,
  });

  factory Roshata.fromJson(Map<String, dynamic> json) => Roshata(
    id: json["id"],
    image: json["image"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created": created.toIso8601String(),
  };
}
