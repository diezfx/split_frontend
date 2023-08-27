// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CostProject _$CostProjectFromJson(Map<String, dynamic> json) => CostProject(
      json['id'] as String,
      json['name'] as String,
      $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
      (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['members'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CostProjectToJson(CostProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currency': _$CurrencyEnumMap[instance.currency],
      'transactions': instance.costElements,
      'members': instance.members,
    };

const _$CurrencyEnumMap = {
  Currency.euro: 'euro',
  Currency.dollar: 'dollar',
};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['id'] as String,
      json['name'] as String,
      $enumDecode(_$CostTypeEnumMap, json['transactionType']),
      (json['amount'] as num).toDouble(),
      json['sourceId'] as String,
      (json['targetIds'] as List<dynamic>).map((e) => e as String).toList(),
      json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'transactionType': _$CostTypeEnumMap[instance.transactionType]!,
      'amount': instance.amount,
      'sourceId': instance.source,
      'targetIds': instance.targets,
      'creationDate': instance.creationDate?.toIso8601String(),
    };

const _$CostTypeEnumMap = {
  CostType.expense: 'Expense',
  CostType.transfer: 'Transfer',
};
