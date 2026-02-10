import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/app_dialogs.dart';
import 'package:wassela_task_app/core/helpers/app_texts.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/core/theming/styles.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';
import 'package:wassela_task_app/features/users/presentation/logic/users_cubit.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/user_detail_header.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/user_edit_form.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/user_info_card.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;
  const UserDetailsScreen({super.key, required this.userId});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getUserDataById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: BlocConsumer<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UpdateUserLoading) {
            AppDialogs.showLoadingWithSentence(context, AppTexts.updatingUser);
          }
          if (state is UpdateUserSuccess) {
            context.pop(); // dismiss loading
            AppDialogs.showNewTost(
              context: context,
              msg: AppTexts.updateSuccess,
              cardColor: Colors.green,
            );
          }
          if (state is UpdateUserFailure) {
            if (state.isPop) context.pop();
            AppDialogs.showErrorDialogue(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          final cubit = context.read<UsersCubit>();

          if (state is GetUserDataByIdLoading) {
            return _buildLoadingState();
          }

          if (state is GetUserDataByIdFailure) {
            return _buildErrorState(state.errorMessage);
          }

          final UserModel? user = cubit.currentUser;
          if (user == null) return _buildLoadingState();

          final bool isEditing = cubit.isEditing;

          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 0,
                floating: false,
                pinned: true,
                backgroundColor: ColorsManager.mainColor1,
                foregroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Text(
                  AppTexts.userDetails,
                  style: TextStyles.font18BlackBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                actions: [
                  if (!isEditing)
                    IconButton(
                      onPressed: () {
                        cubit.toggleEditMode();
                      },
                      icon: Icon(Icons.edit_outlined, size: 5.w),
                    ),
                ],
              ),
              // Body
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Header
                    UserDetailHeader(user: user),
                    SizedBox(height: 1.h),
                    // Edit form or Info card
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            child: child,
                          ),
                        );
                      },
                      child: isEditing
                          ? UserEditForm(key: const ValueKey('edit'))
                          : UserInfoCard(
                              key: const ValueKey('info'),
                              user: user,
                            ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ColorsManager.mainColor1),
          SizedBox(height: 2.h),
          Text(AppTexts.loadingUsers, style: TextStyles.font16fontGreyMedium),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: ColorsManager.mainColor1,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF7F8FC),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade400,
                size: 10.w,
              ),
              SizedBox(height: 2.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyles.font16BlackMedium.copyWith(
                  color: ColorsManager.gray1,
                ),
              ),
              SizedBox(height: 3.h),
              TextButton.icon(
                onPressed: () {
                  context.read<UsersCubit>().getUserDataById(widget.userId);
                },
                icon: Icon(Icons.refresh, color: ColorsManager.mainColor1),
                label: Text(
                  AppTexts.retry,
                  style: TextStyles.font16BlackMedium.copyWith(
                    color: ColorsManager.mainColor1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
