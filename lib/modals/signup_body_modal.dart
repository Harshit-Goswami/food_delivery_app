class SignUpBody {
  String name;
  String email;
  String phone;
  String password;

  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;

    return data;
  }
}
