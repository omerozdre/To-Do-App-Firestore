
class Gorevler{
  String gorev_id;
  String gorev_ad;
  String gorev_tarih;
  String gorev_saat ;

  Gorevler({required this.gorev_id, required this.gorev_ad, required this.gorev_tarih, required this.gorev_saat});

  factory Gorevler.fromJson(Map<dynamic,dynamic> json,String key){
    return Gorevler(
        gorev_id: key,
        gorev_ad: json["gorev_ad" as String],
        gorev_tarih: json["gorev_tarih" as String],
        gorev_saat: json["gorev_saat" as String]);

  }
}