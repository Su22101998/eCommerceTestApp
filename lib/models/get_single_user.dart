class SingleUser {
    int id;
    String email;
    String password;
    String name;
    String role;
    String avatar;
    DateTime creationAt;
    DateTime updatedAt;

    SingleUser({
        required this.id,
        required this.email,
        required this.password,
        required this.name,
        required this.role,
        required this.avatar,
        required this.creationAt,
        required this.updatedAt,
    });

    factory SingleUser.fromJson(Map<String, dynamic> json) => SingleUser(
        id: json["_id"]??0,
        email: json["email"]??"",
        password: json["password"]??"",
        name: json["name"]??"",
        role: json["role"]??"",
        avatar: json["avatar"]??"",
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"])
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
        "creationAt":creationAt,
        "updatedAt": updatedAt,
    };

}