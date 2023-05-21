import 'package:flutter/material.dart';
import 'package:sqflite_app/utils/alert_dialog.dart';
import 'package:sqflite_app/resources/expanded_button.dart';
import 'package:sqflite_app/resources/header.dart';
import 'package:sqflite_app/utils/global.dart';
import 'package:sqflite_app/resources/textfield_widget.dart';
import 'package:sqflite_app/utils/validator.dart';
import 'package:sqflite_app/database/db_helper.dart';
import 'package:sqflite_app/model/user_model.dart';
import 'package:sqflite_app/view/signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();

  final _userName = TextEditingController();
  final _password = TextEditingController();
  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await dbHelper
          .getLoginUser(_userName.text, _password.text)
          .then((userData) {
        if (userData != null) {
          setUserData(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setUserData(UserModel user) async {
    userData = UserModel(user.userId, user.userName, user.email, user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login with Signup',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Header('Login'),
                TextFieldWidget(
                  controller: _userName,
                  icon: Icons.person,
                  hintName: 'User Name',
                  validator: (value) => requiredValidator(value),
                ),
                TextFieldWidget(
                  controller: _password,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                  validator: (value) => passwordValidator(value),
                ),
                ExpandedButton(title: "Login", onPress: login),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Does not have account? '),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen()));
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
