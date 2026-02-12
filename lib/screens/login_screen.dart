import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  //Variable de control para mostrar/ocultar la contraseña
  bool _obscureText = true;
  
  //crear el cerebro de la animacion
  StateMachineController? _controller;
  //SMI: State Machine Input
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;



  @override
  Widget build(BuildContext context) {

    //Para obtener el tamaño de la pantalla
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_bear.riv',
                  stateMachines: ["Login Machine"],
                  //al iniciar ña animacion
                  onInit: (artboard) {
                    _controller=StateMachineController.fromArtboard(artboard, "Login Machine");
                    

                    //Verifica que inicio bien
                    if (_controller == null) return;
                    //Agrega el controlador al tabalero 
                    artboard.addController(_controller!);
                    //Vincular variables
                    _isChecking = _controller!.findSMI("isChecking");
                    _isHandsUp = _controller!.findSMI("isHandsUp");
                    _trigSuccess = _controller!.findSMI("trigSuccess");
                    _trigFail = _controller!.findSMI("trigFail");

                  },
                  
                  ),
              ),
          
              //Para separacion
              const SizedBox(height: 10),
              TextField( 
                onChanged: (value) {
                  if(_isHandsUp !=null){
                    _isHandsUp !.change(false);
                  }
                  if(_isChecking==null) return;
                    _isChecking!.change(true);
                },
          
                //Para mostrar un tipo de teclado
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText:'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    //Para redondear los bordes
                    borderRadius: BorderRadius.circular(12)
                  )
          
                )
              ), 
              const SizedBox(height: 10),
              //campo contraseña

              TextField(
                onChanged: (value) {
                  if(_isChecking !=null){
                    //no quiero modo chsimoso
                    _isChecking !.change(false);
                  }
                  if(_isHandsUp==null) return;
                    _isHandsUp!.change(true);
                },

                obscureText: _obscureText, 
                decoration: InputDecoration(
                  hintText: 'Password', 
                  prefixIcon: const Icon(Icons.lock),
                //Boton para visualizar la contraseña
                  suffixIcon: IconButton( 
                    //If ternario
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off
                    ),
                    onPressed: () {
                      //Refresca el icono
                      setState(() {
                        _obscureText = !_obscureText;
                      }); 
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                  
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}