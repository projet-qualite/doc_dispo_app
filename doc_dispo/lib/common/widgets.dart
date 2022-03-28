import 'package:doc_dispo/classes/creneau.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';


// Templates des éléments de l'accueil
Widget templateElementsAccueil({required String title, required String subtitle, required Size size, required String image})
{
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: size.width / 2.2,
            height: size.height / 6,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius:
                BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                  image,
                  width: size.width),
            )),
        Container(
          width: size.width / 2.5,
          padding: EdgeInsets.only(top: 4),
          child:  Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: size.width / 3,
          child:  Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}




// Header on login, signin, reset pages
Widget header({required double width, required String mainTitle, required String subtitle1,required String subtitle2,
  required BuildContext context, required String route, bool back = false, bool logo= true})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (back) ? IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: () {
            Navigator.of(context).pop();
          },
          ) : Text(""),
          (logo) ? Image.asset(
            "images/logo.png",
            width: (back) ? width/2 : width/1.8,
          ) : Text(''),
        ],
      ),

      Text(
        mainTitle,
        style: TextStyle(
            color: Colors.black,
            fontSize: width/17,
            fontWeight: FontWeight.w800,
            fontFamily: "Roboto"
        ),
      ),


      Row(
        children:  [
          Text(
            subtitle1,
            style:  TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              fontSize: width/35,
            ),
          ),
          InkWell(
            onTap: () async{

              if (!await launch(
                route,
                forceSafariVC: false,
                forceWebView: false,
              )) {
                throw 'Could not launch $route';
              }

            },
            child: Text(
              subtitle2,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black
              ),
            ),
          )
        ],
      ),
    ],
  );
}


// Border of fields
OutlineInputBorder border =  OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: const BorderSide(color: Colors.black)
);



Widget pageViewElement(String imageUrl, String title, String text, BuildContext context)
{
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          width: MediaQuery.of(context).size.width/2,
        ),
        const SizedBox(height: 20,),
        Text(
          title,
          style: const TextStyle(
              fontSize: 25,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              color: Colors.white
          ),),
        const SizedBox(height: 20,),
        Text(
          text,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w200,
              color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}



Widget indicatorPageView(int currentPageView,int index)
{
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.only(left: 10, right: 10),
    height: 16,
    width: (currentPageView == index ) ? 42 : 25,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (currentPageView == index ) ? pageViewSelected : pageViewUnselected
    ),
  );
}

Widget cardElementMedecin({required String title, required Specialite? subtitle, required Size size, required String image})
{


  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: size.width / 2.2,
            height: size.height / 5.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(image, fit: BoxFit.cover,),
            )
        ),
        Container(
          width: size.width / 2.5,
          padding: EdgeInsets.only(top: 4),
          child:  Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: size.width / 3,
          child:  Text(
            subtitle!.libelle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}


Widget styleCreneau(Creneau creneau)
{
  return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorWidget
      ),
      child: Center(
        child: Text(showHour(creneau.heure), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
      )


  );
}


Widget identite(String titre, String? valeur)
{
  return (valeur != null) ? Row(
    children: [
       Text(
        titre,
        style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color.fromRGBO(78, 78, 78 ,.8)),
      ),
      Text(
        valeur,
        style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 14,
            color: Color.fromRGBO(78, 78, 78 ,.7)),
      ),
    ],
  ) :  const Text('');
}


Widget recapitulatif(String titre, String? valeur)
{
  return (valeur != null) ? Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        titre,
        style: const TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color.fromRGBO(78, 78, 78 ,.8)),
      ),
      Text(
        valeur,
        style: const TextStyle(
            fontFamily: "Roboto",
            fontSize: 11,
            color: Color.fromRGBO(78, 78, 78 ,.7)),
      ),
    ],
  ) :  const Text('');
}


Widget libelle(Color colorBox, String texte, Color colorTexte)
{
  return Container(
    margin: const EdgeInsets.only(right: 2, left: 20),
    padding: const EdgeInsets.all(7),
    height: 25,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: colorBox,
    ),
    child: Center(
      child: Text(
          texte,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: colorTexte)
      ),
    ),
  );
}


Widget buttonRequest(bool isLoading, String titre)
{
  return (isLoading) ?
  Center(
    child: Container(
      height: 20,
      width: 20,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
      ),
    ),
  ) :  Center(
    child: Text(
      titre,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold),
    ),
  );
}


dynamic snackbar(String titre, BuildContext context)
{
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(titre)),
  );
}
