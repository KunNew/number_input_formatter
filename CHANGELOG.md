# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-XX

### Added
- Initial release of number_input_formatter package
- `AmountInputFormatter` class for TextField integration
- `NumberFormatter` class for low-level number formatting
- Support for configurable decimal places (fractionalDigits)
- Support for thousands separator with customizable character and grouping
- Support for negative numbers (optional)
- Support for different locales with customizable decimal and group separators
- Smart cursor positioning during text formatting
- RTL language support with LTR enforcement
- Comprehensive example app demonstrating various use cases
- Support for programmatic value setting with `setNumber()` method
- Support for clearing formatter data with `clear()` method

### Features
- **Configurable Parameters:**
  - `integralLength`: Maximum digits before decimal (default: 24)
  - `fractionalDigits`: Decimal places (default: 3)
  - `groupSeparator`: Thousands separator (default: ',')
  - `decimalSeparator`: Decimal separator (default: '.')
  - `groupedDigits`: Digits per group (default: 3)
  - `allowNegative`: Enable negative numbers (default: false)
  - `isEmptyAllowed`: Allow empty input (default: false)
  - `initialValue`: Set initial value (default: null)

- **Localization Support:**
  - US format: 1,234.56
  - European format: 1.234,56
  - French format: 1 234,56
  - Indian format: 12,34,567.89

- **Integration Features:**
  - Seamless TextField integration
  - TextEditingController synchronization
  - Real-time value access via `doubleValue` property
  - Formatted string access via `formattedValue` property

### Documentation
- Comprehensive README with usage examples
- API documentation with parameter descriptions
- Example app with multiple formatter configurations
- Localization examples for different regions