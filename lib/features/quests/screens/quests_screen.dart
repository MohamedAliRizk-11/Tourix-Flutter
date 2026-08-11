import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/selectable_chip.dart';
import '../cubit/quests_cubit.dart';
import '../cubit/quests_state.dart';
import '../widgets/quest_card.dart';

class QuestsScreen extends StatelessWidget {
  const QuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuestsCubit()..loadQuests(),
      child: const _QuestsView(),
    );
  }
}

class _QuestsView extends StatelessWidget {
  const _QuestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(),
      body: BlocBuilder<QuestsCubit, QuestsState>(
        builder: (context, state) {
          if (state is QuestsLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is QuestsError)
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          final loaded = state as QuestsLoaded;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              Text('Expedition Types', style: AppTextStyles.displayMedium),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: loaded.questTypes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final type = loaded.questTypes[i];
                    return SelectableChip(
                      label: type,
                      isSelected: type == loaded.selectedType,
                      onTap: () => context.read<QuestsCubit>().selectType(type),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (loaded.filteredQuests.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xl),
                  child: Center(
                    child: Text(
                      'لا توجد مهام من هذا النوع حاليًا',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                )
              else
                ...loaded.filteredQuests.map(
                  (quest) => QuestCard(
                    quest: quest,
                    onStart: () => Navigator.pushNamed(
                      context,
                      RouteNames.missionVerification,
                      arguments: quest,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
