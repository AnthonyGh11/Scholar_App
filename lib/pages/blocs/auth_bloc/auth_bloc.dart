import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(RegisterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(errMessage: 'Weak Password'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(errMessage: 'Email Already in Use'));
          }
        } on Exception catch (e) {
          emit(RegisterFailure(
              errMessage: 'Something Went Wrong, Please Try Again'));
        }
      }
    });
  }
}
