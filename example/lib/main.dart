import 'package:flutter/material.dart';
import 'package:number_input_formatter/number_input_formatter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Input Formatter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Number Input Formatter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _basicController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _customController = TextEditingController();
  final TextEditingController _negativeController = TextEditingController();

  late final AmountInputFormatter _basicFormatter;
  late final AmountInputFormatter _currencyFormatter;
  late final AmountInputFormatter _customFormatter;
  late final AmountInputFormatter _negativeFormatter;

  @override
  void initState() {
    super.initState();
    
    // Basic formatter with default settings
    _basicFormatter = AmountInputFormatter();
    
    // Currency formatter (2 decimal places, comma separator)
    _currencyFormatter = AmountInputFormatter(
      fractionalDigits: 2,
      groupSeparator: ',',
      decimalSeparator: '.',
    );
    
    // Custom formatter (European style: dot as thousand separator, comma as decimal)
    _customFormatter = AmountInputFormatter(
      fractionalDigits: 2,
      groupSeparator: '.',
      decimalSeparator: ',',
      groupedDigits: 3,
    );
    
    // Formatter that allows negative numbers
    _negativeFormatter = AmountInputFormatter(
      fractionalDigits: 2,
      allowNegative: true,
      groupSeparator: ',',
    );
  }

  @override
  void dispose() {
    _basicController.dispose();
    _currencyController.dispose();
    _customController.dispose();
    _negativeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Number Input Formatter Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Basic Example
            _buildExample(
              title: 'Basic Formatter',
              description: 'Default settings: 3 decimal places, comma thousand separator',
              controller: _basicController,
              formatter: _basicFormatter,
              value: _basicFormatter.doubleValue,
            ),
            
            const SizedBox(height: 20),
            
            // Currency Example
            _buildExample(
              title: 'Currency Formatter',
              description: '2 decimal places, perfect for currency input',
              controller: _currencyController,
              formatter: _currencyFormatter,
              value: _currencyFormatter.doubleValue,
            ),
            
            const SizedBox(height: 20),
            
            // Custom Example
            _buildExample(
              title: 'European Style Formatter',
              description: 'Dot as thousand separator, comma as decimal separator',
              controller: _customController,
              formatter: _customFormatter,
              value: _customFormatter.doubleValue,
            ),
            
            const SizedBox(height: 20),
            
            // Negative Example
            _buildExample(
              title: 'Negative Numbers Allowed',
              description: 'Supports both positive and negative numbers',
              controller: _negativeController,
              formatter: _negativeFormatter,
              value: _negativeFormatter.doubleValue,
            ),
            
            const SizedBox(height: 30),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _currencyFormatter.setNumber(1234.56, attachedController: _currencyController);
                    setState(() {});
                  },
                  child: const Text('Set \$1,234.56'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _negativeFormatter.setNumber(-9876.54, attachedController: _negativeController);
                    setState(() {});
                  },
                  child: const Text('Set -\$9,876.54'),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                _basicController.clear();
                _currencyController.clear();
                _customController.clear();
                _negativeController.clear();
                setState(() {});
              },
              child: const Text('Clear All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExample({
    required String title,
    required String description,
    required TextEditingController controller,
    required AmountInputFormatter formatter,
    required double value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              inputFormatters: [formatter],
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter amount',
                hintText: '0.00',
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Text(
              'Formatted: ${formatter.formattedValue}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Double value: $value',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}