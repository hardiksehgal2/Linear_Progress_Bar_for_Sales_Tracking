/// ParameterName : "New Counter"
/// ParameterValues : {"MinValue":1.00,"MaxValue":10.00,"ActualValue":3.00}
class BonnApi {
  BonnApi({
    String? parameterName,
    ParameterValues? parameterValues,}){
    _parameterName = parameterName;
    _parameterValues = parameterValues;
  }

  BonnApi.fromJson(dynamic json) {
    _parameterName = json['ParameterName'];
    _parameterValues = json['ParameterValues'] != null ? ParameterValues.fromJson(json['ParameterValues']) : null;
  }
  String? _parameterName;
  ParameterValues? _parameterValues;
  BonnApi copyWith({  String? parameterName,
    ParameterValues? parameterValues,
  }) => BonnApi(  parameterName: parameterName ?? _parameterName,
    parameterValues: parameterValues ?? _parameterValues,
  );
  String? get parameterName => _parameterName;
  ParameterValues? get parameterValues => _parameterValues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ParameterName'] = _parameterName;
    if (_parameterValues != null) {
      map['ParameterValues'] = _parameterValues?.toJson();
    }
    return map;
  }

}

/// MinValue : 1.00
/// MaxValue : 10.00
/// ActualValue : 3.00

class ParameterValues {
  ParameterValues({
    num? minValue,
    num? maxValue,
    num? actualValue,}){
    _minValue = minValue;
    _maxValue = maxValue;
    _actualValue = actualValue;
  }

  ParameterValues.fromJson(dynamic json) {
    _minValue = json['MinValue'];
    _maxValue = json['MaxValue'];
    _actualValue = json['ActualValue'];
  }
  num? _minValue;
  num? _maxValue;
  num? _actualValue;
  ParameterValues copyWith({  num? minValue,
    num? maxValue,
    num? actualValue,
  }) => ParameterValues(  minValue: minValue ?? _minValue,
    maxValue: maxValue ?? _maxValue,
    actualValue: actualValue ?? _actualValue,
  );
  num? get minValue => _minValue;
  num? get maxValue => _maxValue;
  num? get actualValue => _actualValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MinValue'] = _minValue;
    map['MaxValue'] = _maxValue;
    map['ActualValue'] = _actualValue;
    return map;
  }

}
