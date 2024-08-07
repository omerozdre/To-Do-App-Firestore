import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/data/entitiy/gorevler.dart';
import 'package:flutter_to_do_list_app/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter_to_do_list_app/ui/views/gorev_detay_sayfa.dart';
import 'package:flutter_to_do_list_app/ui/views/gorev_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {//uygulama ilk calistiginda burası çalıştı
    super.initState();//AnasayfaCubit'deki gorevleriYukle fonksiyonunu çalıştırdı
    context.read<AnasayfaCubit>().gorevleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF900000),
      appBar: AppBar(
        title: aramaYapiliyorMu ?
         TextField(
          decoration: const InputDecoration(
            hintText: "Ara",
            hintStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),),
           style: const TextStyle(
             color: Colors.white,
           ),
          onChanged: (String aramaSonucu){
            context.read<AnasayfaCubit>().ara(aramaSonucu);

          },
        ):
        const Text("Welcome To Do List",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      //  centerTitle: true,
        backgroundColor:  const Color(0xFF5c0a0a),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
            });
            context.read<AnasayfaCubit>().gorevleriYukle();
           }, icon:const Icon(Icons.clear,color: Colors.white,),) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu= true;
            });
           }, icon:const Icon(Icons.search,color: Colors.white,),)
        ],
      ),
      body:  BlocBuilder<AnasayfaCubit,List<Gorevler>>(//dinleme altyapısı//cubiti çalıştırıp list i alacğız//emit ettiğimiz yapılar buraya geliyor
        builder: (context,gorevlerListesi){//aldık
          if(gorevlerListesi.isNotEmpty){//kontrol ettik
            return ListView.builder(
              itemCount: gorevlerListesi.length,//listede kullandık
              itemBuilder: (context,indeks){//döngü gibi çalışacak
                var gorev = gorevlerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GorevDetaySayfa(gorev: gorev)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Card(
                      child: SizedBox(height: 130,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.draw),
                                      const SizedBox(width: 8,),
                                      Text(gorev.gorev_ad,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range),
                                      const SizedBox(width: 8,),
                                      Text(gorev.gorev_tarih,style: const TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time),
                                      const SizedBox(width: 8,),
                                      Text(gorev.gorev_saat,style: const TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,top: 70),
                              child: ElevatedButton(onPressed: (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("${gorev.gorev_ad} silinsin mi?"),
                                      action: SnackBarAction(
                                        label: "Evet",
                                        onPressed: (){
                                          context.read<AnasayfaCubit>().sil(gorev.gorev_id);//id'yi anasayfacubite gonderdik
                                        },
                                      ),
                                    ),
                                );
                              }, child: const Text("Sil",style: TextStyle(color: Color(0xFF5c0a0a),fontSize: 20),)),
                            )

                            /*IconButton(onPressed: (){

                            }, icon:const Icon(Icons.clear,color: Color(0xFF5c0a0a),size: 30,),)*/
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const GorevKayitSayfa()));
        },
        child: Icon(Icons.add,color: Colors.white,size: 40,),
        backgroundColor: const Color(0xFF5c0a0a),
      ),
    );
  }
}
