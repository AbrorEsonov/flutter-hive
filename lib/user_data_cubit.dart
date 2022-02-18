import 'package:equatable/equatable.dart';
import 'package:hive_example/cubit/repository_cubit.dart';
import 'package:hive_example/entity/users.dart';
import 'package:hive_example/repository/app_repository.dart';

part 'user_data_state.dart';

class UserDataCubit extends RepositoryCubit<UserDataState> {
  UserDataCubit(AppRepository appRepository) : super(appRepository, UserDataInitial());

  void getUsers(){
    emit(UserDataLoading());
    appRepository.getArticles().then((value){
      print("helllooooo");
      print(value!.data!);
      emit(UserDataSuccess(value.data!));
    }).onError((error, stackTrace){
      emit(Error(exception: error.toString()));
    });
  }
}
