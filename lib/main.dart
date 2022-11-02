import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerHeight = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();

  String _calculationIMC() {
    double height = double.parse(controllerHeight.value.text);
    double weight = double.parse(controllerWeight.value.text);

    double calHeight = height * height;
    double imc = weight / calHeight;

    return imc.toStringAsFixed(1);
  }

  String result() {
    double value = double.parse(_calculationIMC());

    if (value <= 18.5) {
      return "Magreza";
    } else if (value >= 18.5 && value <= 24.9) {
      return "Saudável";
    } else if (value >= 25 && value <= 29.9) {
      return "Sobrepeso";
    } else if (value >= 30 && value <= 34.9) {
      return "Obesidade grau l";
    } else if (value >= 35 && value <= 39.9) {
      return "Obesidade grau ll (severa)";
    } else {
      return "Obesidade grau lll (morbida)";
    }
  }

  Color getColor() {
    double value = double.parse(_calculationIMC());

    if (value <= 18.5) {
      return Colors.grey;
    } else if (value > 18.5 && value <= 24.9) {
      return Colors.green.shade700;
    } else if (value > 25 && value <= 29.9) {
      return Colors.yellow.shade700;
    } else if (value > 30 && value <= 34.9) {
      return Colors.orange;
    } else if (value > 35 && value <= 39.9) {
      return Colors.red;
    } else {
      return Colors.red.shade700;
    }
  }

  _textForm(TextEditingController controller, String labelText, String hintText,
      IconData icon) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
      ],
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        icon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  _calculateButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen,
          fixedSize: Size(MediaQuery.of(context).size.width, 15)),
      child: const Text('Calcular IMC'),
      onPressed: () {
        _calculationIMC();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result(),
                        style: TextStyle(
                            color: getColor(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 18),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Seu IMC é de ',
                          ),
                          TextSpan(
                              text: '${_calculationIMC().toString()} kg/m2',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.network(
                      'https://4.bp.blogspot.com/-IEL20wwGL88/UWmoZKkMGJI/AAAAAAAAAS4/B6nEn1ioQS4/s1600/imc+(1).png',
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.height / 1.5,
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Calculadora de IMC',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  _textForm(controllerHeight, 'Altura', 'Digite a sua altura',
                      Icons.accessibility),
                  const SizedBox(height: 10),
                  _textForm(controllerWeight, 'Peso', 'Digite o seu peso',
                      Icons.balance),
                  const SizedBox(height: 10),
                  _calculateButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: _body(),
    );
  }
}
