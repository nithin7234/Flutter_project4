import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());}
class MyApp extends StatefulWidget{
  const MyApp({super.key});
  @override
  State<MyApp> createState()=>_MyApp();}
class _MyApp extends State<MyApp>{
  final _formkey=GlobalKey<FormState>();
  final _amountcontroller=TextEditingController();
  final _interestcontroller=TextEditingController();
  final _tenurecontroller=TextEditingController();
  String _result="";
  void _calculateEmi(){
    if(_formkey.currentState!.validate()){
      double p=double.tryParse(_amountcontroller.text) ?? 0.0;
      double annualInterest=double.tryParse(_interestcontroller.text) ?? 0.0;
      double r=annualInterest/12/100;
      int n=int.tryParse(_tenurecontroller.text) ?? 0;
      double emi;
      if(r==0){
        emi=p/n;
      }
      else{
        emi=(p*r*(pow(1+r,n)))/(pow(1+r,n)-1);
      }
      double totalInterest=(emi*n)-p;
      setState(() {
        _result="Loan Amount : ₹ ${p.toStringAsFixed(2)}\n EMI Amount : ₹ ${emi.toStringAsFixed(2)} \n Total Interest : ₹ ${totalInterest.toStringAsFixed(2)}";
}
        );
    }
}
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "EMI Calculator App",
      home:Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 242, 225),
        appBar: AppBar(title: Text("EMI Calculator App"),backgroundColor: Color.fromARGB(255, 255, 175, 2),),
        body:Container(
          padding: EdgeInsets.all(20),
          child:Form(
            key:_formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:"Loan Amount",
                    border:OutlineInputBorder()
                  ),
                  validator:(value){
                    if(value==null || value.isEmpty){
                      return "Please enter the loan amount";
                    }
                    if(double.tryParse(value)==null){
                      return "Please enter a valid number";
                    }
                    if(double.tryParse(value)!=null && double.tryParse(value)!<=0){
                      return "Please enter a positive number";
                    }
                    return null;
                  }, ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _interestcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:"Annual Interest rate (%)",
                    border:OutlineInputBorder()
                  ),
                  validator:(value){
                    if(value==null || value.isEmpty){
                      return "Please enter the interest rate";
                    }
                    if(double.tryParse(value)==null){
                      return "Please enter a valid number";
                    }
                    if(double.tryParse(value)!=null && double.tryParse(value)!<=0){
                      return "Please enter a positive number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                TextFormField(
                  controller: _tenurecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:"Loan tenure (Months)",
                    border:OutlineInputBorder()
                  ),
                  validator:(value){
                    if(value==null || value.isEmpty){
                      return "Please enter the loan tenure";
                    }
                    if(double.tryParse(value)==null){
                      return "Please enter a valid number";
                    }
                    if(double.tryParse(value)!=null && double.tryParse(value)!<=0){
                      return "Please enter a positive number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 132, 31),
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0)),
                  onPressed: _calculateEmi,
                  child: Text("Calculate EMI")),
                  SizedBox(height: 10),
 Text(_result,style: TextStyle(color:Colors.green,fontSize: 20,fontWeight:FontWeight.bold))
              ],),
            ),
        ),
      )
    );
  }
}
