class UserModel {
  String? firstName;
  late String? lastName;
  late String? email;
  late String? password;

  String get getFirstName {
    return firstName!;
  }

  set setFirstName(String setterFirstname) {
    firstName = setterFirstname;
  }

  String get getLastName {
    return lastName!;
  }

  set setLastName(String setterLastname) {
    lastName = setterLastname;
  }

  String get getEmail {
    return email!;
  }

  set setEmail(String setterEmail) {
    email = setterEmail;
  }

  String get getPassword {
    return password!;
  }

  set setPassword(String setterPassword) {
    password = setterPassword;
  }
}
