import 'package:dartz/dartz.dart';
import 'package:panite_music/data/models/auth/create_user_req.dart';

import '../../../data/models/auth/signin_user_req.dart';

abstract class AuthRepository {
  Future<void> signOut();
  Future<Either> signIn(SigninUserReq user);
  Future<Either> signUp(CreateUserReq createUser);
}
