import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/attribute_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/character/character_bloc.dart';
import '../../widgets/common/zero_button.dart';
import '../../widgets/common/zero_card.dart';

/// Character creation screen
class CharacterCreationScreen extends StatefulWidget {
  const CharacterCreationScreen({super.key});

  @override
  State<CharacterCreationScreen> createState() =>
      _CharacterCreationScreenState();
}

class _CharacterCreationScreenState extends State<CharacterCreationScreen> {
  BuildPath? _selectedPath;
  bool _isCreating = false;

  void _createCharacter() {
    if (_selectedPath == null) return;

    final userId = context.read<AuthBloc>().state.user.id;
    setState(() => _isCreating = true);

    context.read<CharacterBloc>().add(
          CharacterCreateRequested(
            userId: userId,
            buildPath: _selectedPath!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharacterBloc, CharacterState>(
      listener: (context, state) {
        if (state.status == CharacterStatus.loaded) {
          context.go(AppRoutes.home);
        } else if (state.status == CharacterStatus.error) {
          setState(() => _isCreating = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Failed to create character'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // Title
                Text(
                  'Choose Your Path',
                  style: AppTypography.displaySmall,
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: -0.2, end: 0),

                const SizedBox(height: 8),

                Text(
                  'Focus on what matters most to you.\nYou can change this later.',
                  style: AppTypography.bodyMedium,
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 300.ms, delay: 100.ms),

                const SizedBox(height: 32),

                // Build paths
                ...BuildPath.values.asMap().entries.map((entry) {
                  final index = entry.key;
                  final path = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _BuildPathCard(
                      path: path,
                      isSelected: _selectedPath == path,
                      onTap: () {
                        setState(() {
                          _selectedPath = path;
                        });
                      },
                    )
                        .animate()
                        .fadeIn(
                          duration: 300.ms,
                          delay: Duration(milliseconds: 150 + (index * 50)),
                        )
                        .slideX(begin: 0.1, end: 0),
                  );
                }),

                const SizedBox(height: 32),

                // Info text
                if (_selectedPath != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AttributeColors.forAttribute(
                              _selectedPath!.primaryAttribute)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AttributeColors.forAttribute(
                                _selectedPath!.primaryAttribute)
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AttributeColors.forAttribute(
                              _selectedPath!.primaryAttribute),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${_selectedPath!.displayName}s earn +20% XP in ${_selectedPath!.primaryAttribute.displayName}',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 200.ms),

                const SizedBox(height: 32),

                // Create button
                ZeroButton(
                  onPressed: _selectedPath == null || _isCreating
                      ? null
                      : _createCharacter,
                  label: 'Begin Journey',
                  isLoading: _isCreating,
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildPathCard extends StatelessWidget {
  const _BuildPathCard({
    required this.path,
    required this.isSelected,
    required this.onTap,
  });

  final BuildPath path;
  final bool isSelected;
  final VoidCallback onTap;

  IconData get _pathIcon {
    switch (path) {
      case BuildPath.warrior:
        return Icons.fitness_center;
      case BuildPath.scholar:
        return Icons.menu_book;
      case BuildPath.merchant:
        return Icons.account_balance_wallet;
      case BuildPath.phantom:
        return Icons.speed;
      case BuildPath.diplomat:
        return Icons.people;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AttributeColors.forAttribute(path.primaryAttribute);

    return ZeroCard(
      onTap: onTap,
      isHighlighted: isSelected,
      highlightColor: color,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              _pathIcon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  path.displayName,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  path.tagline,
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Focus: ${path.primaryAttribute.displayName} (+20%)',
                  style: AppTypography.labelSmall.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),

          // Selection indicator
          if (isSelected)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.backgroundPrimary,
                size: 16,
              ),
            )
          else
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.border,
                  width: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
