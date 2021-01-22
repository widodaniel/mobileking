import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formkey;
  String _email;
  String _senha;
  String _confirmaSenha;

  bool _hidepass;

  @override
  void initState() {
    _formkey = GlobalKey<FormState>();
    _email = "";
    _senha = "";
    _confirmaSenha = "";
    _hidepass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[600],
        ),
        body: Form(
          key: _formkey,
          child: Container(
            margin: EdgeInsets.only(
              left: 28,
              right: 28,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cadastre-se",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 50,
                ),
                TextFormField(
                  onChanged: (String email) {
                    _email = email;
                  },
                  validator: (String texto) {
                    if (GetUtils.isEmail(texto))
                      return null;
                    else
                      return "Email Inválido";
                  },
                  decoration: InputDecoration(
                    hintText: "Insiria seu Email",
                  ),
                ),
                Container(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (String senha) {
                    _senha = senha;
                  },
                  obscureText: _hidepass,
                  validator: (String texto) {
                    if (texto.trim().length < 6)
                      return "No mínimo 6 caracteres!";
                    else
                      return null;
                  },
                  decoration: InputDecoration(hintText: "Insira uma Senha"),
                ),
                Container(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (String confirmaSenha) {
                    _confirmaSenha = confirmaSenha;
                  },
                  obscureText: _hidepass,
                  validator: (String texto) {
                    if (texto.trim().length < 6) {
                      return "No mínimo 6 caracteres!";
                    } else if (texto != _senha) {
                      return "Senha são diferentes";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Insira sua senha novamente",
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
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 45,
                  ),
                  width: Get.width,
                  child: RaisedButton(
                    onPressed: () async{
                      if (_formkey.currentState.validate()) {
                        try {
                          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _email,
                              password: _senha
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                        debugPrint("Sucesso!");
                      }
                      else
                        debugPrint("Falha!");
                    },
                    color: Colors.pink,
                    child: Text(
                      "Registre-se",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
