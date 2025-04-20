import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/core/resources/app_colors.dart';
import 'package:recycling_app/core/widget/w_appbar.dart';
import 'package:recycling_app/blocs/forum/forum_bloc.dart';
import 'package:recycling_app/data/domain/usecases/firestore_usecases.dart';

import '../../../core/resources/app_styles.dart';
import '../../core/widget/w_bulleted_list.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  bool isLoading = false;
  @override
  void initState() {
    _forumBloc = ForumBloc(FirestoreUsecases(firestoreRepo: context.read()));
    super.initState();
  }

  late ForumBloc _forumBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _forumBloc,
      child: Scaffold(
        backgroundColor: AppColors.c_C6E5BA,
        appBar: WAppBar(title: "FORUM"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 38.0,
              vertical: 32,
            ),
            child: BlocBuilder<ForumBloc, ForumState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  );
                } else if (state is ResForumState) {
                  return Column(
                    children: [
                      Text(
                        "FAQs:".tr(),
                        style: AppStyles.seoulRegular.copyWith(
                          fontSize: 24.sp,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      //FAQs
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(38),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black.withOpacity(.25),
                                blurRadius: 4,
                                offset: const Offset(0, 4))
                          ],
                        ),
                        //Bulleted List
                        child: WBulletedList(listData: state.forum.faqs),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "QUICK TIPS & TRICKS:".tr(),
                        style: AppStyles.seoulRegular
                            .copyWith(fontSize: 24.sp, color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      //Tips and tricks
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(38),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4))
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.55,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Column(
                                    children: state.forum.tips
                                        .map(
                                          (tip) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Text(
                                              tip,
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                              style: AppStyles.seoulRegular
                                                  .copyWith(
                                                      fontSize: 15.sp,
                                                      color: const Color(
                                                          0xff1A441D)),
                                            ),
                                          ),
                                        )
                                        .toList())),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (state is ErrorState) {
                  return Center(
                    child: Text("data:${state.errorMessage}"),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
