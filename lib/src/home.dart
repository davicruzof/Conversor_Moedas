import 'package:flutter/material.dart';
import 'requests/request.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController realController =  TextEditingController();
  TextEditingController euroController =  TextEditingController();
  TextEditingController dolarController =  TextEditingController();
  TextEditingController bitController =  TextEditingController();

  double dolar;
  double euro;
  double bit;

  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    bitController.text = "";
  }


  void _realChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    bitController.text = (real/bit).toStringAsFixed(2);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    bitController.text = (dolar * this.dolar / bit).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    bitController.text = (euro * this.euro / bit).toStringAsFixed(2);
  }

  void _bitChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double bit = double.parse(text);
    realController.text = (bit * this.bit).toStringAsFixed(2);
    dolarController.text = (bit * this.bit / dolar).toStringAsFixed(2);
    euroController.text = (bit * this.bit / euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Icon(Icons.attach_money,size: 30,),
              ),
              Container(
                  padding: EdgeInsets.only(top: 15,right: 70),
                  child: Text(
                    "Conversor de Moedas",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ),
            ],
          ),
        ],
        //title: Text("Conversor Moedas"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                   child: Text(
                     "Carregando Dados ...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                      ),
                     textAlign: TextAlign.center,
                   ),
                );
              default:
                if(snapshot.hasError){
                  return Center(
                    child: Text(
                      "Erro ao carregar da dos ...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }else{
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  bit = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                  print("$dolar");
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(top:50,right: 10,left: 10),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        buildTextFild("Reais", "R\$",realController,_realChanged),
                        Divider(),
                        buildTextFild("Dolares", "US\$",dolarController,_dolarChanged),
                        Divider(),
                        buildTextFild("Euros", "EU\$",euroController,_euroChanged),
                        Divider(),
                        buildTextFild("BitCoin", "BT\$",bitController,_bitChanged),
                      ],
                    ),
                  );
                }
            }
          }
      ),
    );
  }
}

Widget buildTextFild(String label, String prefixo,TextEditingController control,Function f){
    return TextField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.amber,
            fontSize: 20,
          ),
          prefixText: prefixo,
      ),
      style: TextStyle(
        color: Colors.amber,
        fontSize: 20.0,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      controller: control,
      onChanged: f,
    );
}

