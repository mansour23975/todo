import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_flutter_app/catalog/infrastructure/data_source/auth/auth_remote_data_source.dart';
import '../../../../common/helper/network_connection_helper.dart';
import '../../../domain/remote/auth/requests/login_request.dart';
import '../../../domain/remote/auth/responses/login_response.dart';
import '../../../domain/remote/common/response_wrapper.dart';
import '/../catalog/domain/remote/common/response_type.dart' as res_type;

class AuthRepository {
  AuthRepository(this.authRemoteDataSource);

  final AuthRemoteDataSource authRemoteDataSource;

  Future<ResponseWrapper<LoginResponse>> loginByEmail({required LoginRequest? loginRequest}) async {
    String? message = await NetworkConnectionHelper.checkNetworkConnection();
    if (message != null) {
      var res = ResponseWrapper<LoginResponse>();
      res.message = message;
      res.responseType = res_type.ResponseType.networkError;
      return res;
    }
    try {
      Response response = await authRemoteDataSource.loginByEmail(loginRequest: loginRequest);
      var res = ResponseWrapper<LoginResponse>();
      print(response.statusCode);
      print(response.data["id"]);
      switch (response.statusCode) {
        case 200:
          //bool? result = response.data['success'];
          //if (result == true) {
          res.responseType = res_type.ResponseType.success;
          res.data = LoginResponse.fromJson(response.data);
          /*} else {
            res.message = response.data['message'];
            res.errors = Errors.fromJson(response.data['errors']);
            res.responseType = res_type.ResponseType.validationError;
          }*/
          return res;

        case 422:
          res.message = response.data['message'];
          res.responseType = res_type.ResponseType.validationError;
          return res;
        case 401:
          res.message = response.data['message'];
          res.responseType = res_type.ResponseType.validationError;
          return res;
        case 400:
          res.message = response.data['message'];
          res.responseType = res_type.ResponseType.validationError;
          return res;
        default:
          res.responseType = res_type.ResponseType.clientError;

          return res;
      }
    } catch (e) {
      var res = ResponseWrapper<LoginResponse>();
      res.message = "server_error".tr();
      res.responseType = res_type.ResponseType.serverError;
      return res;
    }
  }
}
