part of 'character_bloc.dart';

/// Character status enum
enum CharacterStatus {
  initial,
  loading,
  loaded,
  notFound,
  levelUp,
  rankUp,
  error,
}

/// Character state
final class CharacterState extends Equatable {
  const CharacterState._({
    this.status = CharacterStatus.initial,
    this.character,
    this.levelUpAttribute,
    this.levelUpNewLevel,
    this.rankUpNewRank,
    this.errorMessage,
  });

  const CharacterState.initial() : this._();

  const CharacterState.loading() : this._(status: CharacterStatus.loading);

  const CharacterState.loaded(Character character)
      : this._(
          status: CharacterStatus.loaded,
          character: character,
        );

  const CharacterState.notFound() : this._(status: CharacterStatus.notFound);

  const CharacterState.levelUp({
    required Character character,
    required AttributeType attribute,
    required int newLevel,
  }) : this._(
          status: CharacterStatus.levelUp,
          character: character,
          levelUpAttribute: attribute,
          levelUpNewLevel: newLevel,
        );

  const CharacterState.rankUp({
    required Character character,
    required Rank newRank,
  }) : this._(
          status: CharacterStatus.rankUp,
          character: character,
          rankUpNewRank: newRank,
        );

  const CharacterState.error(String message)
      : this._(
          status: CharacterStatus.error,
          errorMessage: message,
        );

  final CharacterStatus status;
  final Character? character;
  final AttributeType? levelUpAttribute;
  final int? levelUpNewLevel;
  final Rank? rankUpNewRank;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        character,
        levelUpAttribute,
        levelUpNewLevel,
        rankUpNewRank,
        errorMessage,
      ];
}
