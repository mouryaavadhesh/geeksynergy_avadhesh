class SqlUser {
  int? id;
  String? companyName;
  String? email;
  String? phone;
  String? address;
  String? password;

  SqlUser(
      {this.id,
      this.companyName,
      this.email,
      this.phone,
      this.address,
      this.password});

  factory SqlUser.fromMap(Map<String, dynamic> data) => SqlUser(
      id: data['id'],
      companyName: data['company_name'],
      email: data['email'],
      phone: data['phone_number'],
      address: data['address'],
      password: data['password']);

  Map<String, dynamic> toMap() => {
        'id': id ?? 0,
        'company_name': companyName ?? '',
        'email': email ?? '',
        'phone_number': phone ?? '',
        'address': address ?? '',
        'password': password ?? '',
      };

  @override
  String toString() {
    return '$companyName: $email: $phone';
  }
}
