import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/models/profile_image.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_cubit.dart';
import 'package:social_app/social_app/social_lauout/cubit/social_states.dart';
import 'package:social_app/widgets/post_card.dart';
class FeedsScreen extends StatelessWidget {
   FeedsScreen({Key? key}) : super(key: key);
  var commentController = TextEditingController();
  List<Profile> profiles = Profile.profileChild;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(builder: (context,state){
      var model = SocialCubit.get(context).socialUserModel;
      if (model != null && SocialCubit.get(context).posts.isNotEmpty) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
                if(!FirebaseAuth.instance.currentUser!.emailVerified)
                Container(height: 50.0,
                color: Colors.amber.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Expanded(child: Text('PLEASE VERIFY YOUR EMAIL',style: TextStyle(color: kTextColor,fontWeight: FontWeight.w600),)),
                      const SizedBox(
                        width: 20.0,
                      ),
                      defaultTextButton(pressed: (){
                        FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content:Text('Check your mail',maxLines:1,
                              overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
                            behavior:SnackBarBehavior.floating,
                            backgroundColor:Color(0xFF801336),
                          ));
                          const Icon(Icons.info_outline,size: 16,);
                        }).catchError((error){

                        });
                      },
                          text: 'SEND')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Card(
                margin: const EdgeInsets.all(8.0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10.0,
                child: Stack(alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    // const Image(image: NetworkImage('https://images.unsplash.com/photo-1671726203383-2585f5572dce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxNDl8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),width: double.infinity,),
                    const Image(image: NetworkImage('https://plus.unsplash.com/premium_photo-1670884126758-cae320f7be47?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),width: double.infinity,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Communicate With friends',style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),),
                    )
                  ],
                ),
              ),
              ListView.separated(
              shrinkWrap: true,physics:const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                if(SocialCubit.get(context).posts.length > currentIndex){
                  SocialCubit.get(context).incIndex(currentIndex);
                }
                return PostCard(profile: SocialCubit.get(context).posts[index],index:currentIndex,);},
               separatorBuilder: (context,index)=>const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                  itemCount: SocialCubit.get(context).posts.length),
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator(),);
      }
    }, listener: (context,state){});
  }

}
/// verify email
///*  if(!model.isEmailVerified!)
//               Container(height: 50.0,
//               color: Colors.amber.withOpacity(0.6),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.info_outline),
//                     const SizedBox(
//                       width: 20.0,
//                     ),
//                     const Expanded(child: Text('PLEASE VERIFY YOUR EMAIL',style: TextStyle(color: kTextColor),)),
//                     const SizedBox(
//                       width: 20.0,
//                     ),
//                     defaultTextButton(pressed: (){
//                       FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value){
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                           content:Text('Check your mail',maxLines:1,
//                             overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
//                           behavior:SnackBarBehavior.floating,
//                           backgroundColor:Color(0xFF801336),
//                         ));
//                         const Icon(Icons.info_outline,size: 16,);
//                       }).catchError((error){
//
//                       });
//                     },
//                         text: 'SEND')
//                   ],
//                 ),
//               ),
//             )*/
List<String> images =[
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2vJzWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYz1p544jUl5ZCz1+OETfTLyJSjtX66+bVerN0TNv9pVikb40L3UZZHWo8sYsVwmYdTUdHOlPHL%7C%7Clo79UvOa0LGFq8zCXItscywlapZ63W6173pQu9u+EhEy3ptV%7C%7CJzlE+2UyMEgvsNzX5DkFUbLPPM1LpqBjG+Zc3YE65ezRlC27THp5dXldRhyOlpPwvtZbsjT7UzF+%7C%7CmWqGogZImY%7C%7CkXSZljcQk8oti4f%7C%7CY8A4n%7C%7Cc%7C%7CjqPWT24CYGduvklDmpPpujnoOE+d6lp852vL74e6a9AsrcbdFLbOcZ666G+SI7LdFuwBCDwACKGGA2D9JtS0X%7C%7CB4mb5BDsxk+nyhpzWJdp%7C%7CzzkNiBWBts3nSFIRGEaW26pCAv17WtTqJ5gg+zZroWeoKmg58tPqD6jlocHibU5kcbTGB.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2uFwWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRzIQlkHjeVeSBo5IopVFtQDD1+O0PXTr2LTTlX6qWfUu3N0DZg9J9pnLozLnQWYn+u98ckVgmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDlBqousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+dazPgL6NDhkyblKXQMKmQmRxLI44jgp9EssCX+c3M9%7C%7C2z6ZoE3KXY2lnealjcQ9I8titj1edgr1vZl4fDobWAjRl07%7C%7CkJRs6GNqCLmUHi+1EwK4WGD5rKfdekF98XGIfiMW+vW3XiYT5TcNf1DWCdZU96Acnr5cLOJCctmhYJLQaofjgzs9A==.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2uFwWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYzxh4o4uUFRZDj1%7C%7CPUzaTLCNSTlR66WZXOzN1jJm8JdklLw0JHMZZXCp%7C%7C8ElXAmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDlBqousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+dfzPgL6NDhkyblKGEZVWRGRhaSnq7gp9EosxfORHM9%7C%7C2z6Zos2BW0OoHealjcQ9I8titj1edgr0PkHsqHURGM4VGly+jlkm8eTjQqYRXqcyG5m4jX+yLDhXNol87jRYKC5EIjNgnONbbLcQ%7C%7CYZG3UHXayGbH7aAcSRXv52tIxWMt4bh1+g2yGLQpvt1DB4DxETpQeZFpxgZevEk4WKxW79uirIrwJmxp+ZWpJ%7C%7CmQsbzcuO1hVyfSGQVJsZPmM=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2Pk2GAlRNucaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfz5m5o0oVFVXZFZyOUPZQLWITzxc7KmeVICm1jRj9p9nkL00K30dZnCn9MUlOzjYMTIfQeoEH%7C%7Cbx7a8Koru5A2MGoyX9auctwCIPuM23TKNy2JAtrKSLl0SxptZ%7C%7CIjNLvG0jJ00m7NPfvnw1UvfPMc9g+PAnHvEzhMQ65Oftxny8M1U9LUAzIWKcm7OYk%7C%7Cgghi6ucTE1pkCFSoMaP208oHSallAysY5z38j3coRq5v05sqjSc20CRjFGrR89vqCEwg75SXiG60QB7kTq2527ceQLodCjAbbOcZW7gSLDbOaTQf1DVSdfUMP3VX2KEdG6BNBzxa5fDuEW%7C%7CFyW6grvcZjCyR9pBmZejC6cQYBeVtSpwbeHpS7xxDKL%7C%7CVFosu2YWpJ6jmFT8fqe4AImLy2VU80Y.jpeg?1'
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2uFwWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYzxh4YssUllXDz17NUTaTrWJSTlS56yQU+zN1Tdk9JZgkLcxLnMaYXOt8cEkUgmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDlBqousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+ddzPgL6NDhkyblEEp8SGtTKBrJj7Lgp7Zb3Cu+InM9%7C%7C2z6Zos2BW0OoHealjcQ9I8titj1edgr0PkHsqHURGM4VGly+jlkm8aSsxaZR1SMim5m+jT89oapXPQf8rvRYKC5EIjNgnONbbLcQ%7C%7CYZG3UHXayGbH7aAcfuX%7C%7CcBxtNrDq9a4wmN8gXoVbzk6wV8KgVChDqMBpB7DvaR9%7C%7CqD3yPkkDrIrwJmxp+ZIuQImQ0bzcuO1hVyfSGQVJsZPmM=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PEvHA5RNecaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfz5j448vWFpZZFN7PkPfT7aPTjdU7KicV+%7C%7CN1TVn85Zpkrs3KHQebH6v%7C%7C8skVAmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7MqqS7Z0zYMh7+yBhEXuuMlgajtE8yUnJkosrJPUry5MY%7C%7CrzDc11sfwmF+dKtckG1ODmmHi5PFszdGxLDhGxuar5oKMCqhTQMjA89jyGZaQRDlw%7C%7Co3Saljd3sY8s1dLvYctk3sE7sKPfSVkMWnU2ih5lwrm3kDnjXFn88llV2U%7C%7CnyeacaPVyi7S1dtfYBv+nnmzDbbOJWe4KUnJSUKzpcln+E+aTSvBbt6ROBtJc4w2A6BG4I5OmyzBoB2Rg1QTdGYtoaM7E74Oyo2Lco3uBpVptw+7iXeMI7Rhi%7C%7CMay+g9%7C%7CJCqXVp5KbA==.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PEvHA5RNucaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfz5j5IIoVlVXZFd5P0PWQbCARDpT56WZVYCh0zZu8ZRpk7s2KXIcY3Sp8sJDCnicKyVHDe0AUq%7C%7Cm6vZNuKyBOTUAsFzMZ9sa3Gtbv9CwWaVny5xu5KaJixiouco3KjwE9GkiIEdmrNjO7AUEX8vzM9op9PEgAIgCifgK4+yziiS2IzotY0FRLgm+gtLmy7hRvGXtcDhl2kOqbYgrDm4%7C%7CoHSa8RUysNF5xdDkPYpS2v87uaXoR2MeAkFhrEZDtKHvuin8OE2d8lt%7C%7C90WH7Kmca9EX48bUYKC5G4mkzyLCOfyLUrREACpfP93Qd1zJdtS9UM1+npFuN%7C%7CYf+2yn8wqkYKD2xQdHHhFhlgK6IachSM67z4Wip2CWjTjT9lQZyZvjXuca91BezdaE7VstKC+QAJ8=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2vJzWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYz1n5Y0pUFlRDT18P0zfT7WPRD9S6qWeUufN1jxk8pVjnLYxL3MdYXav8cMpXQmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDhxmousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+dczPgL6NDhkyblKzQ+WHxSH2jPgJjgp9Et0zLnRHM9%7C%7C2z6Zos2BW0OoHealjcQ9I8titj1edgr0PkHsqHURGM4VGly+jlkk8SSoxKZRnqqjW5mxDT+9pamXcoXvLjnYKC5EIjNgnONbbLcQ%7C%7CYZG3UHXayGbH7aAeG+H8dDw699HfF8gQ6D9SfwTeHE+R58LxFj0jWSHKUjUtfKzImr9lbotCrIrwJmxp+ZWuAImHgbzcuO1hVyfSGQVJsZPmM=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2vJzWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYz1j54krVl9QDD1+PkfWSLCNSjpS5q2eUujN1TRm8ZdhkbY9LHMdZneo%7C%7C8YpUgmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDhxmousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+ZdzPgL6NDhkyblC0IOdV5ENg+yvabgp7clgxnbcHM9%7C%7C2z6Zos2BW0OoHealjcQ9I8titj1edgr0PkHsqHURGM4VGly+jlkqY6TswqeR1SYx25YwHr+yIbkXMoP97jBYKC5EIjNgnONbbLcQ%7C%7CYZG3UHXayGbH7aBKWVBNtWn6V7Bq5mxwa32haxQLL85BggPmFosBzZA7hURu6fl5v06iXThgzIrwJmxp+ZIut+6gobzcuO1hVyfSGQVJsZPmM=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2vJzWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYz1i4Y8iUlhRDT17OEDbQbOOTDtX5qWZU+rN0DZm9JBilrY2JXwYZ3Cp9sMvOzjYMTIfQeoEH%7C%7Cbx7a8Koru5A2MGoyX9auctwCIPosCrVrZwxIVt4aaA0ga0pYc1KjRE4X8gI1spr5PZpTdMY%7C%7CrzDc11sfwmF+ZKtckG1ODmmHiMC3pzYmdEPDKxl6r50u0yiDnaMjA89jyGZaQRDlw%7C%7Co3Saljd3sY8s1dLvYctk3sE7sKPfSVkMWnU2ih5XibqnrnLiXE2z8WdV1E3n56qfRs9zi5K1dtfYBv+nnmzDbbOJWe4KUnJSUKzpcln+KfyUBpBMrodNSaxD81Gj5hzpWpPuihRzLDRHui3dCodmE9nM0IWR9XDjhXuBpVptw+7iIpZ4mRhi%7C%7CMay+g9%7C%7CJCqXVp5KbA==.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2uFwWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYz1h54MpWFxZDj15PkHbSreATz1S6KSQVezN2zZj8Jdikr42JHQXZnat%7C%7C8QrVQmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDlBqousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+dZzPgL6NDhkyblG28+VGx8JGStiojgp7cvoiXpbHM9%7C%7C2z6Zos2BW0OoHealjcQ9I8titj1edgr0PkHsqHURGM4VGly+jlkqYyToxqdRnqIjG124jH85pLkXNolvrvRYKC5EIjNgnONbbLcQ%7C%7CYZG3UHXayGbH7aA+2TNvBmzppsKPR28W+QyCu6JOWsjyF2FDRFjmGmCKdSRaXJz6qO%7C%7C3zjzyrIrwJmxp+ZWpAI7g8bzcuO1hVyfSGQVJsZPmM=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2vJzWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYz5j5YMiVFxSAz18NEHeTrGMSj1W5qyfUO%7C%7CN1j1h9JNgk7w1K3EXY3Km%7C%7CsorXAmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDhxmousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF+dUzPgL6NDhkyblBUM5fGp2OzGwqd%7C%7Cgp9ER13DRInM9%7C%7C2z6Zos2BW0OoHealjcQ9I8titj1edgr0PkHsqHURGM4VGly+jlkocaSoyTVRXqqyGxm5jT92IqrXMoLsbjBYKC5EIjNgnONbbLcQ%7C%7CYZG3UHXayGbH7aA8ThHspJstJaCsJ38GSNqUuHdpas2iVTFT5F2ju6L5ZZEaiN95uX6G%7C%7CJiDrIrwJmxp+ZIuoP7Q4bzcuO1hVyfSGQVJsZPmM=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2uFwWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYzxi54gqUl1XDD17OEDdS7aPSz5S66mcUe3N1zNg%7C%7CZBnk70yKHcdZXGp98ElXAmYdSgIGaYDG7uo+qhT5aGuO1lQpTb9dLVCkGZK4JP8CORKxJIf6rbak0jq5ZA0KikH8W81dQR57N7epDMET+DxNdx1qO90SbpKtckG1Ozvj3jpV1IkeFFxHzPCldzxreIQsXvkY20ZwzmSb7wIHwobhVjmljcTkJokvaeDFaxMn%7C%7C07s%7C%7C2AATNBUGQ290RRsZKZvgHhejee3WgH6kP045mJKsEqj7HnKvCKAd7OmAzRZJ3TBalOdkk8NcvXVBnTJajgVOoAsq0aPb5x2V2K4w+5Kein2EUhVw==.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBcaS3SYdxKjf8F2vJzWgxSZ60STLepjSVmIR1vLHOapZA0mpCj4yRwKwVlASuRYzxh5o0sUlhXCj17NUzeTbGITD1R66maU+fN2zVh9J5ikbk0KnQcYnGs9cMoUQmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7NCnV6xhz580r6GDhxmousoyIDND%7C%7CHg1JU46o9CUqTUHGsv+MfF3pLUqF%7C%7CEzhMQ65OftxhK5MDsTXFRMMTGcm7P+i9guvG6ucTE1pkCFSoMaP208oHSallAysY5z38j3coRq5v05sqjSc20CRjFGrR8%7C%7CvrC+wg75RTOE1W4D7Wr+lp67X+QLodCjAbbOcZW7gSLDbOaTQf1DVSdfUMP3VXv1C6S4NfwLpYBcRK90z0+0oxGyQ+jx7wl7KhpDrR2ZGJhaZdrNzqSp8CXXxDKL%7C%7CVFospWaL+AJjmFT8fqe4AImLy2VU80Y.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PwkAQ9OKfhSQ7e71yJjMBhsLH6QvJA0mpCj4yRwKwVlASuRYzxg5IItU1RVDz17PEHYT7yNTT1d7KqcXe6kvDBl859pnLo0K3AZYHKo98UvVWKpNWwSDv5PHL%7C%7Clo79UvOa0LGFq8zCXItscywlapZ6tVrFhy5Yy46%7C%7CJhkLg%7C%7CdZjaWwE9GUgak8qodnU5DQPSLLPPM1LpqBjG+ZKtckG1ODmmHirO1l5bUt8DX24sar5xtQJrQXCMjA89jyGZaQRDlw%7C%7Co3Saljd3sY8s1dLvYctk3sE7sKPfSVkMWnU2ih5liLm3lHHjXFH78Gd%7C%7Clk73++efaMs8iaS1dtfYBv+nnmzDbbOJWe4KUnJSUKzpcln+AvCSL8dvgahsKvBZ4ROHwl7uX6X%7C%7C%7C%7Cl5dLhxYkmS8BrZbbu2554qd1iPyhXuBpVptw+7iWeUE7hhi%7C%7CMay+g9%7C%7CJCqXVp5KbA==.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PwkAQ9OKfhSQ7e71yJjMBhsLH6QvJA0mpCj4yRwKwVlASuRYzxg5okpU1VVAz17NEHdTryORDtU6KWeVuvN1zBk9JVll7ozK3UYY3Ss%7C%7C8AvXQmYdSgIGaYDG7uo%7C%7CesJ+fPucjcBojOMNbBGmDdttdCwFahlza4lsfe4kx2xu5xncG114WNxahlw5OLUqQUCSKn5PN1gpKZlR7pCjM4A%7C%7Cb281nT2F2MrNWh8FDSR9IXEi6g8iyDXdzQspjD3H+8EIU8hjl246h01mNURp5KWEaJc+MZhnq3hZHJBWmhm+jVBocW+xzTvSUGI%7C%7CgVRwGKOlf7kNPEu+8WgGtKbdN3t%7C%7CxjvX6n0RK52ciMKJNveaXL0Ba2dHclpxYAZPtB2+FSj1SCQR7K5jCI3CzAX1WepLcQmZ6vb+6GnzWTZhmDWpgNqws4=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PwkAQ9OKftSQ7e71yJjMBhsLH6QvJA0mpCj4yRwKwVlASuRYz1o4YIqU1VTDz1%7C%7CNEzWSbKATjZU7KucXe%7C%7CN0DVm9pBilb08K3QaZn6u9csqUAmYdSgIGaYDG7uo+qhT5aGuO1lQpTb9d7JGmC4E5ZObS6olhMF4pJ2Jg3Tt%7C%7C9k4Ki5e82wzJURmpNTfvGhYEaa+NMB166d1RbMCxMkA%7C%7C6nRlSaHEmw+Jj8uRXagtIj+kOYA2ALcXx0+qzb3XpgaDnQhvl+hkh93t4gj1aSNBdxuiekakIH2bSAEXG428Fk71pu1ynOdV0Gv%7C%7CXpKklPclqKDK%7C%7CgsiIHGD%7C%7CqoZ4Pa6C%7C%7CySJzwDJxnXG0XEPjkUWz6I+DuEs8fmY4SSqts9Q7ipiP7S7734wB4AGgShTDaXpA=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2Pk2GAlRNecaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfz1h5YIiVVxUZFZ4P0zcTrOMSDlW5qWaU+rN1jdj95Njk789KHwcYnWq8MIvVQmYdSgIGaYDG7uo+qhT5aGuO1lQpTaEW+oR9z5G7MqqS7Z0zYMh7+yBjFzqv8lgajtE8yUnJkosrJPUry5MY%7C%7CrzDc11sfwmAIgCifgK4+yzoTyVMkpzUmhbOBm+gtLjnb4XjWXtcDhl2kOqbYgrDm4%7C%7CoHSa8RUysNF5xdDkPYpS2v87uaXoR2MeAkFxhgNDtLWkugfsPE2z9lt82VmC77mcItAH48bUYKC5G4mkzyLCOfyLUrREACpfP93QclLeCd+8XsZJl717CP4b3EqR6FSqforA8jl2VDlfsSfbWsJnb%7C%7CGO3qGrw2CWjTjT9lQZye2aL+Ma91BezdaE7VstKC+QAJ8=.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PEvHA5RNucaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfjhl4I8vVVlRZFF%7C%7CNEPeTbyJSj5T5q2eV4Cn0TBn85NplLo1JHIXbXOo88UvOzjYMTIfQeoEH%7C%7Cbx7a8Koru5A2MGoyX9auctwCIPuM23TKNy2JAtrKSDjkC2ptZ%7C%7CIjNLvG0jJ00m7NPfvnw1UvfPMc9g+PAnEfEzhMQ65Oftxi2TBzUtLT9vAiicm7P+pdkltDOucTE1pkCFSoMaP208oHSallAysY5z38j3coRq5v05sqjSc20CRjFGrRc7vbCQjw75XXiH+2pF7lT6k56FW64Jl9CjAbbOcZW7gSLDbOaTQf1DVSdfUMP3VX2KOcO+HcFok5NAJt18jw2f3ie0UYX9xClyVThPojibIZ52c+en8Zyqyl%7C%7CxxDKL%7C%7CVFosu2aKuUKjmFT8fqe4AImLy2VU80Y.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2PEvHA5RNecaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfjlg5ostUlxXZFB4NEPcSLWJRT1R6auaVYCl0jZh855nl7g0KnIbZHKm9MYoOzjYMTIfQeoEH%7C%7Cbx7a8Koru5A2MGoyX9auctwCIPuM23TKNy2JAtrKSDjkC2ptV%7C%7CIjNLvG0jJ00m7NPfvnw1UvfPMc9g+PAnE%7C%7CEzhMQ65Oftxgi1PU8IXWd2Pim6m7OZntc7vxqucTE1pkCFSoMaP208oHSallAysY5z38j3coRq5v05sqjSc20CRjFGrRd2vrCEgAzpSXmH63JI7kTik527W+YIl9CjAbbOcZW7gSLDbOaTQf1DVSdfUMP3VXz4D6yDA8FOlad5Pascx0+4+yqEdb%7C%7CbzCJIJhp9jmWAM7RqUdXKzI6P6mPhxDKL%7C%7CVFosu2dLOEOjmFT8fqe4AImLy2VU80Y.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2Pk2GAlRNucaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfj9j4YMpVVVWZFd4OEfZQLWMSTlS76uaVICj0zJk855hnbczLXEfZnOv9MQuOzjYMTIfQeoEH%7C%7Cbx7a8Koru5A2MGoyX9auctwCIPuM23TKNy2JAtrKSLl0SxptZ%7C%7CIjNLvG0jJ00m7NPfvnw1UvfPMc9g+PAnHvEzhMQ65Oftxg6eKDo5Uj59QSfPm7OMneJUtRWucTE1pkCFSoMaP208oHSallAysY5z38j3coRq5v05sqjSc20CRjFGrSE7v7CcxA7HSTCExWJI7kTqkZ2FW6oIodCjAbbOcZW7gSLDbOaTQf1DVSdfUMP3VXvmcPeCCupQg7MbO+p4x1Cn9FHoTLzuyQlBPRFP2hiYVKsid6jFibe0o3rxxDKL%7C%7CVFosu3tKOZ%7C%7CjmFT8fqe4AImLy2VU80Y.jpeg?1',
  'https://cdn1.picuki.com/hosted-by-instagram/q=0exhNuNYnjBGZDHIdN5WmL9I2Pk2GAlRNucaS7j0nyZiNxIsbHWB58ltwdGn%7C%7CDh6Kwh9HS+Lfjtg4I4qVV5ZZFN8NUDaTreBRDpc7aiYVICh2zJg8p9ikbozL30bYnGs88srOzjYMTIfQeoEH%7C%7Cb2rvUW+PzwZDMBuDuXMOUtzCVG%7C%7CMm0X51wmcQf8fTT0FOzv9QONzUavDt5YnYmoeLSvmcDUufkM8lmpKw5QLsbhZNIuaHolST2F28pf2AwGTWL%7C%7CLTPnNEAhDe1JWVgvV6pRJY0J09Dj3GauwMGub8sjbCDDNU%7C%7C2+odhubSSGtafkNa9hc+h7actgLsLmOq3R4FjjWVzbvsIq4Zh5PRPP67QPTC23jTRbXUAa5WWG1CLqXpbHj6BcTiBpgPnLJoO+J9xEqt%7C%7ClTvc%7C%7Cb72U4nVxdrohepVNRPTf6i16agry%7C%7CWhmzcog==.jpeg?1',

];
//ruslana_kutsa