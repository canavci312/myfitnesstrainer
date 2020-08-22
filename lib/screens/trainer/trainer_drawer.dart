import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class TrainerDrawer extends StatelessWidget {
  const TrainerDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    print(userModel.user.toString());
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountEmail: Text(userModel.user.email),
            accountName: Text(userModel.user.name),
            
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                userModel.user.imageUrl,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Egzersizler'),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Eğitmenler'),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Eğitmenler'),
          ),
          GestureDetector(
            onTap: (){
              userModel.signOut();
            },
                      child: Align(alignment:Alignment.bottomCenter,child: ListTile(leading: Icon(Icons.exit_to_app),
              title: Text('Çıkış yap'),)),
          )
        ],
      ),
    );
  }
}
