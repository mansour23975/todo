import 'package:dio/dio.dart';
import '../../../../common/common.dart';
import '../../../domain/remote/auth/requests/login_request.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this.dio);

  final Dio dio;

  Future<dynamic> loginByEmail({required LoginRequest? loginRequest}) async {
    try {
      Response response = await dio.post(APIUrls.login, data: loginRequest?.toJson());
      return response;
    } catch (e) {
      print(e);
    }
  }
}
