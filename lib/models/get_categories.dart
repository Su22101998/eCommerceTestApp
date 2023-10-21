class Categories {
    int id;
    String name;
    String image;
    DateTime creationAt;
    DateTime updatedAt;

    Categories({
        required this.id,
        required this.name,
        required this.image,
        required this.creationAt,
        required this.updatedAt,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["_id"]??0,
        name: json["name"]??"",
        image: json["image"]??"",
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"])
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "creationAt":creationAt,
        "updatedAt": updatedAt,
    };

}