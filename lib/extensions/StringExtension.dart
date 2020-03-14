
extension StringExtension on String {

  bool get isBlank => this == '' || this == null;

  bool get isNotBlank => !this.isBlank;

  static String empty() => '';
}