# Number Input Formatter

A minimalistic and configurable Flutter package for formatting number input in TextField widgets. This package provides seamless number formatting with support for thousands separators, decimal places, and negative numbers without any additional dependencies.

## Attribution

This package is based on and extends the excellent work by [TBR-Group-software/amount_input_formatter](https://github.com/TBR-Group-software/amount_input_formatter). We've enhanced it with improved negative number support and better empty value handling while maintaining the core functionality and design principles of the original package.

## Features

- 🔢 **Configurable decimal places** - Set the number of digits after decimal separator
- 🔄 **Thousands separator** - Automatic grouping with customizable separator (comma, dot, space, etc.)
- ➖ **Negative numbers support** - Optional support for negative values
- 🌍 **Localization friendly** - Customizable decimal and group separators for different locales
- 📱 **Flutter TextField integration** - Works seamlessly with TextEditingController
- ⚡ **Lightweight** - No external dependencies, only Flutter and Dart
- 🎯 **Precise cursor positioning** - Smart cursor placement during formatting

## Installation

Add this package to your `pubspec.yaml`:

### From GitHub (Recommended)

```yaml
dependencies:
  number_input_formatter:
    git:
      url: https://github.com/KunNew/number_input_formatter.git
```

### From local path

```yaml
dependencies:
  number_input_formatter:
    path: /path/to/number_input_formatter
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:number_input_formatter/number_input_formatter.dart';

class MyWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final AmountInputFormatter _formatter = AmountInputFormatter();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      inputFormatters: [_formatter],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Enter amount',
        hintText: '0.000',
      ),
    );
  }
}
```

### Advanced Configuration

```dart
// Currency formatter (2 decimal places)
final currencyFormatter = AmountInputFormatter(
  fractionalDigits: 2,
  groupSeparator: ',',
  decimalSeparator: '.',
);

// European style formatter
final europeanFormatter = AmountInputFormatter(
  fractionalDigits: 2,
  groupSeparator: '.',      // Dot for thousands
  decimalSeparator: ',',    // Comma for decimals
);

// Formatter with negative numbers
final negativeFormatter = AmountInputFormatter(
  fractionalDigits: 2,
  allowNegative: true,
  groupSeparator: ',',
);

// Custom configuration
final customFormatter = AmountInputFormatter(
  integralLength: 10,       // Max 10 digits before decimal
  fractionalDigits: 4,      // 4 decimal places
  groupSeparator: ' ',      // Space as thousand separator
  decimalSeparator: '.',    // Dot as decimal separator
  groupedDigits: 3,         // Group every 3 digits
  allowNegative: true,      // Allow negative numbers
  isEmptyAllowed: true,     // Allow empty input
);
```

### Getting Values

```dart
final formatter = AmountInputFormatter(fractionalDigits: 2);

// Get the numeric value
double value = formatter.doubleValue;

// Get the formatted string
String formatted = formatter.formattedValue;

// Set a value programmatically
formatter.setNumber(1234.56, attachedController: _controller);

// Clear the formatter
formatter.clear();
```

### Real-world Example

```dart
class PriceInputWidget extends StatefulWidget {
  @override
  _PriceInputWidgetState createState() => _PriceInputWidgetState();
}

class _PriceInputWidgetState extends State<PriceInputWidget> {
  final TextEditingController _priceController = TextEditingController();
  final AmountInputFormatter _priceFormatter = AmountInputFormatter(
    fractionalDigits: 2,
    groupSeparator: ',',
    decimalSeparator: '.',
    allowNegative: false,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _priceController,
          inputFormatters: [_priceFormatter],
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Price',
            prefixText: '\$ ',
            hintText: '0.00',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Text('Entered amount: \$${_priceFormatter.doubleValue.toStringAsFixed(2)}'),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Set a predefined value
            _priceFormatter.setNumber(99.99, attachedController: _priceController);
          },
          child: Text('Set \$99.99'),
        ),
      ],
    );
  }
}
```

## Configuration Options

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `integralLength` | `int` | `24` | Maximum digits before decimal separator |
| `fractionalDigits` | `int` | `3` | Number of digits after decimal separator |
| `groupSeparator` | `String` | `','` | Thousands separator character |
| `decimalSeparator` | `String` | `'.'` | Decimal separator character |
| `groupedDigits` | `int` | `3` | Number of digits in each group |
| `allowNegative` | `bool` | `false` | Whether to allow negative numbers |
| `isEmptyAllowed` | `bool` | `false` | Whether empty input is allowed |
| `initialValue` | `num?` | `null` | Initial value to set |

## Localization Examples

### US Format (Default)
```dart
AmountInputFormatter(
  groupSeparator: ',',
  decimalSeparator: '.',
)
// Output: 1,234.56
```

### European Format
```dart
AmountInputFormatter(
  groupSeparator: '.',
  decimalSeparator: ',',
)
// Output: 1.234,56
```

### French Format
```dart
AmountInputFormatter(
  groupSeparator: ' ',
  decimalSeparator: ',',
)
// Output: 1 234,56
```

### Indian Format
```dart
AmountInputFormatter(
  groupSeparator: ',',
  decimalSeparator: '.',
  groupedDigits: 2, // Group by 2 after first 3 digits
)
// Output: 12,34,567.89
```

## Methods

### `AmountInputFormatter` Methods

- `double get doubleValue` - Get the current numeric value
- `String get formattedValue` - Get the formatted string representation
- `String get ltrEnforcedValue` - Get LTR-enforced formatted value for RTL contexts
- `bool get isEmptyAllowed` - Check if empty values are allowed
- `String setNumber(num number, {TextEditingController? attachedController})` - Set a numeric value
- `String clear()` - Clear the formatter

### `NumberFormatter` Methods

The underlying `NumberFormatter` class provides additional low-level formatting capabilities:

- `String? processTextValue({required String textInput})` - Process raw text input
- `String setNumValue(num number)` - Set numeric value without controller
- `String clear()` - Clear formatter data

## RTL Support

For right-to-left languages, use the `ltrEnforcedValue` property to ensure numbers are displayed correctly:

```dart
Text(formatter.ltrEnforcedValue) // Forces LTR display
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.