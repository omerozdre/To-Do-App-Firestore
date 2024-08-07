import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_to_do_list_app/data/entitiy/gorevler.dart';

class GorevlerDaoRepository{

  var collectionGorevler = FirebaseFirestore.instance.collection("Gorevler");//tabloya erişmemizi sağlayacak

   Future<void> gorevKaydet(String gorev_ad,String gorev_tarih, String gorev_saat) async {
     var yeniGorev = HashMap<String,dynamic>();
     yeniGorev["gorev_id"] = "";
     yeniGorev["gorev_ad"] = gorev_ad;
     yeniGorev["gorev_tarih"] = gorev_tarih;
     yeniGorev["gorev_saat"] = gorev_saat;
     collectionGorevler.add(yeniGorev);
  }

  Future<void> gorevGuncelle(String gorev_id,String gorev_ad,String gorev_tarih, String gorev_saat) async {
    var guncellenenGorev = HashMap<String,dynamic>();
    guncellenenGorev["gorev_ad"] = gorev_ad;
    guncellenenGorev["gorev_tarih"] = gorev_tarih;
    guncellenenGorev["gorev_saat"] = gorev_saat;
    collectionGorevler.doc(gorev_id).update(guncellenenGorev);
  }

   Future<void> sil(String gorev_id) async{
     collectionGorevler.doc(gorev_id).delete();
   }
}