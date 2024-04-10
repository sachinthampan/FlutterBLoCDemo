import 'dart:collection';
import 'dart:js_interop';

import 'package:flutter_bloc_demo/network/resource.dart';
import 'package:flutter_bloc_demo/repository/LoginRepo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginEvent{}
class LoginPressed extends LoginEvent{
  final String username;
  final String password;

  LoginPressed(this.username, this.password);
}
class RegisterPressed extends LoginEvent{}
class Reset extends LoginEvent{}

class Loginbloc extends Bloc<LoginEvent, LoginPageState>{
  final LoginRepo loginRepo;
  Loginbloc({required this.loginRepo}) : super(LoginPageState(loginState: LoginPageStates.INITIAL))  {
    on<LoginPressed>((event, emit) async {
      emit(LoginPageState(loginState: LoginPageStates.LOADING));
      print("Loading...");
      try{
        debugPrint("MyBloc : user , pass  : ${event.username + "," + event.password}");
        Map<String, String> params = {"username" : event.username, "password" : event.password};
        await loginRepo.auth(params).then((value) {
          Map mData = (value as Resource<dynamic>).data as Map<String, dynamic>;
          debugPrint("MyBloc : auth response : ${mData.toString()}");
          debugPrint("MyBloc : auth response : token =  ${mData['token']}");

          emit(LoginPageState(loginState: LoginPageStates.LOGIN_SUCCESS));


        },onError: (err){
          debugPrint("MyBloc : auth response : err ${err.toString()}");
          emit(LoginPageState(loginState: LoginPageStates.LOGIN_FAILED));
        });
      }
      catch(exception, stacktrace){
        emit(LoginPageState(loginState: LoginPageStates.LOGIN_FAILED));
      }
    });
      //  on<LoginPressed>((event, emit) => emit(LoginPageState(loginState : 1))
    on<RegisterPressed>((event, emit) => emit(LoginPageState(loginState: LoginPageStates.REGISTER)));
    on<Reset>((event, emit) => emit(LoginPageState(loginState: LoginPageStates.INITIAL)));
  }

  void _loginPressedEventToState(
      LoginPressed event, Emitter<LoginPageState> emit) {
    emit(LoginPageState(loginState: LoginPageStates.LOADING));
    print("Loading...");
    try{
      loginRepo.auth(MapEntry("hbingley1", "CQutx25i8r")).then((value) => {
        debugPrint("MyBloc : auth response : ${value.json()}")

      },onError: (err){
        debugPrint("MyBloc : auth response : err ${err.toString()}");
      });
    }
    catch(exception, stacktrace){
      emit(LoginPageState(loginState: LoginPageStates.LOGIN_FAILED));
    }
  }
}






/* @override
  Stream<LoginPageState> mapEventToState(LoginEvent event) async*{
    switch (event){
      case LoginEvent.submit :
        yield LoginPageState(loginState: 1);
        break;
      case LoginEvent.register :
        yield LoginPageState(loginState: 2);
        break;
      case LoginEvent.forgotpassword :
        yield LoginPageState(loginState: 3);
        break;

      default : yield LoginPageState(loginState: -2);
    }
  }*/

class LoginPageState{
  String? userName = "";
  String? password = "";
  LoginPageStates loginState = LoginPageStates.INITIAL;

  LoginPageState({
    required this.loginState
  });


  void setUserName(String? username){
    userName = username;
  }

  void setPassword(String? pass){
    password = pass;
  }
}
enum LoginPageStates{
  LOADING, LOGIN_FAILED, LOGIN_SUCCESS, REGISTER, INITIAL
}
