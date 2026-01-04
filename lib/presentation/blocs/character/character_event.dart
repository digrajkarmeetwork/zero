part of 'character_bloc.dart';

/// Base class for character events
sealed class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object?> get props => [];
}

/// Load character for user
final class CharacterLoadRequested extends CharacterEvent {
  const CharacterLoadRequested(this.userId);

  final String userId;

  @override
  List<Object?> get props => [userId];
}

/// Create new character
final class CharacterCreateRequested extends CharacterEvent {
  const CharacterCreateRequested({
    required this.userId,
    required this.buildPath,
  });

  final String userId;
  final BuildPath buildPath;

  @override
  List<Object?> get props => [userId, buildPath];
}

/// Add XP to an attribute
final class CharacterXpAdded extends CharacterEvent {
  const CharacterXpAdded({
    required this.attribute,
    required this.amount,
  });

  final AttributeType attribute;
  final int amount;

  @override
  List<Object?> get props => [attribute, amount];
}

/// Update streak
final class CharacterStreakUpdated extends CharacterEvent {
  const CharacterStreakUpdated({required this.completed});

  final bool completed;

  @override
  List<Object?> get props => [completed];
}

/// Change build path
final class CharacterBuildPathChanged extends CharacterEvent {
  const CharacterBuildPathChanged(this.newPath);

  final BuildPath newPath;

  @override
  List<Object?> get props => [newPath];
}

/// Equip title
final class CharacterTitleEquipped extends CharacterEvent {
  const CharacterTitleEquipped(this.title);

  final String? title;

  @override
  List<Object?> get props => [title];
}
