extension StringExtension on String {
  String getNameFromEnum() {
    if (!contains(".")) return this;
    return replaceRange(0, indexOf(".") + 1, "");
  }

  bool containsIgnoreCase(String other) {
    return this.toLowerCase().contains(other.toLowerCase());
  }
}

extension CollectionExtension<E> on Iterable<E> {
  List<T> mapToList<T>(T Function(E) transform) => map(transform).toList();
}

/// - [isNullOrEmpty], [isNullEmptyOrFalse] are from [this StackOverflow answer](https://stackoverflow.com/a/59826129/10830091)
extension GeneralUtilsObjectExtension on Object? {
  /// Returns true if object is:
  /// - null `Object`
  bool get isNull => this == null;

  /// Returns true if object is NOT:
  /// - null `Object`
  bool get isNotNull => this != null;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  bool get isNullOrEmpty => isNull || _isStringObjectEmpty || _isIterableObjectEmpty;

  /// Returns true if object is NOT:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  bool get isNotNullNorEmpty => isNotNull && !_isStringObjectEmpty && !_isIterableObjectEmpty;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  /// - false `bool`
  bool get isNullEmptyOrFalse => isNull || _isStringObjectEmpty || _isIterableObjectEmpty || _isBoolObjectFalse;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  /// - false `bool`
  /// - zero `num`
  bool get isNullEmptyFalseOrZero =>
      isNull || _isStringObjectEmpty || _isIterableObjectEmpty || _isBoolObjectFalse || _isNumObjectZero;

  // ------- PRIVATE EXTENSION HELPERS -------
  /// **Private helper**
  ///
  /// If `String` object, return String's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `String`
  bool get _isStringObjectEmpty => (this is String) ? (this as String).isEmpty : false;

  /// **Private helper**
  ///
  /// If `Iterable` object, return Iterable's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `Iterable`
  bool get _isIterableObjectEmpty => (this is Iterable) ? (this as Iterable).isEmpty : false;

  /// **Private helper**
  ///
  /// If `bool` object, return `isFalse` expression
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `bool`
  bool get _isBoolObjectFalse => (this is bool) ? (this as bool?) == false : false;

  /// **Private helper**
  ///
  /// If `num` object, return `isZero` expression
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `num`
  bool get _isNumObjectZero => (this is num) ? (this as num?) == 0 : false;
}
