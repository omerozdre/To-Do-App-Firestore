import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/data/repo/gorevlerdao_repository.dart';

class GorevKayitSayfaCubit extends Cubit<void>{
  GorevKayitSayfaCubit():super(0);

  var grepo = GorevlerDaoRepository();

  Future<void> gorevKaydet(String gorev_ad,String gorev_tarih, String gorev_saat) async {
    await grepo.gorevKaydet(gorev_ad, gorev_tarih, gorev_saat);
  }
}