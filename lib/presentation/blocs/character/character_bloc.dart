import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/attribute_constants.dart';
import '../../../core/constants/rank_constants.dart';
import '../../../domain/entities/character.dart';
import '../../../domain/repositories/character_repository.dart';

part 'character_event.dart';
part 'character_state.dart';

/// Character BLoC for managing character state
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc({
    required CharacterRepository characterRepository,
  })  : _characterRepository = characterRepository,
        super(const CharacterState.initial()) {
    on<CharacterLoadRequested>(_onLoadRequested);
    on<CharacterCreateRequested>(_onCreateRequested);
    on<CharacterXpAdded>(_onXpAdded);
    on<CharacterStreakUpdated>(_onStreakUpdated);
    on<CharacterBuildPathChanged>(_onBuildPathChanged);
    on<CharacterTitleEquipped>(_onTitleEquipped);
    on<_CharacterUpdated>(_onCharacterUpdated);
  }

  void _onCharacterUpdated(
    _CharacterUpdated event,
    Emitter<CharacterState> emit,
  ) {
    emit(CharacterState.loaded(event.character));
  }

  final CharacterRepository _characterRepository;
  StreamSubscription<Character?>? _characterSubscription;

  Future<void> _onLoadRequested(
    CharacterLoadRequested event,
    Emitter<CharacterState> emit,
  ) async {
    emit(const CharacterState.loading());

    try {
      // Cancel existing subscription
      await _characterSubscription?.cancel();

      // First, try to get the character
      final character = await _characterRepository.getCharacter(event.userId);

      if (character == null) {
        emit(const CharacterState.notFound());
        return;
      }

      emit(CharacterState.loaded(character));

      // Then subscribe to updates
      _characterSubscription = _characterRepository
          .watchCharacter(event.userId)
          .listen((character) {
        if (character != null) {
          add(_CharacterUpdated(character));
        }
      });
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }

  Future<void> _onCreateRequested(
    CharacterCreateRequested event,
    Emitter<CharacterState> emit,
  ) async {
    emit(const CharacterState.loading());

    try {
      final character = await _characterRepository.createCharacter(
        userId: event.userId,
        buildPath: event.buildPath,
      );

      emit(CharacterState.loaded(character));

      // Subscribe to updates
      _characterSubscription = _characterRepository
          .watchCharacter(event.userId)
          .listen((character) {
        if (character != null) {
          add(_CharacterUpdated(character));
        }
      });
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }

  Future<void> _onXpAdded(
    CharacterXpAdded event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;
    if (currentState.status != CharacterStatus.loaded) return;

    try {
      final oldCharacter = currentState.character!;
      final oldLevel = oldCharacter.getAttribute(event.attribute).level;
      final oldRank = oldCharacter.rank;

      final updatedCharacter = await _characterRepository.addXp(
        userId: currentState.character!.userId,
        attribute: event.attribute,
        amount: event.amount,
      );

      final newLevel = updatedCharacter.getAttribute(event.attribute).level;
      final newRank = updatedCharacter.rank;

      // Check for level up
      if (newLevel > oldLevel) {
        emit(CharacterState.levelUp(
          character: updatedCharacter,
          attribute: event.attribute,
          newLevel: newLevel,
        ));
      }

      // Check for rank up
      if (newRank.tier > oldRank.tier) {
        emit(CharacterState.rankUp(
          character: updatedCharacter,
          newRank: newRank,
        ));
      }

      emit(CharacterState.loaded(updatedCharacter));
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }

  Future<void> _onStreakUpdated(
    CharacterStreakUpdated event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;
    if (currentState.status != CharacterStatus.loaded) return;

    try {
      final updatedCharacter = await _characterRepository.updateStreak(
        userId: currentState.character!.userId,
        completed: event.completed,
      );

      emit(CharacterState.loaded(updatedCharacter));
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }

  Future<void> _onBuildPathChanged(
    CharacterBuildPathChanged event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;
    if (currentState.status != CharacterStatus.loaded) return;

    try {
      final updatedCharacter = await _characterRepository.changeBuildPath(
        userId: currentState.character!.userId,
        newPath: event.newPath,
      );

      emit(CharacterState.loaded(updatedCharacter));
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }

  Future<void> _onTitleEquipped(
    CharacterTitleEquipped event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;
    if (currentState.status != CharacterStatus.loaded) return;

    try {
      final updatedCharacter = await _characterRepository.equipTitle(
        userId: currentState.character!.userId,
        title: event.title,
      );

      emit(CharacterState.loaded(updatedCharacter));
    } catch (e) {
      emit(CharacterState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _characterSubscription?.cancel();
    return super.close();
  }
}

/// Internal event for character updates from stream
final class _CharacterUpdated extends CharacterEvent {
  const _CharacterUpdated(this.character);

  final Character character;

  @override
  List<Object?> get props => [character];
}
