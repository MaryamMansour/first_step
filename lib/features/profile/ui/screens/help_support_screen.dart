import 'package:flutter/material.dart';
import 'package:first_step/core/helper/spacing.dart';
import 'package:first_step/core/theming/colors.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Support'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle(context, 'Policies and Rules', Icons.policy),
            _buildCard(context, 'Respect Intellectual Property',
                'The app is not responsible for protecting the intellectual property rights of the project ideas uploaded by users. By uploading your project idea, you agree that you understand and accept this.'),
            _buildCard(context, 'No Plagiarism',
                'Users must ensure that the project ideas they upload are original and do not infringe on any existing copyrights or intellectual property rights.'),
            _buildCard(context, 'Appropriate Content',
                'All content uploaded must be appropriate and respectful. Any content deemed offensive or inappropriate will be removed, and the user may be banned from the platform.'),
            _buildCard(context, 'Privacy',
                'Users are responsible for ensuring that any personal information shared in their project ideas is done so at their own risk. The app is not responsible for any misuse of personal information shared by users.'),
            _buildCard(context, 'User Conduct',
                'Users must conduct themselves in a respectful and professional manner when interacting with others on the platform.'),
            verticalSpace(30),
            _buildSectionTitle(context, 'Terms and Conditions', Icons.description),
            _buildCard(context, 'Agreement to Terms',
                'By using this platform and uploading your project ideas, you agree to the following terms and conditions:'),
            _buildCard(context, 'Intellectual Property',
                'You acknowledge that the app is not responsible for the protection of your intellectual property rights.'),
            _buildCard(context, 'Original Content',
                'You agree that any project ideas you upload are original and do not violate any existing copyrights or intellectual property rights.'),
            _buildCard(context, 'Personal Information',
                'You understand that any personal information shared in your project ideas is done at your own risk.'),
            _buildCard(context, 'Respectful Behavior',
                'You agree to behave respectfully and professionally while using the platform.'),
            _buildCard(context, 'Acceptance of Terms',
                'You accept that by uploading your project idea, you agree to the terms and conditions set forth by the platform.'),
            verticalSpace(30),
            _buildSectionTitle(context, 'Contact Us', Icons.contact_mail),
            _buildCard(context, 'Support',
                'If you have any questions or need support, please contact us at:'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Email: mryammanour411@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor),
        horizontalSpace(10),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, String title, String content) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            verticalSpace(10),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
