import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discount Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // المتغيرات
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  
  double finalPrice = 0.0;
  double savedAmount = 0.0;
  
  // دالة الحساب
  void calculatePrice() {
    double price = double.tryParse(priceController.text) ?? 0;
    double discount = double.tryParse(discountController.text) ?? 0;
    double tax = double.tryParse(taxController.text) ?? 0;
    
    // حساب السعر بعد الخصم
    double priceAfterDiscount = price - (price * discount / 100);
    
    // حساب الضريبة
    double taxAmount = priceAfterDiscount * tax / 100;
    
    // السعر النهائي
    setState(() {
      finalPrice = priceAfterDiscount + taxAmount;
      savedAmount = price * discount / 100;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discount & Tax Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // أيقونة
            Icon(
              Icons.shopping_cart,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 30),
            
            // حقل السعر الأصلي
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Original Price (\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 15),
            
            // حقل الخصم
            TextField(
              controller: discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Discount (%)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_offer),
              ),
            ),
            SizedBox(height: 15),
            
            // حقل الضريبة
            TextField(
              controller: taxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tax (%)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.receipt),
              ),
            ),
            SizedBox(height: 25),
            
            // زر الحساب
            ElevatedButton(
              onPressed: calculatePrice,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Calculate',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 30),
            
            // النتائج
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Results',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(height: 30),
                    
                    ResultRow(
                      label: 'You Save:',
                      value: '\$${savedAmount.toStringAsFixed(2)}',
                      color: Colors.green,
                    ),
                    SizedBox(height: 10),
                    
                    ResultRow(
                      label: 'Final Price:',
                      value: '\$${finalPrice.toStringAsFixed(2)}',
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget للنتائج
class ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  
  ResultRow({required this.label, required this.value, required this.color});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}