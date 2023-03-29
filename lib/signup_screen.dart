import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dice/login_screen.dart';
import 'package:dice/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
 bool isLoading=false;
   var time=DateTime.now();
   List usernames=[];
getUsernames()async{
  var vari=await FirebaseFirestore.instance.collection('AllUsernames')
  .doc('All')
  .get();
  setState(() {
    usernames=vari.data()?['Users'];
  });
}
@override
  void initState() {
   getUsernames();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
body: isLoading?
Center(
  child: CircularProgressIndicator(
    color: Colors.indigo,
  ),
)
:SingleChildScrollView(
  child:   Padding(
  
  
  
    padding: const EdgeInsets.symmetric(horizontal: 20),
  
  
  
    child:   Column(
  
  
  
    
  
  
  
      mainAxisAlignment: MainAxisAlignment.center,
  
  
  
    
  
  
  
      children: [
  
  
  
    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
  
  
  
      Container(
  
  
  
    
  
  
  
        height: MediaQuery.of(context).size.height*0.15,
  
  
  
    
  
  
  
        width: MediaQuery.of(context).size.width*0.3,
  
  
  
    
  
  
  
      decoration: BoxDecoration(
  
      color: Colors.indigo,
  
      shape: BoxShape.circle
  
      ),
  
  
  
    
  
  
  
        child: Padding(
  
  
  
    
  
  
  
          padding: const EdgeInsets.all(8.0),
  
  
  
    
  
  
  
          child: Padding(
  
            padding: const EdgeInsets.all(8.0),
  
            child: Image.asset('assets/dice.png',color: Colors.white,),
  
          ),
  
  
  
    
  
  
  
        ),
  
  
  
    
  
  
  
      ),
  
  
  
    
  
  
  
      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
  
  
  
     Text('Signup',style: GoogleFonts.poppins(
  
                                 
  
                                          textStyle: TextStyle(
  
                                 
  
                                          color: Colors.black,
  
                                 
  
                                          fontSize: 30,
  
                                 
  
                                     fontWeight: FontWeight.bold
  
                                 
  
                                      ),
  
                                 
  
                                      )),
  
                                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
  
  
  
      TextFormField(
  
  
  
    
  
  
  
        controller: username,
  
  
  
        decoration: InputDecoration(
  
  
  
          prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.grey.shade700,),
  
  
  
          hintText: 'Username',
  
  
  
          hintStyle: GoogleFonts.poppins(
  
  
  
            textStyle:TextStyle(
  
  
  
              color: Colors.grey.shade700,
  
  
  
              fontSize: 15
  
  
  
            )
  
  
  
          )
  
  
  
        ),
  
  
  
        
  
  
  
    
  
  
  
      ),
  
  
  
      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
  
  
  
    
  
  
  
      TextFormField(
  
  obscureText: true,
  
    
  
  
  
        controller: password,
  
  
  
        decoration: InputDecoration(
  
          
  
  
  
          prefixIcon: Icon(Icons.vpn_key_outlined,color: Colors.grey.shade700,),
  
  
  
          hintText: 'Password',
  
  
  
          hintStyle: GoogleFonts.poppins(
  
  
  
            textStyle:TextStyle(
  
  
  
              color: Colors.grey.shade700,
  
  
  
              fontSize: 15
  
  
  
            )
  
  
  
          )
  
  
  
        ),
  
  
  
        
  
  
  
    
  
  
  
      ),
  
      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
  
       InkWell(
  
        onTap: ()async{
  
  if(username.text.isEmpty || password.text.isEmpty){
  
  Fluttertoast.showToast(msg: 'Please enter fields');
  
  }
  
  else if(usernames.contains(username.text)){
  
  Fluttertoast.showToast(msg: 'This username is already taken');
  
  }
  
  else{
  setState(() {
    isLoading=true;
  });
    await FirebaseFirestore.instance.collection('UserInfo')
  
  .doc(username.text)
  
  
  
  .set({
  
  'Username':username.text,
  
  'Password':password.text,
  
  'ID':'${time.second}'+'${time.minute}'+'${time.hour}'+'${time.day}'+'${time.month}'+'${time.year}'
  
  }).whenComplete(()async{
  
    await FirebaseFirestore.instance.collection('AllUsernames')
  
    .doc('All')
  
    .update({
  
  'Users':FieldValue.arrayUnion([username.text])
  
    }).whenComplete((){
  
  Navigator.of(context).pushReplacement(PageRouteBuilder(
  
                      transitionDuration: Duration(seconds: 1),
  
                      transitionsBuilder: (BuildContext context,
  
                          Animation<double> animation,
  
                          Animation<double> secAnimation,
  
                          Widget child) {
  
                        animation = CurvedAnimation(
  
                            parent: animation, curve: Curves.linear);
  
                        return SharedAxisTransition(
  
                            child: child,
  
                            animation: animation,
  
                            secondaryAnimation: secAnimation,
  
                            transitionType: SharedAxisTransitionType.horizontal);
  
                      },
  
                      pageBuilder: (BuildContext context,
  
                          Animation<double> animation,
  
                          Animation<double> secAnimation) {
  
                        return MainScreen();
  
                      }));
                      Fluttertoast.showToast(msg: 'Signup Successfully!');
                     
  
    }).whenComplete((){
 setState(() {
  isLoading=false;

  });
    });
  
      
  
  });
  
  }
  
        },
  
         child: Container(
  
                                    height: MediaQuery.of(context).size.height*0.06,
  
                                    width: MediaQuery.of(context).size.width,
  
                                 decoration: BoxDecoration(
  
                                   color: Colors.indigo.shade500,
  
                                 
  
                                   borderRadius: BorderRadius.circular(10),
  
                                 ),
  
                                 child:  Center(
  
                                   child:   Text('Signup',style: GoogleFonts.poppins(
  
                                   
  
                                            textStyle: TextStyle(
  
                                   
  
                                            color: Colors.white,
  
                                   
  
                                            fontSize: 16,
  
                                   
  
                                       fontWeight: FontWeight.w600
  
                                   
  
                                        ),
  
                                   
  
                                        )),
  
                                 ),
  
                                    
  
                                                             ),
  
       ),
  
  
  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
   Text('OR',style: GoogleFonts.poppins(
         textStyle: TextStyle(
         color: Colors.grey.shade400,
         fontSize: 14,
        // fontWeight: FontWeight.w600
         ),
        )),
  SizedBox(height: MediaQuery.of(context).size.height*0.04,),
  Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
       Text('Already have an account? ',style: GoogleFonts.poppins(
         textStyle: TextStyle(
         color: Colors.grey.shade700,
         fontSize: 14,
        // fontWeight: FontWeight.w600
         ),
        )),
      GestureDetector(
        onTap: (){
           Navigator.of(context).pushReplacement(PageRouteBuilder(
      
                          transitionDuration: Duration(seconds: 1),
      
                          transitionsBuilder: (BuildContext context,
      
                              Animation<double> animation,
      
                              Animation<double> secAnimation,
      
                              Widget child) {
      
                            animation = CurvedAnimation(
      
                                parent: animation, curve: Curves.linear);
      
                            return SharedAxisTransition(
      
                                child: child,
      
                                animation: animation,
      
                                secondaryAnimation: secAnimation,
      
                                transitionType: SharedAxisTransitionType.horizontal);
      
                          },
      
                          pageBuilder: (BuildContext context,
      
                              Animation<double> animation,
      
                              Animation<double> secAnimation) {
      
                            return LoginScreen();
      
                          }));
        },
        child: Text('Login',style: GoogleFonts.poppins(
         textStyle: TextStyle(
         color: Colors.indigo,
         fontSize: 14,
         fontWeight: FontWeight.w600
         ),
        
                                         
        
                                              )),
      ),
    ],
  ),
    
  
  
  
      ],
  
  
  
    
  
  
  
    ),
  
  
  
  ),
),
    );
  }
}