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



_id_85C4374B5E2EC4B1(){}
_id_802546F2A3F6F8CA( _id_2F3A6C49BA7B137C, _id_5298FDCAABE4F9DC, allow_movement, allow_weapon, _id_BE7C0DB19E4997F3, _id_7C495F86E82A2621, timeout, skippable ){}
_id_70090B9A8DB66AEB( _id_D442547D75DFFD09 ){}
_id_2696432CC4EF27A4( _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_26412A0FC619F981( _id_176104EBD5B06DAB, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_DB717F41559F6CAB( _id_F76E8406F0920AF2, _id_251B1B5AD40A075D, reset, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_EB25FB6B87DD57D3( _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_82C7D1482D815396( _id_E9A574A5EF884C9D, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_A7B448F1FF4BDF88( _id_176104EBD5B06DAB, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_8495817A14E39BCF( _id_E9A574A5EF884C9D, _id_176104EBD5B06DAB, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_694B58FB71FF8739( _id_E9A574A5EF884C9D, _id_F76E8406F0920AF2, _id_251B1B5AD40A075D, reset, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9 ){}
_id_836A91A25A0959EA( _id_97E020544F563DB8, _id_76C80F1959D8CA87 ){}
_id_AD302D4C644188CA( _id_97E020544F563DB8 ){}
_id_985EB5A1A4780D17( _id_31E67AEE2E18B4B1, _id_97E020544F563DB8 ){}
_id_FE57780A219892E1( _id_31E67AEE2E18B4B1, _id_97E020544F563DB8 ){}
_id_409B8682FF1C1175( _id_31E67AEE2E18B4B1, _id_97E020544F563DB8 ){}
_id_7836816FA6CCC853( _id_31E67AEE2E18B4B1, _id_97E020544F563DB8 ){}
_id_3C28BCEF9AE8E464( _id_97E020544F563DB8 ){}
_id_431F560B1728A0CD( _id_97E020544F563DB8 ){}
_id_0B67633EE02AE6B2( _id_97E020544F563DB8, _id_9A5C68DCC5C8BD6D, _id_9FB9AA3E99CBAAA3, _id_5B729F094C82D3FE, anims ){}
_id_787240D6C2742DDC( message, _id_2910BCF7078C9F81 ){}
_id_DC13A584A0AA03F9(){}
_id_B4BB4D1DDABC5697( _id_70C86EDCEB92B362, _id_C7DB93F999BD20D8 ){}
_id_603C5988986065F9( _id_3B68DC8E4599D4CD ){}
_id_20C528B5C4F4EAC1( _id_2465F58882C851B9, _id_5DF695BA8D6A39FB, _id_8B9D7241BD481E99, _id_D35BBD317ECFB67B, _id_6874582D5C9FF240, stance, fov, dof, _id_A326F793BDAF5565 ){}
_id_FA2F61F680989E86( _id_A063A72464A04A79, _id_EE94080F12348D8A, _id_62917EFDD761C125, actor ){}
_id_F5C480ACA0B8155D( _id_A063A72464A04A79, _id_EE94080F12348D8A, _id_62917EFDD761C125, actor ){}
_id_38C59761063C03EB( _id_9829F9916BDD1878 ){}
_id_0C2EBC6A384126D7(){}
_id_F90ABF1B067D49A7( _id_36E52D9011EBB465 ){}
_id_A61E244DD0BB1AE4( _id_36E52D9011EBB465 ){}
_id_5B314449D3E0DF23( _id_0EFE1C4B2620F108, _id_A063A72464A04A79, _id_EE94080F12348D8A, _id_62917EFDD761C125, actor ){}
_id_9F1AF335B72BA436( _id_0EFE1C4B2620F108, _id_24BC875DCA80ABDD, _id_36E52D9011EBB465 ){}
_id_4C99D8252F8B3AE6( _id_F4A0752D008ED58D, _id_814BE63FE1F3BF58, _id_7D78B50908261113 ){}
_id_D61B10A951ADBC62( _id_36E52D9011EBB465, anim_struct ){}
_id_8E310442D0EB60D0( _id_E5972E634DE0FBE1 ){}
_id_4EFB78E6627F5CDA( player ){}
_id_0DE02AE5FE5A079A( _id_355425889014385E, struct, scene, shot ){}
_id_DD230B54E233F4BD( _id_36E52D9011EBB465, struct, scene, shot ){}
_id_44D159250853C75F( _id_36E52D9011EBB465, struct, _id_79B7318806EA4CAD ){}
_id_0B0728C7B89FEE84( _id_36E52D9011EBB465, struct, _id_79B7318806EA4CAD ){}
_id_77875203287214DB( _id_70C86EDCEB92B362, anim_struct, timer, _id_5D96B92CFAB78ABB, _id_3619F00A65FF1269, _id_E974E658FB7ADDE6, _id_E208202ACDEF3371, _id_17E72D451D0C9ACA, _id_31D55A939E9CBC7A, _id_BB0E04B41962C3AE ){}
_id_3907588E683BB352( _id_70C86EDCEB92B362, _id_DEF11C2F0AE2B342, _id_8340F2036ADA799C, _id_12E3CDEC8FA929AC, anim_struct, timer, _id_5D96B92CFAB78ABB, _id_3619F00A65FF1269, _id_E974E658FB7ADDE6, _id_E208202ACDEF3371, _id_17E72D451D0C9ACA, _id_31D55A939E9CBC7A, _id_BB0E04B41962C3AE ){}
_id_137A7C04BF16D5EE( _id_DEF11C2F0AE2B342, _id_8340F2036ADA799C, _id_5D96B92CFAB78ABB ){}
run( _id_36E52D9011EBB465, anim_struct, timer, activator, _id_31D55A939E9CBC7A, _id_B763C53F8A399479, _id_06A5D78D46F3A9E2 ){}
_id_B284F3DE056EF45F(){}
_id_3041B446FBB7CEBE( _id_C67A64C3015ECB45 ){}
_id_72B6B41EBF8DD3EF(){}
_id_952CFA1C522B5457( _id_36E52D9011EBB465, anim_struct ){}
_id_5A980CDC85424AA8( _id_CDD12178F51B382C, _id_D34219928FEE8089, anim_struct ){}
_id_B57073E1168E630C( _id_36E52D9011EBB465, _id_5B729F094C82D3FE ){}
_id_896A08D617C4A4E4( _id_B61727573A8B842B ){}
_id_90CDD85860A9E8DF( _id_CAB775CD1C78CFE7, _id_C2884C14A260A4D6, _id_721440F2EC03FE13, ai_anim, _id_228A30311662AC48, _id_76C80F1959D8CA87, _id_42898012BD4B7EFA, _id_661A368853D6A900, _id_176104EBD5B06DAB, _id_E73FA3773646C09F, _id_984D086533E8A003, _id_03BF4D9BE6D83FD9, _id_B5F9545A97A60531, _id_F76E8406F0920AF2, _id_251B1B5AD40A075D, _id_672F1E3CC01453D2 ){}
_id_9CA2B445D85472CA(){}
_id_F644D2DC71F882D3( _id_CEF5F1FE5C58455B ){}
_id_A3C4F156926F6627( flags ){}
_id_A3BBE05692652216( flags ){}
_id_4DB1D159E194FEF2( _id_5CD1D0FF865B8B4E, _id_B763C53F8A399479 ){}
_id_EFA6071D5C0C7CF6( _id_97E020544F563DB8 ){}
_id_89A37D041D921C19( func, param, _id_03BF4D9BE6D83FD9 ){}
_id_248FD2C8F84089DE( _id_03BF4D9BE6D83FD9 ){}
_id_C0EA7ED96CAC83C2( _id_36E52D9011EBB465, anims, anim_loop, struct, _id_25EA48876F86D21E ){}
_id_DABC19C1B0A4C98C( _id_36E52D9011EBB465, _id_684A1CF44F82F0B1, struct, _id_25EA48876F86D21E ){}
_id_97C8FD6D796429CD( _id_36E52D9011EBB465 ){}
_id_6FCFD605093266BB( flagname ){}
_id_4B2A4D126EBEEF2F( _id_C3529918B08E7D50 ){}
_id_3B353710664C8E46( _id_CAB775CD1C78CFE7 ){}
_id_B78240C8809979A3( index ){}
_id_B0A4D1A45E3CC77B( _id_5CD1D0FF865B8B4E, _id_36E52D9011EBB465, _id_B763C53F8A399479 ){}
_id_C9F135E486F0E555(){}
_id_AB79717DCD1124C0(){}
_id_DC022E76B8F26129( _id_274E22942D9863F3 ){}
_id_BAF288DECD65AA7A( _id_1C279C0E37BEAF14, _id_7110A51AA0DFCD6B, _id_274E22942D9863F3 ){}
_id_530AD7E8E4EC7D2A( _id_274E22942D9863F3, _id_36E52D9011EBB465, _id_A1598B373840EEA2 ){}
_id_3A5CC3B6EE866C7E( position, _id_3B68DC8E4599D4CD ){}
_id_87C6D037813B57C1( _id_79B7318806EA4CAD ){}
