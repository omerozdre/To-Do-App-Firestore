import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter_to_do_list_app/ui/cubit/gorev_detay_sayfa_cubit.dart';
import 'package:flutter_to_do_list_app/ui/cubit/gorev_kayit_sayfa_cubit.dart';
import 'package:flutter_to_do_list_app/ui/views/anasayfa.dart';
import 'package:flutter_to_do_list_app/ui/views/gorev_kayit_sayfa.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GorevKayitSayfaCubit()),
        BlocProvider(create: (context) => GorevDetaySayfaCubit()),
        BlocProvider(create: (context) => AnasayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

