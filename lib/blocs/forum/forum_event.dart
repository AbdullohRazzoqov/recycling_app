part of 'forum_bloc.dart';

@immutable
sealed class ForumEvent {}

class GetForumEvent extends ForumEvent{}