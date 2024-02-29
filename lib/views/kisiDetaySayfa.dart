import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisileruygulamasi_blocpatern/cubit/kisiDetay_cubit.dart';
import 'package:kisileruygulamasi_blocpatern/entity/kisiler.dart';
import 'package:kisileruygulamasi_blocpatern/views/anasayfa.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;


  KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();
  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAd.text=kisi.kisi_ad;
    tfKisiTel.text=kisi.kisi_tel;
  }

  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel) async {
    print("Kişi Güncelle : $kisi_id - $kisi_ad - $kisi_tel");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kişi Detay"),),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(controller: tfKisiAd, decoration: const InputDecoration(hintText: "Kişi Ad"),
            ),
            TextField(controller: tfKisiTel, decoration: const InputDecoration(hintText: "Kişi Tel"),),
            ElevatedButton(onPressed: (){
              context.read<KisiDetayCubit>().guncelle(widget.kisi.kisi_id, tfKisiAd.text, tfKisiTel.text);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Anasayfa()));
            }, child: const Text("GÜNCELLE"),)
          ],
        ),
      ),
    );
  }
}

