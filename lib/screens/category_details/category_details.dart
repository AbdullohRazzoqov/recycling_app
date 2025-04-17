import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling_app/blocs/category_details/category_details_bloc.dart';
import 'package:recycling_app/screens/category_details/widget/w_category_d_info_display.dart';
import 'package:recycling_app/screens/category_details/widget/w_category_d_overview.dart';

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
    categoryDetailsBloc = CategoryDetailsBloc();
    categoryDetailsBloc.add(GetCategoryDetailsEvent(widget.paht));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoryDetailsBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.paht),
        ),
        body: BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ResCategoryDetail) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: const Color(0xffA2CE92),
                    borderRadius: BorderRadius.only(
                      topLeft: _currentPage == 0
                          ? const Radius.circular(45)
                          : Radius.zero,
                      topRight: _currentPage ==
                              state.categoryDetails.materialInfo.length
                          ? const Radius.circular(45)
                          : Radius.zero,
                    )),
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  children: List.generate(
                      state.categoryDetails.materialInfo.length + 1,
                      (index) => index == 0
                          ? WCategoryDInfoDisplay(
                              imageUrl: widget.paht,
                              acceptableProducts:
                                  state.categoryDetails.acceptableProducts,
                              unacceptableProducts:
                                  state.categoryDetails.unacceptableProducts,
                            )
                          : WCategoryDOverview(
                              materialInfo:
                                  state.categoryDetails.materialInfo[index - 1],
                            )),
                ),
              );
            } else if (state is ErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
