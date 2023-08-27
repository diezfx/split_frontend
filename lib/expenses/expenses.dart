import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pkg/user/user.dart';

part 'expenses.g.dart';

const uuid = Uuid();

@JsonSerializable()
class CostProject extends Equatable {
  final String id;
  final String name;
  final Currency? currency;

  @JsonKey(name: 'transactions')
  final List<Transaction> costElements;
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
  final String id;
  final String name;
  final CostType transactionType;

  final double amount;
  @JsonKey(name: 'sourceId')
  final UserId source;
  @JsonKey(name: 'targetIds')
  final List<UserId> targets;
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
