import 'package:budget_buddy/core/main_navigator.dart';
import 'package:budget_buddy/core/util/responsive.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/database_helper.dart';
import 'core/util/bloc_obserever.dart';
import 'features/category/presentation/screens/category_slicing/screens/category_slicing_screen.dart';
import 'features/user_info/presentation/screens/settting_up/screens/setup_profile_screen.dart';


void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.db;
  Bloc.observer=MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home:   BlocProvider <SettingCubit> (
          create: (ctx)=>SettingCubit(),
          child:  SetupProfileScreen()));

  }
}

