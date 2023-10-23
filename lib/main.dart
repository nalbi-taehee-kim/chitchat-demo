import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chitchat_websocket_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  void _connectWebsocket() {}
  void _sendMatch() {}
  void _sendMatchResponse() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final idController = useTextEditingController();
    final targetIdController = useTextEditingController();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Websocket Test'),
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: "Your user id"),
                )),
            ElevatedButton(
                onPressed: _connectWebsocket, child: const Text("connect")),
            Expanded(child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(chitchatWebsocketProvider);
                if (state is AsyncLoading) return const CircularProgressIndicator();
                if (state.value == null) return const SizedBox();
                return ListView.builder(
                    itemCount: state.value?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.value.toString()),
                      );
                    });
              }
            )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: targetIdController,
                  decoration: const InputDecoration(labelText: "Target user id"),
                )),
          ],
        ),
      ),
    );
  }
}
