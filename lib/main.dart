import 'package:invoice_management/controller/gst_list_controller.dart';
import 'package:invoice_management/controller/invoice_controller.dart';
import 'package:invoice_management/controller/payment_controller.dart';
import 'package:invoice_management/controller/product_list_controller.dart';
import 'package:invoice_management/controller/provider/provider_controller.dart';
import 'package:invoice_management/utils/app_theme.dart';
import 'package:provider/provider.dart';

import 'imports.dart';
import 'view/init_screen/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => ProviderController()),
        ChangeNotifierProvider(create: (_) => ProductListController()),
        ChangeNotifierProvider(create: (_) => GSTListController()),
        ChangeNotifierProvider(create: (_) => PaymentController()),
        ChangeNotifierProvider(create: (_) => InvoiceController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeCtrl, child) {
          return MaterialApp(
            title: 'Invoice Management',
            debugShowCheckedModeBanner: false,
            theme: themeCtrl.currentTheme,
            home: const Splash(),
          );
        },
      ),
    );
  }
}
