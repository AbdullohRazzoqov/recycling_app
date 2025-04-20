import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:recycling_app/blocs/scanner/scan_bloc.dart';
import 'package:recycling_app/core/resources/app_toast.dart';
import 'package:recycling_app/data/domain/usecases/firestore_usecases.dart';
import '../../config/route_name.dart';
import '../../core/resources/app_colors.dart';
import '../../core/widget/w_main.button.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? barcode;
  late ScanBloc scanBloc;
  @override
  void initState() {
    scanBloc = ScanBloc(FirestoreUsecases(firestoreRepo: context.read()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => scanBloc,
      child: BlocListener<ScanBloc, ScanState>(
        listener: (context, state) {
          print(state);
          if (state is SeachResultState) {
            Navigator.pushNamed(
              context,
              RouteNames.scanResault,
              arguments: scanBloc.product!,
            );
          } else if (state is ScanErrorState) {
            AppToast.show(
                message: state.error,
                toastType: ToastType.error,
                context: context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("SCAN YOUR ITEM".tr()),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(85),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 32,
                    child: MobileScanner(
                        controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates,
                            returnImage: true),
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          barcode = barcodes.first.rawValue;
                          setState(() {});
                        }),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ScanBloc, ScanState>(
                    builder: (context, state) {
                      return WMainButton(
                        backgroundColor:
                            barcode == null ? Colors.grey : AppColors.c_70B458,
                        margin: const EdgeInsets.symmetric(vertical: 32),
                        text: "Scan",
                        isLoading: state is ScanLoadingState,
                        onPressed: () {
                          // barcode = '11111111';
                          if (barcode != null) {
                            scanBloc.add(SearchProductEvent(barcode!));
                          } else {
                            AppToast.show(
                                context: context,
                                message: "Please scan a barcode".tr(),
                                toastType: ToastType.error);
                          }
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
