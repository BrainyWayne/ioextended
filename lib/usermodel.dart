import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference usersCollection = _firestore.collection('records');

class UserModel {
  String name;
  String email;
  String contact;
  String signUpType;
  UserModel({
    required this.name,
    required this.email,
    required this.contact,
    required this.signUpType,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? contact,
    String? signUpType,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      signUpType: signUpType ?? this.signUpType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'contact': contact,
      'signUpType': signUpType,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      contact: map['contact'],
      signUpType: map['signUpType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, contact: $contact, signUpType: $signUpType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.contact == contact &&
        other.signUpType == signUpType;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        contact.hashCode ^
        signUpType.hashCode;
  }
}
