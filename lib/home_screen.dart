import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formkey;
  bool _hidepass;
  String _email;
  String _senha;

  @override
  void initState() {
    _hidepass = true;
    _email = "";
    _senha = "";
    _formkey = GlobalKey<FormState>();
  }

  void onClick() {
    if (_formkey.currentState.validate())
      debugPrint("Sucesso");
    else
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
                  onPressed: () {},
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
