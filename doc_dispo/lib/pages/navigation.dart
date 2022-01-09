import 'package:doc_dispo/common/colors.dart';
import 'package:doc_dispo/common/data.dart';
import 'package:doc_dispo/pages/home_page.dart';
import 'package:doc_dispo/pages/patient/listes/list_medecin.dart';
import 'package:doc_dispo/pages/profile.dart';
import 'package:doc_dispo/pages/rdv.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget
{
  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation>
{


  late List<Widget> widgetsOptions;
  late List<BottomNavigationBarItem> widgetsNavigation;

  void _onTapItem(int index)
  {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    if(currentUser == null)
      {
        widgetsOptions = [
          HomePage(),
          ListMedecin(),
          Profile(),
        ];

        widgetsNavigation = [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Accueil"
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: "Medecins"
            ),

            const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile"
            ),
        ];
      }
    else{
      widgetsOptions = [
        HomePage(),
        ListMedecin(),
        Rdv(),
        Profile(),
      ];

      widgetsNavigation = [
        const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil"
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: "Medecins"
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: "Rdv"
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
        ),
      ];
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorWidget,
      body: widgetsOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: widgetsNavigation,
        currentIndex: selectedIndex,
        onTap: _onTapItem,
        selectedItemColor: colorWidget,
        unselectedItemColor: colorNavigationItemUnselected,
      ),
    );

  }

}