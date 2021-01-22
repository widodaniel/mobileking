import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_01/register_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserCredential userCredential;
  GlobalKey<FormState> _formkey;
  bool _hidepass;
  String _email;
  String _senha;




  @override
  void initState() {
    initFirebase();

    _hidepass = true;
    _email = "";
    _senha = "";
    _formkey = GlobalKey<FormState>();
  }

  initFirebase()async{
    await Firebase.initializeApp();
  }

  void onClick() async {

    if (_formkey.currentState.validate()) {
      try {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password: _senha,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      debugPrint("Sucesso");
    } else
      debugPrint("Falha!!");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.only(
              left: 28,
              right: 28,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/crowns.png",
                      height: 100,
                    ),
                    Text(
                      "King Cameras",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      onChanged: (String email) {
                        _email = email;
                        _formkey.currentState.validate();
                      },
                      validator: (String email) {
                        if (GetUtils.isEmail(email)) {
                          return null;
                        } else {
                          return "Email inválido";
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      onChanged: (String senha) {
                        _senha = senha;
                        _formkey.currentState.validate();
                      },
                      obscureText: _hidepass,
                      validator: (String senha) {
                        if (senha.trim().isEmpty) {
                          return "Campo Obrigatório";
                        } else if (senha.trim().length < 6) {
                          return "Senha pequena demais";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              _hidepass = !_hidepass;
                            });
                          },
                          child: _hidepass
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Senha",
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: Get.width,
                      child: RaisedButton(
                        color: Colors.pink,
                        onPressed: onClick,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    Get.to(RegisterScreen());
                  },
                  child: Text(
                    "Cadastre-se",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
