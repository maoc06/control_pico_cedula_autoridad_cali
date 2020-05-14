
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pico_cedula_autoridad/bloc_settings.dart';
import 'package:pico_cedula_autoridad/view/mapAutoridadesView.dart';

class LoginAutoridadModel extends BloCSetting{

  static FirebaseAuth auth = FirebaseAuth.instance;

  static String msgError = '';

  signInWithEmail(String email, String password, BuildContext ctx, state) async {
    if(email != '' || password != '') {
      
      try {

        AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, 
          password: password
        );

        FirebaseUser user = result.user;

        assert(user != null);
        assert(await user.getIdToken() != null);

        FirebaseUser currentUser = await auth.currentUser();
        assert(user.uid == currentUser.uid);

        print("UID: ${user.uid}");

        // (email == 'alcaldia@cali.com')
        // ? print('ALCALDIA LOGIN()...')
        // : Navigator.push( ctx, MaterialPageRoute(builder: (ctx) => MapAurtoridades() ));
        Navigator.push( ctx, MaterialPageRoute(builder: (ctx) => MapAurtoridades() ));

        // Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) => MapAurtoridades()));

        msgError = '';

      } catch (e) {
        if(Platform.isAndroid) {
          switch (e.message) {
            case 'There is no user record corresponding to this identifier. The user may have been deleted.':
              rebuildWidgets(
                setStates: () {
                  msgError = 'El usuario no se encuentra registrado';
                },
                states: [state]
              );
              print('UserNotFound');
              break;
            case 'The password is invalid or the user does not have a password.':
              print('Invalid Password');
              msgError = 'Contraseña incorrecta';
              rebuildWidgets(
                setStates: () {
                  msgError = 'Contraseña incorrecta';
                },
                states: [state]
              );
              break;
            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
              print('Not Network');
              msgError = 'No tiene conexion a internet';
              rebuildWidgets(
                setStates: () {
                  msgError = 'No tiene conexion a internet';
                },
                states: [state]
              );
              break;
            default:
              msgError = 'Ocurrio un error. Vuelve a intentarlo';
              print("###########################");
              print(e.message);
              print("###########################");
              rebuildWidgets(
                setStates: () {
                  msgError = 'Ocurrio un error. Vuelve a intentarlo';
                },
                states: [state]
              );
              break;
          }
        }
      }

    } else {
      msgError = 'Ingresa información en los campos';
      rebuildWidgets(
        setStates: () {
          msgError = 'Ingresa información en los campos';
        },
        states: [state]
      );
      print("Null");
    }
    
    
    
  }

  static get getMsgError => msgError;

}

LoginAutoridadModel singIn;