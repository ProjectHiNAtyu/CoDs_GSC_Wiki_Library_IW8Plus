//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//
// Project HiNAtyu MWII SP FSTB GSC Mod Menu
//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//

//=================================================================//
// 
// [ Contact ]
// 
// Creator       : HiNAtyu Studio
// Update date   : 2024/05/25
// YouTube       : https://www.youtube.com/channel/UCmxJAnVPtkStQVKrvAVMZSw
// Twitter 1     : @KonataGIF ( https://x.com/KonataGIF )
// Twitter 2     : @H1NAtyu ( https://twitter.com/H1NAtyu )
// Discord       : hinatapoko ( https://discordapp.com/users/239453096026046464 )
// 
//=================================================================//

//=================================================================//
// 
// [ GSC Info ]
// 
// Game title         : Call of Duty : Modern Warfare II
// Game code          : IW9 / MW22 / CoD19
// Game released year : 2022
// Game mode          : SP ( Single Player / Campaign )
// 
//=================================================================//

//=================================================================//
// 
// [ Promotion ]
// 
// I'd be very happy if you could follow, subscribe, like, or comment on my various SNS accounts.
// If you like my work, I'd be happy if you could sponsor or donate.
// This will help facilitate the development of new features and fixes.
// 
// Ko-fi : https://ko-fi.com/hinatyustudio
// BTC   : 32J66dfWi9dqqWHS2RYR9rFCUNBL88vgUR
// ETH   : 0xaE5D5b3e8E865B2bA676a24eF41d5f4CBD315978
// 
//=================================================================//

//=================================================================//
// 
// [ Caution! ]
// 
// * This Injector was created for research, development, and educational purposes.
// * This Injector was created for free release purposes.
// * Unless there are significant bugs, I will not make fixes to the Injector.
// * I recommend using it only with the MWII SP Offline build.
// * It is not intended for use with any other games.
// * Any use for unintended purposes is always at your own risk.
// * If OneDrive is enabled, the software may not function properly, so please disable OneDrive if any issues occur.
// 
// * After using this Injector, be sure to restart your PC before playing other games.
// * Shutting down or unplugging the power will not initialize the driver, which increases the risk of a BAN.
// * Any BAN measures resulting from the use of this Injector are entirely at your own risk.
// 
// * To use this Face Injector on Windows 11, please use <MRON AIO FIXES.bat> distributed by MRON to fix your system.
// 
// * The driver for this Face Injector will be detected by the Retail Version of Call of Duty Ricochet.
// * Be sure to use this Injector only with an offline version of MWII SP!
// * If you use it with the Retail Version, the consequences are at your own risk.
// 
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



_id_F5154A3D477820D9(){}
_id_5634AD9C7902C703(){}
_id_D2B3539E8CDD93E7(){}
_id_6DE481EBC9A12469(){}
_id_F06047156C190734(){}
_id_E5312C6DFA471FDB(){}
_id_A06C6F8B2F6D82D0( direction ){}
_id_3893E3DB7E7694D5( target ){}
_id_A1B5CCD038B58C59( start, end, color, _id_CDC08C2C59A55365, _id_B7973E4DBA31564C, _id_3F809D1940BBAE5C, _id_FFB74DFE2FDAD3BE, duration ){}
get_average_origin( guys, max_count ){}
_id_7969D683DFC4FB9E( guys, max_count ){}
_id_25BC4D68CC6D7A4A(){}
_id_C5ECE4FA44D2894E(){}
_id_6C86247E5B5EB26D(){}
_id_E9B99C2D42EA8B56( other ){}
_id_4FDBCAA7C15F5B11(){}
_id_9485CA5CF96BD699(){}
_id_859D741DC99BF1A4(){}
_id_16C83724C6B1446D( enemy ){}
_id_003CC20D595E70F8(){}
_id_9B24C93B2BC885CF(){}
_id_656C8BA582163660( type ){}
_id_A7A911968F655267( type ){}
_id_A3B5180187A17623(){}
_id_8BDFF60054CE5866(){}
_id_C4E2E61A7CE330C0(){}
_id_42C77C7F13A1BEB8( _id_12853466CE806612 ){}
_id_453B3867C6EC0CEB( enemy, team, type ){}
_id_F649C4EF3ACDEC1D( team ){}
_id_D8ED6827953BCAC2(){}
_id_45B841E13DD6CF9C( root, _id_0E4731409BD255E0 ){}
_id_8271E180C87B8970(){}
_id_2008B43ADF7E18EF(){}
_id_7E6D670C76D60628(){}
_id_472B1D721B3B7618(){}
_id_03E144FDA9848FD5(){}
_id_479FA1BCEACAC04B(){}
_id_F06007E1F432CE27(){}
_id_1D268B003B51A5B3(){}
_id_01E4F162BF544387(){}
_id_E196D9B15E858B0F( players ){}
_id_E3A09AC9C428DBEA( array ){}
_id_842319303719440C(){}
_id_607FD7B62A18E9DC(){}
_id_1E0FD010AA69762D(){}
_id_C7DA930CD7BA754F(){}
_id_C315A1B81D2E3288(){}
_id_64D791A1D9D155B1(){}
_id_4DC52E4105914357(){}
_id_ABC132C5C51197C9( _id_4351410D12107DF3, _id_574307D4CDBDAC4C ){}
_id_BFFB62C0764278A7(){}
_id_BBB539FD7C238608(){}
_id_E46D9FD4C3250863(){}
_id_E906749F6343F822(){}
_id_4DFFA550C687B071(){}
_id_91AE298FCC3884C2( type, event ){}
_id_22D252D6CFA50EDD(){}
_id_E64DBAAAE396FBB8( previousstate ){}
_id_F6C7D545B09F9F0A(){}
_id_7CE36B78C85185C2(){}
_id_F4671F61A3031990(){}
_id_07CC890E658E3F93(){}
_id_1AE088B4C06D0525(){}
_id_8FA36B2CE712A5BB(){}
_id_BAA35784BE25B993( target ){}
_id_881AB22021BE3C6B( _id_56D4E883D1ED4129 ){}
_id_6237814879B07FBF(){}
_id_E2D4E5C64D62278E( other ){}
_id_79B973BC437563DB( _id_3DA06140A804E127 ){}
_id_51AC5B1DF7F85112( region, _id_168C108518D4BAC9 ){}
_id_4531D54403FE6D07( _id_3DA06140A804E127, _id_168C108518D4BAC9 ){}
_id_AC566E2D34BCCAA2( _id_9144967162969CD7, data ){}
_id_C1C2326DB1C9B81D( event, _id_9144967162969CD7, faction ){}
_id_21333116B170A5BB( faction, key, values ){}
_id_BD1704B44A1A730E(){}
