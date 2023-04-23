import 'package:flutter/cupertino.dart';

import '../../Models/CompanyModels/company_notification_model.dart';
import '../../Network/api_constant.dart';
import '../../Network/post_api_client.dart';

class CompanyNotificationController {
  Future<CompanyNotificationModel> getNotification(BuildContext context) async {
    var response = await getData(paramUri: ApiConstant.companyNotification);
    return CompanyNotificationModel.fromJson(response);
  }
}
