import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dmarketing/models/Constant.dart';
import 'package:dmarketing/root_pages.dart';
import 'package:dmarketing/pages/signing/forget_password.dart';
import 'package:dmarketing/pages/signing/login_screen.dart';
import 'package:dmarketing/pages/merchant/all_order.dart';
import 'package:dmarketing/repository/auth_user.dart';
import 'package:dmarketing/elements/user_input.dart';
import 'package:dmarketing/helper/showtoast.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  String kind;
  SignUpScreen(this.kind);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool pass = true;
  @override
  void initState() {
    _dropDownMenuItemsCityKind = _getDropDownMenuItemsCityKind();
    _dropDownMenuItemsRegionsKind = _getDropDownMenuItemsRegionsKind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userAuth = Provider.of<UserAuth>(context,listen: false);
    // userAuth.cities();
    // userAuth.regions();
    return Scaffold(
      backgroundColor: colorWhite,
      body: Container(
        height: _size.height,
        width: _size.width,
        color: colorWhite,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/back.png"),
        //       fit: BoxFit.cover,
        //     )
        // ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: height * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),

                Container(
                  width: width * 0.9,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                  child: UserInput.userinput(hint: translate("signup.username"),
                    textEditingController: _usernameController,
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Container(
                  width: width * 0.9,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                  child:  UserInput.userinput(
                      hint:  translate("signup.phone"),
                      textEditingController: __phoneController,
                      textInputType: TextInputType.phone
                  ),
                ),
                SizedBox(
                  height: height*0.02,
                ),
                Container(
                  width: width * 0.9,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                  child: UserInput.userinput(hint:  translate("signup.email"),
                      textEditingController: _emailController,
                      textInputType: TextInputType.emailAddress
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: width * 0.9,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                  child: UserInput.userinput(
                    hint:  translate("signup.password"),
                    password: pass,
                    textEditingController: _passwordController,
                    suffix: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        pass
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                    ),
                  ),
                ),
                // SizedBox(
                //   height: height*0.02,
                // ),
                // Container(
                //   width: width * 0.8,
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       border: Border.all(width: 1,color: appColor),
                //       color:colorWhite ),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton(
                //       isExpanded: true,
                //       style: new TextStyle(
                //           color: appColor, fontSize: width * 0.03+4),
                //       value: _statusSelCityKind,
                //       items: _dropDownMenuItemsCityKind,
                //       hint: Text(translate("signup.country"),
                //         style: GoogleFonts.cairo(
                //             fontWeight: FontWeight.bold,
                //             fontSize: width * 0.03 + 4),
                //       ),
                //       onChanged: _changeDrownItemCityKind,
                //       icon: new Icon(Icons.keyboard_arrow_down),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: height*0.02,
                // ),
                // Container(
                //   width: width * 0.8,
                //   alignment: Alignment.center,
                //   padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       border: Border.all(width: 1,color: appColor),
                //       color:colorWhite ),
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton(
                //       isExpanded: true,
                //       style: new TextStyle(
                //           color: appColor, fontSize: width * 0.03+4),
                //       value: _statusSelRegionsKind,
                //       items: _dropDownMenuItemsRegionsKind,
                //       hint: Text(translate("store.city"),
                //         style: GoogleFonts.cairo(
                //             fontWeight: FontWeight.bold,
                //             fontSize: width * 0.03 + 4),
                //       ),
                //       onChanged: _changeDrownItemRegionsKind,
                //       icon: new Icon(Icons.keyboard_arrow_down),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: _size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {

                    if (_usernameController.text.toString().trim().isNotEmpty&&
                        __phoneController.text.toString().trim().isNotEmpty&&
                        _emailController.text.toString().trim().isNotEmpty&&
                        _passwordController.text.toString().trim().isNotEmpty) {
                      await userAuth.registerUser(
                          context: context,
                          password: _passwordController.text.toString().trim(),
                          userName: _usernameController.text.toString().trim(),
                          mobile: __phoneController.text.toString().trim(),
                          email: _emailController.text.toString().trim(),
                      );
                    } else {
                      showToast(translate("login.not_true"));
                    }

                  },
                  child: Text(
                    translate("signup.signup"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: width*0.06,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: appColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: Size(_size.width, _size.height * 0.070),
                  ),
                ),
                SizedBox(
                  height: _size.height * 0.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LoginScreen()),);
                      },
                      child: Text(
                        translate("signup.already_have_account"),
                        style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: appColor,
                      size: width*0.06,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordSureController = TextEditingController();
  final TextEditingController __phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  //drop down
  List<DropdownMenuItem<String>> _dropDownMenuItemsCityKind;
  String _statusSelCityKind;
  List<DropdownMenuItem<String>> _getDropDownMenuItemsCityKind() {
    List<DropdownMenuItem<String>> itemsCityKind = new List();
    for(int i=0; i<Constant.cities.value.length;i++){
      itemsCityKind.add(new DropdownMenuItem(
        child: new Text(
          "${Constant.cities.value[i].name}",
          style: GoogleFonts.cairo(
            color: appColor,
          ),
        ),
        value: "${Constant.cities.value[i].id}",
      ));
    }
    return itemsCityKind;
  }
  void _changeDrownItemCityKind(String selectedItem) {
    setState(() {
      _dropDownMenuItemsRegionsKind.clear();
      _statusSelCityKind = selectedItem;
      print(_statusSelCityKind);
    });
    showToast("◌");
    // Timer(Duration(seconds: 1),(){
    try{
      for(int i=0; i<Constant.regions.value.length;i++){
        if(Constant.regions.value[i].city_id=="$selectedItem"){
          print("selected cityId: ${Constant.regions.value[i].city_id.toString()}");
          // _dropDownMenuItemsRegionsKind.clear();
          setState(() {
            _statusSelRegionsKind=Constant.regions.value[i].id.toString();
            _dropDownMenuItemsRegionsKind = _getDropDownMenuItemsRegionsKind(cityID:Constant.regions.value[i].city_id.toString());
          });
        }
      }
    }catch(e){print(e);}
    // });
  }

  List<DropdownMenuItem<String>> _dropDownMenuItemsRegionsKind;
  String _statusSelRegionsKind;
  List<DropdownMenuItem<String>> _getDropDownMenuItemsRegionsKind({String cityID}) {
    List<DropdownMenuItem<String>> itemsRegionKind = new List();
    for(int i=0; i<Constant.regions.value.length;i++){
      if(cityID==null){
        itemsRegionKind.add(new DropdownMenuItem(
          child: new Text(
            "${Constant.regions.value[i].name}",
            style: GoogleFonts.cairo(
              color: appColor,
            ),
          ),
          value: "${Constant.regions.value[i].id}",
        ));
      }else if(cityID==Constant.regions.value[i].city_id){
        print("add regionCityId $cityID");
        itemsRegionKind.add(new DropdownMenuItem(
          child: new Text(
            "${Constant.regions.value[i].name}",
            style: GoogleFonts.cairo(
              color: appColor,
            ),
          ),
          value: "${Constant.regions.value[i].id}",
        ));
      }
    }
    return itemsRegionKind;
  }
  void _changeDrownItemRegionsKind(String selectedItem) {
    setState(() {
      _statusSelRegionsKind = selectedItem;
      print(_statusSelRegionsKind);
    });
  }
}
