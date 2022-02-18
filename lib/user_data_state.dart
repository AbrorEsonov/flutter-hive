part of 'user_data_cubit.dart';

abstract class UserDataState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserDataInitial extends UserDataState {

}

class UserDataLoading extends UserDataState {

}

class UserDataSuccess extends UserDataState {
   final List<Users> users;
   UserDataSuccess(this.users);

   @override
  List<Object?> get props => [users];
}

class Error extends UserDataState{
  final String? exception;
  Error({this.exception});
}
