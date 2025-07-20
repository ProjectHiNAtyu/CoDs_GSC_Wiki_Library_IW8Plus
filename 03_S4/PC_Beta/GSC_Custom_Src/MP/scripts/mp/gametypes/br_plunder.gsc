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



init(){}
_id_B91E( var_0, var_1, var_2 ){}
_id_9FF0( var_0, var_1 ){}
_id_D89B(){}
_id_829D(){}
_id_8259(){}
_id_B72C(){}
_id_B751(){}
_id_4A5A( var_0 ){}
_id_5218( var_0 ){}
_id_47D6( var_0 ){}
_id_47D5( var_0 ){}
_id_47D4(){}
_id_8241(){}
_id_B689(){}
_id_21B0(){}
_id_B68A( var_0, var_1 ){}
_id_EDCF( var_0 ){}
_id_824F(){}
_id_B743( var_0, var_1 ){}
_id_B737( var_0, var_1, var_2 ){}
_id_B733( var_0, var_1, var_2 ){}
_id_B73F( var_0, var_1 ){}
_id_B735( var_0, var_1, var_2 ){}
_id_B741( var_0, var_1, var_2 ){}
_id_B73D( var_0, var_1 ){}
_id_B739( var_0, var_1 ){}
_id_B73A( var_0, var_1, var_2, var_3 ){}
_id_FF51( var_0 ){}
_id_B744( var_0, var_1, var_2 ){}
_id_B738( var_0, var_1, var_2 ){}
_id_B734( var_0, var_1, var_2 ){}
_id_B740( var_0, var_1, var_2 ){}
_id_B736( var_0, var_1, var_2 ){}
_id_B742( var_0, var_1, var_2 ){}
_id_54EC( var_0 ){}
_id_54ED( var_0, var_1 ){}
_id_400F( var_0, var_1 ){}
_id_3D41( var_0, var_1, var_2 ){}
_id_B790( var_0, var_1 ){}
_id_B791( var_0 ){}
_id_6BE6( var_0, var_1, var_2, var_3 ){}
_id_B6A6(){}
_id_431E( var_0, var_1 ){}
_id_B72D(){}
_id_3E65(){}
_id_5033( var_0, var_1 ){}
_id_5032( var_0, var_1, var_2 ){}
_id_5006( var_0, var_1 ){}
_id_8997(){}
#using_animtree("mp_vehicles_always_loaded");
_id_818F(){}
#using_animtree("script_model");
_id_8190(){}
_id_8191(){}
_id_6C56(){}
_id_D899(){}
_id_6887(){}
_id_D53F( var_0 ){}
_id_44AC( var_0 ){}
_id_B963( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_B964( var_0, var_1, var_2, var_3 ){}
_id_B7E7(){}
_id_B67E( var_0, var_1 ){}
_id_402B( var_0 ){}
_id_B7BC( var_0, var_1 ){}
_id_6A08( var_0 ){}
_id_6944( var_0, var_1, var_2 ){}
_id_5010( var_0 ){}
_id_2EC4( var_0, var_1, var_2 ){}
_id_2EC3( var_0 ){}
_id_779F( var_0 ){}
_id_77CE( var_0 ){}
_id_774D( var_0 ){}
_id_E35F( var_0 ){}
_id_E2F7( var_0, var_1, var_2, var_3, var_4 ){}
_id_777B( var_0 ){}
_id_7780(){}
_id_774F(){}
_id_7798( var_0 ){}
_id_777D(){}
_id_777A( var_0 ){}
_id_2F1A( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 ){}
_id_77A7( var_0 ){}
_id_7688( var_0 ){}
_id_777F(){}
_id_77BA(){}
_id_77BC(){}
_id_77BB(){}
_id_54CE(){}
_id_7781(){}
_id_7782(){}
_id_F3C6( var_0 ){}
_id_F3C8( var_0 ){}
_id_77CF(){}
_id_7779( var_0, var_1 ){}
_id_779B( var_0 ){}
_id_774B( var_0 ){}
_id_B955(){}
_id_82BC(){}
_id_1F26(){}
_id_B67C(){}
_id_B73E( var_0 ){}
_id_8290(){}
_id_6C57( var_0 ){}
_id_B8AA( var_0, var_1 ){}
_id_BD55(){}
_id_BD54( var_0 ){}
_id_4413(){}
_id_B922(){}
_id_B921( var_0, var_1, var_2 ){}
_id_B92A( var_0, var_1 ){}
_id_B91D( var_0 ){}
_id_B931( var_0 ){}
_id_B919( var_0, var_1, var_2 ){}
_id_B91A( var_0, var_1, var_2, var_3 ){}
_id_B918( var_0, var_1, var_2 ){}
_id_B927( var_0, var_1 ){}
_id_B928( var_0, var_1, var_2 ){}
_id_B936( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_B934( var_0, var_1 ){}
_id_B935( var_0, var_1 ){}
_id_B938( var_0, var_1 ){}
_id_B932( var_0, var_1, var_2 ){}
_id_B92E( var_0, var_1 ){}
_id_B937( var_0, var_1 ){}
_id_B92F( var_0, var_1 ){}
_id_B92D( var_0 ){}
_id_B933( var_0, var_1, var_2 ){}
_id_B930( var_0 ){}
_id_B92C( var_0 ){}
_id_B929(){}
_id_B93E( var_0, var_1, var_2, var_3, var_4, var_5, var_6 ){}
_id_B91C( var_0, var_1 ){}
_id_B939( var_0 ){}
_id_B917( var_0 ){}
_id_B92B( var_0 ){}
_id_B93D( var_0, var_1 ){}
