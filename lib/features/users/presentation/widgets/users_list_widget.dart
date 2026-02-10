import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wassela_task_app/core/helpers/extensions.dart';
import 'package:wassela_task_app/core/routing/routes.dart';
import 'package:wassela_task_app/core/theming/colors.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';
import 'package:wassela_task_app/features/users/presentation/logic/users_cubit.dart';
import 'package:wassela_task_app/features/users/presentation/widgets/user_card.dart';

class UsersListWidget extends StatefulWidget {
  final List<UserModel> users;
  final bool hasMore;
  final bool isLoadingMore;

  const UsersListWidget({
    super.key,
    required this.users,
    required this.hasMore,
    required this.isLoadingMore,
  });

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<UsersCubit>().loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
      // Only show the extra item if we are actively loading more
      itemCount: widget.users.length + (widget.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.users.length) {
          return _buildPaginationLoader();
        }
        final user = widget.users[index];
        return UserCard(
          user: user,
          index: index,
          onTap: () {
            context.pushNamed(Routes.userDetailsScreen, arguments: user.id);
          },
        );
      },
    );
  }

  Widget _buildPaginationLoader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Center(
        child: SizedBox(
          width: 6.w,
          height: 6.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: ColorsManager.mainColor1,
          ),
        ),
      ),
    );
  }
}
