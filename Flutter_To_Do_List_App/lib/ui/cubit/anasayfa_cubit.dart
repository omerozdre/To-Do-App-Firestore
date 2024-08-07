import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/data/entitiy/gorevler.dart';
import 'package:flutter_to_do_list_app/data/repo/gorevlerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Gorevler>>{
  AnasayfaCubit():super(<Gorevler>[]);

  var grepo = GorevlerDaoRepository();

  var collectionGorevler = FirebaseFirestore.instance.collection("Gorevler");//tabloya erişmemizi sağlayacak


  Future<void> gorevleriYukle() async{
    collectionGorevler.snapshots().listen((event){
      var gorevlerListesi = <Gorevler>[];

      var documents = event.docs;
      for(var document in documents){//document her satırı temsil ediyor
        var key = document.id;
        var data = document.data();
        var gorev = Gorevler.fromJson(data, key);
        gorevlerListesi.add(gorev);

      }
      emit(gorevlerListesi);
    });
      }

  Future<void> ara(String aramaKelimesi) async{
    collectionGorevler.snapshots().listen((event){
      var gorevlerListesi = <Gorevler>[];

      var documents = event.docs;
      for(var document in documents){//document her satırı temsil ediyor
        var key = document.id;
        var data = document.data();
        var gorev = Gorevler.fromJson(data, key);

        if(gorev.gorev_ad.toLowerCase().contains(aramaKelimesi.toLowerCase())){
          gorevlerListesi.add(gorev);
        }
      }
      emit(gorevlerListesi);
    });
  }

  Future<void> sil(String gorev_id) async{
    await grepo.sil(gorev_id);//repoya gitti
  }
}