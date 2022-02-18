import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/entity/users.dart';
import 'package:hive_example/repository/app_repository.dart';
import 'package:hive_example/user_data_cubit.dart';
import 'package:hive_example/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppRepository.initAppRepository().then((value) {
    runApp(MyApp(value));
  });
  final applicationDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(applicationDocumentDir.path);
  Hive.registerAdapter(UsersAdapter());
  Hive.openBox(Constants.USERS);
}

class MyApp extends StatelessWidget {
  final AppRepository appRepository;

  MyApp(this.appRepository) {

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<UserDataCubit>(
        create: (context) => UserDataCubit(appRepository),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserDataCubit>(context).getUsers();
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if(state is UserDataLoading){
            return CircularProgressIndicator();
          }

          if(state is UserDataSuccess){
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (ctx, index) {
                  final item = state.users[index];
                  return ListTile(
                    title: Text("${item.first_name} ${item.last_name}"),
                    subtitle: Text("${item.email}"),
                  );
                });
          }
          if(state is Error){
            return Text(state.exception!);
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
