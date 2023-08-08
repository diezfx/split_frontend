import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pkg/user/user.dart';

part 'expenses.g.dart';

const uuid = Uuid();

@JsonSerializable()
class CostProject extends Equatable {
  @JsonKey(name: 'ID')
  final String id;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Currency')
  final Currency? currency;

  @JsonKey(name: 'Transactions')
  final List<Transaction> costElements;
  @JsonKey(name: 'Members')
  final List<String> members;

  const CostProject(
      this.id, this.name, this.currency, this.costElements, this.members);

  CostProject copyWith(
      {String? newName, List<Transaction>? elements, List<String>? members}) {
    return CostProject(id, newName ?? name, currency, elements ?? costElements,
        members ?? this.members);
  }

  static String getRandomId() {
    return uuid.v4();
  }

  @override
  List<Object?> get props => [costElements];

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory CostProject.fromJson(Map<String, dynamic> json) =>
      _$CostProjectFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CostProjectToJson(this);
}

enum CostType {
  @JsonValue("Expense")
  expense, // a user pays for something
  @JsonValue("Transfer")
  transfer, // one user transfers money to another one
}

enum Currency {
  euro,
  dollar,
}

@JsonSerializable()
class Transaction extends Equatable {
  @JsonKey(name: 'ID')
  final String id;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'TransactionType')
  final CostType transactionType;

  @JsonKey(name: 'Amount')
  final double amount;
  @JsonKey(name: 'SourceID')
  final UserId source;
  @JsonKey(name: 'TargetIDs')
  final List<UserId> targets;
  @JsonKey(name: 'creationDate')
  final DateTime? creationDate;

  const Transaction(this.id, this.name, this.transactionType, this.amount,
      this.source, this.targets, this.creationDate);

  @override
  List<Object?> get props => [name, transactionType, source, targets];

  static String getRandomId() {
    return uuid.v4();
  }

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
