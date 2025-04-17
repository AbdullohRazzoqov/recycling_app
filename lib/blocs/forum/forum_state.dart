part of 'forum_bloc.dart';

@immutable
sealed class ForumState {}

final class ForumInitial extends ForumState {}

final class LoadingState extends ForumState {}

final class ResForumState extends ForumState {
  final ForumModel forum;
  ResForumState({required this.forum});
}

final class ErrorState extends ForumState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
}
