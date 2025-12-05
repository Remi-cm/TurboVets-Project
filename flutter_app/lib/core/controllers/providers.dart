import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'chat_provider.dart';
import 'global_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<GlobalProvider>(create: (_) => GlobalProvider(themeIsDark: false)),
  ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
];