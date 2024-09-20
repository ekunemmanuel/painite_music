import 'package:dartz/dartz.dart';
import 'package:panite_music/data/models/auth/create_user_req.dart';
import 'package:panite_music/data/sources/auth/auth_firebase_service.dart';
import 'package:panite_music/domain/repository/auth/auth.dart';
import 'package:panite_music/service_locator.dart';

import '../../models/auth/signin_user_req.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SigninUserReq user) async {
    return await sl<AuthFirebaseService>().signIn(user);
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either> signUp(CreateUserReq createUser) async {
    return await sl<AuthFirebaseService>().signUp(createUser);
  }
}
