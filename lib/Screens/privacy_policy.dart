import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

import '../utils/Colors.dart';

class EmployeePrivacyPolicy extends StatefulWidget {
  const EmployeePrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<EmployeePrivacyPolicy> createState() => _EmployeePrivacyPolicyState();
}

class _EmployeePrivacyPolicyState extends State<EmployeePrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScreenBg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: const Text(
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold, fontSize: 30, height: 1.5),
            //       'Privacy Policy'),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                  style: TextStyle(fontSize: 16, height: 1.5),
                  'This privacy notice applies solely to information collected by this web site.  It will notify you of the following: \n\n 1. What personally identifiable information is collected from you through the web site, how it is used and with whom it may be shared.\n\n2. What choices are available to you regarding the use of your data.\n\n3. The security procedures in place to protect the misuse of your information.\n\n4. How you can correct any inaccuracies in the information.\n\nInformation Collection, Use, and Sharing\n\nWe are the sole owners of the information collected on this site. We only have access to/collect information that you voluntarily give us via email or other direct contact from you. We will not sell or rent your individual information to anyone\n\nWe will use your information to respond to you, regarding the reason you contacted us. We will not share your individual information with any third party outside of our organization, other than as necessary to fulfill your request.\n\nUnless you ask us not to, we may contact you via email in the future to tell you about specials, new products or services, or changes to this privacy policy.\n\nYour Access to and Control Over Information\n\nYou may opt out of any future contacts from us at any time. You can do the following at any time by contacting us via the email address or phone number given on our website:\n\n- See what data we have about you, if any.\n\n- Change/correct any data we have about you.\n\n- Have us delete any data we have about you.\n\n- Express any concern you have about our use of your data.\n\nSecurity\n\nWe take precautions to protect your information. When you submit sensitive information via the website, your information is protected both online and offline.\n\nWherever we collect sensitive information (such as credit card data), that information is encrypted and transmitted to us in a secure way.  You can verify this by clicking on the Authorize.net Verified Merchant Seal found on each page of the website.\n\nWhile we use encryption to protect sensitive information transmitted online, we also protect your information offline. Only employees who need the information to perform a specific job (for example, billing or customer service) are granted access to personally identifiable information. The computers/servers in which we store personally identifiable information are kept in a secure environment\n\nIf you feel that we are not abiding by this privacy policy, you should contact us immediately via telephone at 561 809-9590 or via email info@employeetrackingsolutions.net'),
            ),
          ],
        ),
      ),
    );
  }
}
