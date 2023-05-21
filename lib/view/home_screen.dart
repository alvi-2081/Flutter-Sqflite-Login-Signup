import 'package:flutter/material.dart';
import 'package:sqflite_app/utils/alert_dialog.dart';
import 'package:sqflite_app/resources/expanded_button.dart';
import 'package:sqflite_app/utils/global.dart';
import 'package:sqflite_app/resources/textfield_widget.dart';
import 'package:sqflite_app/database/db_helper.dart';
import 'package:sqflite_app/model/user_model.dart';
import 'package:sqflite_app/view/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  DbHelper? dbHelper;

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    setState(() {
      _userName.text = userData!.userName.toString();
      _email.text = userData!.email.toString();
      _password.text = userData!.password.toString();
    });
  }

  update() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user = UserModel(
          userData!.userId, _userName.text, _email.text, _password.text);
      await dbHelper!.updateUser(user).then((value) {
        if (value == 1) {
          alertDialog(context, "Successfully Updated");

          updateUserData(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error Update");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error");
      });
    }
  }

  delete() async {
    await dbHelper!.deleteUser(userData!.userId!).then((value) {
      if (value == 1) {
        alertDialog(context, "Successfully Deleted");

        updateUserData(null, false).whenComplete(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (Route<dynamic> route) => false);
        });
      }
    });
  }

  Future updateUserData(UserModel? user, bool add) async {
    if (add) {
      userData = user;
    } else {
      userData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),
                  TextFieldWidget(
                      controller: _userName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  SizedBox(height: 10.0),
                  TextFieldWidget(
                      controller: _email,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  TextFieldWidget(
                    controller: _password,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  ExpandedButton(title: "Update", onPress: update),

                  //Delete
                  TextFieldWidget(
                      controller: _userName,
                      isEnable: false,
                      icon: Icons.person,
                      hintName: 'User Name'),
                  SizedBox(height: 10.0),
                  ExpandedButton(title: "Delete", onPress: delete),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
