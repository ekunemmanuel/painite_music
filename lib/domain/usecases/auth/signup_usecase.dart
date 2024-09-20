import 'package:dartz/dartz.dart';
import 'package:panite_music/core/usecases/usecase.dart';
import 'package:panite_music/data/models/auth/create_user_req.dart';
import 'package:panite_music/domain/repository/auth/auth.dart';
import 'package:panite_music/service_locator.dart';

class SignupUsecase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signUp(params!);
  }
}
