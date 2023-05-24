import 'package:flutter/material.dart';

const color1 = Colors.black;
const color2 = Colors.blue;
const color3 = Colors.white;

class ConversionPage extends StatefulWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

String convertCurrencies(
  String currency1,
  String currency2,
  String input,
) {
  double? doubleCurrency1 = double.tryParse(currency1);
  double? doubleCurrency2 = double.tryParse(currency2);
  double? doubleAmount = double.tryParse(input);

  if (doubleCurrency1 != null &&
      doubleCurrency2 != null &&
      doubleAmount != null) {
    double result = doubleAmount * doubleCurrency2 / doubleCurrency1;
    return result.toString();
  } else {
    return 'Invalid input';
  }
}

class _ConversionPageState extends State<ConversionPage> {
  final _inputValueController = TextEditingController();

  String firstCurrencyValue = "1";
  String secondCurrencyValue = "1";
  String convertedResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currencies')),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 300,
              child: TextFormField(
                controller: _inputValueController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan angka',
                ),
              ),
            ),
            const SizedBox(height: 20),
            dropdown1(),
            dropdown2(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  minimumSize: const Size(80, 50),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  setState(
                    () {
                      convertedResult = convertCurrencies(
                        firstCurrencyValue,
                        secondCurrencyValue,
                        _inputValueController.text,
                      );
                    },
                  );
                },
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Hasil : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  convertedResult,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdown1() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 300,
      child: DropdownButtonFormField<String>(
        value: firstCurrencyValue,
        items: dropdownItems,
        iconEnabledColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            firstCurrencyValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: color1,
            ),
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: color2,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget dropdown2() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 300,
      child: DropdownButtonFormField<String>(
        value: secondCurrencyValue,
        items: dropdownItems,
        iconEnabledColor: Colors.white,
        onChanged: (String? newValue) {
          setState(() {
            secondCurrencyValue = newValue!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 3,
              color: color1,
            ),
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: color2,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: '1',
        child: Text("USD"),
      ),
      const DropdownMenuItem(
        value: '14500',
        child: Text("IDR"),
      ),
      const DropdownMenuItem(
        value: '1.24',
        child: Text("GBP"),
      ),
    ];
    return menuItems;
  }
}
