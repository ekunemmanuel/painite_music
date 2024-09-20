import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panite_music/data/models/auth/create_user_req.dart';
import 'package:panite_music/service_locator.dart';

import '../../models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<void> signOut();
  Future<Either> signIn(SigninUserReq user);
  Future<Either> signUp(CreateUserReq createUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  AuthFirebaseServiceImpl();

  final FirebaseAuth _firebaseAuth = sl<FirebaseAuth>();
  final FirebaseFirestore _firestore = sl<FirebaseFirestore>();
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<Either> signIn(SigninUserReq user) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return const Right('Sign in success');
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message!;
      if (e.code == "invalid-email") {
        errorMessage = "No user found for that email";
      } else if (e.code == "invalid-credential") {
        errorMessage = "Wrong Password provided";
      }
      return Left(errorMessage);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
      await result.user!.updateDisplayName(createUserReq.fullName);
      _firestore.collection('users').doc(result.user!.uid).set({
        'email': createUserReq.email,
        'fullName': createUserReq.fullName,
        'uid': result.user!.uid,
      });
      return const Right('Sign up success');
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message!;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      return Left(errorMessage);
    }
  }
}
