import 'package:bip_hip/utils/constants/imports.dart';

class MessengerController extends GetxController{
  final TextEditingController inboxSearchTextEditingController = TextEditingController();
  final RxList inboxFilterCategoryList = RxList(["All", "Active", "Marketplace", "Kids"]);
  final RxString selectedFilterCategory = RxString("All");

  final RxList inboxList = RxList([
    {"id": 0, "name": "Manjurul S. Omi", "image":"https://images.pexels.com/photos/17725267/pexels-photo-17725267/free-photo-of-portrait-of-soldier-in-gas-mask.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1", "message": "Assalamualaikum vai, kemon achen.", "isActive": true, "isSeen": false, "isMute": false, "isLastMessageSelf": true, "lastMassageTime": DateTime.now()},
    {"id": 1, "name": "Johan Liebert", "image":"https://static.wikia.nocookie.net/villains/images/2/2b/Johan.jpg", "message": "Richard, how about a drink?", "isActive": false, "isSeen": true, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 2, "name": "Rick Sanchez", "image":"https://cdn.dribbble.com/users/5592443/screenshots/14279501/drbl_pop_r_m_rick_4x.png", "message": "Wubba lubba dub dub arghhhh!", "isActive": true, "isSeen": true, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 3, "name": "Morty Smith", "image":"https://static.tvtropes.org/pmwiki/pub/images/morty_smith_2.png", "message": "Rick, I.. I can't breathe Rick. Get off me chest.", "isActive": true, "isSeen": false, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 4, "name": "Peter Griffin", "image":"https://pub-1de51ae1e68144d78f7c582e1dda3ab1.r2.dev/peter_2008_v2F_hires1-56a00f083df78cafda9fdcb6.jpeg", "message": "What Louis! Can't you make on thing right?", "isActive": true, "isSeen": false, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 5, "name": "Stewie Griffin", "image":"https://facts.net/wp-content/uploads/2023/09/10-facts-about-stewie-griffin-family-guy-1694159026.jpg", "message": "See what I'm doing, Scarf, high stool, legs crossed, engaged and in the moment", "isActive": false, "isSeen": true, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 6, "name": "Brian Griffin", "image": "https://facts.net/wp-content/uploads/2023/08/13-facts-about-brian-griffin-family-guy-1692229079.jpg", "message": "Stewie look out!", "isActive": true, "isSeen": false, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 7, "name": "Meg Griffin", "image":"https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Meg-Griffin.Family-Guy.webp", "message": "Dad, I heard a noise.", "isActive": true, "isSeen": false, "isMute": true, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 8, "name": "Louis Griffin", "image": "https://static0.gamerantimages.com/wordpress/wp-content/uploads/2023/07/lois-griffin.jpg", "message": "You heard me right?", "isActive": false, "isSeen": true, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 9, "name": "Chris Griffin", "image": "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Chris-Griffin.Family-Guy.webp", "message": "What if we have two calculators?", "isActive": true, "isSeen": false, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
    {"id": 10, "name": "Glenn Quagmire", "image": "https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Glenn-Quagmire.Family-Guy.webp", "message": "Giggity", "isActive": true, "isSeen": false, "isMute": false, "isLastMessageSelf": false, "lastMassageTime": DateTime.now()},
  ]);
}