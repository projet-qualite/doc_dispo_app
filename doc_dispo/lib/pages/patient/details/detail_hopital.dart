import 'package:doc_dispo/classes/hopital.dart';
import 'package:doc_dispo/classes/specialite.dart';
import 'package:doc_dispo/common/widgets.dart';
import 'package:doc_dispo/main_elements/functions.dart';
import 'package:doc_dispo/pages/patient/details/detail_medecin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class DetailHopital extends StatefulWidget
{
  Hopital? hopital;
  List<dynamic>? listMedecin;
  List<dynamic>? listSpecialite;
  List<dynamic>? listAssurance;
  DetailHopital({required this.hopital,required this.listMedecin,required this.listSpecialite, required this.listAssurance});
  DetailHopitalState createState() => DetailHopitalState();
}

class DetailHopitalState extends State<DetailHopital>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


  Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.hopital!.libelle),),
      body: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: size.width/2.5,
                            height: size.width/3.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network("http://54.38.186.80/front/img/hopitaux/"+widget.hopital!.img)
                            )
                        ),
                        Column(
                          children: [
                            Text(widget.listMedecin!.length.toString(), style: const TextStyle(fontWeight: FontWeight.w400, fontFamily: "Roboto", fontSize: 18)),
                            const Text("Medecins", style: TextStyle(fontWeight: FontWeight.w800, fontFamily: "Roboto", fontSize: 15),)
                          ],
                        ),
                        Column(
                          children: [
                            Text(widget.listSpecialite!.length.toString(), style: const TextStyle(fontWeight: FontWeight.w400, fontFamily: "Roboto", fontSize: 18)),
                            const Text("Spécialités", style: TextStyle(fontWeight: FontWeight.w800, fontFamily: "Roboto", fontSize: 15),)
                          ],
                        )
                      ],
                    )
                ),
                const SizedBox(height: 30,),


                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Medecins",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25),
                  ),),
                const SizedBox(height: 20,),

                SizedBox(
                  height: size.height / 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.listMedecin!.length,
                      itemBuilder: (context, index) {

                        Specialite? listSpe = getSpecialiteMedecin(id: widget.listMedecin![index]!.id);
                        String title = widget.listMedecin![index]!.type + " "+ widget.listMedecin![index]!.nom +" "+ widget.listMedecin![index]!.prenom;

                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailMedecin(medecin: widget.listMedecin![index])),
                            );
                          },
                          child: cardElementMedecin(title: title, subtitle: listSpe, size: size, image: "http://54.38.186.80/front/img/medecins/"+widget.listMedecin![index]!.img_1),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Spécialités",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 25),
                  ),
                ),

                const SizedBox(height: 20,),

                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.listSpecialite!.length,
                      itemBuilder: (context, index) {

                        return Container(
                          margin: const EdgeInsets.only(left: 20, right: 2),
                          padding: const EdgeInsets.all(10),
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[400]
                          ),
                          child: Center(
                            child: Text(widget.listSpecialite![index].libelle, style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );

                      }),
                ),

                const SizedBox(height: 30,),

                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Assurances",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 28),
                  ),
                ),
                const SizedBox(height: 20,),


                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.listAssurance!.length,
                      itemBuilder: (context, index) {

                        return Container(
                          margin: const EdgeInsets.only(left: 20, right: 2),
                          padding: const EdgeInsets.all(10),
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[400]
                          ),
                          child: Center(
                            child: Text(widget.listAssurance![index].libelle, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );

                      }),
                )


              ],
            )
        ),
      )
    );

  }

}