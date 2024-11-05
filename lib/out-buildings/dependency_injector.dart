import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_flutter_app/catalog/domain/models/todo.dart';
import 'package:todo_flutter_app/catalog/infrastructure/data_source/auth/auth_remote_data_source.dart';
import 'package:todo_flutter_app/catalog/infrastructure/data_source/todo/todo_remote_data_source.dart';
import 'package:todo_flutter_app/catalog/infrastructure/repository/todo/todo_repository.dart';
import 'package:todo_flutter_app/catalog/navigation/navigation_service.dart';
import 'package:todo_flutter_app/catalog/service/network/dio_network_service.dart';
import 'package:todo_flutter_app/catalog/view/home/bloc/home_bloc.dart';
import 'package:todo_flutter_app/catalog/view/home/todo_bloc/todo_bloc.dart';

import '../catalog/infrastructure/repository/auth/auth_repository.dart';
import '../catalog/view/profile/bloc/login_bloc.dart';

final getIt = GetIt.instance;

Future init() async {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerSingleton<DioNetworkService>(
    DioNetworkService(),
  );

  getIt.registerLazySingleton<Dio>(
        () => getIt<DioNetworkService>().dio,
  );

  //key
  const todosKey = 'todos';
  //adapters
  Hive.registerAdapter(ToDoAdapter());
  //box
  final todosBox = await Hive.openBox<ToDo>(todosKey);
  //repos

  ///data sources
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt()));
  getIt.registerLazySingleton(() => TodosRemoteDataSource(getIt()));


  ///Infrastructure Layer - repositories
  getIt.registerLazySingleton(() => AuthRepository(getIt()));
  getIt.registerLazySingleton(() => TodosRepository(getIt(),todosBox:todosBox));


  ///Presentation Layer - Blocs
  getIt.registerFactory(() => LoginBloc(authRepository: getIt()));
  getIt.registerFactory(() => HomeBloc(todosRepository: getIt()));
  getIt.registerFactory(() => TODOBloc(todosRepository: getIt()));

}


