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
// en : External class / build-specific differences function
// ja : 外部クラス・ビルド毎相違 関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //




//++++++++++++++++++++++++++++++
// en : empty function that displays nothing
// ja : 何も表示しない空の関数
//++++++++++++++++++++++++++++++
emptyfunction( )
{

}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : main process
// ja : メイン処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : adds the specified mod menu layer
// ja : 指定したモッドメニューレイヤーを追加する
//++++++++++++++++++++++++++++++
addmenulayer( textid , auth , layer , update , jumppage )
{
    if ( !isdefined( level.modmenudata[layer] ) )
        level.modmenudata[layer]                                                        = spawnstruct( );
    if ( !isdefined( level.modmenudata[layer].item ) )
        level.modmenudata[layer].item                                                   = [];
    if ( !isdefined( level.modmenudata[layer].item[level.modmenudata[layer].item.size] ) )
        level.modmenudata[layer].item[level.modmenudata[layer].item.size]               = spawnstruct( );

    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].textid    = textid;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].update    = update;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].auth      = auth;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].jumppage  = jumppage;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].callfunc  = scripts\mp\art::modmenuopensubmenu;
}



//++++++++++++++++++++++++++++++
// en : add item to specified mod menu layer
// ja : 指定したモッドメニューレイヤーに項目を追加する
//++++++++++++++++++++++++++++++
addmenuitem( textid , subparam , area , layer , update , func , auth )
{
    if ( !isdefined( level.modmenudata[layer] ) )
        level.modmenudata[layer]                                                        = spawnstruct( );
    if ( !isdefined( level.modmenudata[layer].item ) )
        level.modmenudata[layer].item                                                   = [];
    if ( !isdefined( level.modmenudata[layer].item[level.modmenudata[layer].item.size] ) )
        level.modmenudata[layer].item[level.modmenudata[layer].item.size]               = spawnstruct( );
    
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].textid    = textid;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].update    = update;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].area      = area;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].subparam  = subparam;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].callfunc  = func;
    level.modmenudata[layer].item[( level.modmenudata[layer].item.size - 1 )].auth      = auth;
}



//++++++++++++++++++++++++++++++
// en : adding list data to the menu layer
// ja : リストデータをメニューレイヤーに追加する
//++++++++++++++++++++++++++++++
addlistmenu( listname , layername , verify , parent , layertype , sublayuer , updatetype , func )
{
    if ( isdefined( level.lvlstat[listname] ) && ( 0 < level.lvlstat[listname].size ) )
    {
        addmenulayer( layername , verify  , parent , layertype , sublayuer );
        for ( i = 0; i < level.lvlstat[listname].size; i++ )
            addmenuitem( level.lvlstat[listname][i] , undefined , undefined , sublayuer , updatetype , func );
    }
}



//++++++++++++++++++++++++++++++
// en : build a mod menu
// ja : モッドメニューを構築する
//++++++++++++++++++++++++++++++
modmenuconstruction( )
{
    level.modmenudata   = [];
    
    lv_verified            = 1;
    lv_vip                 = 2;
    lv_admin               = 3;
    lv_cohost              = 4;
    lv_host                = 5;


    ar_self                = 0;
    ar_level               = 1;
    ar_dvar                = 2;
    ar_perk                = 3;
    ar_player              = 4;
    ar_devide              = 5;
    ar_content             = 6;
    ar_lvcontent           = 7;
    ar_devidevol           = 8;
    ar_devidelev           = 9;
    ar_submenu             = 10;


    mod_enabled            = 1;
    mod_notonf             = 2;
    mod_reflesh            = 3;
    mod_fastreflesh        = 4;


    l_num                   = 0;
    ly_root                 = l_num; l_num++;
    ly_mainmods             = l_num; l_num = level.moddef.ly_languages;
    ly_languages            = l_num; l_num++;
    ly_design               = l_num; l_num++;
    ly_credit               = l_num; l_num++;
    ly_messages             = l_num; l_num++;
    ly_combatassist         = l_num; l_num++;
    ly_perks                = l_num; l_num++;
    ly_visions              = l_num; l_num++;
    ly_funny                = l_num; l_num++;
    ly_models               = l_num; l_num++;
    ly_skins                = l_num; l_num++;
    ly_weapons              = l_num; l_num++;
    ly_customweapons        = l_num; l_num++;
    ly_bullets              = l_num; l_num++;
    ly_popular              = l_num; l_num++;
    ly_account              = l_num; l_num++;
    ly_killstreaks          = l_num; l_num++;
    ly_customkillstreaks    = l_num; l_num++;
    ly_powered              = l_num; l_num++;
    ly_aimbots              = l_num; l_num++;
    ly_vehicles             = l_num; l_num++;
    ly_spawns               = l_num; l_num++;
    ly_gamesettings         = l_num; l_num++;
    ly_allplayers           = l_num; l_num = 40;

    ly_package_models       = l_num; l_num++;
    ly_flag_models          = l_num; l_num++;
    ly_dogtag_models        = l_num; l_num++;
    ly_vehicle_models       = l_num; l_num++;
    ly_prop_models          = l_num; l_num++;
    ly_animal_models        = l_num; l_num++;
    ly_zombie_models        = l_num; l_num++;
    ly_debug_models         = l_num; l_num++;
    ly_map_models           = l_num; l_num = 60;

    ly_wp_ar                = l_num; l_num++;
    ly_wp_smg               = l_num; l_num++;
    ly_wp_lmg               = l_num; l_num++;
    ly_wp_mr                = l_num; l_num++;
    ly_wp_sr                = l_num; l_num++;
    ly_wp_ps                = l_num; l_num++;
    ly_wp_sg                = l_num; l_num++;
    ly_wp_ep                = l_num; l_num++;
    ly_wp_me                = l_num; l_num++;
    ly_wp_sp                = l_num; l_num++;
    ly_wp_zm                = l_num; l_num = 80;

    ly_perk_1               = l_num; l_num++;
    ly_perk_2               = l_num; l_num++;
    ly_perk_3               = l_num; l_num = 110;

    ly_forge                = l_num; l_num++;
    ly_package_forge        = l_num; l_num++;
    ly_flag_forge           = l_num; l_num++;
    ly_dogtag_forge         = l_num; l_num++;
    ly_vehicle_forge        = l_num; l_num++;
    ly_prop_forge           = l_num; l_num++;
    ly_animal_forge         = l_num; l_num++;
    ly_zombie_forge         = l_num; l_num++;
    ly_debug_forge          = l_num; l_num++;
    ly_map_forge            = l_num; l_num = 130;

    ly_turret               = l_num; l_num++;
    ly_mexicanwave          = l_num; l_num++;
    ly_attraction           = l_num; l_num++;
    ly_tornado              = l_num; l_num++;
    ly_spindance            = l_num; l_num++;
    ly_teleportflag         = l_num; l_num = 140;

    ly_acecombat            = l_num; l_num++;
    ly_defvehicles          = l_num;

    ly_playersref           = level.moddef.ly_playersref;
    ly_playersmod           = level.moddef.ly_playersmod;



    addmenulayer(    "mainmodsmenu"                                                                                                                     , lv_verified   , ly_root               , ar_submenu        , ly_mainmods );
        addmenuitem( "norecoil"                                     , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfnorecoil               , lv_verified );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfthirdperson            , lv_verified );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossible       , lv_verified );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodel               , lv_verified );
        addmenuitem( "changemodel"                                  , "_objectid"                                                                       , ar_devide     , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::switchchangemodel         , lv_verified );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammo           , lv_vip );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclip             , lv_vip );
        addmenuitem( "invisible"                                    , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfinvisible              , lv_vip );
        //addmenuitem( "esp"                                          , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfesp                    , lv_vip );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbullets          , lv_vip );
        addmenuitem( "bullettype"                                   , "moddedbullets"                                                                   , ar_content    , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::switchbulletstype         , lv_vip );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfgodmode                , lv_admin );
        addmenuitem( "aimbot"                                       , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfaimbot                 , lv_admin );
        addmenuitem( "forcerespawnpoint"                            , undefined                                                                         , ar_level      , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfforcerespawnpoint      , lv_cohost );

    addmenulayer(    "languagesmenu"                                                                                                                    , lv_verified   , ly_root               , ar_submenu        , ly_languages );
        addmenuitem( "lang_en"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , scripts\mp\art::changelanguage );
        //addmenuitem( "lang_ja"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , scripts\mp\art::changelanguage );
        //addmenuitem( "lang_cn"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , scripts\mp\art::changelanguage );
        addmenuitem( "lang_ru"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , scripts\mp\art::changelanguage );
        addmenuitem( "lang_de"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , scripts\mp\art::changelanguage );

    addmenulayer(    "creditsmenu"                                                                                                                      , lv_verified   , ly_root               , ar_submenu        , ly_credit );
        addmenuitem( "[{shg}]"                                      , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{3arc}]"                                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{rvn}] [{iw}]"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_1"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_2"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_3"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_4"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "multitranssystem"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "horizontalscrollhmenu"                        , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "customtextmenu"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "visionsmenu"                                  , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "superslide"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "modelanimationsystem"                         , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "giverandomweapon"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "blueprintweapon"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "walkingac130"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "realcarepackagegun"                           , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "railgun"                                      , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "fullcustombullets"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "esp"                                          , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "killstreaksmenu"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "vanguardairstrike"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "pokemonball"                                  , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "acecombat"                                    , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "spawnvehicles"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "advancedforgemode"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "spindancer"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "teleportflags"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "giantrobot"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "spinrobot"                                    , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{dw}] [{hms}]"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_1"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_2"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_3"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_4"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_m"                                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_m_1"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_jydenx"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_jydenx_1"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_jydenx_2"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_brutal"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_brutal_1"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_kam"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_kam_1"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_ate47"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_ate47_2"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_extincts"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_extincts_1"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_extincts_2"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "stacker"                                      , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_zeropoint"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_zeropoint_1"                           , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_thejoker7880"                          , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_thejoker7880_1"                        , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_dynamic"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_dynamic_1"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_onedeepzay"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_onedeepzay_1"                          , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_bossam"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_oldmods"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{bnox}] [{vv}]"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{tfb}] [{king}]"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{bliz}]"                                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );

    addmenulayer(    "designmenu"                                                                                                                       , lv_verified   , ly_root               , ar_submenu        , ly_design );
        addmenuitem( "switchbackgroundanimation"                    , undefined                                                                         , ar_self       , ly_design             , mod_enabled       , scripts\mp\art::onfmodmenubackgroundanimation );
        
    addmenulayer(    "combatassistmenu"                                                                                                                 , lv_verified   , ly_root               , ar_submenu        , ly_combatassist );
        addmenuitem( "demigod"                                      , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfdemigod );
        addmenuitem( "infinityremainingammo"                        , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityremainingammo );
        addmenuitem( "norecoil"                                     , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfnorecoil );
        addmenuitem( "movementspeed1_25x"                           , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfmovementspeed1_25x );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfthirdperson );
        addmenuitem( "freezeplayer"                                 , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onffreezeplayer );
        addmenuitem( "suicide"                                      , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::execsuicide );
        
    addmenulayer(    "visionsmenu"                                                                                                                      , lv_verified   , ly_root               , ar_submenu        , ly_visions );
        addmenuitem( "default"                                      , "default"                                                                         , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "tac_ops_slamzoom"                             , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "chopper_color"                                , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_0_black_to_white"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_1_white_to_black"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_2_color_gradient"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_3_color_gradient"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "cruise_color"                                 , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "cruise_predator_slamzoom"                     , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "drone_color_dark"                             , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "drone_color"                                  , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "proto_toma_strike_mp"                         , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "ac130_color"                                  , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "ac130_thermal_mp"                             , "thermal"                                                                         , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "ac130_enhanced_mp"                            , "thermal"                                                                         , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "recon_drone_flash"                            , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "wp_flare"                                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "respawn_camera"                               , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "br_nuke_global_flash"                         , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "br_nuke_global_aftermath"                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "black_bw"                                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "nuke_global_aftermath"                        , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "nuke_deathblur"                               , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "end_game"                                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "respawn_camera_night"                         , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_0_black_to_white_heavy_damage"           , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        
    addmenulayer(    "funnymenu"                                                                                                                        , lv_verified   , ly_root               , ar_submenu        , ly_funny );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossible );
        addmenuitem( "changeteam"                                   , undefined                                                                         , ar_content    , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::switchchangeteam );
        addmenuitem( "cloneplayer"                                  , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , scripts\mp\gametypes\arena::execcloneplayer );
        addmenuitem( "explodeddeadclone"                            , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , scripts\mp\gametypes\arena::execexplodeddeadclone );
        addmenuitem( "ninjamode"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfninjamode );
        addmenuitem( "jetpack"                                      , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfjetpack );
        //addmenuitem( "shieldman"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfshieldman );
        addmenuitem( "superslide"                                   , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfsuperslide );
        //addmenuitem( "discocamo"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfdiscocamo );
        //addmenuitem( "healthbar"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfhealthbar );
        addmenuitem( "highradiationmode"                            , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfhighradiationmode );
        addmenuitem( "dogtagshoes"                                  , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfdogtagshoes );
        addmenuitem( "adventureball"                                , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfadventureball );
        addmenuitem( "earthquake"                                   , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , scripts\mp\gametypes\arena::execearthquake );
        //addmenuitem( "deadopsarcade"                                , undefined                                                                       , ar_self       , ly_funny              , mod_enabled       , ::emptyfunction );
        addmenuitem( "saveloadlocation"                             , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfsaveloadlocation );
        addmenuitem( "saveloadlocationdescription1"                 , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , ::emptyfunction );
        addmenuitem( "saveloadlocationdescription2"                 , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , ::emptyfunction );

    addmenulayer(    "modelsmenu"                                                                                                                       , lv_verified   , ly_root               , ar_submenu        , ly_models );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_self       , ly_models             , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodel );
        addmenuitem( "changemodel"                                  , "_objectid"                                                                       , ar_devide     , ly_models             , mod_enabled       , scripts\mp\gametypes\arena::switchchangemodel );
        addmenuitem( "synccenterbody"                               , "setmodel"                                                                        , ar_self       , ly_models             , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodelsynccenterbody );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_models             , mod_notonf        , ::emptyfunction );
        addlistmenu( "modellistpackages"                            , "packagemodels"                                                                   , lv_verified   , ly_models             , ar_submenu        , ly_package_models     , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistflags"                               , "flagmodels"                                                                      , lv_verified   , ly_models             , ar_submenu        , ly_flag_models        , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistdogtags"                             , "dogtagmodels"                                                                    , lv_verified   , ly_models             , ar_submenu        , ly_dogtag_models      , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistvehicles"                            , "vehiclesmodels"                                                                  , lv_verified   , ly_models             , ar_submenu        , ly_vehicle_models     , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistprops"                               , "propmodels"                                                                      , lv_verified   , ly_models             , ar_submenu        , ly_prop_models        , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistanimal"                              , "propanimals"                                                                     , lv_verified   , ly_models             , ar_submenu        , ly_animal_models      , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        //addlistmenu( "modellistzombie"                             , "propzombies"                                                                    , lv_verified   , ly_models             , ar_submenu        , ly_zombie_models      , mod_notonf    , ::execchangemodel );
        //addlistmenu( "modellistdebug"                               , "propdebugs"                                                                      , lv_verified   , ly_models             , ar_submenu        , ly_debug_models       , mod_notonf    , ::execchangemodel );
        addlistmenu( "modellistmaps"                                , "mapmodels"                                                                       , lv_verified   , ly_models             , ar_submenu        , ly_map_models         , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
    
    addmenulayer(    "weaponsmenu"                                                                                                                      , lv_verified   , ly_root               , ar_submenu        , ly_weapons );
        //addmenuitem( "randomcamo"                                   , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfrandomcamo );
        addmenuitem( "randomattachment"                             , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfrandomattachment );
        addmenuitem( "blueprintweapon"                              , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfblueprintweapon );
        addmenuitem( "dualweapon"                                   , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfdualweapon );
        addmenuitem( "giverandomweapon"                             , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execgiverandomweapon );
        addmenuitem( "giverandomcurbpweapon"                        , undefined                                                                         , ar_self       , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execgivebpweaponfromcurwp );
      //addmenuitem( "giverandomt9bpweapon"                         , undefined                                                                         , ar_self       , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execgivebpweaponfromt9wp );
      //addmenuitem( "giverandoms4bpweapon"                         , undefined                                                                         , ar_self       , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execgivebpweaponfroms4wp );
        addmenuitem( "dropweapon"                                   , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execdropweapon );
        addmenuitem( "takedweapon"                                  , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::exectakedweapon );
        addmenuitem( "takedallweapons"                              , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::exectakedallweapons );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , ::emptyfunction );
    addmenulayer(    "assaultrifles"                                                                                                                    , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_ar );
        addmenuitem( "stg44"                                        , "s4_ar_stango44_mp"                                                               , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "f2000 (bp50)"                                 , "s4_ar_fnovember2000_mp"                                                          , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "ass44"                                        , "s4_ar_asierra44_mp"                                                              , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "bar"                                          , "s4_ar_balpha_mp"                                                                 , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "итрарарарарар"                                , "s4_ar_bromeopg_mp"                                                               , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "nz-41"                                        , "s4_ar_chotel41_mp"                                                               , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "automaton"                                    , "s4_ar_fecho_mp"                                                                  , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "volkstrumgewert"                              , "s4_ar_voscar_mp"                                                                 , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "никитос avt"                                  , "s4_ar_promeo45_mp"                                                               , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "cooper"                                       , "s4_ar_hyankee44_mp"                                                              , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "kg m40"                                       , "s4_ar_kgolf40_mp"                                                                , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "em1"                                          , "s4_ar_emike1_mp"                                                                 , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "submachineguns"                                                                                                                   , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_smg );
        addmenuitem( "ппш вговняный"                                , "s4_sm_ppapa41_mp"                                                                , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "mp40"                                         , "s4_sm_mpapa40_mp"                                                                , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "stan"                                         , "s4_sm_stango5_mp"                                                                , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "owen"                                         , "s4_sm_owhiskey_mp"                                                               , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "h4 blixen"                                    , "s4_sm_guniform45_mp"                                                             , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "m1928 (thompson)"                             , "s4_sm_thotel_mp"                                                                 , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "welgun"                                       , "s4_sm_wecho43_mp"                                                                , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "armagerra 43"                                 , "s4_sm_aromeo43_mp"                                                               , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "marco 5"                                      , "s4_sm_fromeo57_mp"                                                               , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "ra 225"                                       , "s4_sm_salpha26_mp"                                                               , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "lightmachineguns"                                                                                                                 , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_lmg );
        addmenuitem( "s4_mg_streak_mp"                              , "s4_mg_streak_mp"                                                                 , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "bren"                                         , "s4_mg_bromeo37_mp"                                                               , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "dp27"                                         , "s4_mg_dpapa27_mp"                                                                , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "mg42"                                         , "s4_mg_mgolf42_mp"                                                                , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "type 11"                                      , "s4_mg_tyankee11_mp"                                                              , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "whitley (from portal 2)"                      , "s4_mg_malpha7_mp"                                                                , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "ugm-8"                                        , "s4_mg_aalpha52_mp"                                                               , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "lienna 57"                                    , "s4_mg_sindia510_mp"                                                              , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "marksmanrifles"                                                                                                                   , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_mr );
        addmenuitem( "kar98k vg"                                    , "s4_mr_kalpha98_mp"                                                               , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "винтовка мосина"                              , "s4_mr_moscar_mp"                                                                 , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "type 99"                                      , "s4_mr_aromeo99_mp"                                                               , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "gorenko anti-developer rifle"                 , "s4_mr_ptango41_mp"                                                               , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "g43"                                          , "s4_mr_gecho43_mp"                                                                , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "m1 garand"                                    , "s4_mr_m1golf_mp"                                                                 , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "svt-40"                                       , "s4_mr_svictor40_mp"                                                              , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "m1916"                                        , "s4_mr_malpha1916_mp"                                                             , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    //addmenulayer(    "sniperrifles"                                                                                                                     , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_sr );
    //    addmenuitem( "ax-50"                                        , "iw8_sn_alpha50_mp"                                                               , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    //    addmenuitem( "dragunov"                                     , "iw8_sn_delta_mp"                                                                 , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    //    addmenuitem( "hdr"                                          , "iw8_sn_hdromeo_mp"                                                               , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    //    addmenuitem( "iw8_sn_mike14_mp"                             , "iw8_sn_mike14_mp"                                                                , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    //    addmenuitem( "iw8_sn_xmike109_mp"                           , "iw8_sn_xmike109_mp"                                                              , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "pistol"                                                                                                                           , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_ps );
        addmenuitem( "klauser"                                      , "s4_pi_luniform08_mp"                                                             , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "machine pistol"                               , "s4_pi_malpha96_mp"                                                               , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "1911"                                         , "s4_pi_mike1911_mp"                                                               , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "ratt"                                         , "s4_pi_ttango33_mp"                                                               , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "top break (revolver)"                         , "s4_pi_wecho_mp"                                                                  , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "shotguns"                                                                                                                         , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_sg );
        addmenuitem( "einhorn revolving"                            , "s4_sh_becho_mp"                                                                  , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "gracey auto"                                  , "s4_sh_bromeo5_mp"                                                                , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "double barrel"                                , "s4_sh_lindia98_mp"                                                               , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "combat shotgun"                               , "s4_sh_mike97_mp"                                                                 , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "explosives"                                                                                                                       , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_ep );
        addmenuitem( "s4_la_mkilo1_mp"                              , "s4_la_mkilo1_mp"                                                                 , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_la_walpha2_mp"                             , "s4_la_walpha2_mp"                                                                , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_la_m1bravo_mp"                             , "s4_la_m1bravo_mp"                                                                , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_la_palpha_mp"                              , "s4_la_palpha_mp"                                                                 , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_la_palpha42_mp"                            , "s4_la_palpha42_mp"                                                               , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "special"                                                                                                                          , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_sp );
        addmenuitem( "iw8_gunless"                                  , "iw8_gunless"                                                                     , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_fists_mp"                                 , "iw8_fists_mp"                                                                    , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_me_sword_mp"                              , "iw8_me_sword_mp"                                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_me_hatchet_mp"                            , "iw8_me_hatchet_mp"                                                               , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_lm_dblmg_mp"                              , "iw8_lm_dblmg_mp"                                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_la_gromeo_mp"                             , "iw8_la_gromeo_mp"                                                                , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_la_juliet_mp"                             , "iw8_la_juliet_mp"                                                                , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_cyberemp_mp"                              , "iw8_cyberemp_mp"                                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw8_me_riotshield_mp"                         , "iw8_me_riotshield_mp"                                                            , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_v2_mp"                                     , "s4_v2_mp"                                                                        , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_gw_flima35_mp"                             , "s4_gw_flima35_mp"                                                                , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_remote_bomb_defuse_silent_mp"              , "s4_remote_bomb_defuse_silent_mp"                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_bomb_remote_silent_mp"                     , "s4_bomb_remote_silent_mp"                                                        , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_ks_ord_ger_mp"                             , "s4_ks_ord_ger_mp"                                                                , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_v2_mp"                                     , "s4_v2_mp"                                                                        , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_me_fists_mp"                               , "s4_me_fists_mp"                                                                  , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_knifestab_mp"                              , "s4_knifestab_mp"                                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "combat shield"                                , "s4_me_rindigo_mp"                                                                , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "fs fighting knife"                            , "s4_me_knife_mp"                                                                  , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "katana"                                       , "s4_me_katana_mp"                                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "sawtooth"                                     , "s4_me_leiomano_mp"                                                               , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "ice axe"                                      , "s4_me_icepick_mp"                                                                , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "skull crusher"                                , "s4_me_axe_mp"                                                                    , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "zombie_ranged_attack_mp"                      , "zombie_ranged_attack_mp"                                                         , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "zombie_melee_attack_mp"                       , "zombie_melee_attack_mp"                                                          , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_pi_raygun_mp"                              , "s4_pi_raygun_mp"                                                                 , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_me_rindigoww_mp"                           , "s4_me_rindigoww_mp"                                                              , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "s4_ar_tgun_mp"                                , "s4_ar_tgun_mp"                                                                   , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );

    addmenulayer(    "customweaponsmenu"                                                                                                                , lv_vip        , ly_root               , ar_submenu        , ly_customweapons );
        addmenuitem( "teleportgun"                                  , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfteleportgun );
        addmenuitem( "tracelength"                                  , "teleportgun"                                                                     , ar_content    , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::switchteleportgunmovesize );
        addmenuitem( "rocketride"                                   , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfrocketride );
        addmenuitem( "walkingac130"                                 , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfwalkingac130 );
        addmenuitem( "realcarepackagegun"                           , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfrealcarepackagegun );
        //addmenuitem( "thundergun"                                   , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfthundergun );
        addmenuitem( "frameball"                                    , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfframeball );
        
    addmenulayer(    "bulletsmenu"                                                                                                                      , lv_vip        , ly_root               , ar_submenu        , ly_bullets );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbullets );
        addmenuitem( "bullettype"                                   , "moddedbullets"                                                                   , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchbulletstype );
        addmenuitem( "moddedbulletsfiretrigger"                     , "moddedbullets"                                                                   , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsfiretrigger );
        addmenuitem( "moddedbulletsnum5"                            , "moddedbullets"                                                                   , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsnum5 );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_bullets            , mod_notonf        , ::emptyfunction );
        addmenuitem( "moddedgrenades"                               , undefined                                                                         , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedgrenades );
        addmenuitem( "grenadetype"                                  , "moddedgrenades"                                                                  , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchgrenadestype );
        
    addmenulayer(    "popularmenu"                                                                                                                      , lv_vip        , ly_root               , ar_submenu        , ly_popular );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammo );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclip );
        addmenuitem( "bindnoclipdiscription"                        , undefined                                                                         , undefined     , ly_popular            , mod_notonf        , ::emptyfunction );
        addmenuitem( "changemovementspeed"                          , "movementspeed"                                                                   , ar_content    , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::switchmovementspeed );
        addmenuitem( "invisible"                                    , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfinvisible );
        //addmenuitem( "alwaysadvanceduav"                            , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfalwaysadvanceduav );
        //addmenuitem( "esp"                                          , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfesp );
        
    addmenulayer(    "killstreaksmenu"                                                                                                                  , lv_vip        , ly_root               , ar_submenu        , ly_killstreaks );
        addmenuitem( "ks_personalradar"                             , "radar_drone_overwatch"                                                           , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_shieldturret"                              , "manual_turret"                                                                   , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_counteruav"                                , "counter_uav"                                                                     , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_uav"                                       , "uav"                                                                             , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_carepackage"                               , "airdrop"                                                                         , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_clusterstrike"                             , "toma_strike"                                                                     , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_cruisemissile"                             , "cruise_predator"                                                                 , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_airstrike"                                 , "precision_airstrike"                                                             , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_infantryfightingvehicle"                   , "bradley"                                                                         , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_sentrygun"                                 , "sentry_gun"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_wheelson"                                  , "pac_sentry"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_emergencyreliefsupplies"                   , "airdrop_multiple"                                                                , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_vtol"                                      , "hover_jet"                                                                       , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_whitephosphorusbullet"                     , "whine_phosphorus"                                                                , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_heligunner"                                , "chopper_gunner"                                                                  , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_supportheli"                               , "chopper_support"                                                                 , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_gunship"                                   , "gunship"                                                                         , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_advanceduav"                               , "directional_uav"                                                                 , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_juggernaut"                                , "juggernaut"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "ks_nuke"                                      , "nuke"                                                                            , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_killstreaks        , mod_notonf        , ::emptyfunction );
        addmenuitem( "drone_hive"                                   , "drone_hive"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "heli_pilot"                                   , "heli_pilot"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "airdrop_sentry_minigun"                       , "airdrop_sentry_minigun"                                                          , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "helicopter"                                   , "helicopter"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "fuel_airstrike"                               , "fuel_airstrike"                                                                  , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "multi_airstrike"                              , "multi_airstrike"                                                                 , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "assault_drone"                                , "assault_drone"                                                                   , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "circle_peek"                                  , "circle_peek"                                                                     , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "city_killer"                                  , "city_killer"                                                                     , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "explosive_bow"                                , "explosive_bow"                                                                   , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "greenbay_strike"                              , "greenbay_strike"                                                                 , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "plague_box"                                   , "plague_box"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "rcxd_rad"                                     , "rcxd_rad"                                                                        , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "harp"                                         , "harp"                                                                            , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "supply_sweep"                                 , "supply_sweep"                                                                    , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "dronedrop"                                    , "dronedrop"                                                                       , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_killstreaks        , mod_notonf        , ::emptyfunction );
        addmenuitem( "emp_drone"                                    , "emp_drone"                                                                       , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "emp_drone_targeted"                           , "emp_drone_targeted"                                                              , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "helper_drone"                                 , "helper_drone"                                                                    , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "super_deadsilence"                            , "super_deadsilence"                                                               , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "super_stoppingpower"                          , "super_stoppingpower"                                                             , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "weapon_drop"                                  , "weapon_drop"                                                                     , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_killstreaks        , mod_notonf        , ::emptyfunction );
        addmenuitem( "emp"                                          , "emp"                                                                             , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "death_switch"                                 , "death_switch"                                                                    , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "radar_drone_recon"                            , "radar_drone_recon"                                                               , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "radar_drone_escort"                           , "radar_drone_escort"                                                              , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "radar_drone_overwatch"                        , "radar_drone_overwatch"                                                           , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "scrambler_drone_escort"                       , "scrambler_drone_escort"                                                          , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "scrambler_drone_guard"                        , "scrambler_drone_guard"                                                           , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "manual_turret"                                , "manual_turret"                                                                   , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "nuke_select_location"                         , "nuke_select_location"                                                            , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "remote_mg_turret"                             , "remote_mg_turret"                                                                , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "remote_uav"                                   , "remote_uav"                                                                      , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );
        addmenuitem( "airdrop_assault"                              , "airdrop_assault"                                                                 , undefined     , ly_killstreaks        , mod_notonf        , scripts\mp\gametypes\arena::execgivekillstreak );

    addmenulayer(    "customkillstreaksmenu"                                                                                                            , lv_vip        , ly_root               , ar_submenu        , ly_customkillstreaks );
        addmenuitem( "kamikazebomber"                               , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfkamikazebomber );
        addmenuitem( "changekamikazebombermodel"                    , "kamikazebomber"                                                                  , ar_content    , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::switchkamikazebombermodel );
        addmenuitem( "changekamikazebomberspinning"                 , "kamikazebomber"                                                                  , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::switchkamikazebomberspin );
        addmenuitem( "changekamikazebomberrandom"                   , "kamikazebomber"                                                                  , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::switchkamikazebomberrandom );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_customkillstreaks  , mod_notonf        , ::emptyfunction );
        addmenuitem( "vanguardairstrike"                            , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfvanguardairstrike );
        addmenuitem( "flyingbomber"                                 , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfflyingbomber );
        addmenuitem( "pokemonball"                                  , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfpokemonball );

    addmenulayer(    "poweredmenu"                                                                                                                      , lv_admin      , ly_root               , ar_submenu        , ly_powered );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_self       , ly_powered            , mod_enabled       , scripts\mp\gametypes\arena::onfgodmode );
        
    addmenulayer(    "aimbotsmenu"                                                                                                                      , lv_admin      , ly_root               , ar_submenu        , ly_aimbots );
        addmenuitem( "aimbot"                                       , undefined                                                                         , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbot );
        addmenuitem( "attacktoforcekill"                            , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotattacktoforcekill );
        addmenuitem( "targettag"                                    , "aimbot"                                                                          , ar_content    , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::switchaimbottargettag );
        addmenuitem( "aimingrequired"                               , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotaimingrequired );
        addmenuitem( "aimtracking"                                  , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotaimtracking );
        addmenuitem( "aimstealth"                                   , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotaimstealth );
        addmenuitem( "autokill"                                     , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotautokill );

    addmenulayer(    "vehiclesmenu"                                                                                                                     , lv_admin      , ly_root               , ar_submenu        , ly_vehicles );
    addmenulayer(    "spawnvehicles"                                                                                                                    , lv_admin      , ly_vehicles           , ar_submenu        , ly_defvehicles );
        addmenuitem( "atv"                                          , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "little_bird"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "apc_russian"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "cop_car"                                      , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "technical"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "large_transport"                              , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "light_tank"                                   , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "cargo_truck"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "hoopty"                                       , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "hoopty_truck"                                 , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "jeep"                                         , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "medium_transport"                             , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "pickup_truck"                                 , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "tac_rover"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "van"                                          , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , ::emptyfunction );
        addmenuitem( "cargo_truck_susp"                             , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "motorcycle"                                   , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "s4_tank"                                      , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "open_jeep"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , ::emptyfunction );
        addmenuitem( "big_bird"                                     , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "cargo_truck_mg"                               , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "little_bird_mg"                               , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "loot_chopper"                                 , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh_a10fd"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh_bt"                                       , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh_indigo"                                   , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "open_jeep_carpoc"                             , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );

    addmenulayer(    "spawnsmenu"                                                                                                                       , lv_cohost     , ly_root               , ar_submenu        , ly_spawns );
    addmenulayer(    "advancedforgemode"                                                                                                                , lv_cohost     , ly_spawns             , ar_submenu        , ly_forge );
        addmenuitem( "advancedforgemode"                            , undefined                                                                         , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfadvancedforgemode );
        addmenuitem( "rotatexaxis"                                  , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemoderotatexaxis );
        addmenuitem( "autolinkonspawn"                              , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemodeautolinkonspawn );
        addmenuitem( "ignorecollision"                              , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemodeignorecollision );
        addmenuitem( "firedcreate"                                  , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemodefiredcreate );
        addmenuitem( "changespawnedtime"                            , "advancedforgemode"                                                               , ar_content    , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::switchforgemodespawnedtime );
        addmenuitem( "combineobject"                                , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , scripts\mp\gametypes\arena::execforgemodecombineobject );
        addmenuitem( "linkobject"                                   , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , scripts\mp\gametypes\arena::switchforgemodelinkself );
        addmenuitem( "spinchange"                                   , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , scripts\mp\gametypes\arena::switchforgemodespinningmode );
        addmenuitem( "spawnlength"                                  , "advancedforgemode"                                                               , ar_content    , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::switchforgemodemovesize );
        addmenuitem( "deletelastobject"                             , "_objectcount"                                                                    , ar_devidevol  , ly_forge              , mod_fastreflesh   , scripts\mp\gametypes\arena::execforgemodedeletelastobject );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "changespawnedmodel"                           , "advancedforgemode"                                                               , ar_content    , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::switchforgemodemodel );
        addlistmenu( "modellistallpackages"                         , "packagemodels"                                                                   , lv_cohost     , ly_forge              , ar_submenu        , ly_package_forge      , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistflags"                               , "flagmodels"                                                                      , lv_cohost     , ly_forge              , ar_submenu        , ly_flag_forge         , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistdogtags"                             , "dogtagmodels"                                                                    , lv_cohost     , ly_forge              , ar_submenu        , ly_dogtag_forge       , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistallvehicles"                         , "vehiclesmodels"                                                                  , lv_cohost     , ly_forge              , ar_submenu        , ly_vehicle_forge      , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistallprops"                            , "propmodels"                                                                      , lv_cohost     , ly_forge              , ar_submenu        , ly_prop_forge         , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistanimal"                              , "propanimals"                                                                     , lv_cohost     , ly_forge              , ar_submenu        , ly_animal_forge       , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        //addlistmenu( "modellistzombie"                              , "propzombies"                                                                   , lv_cohost     , ly_forge              , ar_submenu        , ly_zombie_forge       , mod_notonf    , ::execchangeforgemodemodel );
        addlistmenu( "modellistdebug"                               , "propdebugs"                                                                      , lv_cohost     , ly_forge              , ar_submenu        , ly_debug_forge        , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistmaps"                                , "mapmodels"                                                                       , lv_cohost     , ly_forge              , ar_submenu        , ly_map_forge          , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription1"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription2"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription3"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription4"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription5"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription6"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription7"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription8"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription9"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription10"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription11"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription12"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription13"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription14"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
    addmenulayer(    "spindancer"                                                                                                                       , lv_cohost     , ly_spawns             , ar_submenu        , ly_spindance );
        addmenuitem( "spindancer"                                   , undefined                                                                         , ar_level      , ly_spindance          , mod_enabled       , scripts\mp\gametypes\arena::execspindancer );
        addmenuitem( "changemodel"                                  , "_" + "spindancer"                                                                , ar_devide     , ly_spindance          , mod_enabled       , scripts\mp\gametypes\arena::switchmodelspindancer );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_spindance          , mod_notonf        , scripts\mp\gametypes\arena::execdeletespindancer );
    addmenulayer(    "mexicanwave"                                                                                                                      , lv_cohost     , ly_spawns             , ar_submenu        , ly_mexicanwave );
        addmenuitem( "mexicanwave"                                  , undefined                                                                         , ar_level      , ly_mexicanwave        , mod_enabled       , scripts\mp\gametypes\arena::execmexicanwave );
        addmenuitem( "changemodel"                                  , "_" + "mexicanwave"                                                               , ar_devide     , ly_mexicanwave        , mod_enabled       , scripts\mp\gametypes\arena::switchmexicanwavemodel );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_mexicanwave        , mod_notonf        , scripts\mp\gametypes\arena::execdeletemexicanwave );
    addmenulayer(    "attractions"                                                                                                                      , lv_cohost     , ly_spawns             , ar_submenu        , ly_attraction );
        addmenuitem( "theclaw"                                      , undefined                                                                         , ar_level      , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::onftheclaw );
        addmenuitem( "merrygoround"                                 , undefined                                                                         , ar_level      , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::onfmerrygoround );
        addmenuitem( "changespeedmerrygoround"                      , "merrygoround"                                                                    , ar_lvcontent  , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::switchmerrygoroundrotatespeed );
    addmenuitem(     "---"                                          , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , ::emptyfunction );
        //addmenuitem( "skyplazaver2"                                 , undefined                                                                         , ar_level      , ly_spawns             , mod_enabled       , scripts\mp\gametypes\arena::onfskyplazaver2 );
        //addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , ::emptyfunction );
        addmenuitem( "discodancer"                                  , undefined                                                                         , ar_level      , ly_spawns             , mod_enabled       , scripts\mp\gametypes\arena::execdiscodancer );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , scripts\mp\gametypes\arena::execdeletediscodancer );

    addmenulayer(    "playersmenu"                                                                                                                      , lv_cohost     , ly_root               , ar_submenu        , ly_playersref );
        addmenuitem( "setunverified"                                , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , scripts\mp\art::removeauthunverified );
        addmenuitem( "setverified"                                  , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , scripts\mp\art::giveauthverified );
        addmenuitem( "setvip"                                       , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , scripts\mp\art::giveauthvip );
        addmenuitem( "setadmin"                                     , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , scripts\mp\art::giveauthadmin );
        addmenuitem( "setcohost"                                    , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , scripts\mp\art::giveauthcohost );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , ::emptyfunction );
        addmenuitem( "teleporttome"                                 , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , scripts\mp\art::execteleporttomesingle );
        addmenuitem( "teleporttohim"                                , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , scripts\mp\art::execteleporttohimsingle );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , ::emptyfunction );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossibleforplayer );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfgodmodeforplayer );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammoforplayer );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsforplayer );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclipforplayer );
        addmenuitem( "rocketride"                                   , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfrocketrideforplayer );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodelforplayer );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfthirdpersonforplayer );
        
    addmenulayer(    "allplayersmenu"                                                                                                                   , lv_host       , ly_root               , ar_submenu        , ly_allplayers );
        addmenuitem( "setunverified"                                , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::removeauthunverifiedforallplayers );
        addmenuitem( "setverified"                                  , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::giveauthverifiedforallplayers );
        addmenuitem( "setvip"                                       , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::giveauthvipforallplayers );
        addmenuitem( "setadmin"                                     , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::giveauthadminforallplayers );
        addmenuitem( "setcohost"                                    , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::giveauthcohostforallplayers );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , ::emptyfunction );
        addmenuitem( "lang_en"                                      , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::changelanguageenforallplayers );
        addmenuitem( "lang_ja"                                      , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::changelanguagejaforallplayers );
        addmenuitem( "teleporttome"                                 , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , scripts\mp\art::execteleporttomeforallplayers );
        addmenuitem( "freezeplayer"                                 , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onffreezeplayerforallplayers );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , ::emptyfunction );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossibleforallplayers );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfgodmodeforallplayers );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammoforallplayers );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsforallplayers );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclipforallplayers );
        addmenuitem( "rocketride"                                   , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfrocketrideforallplayers );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodelforallplayers );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfthirdpersonforallplayers );

    addmenulayer(    "gamesettingsmenu"                                                                                                                 , lv_host       , ly_root               , ar_submenu        , ly_gamesettings );
        addmenuitem( "superjump"                                    , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , scripts\mp\gametypes\arena::execsuperjumpforallplayers );
        addmenuitem( "speedhack"                                    , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , scripts\mp\gametypes\arena::execspeedhackforallplayers );
        addmenuitem( "forcerespawnpoint"                            , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , scripts\mp\gametypes\arena::onfforcerespawnpoint );
        addmenuitem( "deletelastobject"                             , "_objectcount"                                                                    , ar_devidelev  , ly_gamesettings       , mod_fastreflesh   , scripts\mp\art::execdeletelastobject );
        addmenuitem( "fastrestrat"                                  , undefined                                                                         , undefined     , ly_gamesettings       , mod_notonf        , scripts\mp\art::execfastrestrat );
        addmenuitem( "pausetimer"                                   , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , scripts\mp\art::onfpausetimer );
        addmenuitem( "endgame"                                      , undefined                                                                         , undefined     , ly_gamesettings       , mod_notonf        , scripts\mp\art::execendgame );
/*

    addmenulayer(    "mainmodsmenu"                                                                                                                     , lv_verified   , ly_root               , ar_submenu        , ly_mainmods );
        addmenuitem( "norecoil"                                     , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfnorecoil               , lv_verified );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfthirdperson            , lv_verified );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossible       , lv_verified );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodel               , lv_verified );
        addmenuitem( "changemodel"                                  , "_objectid"                                                                       , ar_devide     , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::switchchangemodel         , lv_verified );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammo           , lv_vip );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclip             , lv_vip );
        addmenuitem( "invisible"                                    , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfinvisible              , lv_vip );
        addmenuitem( "alwaysadvanceduav"                            , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfalwaysadvanceduav      , lv_vip );
        addmenuitem( "esp"                                          , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfesp                    , lv_vip );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbullets          , lv_vip );
        addmenuitem( "bullettype"                                   , "moddedbullets"                                                                   , ar_content    , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::switchbulletstype         , lv_vip );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfgodmode                , lv_admin );
        addmenuitem( "aimbot"                                       , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , scripts\mp\gametypes\arena::onfaimbot                 , lv_admin );
        addmenuitem( "sendmessageloop"                              , undefined                                                                         , ar_self       , ly_mainmods           , mod_enabled       , _id_67708F418B1FAC79::onfsendmessageloop        , lv_host );
        
    addmenulayer(    "languagesmenu"                                                                                                                    , lv_verified   , ly_root               , ar_submenu        , ly_languages );
        addmenuitem( "lang_en"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , _id_67708F418B1FAC79::changelanguage );
        addmenuitem( "lang_ja"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , _id_67708F418B1FAC79::changelanguage );
        addmenuitem( "lang_cn"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , _id_67708F418B1FAC79::changelanguage );
        addmenuitem( "lang_ru"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , _id_67708F418B1FAC79::changelanguage );
        addmenuitem( "lang_de"                                      , undefined                                                                         , undefined     , ly_languages          , mod_notonf        , _id_67708F418B1FAC79::changelanguage );

    addmenulayer(    "creditsmenu"                                                                                                                      , lv_verified   , ly_root               , ar_submenu        , ly_credit );
        addmenuitem( "[{atvi}]"                                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{iw}]"                                       , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{rvn}] [{3arc}] [{shg}]"                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_1"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_2"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_3"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_hinatyu_4"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "multitranssystem"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "horizontalscrollhmenu"                        , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "customtextmenu"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "visionsmenu"                                  , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "superslide"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "modelanimationsystem"                         , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "giverandomweapon"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "blueprintweapon"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "walkingac130"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "realcarepackagegun"                           , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "railgun"                                      , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "fullcustombullets"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "esp"                                          , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "killstreaksmenu"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "vanguardairstrike"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "pokemonball"                                  , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "acecombat"                                    , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "spawnvehicles"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "advancedforgemode"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "spindancer"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "teleportflags"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "giantrobot"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "spinrobot"                                    , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{dw}] [{hms}]"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_1"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_2"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_3"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_sku_4"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_m"                                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_m_1"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_jydenx"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_jydenx_1"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_jydenx_2"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_brutal"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_brutal_1"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_kam"                                   , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_kam_1"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_ate47"                                 , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_ate47_2"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_extincts"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_extincts_1"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_extincts_2"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "stacker"                                      , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_zeropoint"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_zeropoint_1"                           , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_thejoker7880"                          , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_thejoker7880_1"                        , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_dynamic"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_dynamic_1"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_onedeepzay"                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_onedeepzay_1"                          , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_bossam"                                , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "credit_oldmods"                               , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{bnox}] [{vv}]"                              , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{tfb}] [{king}]"                             , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( "[{bliz}]"                                     , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );
        addmenuitem( " "                                            , undefined                                                                         , undefined     , ly_credit             , mod_notonf        , ::emptyfunction );

    addmenulayer(    "designmenu"                                                                                                                       , lv_verified   , ly_root               , ar_submenu        , ly_design );
        addmenuitem( "switchbackgroundanimation"                    , undefined                                                                         , ar_self       , ly_design             , mod_enabled       , _id_67708F418B1FAC79::onfmodmenubackgroundanimation );
        addmenuitem( "changemenustyle"                              , undefined                                                                         , ar_self       , ly_design             , mod_enabled       , _id_67708F418B1FAC79::onfmodmenustyle );
        addmenuitem( "iprintlnmenu"                                 , undefined                                                                         , ar_self       , ly_design             , mod_enabled       , _id_67708F418B1FAC79::onfiprintlnmenu );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_design             , mod_notonf        , ::emptyfunction );
        addmenuitem( "menu to left"                                 , undefined                                                                         , undefined     , ly_design             , mod_notonf        , _id_67708F418B1FAC79::execiprintlnmenutoleft );
        addmenuitem( "menu to right"                                , undefined                                                                         , undefined     , ly_design             , mod_notonf        , _id_67708F418B1FAC79::execiprintlnmenutoright );
        addmenuitem( "menu to up"                                   , undefined                                                                         , undefined     , ly_design             , mod_notonf        , _id_67708F418B1FAC79::execiprintlnmenutoup );
        addmenuitem( "menu to down"                                 , undefined                                                                         , undefined     , ly_design             , mod_notonf        , _id_67708F418B1FAC79::execiprintlnmenutodown );
        
    addmenulayer(    "combatassistmenu"                                                                                                                 , lv_verified   , ly_root               , ar_submenu        , ly_combatassist );
        addmenuitem( "demigod"                                      , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfdemigod );
        addmenuitem( "infinityremainingammo"                        , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityremainingammo );
        addmenuitem( "norecoil"                                     , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfnorecoil );
        addmenuitem( "movementspeed1_25x"                           , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfmovementspeed1_25x );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfthirdperson );
        addmenuitem( "alwaysnormaluav"                              , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onfalwaysnormaluav );
        addmenuitem( "freezeplayer"                                 , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::onffreezeplayer );
        addmenuitem( "suicide"                                      , undefined                                                                         , ar_self       , ly_combatassist       , mod_enabled       , scripts\mp\gametypes\arena::execsuicide );
        
    addmenulayer(    "visionsmenu"                                                                                                                      , lv_verified   , ly_root               , ar_submenu        , ly_visions );
        addmenuitem( "default"                                      , "default"                                                                         , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "tac_ops_slamzoom"                             , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "chopper_color"                                , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_0_black_to_white"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_1_white_to_black"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_2_color_gradient"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_3_color_gradient"                        , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "cruise_color"                                 , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "cruise_predator_slamzoom"                     , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "drone_color_dark"                             , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "drone_color"                                  , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "proto_toma_strike_mp"                         , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "ac130_color"                                  , "ks"                                                                              , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "ac130_thermal_mp"                             , "thermal"                                                                         , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "ac130_enhanced_mp"                            , "thermal"                                                                         , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "recon_drone_flash"                            , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "wp_flare"                                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "respawn_camera"                               , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "br_nuke_global_flash"                         , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "br_nuke_global_aftermath"                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "black_bw"                                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "nuke_global_aftermath"                        , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "nuke_deathblur"                               , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "end_game"                                     , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "respawn_camera_night"                         , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        addmenuitem( "flir_0_black_to_white_heavy_damage"           , "naked"                                                                           , undefined     , ly_visions            , mod_notonf        , scripts\mp\gametypes\arena::execsetvision );
        
    addmenulayer(    "funnymenu"                                                                                                                        , lv_verified   , ly_root               , ar_submenu        , ly_funny );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossible );
        addmenuitem( "changeteam"                                   , undefined                                                                         , ar_content    , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::switchchangeteam );
        addmenuitem( "cloneplayer"                                  , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , scripts\mp\gametypes\arena::execcloneplayer );
        addmenuitem( "explodeddeadclone"                            , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , scripts\mp\gametypes\arena::execexplodeddeadclone );
        addmenuitem( "ninjamode"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfninjamode );
        addmenuitem( "jetpack"                                      , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfjetpack );
        addmenuitem( "shieldman"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfshieldman );
        addmenuitem( "superslide"                                   , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfsuperslide );
        //addmenuitem( "discocamo"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfdiscocamo );
        addmenuitem( "healthbar"                                    , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfhealthbar );
        addmenuitem( "highradiationmode"                            , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfhighradiationmode );
        addmenuitem( "dogtagshoes"                                  , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfdogtagshoes );
        addmenuitem( "adventureball"                                , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfadventureball );
        addmenuitem( "earthquake"                                   , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , scripts\mp\gametypes\arena::execearthquake );
        //addmenuitem( "deadopsarcade"                                , undefined                                                                       , ar_self       , ly_funny              , mod_enabled       , ::emptyfunction );
        addmenuitem( "saveloadlocation"                             , undefined                                                                         , ar_self       , ly_funny              , mod_enabled       , scripts\mp\gametypes\arena::onfsaveloadlocation );
        addmenuitem( "saveloadlocationdescription1"                 , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , ::emptyfunction );
        addmenuitem( "saveloadlocationdescription2"                 , undefined                                                                         , undefined     , ly_funny              , mod_notonf        , ::emptyfunction );

    addmenulayer(    "modelsmenu"                                                                                                                       , lv_verified   , ly_root               , ar_submenu        , ly_models );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_self       , ly_models             , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodel );
        addmenuitem( "changemodel"                                  , "_objectid"                                                                       , ar_devide     , ly_models             , mod_enabled       , scripts\mp\gametypes\arena::switchchangemodel );
        addmenuitem( "synccenterbody"                               , "setmodel"                                                                        , ar_self       , ly_models             , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodelsynccenterbody );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_models             , mod_notonf        , ::emptyfunction );
        addlistmenu( "modellistpackages"                            , "packagemodels"                                                                   , lv_verified   , ly_models             , ar_submenu        , ly_package_models     , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistflags"                               , "flagmodels"                                                                      , lv_verified   , ly_models             , ar_submenu        , ly_flag_models        , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistdogtags"                             , "dogtagmodels"                                                                    , lv_verified   , ly_models             , ar_submenu        , ly_dogtag_models      , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistvehicles"                            , "vehiclesmodels"                                                                  , lv_verified   , ly_models             , ar_submenu        , ly_vehicle_models     , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        addlistmenu( "modellistprops"                               , "propmodels"                                                                      , lv_verified   , ly_models             , ar_submenu        , ly_prop_models        , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );
        //addlistmenu( "modellistanimal"                             , "propanimals"                                                                    , lv_verified   , ly_models             , ar_submenu        , ly_animal_models      , mod_notonf    , ::execchangemodel );
        //addlistmenu( "modellistzombie"                             , "propzombies"                                                                    , lv_verified   , ly_models             , ar_submenu        , ly_zombie_models      , mod_notonf    , ::execchangemodel );
        //addlistmenu( "modellistdebug"                              , "propdebugs"                                                                     , lv_verified   , ly_models             , ar_submenu        , ly_debug_models       , mod_notonf    , ::execchangemodel );
        addlistmenu( "modellistmaps"                                , "mapmodels"                                                                       , lv_verified   , ly_models             , ar_submenu        , ly_map_models         , mod_notonf    , scripts\mp\gametypes\arena::execchangemodel );

    addmenulayer(    "weaponsmenu"                                                                                                                      , lv_verified   , ly_root               , ar_submenu        , ly_weapons );
        addmenuitem( "randomcamo"                                   , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfrandomcamo );
        addmenuitem( "randomattachment"                             , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfrandomattachment );
        addmenuitem( "blueprintweapon"                              , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfblueprintweapon );
        //addmenuitem( "dualweapon"                                   , undefined                                                                         , ar_self       , ly_weapons            , mod_enabled       , scripts\mp\gametypes\arena::onfdualweapon );
        addmenuitem( "giverandomweapon"                             , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execgiverandomweapon );
        addmenuitem( "giverandomcurbpweapon"                        , undefined                                                                         , ar_self       , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execgivebpweaponfromcurwp );
        //addmenuitem( "giverandomt9bpweapon"                          , undefined                                                                      , ar_self       , ly_weapons            , mod_notonf        , _id_67708F418B1FAC79::execgivebpweaponfromt9wp );
        //addmenuitem( "giverandoms4bpweapon"                          , undefined                                                                      , ar_self       , ly_weapons            , mod_notonf        , _id_67708F418B1FAC79::execgivebpweaponfroms4wp );
        addmenuitem( "dropweapon"                                   , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::execdropweapon );
        addmenuitem( "takedweapon"                                  , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::exectakedweapon );
        addmenuitem( "takedallweapons"                              , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , scripts\mp\gametypes\arena::exectakedallweapons );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_weapons            , mod_notonf        , ::emptyfunction );
    addmenulayer(    "assaultrifles"                                                                                                                    , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_ar );
        addmenuitem( "iw9_ar_mike4_mp"                              , "iw9_ar_mike4_mp"                                                                 , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_ar_akilo_mp"                              , "iw9_ar_akilo_mp"                                                                 , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_ar_augolf_mp"                             , "iw9_ar_augolf_mp"                                                                , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_ar_golf3_mp"                              , "iw9_ar_golf3_mp"                                                                 , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_ar_schotel_mp"                            , "iw9_ar_schotel_mp"                                                               , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_ar_mcharlie_mp"                           , "iw9_ar_mcharlie_mp"                                                              , undefined     , ly_wp_ar              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "submachineguns"                                                                                                                   , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_smg );
        addmenuitem( "iw9_sm_mpapa5_mp"                             , "iw9_sm_mpapa5_mp"                                                                , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sm_aviktor_mp"                            , "iw9_sm_aviktor_mp"                                                               , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sm_mpapa7_mp"                             , "iw9_sm_mpapa7_mp"                                                                , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sm_alpha57_mp"                            , "iw9_sm_alpha57_mp"                                                               , undefined     , ly_wp_smg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "lightmachineguns"                                                                                                                 , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_lmg );
        addmenuitem( "iw9_lm_rkilo_mp"                              , "iw9_lm_rkilo_mp"                                                                 , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_lm_mkilo3_mp"                             , "iw9_lm_mkilo3_mp"                                                                , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_lm_slima_mp"                              , "iw9_lm_slima_mp"                                                                 , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_lm_dblmg_mp"                              , "iw9_lm_dblmg_mp"                                                                 , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_lm_dblmg_jailer_mp"                       , "iw9_lm_dblmg_jailer_mp"                                                          , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_lm_dblmg_execution_mp"                    , "iw9_lm_dblmg_execution_mp"                                                       , undefined     , ly_wp_lmg             , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "marksmanrifles"                                                                                                                   , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_mr );
        addmenuitem( "iw9_dm_crossbow_mp"                           , "iw9_dm_crossbow_mp"                                                              , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_dm_recondartcrossbow_mp"                  , "iw9_dm_recondartcrossbow_mp"                                                     , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_dm_la700"                                 , "iw9_dm_la700"                                                                    , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_dm_xmike2010"                             , "iw9_dm_xmike2010"                                                                , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_dm_sbeta_mp"                              , "iw9_dm_sbeta_mp"                                                                 , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_dm_pgolf1_mp"                             , "iw9_dm_pgolf1_mp"                                                                , undefined     , ly_wp_mr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "sniperrifles"                                                                                                                     , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_sr );
        addmenuitem( "iw9_sn_alpha50_mp"                            , "iw9_sn_alpha50_mp"                                                               , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sn_la700_mp"                              , "iw9_sn_la700_mp"                                                                 , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sn_xmike2010_mp"                          , "iw9_sn_xmike2010_mp"                                                             , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sn_limax_mp"                              , "iw9_sn_limax_mp"                                                                 , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sn_india_mp "                             , "iw9_sn_india_mp "                                                                , undefined     , ly_wp_sr              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "pistol"                                                                                                                           , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_ps );
        addmenuitem( "iw9_pi_stimpistol_mp"                         , "iw9_pi_stimpistol_mp"                                                            , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_pi_swhiskey_mp"                           , "iw9_pi_swhiskey_mp"                                                              , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_pi_golf17_mp"                             , "iw9_pi_golf17_mp"                                                                , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_pi_golf18_mp"                             , "iw9_pi_golf18_mp"                                                                , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_pi_decho_mp"                              , "iw9_pi_decho_mp"                                                                 , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_pi_papa220_mp"                            , "iw9_pi_papa220_mp"                                                               , undefined     , ly_wp_ps              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );    
    addmenulayer(    "shotguns"                                                                                                                         , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_sg );
        addmenuitem( "iw9_sh_charlie725_mp"                         , "iw9_sh_charlie725_mp"                                                            , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sh_mike1014_mp"                           , "iw9_sh_mike1014_mp"                                                              , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sh_mviktor_mp"                            , "iw9_sh_mviktor_mp"                                                               , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sh_mbravo_mp"                             , "iw9_sh_mbravo_mp"                                                                , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_sh_vecho_mp"                              , "iw9_sh_vecho_mp"                                                                 , undefined     , ly_wp_sg              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "explosives"                                                                                                                       , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_ep );
        addmenuitem( "iw9_la_gromeo_mp"                             , "iw9_la_gromeo_mp"                                                                , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_la_juliet_mp"                             , "iw9_la_juliet_mp"                                                                , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_la_mike32_mp"                             , "iw9_la_mike32_mp"                                                                , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_la_kgolf_mp"                              , "iw9_la_kgolf_mp"                                                                 , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_la_rpapa7_mp"                             , "iw9_la_rpapa7_mp"                                                                , undefined     , ly_wp_ep              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    addmenulayer(    "melee"                                                                                                                            , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_me );
        addmenuitem( "iw9_me_fists_mp"                              , "iw9_me_fists_mp"                                                                 , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_sword01_mp"                            , "iw9_me_sword01_mp"                                                               , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_knife_mp"                              , "iw9_me_knife_mp"                                                                 , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_diveknife_mp"                          , "iw9_me_diveknife_mp"                                                             , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_climbfists_mp"                         , "iw9_me_climbfists_mp"                                                            , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_superfists_mp"                         , "iw9_me_superfists_mp"                                                            , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_buzzsaw_mp"                            , "iw9_me_buzzsaw_mp"                                                               , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
        addmenuitem( "iw9_me_riotshield_mp"                         , "iw9_me_riotshield_mp"                                                            , undefined     , ly_wp_me              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );
    //addmenulayer(    "special"                                                                                                                          , lv_verified   , ly_weapons            , ar_submenu        , ly_wp_sp );
    //    addmenuitem( "гроза"                                        , "iw8_ar_t9fasthandling_mp"                                                        , undefined     , ly_wp_sp              , mod_notonf        , scripts\mp\gametypes\arena::execgiveweapon );

    addmenulayer(    "customweaponsmenu"                                                                                                                , lv_vip        , ly_root               , ar_submenu        , ly_customweapons );
        addmenuitem( "teleportgun"                                  , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfteleportgun );
        addmenuitem( "tracelength"                                  , "teleportgun"                                                                     , ar_content    , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::switchteleportgunmovesize );
        addmenuitem( "rocketride"                                   , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfrocketride );
        addmenuitem( "walkingac130"                                 , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfwalkingac130 );
        addmenuitem( "realcarepackagegun"                           , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfrealcarepackagegun );
        //addmenuitem( "thundergun"                                   , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfthundergun );
        addmenuitem( "frameball"                                    , undefined                                                                         , ar_self       , ly_customweapons      , mod_enabled       , scripts\mp\gametypes\arena::onfframeball );
        
    addmenulayer(    "bulletsmenu"                                                                                                                      , lv_vip        , ly_root               , ar_submenu        , ly_bullets );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbullets );
        addmenuitem( "bullettype"                                   , "moddedbullets"                                                                   , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchbulletstype );
        addmenuitem( "moddedbulletsfiretrigger"                     , "moddedbullets"                                                                   , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsfiretrigger );
        addmenuitem( "moddedbulletsnum5"                            , "moddedbullets"                                                                   , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsnum5 );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_bullets            , mod_notonf        , ::emptyfunction );
        addmenuitem( "moddedgrenades"                               , undefined                                                                         , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedgrenades );
        addmenuitem( "grenadetype"                                  , "moddedgrenades"                                                                  , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchgrenadestype );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_bullets            , mod_notonf        , ::emptyfunction );
        addmenuitem( "fullcustombullets"                            , undefined                                                                         , ar_self       , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::onffullcustombullets );
        addmenuitem( "tracelength"                                  , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombullettracesize );
        addmenuitem( "changebulletmodel"                            , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletmodel );
        addmenuitem( "changebulleteffect"                           , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulleteffect );
        addmenuitem( "changeeffectuponimpact"                       , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletuponeffect );
        addmenuitem( "objectdeletiondelaytime"                      , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletdeletetime );
        addmenuitem( "changebulletsound"                            , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletloopsound );
        addmenuitem( "changesounduponimpact"                        , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletuponsound );
        addmenuitem( "earthquakeuponimpactpower"                    , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletequponpower );
        addmenuitem( "earthquakeuponimpacttime"                     , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletequpontime );
        addmenuitem( "earthquakeuponimpactrange"                    , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletequponrange );
        addmenuitem( "radiusdamageuponimpactpower"                  , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletrduponpower );
        addmenuitem( "radiusdamageuponimpactrange"                  , "fullcustombullets"                                                               , ar_content    , ly_bullets            , mod_enabled       , scripts\mp\gametypes\arena::switchfullcustombulletrduponrange );
        
    addmenulayer(    "popularmenu"                                                                                                                      , lv_vip        , ly_root               , ar_submenu        , ly_popular );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammo );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclip );
        addmenuitem( "bindnoclipdiscription"                        , undefined                                                                         , undefined     , ly_popular            , mod_notonf        , ::emptyfunction );
        addmenuitem( "changemovementspeed"                          , "movementspeed"                                                                   , ar_content    , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::switchmovementspeed );
        addmenuitem( "invisible"                                    , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfinvisible );
        addmenuitem( "alwaysadvanceduav"                            , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfalwaysadvanceduav );
        addmenuitem( "esp"                                          , undefined                                                                         , ar_self       , ly_popular            , mod_enabled       , scripts\mp\gametypes\arena::onfesp );
        
    addmenulayer(    "customkillstreaksmenu"                                                                                                            , lv_vip        , ly_root               , ar_submenu        , ly_customkillstreaks );
        addmenuitem( "kamikazebomber"                               , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfkamikazebomber );
        addmenuitem( "changekamikazebombermodel"                    , "kamikazebomber"                                                                  , ar_content    , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::switchkamikazebombermodel );
        addmenuitem( "changekamikazebomberspinning"                 , "kamikazebomber"                                                                  , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::switchkamikazebomberspin );
        addmenuitem( "changekamikazebomberrandom"                   , "kamikazebomber"                                                                  , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::switchkamikazebomberrandom );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_customkillstreaks  , mod_notonf        , ::emptyfunction );
        addmenuitem( "vanguardairstrike"                            , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfvanguardairstrike );
        addmenuitem( "flyingbomber"                                 , undefined                                                                         , ar_self       , ly_customkillstreaks  , mod_enabled       , scripts\mp\gametypes\arena::onfflyingbomber );

    addmenulayer(    "poweredmenu"                                                                                                                      , lv_admin      , ly_root               , ar_submenu        , ly_powered );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_self       , ly_powered            , mod_enabled       , scripts\mp\gametypes\arena::onfgodmode );
        
    addmenulayer(    "aimbotsmenu"                                                                                                                      , lv_admin      , ly_root               , ar_submenu        , ly_aimbots );
        addmenuitem( "aimbot"                                       , undefined                                                                         , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbot );
        addmenuitem( "attacktoforcekill"                            , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotattacktoforcekill );
        addmenuitem( "targettag"                                    , "aimbot"                                                                          , ar_content    , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::switchaimbottargettag );
        addmenuitem( "aimingrequired"                               , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotaimingrequired );
        addmenuitem( "aimtracking"                                  , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotaimtracking );
        addmenuitem( "aimstealth"                                   , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotaimstealth );
        addmenuitem( "autokill"                                     , "aimbot"                                                                          , ar_self       , ly_aimbots            , mod_enabled       , scripts\mp\gametypes\arena::onfaimbotautokill );

    addmenulayer(    "vehiclesmenu"                                                                                                                     , lv_admin      , ly_root               , ar_submenu        , ly_vehicles );
    addmenulayer(    "spawnvehicles"                                                                                                                    , lv_admin      , ly_vehicles           , ar_submenu        , ly_defvehicles );
        addmenuitem( "atv"                                          , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "little_bird"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "tac_rover"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_jltv"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_civ_lnd_dirt_bike"                       , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_rhib"                                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_pwc"                                     , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_jltv_mg"                                 , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "light_tank"                                   , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_suv_1996"                                , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_sedan_hatchback_1985"                    , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_mil_cargo_truck"                         , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_utv"                                     , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_hummer"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_overland_2016"                           , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_acv_6x6"                                 , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_cougar"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_patrol_boat"                             , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_palfa"                                   , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "apc_russian"                                  , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_mil_cargo_truck"                         , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_blima"                                   , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        addmenuitem( "veh9_mil_lnd_mrap"                            , undefined                                                                         , undefined     , ly_defvehicles        , mod_notonf        , scripts\mp\gametypes\arena::execspawnvehicle );
        
    addmenulayer(    "spawnsmenu"                                                                                                                       , lv_cohost     , ly_root               , ar_submenu        , ly_spawns );
    addmenulayer(    "advancedforgemode"                                                                                                                , lv_cohost     , ly_spawns             , ar_submenu        , ly_forge );
        addmenuitem( "advancedforgemode"                            , undefined                                                                         , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfadvancedforgemode );
        addmenuitem( "rotatexaxis"                                  , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemoderotatexaxis );
        addmenuitem( "autolinkonspawn"                              , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemodeautolinkonspawn );
        addmenuitem( "ignorecollision"                              , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemodeignorecollision );
        addmenuitem( "firedcreate"                                  , "advancedforgemode"                                                               , ar_self       , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::onfforgemodefiredcreate );
        addmenuitem( "changespawnedtime"                            , "advancedforgemode"                                                               , ar_content    , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::switchforgemodespawnedtime );
        addmenuitem( "combineobject"                                , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , scripts\mp\gametypes\arena::execforgemodecombineobject );
        addmenuitem( "linkobject"                                   , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , scripts\mp\gametypes\arena::switchforgemodelinkself );
        addmenuitem( "spinchange"                                   , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , scripts\mp\gametypes\arena::switchforgemodespinningmode );
        addmenuitem( "spawnlength"                                  , "advancedforgemode"                                                               , ar_content    , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::switchforgemodemovesize );
        addmenuitem( "deletelastobject"                             , "_objectcount"                                                                    , ar_devidevol  , ly_forge              , mod_fastreflesh   , scripts\mp\gametypes\arena::execforgemodedeletelastobject );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "changespawnedmodel"                           , "advancedforgemode"                                                               , ar_content    , ly_forge              , mod_enabled       , scripts\mp\gametypes\arena::switchforgemodemodel );
        addlistmenu( "modellistallpackages"                         , "packagemodels"                                                                   , lv_cohost     , ly_forge              , ar_submenu        , ly_package_forge      , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistflags"                               , "flagmodels"                                                                      , lv_cohost     , ly_forge              , ar_submenu        , ly_flag_forge         , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistdogtags"                             , "dogtagmodels"                                                                    , lv_cohost     , ly_forge              , ar_submenu        , ly_dogtag_forge       , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistallvehicles"                         , "vehiclesmodels"                                                                  , lv_cohost     , ly_forge              , ar_submenu        , ly_vehicle_forge      , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistallprops"                            , "propmodels"                                                                      , lv_cohost     , ly_forge              , ar_submenu        , ly_prop_forge         , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        //addlistmenu( "modellistanimal"                              , "propanimals"                                                                   , lv_cohost     , ly_forge              , ar_submenu        , ly_animal_forge       , mod_notonf    , ::execchangeforgemodemodel );
        //addlistmenu( "modellistzombie"                              , "propzombies"                                                                   , lv_cohost     , ly_forge              , ar_submenu        , ly_zombie_forge       , mod_notonf    , ::execchangeforgemodemodel );
        addlistmenu( "modellistdebug"                               , "propdebugs"                                                                      , lv_cohost     , ly_forge              , ar_submenu        , ly_debug_forge        , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addlistmenu( "modellistmaps"                                , "mapmodels"                                                                       , lv_cohost     , ly_forge              , ar_submenu        , ly_map_forge          , mod_notonf    , scripts\mp\gametypes\arena::execchangeforgemodemodel );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription1"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription2"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription3"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription4"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription5"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription6"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription7"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription8"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription9"                        , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription10"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription11"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription12"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription13"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
        addmenuitem( "forgemodedescription14"                       , undefined                                                                         , undefined     , ly_forge              , mod_notonf        , ::emptyfunction );
    addmenulayer(    "spindancer"                                                                                                                       , lv_cohost     , ly_spawns             , ar_submenu        , ly_spindance );
        addmenuitem( "spindancer"                                   , undefined                                                                         , ar_level      , ly_spindance          , mod_enabled       , scripts\mp\gametypes\arena::execspindancer );
        addmenuitem( "changemodel"                                  , "_" + "spindancer"                                                                , ar_devide     , ly_spindance          , mod_enabled       , scripts\mp\gametypes\arena::switchmodelspindancer );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_spindance          , mod_notonf        , scripts\mp\gametypes\arena::execdeletespindancer );
    addmenulayer(    "mexicanwave"                                                                                                                      , lv_cohost     , ly_spawns             , ar_submenu        , ly_mexicanwave );
        addmenuitem( "mexicanwave"                                  , undefined                                                                         , ar_level      , ly_mexicanwave        , mod_enabled       , scripts\mp\gametypes\arena::execmexicanwave );
        addmenuitem( "changemodel"                                  , "_" + "mexicanwave"                                                               , ar_devide     , ly_mexicanwave        , mod_enabled       , scripts\mp\gametypes\arena::switchmexicanwavemodel );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_mexicanwave        , mod_notonf        , scripts\mp\gametypes\arena::execdeletemexicanwave );
    addmenulayer(    "teleportflags"                                                                                                                    , lv_cohost     , ly_spawns             , ar_submenu        , ly_teleportflag );
        addmenuitem( "teleportflags"                                , undefined                                                                         , ar_level      , ly_teleportflag       , mod_enabled       , scripts\mp\gametypes\arena::execteleportflags );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_teleportflag       , mod_notonf        , scripts\mp\gametypes\arena::execdeleteteleportflags );
    addmenulayer(    "attractions"                                                                                                                      , lv_cohost     , ly_spawns             , ar_submenu        , ly_attraction );
        addmenuitem( "theclaw"                                      , undefined                                                                         , ar_level      , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::onftheclaw );
        addmenuitem( "ferriswheel"                                  , undefined                                                                         , ar_level      , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::onfferriswheel );
        addmenuitem( "changespeedferriswheel"                       , "ferriswheel"                                                                     , ar_lvcontent  , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::switchferriswheelrotatespeed );
        addmenuitem( "merrygoround"                                 , undefined                                                                         , ar_level      , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::onfmerrygoround );
        addmenuitem( "changespeedmerrygoround"                      , "merrygoround"                                                                    , ar_lvcontent  , ly_attraction         , mod_enabled       , scripts\mp\gametypes\arena::switchmerrygoroundrotatespeed );
    addmenuitem(     "---"                                          , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , ::emptyfunction );
        addmenuitem( "skyplazaver2"                                 , undefined                                                                         , ar_level      , ly_spawns             , mod_enabled       , scripts\mp\gametypes\arena::onfskyplazaver2 );
        addmenuitem( "soccerball"                                   , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , scripts\mp\gametypes\arena::execspawnsoccerball );
        addmenuitem( "changemodel"                                  , "_soccerball"                                                                     , ar_devide     , ly_spawns             , mod_enabled       , scripts\mp\gametypes\arena::switchsoccerballmodel );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , scripts\mp\gametypes\arena::execdeletesoccerball );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , ::emptyfunction );
        addmenuitem( "discodancer"                                  , undefined                                                                         , ar_level      , ly_spawns             , mod_enabled       , scripts\mp\gametypes\arena::execdiscodancer );
        addmenuitem( "deleteobject"                                 , undefined                                                                         , undefined     , ly_spawns             , mod_notonf        , scripts\mp\gametypes\arena::execdeletediscodancer );

    addmenulayer(    "playersmenu"                                                                                                                      , lv_cohost     , ly_root               , ar_submenu        , ly_playersref );
        addmenuitem( "setunverified"                                , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , _id_67708F418B1FAC79::removeauthunverified );
        addmenuitem( "setverified"                                  , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , _id_67708F418B1FAC79::giveauthverified );
        addmenuitem( "setvip"                                       , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , _id_67708F418B1FAC79::giveauthvip );
        addmenuitem( "setadmin"                                     , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , _id_67708F418B1FAC79::giveauthadmin );
        addmenuitem( "setcohost"                                    , undefined                                                                         , undefined     , ly_playersmod         , mod_reflesh       , _id_67708F418B1FAC79::giveauthcohost );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , ::emptyfunction );
        addmenuitem( "teleporttome"                                 , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , _id_67708F418B1FAC79::execteleporttomesingle );
        addmenuitem( "teleporttohim"                                , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , _id_67708F418B1FAC79::execteleporttohimsingle );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_playersmod         , mod_notonf        , ::emptyfunction );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossibleforplayer );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfgodmodeforplayer );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammoforplayer );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsforplayer );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclipforplayer );
        addmenuitem( "rocketride"                                   , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfrocketrideforplayer );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodelforplayer );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_player     , ly_playersmod         , mod_enabled       , scripts\mp\gametypes\arena::onfthirdpersonforplayer );
        
    addmenulayer(    "allplayersmenu"                                                                                                                   , lv_host       , ly_root               , ar_submenu        , ly_allplayers );
        addmenuitem( "setunverified"                                , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::removeauthunverifiedforallplayers );
        addmenuitem( "setverified"                                  , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::giveauthverifiedforallplayers );
        addmenuitem( "setvip"                                       , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::giveauthvipforallplayers );
        addmenuitem( "setadmin"                                     , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::giveauthadminforallplayers );
        addmenuitem( "setcohost"                                    , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::giveauthcohostforallplayers );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , ::emptyfunction );
        addmenuitem( "lang_en"                                      , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::changelanguageenforallplayers );
        addmenuitem( "lang_ja"                                      , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::changelanguagejaforallplayers );
        addmenuitem( "teleporttome"                                 , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , _id_67708F418B1FAC79::execteleporttomeforallplayers );
        addmenuitem( "freezeplayer"                                 , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onffreezeplayerforallplayers );
        addmenuitem( "---"                                          , undefined                                                                         , undefined     , ly_allplayers         , mod_notonf        , ::emptyfunction );
        addmenuitem( "outofmappossible"                             , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfoutofmappossibleforallplayers );
        addmenuitem( "godmode"                                      , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfgodmodeforallplayers );
        addmenuitem( "infinityammo"                                 , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfinfinityammoforallplayers );
        addmenuitem( "moddedbullets"                                , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfmoddedbulletsforallplayers );
        addmenuitem( "bindnoclip"                                   , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfbindnoclipforallplayers );
        addmenuitem( "rocketride"                                   , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfrocketrideforallplayers );
        addmenuitem( "setmodel"                                     , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfsetmodelforallplayers );
        addmenuitem( "thirdperson"                                  , undefined                                                                         , ar_level      , ly_allplayers         , mod_enabled       , scripts\mp\gametypes\arena::onfthirdpersonforallplayers );
        
    addmenulayer(    "messagesmenu"                                                                                                                     , lv_host       , ly_root               , ar_submenu        , ly_messages );
        addmenuitem( "doheart"                                      , undefined                                                                         , ar_level      , ly_messages           , mod_enabled       , scripts\mp\gametypes\arena::onfdoheart );
        addmenuitem( "sendmessageloop"                              , undefined                                                                         , ar_self       , ly_messages           , mod_enabled       , _id_67708F418B1FAC79::onfsendmessageloop );
        addmenuitem( "yourpromotion"                                , "yourpromotionmessage"                                                            , undefined     , ly_messages           , mod_notonf        , _id_67708F418B1FAC79::execsetloopmessage );
        addmenuitem( "yourpromotion2"                               , "yourpromotionmessage2"                                                           , undefined     , ly_messages           , mod_notonf        , _id_67708F418B1FAC79::execsetloopmessage );

    addmenulayer(    "gamesettingsmenu"                                                                                                                 , lv_host       , ly_root               , ar_submenu        , ly_gamesettings );
        addmenuitem( "superjump"                                    , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , scripts\mp\gametypes\arena::execsuperjumpforallplayers );
        addmenuitem( "speedhack"                                    , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , scripts\mp\gametypes\arena::execspeedhackforallplayers );
        addmenuitem( "deletelastobject"                             , "_objectcount"                                                                    , ar_devidelev  , ly_gamesettings       , mod_fastreflesh   , _id_67708F418B1FAC79::execdeletelastobject );
        addmenuitem( "fastrestrat"                                  , undefined                                                                         , undefined     , ly_gamesettings       , mod_notonf        , _id_67708F418B1FAC79::execfastrestrat );
        addmenuitem( "pausetimer"                                   , undefined                                                                         , ar_level      , ly_gamesettings       , mod_enabled       , _id_67708F418B1FAC79::onfpausetimer );
        addmenuitem( "endgame"                                      , undefined                                                                         , undefined     , ly_gamesettings       , mod_notonf        , _id_67708F418B1FAC79::execendgame );

*/
}






























































































































































































// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : The original GSC function (emptied to avoid DEV ERROR when called from an external class)
// ja : 元GSCの関数（外部クラスからのコール時のDEV ERROR回避用に空にする）
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



_id_818C(){}
_id_0CBE( var_0, var_1, var_2, var_3 ){}
_id_829D(){}
_id_724F(){}
_id_D83D( var_0 ){}
_id_724E(){}
_id_6B29(){}
_id_3ADC( var_0, var_1 ){}
_id_3ADB( var_0, var_1 ){}
_id_3D42( var_0, var_1, var_2 ){}
_id_6A63( var_0 ){}
_id_E3A4( var_0, var_1, var_2 ){}
_id_E31F( var_0 ){}
_id_B6D4( var_0 ){}
_id_B6D5( var_0 ){}
_id_8908( var_0 ){}
_id_883E( var_0 ){}
_id_A101( var_0 ){}
_id_3710( var_0 ){}
_id_DD0C( var_0, var_1, var_2 ){}
_id_18F1(){}
_id_B6CE(){}
_id_7258( var_0 ){}
_id_AB50( var_0 ){}
_id_B693( var_0 ){}
_id_6A64(){}
_id_D86F(){}
_id_DC8E( var_0 ){}
_id_6DCE(){}
_id_B6B4(){}
_id_4CE0( var_0 ){}
_id_8B41( var_0 ){}
_id_B641(){}
_id_C603( var_0 ){}
_id_FF50( var_0 ){}
_id_2487( var_0 ){}
_id_10B97( var_0 ){}
_id_10B9A( var_0 ){}
_id_10B99( var_0, var_1 ){}
_id_E6A8( var_0 ){}
_id_B79E(){}
_id_745C( var_0, var_1, var_2, var_3 ){}
_id_9A0E( var_0, var_1, var_2 ){}
_id_9A0F( var_0 ){}
_id_9A0C( var_0, var_1, var_2 ){}
_id_9A0D( var_0, var_1 ){}
_id_FCDF( var_0 ){}
_id_B6B2(){}
_id_7248( var_0, var_1, var_2 ){}
_id_725F( var_0, var_1, var_2 ){}
_id_4C2B( var_0, var_1 ){}
_id_6BE0(){}
_id_10954( var_0, var_1 ){}
_id_10944( var_0 ){}
_id_873C( var_0 ){}
_id_8946( var_0 ){}
_id_7423( var_0, var_1, var_2 ){}
_id_6B64( var_0 ){}
_id_ACF3( var_0 ){}
_id_7266( var_0 ){}
_id_7267(){}
_id_7268( var_0 ){}
_id_7265(){}
_id_7264(){}
_id_10B9( var_0, var_1 ){}
_id_10BA( var_0, var_1 ){}
_id_C4D2( var_0, var_1 ){}
_id_897A( var_0, var_1 ){}
_id_54B8( var_0 ){}
_id_54B9( var_0 ){}
_id_B6A5(){}
_id_897B( var_0, var_1 ){}
_id_D5B5( var_0 ){}
_id_B668( var_0 ){}
_id_B6D7( var_0 ){}
_id_824B( var_0 ){}
_id_B6D8( var_0 ){}
_id_B7CC( var_0 ){}
_id_B6B5(){}
_id_B6B6(){}
_id_589C( var_0 ){}
_id_724C( var_0 ){}
_id_724A(){}
_id_724D(){}
_id_724B(){}
_id_589D( var_0 ){}
_id_7252(){}
_id_725A(){}
_id_725B(){}
_id_B7E2( var_0, var_1 ){}
_id_8242( var_0, var_1, var_2 ){}
_id_B7CA( var_0 ){}
_id_6B5C( var_0 ){}
_id_B7E8( var_0 ){}
_id_726C( var_0, var_1, var_2, var_3 ){}
_id_B749( var_0 ){}
_id_7261( var_0, var_1 ){}
guidgen( var_0 ){}
_id_B797( var_0 ){}
_id_B7BD(){}
_id_C13D( var_0, var_1 ){}
_id_384D( var_0 ){}
_id_7256( var_0 ){}
_id_7255( var_0 ){}
_id_7253( var_0, var_1 ){}
_id_898D( var_0, var_1 ){}
_id_B6A2( var_0, var_1 ){}
_id_6CE5( var_0, var_1, var_2 ){}
_id_B6A1(){}
_id_B6A0( var_0 ){}
_id_B6B7( var_0, var_1 ){}
_id_689F( var_0, var_1 ){}
_id_726F( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_B664( var_0 ){}
_id_B6B9( var_0 ){}
_id_F62E( var_0 ){}
_id_B756(){}
_id_726D(){}
_id_7271(){}
_id_726E(){}
_id_7270(){}
_id_7272(){}
_id_B9D5( var_0 ){}
_id_34F1(){}
_id_F745(){}
_id_B6B8( var_0 ){}
_id_FCC2( var_0, var_1 ){}
_id_0D83( var_0, var_1 ){}
_id_FCBC( var_0 ){}
_id_B80A( var_0 ){}
_id_B67F( var_0 ){}
_id_D66E( var_0 ){}
_id_D66F( var_0, var_1 ){}
_id_D659( var_0 ){}
_id_D670( var_0 ){}
_id_D65A( var_0 ){}
_id_D655( var_0 ){}
_id_E67D( var_0, var_1 ){}
_id_DC22( var_0 ){}
_id_DC87( var_0, var_1 ){}
_id_FC11( var_0, var_1 ){}
_id_10A97( var_0 ){}
_id_10A98( var_0 ){}
_id_A696( var_0, var_1, var_2 ){}
_id_24B0( var_0 ){}
_id_FC10( var_0 ){}
_id_3850( var_0, var_1 ){}
_id_10A96( var_0, var_1, var_2, var_3 ){}
_id_52C2( var_0, var_1 ){}
_id_AF6A( var_0, var_1 ){}
_id_0B7C( var_0, var_1, var_2 ){}
_id_6901( var_0, var_1 ){}
_id_AF69( var_0, var_1, var_2 ){}
_id_C88B( var_0 ){}
_id_E35D( var_0 ){}
_id_C8B3( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_E35C( var_0 ){}
_id_B7DE( var_0 ){}
_id_6D99( var_0, var_1, var_2 ){}
_id_E257(){}
_id_0E1D(){}
_id_0E14( var_0, var_1 ){}
_id_0E18(){}
_id_10943(){}
_id_99C2(){}
_id_F48F( var_0, var_1 ){}
_id_B793(){}
_id_B74C( var_0 ){}
_id_9538( var_0 ){}
_id_B7BF(){}
_id_10964( var_0 ){}
_id_0D9F( var_0 ){}
_id_B64E(){}
_id_B63F(){}
_id_B6B3( var_0, var_1 ){}
_id_7251(){}
_id_3FC7(){}
_id_B6A9( var_0, var_1 ){}
_id_34DD( var_0 ){}
_id_6AF6(){}
_id_D85B( var_0 ){}
_id_4D0E( var_0 ){}
_id_1A88( var_0 ){}
_id_1A89( var_0, var_1, var_2, var_3 ){}
_id_1A8A( var_0, var_1, var_2 ){}
_id_1A8B( var_0, var_1 ){}
_id_1A86( var_0, var_1 ){}
_id_1A80( var_0 ){}
_id_1A7F( var_0 ){}
_id_1A8C( var_0, var_1 ){}
_id_1A8D( var_0, var_1 ){}
_id_1A83( var_0 ){}
_id_1A85( var_0, var_1, var_2, var_3 ){}
_id_1A84( var_0, var_1, var_2 ){}
_id_1A87( var_0, var_1 ){}
_id_1A82( var_0 ){}
_id_1A81(){}
_id_68AE( var_0, var_1 ){}
_id_ADB5( var_0, var_1, var_2, var_3, var_4 ){}
_id_D46F( var_0, var_1, var_2 ){}
_id_D471( var_0, var_1, var_2 ){}
_id_D470( var_0, var_1, var_2 ){}
_id_FC02( var_0 ){}
_id_B78D( var_0 ){}
_id_FC01( var_0 ){}
_id_C5F3( var_0 ){}
_id_B78A( var_0 ){}
_id_B78F( var_0, var_1, var_2 ){}
_id_B724( var_0, var_1, var_2, var_3, var_4 ){}
_id_FCFB( var_0 ){}
_id_B667( var_0 ){}
_id_D62B( var_0, var_1 ){}
_id_D62A( var_0, var_1 ){}
_id_B6C0( var_0 ){}
_id_B747(){}
_id_B730(){}
_id_B7A1(){}
_id_B802( var_0 ){}
_id_0C6B( var_0 ){}
_id_B661( var_0, var_1 ){}
_id_B6D2(){}
_id_B6D1(){}
_id_B662(){}
_id_B663(){}
_id_D84B( var_0, var_1 ){}
_id_FE2E( var_0 ){}
_id_C626(){}
