import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_user.dart';
import 'login_event.dart';
import 'login_state.dart';

class AuthBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await loginUseCase(event.email, event.password);
        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure('Login failed: ${e.toString()}'));
      }
    });
  }
}
