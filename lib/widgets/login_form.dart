import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signup_ui_starter/screens/tabControll.dart';
import 'package:login_signup_ui_starter/theme.dart';
import 'package:login_signup_ui_starter/widgets/primary_button.dart';


class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {

  TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String errMessage ;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
  child: Column(
    children: [
      
        buildInputFormEmail('Email', false),
        buildInputFormPassword('Password', true),
          SizedBox(
                height: 20,
              ),
              GestureDetector(
                   onTap: (){
                                             signIn(_email.text, _password.text);

                      //  Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //     builder: (context) => AllTabControll()));
                   },
                   child: PrimaryButton(buttonText: 'Đăng nhập',),
                 ),
    ],
  ),
    );
  }

  Padding buildInputFormEmail(String label, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _email,
        validator: (value) {
                          if (value.isEmpty) {
                            return ('Nhập email');
                          }
                          if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]')
                              .hasMatch(value)) {
                            return ('Nhập email đúng định dạng');
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email.text = value;
                        },
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }
    Padding buildInputFormPassword(String label, bool pass) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _password,
        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value.isEmpty) {
                            return ('Nhập password');
                          }
                          if (!regex.hasMatch(value)) {
                            return ('Nhập password ít nhất 6 kí tự');
                          }
                        },
                        onSaved: (value) {
                          _password.text = value;
                        },
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }void signIn(String email, String password) async {
    if (_formKey.currentState.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Đăng nhập thành công"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AllTabControll())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "email không hợp lệ":
            errMessage = "Email không đúng định dạng.";

            break;
          /*
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          */
          default:
            errMessage = "Sai thông tin đăng nhập!";
        }
        Fluttertoast.showToast(msg: errMessage);
        print(error.code);
      }
    }
  }
}
