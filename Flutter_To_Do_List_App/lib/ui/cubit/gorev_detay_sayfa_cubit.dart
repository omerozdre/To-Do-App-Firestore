import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/data/repo/gorevlerdao_repository.dart';


class GorevDetaySayfaCubit extends Cubit<void>{
  GorevDetaySayfaCubit():super(0);

  var grepo = GorevlerDaoRepository();

  Future<void> gorevGuncelle(String gorev_id,String gorev_ad,String gorev_tarih, String gorev_saat) async {
    await grepo.gorevGuncelle(gorev_id, gorev_ad, gorev_tarih, gorev_saat);
  }
}