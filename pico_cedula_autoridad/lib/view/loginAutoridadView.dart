import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:pico_cedula_autoridad/controller/loginAutoridadController.dart';
import 'package:pico_cedula_autoridad/model/loginAutoridadModel.dart';

import 'mapAutoridadesView.dart';

class LoginAutoridad extends StatefulWidget {
  LoginAutoridad({Key key}) : super(key: key);

  final MaterialAppLogin state = MaterialAppLogin();

  LoginAutoridadController get controller => state.controller;

  @override
  MaterialAppLogin createState() => state;
}

class MaterialAppLogin extends StateMVC<LoginAutoridad> {

  final TextEditingController emailInput = new TextEditingController();
  final TextEditingController passwordInput = new TextEditingController();

  MaterialAppLogin() : super(LoginAutoridadController()) {
    _con = controller;
  }
  LoginAutoridadController _con;

  @override
  void initState() {
    super.initState();
    singIn = LoginAutoridadModel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Autoridad',
      debugShowCheckedModeBanner: false,
      home: _LoginAutoridad(
        emailInput: emailInput,
        passwordInput: passwordInput,
        controlador: _con,
        state: this,
      ),
    );
  }
}

class _LoginAutoridad extends StatelessWidget {
  
  final TextEditingController emailInput;
  final TextEditingController passwordInput;
  final LoginAutoridadController controlador;
  final State<StatefulWidget> state;

  const _LoginAutoridad({
    Key key, 
    @required this.emailInput, 
    @required this.passwordInput, 
    @required this.controlador,
    @required this.state
  }) : super(key: key);

  // emailInput = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text("Login Autoridad"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context, false),
        // ),
      ),
      // resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/pics/loginAutridad.png'),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 270.0,
                  ),
                  Container(
                      width: 250.0,
                      child: Center(
                        child: TextField(
                          controller: emailInput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            labelText: 'Usuario',
                          ),
                          //autofocus: true,
                          style: TextStyle(
                              height: 1, fontSize: 20.0, color: Colors.black54),
                          //onSubmitted: (cc) => checkIsCCExists(cc, context),
                        ),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: 250.0,
                      child: Center(
                        child: PasswordField(
                          controller: passwordInput,
                          hasFloatingPlaceholder: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black38)),
                          hintStyle: TextStyle(
                              height: 1, fontSize: 20.0, color: Colors.black54),
                        ),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      child: Center(
                    child: Text(
                      // '-',
                      (controlador.getMsgError() == '') ? '' : controlador.getMsgError(),
                      style: TextStyle(color: Colors.red),
                    ),
                  )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      width: 250.0,
                      height: 50.0,
                      child: Center(
                          child: ButtonTheme(
                        minWidth: 250.0,
                        height: 50.0,
                        child: RaisedButton(
                          child: Text(
                            'Entrar',
                            style: TextStyle(fontSize: 20),
                          ),
                          color: Colors.pink[400],
                          padding: new EdgeInsets.all(15.0),
                          textColor: Colors.lightBlue[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          onPressed: () {
                            singIn.signInWithEmail(emailInput.text,
                                passwordInput.text, context, this);
                          },
                        ),
                      ))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
