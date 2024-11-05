import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_app/catalog/domain/remote/auth/requests/login_request.dart';
import 'package:todo_flutter_app/common/config/shared_data.dart';
import '../../../domain/models/user_info.dart';
import '../../../domain/remote/auth/responses/login_response.dart';
import '../../../domain/remote/common/response_type.dart';
import '../../../infrastructure/repository/auth/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authRepository,
  }) : super(LoginInitial()) {
    on<LoginByEmail>(_onLogin);
  }

  final AuthRepository authRepository;

  Future<void> _onLogin(LoginByEmail event, emit) async {
    try {
      emit(LoginLoading());
      final response = await authRepository.loginByEmail(loginRequest: event.model);
      switch (response.responseType) {
        case ResponseType.success:
          SharedData.shared.saveCurrentUser(user: response.data!.user!,token: response.data!.user!.accessToken);
          emit(LoginSuccessfully(userTokens: response.data));
          break;
        default:
          emit(LoginError(response.message));
      }
    } catch (e) {
      print(e);
      emit(LoginError('general_error'.tr()));
    }
  }
}
