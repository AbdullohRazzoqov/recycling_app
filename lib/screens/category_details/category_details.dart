import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycling_app/blocs/category_details/category_details_bloc.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/data/domain/usecases/firestore_usecases.dart';
import 'package:recycling_app/screens/category_details/widget/w_category_d_info_display.dart';
import 'package:recycling_app/screens/category_details/widget/w_category_d_overview.dart';

import '../../core/resources/app_colors.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.paht});
  final String paht;
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  int _currentPage = 0;

  late CategoryDetailsBloc categoryDetailsBloc;

  @override
  void initState() {
    categoryDetailsBloc = CategoryDetailsBloc(FirestoreUsecases(firestoreRepo: context.read()));
    categoryDetailsBloc.add(GetCategoryDetailsEvent(widget.paht));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoryDetailsBloc,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            widget.paht.toUpperCase(),
            style: AppStyles.nunitoSemiBold.copyWith(
              fontSize: 35.sp,
              color: AppColors.black,
            ),
          ),
        ),
        body: BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ResCategoryDetail) {
              return PageView(
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                children: List.generate(
                    state.categoryDetails.materialInfo.length + 1,
                    (index) => Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: index == 0
                                  ? const Radius.circular(45)
                                  : Radius.zero,
                              topRight: index ==
                                      state.categoryDetails.materialInfo.length
                                  ? const Radius.circular(45)
                                  : Radius.zero,
                            )),
                        child: index == 0
                            ? WCategoryDInfoDisplay(
                                imageUrl: widget.paht,
                                acceptableProducts:
                                    state.categoryDetails.acceptableProducts,
                                unacceptableProducts:
                                    state.categoryDetails.unacceptableProducts,
                              )
                            : WCategoryDOverview(
                                isLast: index ==
                                    state.categoryDetails.materialInfo.length,
                                materialInfo: state
                                    .categoryDetails.materialInfo[index - 1],
                              ))),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
