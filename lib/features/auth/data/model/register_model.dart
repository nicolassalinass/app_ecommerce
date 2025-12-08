class RegisterModel {
    String name;
    String email;
    String? password;

    RegisterModel({
        required this.name,
        required this.email,
        this.password,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
    };
}
