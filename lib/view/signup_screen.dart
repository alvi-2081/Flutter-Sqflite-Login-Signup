import 'package:flutter/material.dart';
import 'package:sqflite_app/utils/alert_dialog.dart';
import 'package:sqflite_app/resources/expanded_button.dart';
import 'package:sqflite_app/resources/header.dart';
import 'package:sqflite_app/resources/textfield_widget.dart';
import 'package:sqflite_app/database/db_helper.dart';
import 'package:sqflite_app/model/user_model.dart';
import 'package:sqflite_app/utils/validator.dart';
import 'package:sqflite_app/view/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel uModel = UserModel(
          DateTime.now().microsecondsSinceEpoch.toString(),
          _userName.text,
          _email.text,
          _password.text);
      await dbHelper.saveData(uModel).then((userData) {
        alertDialog(context, "Successfully Saved");

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Data Save Fail");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Header('Signup'),
                TextFieldWidget(
                  controller: _userName,
                  icon: Icons.person_outline,
                  inputType: TextInputType.name,
                  hintName: 'User Name',
                  validator: (value) => requiredValidator(value),
                ),
                TextFieldWidget(
                  controller: _email,
                  icon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  hintName: 'Email',
                  validator: (value) => emailValidator(value),
                ),
                TextFieldWidget(
                  controller: _password,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                  validator: (value) => passwordValidator(value),
                ),
                ExpandedButton(title: "Signup", onPress: signUp),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Does you have account? '),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Sign In',
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
