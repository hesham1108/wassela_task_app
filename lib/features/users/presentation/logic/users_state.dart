part of 'users_cubit.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

// ── Get all users states ──
final class GetAllUsersLoading extends UsersState {}

final class GetAllUsersLoadingMore extends UsersState {
  final List<UserModel> currentUsers;
  const GetAllUsersLoadingMore({required this.currentUsers});
  @override
  List<Object> get props => [currentUsers, DateTime.now().toString()];
}

final class GetAllUsersSuccess extends UsersState {
  final List<UserModel> users;
  final bool hasMore;
  const GetAllUsersSuccess({required this.users, required this.hasMore});
  @override
  List<Object> get props => [users, hasMore, DateTime.now().toString()];
}

final class GetAllUsersFailure extends UsersState {
  final String errorMessage;
  const GetAllUsersFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

// ── Get user data by id states ──
final class GetUserDataByIdLoading extends UsersState {}

final class GetUserDataByIdSuccess extends UsersState {
  final UserModel user;
  const GetUserDataByIdSuccess(this.user);
  @override
  List<Object> get props => [user, DateTime.now().toString()];
}

final class GetUserDataByIdFailure extends UsersState {
  final String errorMessage;
  const GetUserDataByIdFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

// ── Update user states ──
final class UpdateUserLoading extends UsersState {
  final String sentence;
  const UpdateUserLoading({this.sentence = ""});
  @override
  List<Object> get props => [sentence];
}

final class UpdateUserSuccess extends UsersState {
  final UserModel user;
  const UpdateUserSuccess({required this.user});
  @override
  List<Object> get props => [user, DateTime.now().toString()];
}

final class UpdateUserFailure extends UsersState {
  final String errorMessage;
  final bool isPop;
  const UpdateUserFailure({required this.errorMessage, this.isPop = false});
  @override
  List<Object> get props => [errorMessage, isPop];
}

// ── Edit mode state ──
final class EditModeChanged extends UsersState {
  final bool isEditing;
  final UserModel user;
  const EditModeChanged({required this.isEditing, required this.user});
  @override
  List<Object> get props => [isEditing, DateTime.now().toString()];
}
