import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
}
