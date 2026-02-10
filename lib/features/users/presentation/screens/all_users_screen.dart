import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/features/users/presentation/logic/users_cubit.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/home_app_bar.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/users_error_widget.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/users_list_widget.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/users_loading_widget.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: HomeAppBar(),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is GetAllUsersLoading) {
            return const UsersLoadingWidget();
          }

          if (state is GetAllUsersFailure) {
            return UsersErrorWidget(
              errorMessage: state.errorMessage,
              onRetry: () {
                context.read<UsersCubit>().getAllUsers();
              },
            );
          }

          if (state is GetAllUsersSuccess || state is GetAllUsersLoadingMore) {
            final cubit = context.read<UsersCubit>();
            final users = cubit.usersList;
            final hasMore = cubit.hasMore;

            if (users.isEmpty) {
              return _buildEmptyState();
            }

            final bool isLoadingMore = state is GetAllUsersLoadingMore;

            return RefreshIndicator(
              onRefresh: () async {
                await cubit.refreshUsers();
              },
              color: ColorsManager.mainColor1,
              child: UsersListWidget(
                users: users,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 15.w,
            color: ColorsManager.gray1_2,
          ),
          SizedBox(height: 2.h),
          Text(AppTexts.noUsersFound, style: TextStyles.font16fontGreyMedium),
        ],
      ),
    );
  }
}
