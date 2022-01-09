import 'dart:async';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/common/request.dart';
import 'package:doc_dispo/pages/login.dart';
import 'package:doc_dispo/pages/navigation.dart';
import 'package:doc_dispo/pages/reset.dart';
import 'package:doc_dispo/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/page_view.dart';
import 'common/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr')
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/login': (context) => LogIn(),
        '/navigation': (context) => Navigation(),
        '/reset': (context) => Reset(),
        '/signin': (context) => SignIn(),
        '/home': (context) => Navigation(),
      },
      theme: ThemeData(primarySwatch: colorCustom),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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


  void requetes()
  {
    getHopital().then((response) {
      setState(() {
        print(response);
        list_hopital = response;
      });
    });

    getAssurance().then((response) {
      setState(() {
        list_assurance = response;
      });
    });


    getAffilier().then((response) {
      setState(() {
        list_affilier = response;
      });
    });

    getSpecialite().then((response) {
      setState(() {
        list_specialite = response;
      });
    });

    getMedecin().then((response) {
      setState(() {
        list_medecin = response;
      });
    });


    getSpecialiteHopital().then((response) {
      setState(() {
        list_specialites_hopital = response;
      });
    });


    getRdv().then((response) {
      setState(() {
        list_rdv = response;
      });
    });

    getProche().then((response) {
      setState(() {
        list_proche = response;
      });
    });

    getCreneau().then((response) {
      setState(() {
        list_creneau = response;
        print(list_creneau);
      });
    });
  }

  @override
  void initState() {
    super.initState();

    requetes();



    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
              context,
              _createRoute(),
              (Route<dynamic> route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: //Navigation()

            Center(
          child: Image.asset("images/logo.png", width: size.width / 2),
        )
            //Profile()
        //DetailMedecin(medecin: list_medecin[1])*/
        //ChoixDate(id_motif_consultation: 1,medecin: list_medecin[2],)
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => IntroPageView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(4.0, 4.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
