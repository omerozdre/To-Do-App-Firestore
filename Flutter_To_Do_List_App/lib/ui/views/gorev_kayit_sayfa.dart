import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_list_app/ui/cubit/gorev_kayit_sayfa_cubit.dart';

class GorevKayitSayfa extends StatefulWidget {
  const GorevKayitSayfa({super.key});

  @override
  State<GorevKayitSayfa> createState() => _GorevKayitSayfaState();
}

class _GorevKayitSayfaState extends State<GorevKayitSayfa> {

  var tfgorevad = TextEditingController();
  var tfgorevtarih = TextEditingController();
  var tfgorevsaat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF900000),
      appBar: AppBar(title: const Text("Kayıt",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF5c0a0a),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
        child: SizedBox(width: 300,height: 400,
          child: Card(
            color: Color(0xFF5c0a0a),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(controller: tfgorevad,
                    decoration: const InputDecoration(
                        hintText: "Başlık",
                        hintStyle: TextStyle(color: Color(0xFF5c0a0a),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),),),
                        filled: true,
                        fillColor: Colors.white,
                      icon: Icon(Icons.draw,color: Colors.white,),),
                  ),
                  TextField( controller: tfgorevtarih,decoration: const InputDecoration(
                      hintText: "Tarih",
                      hintStyle: TextStyle(color: Color(0xFF5c0a0a),),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10),),),
                      filled: true,
                      fillColor: Colors.white,
                    icon: Icon(Icons.date_range,color: Colors.white,),
                  ),
                    readOnly: true, // Klavyenin açılmasını engeller
                    onTap: () {
                      showDatePicker(context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000), // Seçilebilecek en erken tarih
                        lastDate: DateTime(2101), // Seçilebilecek en geç tarih
                      ).then((DateTime? selectedDate) {
                        if (selectedDate != null) {
                          // Tarihi formatla (Gün.Ay.Yıl)
                          String formattedDate =
                              "${selectedDate.day.toString().padLeft(2, '0')}"
                              ".${selectedDate.month.toString().padLeft(2, '0')}"
                              ".${selectedDate.year}";
                          tfgorevtarih.text = formattedDate; // TextField'e güncellenmiş tarihi ata
                        }
                      });
                    },
                  ),
                  TextField( controller: tfgorevsaat,
                    decoration: const InputDecoration(
                      hintText: "Saat",
                      hintStyle: TextStyle(color: Color(0xFF5c0a0a),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),),),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.access_time,color: Colors.white,),),
                    readOnly: true,
                    onTap: (){
                      showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      ).then((TimeOfDay? value) {
                        if (value != null) {
                          //ikili gösterim
                          String formattedTime = "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
                          tfgorevsaat.text = formattedTime; // TextField'e güncellenmiş saati ata
                        }
                      });
                    },
                  ),

                  ElevatedButton(onPressed: (){
                    context.read<GorevKayitSayfaCubit>().gorevKaydet(tfgorevad.text, tfgorevtarih.text, tfgorevsaat.text);
                  }, child: const Text("KAYDET" ,style: TextStyle(color: Color(0xFF5c0a0a),),),
                  ),
                ],
              ),
              ),
          ),
        ),
      ),
      ),
    );
  }
}
