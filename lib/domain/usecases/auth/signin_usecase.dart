import 'package:dartz/dartz.dart';
import 'package:panite_music/core/usecases/usecase.dart';
import 'package:panite_music/data/models/auth/signin_user_req.dart';
import 'package:panite_music/domain/repository/auth/auth.dart';
import 'package:panite_music/service_locator.dart';

class SigninUsecase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signIn(params!);
  }
}
