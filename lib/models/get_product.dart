
import 'get_categories.dart';

class Product {
    int id;
    String title;
    int price;
    String description;
    List<String> images;
    DateTime creationAt;
    DateTime updatedAt;
    Categories category;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.images,
        required this.creationAt,
        required this.updatedAt,
        required this.category,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"]??0,
        title: json["title"]??"",
        price: json["price"]??0,
        description: json["description"]??"",
        images: json['images'].cast<String>(),
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        category: Categories.fromJson(json['category']), 
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title":title,
        "price":price,
        "description":description,
        "images":images,
        "creationAt":creationAt,
        "updatedAt": updatedAt,
        "category":category.toJson(),
    };

}
