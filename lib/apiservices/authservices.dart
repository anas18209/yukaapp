import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a new user with email and password
  Future<User?> createUserWithEmailPassword(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      print("Email or Password is empty.");
      return null; // Early exit if email or password is empty
    }

    try {
      print("Attempting to create a user with email: $email");

      // Attempt to create a new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Success, user is created
      print("User creation successful for: ${userCredential.user?.email}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Firebase-specific exceptions
      print("FirebaseAuthException caught: ${e.message}");
      print("Error code: ${e.code}");

      if (e.code == 'email-already-in-use') {
        print('The email is already in use by another account.');
        throw Exception('The email is already in use by another account.');
      } else if (e.code == 'weak-password') {
        print('The password is too weak.');
        throw Exception('The password is too weak.');
      } else {
        print('Error: ${e.message}');
        throw Exception('An error occurred during user creation. Please try again.');
      }
    } catch (e) {
      // Non-Firebase related errors
      print("Error during user creation: $e");
      throw Exception("Failed to create user. Please check your email and password.");
    }
  }
}
