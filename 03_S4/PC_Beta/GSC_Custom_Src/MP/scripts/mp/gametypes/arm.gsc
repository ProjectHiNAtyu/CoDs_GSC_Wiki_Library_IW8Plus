//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//
// Project HiNAtyu
//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//

//=================================================================//
// [ English ]
// Creator       : HiNAtyu
// Created date  : 2025/04/02
// Latest update : 2025/04/02
// ---------------
// [ Japanese ]
// 制作者         : HiNAtyu
// 作成日         : 2025/04/02
// 更新日         : 2025/04/02
// ---------------
// [ Social ]
// YouTube  : http://www.youtube.com/channel/UCmxJAnVPtkStQVKrvAVMZSw?sub_confirmation=1
// Twitter1 : https://x.com/KonataGIF
// Twitter2 : https://twitter.com/H1NAtyu
// Discord  : hinatapoko （ https://discordapp.com/users/239453096026046464 ）
//=================================================================//

//:::::::::::::::::::::::::::::::::::::::::::::::::://
// [ English ]
//   < CoD GSC (C++) syntax explanation >
//     @ level                    = modifier for the entire room
//     @ level.players[i]         = 1 player participating in the room
//     @ self                     = myself where the function is being executed
//     @ thread                   = Execute the specified function in a subthread
//     @ Endon( "event_name" )    = Terminates function processing when the specified event name is issued.
//     @ WaitTill( "event_name" ) = Waits until the specified event name is issued, and then resumes subsequent processing
//     @ Notify( "event_name" )   = Publish the specified event name
//     @ Destroy( )               = Delete the specified variable and its actual state
//     @ IsDefined( variable )    = Check if the specified variable has been created
//     @ ^0                       = Color code (Black)
//     @ ^1                       = Color code (Red)
//     @ ^2                       = Color code (Green)
//     @ ^3                       = Color code (Yellow)
//     @ ^4                       = Color code (Blue)
//     @ ^5                       = Color code (Cyan)
//     @ ^6                       = Color code (Pink)
//     @ ^7                       = Color code (White)
//     @ wait                     = Wait for the specified time
// ---------------------------------------------
// [ Japanese ]
//   < CoD GSC (C++) 構文解説 >
//     @ level                    = 部屋全体に対する修飾子
//     @ level.players[i]         = 部屋に参加しているプレイヤー1個人
//     @ self                     = 関数が実行されている自分自身
//     @ thread                   = 指定した関数をサブスレッドで実行する
//     @ Endon( "event_name" )    = 指定したイベント名が発行されたら、関数の処理を終了する
//     @ WaitTill( "event_name" ) = 指定したイベント名が発行されるまで待機し、イベントが発行されたら、以降の処理を再開する
//     @ Notify( "event_name" )   = 指定したイベント名を発行する
//     @ Destroy( )               = 指定した変数とその実態を削除する
//     @ IsDefined( variable )    = 指定した変数が作成されているか調べる
//     @ ^0                       = カラーコード (黒)
//     @ ^1                       = カラーコード (赤)
//     @ ^2                       = カラーコード (緑)
//     @ ^3                       = カラーコード (黄色)
//     @ ^4                       = カラーコード (青)
//     @ ^5                       = カラーコード (水色)
//     @ ^6                       = カラーコード (ピンク)
//     @ ^7                       = カラーコード (白)
//     @ wait                     = 指定した時間分待機する
//:::::::::::::::::::::::::::::::::::::::::::::::::://





// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : The original GSC function (emptied to avoid DEV ERROR when called from an external class)
// ja : 元GSCの関数（外部クラスからのコール時のDEV ERROR回避用に空にする）
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



main(){}
_id_81CB(){}
_id_AB9A(){}
_id_FC7A(){}
_id_D5A0(){}
_id_515D(){}
_id_C4EE(){}
_id_4468(){}
_id_D8BA(){}
_id_D874(){}
_id_D88E(){}
_id_FC4F(){}
_id_6BE1(){}
_id_FD1A(){}
_id_CA5A( var_0 ){}
_id_A874(){}
_id_7345(){}
_id_FC66(){}
_id_D59C(){}
_id_E369(){}
_id_A87E(){}
_id_A880( var_0 ){}
_id_A883( var_0 ){}
_id_A884( var_0, var_1, var_2 ){}
_id_A882( var_0 ){}
_id_A885( var_0, var_1, var_2, var_3 ){}
_id_A87F( var_0 ){}
_id_A881( var_0 ){}
_id_4D20(){}
_id_CA5B( var_0, var_1 ){}
_id_5008( var_0, var_1, var_2 ){}
_id_4C32( var_0, var_1, var_2 ){}
_id_10B4( var_0 ){}
_id_500C( var_0 ){}
_id_C2B6(){}
_id_4485(){}
_id_3500( var_0 ){}
_id_501A( var_0 ){}
_id_35B7(){}
_id_5AC5( var_0 ){}
_id_35E3(){}
_id_CA3B( var_0, var_1, var_2 ){}
_id_6ABB( var_0 ){}
_id_BD64(){}
_id_2A24( var_0 ){}
_id_A6F1(){}
_id_A6F2(){}
_id_A707( var_0 ){}
_id_A70E( var_0 ){}
_id_A72F( var_0 ){}
_id_827A(){}
_id_2ED6( var_0 ){}
_id_6D2C(){}
_id_AB91(){}
_id_FCC0(){}
_id_AB5D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ){}
_id_9A03( var_0 ){}
_id_AB46( var_0 ){}
_id_AB50( var_0 ){}
_id_FC76(){}
_id_44A5(){}
_id_AB65( var_0 ){}
_id_6BE4( var_0 ){}
_id_6CD0(){}
_id_AB2C( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_827C(){}
_id_D709( var_0, var_1, var_2 ){}
_id_19C6(){}
_id_C525(){}
_id_E724(){}
_id_4CD0(){}
_id_532B(){}
_id_A214( var_0, var_1, var_2 ){}
_id_CA65(){}
_id_B8C8(){}
_id_1AED( var_0, var_1 ){}
_id_1AEE( var_0 ){}
_id_1AEB( var_0, var_1 ){}
_id_99FF(){}
_id_3F7E( var_0, var_1 ){}
_id_740A( var_0, var_1, var_2, var_3 ){}
_id_61F0(){}
_id_C4A9( var_0 ){}
_id_C4A8(){}
_id_E33B(){}
_id_8C89( var_0, var_1 ){}
_id_9539( var_0, var_1 ){}
_id_9538( var_0, var_1 ){}
_id_AE05( var_0, var_1 ){}
_id_445C(){}
_id_2DF3(){}
_id_99C8( var_0, var_1 ){}
_id_2DEB(){}
_id_1AE0( var_0 ){}
_id_899F( var_0 ){}
_id_C2B9( var_0, var_1, var_2 ){}
_id_7F8B(){}
_id_10344( var_0 ){}
_id_1034D( var_0, var_1 ){}
_id_10347( var_0, var_1 ){}
_id_10340( var_0, var_1 ){}
_id_1033E( var_0, var_1 ){}
_id_1033F( var_0, var_1 ){}
_id_10342( var_0, var_1 ){}
_id_10343( var_0, var_1 ){}
_id_10345( var_0, var_1 ){}
_id_1033D( var_0, var_1 ){}
_id_1034C( var_0, var_1 ){}
_id_10346( var_0, var_1 ){}
_id_10348( var_0, var_1 ){}
_id_10349( var_0, var_1 ){}
_id_1034A( var_0, var_1 ){}
_id_1034E( var_0, var_1 ){}
_id_1034B( var_0, var_1 ){}
_id_10028( var_0, var_1 ){}
_id_102E2( var_0 ){}
_id_1025D(){}
_id_10341( var_0 ){}
_id_504C( var_0 ){}
_id_10027( var_0, var_1 ){}
_id_102E1( var_0 ){}
_id_1025E(){}
_id_10232( var_0 ){}
_id_8066(){}
_id_10C24( var_0 ){}
_id_6C99( var_0, var_1 ){}
_id_1AEA(){}
_id_44CD( var_0 ){}
_id_893E( var_0 ){}
_id_2ECB( var_0 ){}
_id_3FCE( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 ){}
_id_2EC2(){}
_id_69FE(){}
_id_AAC1( var_0 ){}
_id_AAC3( var_0 ){}
_id_E031( var_0, var_1 ){}
_id_2EBF( var_0, var_1, var_2 ){}
_id_44DD( var_0, var_1, var_2 ){}
_id_6B41( var_0 ){}
_id_2EC5(){}
_id_2EBA( var_0, var_1 ){}
_id_E353(){}
