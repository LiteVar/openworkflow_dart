// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FunctionItem _$FunctionItemFromJson(Map<String, dynamic> json) => FunctionItem(
      function: json['function'] as String,
      description: json['description'] as String?,
      arguments: json['arguments'] as Map<String, dynamic>,
      results: json['results'] as Map<String, dynamic>,
      next: json['next'] as String,
    );

Map<String, dynamic> _$FunctionItemToJson(FunctionItem instance) =>
    <String, dynamic>{
      'function': instance.function,
      'description': instance.description,
      'arguments': instance.arguments,
      'results': instance.results,
      'next': instance.next,
    };
