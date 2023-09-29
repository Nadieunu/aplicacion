import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Promedio de Calificaciones',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AverageCalculator(),
    );
  }
}

class AverageCalculator extends StatefulWidget {
  @override
  _AverageCalculatorState createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  List<double> averages = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadAverages();
  }

  Future<void> loadAverages() async {
    prefs = await SharedPreferences.getInstance();
    List<String> storedAverages = prefs.getStringList('averages') ?? [];
    setState(() {
      averages =
          storedAverages.map((average) => double.parse(average)).toList();
    });
  }

  Future<void> saveAverages() async {
    List<String> averageStrings =
        averages.map((average) => average.toString()).toList();
    await prefs.setStringList('averages', averageStrings);
  }

  void calculateAverage() {
    double calification1 = double.tryParse(controller1.text) ?? 0.0;
    double calification2 = double.tryParse(controller2.text) ?? 0.0;
    double calification3 = double.tryParse(controller3.text) ?? 0.0;

    double sum = calification1 + calification2 + calification3;
    double calculatedAverage = sum / 3;

    setState(() {
      averages.add(calculatedAverage);
    });

    // Guardar los promedios en las preferencias
    saveAverages();

    // Limpiar los campos de entrada
    controller1.clear();
    controller2.clear();
    controller3.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Promedio de Calificaciones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ingrese las tres calificaciones:',
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: controller1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Calificación 1'),
                  ),
                  TextField(
                    controller: controller2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Calificación 2'),
                  ),
                  TextField(
                    controller: controller3,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Calificación 3'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateAverage,
              child: Text('Calcular Promedio'),
            ),
            SizedBox(height: 20),
            Text(
              'Promedios calculados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children:
                  averages.map((average) => Text(average.toString())).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
