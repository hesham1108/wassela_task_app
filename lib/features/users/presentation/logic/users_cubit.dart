import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wassela_task_app/features/users/data/models/update_user_body.dart';
import 'package:wassela_task_app/features/users/data/models/user_model.dart';
import 'package:wassela_task_app/features/users/data/repo/users_repo_impl.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepoImpl usersRepoImpl;
  UsersCubit({required this.usersRepoImpl}) : super(UsersInitial());

  // ── Pagination ──
  static const int _pageLimit = 10;
  int _currentSkip = 0;
  bool hasMore = true;
  bool _isLoadingMore = false;
  List<UserModel> usersList = [];

  // ── Get all users (initial load) ──
  Future<void> getAllUsers() async {
    _currentSkip = 0;
    hasMore = true;
    usersList = [];
    emit(GetAllUsersLoading());

    final result = await usersRepoImpl.getAllUsers(
      limit: _pageLimit,
      skip: _currentSkip,
    );
    result.fold(
      (l) => emit(GetAllUsersFailure(errorMessage: l.message ?? "")),
      (r) {
        usersList = r.users ?? [];
        _currentSkip = usersList.length;
        hasMore = _currentSkip < (r.total ?? 0);
        emit(GetAllUsersSuccess(users: usersList, hasMore: hasMore));
      },
    );
  }

  // ── Load more users (pagination) ──
  Future<void> loadMoreUsers() async {
    if (_isLoadingMore || !hasMore) return;
    _isLoadingMore = true;
    emit(GetAllUsersLoadingMore(currentUsers: usersList));

    final result = await usersRepoImpl.getAllUsers(
      limit: _pageLimit,
      skip: _currentSkip,
    );
    result.fold(
      (l) {
        _isLoadingMore = false;
        emit(GetAllUsersSuccess(users: usersList, hasMore: hasMore));
      },
      (r) {
        final newUsers = r.users ?? [];
        usersList = [...usersList, ...newUsers];
        _currentSkip = usersList.length;
        hasMore = _currentSkip < (r.total ?? 0);
        _isLoadingMore = false;
        emit(GetAllUsersSuccess(users: usersList, hasMore: hasMore));
      },
    );
  }

  // ── Pull-to-refresh ──
  Future<void> refreshUsers() async {
    _currentSkip = 0;
    hasMore = true;
    _isLoadingMore = false;
    usersList = [];

    final result = await usersRepoImpl.getAllUsers(
      limit: _pageLimit,
      skip: _currentSkip,
    );
    result.fold(
      (l) => emit(GetAllUsersFailure(errorMessage: l.message ?? "")),
      (r) {
        usersList = r.users ?? [];
        _currentSkip = usersList.length;
        hasMore = _currentSkip < (r.total ?? 0);
        emit(GetAllUsersSuccess(users: usersList, hasMore: hasMore));
      },
    );
  }

  // ── Get user details by id ──
  UserModel? currentUser;
  Future<void> getUserDataById(int id) async {
    emit(GetUserDataByIdLoading());

    final result = await usersRepoImpl.getUserDataById(id);

    result.fold(
      (l) => emit(GetUserDataByIdFailure(errorMessage: l.message ?? "")),
      (r) {
        currentUser = r;
        emit(GetUserDataByIdSuccess(r));
      },
    );
  }

  // ── Edit mode ──
  bool isEditing = false;
  final GlobalKey<FormState> updateUserFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void toggleEditMode() {
    if (currentUser != null) {
      firstNameController.text = currentUser!.firstName ?? '';
      lastNameController.text = currentUser!.lastName ?? '';
      emailController.text = currentUser!.email ?? '';
    }
    isEditing = true;
    emit(EditModeChanged(isEditing: true, user: currentUser!));
  }

  void cancelEdit() {
    isEditing = false;
    emit(EditModeChanged(isEditing: false, user: currentUser!));
  }

  // ── Update user ──
  Future<void> checkUpdateUserForm() async {
    if (updateUserFormKey.currentState!.validate()) {
      await updateUser();
    }
  }

  Future<void> updateUser() async {
    if (currentUser == null) return;
    emit(UpdateUserLoading());

    final body = UpdateUserBody(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
    );

    final result = await usersRepoImpl.updateUser(
      currentUser!.id!,
      body.toJson(),
    );
    result.fold(
      (l) =>
          emit(UpdateUserFailure(errorMessage: l.message ?? "", isPop: true)),
      (r) {
        currentUser = r;
        isEditing = false;
        emit(UpdateUserSuccess(user: r));
      },
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
