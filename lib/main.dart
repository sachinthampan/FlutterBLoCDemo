import 'package:flutter_bloc_demo/repository/LoginRepo.dart';
import 'package:flutter_bloc_demo/utils/user_interface.dart';
import 'package:flutter_bloc_demo/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/loginbloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
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
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Loginbloc loginbloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginbloc = Loginbloc(loginRepo: LoginRepo());
  }

  @override
  void dispose() {
    loginbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => loginbloc,
        child: BlocBuilder<Loginbloc, LoginPageState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  // TRY THIS: Try changing the color here to a specific color (to
                  // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
                  // change color while the other colors stay the same.
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .inversePrimary,
                  // Here we take the value from the MyHomePage object that was created by
                  // the App.build method, and use it to set our appbar title.
                  title: Text("Login"),
                ),
                body: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Center(
                    // Center is a layout widget. It takes a single child and positions it
                    // in the middle of the parent.
                    child: Column(
                      // Column is also a layout widget. It takes a list of children and
                      // arranges them vertically. By default, it sizes itself to fit its
                      // children horizontally, and tries to be as tall as its parent.
                      //
                      // Column has various properties to control how it sizes itself and
                      // how it positions its children. Here we use mainAxisAlignment to
                      // center the children vertically; the main axis here is the vertical
                      // axis because Columns are vertical (the cross axis would be
                      // horizontal).
                      //
                      // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                      // action in the IDE, or press "p" in the console), to see the
                      // wireframe for each widget.
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 5),
                          child: TextFormField(
                              onChanged: state.setUserName,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Please enter your username"
                              ),
                              onTap: () {
                                context.read<Loginbloc>().add(Reset());
                              },
                              validator: (value){
                                return Validators.validateEmail(value);
                              }
                          ),),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                          child: TextFormField(
                              onChanged: state.setPassword,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Please enter your password"
                              ),
                              onTap: () {
                                context.read<Loginbloc>().add(Reset());
                              },
                              validator: Validators.validatePassword),),
                        OverflowBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(160.0, 45.0)),
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                                    }
                                    return null; // Use the component's default.
                                  },
                                ),
                              ),
                              child: const Text('Login'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  UserInterface.showSnack(context, 'Logging in...');
                                  context.read<Loginbloc>().add(LoginPressed(state.userName!, state.password!));
                                }
                                context.read<Loginbloc>().add(Reset());
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        state.loginState == LoginPageStates.LOGIN_FAILED ?
                        const Text("Login Failed", style: TextStyle(color: Colors.redAccent)) :
                        state.loginState == LoginPageStates.LOGIN_SUCCESS ?
                        const Text("Login Success", style: TextStyle(color: Colors.greenAccent)) :
                        const SizedBox(height: 10,)

                      ],
                    ),
                  ),
                ),
              );
            })


    );
  }
}
