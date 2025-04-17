import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling_app/core/resources/app_colors.dart';
import 'package:recycling_app/core/resources/app_image.dart';
import 'package:recycling_app/core/resources/app_styles.dart';
import 'package:recycling_app/core/widget/w_appbar.dart';
import 'package:recycling_app/features/info/bloc/info_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/widget/w_main_input.dart';
import 'model/category_model.dart';
import '../category_details/screen/category_details.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late InfoBloc infoBloc;
  @override
  void initState() {
    infoBloc = InfoBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => infoBloc,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: WAppBar(title: 'ITEM SEARCH'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 46,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Search By Item:".tr(),
                style: AppStyles.getForumTitleStyle(),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            WMainInput(
              onTapSearch: (input) {
                infoBloc.add(SearchProductEvent(input));
              },
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Search By Category:".tr(),
                style: AppStyles.getForumTitleStyle(),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            BlocBuilder<InfoBloc, InfoState>(
              builder: (context, state) {
                print(state);

                if (state is LoadingState) {
                  return Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Color(0xFFC2E4B5),
                      highlightColor: Color(0xff70B458),
                      child: GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.only(left: 30),
                        scrollDirection: Axis.horizontal,
                        childAspectRatio: 1.1,
                        children: List.generate(6, (index) {
                          return Container(
                            margin:
                                const EdgeInsets.only(right: 24, bottom: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xff70B458),
                              borderRadius: BorderRadius.circular(33),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                } else if (state is ResCategoryState) {
                  List<CategoryModel> categories = state.categories;
                  return Expanded(
                      child: GridView.count(
                    padding: const EdgeInsets.only(left: 30),
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    children: List.generate(categories.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDetails(
                                paht: categories[index].imageUrl,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 24, bottom: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xff70B458),
                            borderRadius: BorderRadius.circular(33),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categories[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Image.asset(
                                AppImages.parseUrlLocal(
                                    categories[index].imageUrl),
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ));
                } else if (state is ErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
