import 'creneau.dart';

class Jour
{
  int dayWeek;
  int day;
  List<Creneau> heures;
  bool selected = false;
  Jour({required this.dayWeek, required this.day, required this.heures, this.selected = false});

  String toString()
  {
    switch(this.dayWeek)
    {
      case 1:
        return 'Lun';
      case 2:
        return 'Mar';
      case 3:
        return 'Mer';
      case 4:
        return 'Jeu';
      case 5:
        return 'Ven';
      case 6:
        return 'Sam';
      case 7:
        return 'Dim';
      default:
        return 'undefined';

    }
  }

  void setSelected(bool selected)
  {
    this.selected = selected;
  }


}