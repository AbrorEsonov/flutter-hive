import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_example/repository/app_repository.dart';

abstract class RepositoryCubit<T> extends Cubit<T>{
  AppRepository appRepository;

  RepositoryCubit(this.appRepository, T t) : super(t);
}
