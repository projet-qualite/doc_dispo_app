import 'jour.dart';

class Mois
{
  int numMonth;
  int year;
  List<Jour> jours=[];

  Mois({required this.numMonth, required this.year});

  String toString()
  {
    switch (this.numMonth) {
      case 1:
        return 'Janvier';
      case 2:
        return 'Février';
      case 3:
        return 'Mars';
      case 4:
        return 'Avril';
      case 5:
        return 'Mai';
      case 6:
        return 'Juin';
      case 7:
        return 'Juillet';
      case 8:
        return 'Août';
      case 9:
        return 'Septembre';
      case 10:
        return 'Octobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Décembre';

      default:
        return 'undefined';
    }
  }


  Mois nextMonth()
  {
    int num = this.numMonth + 1;
    int annee = this.year;
    if(num > 12)
    {
      num -=12;
      annee++;
    }


    return Mois(numMonth: num, year: annee);
  }


  int nbJour() {
    switch (this.numMonth) {
      case 1:
        return 31;
      case 2:
        return (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) ? 29 : 28;
      case 3:
        return 31;
      case 4:
        return 30;
      case 5:
        return 31;
      case 6:
        return 30;
      case 7:
        return 31;
      case 8:
        return 31;
      case 9:
        return 30;
      case 10:
        return 31;
      case 11:
        return 30;
      case 12:
        return 31;
      default:
        return -1;
    }
  }

  /*void generateDays()
  {
    for(int i = 1; i <= this.nbJour(); i++)
    {
      DateTime jour = DateTime(this.year, this.numMonth, i);

      if(DateTime.now().difference(jour).inDays <= 0)
      {
        List<String> heures = [];
        list_creneau.forEach((key, value) {
          int day = int.parse(value.date_creneau.split("-")[0]);
          int mois = int.parse(value.date_creneau.split("-")[1]);
          int annee = int.parse(value.date_creneau.split("-")[2]);

          DateTime creneau = DateTime(annee, mois, day);
          if(jour.difference(creneau).inDays == 0)
            {
              heures.add(value.heure_creneau);
            }
        });
        jours.add(Jour(dayWeek: jour.weekday, day: jour.day, heures: heures));
      }


    }
  }*/
}
