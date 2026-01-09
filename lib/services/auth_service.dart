import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Función para Registrarse
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      User? user = result.user;

      // Sincronización: Guardamos en Firestore para que React lo vea
      if (user != null) {
        await _db.collection('users').doc(user.uid).set({
          'email': email,
          'platform': 'android',
          'createdAt': DateTime.now(),
        });
      }
      return user;
    } catch (e) {
      print("Error en registro: $e");
      return null;
    }
  }

  // Función para Iniciar Sesión
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } catch (e) {
      print("Error en login: $e");
      return null;
    }
  }
}