import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:recycling_app/data/model/forum_model.dart';

part 'forum_event.dart';
part 'forum_state.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  ForumBloc() : super(ForumInitial()) {
    on<GetForumEvent>((event, emit) async {
      emit(LoadingState());
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        final resForum = await firestore.collection('forum').doc('forum').get();

        if (resForum.data() != null && resForum.exists) {
          final ForumModel forum = ForumModel.fromMap(resForum.data()!);
          emit(ResForumState(forum: forum));
        } else {
          emit(ErrorState(errorMessage: "Error"));
        }
      } on FirebaseException catch (e) {
        emit(ErrorState(errorMessage: e.message.toString()));
      }
    });
    add(GetForumEvent());
  }
}
