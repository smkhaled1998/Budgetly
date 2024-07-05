import 'package:budget_buddy/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/explore/presentation/screens/bottom_navigation_bar_widget.dart';
import 'features/explore/presentation/widgets/calculator_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExploreCubit>(
      create: (context)=> ExploreCubit()..getCategoryData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home:  BottomNavigationBarWidget(),
      ),
    );
  }
}

