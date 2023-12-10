import 'package:e_commerce_project_ws_cube/features/account/services/account_services.dart';
import 'package:e_commerce_project_ws_cube/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffFF8066),
            Color(0xffA8EB12),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          // const Icon(
          //   Icons.location_on_outlined,
          //   size: 20,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Welcome to ${user.name}  ${user.address}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 2,
            ),
            child: IconButton(
                onPressed: () {
                  context.read<AccountServices>().logOut(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  size: 18,
                )),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
