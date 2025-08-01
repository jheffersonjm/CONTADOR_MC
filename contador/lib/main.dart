import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Calculadora de IMC')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: IMCCalculadora(
            pesoController: pesoController,
            alturaController: alturaController,
          ),
        ),
      ),
    );
  }
}

class IMCCalculadora extends StatefulWidget {
  final TextEditingController pesoController;
  final TextEditingController alturaController;

  IMCCalculadora({
    required this.pesoController,
    required this.alturaController,
  });

  @override
  _IMCCalculadoraState createState() => _IMCCalculadoraState();
}

class _IMCCalculadoraState extends State<IMCCalculadora> {
  String resultado = '';

  void calcularIMC() {
    double? peso = double.tryParse(widget.pesoController.text);
    double? altura = double.tryParse(widget.alturaController.text);

    if (peso == null || altura == null || altura == 0) {
      setState(() {
        resultado = 'Peso ou altura inválidos.';
      });
      return;
    }

    double imc = peso / (altura * altura);
    String classificacao = '';

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
    } else if (imc < 25) {
      classificacao = 'Peso normal';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else if (imc < 35) {
      classificacao = 'Obesidade grau I';
    } else if (imc < 40) {
      classificacao = 'Obesidade grau II';
    } else {
      classificacao = 'Obesidade grau III';
    }

    setState(() {
      resultado = 'IMC: ${imc.toStringAsFixed(2)}\n$classificacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.pesoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Insira o peso (kg)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: widget.alturaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Insira a altura (m)',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: calcularIMC,
          child: Text('Calcular IMC'),
        ),
        SizedBox(height: 16),
        Text(
          resultado,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
