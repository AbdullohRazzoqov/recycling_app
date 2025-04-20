import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:recycling_app/core/resources/data_state.dart';
import 'package:recycling_app/core/utils/constants/collection_name.dart';
import 'package:recycling_app/data/data/dto/forum_dto.dart';
import 'package:recycling_app/data/domain/entities/forum_entities.dart';
import 'package:recycling_app/data/domain/usecases/firestore_usecases.dart';

part 'forum_event.dart';
part 'forum_state.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  FirestoreUsecases firestoreUsecases;

  ForumBloc(this.firestoreUsecases) : super(ForumInitial()) {
    on<GetForumEvent>((event, emit) async {
      emit(LoadingState());

      final res = await firestoreUsecases.getForum();
      if (res is DataSuccess) {
        emit(ResForumState(forum: res.data!));
      } else {
        emit(ErrorState(errorMessage: res.errorMessage.toString()));
      }
    });
    add(GetForumEvent());
  }
}
