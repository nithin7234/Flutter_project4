import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EMICalculatorApp());
}

class EMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EMI Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EMICalculatorScreen(),
    );
  }
}

class EMICalculatorScreen extends StatefulWidget {
  @override
  _EMICalculatorScreenState createState() => _EMICalculatorScreenState();
}

class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _loanController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  double? emi;
  double? totalInterest;

  void _calculateEMI() {
    if (_formKey.currentState!.validate()) {
      double P = double.parse(_loanController.text);
      double annualRate = double.parse(_rateController.text);
      int N = int.parse(_tenureController.text);

      double R = annualRate / 12 / 100; // Monthly interest rate

      double emiValue =
          (P * R * pow(1 + R, N)) / (pow(1 + R, N) - 1);

      double totalPayment = emiValue * N;
      double interest = totalPayment - P;

      setState(() {
        emi = emiValue;
        totalInterest = interest;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EMI Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _loanController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Loan Amount",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter loan amount";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return "Enter a valid positive number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Annual Interest Rate (%)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter interest rate";
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return "Enter a valid positive number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _tenureController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Loan Tenure (Months)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter loan tenure";
                    }
                    if (int.tryParse(value) == null ||
                        int.parse(value) <= 0) {
                      return "Enter a valid positive integer";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateEMI,
                  child: Text("Calculate EMI"),
                ),
                SizedBox(height: 20),
                if (emi != null && totalInterest != null)
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Results:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text("Loan Amount: ₹${_loanController.text}"),
                          Text("Monthly EMI: ₹${emi!.toStringAsFixed(2)}"),
                          Text("Total Interest: ₹${totalInterest!.toStringAsFixed(2)}"),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
