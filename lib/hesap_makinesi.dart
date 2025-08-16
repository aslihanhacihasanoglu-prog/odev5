import 'package:flutter/material.dart';

class HesapMakinesi extends StatefulWidget {
  const HesapMakinesi({super.key});

  @override
  State<HesapMakinesi> createState() => _HesapMakinesiState();
}

class _HesapMakinesiState extends State<HesapMakinesi> {

  double _sonuc = 0;

  bool _yeniDeger = false;

  final TextEditingController _textEditingControllerSayi1 = TextEditingController();
  final TextEditingController _textEditingControllerSayi2 = TextEditingController();

  TextEditingController? activeController;

  final buttons = [
    "7", "8", "9", "C",
    "4", "5", "6", "+",
    "1", "2", "3", "=",
    "0"
  ];


  void _onButtonClick(String value){
      setState(() {
          if(value == "C")
          {
            _textEditingControllerSayi1.clear();
            _textEditingControllerSayi2.clear();

            _sonuc=0;
            _yeniDeger=false;

          }else if(value == "=")
          {
            _sonuc = (double.tryParse(_textEditingControllerSayi1.text)!) + (double.tryParse(_textEditingControllerSayi2.text)!);

          }else if(value == "+"){

            _yeniDeger = true;

          }else{

            activeController!.text +=value;

        }
      }
      );
  }

@override
  void dispose() {
    _textEditingControllerSayi1.dispose();
    _textEditingControllerSayi2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("Hesap Makinesi"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: TextField(

                  controller:_textEditingControllerSayi1,
                  decoration: const InputDecoration(hintText: "İlk sayıyı giriniz.."),
                  readOnly: true,
                  showCursor: true,
                onTap: (){
                    setState(() {
                      activeController = _textEditingControllerSayi1;
                    });
                },

                  ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: TextField(

                    controller:_textEditingControllerSayi2,
                    decoration: const InputDecoration(hintText: "İkinci sayıyı giriniz.."),
                    readOnly: true,
                    showCursor: true,
                    onTap:(){

                      setState(() {
                        activeController = _textEditingControllerSayi2;
                      });
                    } ,

                   ),
            ),

          Text("Sonuç: ${_sonuc}"),


    GridView.builder(
          shrinkWrap: true,
          itemCount: buttons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.5,
        ),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => _onButtonClick(buttons[index]),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                  child: Text(
                      buttons[index],
                      style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          }
        ),
       ]
      ),
    );
  }
}
