import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum Sex {
  @JsonValue(1)
  male,
  @JsonValue(2)
  female,
}
