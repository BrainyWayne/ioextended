import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ioextended/components/button.dart';
import 'package:ioextended/components/input_item.dart';
import 'package:ioextended/usermodel.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = '',
      email = '',
      password = '',
      confirmPassword = '',
      signupType = 'Select Signup Type',
      contact = '';
  UserCredential? credential;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 200),
              InputField(
                suffixIcon: Icon(Icons.account_circle),
                name: "Name",
                onChanged: ((value) {
                  name = value;
                }),
              ),
              SizedBox(height: 20),
              InputField(
                suffixIcon: Icon(Icons.email),
                name: "Email address",
                onChanged: ((value) {
                  email = value;
                }),
              ),
              SizedBox(height: 20),
              InputField(
                suffixIcon: Icon(Icons.phone),
                name: "Phone Number",
                onChanged: ((value) {
                  contact = value;
                }),
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    signupType,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InputField(
                suffixIcon: Icon(Icons.lock),
                name: "Password",
                obscureText: true,
                maxLines: 1,
                onChanged: ((value) {
                  password = value;
                }),
              ),
              SizedBox(height: 20),
              InputField(
                suffixIcon: Icon(Icons.lock),
                name: "Confirm Password",
                obscureText: true,
                maxLines: 1,
                onChanged: ((value) {
                  confirmPassword = value;
                }),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        if (name.length == 0 ||
                            email.length == 0 ||
                            password != confirmPassword ||
                            signupType == "Select Signup Type") {
                        } else {
                          signUp();
                        }
                      },
                      child: CustomButton(text: "SIGN UP"),
                    ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(),
                  ),
                  Text(
                    " Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    isLoading = true;
    setState(() {});
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential != null) {
        Map<String, dynamic> data = <String, dynamic>{
          "name": name,
          "email": email,
          "contact": contact,
          "signupType": signupType
        };
        await usersCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(data)
            .whenComplete(() async {
          await getData();

         
        }).catchError((e) => print(e));
      }
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {}
  }

  Future<dynamic> getData() async {
    var data;
    final DocumentReference document =
        usersCollection.doc(FirebaseAuth.instance.currentUser!.uid);
    try {
      await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
        setState(() {
          data = snapshot.data();
        });
        currentUser = UserModel(
            name: data['name'],
            email: data['email'],
            contact: data['contact'],
            signUpType: data["signupType"]);

        log(currentUser.toString());
      });
    } catch (e) {
      log(e.toString());
    }

    return data;
  }
}
