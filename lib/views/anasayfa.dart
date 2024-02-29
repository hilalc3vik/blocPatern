import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisileruygulamasi_blocpatern/cubit/anasayfa_cubit.dart';
import 'package:kisileruygulamasi_blocpatern/entity/kisiler.dart';
import 'package:kisileruygulamasi_blocpatern/views/kisiDetaySayfa.dart';
import 'package:kisileruygulamasi_blocpatern/views/kisiKayitSayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu= false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
            TextField(decoration: const InputDecoration(hintText: "Ara"),
            onChanged: (aramaSonucu){
              context.read<AnasayfaCubit>().ara(aramaSonucu);
            },
            )
              : const Text("Kişiler"),
      actions: [
        aramaYapiliyorMu ?
        IconButton(onPressed: (){
          setState(() { aramaYapiliyorMu=false;          });
          context.read<AnasayfaCubit>().kisileriYukle();
        }, icon: const Icon(Icons.cancel)) :
        IconButton(onPressed: (){
          setState(() { aramaYapiliyorMu=true;          });
        }, icon: const Icon(Icons.search)),
      ],),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
                itemCount: kisilerListesi.length,
                itemBuilder: (context,index){
                  var kisi = kisilerListesi[index];
                  return GestureDetector(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>  KisiDetaySayfa(kisi: kisi)))
                        .then((value){ context.read<AnasayfaCubit>().kisileriYukle(); });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("${kisi.kisi_ad} - ${kisi.kisi_tel}"),
                            const Spacer(),
                            IconButton(onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("${kisi.kisi_ad} silinsin mi?"),
                              action: SnackBarAction(
                              label: "EVET",
                              onPressed: (){
                                context.read<AnasayfaCubit>().sil(kisi.kisi_id);
                                },
                                ),
                                ),
                              );
                            }, icon: const Icon(Icons.delete_outline)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const KisiKayitSayfa()))
            .then((value){ context.read<AnasayfaCubit>().kisileriYukle(); });
          //var kisi = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "51656651");
         // Navigator.push(context, MaterialPageRoute(builder: (context)=>  KisiDetaySayfa(kisi: kisi)))
         //  .then((value){ print("Anasayfaya Dönüldü"); });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

