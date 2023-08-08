// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CostProject _$CostProjectFromJson(Map<String, dynamic> json) => CostProject(
      json['ID'] as String,
      json['Name'] as String,
      $enumDecodeNullable(_$CurrencyEnumMap, json['Currency']),
      (json['Transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['Members'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CostProjectToJson(CostProject instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'Currency': _$CurrencyEnumMap[instance.currency],
      'Transactions': instance.costElements,
      'Members': instance.members,
    };

const _$CurrencyEnumMap = {
  Currency.euro: 'euro',
  Currency.dollar: 'dollar',
};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['ID'] as String,
      json['Name'] as String,
      $enumDecode(_$CostTypeEnumMap, json['TransactionType']),
      (json['Amount'] as num).toDouble(),
      json['SourceID'] as String,
      (json['TargetIDs'] as List<dynamic>).map((e) => e as String).toList(),
      json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'TransactionType': _$CostTypeEnumMap[instance.transactionType]!,
      'Amount': instance.amount,
      'SourceID': instance.source,
      'TargetIDs': instance.targets,
      'creationDate': instance.creationDate?.toIso8601String(),
    };

const _$CostTypeEnumMap = {
  CostType.expense: 'Expense',
  CostType.transfer: 'Transfer',
};
