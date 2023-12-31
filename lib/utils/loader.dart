
import 'package:flutter/cupertino.dart';
import 'package:speso_chat_app/utils/progressFile.dart';

import '../constants/colors.dart';


class LoaderProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ProgressBar _progressBar = ProgressBar();

  show(BuildContext context) {
    _progressBar.show(context);
  }

  hide() {
    _progressBar.hide();
  }
}




final loaderOne = Padding(
  padding: const EdgeInsets.all(18.0),
  child: Center(
    child: CupertinoActivityIndicator(
      color: AppColors.blueColor,
      radius: 13,
    ),
  ),
);

