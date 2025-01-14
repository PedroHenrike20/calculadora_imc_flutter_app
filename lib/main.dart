import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculadora de IMC',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                  controller: weightController,
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return 'Informe o peso!';
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                  controller: heightController,
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return 'Informe a altura!';
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(2)))),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            ),
          )
        ));
  }
}
