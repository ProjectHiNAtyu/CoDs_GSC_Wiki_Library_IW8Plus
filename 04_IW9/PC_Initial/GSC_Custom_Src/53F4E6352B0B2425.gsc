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



_id_6DCA6F439CA0A74F(){}
_id_B3E5599C9F6A8895( obj ){}
_id_04677A3D91779F0E(){}
_id_F0B5522EE5CE0CB1(){}
_id_40A17693396019A7(){}
_id_43733C2CD059B9C7( soundalias, targets ){}
_id_9185173EE7017A51( _id_972270FB4A04F3BF, _id_C09E956D9FBC81A6 ){}
_id_98147CDB66AA6506( soundalias, targets, _id_C09E956D9FBC81A6 ){}
_id_C5647295E3AC75DF( _id_972270FB4A04F3BF, notifyentity, notifystring, _id_C09E956D9FBC81A6 ){}
_id_A9BCFAFB96E69580( _id_972270FB4A04F3BF, _id_5B982A11C50C429E, _id_C09E956D9FBC81A6 ){}
_id_74726126B3D8B0AA( _id_972270FB4A04F3BF, _id_38887ADA292D9569, _id_C09E956D9FBC81A6 ){}
_id_62B51AA15506BCBC( _id_972270FB4A04F3BF ){}
_id_0F0A31C88DBF01C1( _id_972270FB4A04F3BF ){}
_id_A922099E0D89C828( targets ){}
_id_40970B59B11F71D3( soundalias, targets ){}
_id_C2524740DBF249BD( _id_879128515EC2CAA2 ){}
_id_3B12D9C60745E066( _id_972270FB4A04F3BF ){}
_id_E70D88E85D5FB19A( _id_972270FB4A04F3BF, volume, _id_149B29E625082ED4, _id_E54398BE13A5FF60, _id_847D2A046CAA4B54 ){}
_id_F54BDC273C4CA53A( _id_972270FB4A04F3BF ){}
_id_A2C9C85B2AF7C7FE( _id_972270FB4A04F3BF, pitch, _id_149B29E625082ED4, _id_E54398BE13A5FF60, _id_847D2A046CAA4B54 ){}
_id_FB2FB41AC5AB1D47(){}
_id_47659F446BF756A4(){}
_id_00202B3D1E393890( type ){}
_id_77D8A00D3187F85C( _id_972270FB4A04F3BF ){}
_id_21D5C74CFBF9EBCB( _id_FD2287F1DB15A3E0 ){}
_id_BF5653C442222AB8( _id_1B0E0F838932E059, _id_2DA794626CACA098, item ){}
_id_23A8F89921CEC8A3( _id_1B0E0F838932E059, _id_2DA794626CACA098, item ){}
_id_F6CEBFF1CB2AFECE(){}
_id_2743B5D65CB4AA61( ent, _id_B042AD1A3B3400E8, _id_71AE8CFAE0FB6EB7, _id_E959ADA5EF77E30A ){}
_id_32231133CCC402EE( soundalias, _id_B042AD1A3B3400E8, _id_71AE8CFAE0FB6EB7, _id_E959ADA5EF77E30A ){}
_id_3FAAAFC0BFA48453( ent ){}
_id_2A7A90760153D57B( _id_972270FB4A04F3BF, soundalias, _id_D8DBA5E985305199, _id_74B5B12BB6514385 ){}
_id_E1F20B9363CA750D( _id_972270FB4A04F3BF, _id_C09E956D9FBC81A6 ){}
_id_9DC92EE851117F94( soundalias, done ){}
_id_F5ABE4D9A18D99C7( done ){}
_id_FF4680A250FAB665( ent, _id_B042AD1A3B3400E8, _id_71AE8CFAE0FB6EB7, _id_E959ADA5EF77E30A ){}
_id_7940C57B609BED52( soundalias, _id_B042AD1A3B3400E8, _id_71AE8CFAE0FB6EB7, _id_E959ADA5EF77E30A ){}
_id_4269910FC1E0759F( ent ){}
_id_9802311630468F27( _id_972270FB4A04F3BF, soundalias, _id_D8DBA5E985305199, _id_74B5B12BB6514385 ){}
_id_E1AD0C284215F3B1( _id_972270FB4A04F3BF, _id_C09E956D9FBC81A6 ){}
_id_CFD6FC964DCA520A(){}
_id_D4503656FC0A9C48(){}
_id_6C8D0689823981AB(){}
_id_F94E1534DE6D5409( _id_669BE993DDE00B14 ){}
_id_D3655EAED7181B30( _id_B8E70FF71A02E32D ){}
_id_088C8B4D475D4CFD( _id_FD2287F1DB15A3E0, soundalias, _id_56CC972DF3606C48, _id_EE21476B751693AB ){}
_id_114485FECD709D37( _id_972270FB4A04F3BF, _id_C09E956D9FBC81A6 ){}
_id_0696597962461161( _id_972270FB4A04F3BF, notifyentity, notifystring, _id_C09E956D9FBC81A6 ){}
_id_EDDFE63D2DA7EE5C( _id_972270FB4A04F3BF, _id_38887ADA292D9569, _id_C09E956D9FBC81A6 ){}
_id_B1FD36299B09C0F5( _id_972270FB4A04F3BF, _id_D17EF5B1986147E1, _id_74B5B12BB6514385 ){}
_id_7670ACB4B00BB0AC( target ){}
_id_2E4EE66733C986EE( _id_DE4004608595AEC8 ){}
_id_FE69AE3B76D26EFA( target, dist, _id_057338C9E11B3E93, _id_90889775C87A2590, rotation ){}
_id_71B899D04C402BB5( _id_93FA9B11F85EC1A9 ){}
_id_5A53EF7BE394D4A8( soundalias, target, _id_A3BABC421280C85A, _id_4E43F4679036CDDB, _id_DE4004608595AEC8, _id_C1ACBB1D24B6EFC5 ){}
_id_15920617B1C19549( soundalias, target, spawntime, _id_4E43F4679036CDDB, rotation, _id_90889775C87A2590 ){}
_id_EE1F9B08B748B2BF( alias, tag, _id_49FDBA4C56715050, _id_B426F32755673BA6, _id_510AF7464E264F89 ){}
_id_EE9C171DB1AE676E( alias, _id_B426F32755673BA6 ){}
_id_4DF9EEE6E5769696( soundalias, notifystring, _id_FE0CDB15E0D3C83F ){}
_id_1CF95EA7031CF826( _id_BE3605030AEF1714, notifystring ){}
_id_F1FA7D6753F06A41( notetrack ){}
_id_A0B9C82D6558A5B5( _id_E54398BE13A5FF60, _id_A61C75B156FC1EE0 ){}
_id_301F98E25E20C1AB( _id_A61C75B156FC1EE0 ){}
_id_F3A9BB58D29C733A( alias ){}
_id_F17E814008BF23A4( _id_E54398BE13A5FF60 ){}
_id_115055E88972DE05( _id_E54398BE13A5FF60 ){}
_id_E6EF280F5472A1D2( _id_78172FA152CE9B61, _id_E54398BE13A5FF60 ){}
_id_B8022E006C096AA7( name ){}
_id_6833106B5E960C6B(){}
_id_DA383238AEE79A39(){}
_id_0AFA0D9063A40DFE( name ){}
_id_1BEC576D8688DBC1( name, _id_B5C1225C75A89360 ){}
_id_775073C6517CEB5E( name, _id_E76053C83C3FBAC3, _id_6E593C780632F83E ){}
_id_EEF3B433A76ADCA0( name, _id_8E053B475850D27C, _id_E40FFB8A0A4CDC32 ){}
_id_96D11F9981C0FE4B( name ){}
_id_40AC4860117F2C0E( name, _id_8E053B475850D27C, _id_B5C1225C75A89360, _id_E76053C83C3FBAC3, _id_E40FFB8A0A4CDC32, _id_6E593C780632F83E ){}
_id_FEB1A4F9EDA07B44( name ){}
_id_DB43AA8B88926353( name ){}
_id_1FC874CE2BD0CC74( _id_B5C1225C75A89360 ){}
_id_95848ECD26935B4B( _id_6E593C780632F83E ){}
_id_F2D694165B0E0E17( _id_6E593C780632F83E ){}
_id_BFAB56D23A4691F8( _id_6E593C780632F83E ){}
_id_AB6B2E892EE33FE3( _id_6E593C780632F83E ){}
_id_9AF2A1AE11395B08( _id_52901F31330A6489, _id_D8DBA5E985305199, _id_5C2B139A8E01D14B ){}
_id_D1642191E07FC7F0( _id_52901F31330A6489, _id_F69BA8D7B96E8326, _id_C8DE3D87B32F7596 ){}
_id_653BEDEE3BCC58BD( _id_7C649EC071EBCC7C, _id_6E593C780632F83E ){}
_id_28A90B1ADE70DC5C( _id_6E593C780632F83E ){}
_id_D80F1D438BDC691F( target, soundalias, _id_BB71B5EFDEEEE611, _id_270C723C3B5F910B ){}
_id_FD77BA9B1A318099( target, fadeout, _id_CFC29A1F6B1ADE48 ){}
_id_70FC1CABB1A0936C( target, alias, _id_BB71B5EFDEEEE611, _id_270C723C3B5F910B ){}
_id_AD44DAD83D5FA19E( _id_218E34A1D650F0C0, _id_4169A0A62719DB05, _id_D4AE98A76ADA6DF4, _id_723C5BF3E20D02B7, _id_9D165087BC5F007A, _id_1A3EA74C57CF7019, _id_083C847736BED906 ){}
_id_73239E48C1F6929B(){}
_id_C69EFDF57402F1C3( _id_6E593C780632F83E ){}
_id_3E1C8AD0ACE0B40A( _id_7C649EC071EBCC7C, _id_6E593C780632F83E ){}
_snd_doppler_main( player, _id_EBFB20D4964AE9EB, _id_1A1348BE52624ED9, _id_AA54CC5521FDB017 ){}
snd_doppler( _id_972270FB4A04F3BF, player, _id_EBFB20D4964AE9EB, _id_1A1348BE52624ED9, _id_AA54CC5521FDB017 ){}
snd_doppler_stop( _id_972270FB4A04F3BF ){}
_id_80AA5254A4D828D6( callback, _id_2339BD3DF9D7BC35 ){}
_id_C10AD7950DE75F96( callback, _id_2339BD3DF9D7BC35 ){}
_id_BAFBD550AB234C4F( trigger, player ){}
_id_63E183CD49335A12(){}
_id_CE7CBB5AAE13431E( callback ){}
_id_37A9B1E456BEB42A( callback, name, key ){}
_id_054C3FA447687F86( name, elements ){}
_id_0A694F301951B340( _id_F7806D4CF24AACD3 ){}
_id_1038BC878BFE6A5A( _id_F7806D4CF24AACD3 ){}
_id_54B7B0779DA7F0C0( player, _id_F7806D4CF24AACD3 ){}
_id_B73221ABA7AB22BC( _id_972270FB4A04F3BF, player, _id_C13FF1030606C1D6, _id_5E08EE058ABA29D3 ){}
_id_F4103B35BBE765F1( _id_972270FB4A04F3BF, player, _id_C13FF1030606C1D6, _id_5E08EE058ABA29D3 ){}
_id_90E41D6931D1D39B( _id_972270FB4A04F3BF ){}
_id_5B159F140BD186DF(){}
_id_1186CA4E2E51AFEA( name ){}
_id_0F1AED36AB4598EA( name ){}
_id_F4E0FF5CB899686D( name ){}
