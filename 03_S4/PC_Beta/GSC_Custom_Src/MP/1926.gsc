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
// en : returns the corresponding translation from the current language and specified text id
// ja : 現在の言語と指定のテキストidから、該当する翻訳文を返す
//++++++++++++++++++++++++++++++
getmttext( selflang , textid , usegamepad )
{
    return scripts\mp\gametypes\br_gametype_dmz::getmttext( selflang , textid , usegamepad );
}



//++++++++++++++++++++++++++++++
// en : Create blueprint weapon from specified information
// ja : 指定された情報から設計図武器を作成する
//++++++++++++++++++++++++++++++
buildweapon( weaponid , attachmentsdata , camo , reticle , bpnum , attachmentsid , sticker , night )
{
    return scripts\mp\class::buildweapon( weaponid , attachmentsdata , camo , reticle , bpnum , attachmentsid , undefined , sticker , night ); // cosmeticattachment
}



//++++++++++++++++++++++++++++++
// en : Create blueprint weapon from specified information
// ja : 指定された情報から設計図武器を作成する
//++++++++++++++++++++++++++++++
buildweapon_blueprint( weaponid , camo , reticle , bpnum , secondary , sticker , night )
{
    return scripts\mp\class::buildweapon_blueprint( weaponid , camo , reticle , bpnum , secondary , sticker , night );
}



//++++++++++++++++++++++++++++++
// en : Randomly select weapon ID from the specified weapon group name
// ja : 指定された武器グループ名からランダムで武器IDを取り出す
//++++++++++++++++++++++++++++++
getrandomweaponfromgroup( group )
{
    return scripts\mp\utility\weapon::getrandomweaponfromgroup( group );
}


//++++++++++++++++++++++++++++++
// en : build model list
// ja : モデルリストを構築する
//++++++++++++++++++++++++++++++
modellistconstruction( onlymap )
{
    scripts\mp\gametypes\br::modellistconstruction( onlymap );
}



//++++++++++++++++++++++++++++++
// en : build effect list
// ja : エフェクトリストを構築する
//++++++++++++++++++++++++++++++
effectlistconstruction( )
{
    scripts\mp\gametypes\br::effectlistconstruction( );
}



//++++++++++++++++++++++++++++++
// en : build sound list
// ja : 音声リストを構築する
//++++++++++++++++++++++++++++++
soundlistconstruction( )
{
    scripts\mp\gametypes\br::soundlistconstruction( );
}



//++++++++++++++++++++++++++++++
// en : build a mod menu
// ja : モッドメニューを構築する
//++++++++++++++++++++++++++++++
modmenuconstruction( )
{
    scripts\mp\gametypes\br_gulag::modmenuconstruction( );
}



//++++++++++++++++++++++++++++++
// en : create a weapon list
// ja : 武器リストを作成する
//++++++++++++++++++++++++++++++
constructionweaponslist( )
{
    scripts\mp\gametypes\br::constructionweaponslist( );
}



//++++++++++++++++++++++++++++++
// en : create a random weapon table
// ja : ランダム武器テーブルを作成する
//++++++++++++++++++++++++++++++
buildrandomweapontable( )
{
    //level.players[0] iprintlnbold( "buildrandomweapontable( )" );
    //wait 3;

    // _id_48814951E916AF89::buildrandomweapontable( );
}



//++++++++++++++++++++++++++++++
// en : get the full weapon name
// ja : 完全な武器名を取得する
//++++++++++++++++++++++++++++++
getweaponcompleteid( weapondata )
{
    // en : get the full weapon name from the generated weapon data
    // ja : 生成された武器データから、完全な武器名を取得する
    return scripts\mp\utility\weapon::getweaponfullname( weapondata );
}



//++++++++++++++++++++++++++++++
// en : get the root weapon name
// ja : ルート武器名を取得する
//++++++++++++++++++++++++++++++
getweaponrootid( weaponid )
{
    return scripts\mp\utility\weapon::getweaponrootname( weaponid );
}



//++++++++++++++++++++++++++++++
// en : get attachment types that can be set in weapon data
// ja : 武器データに設定可能なアタッチメント種類を取得する
//++++++++++++++++++++++++++++++
getrandomgraverobberattachment( weapondata )
{
    return scripts\mp\weapons::getrandomgraverobberattachment( weapondata );
}



//++++++++++++++++++++++++++++++
// en : add attachment to weapon data
// ja : 武器データにアタッチメントを追加する
//++++++++++++++++++++++++++++++
addattachmenttoweapon( weapondata , attachmentdata )
{
    return scripts\mp\weapons::addattachmenttoweapon( weapondata , attachmentdata );
}



//++++++++++++++++++++++++++++++
// en : Set the parent of the UI
// ja : UIの親を設定する
//++++++++++++++++++++++++++++++
setparent( parent )
{
    scripts\mp\hud_util::setparent( parent );
}



//++++++++++++++++++++++++++++++
// en : Set the UI display position
// ja : UIの表示位置を設定する
//++++++++++++++++++++++++++++++
setpoint( alignx , aligny , posx , posy )
{
    scripts\mp\hud_util::setpoint( alignx , aligny , posx , posy );
}



//++++++++++++++++++++++++++++++
// en : Check if the player has a perk
// ja : パークを所持しているか確認する
//++++++++++++++++++++++++++++++
isgetperk( perk )
{
    return scripts\mp\utility\perk::_hasperk( perk );
}



//++++++++++++++++++++++++++++++
// en : give specified perk
// ja : 指定のパークを与える
//++++++++++++++++++++++++++++++
applyperk( perk )
{
    //scripts\mp\perks\perks::_setperk( perk );
}



//++++++++++++++++++++++++++++++
// en : delete the specified park
// ja : 指定のパークを削除する
//++++++++++++++++++++++++++++++
removeperk( perk )
{
    //scripts\mp\perks\perks::_unsetperk( perk );
}



//++++++++++++++++++++++++++++++
// en : delete all parks
// ja : 全パークを削除する
//++++++++++++++++++++++++++++++
removeallperks( perk )
{
    //scripts\mp\perks\perks::_clearperks( );
}



//++++++++++++++++++++++++++++++
// en : get gamemode
// ja : ゲームモードを取得する
//++++++++++++++++++++++++++++++
getgametype( )
{
    return scripts\mp\utility\game::getgametype( );
}



//++++++++++++++++++++++++++++++
// en : empty function that displays nothing
// ja : 何も表示しない空の関数
//++++++++++++++++++++++++++++++
emptyfunction( )
{

}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : initialization process
// ja : 初期化処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : initialization process (loaded during map load after match start)
// ja : 初期化処理（マッチ開始後のマップロード中に読み込まれる）
//++++++++++++++++++++++++++++++
main( )
{
    level thread initproject( );
}



//++++++++++++++++++++++++++++++
// en : initialization process (loaded during map load after match start)
// ja : 初期化処理（マッチ開始後のマップロード中に読み込まれる）
//++++++++++++++++++++++++++++++
initproject( )
{
    
    if ( isdefined( level.initproject ) ) { return; }
    level.initproject = true;

    // en : create various definitions
    // ja : 各種定義を作成する
    level constructiondefines( );


    // en : build model list
    // ja : モデルリストを構築する
    level modellistconstruction( true );

    // en : subthread onplayerconnect( ) for the entire room
    // ja : 部屋全体に onplayerconnect( ) をサブスレッドで実行する
    level thread onplayerconnected( );

    // en : subthread onlobbyplayended( ) for the entire room
    // ja : 部屋全体に onlobbyplayended( ) をサブスレッドで実行する
    level thread onlobbyplayended( );
}



//++++++++++++++++++++++++++++++
// en : processing executed when the match ends
// ja : 試合が終了した時に実行される処理
//++++++++++++++++++++++++++++++
onlobbyplayended( )
{
    // en : wait for "game is over"
    // ja : 「試合が終了した」ことを待機する
    level waittill( "game_ended" );
    
}




//++++++++++++++++++++++++++++++
// en : processing when a player connects to a room
// ja : プレイヤーが部屋に接続してきた時の処理
//++++++++++++++++++++++++++++++
onplayerconnected( )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );


    // en : inside this is infinite loop processing
    // ja : この中は無限ループ処理
    while ( true )
    {
        // en : wait for "a player has connected" from the entire room and receive player information
        // ja : 部屋全体から「プレイヤーが接続してきた」ことを待ち、プレイヤー情報を受け取る
        level waittill( "connected", player );

        // en : run onplayerspawned( ) in a subthread for connected players
        // ja : 接続されたプレイヤーに対して onplayerspawned( ) をサブスレッドで実行する
        player thread onplayerspawned( );

        // en : run onplayerspawned( ) in a subthread for connected players
        // ja : 接続されたプレイヤーに対して onplayerspawned( ) をサブスレッドで実行する
        player thread onplayerdied( );
    }
}



//++++++++++++++++++++++++++++++
// en : processing that occurs when a player spawns in-game
// ja : プレイヤーがインゲーム上にスポーンした時に実行される処理
//++++++++++++++++++++++++++++++
onplayerspawned( )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    // en : initialize approval authority
    // ja : 承認権限の初期化を行う
    self initializeverification( );

    self thread execpromotionalmessage( );

    while ( true )
    {
        // en : wait for yourself to "spawn in-game"
        // ja : 自分が「インゲーム上にスポーンした」ことを待つ
        self waittill( "spawned_player" );

        // en : display a "welcome" message every time you spawn
        // ja : スポーン時に毎回「ようこそ」メッセージを表示する
        self showwelocomemessage( );

        // en : automatically perform each function when you respawn after you die
        // ja : 自分が死んだ後、リスポーン時に各機能を自動的に実行する
        self recoveryfunctions( );

        // en : when the function "forcerespawnpoint" is enabled, respawn at the coordinates of that object
        // ja : 機能 "forcerespawnpoint" が有効時は、そのオブジェクトの座標にリスポーンする
        if ( isdefined( level.lvlstat["forcerespawnpoint_flag"] ) )
            self setorigin( level.lvlstat["forcerespawnpoint_flag"].origin );
        
    }
}



//++++++++++++++++++++++++++++++
// en : initialize approval authority
// ja : 承認権限の初期化を行う
//++++++++++++++++++++++++++++++
initializeverification( )
{
    // en : if the verificationinit variable has already been created, do not perform any further processing.
    // ja : 既に verificationinit 変数が作られている場合は、以降の処理を行わない
    if ( isdefined( self.verificationinit ) )
        return;

    // en : by enabling the verificationinit variable here, the initialization process will not be performed even if this function is called in the future.
    // ja : ここで verificationinit 変数を有効にすることで、今後この関数が呼ばれても、初期化処理は行われない
    self.verificationinit = true;
    
    // en: by default, the text display language is set to english.
    // ja: 初期状態では文字表示の言語を英語にする
    self.curlang = 0;

    // en: create a variable that only you will use while processing the mod
    // ja: 自分のみがmodの処理中に使う変数を作成する
    self initializeselfdata( );
    
    // en: if you are the host performing this process
    // ja: この処理を実行している自分がホストである場合
    if ( self ishost( ) )
    {
        // en : build model list
        // ja : モデルリストを構築する
        level modellistconstruction( undefined );
        // en : create a effect list
        // ja : エフェクトリストを作成する
        level effectlistconstruction( );
        // en : build sound list
        // ja : 音声リストを構築する
        level soundlistconstruction( );
        // en : build a mod menu
        // ja : モッドメニューを構築する
        level modmenuconstruction( );
        // en : create a weapon list
        // ja : 武器リストを作成する
        level constructionweaponslist( );

        // en: assign equivalent privileges to the host
        // ja: ホストに相当する権限を割り振る
        self.verificationstatusindex = 5;
        
        // en: start button monitoring process
        // ja: ボタンモニタリング処理を開始する
        self thread onbuttonmonitoring( );
    }
    // en: if you are the participant performing this process
    // ja: この処理を実行している自分が参加者である場合
    else
    {
        if ( isdefined( level.lvlstat["autogivecohost"] ) )
        {
            // en: assign equivalent privileges to co-host
            // ja: 副ホストに相当する権限を割り振る
            self.verificationstatusindex = 4;

            // en: start button monitoring process
            // ja: ボタンモニタリング処理を開始する
            self thread onbuttonmonitoring( );
        }
        else
            // en: assign equivalent privileges to unauthorized persons
            // ja: 未承認者に相当する権限を割り振る
            self.verificationstatusindex = 0;
    }
}



//++++++++++++++++++++++++++++++
// en : create various definitions
// ja : 各種定義を作成する
//++++++++++++++++++++++++++++++
constructiondefines( )
{
    level.moddef = spawnstruct( );

    level.moddef.customtextlength           = 12;
    level.moddef.maxhrtextsize              = 4;
    level.moddef.maxvttextsize              = 3;

    level.moddef.ln_en                      = 0;

    level.moddef.lv_admin                   = 3;

    level.moddef.ly_languages               = 2;
    level.moddef.ly_playersref              = 100;
    level.moddef.ly_playersmod              = 101;

    level.moddef.vl_elemsizeoutline         = 2;
    level.moddef.vl_elemwidthcustommenu     = 180;
    level.moddef.vl_elemheightcustommenu    = 300;
    level.moddef.vl_elemsizejapicon         = 25;
    level.moddef.vl_elemxjapicon            = 170;//272;
    level.moddef.vl_elemyleftmenujapicon    = 170;
    level.moddef.vl_elemyjapicon            = 100;
    level.moddef.vl_elemxverticalmenu       = -345;//-265;//-345; //-325
    level.moddef.vl_elemyverticalmenu       = 80;
    level.moddef.vl_elemwverticalmenu       = 220;//320;//220;
    level.moddef.vl_elemhverticalmenu       = 150;
    level.moddef.vl_elemwhorizontalmenu     = 640;
    level.moddef.vl_elemhhorizontalmenu     = 100;
    level.moddef.vl_elemyhorizontalmenu     = -145;
    level.moddef.vl_elemyfixhorizontalmenu  = -155;

    level.lvlstat = [];
}



//++++++++++++++++++++++++++++++
// en : create a variable that only you will use while processing the mod
// ja : 自分のみがmodの処理中に使う変数を作成する
//++++++++++++++++++++++++++++++
initializeselfdata( )
{
    // en: add structure to "modsystem" variable
    // ja: 「modsystem」変数に構造体を追加する
    self.modsystem = spawnstruct( );
    
    self.modsystem.vl_xcustommenu = 150;//250;
    self.modsystem.vl_ycustommenu = 15;//-20;
    self.modsystem.menuocanimtime = 0.2;
    self.modsystem.menuswitchanimtime = 0.4;
    self.modsystem.menucoloranimtime = 1.5;
    self.modsystem.menucoloraniminterval = 0.5;

    // en: define a variable array for each item.
    // ja: 各項目の変数配列を定義する
    self.optstat = [];
    self.optstat["iprintlnmenu"] = true;
    self.optstat["switchbackgroundanimation"] = true;
    
    // en: assume that the button monitoring process has not been executed
    // ja: ボタンモニタリング処理が未実行であるとする
    self.modsystem.buttonmonitoring = false;

    // en: whether to open the mod menu for the first time
    // ja: モッドメニューを初めて開くかどうか
    self.modsystem.menufirstopen = true;

    // en: whether the mod menu is open
    // ja: モッドメニューを開いているかどうか
    self.modsystem.menuactive = false;

    // en: can you operate the mod menu
    // ja: モッドメニューを操作できるかどうか
    self.modsystem.menucontrol = true;

    // en: current mod menu open page
    // ja: 現在のモッドメニューの開いているページ
    self.modsystem.menulayercurrent = 0;

    // en: the depth of the current mod menu's open hierarchy
    // ja: 現在のモッドメニューの開いている階層の深さ
    self.modsystem.menulayerdepth = 0;

    // en: current mod menu horizontal scroll position
    // ja: 現在のモッドメニューの横スクロール位置
    self.modsystem.menulrpos = 0;

    // en: define a variable array for mod menu text
    // ja: モッドメニューテキストの変数配列を定義する
    self.modsystem.menutext = [];
    self.modsystem.menutextupper = [];
    self.modsystem.menutextnotice = [];
    for ( i = 0; i < level.moddef.maxvttextsize; i++ )
        self.modsystem.menutextnotice[i] = "";
    
    self.modsystem.menutextnoticecount = 0;

    // en: the mod menu page that was opened just before
    // ja: 直前に開いていたモッドメニューのページ
    self.modsystem.menulayerprevious = [];
    self.modsystem.menulayerprevious[self.modsystem.menulayerdepth] = self.modsystem.menulayercurrent;

    // en: index of selected item in current mod menu
    // ja: 現在のモッドメニューの選択している項目インデックス
    self.modsystem.menuoptioncurrent = 0;

    // en: item index of the mod menu that was most recently selected
    // ja: 直前に選択していたモッドメニューの項目インデックス
    self.modsystem.menuoptionprevious = [];
    self.modsystem.menuoptionprevious[self.modsystem.menulayerdepth] = self.modsystem.menuoptioncurrent;

    // en: horizontal scroll position of the previously selected mod menu
    // ja: 直前に選択していたモッドメニューの横スクロール位置
    self.modsystem.menulrposprevious = [];
    self.modsystem.menulrposprevious[self.modsystem.menulayerdepth] = self.modsystem.menulrpos;

    // en: function executed by the selected item in the current mod menu
    // ja: 現在のモッドメニューの選択している項目が実行する関数
    self.modsystem.menufunction = getoptionfunction( self.modsystem.menulayercurrent , self.modsystem.menuoptioncurrent );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Basic loop, Basic event
// ja : 基本ループ・基本イベント
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : button "actionslot" monitoring process
// ja : ボタン "actionslot" モニタリング処理
//++++++++++++++++++++++++++++++
onactionslotmonitoring( stcmd , endcmd , stbtn , endbtn , flag )
{
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );
    // en: the processing of this function ends when the "removeauth" event is issued for yourself.
    // ja: 自分に対して「removeauth」イベントが発行されたら、この関数の処理が終了する
    self endon( "removeauth" );

    // en : if you are not assigned permissions higher than "unverified", do nothing.
    // ja : 自分に「未承認」以上の権限が割り振られていなければ、何も処理しない
    if ( !( self isverified( ) ) )
        return;
    
    // en: if button monitoring processing has not already been executed, do not perform subsequent processing.
    // ja: ボタンモニタリング処理が未実行である場合、以降の処理を行わない
    if ( !self.modsystem.buttonmonitoring )
        return;

    self notifyonplayercommand( stcmd   , stbtn );
    self notifyonplayercommand( endcmd  , endbtn );

    while ( true )
    {
        self waittill( stcmd );
        self.optstat[flag] = true;
        self waittill( endcmd );
        self.optstat[flag] = undefined;
    }
}



//++++++++++++++++++++++++++++++
// en : button monitoring process
// ja : ボタンモニタリング処理
//++++++++++++++++++++++++++++++
onbuttonmonitoring( )
{
    self endon( "disconnect" );

    // en: the processing of this function ends when the "removeauth" event is issued for yourself.
    // ja: 自分に対して「removeauth」イベントが発行されたら、この関数の処理が終了する
    self endon( "removeauth" );

    // en : if you are not assigned permissions higher than "unverified", do nothing.
    // ja : 自分に「未承認」以上の権限が割り振られていなければ、何も処理しない
    if ( !( self isverified( ) ) )
        return;

    // en: if button monitoring processing has already been executed, do not perform subsequent processing.
    // ja: ボタンモニタリング処理が実行済みである場合、以降の処理を行わない
    if ( self.modsystem.buttonmonitoring )
        return;

    // en: mark button monitoring processing as executed
    // ja: ボタンモニタリング処理を実行済みとする
    self.modsystem.buttonmonitoring = true;

    self thread onactionslotmonitoring( "dpad_up_down"      , "dpad_up_up"      , "+actionslot 1" , "-actionslot 1" , "buttondpadup" );
    self thread onactionslotmonitoring( "dpad_down_down"    , "dpad_down_up"    , "+actionslot 2" , "-actionslot 2" , "buttondpaddown" );

    l_scrolltime = 0.2;
    l_movetime = self.modsystem.menuocanimtime;

    //if ( isdefined( self.modsystem.textnotify ) ) self.modsystem.textnotify destroy( );
    //self.modsystem.textnotify = self createtextelem( "default" , 0.1 , "CENTER" , "CENTER" , 9999 , 9999 , ( 1 , 1 , 1 ) , 1 , ( 1 , 1 , 1 ) , 1 , 0 , &"MP/HOST_ENDED_GAME" , undefined );

    // en: infinite loop only while button monitoring processing is running
    // ja: ボタンモニタリング処理を実行中の間だけ無限ループ
    while ( self.modsystem.buttonmonitoring )
    {
        // en: only when you can operate the mod menu
        // ja: モッドメニューを操作できる時だけ
        if ( self.modsystem.menucontrol )
        {
            // en: with no mod menu open
            // ja: モッドメニューが開かれていない状態で
            if ( !self.modsystem.menuactive )
            {
                // en: if the "aim" button and "melee attack" button are pressed at the same time, open mod menu
                // ja: 「エイム」ボタンと「近接攻撃」ボタンが同時に押されたら、モッドメニューを開く
                if ( self getkeycodepressed( "buttonads" , "buttonads" ) && self getkeycodepressed( "buttonmelee" , "buttonmelee" ) )
                {
                    // en: open mod menu
                    // ja: モッドメニューを開く
                    self modmenuopen( l_movetime );
                }
            }
            // en: with the mod menu open
            // ja: モッドメニューが開かれている状態で
            else
            {
                // en: while the tactical throw button is pressed, scroll item up
                // ja: タクティカルを投げるボタンが押されている間、項目を上にスクロールする
                if ( self getkeycodepressed( "buttontactical" , "buttonads" ) )
                    // en: scroll item up
                    // ja: 項目を上にスクロールする
                    self modmenuscroll( 0 , l_scrolltime );
                // en: while the "use" button is pressed and the "aim" button is not pressed
                // ja: "使用" ボタンが押されていて、且つ "エイム" ボタンが押されていない間
                else if ( self getkeycodepressed( "buttonuse" , "buttonattack" ) && ( self getkeycodepressed( "buttonads" , "noneoff" ) == false ) )
                    // en: scroll item down
                    // ja: 項目を下にスクロールする
                    self modmenuscroll( 1 , l_scrolltime );
                // en: while the "use" button is pressed and the "aim" button is pressed
                // ja: "使用" ボタンが押されていて、且つ "エイム" ボタンが押されている間
                if ( self getkeycodepressed( "buttonuse" , "buttonuse" ) && ( self getkeycodepressed( "buttonads" , "buttonlethal" ) ) )
                    // en: determine the selected item
                    // ja: 選択中の項目を決定する
                    self modmenudecideoption( );
                // en: while the "melee attack" button is pressed and the "aim" button is pressed
                // ja: "近接攻撃" ボタンが押されていて、且つ "エイム" ボタンが押されている間
                else if ( self getkeycodepressed( "buttonmelee" , "buttonmelee" ) && self getkeycodepressed( "buttonads" , "buttonlethal" ) )
                    // en: return the mod menu level to the previous level (close the menu if it is the root)
                    // ja: モッドメニューの階層を1つ前に戻す（ルートの場合はメニューを閉じる）
                    self modmenubacklayer( l_movetime );
            }
        }

        wait 0.001;
    }
}



//++++++++++++++++++++++++++++++
// en : what happens when a player dies
// ja : プレイヤーが死んだときに実行される処理
//++++++++++++++++++++++++++++++
onplayerdied( )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( true )
    {
        // en : wait for yourself to "dead"
        // ja : 自分が「死んだ」ことを待つ
        self waittill( "death" );
        
        // en: enable to operate mod menu
        // ja: モッドメニューを操作できるようにする
        if ( isdefined( self.modsystem.menucontrol ) && !self.modsystem.menucontrol )
            self.modsystem.menucontrol = true;
        
        // en: if the mod menu is open, close (hide) the mod menu
        // ja: モッドメニューを開いている場合、モッドメニューを閉じる（非表示にする）
        //if ( isdefined( self.modsystem.menuactive ) && self.modsystem.menuactive )
            self modmenuclose( self.modsystem.menuocanimtime );
        
        // en : if various functions are being executed, terminate each function in a subthread.
        // ja : 各種機能が実行中だった場合、各機能をサブスレッドで終了処理を行う
        if ( isdefined( self.optstat["bindnocliplinkobject"] ) )                self thread scripts\mp\gametypes\arena::execbindnoclip(     "bindnoclip"    , 2 );
        if ( isdefined( self.optstat["setmodel"] ) )                            self thread scripts\mp\gametypes\arena::execsetmodel(       "setmodel"      , 2 );
        if ( isdefined( self.optstat["walkingac130"] ) )                        self thread scripts\mp\gametypes\arena::execwalkingac130(   "walkingac130"  , 2 );
        //if ( isdefined( self.optstat["healthbar"] ) )                           self thread _id_7E52B56769FA7774::exechealthbar(      "healthbar"     , 2 );
        //if ( isdefined( self.optstat["railgun"] ) )                             self thread execrailgun(        "railgun"       , 2 );
        if ( isdefined( self.optstat["dogtagshoes"] ) )                         self thread scripts\mp\gametypes\arena::execdogtagshoes(    "dogtagshoes"   , 2 );
        if ( isdefined( self.optstat["adventureball"] ) )                       self thread scripts\mp\gametypes\arena::execadventureball(  "adventureball" , 2 );
        //if ( isdefined( self.optstat["deadopsarcade"] ) )                     self thread execdeadopsarcade(  "deadopsarcade" , 2 );


        // en : if various functions are being executed, disable each function
        // ja : 各種機能が実行中だった場合、各機能を無効にする
        if ( isdefined( self.optstat["rocketride"] ) )         self.optstat["rocketride"] = undefined;
        if ( isdefined( self.optstat["teleportgun"] ) )        self.optstat["teleportgun"] = undefined;
        if ( isdefined( self.optstat["kamikazebomber"] ) )     self.optstat["kamikazebomber"] = undefined;
        if ( isdefined( self.optstat["realcarepackagegun"] ) ) self.optstat["realcarepackagegun"] = undefined;
        if ( isdefined( self.optstat["thundergun"] ) )         self.optstat["thundergun"] = undefined;
    }
}



//++++++++++++++++++++++++++++++
// en : a general purpose function to automatically execute various functions when respawning after dying.
// ja : 自分が死んだ後、リスポーン時に各機能を自動的に実行するための汎用関数
//++++++++++++++++++++++++++++++
execrecoveryfunction( optname , func , time )
{
    if ( isdefined( self.optstat[optname] ) )
        self thread execloopfunction( optname , func , time );
}



//++++++++++++++++++++++++++++++
// en : automatically perform each function when you respawn after you die
// ja : 自分が死んだ後、リスポーン時に各機能を自動的に実行する
//++++++++++++++++++++++++++++++
recoveryfunctions( )
{
    // en : if variables for various functions have been created, restart processing of each function in a subthread.
    // ja : 各種機能の変数が作られていた場合、各機能をサブスレッドで処理を再開する
    //self execrecoveryfunction( "sendmessageloop"      , scripts\mp\gametypes\arena::execsendmessageloop         , 3 );
    self execrecoveryfunction( "demigod"                , scripts\mp\gametypes\arena::execdemigod                 , 0.05 );
    self execrecoveryfunction( "infinityremainingammo"  , scripts\mp\gametypes\arena::execinfinityremainingammo   , 0.05 );
    self execrecoveryfunction( "norecoil"               , scripts\mp\gametypes\arena::execnorecoil                , 1 );
    self execrecoveryfunction( "movementspeed1_25x"     , scripts\mp\gametypes\arena::execmovementspeed1_25x      , 1 );
    self execrecoveryfunction( "thirdperson"            , scripts\mp\gametypes\arena::execthirdperson             , 1 );
    //self execrecoveryfunction( "alwaysnormaluav"      , scripts\mp\gametypes\arena::execalwaysnormaluav         , 1 );
    self execrecoveryfunction( "freezeplayer"           , scripts\mp\gametypes\arena::execfreezeplayer            , 1 );
    self execrecoveryfunction( "outofmappossible"       , scripts\mp\gametypes\arena::execoutofmappossible        , 1 );
    self execrecoveryfunction( "saveloadlocation"       , scripts\mp\gametypes\arena::execsaveloadlocation        , 0.05 );
    self execrecoveryfunction( "jetpack"                , scripts\mp\gametypes\arena::execjetpack                 , 0.1 );
    self execrecoveryfunction( "ninjamode"              , scripts\mp\gametypes\arena::execninjamode               , 0.05 );
    self execrecoveryfunction( "superslide"             , scripts\mp\gametypes\arena::execsuperslide              , 0.05 );
    self execrecoveryfunction( "shieldman"              , scripts\mp\gametypes\arena::execshieldman               , 1 );
    //self execrecoveryfunction( "healthbar"            , scripts\mp\gametypes\arena::exechealthbar               , 0.05 );
    //self execrecoveryfunction( "discocamo"            , scripts\mp\gametypes\arena::execdiscocamo               , 0.15 );
    self execrecoveryfunction( "setmodel"               , scripts\mp\gametypes\arena::execsetmodel                , 0.05 );
    self execrecoveryfunction( "moddedbullets"          , scripts\mp\gametypes\arena::execmoddedbullets           , 0.05 );
    self execrecoveryfunction( "moddedgrenades"         , scripts\mp\gametypes\arena::execmoddedgrenades          , 0.05 );
    self execrecoveryfunction( "infinityammo"           , scripts\mp\gametypes\arena::execinfinityammo            , 0.05 );
    self execrecoveryfunction( "bindnoclip"             , scripts\mp\gametypes\arena::execbindnoclip              , 0.05 );
    self execrecoveryfunction( "movementspeed"          , scripts\mp\gametypes\arena::execchangemovementspeed     , 1 );
    self execrecoveryfunction( "invisible"              , scripts\mp\gametypes\arena::execinvisible               , 1 );
    //self execrecoveryfunction( "alwaysadvanceduav"    , scripts\mp\gametypes\arena::execalwaysadvanceduav       , 1 );
    //self execrecoveryfunction( "esp"                    , scripts\mp\gametypes\arena::execesp                     , 0.05 );
    self execrecoveryfunction( "godmode"                , scripts\mp\gametypes\arena::execgodmode                 , 1 );
    //self execrecoveryfunction( "nohitmode"            , scripts\mp\gametypes\arena::execnohitmode               , 1 );
    self execrecoveryfunction( "aimbot"                 , scripts\mp\gametypes\arena::execaimbot                  , 0.01 );
    self execrecoveryfunction( "advancedforgemode"      , scripts\mp\gametypes\arena::execadvancedforgemode       , 0.01 );
    //self execrecoveryfunction( "alwaysskinupdater"    , scripts\mp\gametypes\arena::execalwaysskinupdater       , 0.1 );
    //self execrecoveryfunction( "fullcustombullets"    , scripts\mp\gametypes\arena::execfullcustombullets       , 0.05 );
    self execrecoveryfunction( "speedhack"              , scripts\mp\gametypes\arena::execspeedhack               , 0.1 );
    self execrecoveryfunction( "superjump"              , scripts\mp\gametypes\arena::execsuperjump               , 0.05 );
    self execrecoveryfunction( "highradiationmode"      , scripts\mp\gametypes\arena::exechighradiationmode       , 0.01 );
    self execrecoveryfunction( "dogtagshoes"            , scripts\mp\gametypes\arena::execdogtagshoes             , 1 );
    self execrecoveryfunction( "adventureball"          , scripts\mp\gametypes\arena::execadventureball           , 0.01 );
    //if ( self ishost( ) )
    //    self execrecoveryfunction( "xplobby"            , _encstr_BA6F2E3318E5A43B7B56C78DEF285FEE73B0CBEBE8939A8E513EAFBF0F081F73A3B04201407393170BAF9BB5B0919FFE::execxplobby           , 1 );
    ////  if ( isdefined( self.optstat["deadopsarcade"] ) )           { self thread execloopfunction( "deadopsarcade"         , ::execdeadopsarcade           , 0.05 ); }
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Generic function to get menu state
// ja : メニュー状態取得汎用関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : returns the function to be executed when selecting an item from the "current menu hierarchy" and "currently selected item index"
// ja : 「現在のメニュー階層」、「現在選択中の項目インデックス」から、項目決定時に実行する関数を返す
//++++++++++++++++++++++++++++++
getoptionfunction( selflayer , selfoption )
{
    if ( isdefined( level.modmenudata[selflayer] ) && isdefined( level.modmenudata[selflayer].item[selfoption] ) && isdefined( level.modmenudata[selflayer].item[selfoption].callfunc ) )
        return level.modmenudata[selflayer].item[selfoption].callfunc;

    return ::emptyfunction;
}



//++++++++++++++++++++++++++++++
// en : returns the maximum index of the menu from the "current menu hierarchy" and "current privilege state"
// ja : 「現在のメニュー階層」、「現在の権限状態」から、そのメニューの最大インデックスを返す
//++++++++++++++++++++++++++++++
getlayermaxindex( selflayer , selflevel )
{
    l_max   = 0;
    l_data  = level.modmenudata;

    if ( selflayer == level.moddef.ly_playersref )
        return level.players.size - 1;
    
    if ( !isdefined( l_data[selflayer] ) )
        return l_max;

    for ( i = 0; i < l_data[selflayer].item.size; i++ )
    {
        if ( !isdefined( l_data[selflayer].item[i] ) )
            break;
        
        if ( !isdefined( l_data[selflayer].item[i].auth ) )
        {
            l_max = ( l_data[selflayer].item.size - 1 );
            break;
        }
        else
        {
            if ( l_data[selflayer].item[i].auth <= selflevel )
                l_max = i;
            else
                break;
        }
    }

    return l_max;
}



//++++++++++++++++++++++++++++++
// en : returns the corresponding translated text from the "current language", "current menu hierarchy", and "currently selected item index"
// ja : 「現在の言語」、「現在のメニュー階層」、「現在選択中の項目インデックス」から、該当する翻訳文を返す
//++++++++++++++++++++++++++++++
getmodmenutext( selflang , selflayer , selfoption )
{
    l_data = level.modmenudata;

    if ( isdefined( l_data[selflayer] ) && isdefined( l_data[selflayer].item[selfoption] ) && isdefined( l_data[selflayer].item[selfoption].textid ) )
        return getmttext( selflang , "" + l_data[selflayer].item[selfoption].textid , self usinggamepad( ) );

    return "<text_undefined>";
}



//++++++++++++++++++++++++++++++
// en : obtain the enabled/disabled status of the item from the "current language", "current menu hierarchy" and "currently selected item index"
// ja : 「現在の言語」、「現在のメニュー階層」、「現在選択中の項目インデックス」から、その項目の有効・無効状態を取得する
//++++++++++++++++++++++++++++++
getoptionstatus( selflang , selflayer , selfoption , getid )
{
    // en: if the currently open menu level is the player refer menu
    // ja: 今開いているメニュー階層がプレイヤー参照メニューの場合
    if ( selflayer == level.moddef.ly_playersref )                              return " ";
    if ( !isdefined( level.modmenudata[selflayer] ) )                           return "<error_getoptstat_nolayer>";
    if ( !isdefined( level.modmenudata[selflayer].item[selfoption] ) )          return "<error_getoptstat_noitem>";
    if ( !isdefined( level.modmenudata[selflayer].item[selfoption].update ) )   return "<error_getoptstat_noupdate>";

    l_update    = level.modmenudata[selflayer].item[selfoption].update;

    switch ( l_update )
    {
        // level.moddef.mod_notonf
        case 2:   return ( isdefined( getid ) ? " " : "" );
        // level.moddef.mod_reflesh
        case 3:  return " ";
        // level.moddef.ar_submenu
        case 10:   return "  ";

        // level.moddef.mod_enabled
        // level.moddef.mod_fastreflesh
        case 1:
        case 4:
            l_area      = level.modmenudata[selflayer].item[selfoption].area;
            l_textid    = level.modmenudata[selflayer].item[selfoption].textid;
            l_subparam  = level.modmenudata[selflayer].item[selfoption].subparam;
            l_enabled   = ( isdefined( getid ) ? "enabled" : " " + getmttext( selflang , "enabled" ) );

            switch ( l_area )
            {
                case 0: // moddef.ar_self
                    if ( isdefined( l_subparam ) && isdefined( self.optstat[l_subparam] ) && isdefined( self.optstat[l_subparam].moddata[l_textid] ) )
                        return l_enabled;
                    else if ( isdefined( self.optstat[l_textid] ) )
                        return l_enabled;
                    break;
                    
                case 1: // moddef.ar_level
                    if ( isdefined( l_subparam ) && isdefined( level.lvlstat[l_subparam] ) && isdefined( level.lvlstat[l_subparam].moddata[l_textid] ) )
                        return l_enabled;
                    else if ( isdefined( level.lvlstat[l_textid] ) )
                        return l_enabled;
                    break;
                    
                case 2: // moddef.ar_dvar
                    return " : " + getdvarint( l_subparam , 0 );
                    
                case 3: // moddef.ar_perk
                    if ( self isgetperk( l_subparam ) )
                        return l_enabled;
                    break;
                    
                case 4: // moddef.ar_player
                    if ( isdefined( self.modsystem.menuplayer ) && isdefined( level.players[self.modsystem.menuplayer] ) && isdefined( level.players[self.modsystem.menuplayer].optstat[l_textid] ) )
                        return l_enabled;
                    break;
                    
                case 5: // moddef.ar_devide
                    if ( isdefined( self.optstat[l_textid + l_subparam] ) )
                        return " : " + self.optstat[l_textid + l_subparam];
                    break;
                    
                case 6: // moddef.ar_content
                    if ( isdefined( l_subparam ) && isdefined( self.optstat[l_subparam] ) && isdefined( self.optstat[l_subparam].moddata[l_textid] ) )
                    {
                        if ( isdefined( self.optstat[l_subparam].moddata[l_textid].assetname ) )    return " : " + self.optstat[l_subparam].moddata[l_textid].assetname;
                        else                                                                        return " : " + self.optstat[l_subparam].moddata[l_textid];
                    }
                    else if ( isdefined( self.optstat[l_textid] ) )
                        return " : " + self.optstat[l_textid];
                    break;
                    
                case 7: // moddef.ar_lvcontent
                    if ( isdefined( l_subparam ) && isdefined( level.lvlstat[l_subparam] ) && isdefined( level.lvlstat[l_subparam].moddata[l_textid] ) )
                        return " : " + level.lvlstat[l_subparam].moddata[l_textid];
                    else if ( isdefined( level.lvlstat[l_textid] ) )
                        return " : " + level.lvlstat[l_textid];
                    break;
                    
                case 8: // moddef.ar_devidevol
                    if ( isdefined( self.optstat[l_textid + l_subparam] ) )
                        return " : " + self.optstat[l_textid + l_subparam].size;
                    break;
                    
                case 9: // moddef.ar_devidelev
                    if ( isdefined( level.lvlstat[l_textid + l_subparam] ) )
                        return " : " + level.lvlstat[l_textid + l_subparam].size;
                    break;
            }
            return ( isdefined( getid ) ? "disabled" : " " + getmttext( selflang , "disabled" ) );
    }

    return "<error_getoptstat_noitemarg>";
}



//++++++++++++++++++++++++++++++
// en : returns the text sentence of the corresponding permission status from "current permission status"
// ja : 「現在の権限状態」から、該当する権限状態のテキスト文章を返す
//++++++++++++++++++++++++++++++
getverifiedtext( status )
{
    switch ( status )
    {
        case 1:     return "verified";      // level.moddef.lv_verified
        case 2:     return "vip";           // level.moddef.lv_vip
        case 3:     return "admin";         // level.moddef.lv_admin
        case 4:     return "cohost";        // level.moddef.lv_cohost
        case 5:     return "host";          // level.moddef.lv_host
        default:    return "unverified";    // level.moddef.lv_unverified
    }
}



//++++++++++++++++++++++++++++++
// en : check if you have been assigned permissions of "unverified" or higher
// ja : 自分に「未承認」以上の権限が割り振られているか調べる
//++++++++++++++++++++++++++++++
isverified( )
{
    // en: if the approval authority has not been initialized yet, it is considered "unverified".
    // ja: まだ承認権限の初期化がされていない場合は「未承認」とみなす
    if ( !isdefined( self.verificationinit ) )
        return false;

    // en: check if it is greater than or equal to "unverified" and return the result
    // ja: 「unverified」以上かどうかを確認して、その結果を返す
    if ( self.verificationstatusindex <= 0 )
        return false;
    
    return true;
}



//++++++++++++++++++++++++++++++
// en : gets whether the player's authority is selectable.
// ja : プレイヤーの権限が選択対象かどうかを取得する
//++++++++++++++++++++++++++++++
isuntargetverification( )
{
    lv_admin = level.moddef.lv_admin;
    if ( !isdefined( self.optstat ) )                           return false;
    if ( !isdefined( self.optstat["godmode"] ) )                return false;
    if ( !isdefined( self.optstat["nohitmode"] ) )              return false;
    if ( !isdefined( self.verificationstatusindex ) )           return false;
    if ( self.verificationstatusindex < level.moddef.lv_admin ) return false;
    return true;
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Basic generic function
// ja : 基本汎用関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : destroy variables that only you use while processing a mod (called when it becomes unverified)
// ja : 自分のみがmodの処理中に使う変数を破棄する（未承認になった時に呼ばれる）
//++++++++++++++++++++++++++++++
finalizeselfdata( )
{
    wait self.modsystem.menuocanimtime + 0.1;
    // en: issue a "removeauth" event to yourself (this will end the looping function)
    // ja: 自分に対して「removeauth」イベントを発行する（これでループ処理している関数が終了する）
    self notify( "removeauth" );

    // en: wait a little while for the loop to finish
    // ja: ループ処理が終了するのを少しだけ待つ
    wait 0.001;

    // en: discard various variables
    // ja: 各種変数を破棄する
    self.modsystem  = undefined;
    self.optstat    = undefined;
    
    wait 0.001;

    // en: create a variable that only you will use while processing the mod
    // ja: 自分のみがmodの処理中に使う変数を作成する
    self initializeselfdata( );
}



//++++++++++++++++++++++++++++++
// en : promotional message in the center of the screen
// ja : 画面中央に宣伝メッセージ
//++++++++++++++++++++++++++++++
execpromotionalmessage( )
{
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    // en : infinite loop until game exit
    // ja : ゲーム退出まで無限ループ
    while ( true )
    {
        // en : get the translation equivalent to the specified text id in the current language
        // ja : 現在の言語で、指定したテキストidに相当する翻訳を取得する
        l_textprojectname       = getmttext( self.curlang , "projectname" );
        l_textcreated           = getmttext( self.curlang , "created" );
        l_textlearngsc          = getmttext( self.curlang , "learngsc" );
        l_textpromotion         = getmttext( self.curlang , "yourpromotionmessage2" );
        

        // en : display a message in the center of the screen
        // ja : 画面中央にメッセージを表示する
        self iprintlnbold( l_textprojectname + l_textcreated + l_textlearngsc );

        // en : wait until the displayed character disappears, then return to the beginning of the loop and display the character again.
        // ja : 表示された文字が消えるまで待ち、消えたらまたループの先頭に戻って文字を表示する
        wait 4;
        self iprintlnbold( l_textpromotion );
        wait 4;
    }
}



//++++++++++++++++++++++++++++++
// en : display a "welcome" message
// ja : 「ようこそ」メッセージを表示する
//++++++++++++++++++++++++++++++
showwelocomemessage( )
{

    l_quickscope = "quickscopelobby";
    // en : if you are not assigned permissions higher than "unverified", do nothing.
    // ja : 自分に「未承認」以上の権限が割り振られていなければ、何も処理しない
    if ( !( self isverified( ) ) && ( !isdefined( level.lvlstat[l_quickscope] ) ) )
        return;

    // en : get the translation equivalent to the specified text id in the current language
    // ja : 現在の言語で、指定したテキストidに相当する翻訳を取得する
    l_textwelcome           = getmttext( self.curlang , "welcometo" );
    l_textprojectname       = getmttext( self.curlang , "projectname" );
    l_textmoddedlobby       = getmttext( self.curlang , "moddedlobby" );
    
    l_textyourmenustatus    = getmttext( self.curlang , "yourmenustatus" );
    l_textverifiedlevel     = getmttext( self.curlang , getverifiedtext( self.verificationstatusindex ) );
    l_textmenudescription   = getmttext( self.curlang , "modmenuopendescription" );

    // en : display a message in the kill log area at the bottom left of your screen(the kill log has 6 lines, so fill in 3 blank lines)
    // ja : 自分の画面左下、キルログ部分にメッセージを表示する（キルログは6行あるため、3行空白で埋める）
    self iprintln( "" );
    self iprintln( "" );
    self iprintln( "" );
    self iprintln( l_textmenudescription );
    self iprintln( l_textyourmenustatus + l_textverifiedlevel );
    self iprintln( l_textwelcome + l_textprojectname + l_textmoddedlobby );
}



//++++++++++++++++++++++++++++++
// en : allow player actions
// ja : プレイヤーの行動を許可する
//++++++++++++++++++++++++++++++
allowplayermovements( )
{
    // en : if you are not assigned permissions higher than "unverified", do nothing.
    // ja : 自分に「未承認」以上の権限が割り振られていなければ、何も処理しない
    if ( !( self isverified( ) ) )
        return;

    // en : unfreeze state
    // ja : フリーズ状態を解除する
    self freezecontrols( false );
    
    // en : be able to move
    // ja : 動けるようにする
    self allowmovement( true );
    
    // en : make it possible to run
    // ja : 走れるようにする
    self allowsprint( true );
    
    // en : allow jumping
    // ja : ジャンプができるようにする
    self allowjump( true );
    
    // en : allows melee attacks
    // ja : 近接攻撃ができるようにする
    self allowmelee( true );
    
    // en : allows attacks
    // ja : 攻撃ができるようにする
    self allowfire( true );
     
    // en : allows sliding
    // ja : スライディングができるようにする
    self allowslide( true );
    
    // en : make it possible to stand
    // ja : 立てるようにする
    self allowstand( true );
    
    // en : make it possible to prone
    // ja : 伏せられるようにする
    self allowprone( true );
    
    // en : make it possible to crouch
    // ja : しゃがめるようにする
    self allowcrouch( true );
    
    // en : make it possible to reload
    // ja : リロードをできるようにする
    self allowreload( true );
    
    // en : make it possible to see through hidden objects
    // ja : 遮蔽物から覗けるようにする
    self allowmountside( true );
    self allowmounttop( true );
    self allowlean( true );
    
    // en : allow double jumping
    // ja : 2段ジャンプができるようにする
    self allowdoublejump( true );
    
    // en : allow wall running
    // ja : 壁走りができるようにする
    self allowwallrun( true );
    
    // en : allow mantle
    // ja : マントルができるようにする
    self allowmantle( true );
}



//++++++++++++++++++++++++++++++
// en : add line breaks to all lines in the log at the bottom left to make the display cleaner.
// ja : 左下のログを全行分改行して、表示をきれいにする
//++++++++++++++++++++++++++++++
clearloglines( )
{
    for ( i = 0; i < 6; i++ )
        self iprintln( "" );
    self iprintlnbold( "" );
}



//++++++++++++++++++++++++++++++
// en : general-purpose processing to display the fixed phrase "[category] sentence 1: sentence 2"
// ja : "[カテゴリ] 文章1 : 文章2" という定型文を表示するための汎用処理
//++++++++++++++++++++++++++++++
showcentermessage( selflang , tagname , msg1 , msg2 , content , prefix )
{
    // en : define empty string
    // ja : 空の文字列を定義
    l_content = "";
    
    // en : if sentence 2 is set, get the translation of sentence 2
    // ja : 文章2が設定されている場合は、文章2の翻訳を取得する
    if ( isdefined( msg2 ) )
        l_content = " : ^5" + getmttext( selflang , msg2 );
    // en : if a content sentence is set, set the sentence as is.
    // ja : コンテンツ文が設定されている場合は、そのままの文章を設定する
    else if ( isdefined( content ) )
        l_content = " : ^5" + content;
    
    // en : if endings are set, add the ending translation to the end
    // ja : 語尾が設定されている場合は、語尾の翻訳を最後に追加する
    if ( isdefined( prefix ) )
        l_content = l_content + getmttext( selflang , prefix );

    // en : display fixed phrases in the center of the screen
    // ja : 定型文を画面中央に表示する
    self.modsystem.menutextnotice[self.modsystem.menutextnoticecount] = getmttext( selflang , tagname ) + getmttext( selflang , msg1 ) + l_content;


    self iprintlnbold( self.modsystem.menutextnotice[self.modsystem.menutextnoticecount] );

    l_maxtextsizelside = level.moddef.maxvttextsize;
        
    self.modsystem.menutextnoticecount++;
    if ( l_maxtextsizelside < self.modsystem.menutextnoticecount ) self.modsystem.menutextnoticecount = 0;
}



//++++++++++++++++++++++++++++++
// en : obtain input judgment results tailored to keyboard and controller
// ja : キーボード、コントローラーに合わせた入力判定結果を取得する
//++++++++++++++++++++++++++++++
getkeycodepressed( kbtype , controllertype )
{
    l_keytype = "";

    // en: if you are using a gamepad
    // ja: ゲームパッドを使用中の場合
    if ( self usinggamepad( ) ) { l_keytype = controllertype; }
    // en: when using a keyboard and mouse
    // ja: キーボード・マウスを使用中の場合
    else                        { l_keytype = kbtype; }
    
    // en: get the input judgment corresponding to the specified key
    // ja: 指定のキーに相当する入力判定を取得する
    switch ( l_keytype )
    {
        // en: while the "aim" button is pressed
        // ja: 「エイム」ボタンが押されている間
        case "buttonads":               return self adsbuttonpressed( );
        // en: when the button to throw tactical is pressed
        // ja: タクティカルを投げるボタンが押されたら
        case "buttontactical":          return self secondaryoffhandbuttonpressed( );
        // en: while the "use" button is pressed
        // ja: 「使用」ボタンが押されている間
        case "buttonuse":               return self usebuttonpressed( );
        // en: when the "reload" button is pressed
        // ja: 「リロード」ボタンが押されたら
        case "buttonreload":            return self reloadbuttonpressed( );
        // en: when the "melee attack" button is pressed
        // ja: 「近接攻撃」ボタンが押されたら
        case "buttonmelee":             return self meleebuttonpressed( );
        // en: when the "attack" button is pressed
        // ja: 「攻撃」ボタンが押されたら
        case "buttonattack":            return self attackbuttonpressed( );
        // en: when the button to throw lethal is pressed
        // ja: リーサルを投げるボタンが押されたら
        case "buttonlethal":            return self fragbuttonpressed( );
        // en: when the "crouch/prone" button is pressed
        // ja: 「しゃがみ・伏せ」ボタンが押されたら
        case "buttonstance":            return self stancebuttonpressed( );
        // en: when the "jump" button is pressed
        // ja: 「ジャンプ」ボタンが押されたら
        case "buttonjump":              return self jumpbuttonpressed( );
        // en: when the "run/hold your breath" button is pressed
        // ja: 「走る・息止め」ボタンが押されたら
        case "buttonsprint":            return self sprintbuttonpressed( );

        case "none":                    return true;
        case "noneoff":                 return false;
        case "buttondpadup":            return isdefined( self.optstat[l_keytype] );
        case "buttondpaddown":          return isdefined( self.optstat[l_keytype] );

        // en: if any other specific key is pressed
        // ja: それ以外の特定のキーが押されたら
        default:
            if ( !isdefined( self.buttonspressed ) )            { return false; }
            if ( !isdefined( self.buttonspressed[l_keytype] ) ) { return false; }
            return self.buttonspressed[l_keytype].pressed;

    }
}



//++++++++++++++++++++++++++++++
// en : change language
// ja : 言語を変更する
//++++++++++++++++++++++++++++++
changelanguage( )
{
    // en: change the current language to the language selected in the mod menu
    // ja: 現在の言語を、モッドメニューで選択中の言語に変更する
    self.curlang = self.modsystem.menuoptioncurrent;
    
    // en: update the text displayed in the mod menu
    // ja: モッドメニューの表示するテキストを更新する
    self modmenutextupdate( );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : HUD elements generic function
// ja : Hud elemnts 汎用関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : create a hud (on-screen ui) with specified elements
// ja : 指定した要素でhud（画面上のui）を作成する
//++++++++++++++++++++++++++++++
createrectangle( xalignment , yalignment , xpoint , ypoint , xscale , yscale , colorvalue , shadertype , sortvalue , alphavalue , publish )
{
    l_newui = undefined;
    if ( !isdefined( publish ) )
        l_newui             = newclienthudelem( self );
    else
        l_newui             = newhudelem( );
    l_newui.elemtype        = "icon";
    l_newui.color           = colorvalue;
    l_newui.alpha           = alphavalue;
    l_newui.sort            = sortvalue;
    l_newui.children        = [];
    l_newui.archived        = 0;
    l_newui.hidewheninmenu  = 1;
    l_newui.showinkillcam   = 1;
    l_newui setshader( shadertype , xscale , yscale );
    l_newui setpoint( xalignment , yalignment , xpoint , ypoint );
    return l_newui;
}



//++++++++++++++++++++++++++++++
// en : create a hud (on-screen ui) with specified elements
// ja : 指定した要素でhud（画面上のui）を作成する
//++++++++++++++++++++++++++++++
createtextelem( fonttype , fontscale , alignx , aligny , posx , posy , colorvalue , alphavalue , glowcolor , glowalpha , sortvalue , textvalue , parent , value )
{
    l_newui = undefined;
    if ( !isdefined( parent ) )
        l_newui                 = newclienthudelem( self );
    else
        l_newui                 = newhudelem( );
    l_newui.elemtype            = "font";
    l_newui.font                = fonttype;
    l_newui.fontscale           = fontscale;
    l_newui.basefontscale       = fontscale;
    l_newui.x                   = 0;
    l_newui.y                   = 0;
    l_newui.width               = 0;
    l_newui.height              = int( level.fontheight * fontscale );
    l_newui.xoffset             = 0;
    l_newui.yoffset             = 0;
    l_newui.children            = [];
    l_newui setparent( level.uiparent );
    l_newui.hidden              = 0;
    l_newui.archived            = 0;
    l_newui.showinkillcam       = 1;
    l_newui.hidewheninmenu      = 0;
    l_newui.foreground          = 1;
    l_newui.color               = colorvalue;
    l_newui.alpha               = alphavalue;
    l_newui.glowalpha           = glowalpha;
    l_newui.sort                = sortvalue;
    l_newui setpoint( alignx , aligny , posx , posy );
    if ( isdefined( textvalue ) )   l_newui settext( textvalue );
    return l_newui;
}



//++++++++++++++++++++++++++++++
// en : Change the scale and color of the specified HUD string (UI on the screen) within the specified
// ja : 指定したhud string（画面上のui）のスケール、カラーを、指定した秒数で変更する
//++++++++++++++++++++++++++++++
fontscalecolor( time , scale , color , alpha )
{
    self changefontscaleovertime( time );
    self.fontscale = scale;
    self fadeovertime( time );
    self.alpha = alpha;
    self.color = color;
}



//++++++++++++++++++++++++++++++
// en : move the xy axis position of the specified hud (on-screen ui) in the specified number of seconds.
// ja : 指定したhud（画面上のui）のxy軸の位置を、指定した秒数で移動させる
//++++++++++++++++++++++++++++++
elementmovexy( time , xpoint , ypoint )
{
	self moveovertime( time );
    if ( isdefined( xpoint ) ) self.x = xpoint;
    if ( isdefined( ypoint ) ) self.y = ypoint;
}



//++++++++++++++++++++++++++++++
// en : changes the color of the specified hud (on-screen ui) for the specified number of seconds.
// ja : 指定したhud（画面上のui）の色を、指定した秒数で変色させる
//++++++++++++++++++++++++++++++
elementcolorchange( time , colorvalue , alpha )
{
	self fadeovertime( time );
	self.color = colorvalue;
	self.alpha = alpha;
}



//++++++++++++++++++++++++++++++
// en : get the gsc color code from the specified rgb color balance
// ja : 指定したrgb色バランスからgsc用カラーコードを取得する
//++++++++++++++++++++++++++++++
dividecolor( rvalue , gvalue , bvalue )
{
    return ( (rvalue / 255) , (gvalue / 255) , (bvalue / 255) );
}



//++++++++++++++++++++++++++++++
// en : Waits the specified amount of time before removing its UI.
// ja : 指定した時間分待機してから自身のUIを削除する
//++++++++++++++++++++++++++++++
delaydestroyelem( time )
{
    wait time;
    self destroy( );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : HUD elements Show / Hide function
// ja : Hud elemnts 表示 / 非表示 関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : Create the background for the vertical mod menu.
// ja : 縦型 Mod Menu の背景を作成する
//++++++++++++++++++++++++++++++
createelemleftmenu( )
{
    l_nosize            = 0;
    l_defxleft          = level.moddef.vl_elemxverticalmenu;
    l_defyleft          = level.moddef.vl_elemyverticalmenu;
    l_defwidthleft      = level.moddef.vl_elemwverticalmenu;
    l_halfwidthleft     = l_defwidthleft / 2;
    l_defheightleft     = level.moddef.vl_elemhverticalmenu;
    l_halfheightleft    = l_defheightleft / 2;
    l_leftposleft       = l_defxleft - l_halfwidthleft;
    l_rightposleft      = l_defxleft + l_halfwidthleft;
    l_upperposleft      = l_defyleft - l_halfheightleft;
    l_lowerposleft      = l_defyleft + l_halfheightleft;
    l_inlineposleft     = l_defyleft - 17;
    l_bg2posleft        = l_inlineposleft - 29;
    l_outlinesize       = level.moddef.vl_elemsizeoutline;
    l_alg               = "CENTER";
    l_shad              = "white";
    l_grey              = dividecolor( 55   , 55    , 55    );
    l_grey2             = dividecolor( 20   , 20    , 20    );
    l_blue              = dividecolor( 37   , 72    , 106   );
    l_yellow            = dividecolor( 201  , 149   , 36    );
    l_alpha             = 0.85;
    l_sort              = 0;
    self.modsystem.menuui["left_bg1"]       = self createrectangle( l_alg , l_alg , l_defxleft      , l_defyleft        , l_defwidthleft    , l_nosize      , l_grey    , l_shad , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["left_bg2"]       = self createrectangle( l_alg , l_alg , l_defxleft      , l_bg2posleft      , l_defwidthleft    , l_nosize      , l_grey2   , l_shad , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["left_inline_1"]  = self createrectangle( l_alg , l_alg , l_defxleft      , l_inlineposleft   , l_nosize          , l_outlinesize , l_blue    , l_shad , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["left_outline_1"] = self createrectangle( l_alg , l_alg , l_leftposleft   , l_defyleft        , l_outlinesize     , l_nosize      , l_yellow  , l_shad , l_sort , l_alpha );
    self.modsystem.menuui["left_outline_2"] = self createrectangle( l_alg , l_alg , l_rightposleft  , l_defyleft        , l_outlinesize     , l_nosize      , l_yellow  , l_shad , l_sort , l_alpha );
    self.modsystem.menuui["left_outline_3"] = self createrectangle( l_alg , l_alg , l_defxleft      , l_upperposleft    , l_nosize          , l_outlinesize , l_yellow  , l_shad , l_sort , l_alpha );
    self.modsystem.menuui["left_outline_4"] = self createrectangle( l_alg , l_alg , l_defxleft      , l_lowerposleft    , l_nosize          , l_outlinesize , l_yellow  , l_shad , l_sort , l_alpha );
}



//++++++++++++++++++++++++++++++
// en : Display the background of the vertical mod menu.
// ja : 縦型 Mod Menu の背景を表示する
//++++++++++++++++++++++++++++++
showelemleftmenu( time )
{
    l_outlinesize           = level.moddef.vl_elemsizeoutline;
    l_defwidthleft          = level.moddef.vl_elemwverticalmenu;
    l_defheightleft         = level.moddef.vl_elemhverticalmenu;
    l_targetwidthleft       = l_defwidthleft;
    l_targetheightleft      = l_defheightleft;
    l_targetheightbg2left   = l_targetheightleft - 94;

    self.modsystem.menuui["left_bg1"]       scaleovertime( time , l_targetwidthleft           , l_targetheightleft );
    self.modsystem.menuui["left_bg2"]       scaleovertime( time , l_targetwidthleft           , l_targetheightbg2left );
    self.modsystem.menuui["left_outline_1"] scaleovertime( time , l_outlinesize               , l_targetheightleft );
    self.modsystem.menuui["left_outline_2"] scaleovertime( time , l_outlinesize               , l_targetheightleft );
    self.modsystem.menuui["left_outline_3"] scaleovertime( time , l_targetwidthleft           , l_outlinesize );
    self.modsystem.menuui["left_outline_4"] scaleovertime( time , l_targetwidthleft           , l_outlinesize );
    self.modsystem.menuui["left_inline_1"]  scaleovertime( time , ( l_targetwidthleft - 2 )   , l_outlinesize );
}



//++++++++++++++++++++++++++++++
// en : Scale out the background of the vertical mod menu.
// ja : 縦型 Mod Menu の背景をスケールアウトする
//++++++++++++++++++++++++++++++
hideelemleftmenu( time )
{
    l_nosize        = 0;
    l_outlinesize   = level.moddef.vl_elemsizeoutline;
    l_defwidthleft  = level.moddef.vl_elemwverticalmenu;

    self.modsystem.menuui["left_bg1"]           scaleovertime( time , l_defwidthleft  , l_nosize );
    self.modsystem.menuui["left_bg2"]           scaleovertime( time , l_defwidthleft  , l_nosize );
    self.modsystem.menuui["left_outline_1"]     scaleovertime( time , l_outlinesize   , l_nosize );
    self.modsystem.menuui["left_outline_2"]     scaleovertime( time , l_outlinesize   , l_nosize );
    self.modsystem.menuui["left_outline_3"]     scaleovertime( time , l_nosize        , l_outlinesize );
    self.modsystem.menuui["left_outline_4"]     scaleovertime( time , l_nosize        , l_outlinesize );
    self.modsystem.menuui["left_inline_1"]      scaleovertime( time , l_nosize        , l_outlinesize );

}



//++++++++++++++++++++++++++++++
// en : Destroy the background of the vertical mod menu.
// ja : 縦型 Mod Menu の背景を削除する
//++++++++++++++++++++++++++++++
destroyelemleftmenu( )
{
    self.modsystem.menuui["left_bg1"]           destroy( );
    self.modsystem.menuui["left_bg2"]           destroy( );
    self.modsystem.menuui["left_outline_1"]     destroy( );
    self.modsystem.menuui["left_outline_2"]     destroy( );
    self.modsystem.menuui["left_outline_3"]     destroy( );
    self.modsystem.menuui["left_outline_4"]     destroy( );
    self.modsystem.menuui["left_inline_1"]      destroy( );
}



//++++++++++++++++++++++++++++++
// en : Create the background for the horizontal mod menu.
// ja : 日本国旗を作成する
//++++++++++++++++++++++++++++++
createelemjapanflag( )
{
    l_nosize        = 0;
    l_defx          = 0;
    l_defy          = level.moddef.vl_elemyhorizontalmenu;
    if ( ( level.mapname == "mp_escape4" ) || ( level.mapname == "mp_sm_island_1" ) )
    {
        l_defy = level.moddef.vl_elemyfixhorizontalmenu;
    }
    l_defheight     = level.moddef.vl_elemyjapicon;
    l_halfheight    = l_defheight / 2;
    l_upperpos      = l_defy    - l_halfheight;
    l_headerpos     = l_upperpos + ( l_halfheight / 3 );

    l_red           = dividecolor( 188  , 0     , 45    );
    l_white         = dividecolor( 255  , 255   , 255   );
    l_alg           = "CENTER";
    l_shad          = "white";
    l_shad2         = "hud_realism_head_revive";
    l_alpha         = 1;
    l_sort          = 10;
    self.modsystem.menuui["japw"]       = self createrectangle( l_alg , l_alg , l_defx          , l_headerpos           , l_nosize , l_nosize , l_white   , l_shad  , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["japr"]       = self createrectangle( l_alg , l_alg , l_defx          , l_headerpos           , l_nosize , l_nosize , l_red     , l_shad2 , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["japrfix1"]   = self createrectangle( l_alg , l_alg , l_defx          , ( l_headerpos - 1 )   , l_nosize , l_nosize , l_red     , l_shad  , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["japrfix2"]   = self createrectangle( l_alg , l_alg , ( l_defx + 1 )  , ( l_headerpos - 2 )   , l_nosize , l_nosize , l_red     , l_shad  , l_sort , l_alpha ); l_sort++;
    self.modsystem.menuui["japwfix"]    = self createrectangle( l_alg , l_alg , l_defx          , ( l_headerpos + 7 )   , l_nosize , l_nosize , l_white   , l_shad  , l_sort , l_alpha );
}



//++++++++++++++++++++++++++++++
// en : Scale out the Japanese national flag.
// ja : 日本国旗をスケールアウトする
//++++++++++++++++++++++++++++++
scaleelemjapanflag( time , wh )
{
    l_japw      = ( 0 < wh ) ? ( wh + 6 )   : 0;
    l_japr      = ( 0 < wh ) ? ( wh + 5 )   : 0;
    l_japrfix   = ( 0 < wh ) ? ( wh - 17 )  : 0;
    l_japwfixw  = ( 0 < wh ) ? ( wh - 10 )  : 0;
    l_japwfixh  = ( 0 < wh ) ? ( wh - 22 )  : 0;

    self.modsystem.menuui["japw"]       scaleovertime( time , l_japw        , wh );
    self.modsystem.menuui["japr"]       scaleovertime( time , l_japr        , l_japr );
    self.modsystem.menuui["japrfix1"]   scaleovertime( time , l_japrfix     , l_japrfix );
    self.modsystem.menuui["japrfix2"]   scaleovertime( time , l_japrfix     , l_japrfix );
    self.modsystem.menuui["japwfix"]    scaleovertime( time , l_japwfixw    , l_japwfixh );
}



//++++++++++++++++++++++++++++++
// en : Move the Japanese national flag to the specified coordinates.
// ja : 日本国旗を指定座標に移動させる
//++++++++++++++++++++++++++++++
moveelemjapanflag( time , x , y )
{
    self.modsystem.menuui["japw"]       elementmovexy( time , x         , y );
    self.modsystem.menuui["japr"]       elementmovexy( time , x         , y );
    self.modsystem.menuui["japrfix1"]   elementmovexy( time , x         , ( y - 1 ) );
    self.modsystem.menuui["japrfix2"]   elementmovexy( time , ( x + 1 ) , ( y - 2 ) );
    self.modsystem.menuui["japwfix"]    elementmovexy( time , x         , ( y + 7 ) );
}



//++++++++++++++++++++++++++++++
// en : Destroy the Japanese national flag.
// ja : 日本国旗を削除する
//++++++++++++++++++++++++++++++
destroyelemjapanflag( )
{
    self.modsystem.menuui["japw"]               destroy( );
    self.modsystem.menuui["japr"]               destroy( );
    self.modsystem.menuui["japrfix1"]           destroy( );
    self.modsystem.menuui["japrfix2"]           destroy( );
    self.modsystem.menuui["japwfix"]            destroy( );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Mod Menu basic operation function
// ja : Mod Menu 基本操作関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : open (display) the mod menu
// ja : モッドメニューを開く（表示する）
//++++++++++++++++++++++++++++++
modmenuopen( opentime )
{
    // en: suppose the mod menu is opened
    // ja: モッドメニューが開かれたとする
    self.modsystem.menuactive = true;
    
    // en: issue a "openmodmenu" event to yourself (this will stop the menu text display update process)
    // ja: 自分に対して "openmodmenu" イベントを発行する（これでメニューテキストの表示更新処理が止まる）
    self notify( "openmodmenu" );

    // en : allow player actions
    // ja : プレイヤーの行動を許可する
    self allowplayermovements( );
    // en: play se only for yourself
    // ja: seを自分だけ再生する
    self playlocalsound( "mp_killstreak_transition_whoosh" );

    
    // en : Define variables for creating the mod menu background UI.
    // ja : モッドメニューの背景ui作成用の変数を定義
    l_japiconsize       = level.moddef.vl_elemsizejapicon;
    l_animtime          = opentime;
    l_interval          = 0;
    l_defxleft          = level.moddef.vl_elemxverticalmenu;
    l_defyleft          = level.moddef.vl_elemyverticalmenu;
    l_defwidthleft      = level.moddef.vl_elemxjapicon;
    l_defheightleft     = level.moddef.vl_elemyleftmenujapicon;
    
    l_defleftx          = l_defxleft + ( l_defwidthleft / 2 ) - ( l_japiconsize / 2 ) + 20;
    l_deflefty          = l_defyleft - ( l_defheightleft / 2 ) + ( l_japiconsize / 2 ) + 10;
    l_changemenustyle   = "changemenustyle";
    l_iprintlnmenu      = "iprintlnmenu";


    // en: create background ui for mod menu
    // ja: モッドメニューの背景uiを作成する
    

    // en: when opening the mod menu for the first time
    // ja: モッドメニューを初めて開く場合
    if ( self.modsystem.menufirstopen == true )
    {
        self createelemjapanflag( );
        self createelemleftmenu( );
    }


    // en : changes the height and width of the specified hud (on-screen ui) in the specified number of seconds.
    // ja : 指定したhud（画面上のui）の縦横幅を、指定した秒数でサイズ変更する

    // en : move the xy axis position of the specified hud (on-screen ui) in the specified number of seconds.
    // ja : 指定したhud（画面上のui）のxy軸の位置を、指定した秒数で移動させる
    self moveelemjapanflag( l_interval , l_defleftx , l_deflefty );

    self scaleelemjapanflag( l_animtime , l_japiconsize );
    self showelemleftmenu( l_animtime );
    

    // en : run color animation of mod menu background color in subthread
    // ja : モッドメニューの背景色のカラーアニメーションをサブスレッドで実行する
    self thread modmenubackgroundcoloranimation( );

    // en: wait 0.3 seconds
    // ja: 0.3秒待機する
    wait l_animtime + 0.01;
    
    // en: when opening the mod menu for the first time, force the language menu to open
    // ja: モッドメニューを初めて開く場合、言語メニューを開かせる
    if ( self.modsystem.menufirstopen == true )
    {
        ln_en = level.moddef.ln_en;
        ly_languages = level.moddef.ly_languages;

        // en: current mod menu open page
        // ja: 現在のモッドメニューの開いているページ
        self.modsystem.menulayercurrent = ly_languages;
        // en: index of selected item in current mod menu
        // ja: 現在のモッドメニューの選択している項目インデックス
        self.modsystem.menuoptioncurrent = ln_en;
        // en: the depth of the current mod menu's open hierarchy
        // ja: 現在のモッドメニューの開いている階層の深さ
        self.modsystem.menulayerdepth = 1;
        // en: the mod menu page that was opened just before
        // ja: 直前に開いていたモッドメニューのページ
        self.modsystem.menulayerprevious[0] = 0;
        // en: item index of the mod menu that was most recently selected
        // ja: 直前に選択していたモッドメニューの項目インデックス
        self.modsystem.menuoptionprevious[0] = ( ly_languages - 1 );
        // en: Horizontal scroll position of the previously selected mod menu
        // ja: 直前に選択していたモッドメニューの横スクロール位置
        self.modsystem.menulrposprevious[0] = ( ly_languages - 1 );
    }

    // en: update the text displayed in the mod menu
    // ja: モッドメニューの表示するテキストを更新する
    self modmenutextupdate( );
}



//++++++++++++++++++++++++++++++
// en : scrolls the selected item up in the displayed mod menu
// ja : 表示中のモッドメニューの、選択中の項目を上にスクロールする
//++++++++++++++++++++++++++++++
modmenuscroll( path , scrolltime )
{
    l_iprintlnmenu  = "iprintlnmenu";
    l_up            = 0;
    l_maxindex      = 0;
    ly_playersref   = level.moddef.ly_playersref;
    l_maxtextsize   = ( !isdefined( self.optstat[l_iprintlnmenu] ) ? level.moddef.customtextlength : level.moddef.maxhrtextsize ) - 1;
    
    // en: if the currently open menu level is not the player refer menu, get the maximum index for each authority in each menu hierarchy
    // ja: 今開いているメニュー階層がプレイヤー参照メニューではない場合、各メニュー階層における、権限毎の最大インデックスを取得する
    if ( self.modsystem.menulayercurrent != ly_playersref )
        l_maxindex = getlayermaxindex( self.modsystem.menulayercurrent , self.verificationstatusindex );
    // en: if the currently open menu level is the player menu, get the maximum number of players currently participating
    // ja: 今開いているメニュー階層がプレイヤーメニューの場合、現在参加中のプレイヤーの最大人数を取得する
    else
        l_maxindex = level.players.size - 1;

    if ( path == l_up )
    {
        // en: set the horizontal scroll position of the mod menu to the top
        // ja: モッドメニューの横スクロール位置を左にずらす
        if ( 0 < self.modsystem.menulrpos )
            self.modsystem.menulrpos--;

        // en: if the currently selected item index is at the top, select the bottom item
        // ja: 現在選択中の項目インデックスが一番上の場合、一番下の項目を選択する
        if ( self.modsystem.menuoptioncurrent <= 0 )
        {
            self.modsystem.menuoptioncurrent = l_maxindex;
            self.modsystem.menulrpos = ( l_maxtextsize < l_maxindex ) ? l_maxtextsize : l_maxindex;
        }
        // en: if the currently selected item index is not the top one, move the currently selected item index in the mod menu one position forward (up)
        // ja: 現在選択中の項目インデックスが一番上ではない場合、モッドメニューの選択中項目インデックスを1つ前（上）にずらす
        else
            self.modsystem.menuoptioncurrent--;
    }
    else
    {
        // en: set the horizontal scroll position of the mod menu to the top
        // ja: モッドメニューの横スクロール位置を右にずらす
        if ( self.modsystem.menulrpos < l_maxtextsize )
            self.modsystem.menulrpos++;

        // en: if the currently selected item index exceeds the maximum index, select the top item
        // ja: 現在選択中の項目インデックスが、最大インデックスを超えている場合、一番上の項目を選択する
        if ( l_maxindex <= self.modsystem.menuoptioncurrent )
        {
            self.modsystem.menuoptioncurrent = 0;
            self.modsystem.menulrpos = 0;
        }
        // en: if the currently selected item index is less than the maximum index, shift the selected item index in the mod menu one position later (down)
        // ja: 現在選択中の項目インデックスが、最大インデックス未満の場合、モッドメニューの選択中項目インデックスを1つ後（下）にずらす
        else
            self.modsystem.menuoptioncurrent++;
    }
    
    // en: play se only for yourself
    // ja: seを自分だけ再生する
    self playlocalsound( "iw8_ks_ac130_weaponswitch" );

    // en: update the text displayed in the mod menu
    // ja: モッドメニューの表示するテキストを更新する
    self modmenutextupdate( );

    // en: wait 0.15 seconds
    // ja: 0.15秒待機する
    wait scrolltime;
}



//++++++++++++++++++++++++++++++
// en : execute the function registered in the currently selected item in a subthread
// ja : 現在選択中の項目に登録されている関数をサブスレッドで実行する
//++++++++++++++++++++++++++++++
modmenudecideoption( )
{
    mod_enabled         = 1;
    mod_notonf          = 2;
    mod_reflesh         = 3;
    mod_fastreflesh     = 4;
    ar_submenu          = 10;
    l_iprintlnmenu      = "iprintlnmenu";

    l_update = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].update;

    self thread [[ self.modsystem.menufunction ]]( );
    
    // en: play se only for yourself
    // ja: seを自分だけ再生する
    self playlocalsound( "weap_cluster_target_beep" );

    // en: when opening a submenu or for items that do not require text updates, update the text during other processing.
    // ja: サブメニューを開いた時の場合や、文字更新の必要ない項目は、他処理時に文字更新を行う
    if ( !isdefined( l_update ) ||
        ( l_update == mod_notonf ) ||
        ( l_update == ar_submenu ) )
    {
        wait 0.15;
    }
    // en: update the text displayed in the mod menu
    // ja: モッドメニューの表示するテキストを更新する
    else if ( ( l_update == mod_enabled ) ||
            ( l_update == mod_reflesh ) )
    {
        wait 0.15;
        self modmenutextupdate( );
    }
    // en: for items that you want to make ultra-high-speed decisions, update the text instantly.
    // ja: 超高速で項目決定を行いたい項目は、瞬時にテキスト更新を行う
    else if ( l_update == mod_fastreflesh )
    {
        wait 0.001;
        self modmenutextupdate( );
    }
}



//++++++++++++++++++++++++++++++
// en : open submenu (move down the mod menu level)
// ja : サブメニューを開く（モッドメニューの階層を下げる）
//++++++++++++++++++++++++++++++
modmenuopensubmenu( )
{
    value_root = 0;
    ly_playersmod   = level.moddef.ly_playersmod;
    ly_playersref   = level.moddef.ly_playersref;

    // en: remember the currently open menu hierarchy and item index
    // ja: 今開いているメニュー階層と項目インデックスを記憶する
    self.modsystem.menulayerprevious[self.modsystem.menulayerdepth]     = self.modsystem.menulayercurrent;
    self.modsystem.menuoptionprevious[self.modsystem.menulayerdepth]    = self.modsystem.menuoptioncurrent;
    self.modsystem.menulrposprevious[self.modsystem.menulayerdepth]     = self.modsystem.menulrpos;

    // en: if the current menu hierarchy is the player refer menu
    // ja: 現在のメニュー階層がプレイヤー参照メニューの場合
    if ( self.modsystem.menulayercurrent == ly_playersref )
        // en: set to layer index in player menu
        // ja: プレイヤーメニューのレイヤーインデックスに設定する
        self.modsystem.menulayercurrent = ly_playersmod;
    // en: for other menu levels
    // ja: それ以外のメニュー階層の場合
    else
        self.modsystem.menulayercurrent = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent ].jumppage;

    // en: move the selected item index to the top
    // ja: 選択中の項目インデックスを一番上にする
    self.modsystem.menuoptioncurrent = value_root;

    // en: set the horizontal scroll position of the mod menu to the top
    // ja: モッドメニューの横スクロール位置を先頭にする
    self.modsystem.menulrpos = value_root;

    // en: reduce the depth of the mod menu
    // ja: モッドメニューの階層の深さを下げる
    self.modsystem.menulayerdepth++;
    
    // en: update the text displayed in the mod menu
    // ja: モッドメニューの表示するテキストを更新する
    self modmenutextupdate( );
}



//++++++++++++++++++++++++++++++
// en : restore menu hierarchy (close mod menu if root is open)
// ja : メニュー階層を戻す（ルートを開いている場合は、モッドメニューを閉じる）
//++++++++++++++++++++++++++++++
modmenubacklayer( movetime )
{
    ly_root = 0;

    // en: if the depth of the menu hierarchy is below the root
    // ja: メニュー階層の深さがルートより下にある場合
    if ( ly_root < self.modsystem.menulayerdepth )
    {
        // en: increase the depth of the menu hierarchy
        // ja: メニュー階層の深さを上げる
        self.modsystem.menulayerdepth--;

        // en: set the menu hierarchy and item index that were opened immediately before
        // ja: 直前に開いていたメニュー階層と項目インデックスにする
        self.modsystem.menulayercurrent     = self.modsystem.menulayerprevious[self.modsystem.menulayerdepth];
        self.modsystem.menuoptioncurrent    = self.modsystem.menuoptionprevious[self.modsystem.menulayerdepth];
        self.modsystem.menulrpos            = self.modsystem.menulrposprevious[self.modsystem.menulayerdepth];
        
        // en: play se only for yourself
        // ja: seを自分だけ再生する
        self playlocalsound( "recon_drone_spotted_plr" );
        
        // en: update the text displayed in the mod menu
        // ja: モッドメニューの表示するテキストを更新する
        self modmenutextupdate( );
        
        // en: wait 0.3 seconds
        // ja: 0.3秒待機する
        wait movetime;
    }
    else
        // en: close (hide) the mod menu
        // ja: モッドメニューを閉じる（非表示にする）
        self modmenuclose( movetime );
}



//++++++++++++++++++++++++++++++
// en : close (hide) the mod menu
// ja : モッドメニューを閉じる（非表示にする）
//++++++++++++++++++++++++++++++
modmenuclose( movetime )
{
    // en: suppose the mod menu is closed
    // ja: モッドメニューが閉じられたとする
    self.modsystem.menuactive = false;
    
    // en: play se only for yourself
    // ja: seを自分だけ再生する
    self playlocalsound( "recondrone_tag" );

    // en: issue a "closemodmenu" event to yourself (this will stop the menu text display update process)
    // ja: 自分に対して「closemodmenu」イベントを発行する（これでメニューテキストの表示更新処理が止まる）
    self notify( "closemodmenu" );
    
    // en: waits for only 1 frame as it waits for the update process to finish.
    // ja: 更新処理の終了待ちの為 1フレーム のみ待機する
    wait 0.001;
    
    // en: add line breaks to all lines in the log at the bottom left to make the display cleaner.
    // ja: 左下のログを全行分改行して、表示をきれいにする
    self clearloglines( );
    
    l_animtime      = movetime;
    l_nosize        = 0;
    l_verticalmenu  = "changemenustyle";
    l_iprintlnmenu  = "iprintlnmenu";

    // en : changes the height and width of the specified hud (on-screen ui) in the specified number of seconds.
    // ja : 指定したhud（画面上のui）の縦横幅を、指定した秒数でサイズ変更する

    self hideelemleftmenu( l_animtime );
    self scaleelemjapanflag( l_animtime , l_nosize );
        
    // en: wait 0.3 seconds
    // ja: 0.3秒待機する
    wait l_animtime + 0.01;


    // en: delete the created mod menu design ui
    // ja: 作成したモッドメニューのデザインuiを削除する

            
    //self destroyelemleftmenu( );
    //self destroyelemjapanflag( );
    
    wait 0.001;
    
    // en: if you are opening the mod menu for the first time, the initialization process will end.
    // ja: モッドメニューを初めて開いていた場合、初期化処理は終了する
    if ( self.modsystem.menufirstopen )
        self.modsystem.menufirstopen = false;
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Mod Menu text update function
// ja : Mod Menu 文字更新処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : update mod menu text
// ja : モッドメニューのテキストを更新する
//++++++++++++++++++++++++++++++
modmenutextupdate( )
{
    l_iprintlnmenu  = "iprintlnmenu";
    ly_root         = 0;
    ly_playersref   = level.moddef.ly_playersref;
    l_maxtextsize   = ( !isdefined( self.optstat[l_iprintlnmenu] ) ? level.moddef.customtextlength : level.moddef.maxhrtextsize );
    l_scrollpos     = self.modsystem.menuoptioncurrent - self.modsystem.menulrpos;
    l_playersname   = [];
    l_optindex      = 0;

        
    // en: get the maximum index of the currently open mod menu hierarchy
    // ja: 現在開いているモッドメニューの階層の最大インデックスを取得
    l_maxindex = getlayermaxindex( self.modsystem.menulayercurrent , self.verificationstatusindex );

    // en: if the current menu hierarchy is the root, if there is player information referenced in the player menu, it will be discarded.
    // ja: 現在のメニュー階層がルートの場合、プレイヤーメニューで参照していたプレイヤー情報があれば、破棄する
    if ( ( self.modsystem.menulayercurrent == ly_root ) && isdefined( self.modsystem.menuplayer ) )
        self.modsystem.menuplayer = undefined;

    // en: if the currently open menu level is not the player refer menu
    // ja: 今開いているメニュー階層がプレイヤー参照メニューではない場合
    if ( self.modsystem.menulayercurrent != ly_playersref )
        // en: update the currently selected mod menu item function
        // ja: 現在選択中のモッドメニューの項目関数を更新
        self.modsystem.menufunction = getoptionfunction( self.modsystem.menulayercurrent , self.modsystem.menuoptioncurrent );
    // en: if the currently open menu hierarchy is the player reference menu
    // ja: 今開いているメニュー階層がプレイヤー参照メニューの場合
    else
        // en: update the currently selected mod menu item function
        // ja: 現在選択中のモッドメニューの項目関数を更新
        self.modsystem.menufunction = ::modmenuopensubmenu;

        
    // en: if the currently open menu hierarchy is the player reference menu
    // ja: 今開いているメニュー階層がプレイヤー参照メニューの場合
    if ( self.modsystem.menulayercurrent == ly_playersref )
    {
        // en: get information on all participating players
        // ja: 参加中の全プレイヤー情報を取得
        for ( i = 0; i < level.players.size; i++ )
        {
            // en: get the privilege status of that player
            // ja: そのプレイヤーの権限状態を取得
            l_playersname[i] = getmttext( self.curlang , getverifiedtext( level.players[i].verificationstatusindex ) );
        
            // en: if the currently selected menu item index and player index match
            // ja: 現在選択中のメニュー項目インデックスと、プレイヤーインデックスが一致している場合
            if ( self.modsystem.menuoptioncurrent == i )
            {
                // en: change selected player name to highlight color
                // ja: 選択中のプレイヤー名をハイライト色に変える
                l_playersname[i] += "^5";
                
                // en: set currently selected player
                // ja: 現在選択中のプレイヤーを設定
                self.modsystem.menuplayer = i;
            }

            // en: get player name (up to this point, the sentence "[authority] player name" is constructed)
            // ja: プレイヤー名を取得（ここまでで「[権限] プレイヤー名」という文章が構築される）
            l_playersname[i] += level.players[i].name;
        }
    }

    // en: loop for the number of text elements of the second and subsequent modmenu items
    // ja: ２番目以降のmodmenu項目のテキストの要素数分ループ
    for ( textnum = 0; textnum < l_maxtextsize; textnum++ )
    {
        l_optindex = l_scrollpos + textnum;

        // en: if "top selected modmenu item + loop element number" does not exceed the maximum index
        // ja: 「一番上の選択中のmodmenu項目 + ループ要素の数値」が、最大インデックスを超えていなければ
        if ( l_optindex <= l_maxindex )
        {
            // en: if the currently open menu hierarchy is the player reference menu
            // ja: 今開いているメニュー階層がプレイヤー参照メニューの場合
            if ( self.modsystem.menulayercurrent == ly_playersref )
            {
                // en: get the player name for that item
                // ja: その項目のプレイヤー名を取得する
                self.modsystem.menutext[textnum] = l_playersname[l_optindex];
                self.modsystem.menutextid[textnum] = l_playersname[l_optindex];
            }
            // en: if the currently open menu level is not the player refer menu
            // ja: 今開いているメニュー階層がプレイヤー参照メニューではない場合
            else
            {
                // en: get the text of that item
                // ja: その項目の文章を取得する
                self.modsystem.menutext[textnum] = getmodmenutext( self.curlang , self.modsystem.menulayercurrent , l_optindex );
                //self.modsystem.menutextid[textnum] = getmodmenutextid( self.modsystem.menulayercurrent , l_optindex );
            }

            // en: if the currently open menu level is not the player reference menu
            // ja: 今開いているメニュー階層がプレイヤー参照メニューではない場合
            if ( self.modsystem.menulayercurrent != ly_playersref )
            {
                // en: get the running status of that item
                // ja: その項目の実行状態を取得する
                self.modsystem.menutext[textnum] += self getoptionstatus( self.curlang , self.modsystem.menulayercurrent , l_optindex , undefined );
                //self.modsystem.menutextstatus[textnum] = self getoptionstatus( self.curlang , self.modsystem.menulayercurrent , l_optindex , true );
            }
        }
        // en: if the maximum index is exceeded, display empty text
        // ja: 最大インデックスを超えていれば、空文を表示する
        else
        {
            self.modsystem.menutext[textnum] = "";
            self.modsystem.menutextid[textnum] = " ";
            self.modsystem.menutextstatus[textnum] = " ";
        }
    }
    
    // en: issue a "refreshmodmenu" event to yourself (this will stop the menu text display update process)
    // ja: 自分に対して「refreshmodmenu」イベントを発行する（これでメニューテキストの表示更新処理が止まる）
    self notify( "refreshmodmenu" );

    // en: waits for only 1 frame as it waits for the update process to finish.
    // ja: 更新処理の終了待ちの為 1フレーム のみ待機する
    wait 0.01;
    
    // en: execute the update process of the character display of the mod menu in a subthread
    // ja: モッドメニューの文字表示の更新処理をサブスレッドで実行する
    self thread modmenutextdisplay( );
}



//++++++++++++++++++++++++++++++
// en : processing to display mod menu text
// ja : モッドメニューのテキストを表示する処理
//++++++++++++++++++++++++++++++
modmenutextdisplay( )
{
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );
    // en : this function terminates when "mod menu is closed"
    // ja : この関数は "モッドメニューが閉じられた" 場合に処理を終了する
    self endon( "closemodmenu" );
    // en: the processing of this function ends when the "refreshmodmenu" event is issued for yourself.
    // ja: 自分に対して「refreshmodmenu」イベントが発行されたら、この関数の処理が終了する
    self endon( "refreshmodmenu" );
    // en : This function terminates processing if the "mod menu style has been changed."
    // ja : この関数は「モッドメニュースタイルが変更された」場合に処理を終了する
    self endon( "changedmenustyle" );
    
    l_title             = "";
    l_description       = "";
    l_maintext          = "";
    l_parenttext        = "";
    l_projectname       = "";
    l_index             = "";
    l_curlayerinfo      = "";
    //l_description       = "";
    ly_root             = 0;
    ly_playersmod       = level.moddef.ly_playersmod;
    l_scrollpos         = 0;
    l_maxindex          = 0;
    l_maxtextsize       = level.moddef.maxhrtextsize;
    l_maxtextsizelside  = level.moddef.maxvttextsize;
    l_lefticon          = "";
    l_righticon         = "";
    l_adsicon           = "";
    l_useicon           = "";
    l_devide            = "^4||^7";
    l_curdepth          = 0;
    l_befdepth          = 0;
    l_menulrpos         = 0;
    l_changemenustyle   = "changemenustyle";
    l_iprintlnmenu      = "iprintlnmenu";
    l_selecting         = "";
    l_txsize            = level.moddef.customtextlength;
    l_txsizelast        = l_txsize - 1;
    l_texttime          = 0.1;
    l_textsizeunselect  = 0.7;
    l_textsizeselect    = 1.0;
    l_white             = dividecolor( 255  , 255   , 255   );
    l_yellow            = dividecolor( 201  , 149   , 36    );
    l_trans             = "";


    // en: infinite loop only while mod menu is open
    // ja: モッドメニューが開かれている間だけ無限ループ
    while ( self.modsystem.menuactive )
    {
        // en: Gets the current mod menu's open level.
        // ja: 現在のモッドメニューの開いている階層の深さを取得
        l_curdepth = self.modsystem.menulayerdepth;
        l_befdepth = l_curdepth - 1;
        l_menulrpos = self.modsystem.menulrpos;

        // en: get project name
        // ja: プロジェクト名を取得
        l_projectname = getmttext( self.curlang , "projectname" );
        // en: get operating instructions
        // ja: 操作説明文を取得
        l_description = getmttext( self.curlang , "modmenucontroldescription" , self usinggamepad( ) );


        // en: get the maximum index of the currently open mod menu hierarchy
        // ja: 現在開いているモッドメニューの階層の最大インデックスを取得
        l_maxindex = getlayermaxindex( self.modsystem.menulayercurrent , self.verificationstatusindex );
        // en: get the currently selected index in character format
        // ja: 現在選択中のインデックスを文字形式で取得
        l_index = "^3 :[" + ( self.modsystem.menuoptioncurrent + 1 ) + "/" + ( l_maxindex + 1 ) + "]";// (" + l_menulrpos + "/" + self.modsystem.menuoptioncurrent + ")";
        //l_index = "^3 : [" + ( self.modsystem.menuoptioncurrent + 1 ) + "/" + ( l_maxindex + 1 ) + "](" + l_menulrpos + "/" + self.modsystem.menuoptioncurrent + ")";

        l_title = l_projectname + "^3 /";

        // en: if the current menu hierarchy is other than the root
        // ja: 現在のメニュー階層がルート以外の場合
         if ( ly_root < self.modsystem.menulayercurrent )
        {
            // en: if the current menu hierarchy is not the player menu, display “project name/current submenu name”
            // ja: 現在のメニュー階層がプレイヤーメニューではない場合、「プロジェクト名 / 現在のサブメニュー名」を表示する
            if ( self.modsystem.menulayercurrent != ly_playersmod )
                l_curlayerinfo = getmodmenutext( self.curlang , self.modsystem.menulayerprevious[l_befdepth] , self.modsystem.menuoptionprevious[l_befdepth] ) + l_index;
            // en: if the current menu hierarchy is the player menu, display "project name/[authority level] selected player name"
            // ja: 現在のメニュー階層がプレイヤーメニューの場合、「プロジェクト名 / [権限レベル] 選択中のプレイヤー名」を表示する
            else
                l_curlayerinfo = getmttext( self.curlang , getverifiedtext( level.players[self.modsystem.menuplayer].verificationstatusindex ) ) + level.players[self.modsystem.menuplayer].name + l_index;

            l_title += l_curlayerinfo;
        }
        else
        {
            l_curlayerinfo = l_index;
            l_title += l_index;
        }

        l_startindex    = ( isdefined( self.optstat[l_iprintlnmenu] ) ? 0           : ( ( l_menulrpos < l_maxtextsize ) ? 0            : l_menulrpos - l_maxtextsizelside ) );
        l_menulrpos     = ( isdefined( self.optstat[l_iprintlnmenu] ) ? l_menulrpos : ( ( l_menulrpos < l_maxtextsize ) ? l_menulrpos  : l_maxtextsizelside ) );

        // en: gets the text containing the update status of all displayed items
        // ja: 表示する全項目の更新状態を含むテキストを取得
        l_line = [];
        for ( i = 0; i < l_maxtextsize; i++ )
            l_line[i] = self.modsystem.menutext[i + l_startindex];
        
        
        // en: Add highlighting before or after the text of the currently selected item
        // ja: 現在選択中の項目のテキスト前後に、ハイライトなどを付随させる

        l_line[l_menulrpos] = " ^5>> " + l_line[l_menulrpos];
        

        // en: add a separator line after the text of all displayed items
        // ja: 表示する全項目のテキストの後ろに区切り線を付随させる
        for ( i = 0; i < l_maxtextsize; i++ )
            l_line[i] = ( ( l_line[i] == "" ) ? "" : ( l_line[i] + "" ) );

        
        l_selecting = "";

        // EN: Display notification messages (if any)
        // JA: 通知メッセージを表示（ある場合）
        for ( i = 0; i < l_maxtextsizelside; i++ )
        {
            self iprintln( l_line[( ( ( ( l_menulrpos < l_maxtextsizelside ) ? l_maxtextsizelside : l_maxtextsize ) - 1 ) - i )] );
        }
        // en: Show the text of the currently selected item
        // ja: 現在選択中の項目のテキストを表示する
        self iprintln( l_selecting );
        // EN: Display operating instructions
        // JA: 操作説明文を表示
        self iprintln( l_description );
        // en: display the text of the currently selected item (highlighted)
        // ja: 現在選択中の項目の文章を表示（ハイライト強調）
        self iprintln( l_title );

        // en: wait 4 seconds
        // ja: 4 秒待機する
        wait 2.65;
    }
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Mod Menu animation function
// ja : Mod Menu アニメーション処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : color animation of mod menu background color
// ja : モッドメニューの背景色のカラーアニメーション
//++++++++++++++++++++++++++++++
modmenubackgroundcoloranimation( )
{
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );
    // en : this function ends processing if "you die"
    // ja : この関数は「モッドメニューが閉じられた」場合に処理を終了する
    self endon( "closemodmenu" );
    // en : This function terminates processing if the "mod menu style has been changed."
    // ja : この関数は「モッドメニュースタイルが変更された」場合に処理を終了する
    self endon( "changedmenustyle" );
    
    l_blue1             = dividecolor( 37   , 72    , 106   );
    l_blue2             = dividecolor( 40   , 116   , 209   );
    l_crimson1          = dividecolor( 37   , 29    , 30    );
    l_crimson2          = dividecolor( 120  , 40    , 31    );
    l_yellow1           = dividecolor( 201  , 149   , 36    );
    l_yellow2           = dividecolor( 133  , 87    , 19    );
    l_animtime          = self.modsystem.menucoloranimtime;
    l_interval          = self.modsystem.menucoloraniminterval;
    l_leftoutline       = l_yellow2;
    l_leftinline        = l_blue2;

    // en: infinite loop only while mod menu is open
    // ja: モッドメニューが開かれている間だけ無限ループ
    while ( self.modsystem.menuactive )
    {
        // en: if mod menu background animation is enabled
        // ja: モッドメニューの背景アニメーションが有効の場合
        if ( isdefined( self.optstat["switchbackgroundanimation"] ) )
        {
            // en : changes the color of the specified hud (on-screen ui) for the specified number of seconds.
            // ja : 指定したhud（画面上のui）の色を、指定した秒数で変色させる

            l_leftoutline   = l_blue2;
            l_leftinline    = l_crimson2;
            self.modsystem.menuui["left_outline_1"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_outline_2"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_outline_3"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_outline_4"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_inline_1"]          elementcolorchange( l_animtime , l_leftinline );
            
            
            wait l_animtime;
            wait l_interval;
        
        
            l_leftoutline   = l_blue1;
            l_leftinline    = l_crimson1;
            self.modsystem.menuui["left_outline_1"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_outline_2"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_outline_3"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_outline_4"]         elementcolorchange( l_animtime , l_leftoutline );
            self.modsystem.menuui["left_inline_1"]          elementcolorchange( l_animtime , l_leftinline );
        
            wait l_animtime;
            wait l_interval;
        }
        wait 0.001;
    }
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Mods parameter handling
// ja : Mods パラメーター処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : display text and execute functions according to the on/off state of specified variables.
// ja : 指定の変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfselffunction( optname , optfunc , message , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6  , optarg7 , weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , dualmode , lvlcheck )
{
    // en : since the process of deleting the previously created case is in progress, the process is interrupted as it cannot be recreated.
    // ja : 前回作った筐体の削除処理が実行中の為、再作成できないとして処理を中断する
    if ( isdefined( self.optstat[optname + "deleting"] ) || ( isdefined( lvlcheck ) && isdefined( level.lvlstat[lvlcheck] ) ) )
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , "waitendfunction" , undefined , undefined , undefined );
        return;
    }
    // en: if the specified variable does not yet exist
    // ja: 指定の変数がまだ存在しない場合
    if ( !isdefined( self.optstat[optname] ) )
        // en : execute the process when the specified parameter is enabled
        // ja : 指定のパラメーターを有効にした時の処理を実行する
        self enabledselfparameter( self.curlang , optname , undefined , message , true , optfunc , true , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 , weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , dualmode );
    // en: if the specified variable has already been created
    // ja: 指定の変数が既に作られている場合
    else
        // en : execute the process when the specified parameter is disabled
        // ja : 指定のパラメーターを無効にした時の処理を実行する
        self disabledselfparameter( self.curlang , optname , undefined , true , weaponid );
}



//++++++++++++++++++++++++++++++
// en : displays text and executes sub-functions associated with the main function according to the on/off state of specified variables.
// ja : 指定の変数のオンオフ状態に合わせて、文章の表示を行い、メイン機能に付随するサブ機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfselfsubfunction( optname1 , optname2 , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 )
{
    // en: if the specified main function variable does not yet exist
    // ja: 指定のメイン機能の変数がまだ存在しない場合
    if ( !isdefined( self.optstat[optname1] ) )
    {
        // en: the text "[notification] function not executed: function name" is displayed in the center of the screen.
        // ja: 画面中央に "[通知] 機能が未実行 : 機能名称" という文章を表示する
        self showcentermessage( self.curlang , "notice" , "notfuncexec" , optname1 , undefined , undefined );
        return;
    }

    // en: if the variable for the specified subfunction does not yet exist
    // ja: 指定のサブ機能の変数がまだ存在しない場合
    if ( !isdefined( self.optstat[optname1].moddata[optname2] ) )
    {
        // en : execute the process when the specified parameter is enabled
        // ja : 指定のパラメーターを有効にした時の処理を実行する
        self enabledselfparameter( self.curlang , optname1 , optname2 , undefined , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 );
    }
    // en: if the specified subfunction variable has already been created
    // ja: 指定のサブ機能の変数が既に作られている場合
    else
    {
        // en : execute the process when the specified parameter is disabled
        // ja : 指定のパラメーターを無効にした時の処理を実行する
        self disabledselfparameter( self.curlang , optname1 , optname2 , notice , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : display text and execute functions for the specified player according to the on/off state of the specified variable.
// ja : 指定したプレイヤーに対して、指定の変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfplayerfunction( optname , optfunc )
{
    // en: if the player to be operated is the host, issue a warning that the operation cannot be performed and end the process.
    // ja: 操作する対象のプレイヤーがホストの場合は、操作できない警告をして処理を終了する
    if ( level.players[self.modsystem.menuplayer] ishost( ) )
    {
        self showcentermessage( self.curlang , "notice" , "cannothost" , undefined , undefined , undefined );
        return;
    }

    // en: if the specified variable does not yet exist
    // ja: 指定の変数がまだ存在しない場合
    if ( !isdefined( level.players[self.modsystem.menuplayer].optstat[optname] ) )
    {
        // en: display the text "[enabled] function name: player name" in the center of the screen for yourself.
        // ja: 自分に対して "[有効化] 機能名称 : プレイヤー名" という文章を、画面中央に表示する
        self showcentermessage( self.curlang , "enabled" , optname , undefined , level.players[self.modsystem.menuplayer].name , undefined );
    }
    else
    {
        // en: display the text "[disable] function name: player name" in the center of the screen for yourself.
        // ja: 自分に対して "[無効化] 機能名称 : プレイヤー名" という文章を、画面中央に表示する
        self showcentermessage( self.curlang , "disabled" , optname , undefined , level.players[self.modsystem.menuplayer].name , undefined );
    }
    
    // en: execute the specified function in a subthread
    // ja: 指定した関数をサブスレッドで実行する
    level.players[self.modsystem.menuplayer] thread [[ optfunc ]]( );
}



//++++++++++++++++++++++++++++++
// en : display text and execute functions for all players according to the on/off state of the specified variable.
// ja : 全プレイヤーに対して、指定の変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfallplayersfunction( optname , optfunc , oneway , withhost )
{
    // en: get information on all participating players
    // ja: 参加中の全プレイヤー情報を取得
    for ( targetuser = 0; targetuser < level.players.size; targetuser++ )
    {
        // en: if the target player is the host, proceed to the next player without processing.
        // ja: 操作する対象のプレイヤーがホストの場合は、処理せずに次のプレイヤーに進む
        if ( !isdefined( withhost ) && ( level.players[targetuser] ishost( ) ) )
        {
            level.players[targetuser] showcentermessage( self.curlang , "notice" , "cannothost" , undefined , undefined , undefined );
            continue;
        }

        // en: if the specified variable does not yet exist
        // ja: 指定の変数がまだ存在しない場合
        if ( ( !isdefined( level.lvlstat[optname] ) && !isdefined( level.players[targetuser].optstat[optname] ) ) ||
        // en: if the specified variable still exists
        // ja: 指定の変数がまだ存在している場合
            ( isdefined( level.lvlstat[optname] ) && isdefined( level.players[targetuser].optstat[optname] ) ) )
            // en: execute the specified function in a subthread
            // ja: 指定した関数をサブスレッドで実行する
            level.players[targetuser] thread [[ optfunc ]]( );
    }

    if ( !isdefined( oneway ) )
    {
        // en: applies to the entire room, if the specified variable does not already exist
        // ja: 部屋全体に適用される、指定の変数がまだ存在しない場合
        if ( !isdefined( level.lvlstat[optname] ) )
            // en: enables the specified variable that applies to the entire room
            // ja: 部屋全体に適用される、指定の変数を有効にする
            level.lvlstat[optname] = true;
        // en: if the specified variable has already been created, which applies to the entire room
        // ja: 部屋全体に適用される、指定の変数が既に作られている場合
        else
            // en: discard the specified variable that applies to the entire room
            // ja: 部屋全体に適用される、指定の変数を破棄する
            level.lvlstat[optname] = undefined;
    }
}



//++++++++++++++++++++++++++++++
// en : display text and execute functions according to the on/off state of specified level variables.
// ja : 指定の level 変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonflevelfunction( optname , optfunc , message , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6  , optarg7 )
{
    // en : since the process of deleting the previously created case is in progress, the process is interrupted as it cannot be recreated.
    // ja : 前回作った筐体の削除処理が実行中の為、再作成できないとして処理を中断する
    if ( isdefined( level.lvlstat[optname + "deleting"] ) )
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , "waitendfunction" , undefined , undefined , undefined );
        return;
    }

    // en: if the specified level variable does not already exist
    // ja: 指定の level 変数がまだ存在しない場合
    if ( !isdefined( level.lvlstat[optname] ) )
    {
        // en : execute the process when the specified parameter is enabled
        // ja : 指定のパラメーターを有効にした時の処理を実行する
        self enabledlevelparameter( self.curlang , optname , undefined , message , true , optfunc , true , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 );
    }
    // en: if the specified level variable has already been created
    // ja: 指定の level 変数が既に作られている場合
    else
    {
        // en : execute the process when the specified parameter is disabled
        // ja : 指定のパラメーターを無効にした時の処理を実行する
        self disabledlevelparameter( self.curlang , optname , undefined , true );
    }
}



//++++++++++++++++++++++++++++++
// en : displays text and executes sub-functions associated with the main function according to the on/off state of specified level variables.
// ja : 指定の level 変数のオンオフ状態に合わせて、文章の表示を行い、メイン機能に付随するサブ機能の実行を行う
//++++++++++++++++++++++++++++++
switchonflevelsubfunction( optname1 , optname2 , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 )
{
    // en: if the specified main function variable does not yet exist
    // ja: 指定のメイン機能の変数がまだ存在しない場合
    if ( !isdefined( level.lvlstat[optname1] ) )
    {
        // en: the text "[notification] function not executed: function name" is displayed in the center of the screen.
        // ja: 画面中央に "[通知] 機能が未実行 : 機能名称" という文章を表示する
        self showcentermessage( self.curlang , "notice" , "notfuncexec" , optname1 , undefined , undefined );
        return;
    }

    // en: if the variable for the specified subfunction does not yet exist
    // ja: 指定のサブ機能の変数がまだ存在しない場合
    if ( !isdefined( level.lvlstat[optname1].moddata[optname2] ) )
    {
        // en : execute the process when the specified parameter is enabled
        // ja : 指定のパラメーターを有効にした時の処理を実行する
        self enabledlevelparameter( self.curlang , optname1 , optname2 , undefined , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 );
    }
    // en: if the specified subfunction variable has already been created
    // ja: 指定のサブ機能の変数が既に作られている場合
    else
    {
        // en : execute the process when the specified parameter is disabled
        // ja : 指定のパラメーターを無効にした時の処理を実行する
        self disabledlevelparameter( self.curlang , optname1 , optname2 , notice );
    }
}




//++++++++++++++++++++++++++++++
// en : processing when the specified self parameter is enabled
// ja : 指定の self パラメーターを有効にした時の処理
//++++++++++++++++++++++++++++++
enabledselfparameter( selflang , optname1 , optname2 , message , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 , weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , dualmode )
{
    l_optname = "";

    // en: if suboptions are specified
    // ja: サブオプションが指定されている場合は
    if ( isdefined( optname2 ) )
    {
        l_optname = optname2;
        
        // en: set the specified data in the variable of the specified subfunction
        // ja: 指定のサブ機能の変数に、指定のデータを設定する
        self.optstat[optname1].moddata[optname2] = optdata;
    }
    // en: if no suboptions are specified
    // ja: サブオプションが指定されていない場合は
    else if ( isdefined( optname1 ) )
    {
        l_optname = optname1;

        // en: enable specified variable
        // ja: 指定の変数を有効にする
        self.optstat[optname1] = true;
        
        // en: add structure to "optstat" variable
        // ja: 「optstat」変数に構造体を追加する
        self.optstat[optname1] = spawnstruct( );
        
        // en: create an array to set parameters dedicated to each function
        // ja: 各機能専用のパラメーターを設定するための配列を作成
        self.optstat[optname1].moddata = [];
        
        // en: if weapon id is specified
        // ja: 武器idが指定されている場合
        if ( isdefined( weaponid ) )
        {
            //// en: get weapon data into specified variable
            //// ja: 指定の変数に武器データを取得する
            self.optstat[optname1].weapondata = self provideweapon(
                /* weaponid */      weaponid ,
                /* inprojectile */  inprojectile ,
                /* onlygroup */     onlygroup ,
                /* attachmentid */  attachmentid ,
                /* camoid */        camoid ,
                /* camogroup */     camogroup ,
                /* akimbo */        dualmode ,
                /* changehand */    true ,
                /* notice */        undefined ,
                /* onlygetid */     undefined
                );
        }
    }

    // en: if you need to display a message
    // ja: メッセージを表示する必要がある場合
    if ( isdefined( notice ) )
    {
        // en: display the text "[enabled] function name" in the center of the screen
        // ja: 画面中央に「[有効化] 機能名称」という文章を表示する
        self showcentermessage( selflang , "enabled" , l_optname , message , undefined , undefined );
    }

    // en: if a function to execute is specified
    // ja: 実行する関数が指定されている場合
    if ( isdefined( optfunc ) )
    {
        // en: execute the specified function in a subthread
        // ja: 指定した関数をサブスレッドで実行する
        if      ( isdefined( optarg7 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 ); }
        else if ( isdefined( optarg6 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 ); }
        else if ( isdefined( optarg5 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 , optarg5 ); }
        else if ( isdefined( optarg4 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 ); }
        else if ( isdefined( optarg3 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 ); }
        else if ( isdefined( optarg2 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 ); }
        else if ( isdefined( optarg1 ) )    { self thread [[ optfunc ]]( optarg1 ); }
        else                                { self thread [[ optfunc ]]( ); }
    }
}



//++++++++++++++++++++++++++++++
// en : processing when the specified self parameter is disabled
// ja : 指定の self パラメーターを無効にした時の処理
//++++++++++++++++++++++++++++++
disabledselfparameter( selflang , optname1 , optname2 , notice , weaponid )
{
    l_optname = "";

    // en: if suboptions are specified
    // ja: サブオプションが指定されている場合は
    if ( isdefined( optname2 ) )
    {
        l_optname = optname2;

        // en: disable (discard) the specified subfunction variable
        // ja: 指定のサブ機能の変数を無効（破棄）する
        self.optstat[optname1].moddata[optname2] = undefined;
    }
    // en: if no suboptions are specified
    // ja: サブオプションが指定されていない場合は
    else
    {
        l_optname = optname1;

        // en: if weapon id is specified
        // ja: 武器idが指定されている場合
        if ( isdefined( weaponid ) )
        {
            // en: pick up the target's weapon
            // ja: 持っている対象の武器を取り上げる
            self configureweapon( self.optstat[optname1].weapondata , true , true , undefined , undefined , undefined );
            wait 0.01;
        }

        // en: disable (discard) the specified variable
        // ja: 指定の変数を無効（破棄）する
        self.optstat[optname1] = undefined;
    }

    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );

    // en: if you need to display a message
    // ja: メッセージを表示する必要がある場合
    if ( isdefined( notice ) )
    {
        // en: display the text "[disabled] function name" in the center of the screen
        // ja: 画面中央に「[無効化] 機能名称」という文章を表示する
        self showcentermessage( selflang , "disabled" , l_optname , undefined , undefined , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : processing when the specified level parameter is enabled
// ja : 指定の level パラメーターを有効にした時の処理
//++++++++++++++++++++++++++++++
enabledlevelparameter( selflang , optname1 , optname2 , message , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 )
{
    l_optname = "";

    // en: if suboptions are specified
    // ja: サブオプションが指定されている場合は
    if ( isdefined( optname2 ) )
    {
        l_optname = optname2;
        
        // en: set the specified data in the variable of the specified subfunction
        // ja: 指定のサブ機能の変数に、指定のデータを設定する
        level.lvlstat[optname1].moddata[optname2] = optdata;
        self.optstat[optname1].moddata[optname2] = optdata;
    }
    // en: if no suboptions are specified
    // ja: サブオプションが指定されていない場合は
    else if ( isdefined( optname1 ) )
    {
        l_optname = optname1;

        // en: enable specified variable
        // ja: 指定の変数を有効にする
        level.lvlstat[optname1] = true;
        self.optstat[optname1] = true;
        
        // en: add structure to "lvlstat" variable
        // ja: "lvlstat" 変数に構造体を追加する
        level.lvlstat[optname1] = spawnstruct( );
        self.optstat[optname1] = spawnstruct( );
        
        // en: create an array to set parameters dedicated to each function
        // ja: 各機能専用のパラメーターを設定するための配列を作成
        level.lvlstat[optname1].moddata = [];
        self.optstat[optname1].moddata = [];
    }

    // en: if you need to display a message
    // ja: メッセージを表示する必要がある場合
    if ( isdefined( notice ) )
    {
        // en: if you want to display a specific message
        // ja: 特定のメッセージを表示する場合
        if ( isdefined( message ) )
        {
            // en: display the text "[notice] message" in the center of the screen
            // ja: 画面中央に "[通知] メッセージ" という文章を表示する
            self showcentermessage( selflang , "notice" , message , undefined , undefined , undefined );
        }
        // en: if no message is specified
        // ja: メッセージの指定がない場合
        else
        {
            // en: display the text "[enabled] function name" in the center of the screen
            // ja: 画面中央に「[有効化] 機能名称」という文章を表示する
            self showcentermessage( selflang , "enabled" , l_optname , undefined , undefined , undefined );
        }
    }

    // en: if a function to execute is specified
    // ja: 実行する関数が指定されている場合
    if ( isdefined( optfunc ) )
    {
        // en: execute the specified function in a subthread
        // ja: 指定した関数をサブスレッドで実行する
        if      ( isdefined( optarg7 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 ); }
        else if ( isdefined( optarg6 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 ); }
        else if ( isdefined( optarg5 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 , optarg5 ); }
        else if ( isdefined( optarg4 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 , optarg4 ); }
        else if ( isdefined( optarg3 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 , optarg3 ); }
        else if ( isdefined( optarg2 ) )    { self thread [[ optfunc ]]( optarg1 , optarg2 ); }
        else if ( isdefined( optarg1 ) )    { self thread [[ optfunc ]]( optarg1 ); }
        else                                { self thread [[ optfunc ]]( ); }
    }
}



//++++++++++++++++++++++++++++++
// en : processing when the specified level parameter is disabled
// ja : 指定の level パラメーターを無効にした時の処理
//++++++++++++++++++++++++++++++
disabledlevelparameter( selflang , optname1 , optname2 , notice )
{
    l_optname = "";

    // en: if suboptions are specified
    // ja: サブオプションが指定されている場合は
    if ( isdefined( optname2 ) )
    {
        l_optname = optname2;

        // en: disable (discard) the specified subfunction variable
        // ja: 指定のサブ機能の変数を無効（破棄）する
        level.lvlstat[optname1].moddata[optname2] = undefined;
        self.optstat[optname1].moddata[optname2] = undefined;
    }
    // en: if no suboptions are specified
    // ja: サブオプションが指定されていない場合は
    else
    {
        l_optname = optname1;

        // en: disable (discard) the specified variable
        // ja: 指定の変数を無効（破棄）する
        level.lvlstat[optname1] = undefined;
        self.optstat[optname1] = undefined;
    }

    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    level notify( "end_lobby_" + l_optname );

    // en: if you need to display a message
    // ja: メッセージを表示する必要がある場合
    if ( isdefined( notice ) )
    {
        // en: display the text "[disabled] function name" in the center of the screen
        // ja: 画面中央に「[無効化] 機能名称」という文章を表示する
        self showcentermessage( selflang , "disabled" , l_optname , undefined , undefined , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : select self variables related to the specified function in order from the specified array
// ja : 指定の機能に関する self 変数を、指定の配列内から順に選択する
//++++++++++++++++++++++++++++++
changeselfparameter( optname1 , optname2 , prefix , optfunc , arraydata , notice , lastend , random )
{
    // en: run the specified function if it has not already been run
    // ja: 指定された機能がまだ実行されていない場合
    if ( !isdefined( self.optstat[optname1] ) )
    {
        // en: if option name 2 is specified
        // ja: オプション名2が指定されている場合
        if ( isdefined( optname2 ) )
        {
            // en: run once and create variables for specified functions
            // ja: 一度実行して、指定機能に関する変数を作成する
            self thread [[ optfunc ]]( );
        }
        // en: if option name 2 is not specified
        // ja: オプション名2が指定されていない場合
        else
        {
            // en: set the first item.
            // ja: 最初の項目を設定する
            self.optstat[optname1] = arraydata[0];
            // en: display the text "[notification] function name: element name" in the center of the screen.
            // ja: 画面中央に "[通知] 機能名 : 要素名" という文章を表示する
            self showcentermessage( self.curlang , "notice" , optname1 , undefined , self.optstat[optname1] , prefix );
            
        }
    }
    // en: if the specified function has already been executed
    // ja: 指定された機能が実行済みの場合
    else
    {
        // en: when not randomly selected
        // ja: ランダム選定しない場合
        if ( !isdefined( random ) )
        {
            // en: if option name 2 is specified
            // ja: オプション名2が指定されている場合
            if ( isdefined( optname2 ) )
            {
                // en: if there are no subparameters yet
                // ja: まだサブパラメーターが存在しない場合
                if ( !isdefined( self.optstat[optname1].moddata[optname2] ) )
                {
                    // en: set the first item.
                    // ja: 最初の項目を設定する
                    self.optstat[optname1].moddata[optname2] = arraydata[0];
                }
                // en: if there are subparameters yet
                // ja: サブパラメーターが存在する場合
                else
                {
                    // en: array length loop
                    // ja: 配列長分ループ
                    for ( index = 0; index < arraydata.size; index++ )
                    {
                        // en: skip until it matches the item currently being set
                        // ja: 現在設定中の項目と一致するまではスキップ
                        if ( !isdefined( arraydata[index].assetname ) ) { if ( self.optstat[optname1].moddata[optname2] != arraydata[index] )                       { continue; } }
                        else                                            { if ( self.optstat[optname1].moddata[optname2].assetname != arraydata[index].assetname )   { continue; } }

                        // en: if the next item that is currently being set does not exceed the length of the array, set the next item.
                        // ja: 現在設定中の項目の一個次が、配列の長さを超えていない場合は、一個次の項目を設定する
                        if ( (index + 1) < arraydata.size ) { self.optstat[optname1].moddata[optname2] = arraydata[index + 1]; }
                        
                        // en: if the next item that is currently being set exceeds the length of the array
                        // ja: 現在設定中の項目の一個次が、配列の長さを超えてしまう場合は
                        else
                        {
                            // en: if the function does not end at the last item,
                            // ja: 最後の項目で機能を終了しない場合は
                            if ( !isdefined( lastend ) )
                            {
                                // en: set the first item.
                                // ja: 最初の項目を設定する
                                self.optstat[optname1].moddata[optname2] = arraydata[0];
                            }
                            // en: to end the function at the last item
                            // ja: 最後の項目で機能を終了する場合は
                            else
                            {
                                // en: disable specified features
                                // ja: 指定の機能を無効にする
                                self thread [[ optfunc ]]( );
                                wait 0.01;
                            }
                        }
                        
                        // en: end loop
                        // ja: ループ終了
                        break;
                    }
                }
            }
            // en: if option name 2 is not specified
            // ja: オプション名2が指定されていない場合
            else
            {
                // en: array length loop
                // ja: 配列長分ループ
                for ( index = 0; index < arraydata.size; index++ )
                {
                    // en: skip until it matches the item currently being set
                    // ja: 現在設定中の項目と一致するまではスキップ
                    if ( self.optstat[optname1] != arraydata[index] ) { continue; }
                    

                    // en: if the next item that is currently being set does not exceed the length of the array, set the next item.
                    // ja: 現在設定中の項目の一個次が、配列の長さを超えていない場合は、一個次の項目を設定する
                    if ( (index + 1) < arraydata.size ) { self.optstat[optname1] = arraydata[index + 1]; }
                    
                    // en: if the next item that is currently being set exceeds the length of the array
                    // ja: 現在設定中の項目の一個次が、配列の長さを超えてしまう場合は
                    else
                    {
                        // en: if the function does not end at the last item,
                        // ja: 最後の項目で機能を終了しない場合は
                        if ( !isdefined( lastend ) )
                        {
                            // en: set the first item.
                            // ja: 最初の項目を設定する
                            self.optstat[optname1] = arraydata[0];
                        }
                        // en: to end the function at the last item
                        // ja: 最後の項目で機能を終了する場合は
                        else
                        {
                            // en: disable specified features
                            // ja: 指定の機能を無効にする
                            self.optstat[optname1] = undefined;
                        }
                    }
                    
                    // en: end loop
                    // ja: ループ終了
                    break;
                }
            }
        }
        // en: when selecting randomly, extract randomly from the array.
        // ja: ランダム選定する場合、配列内からランダムに取り出す
        else
        {
            // en: if option name 2 is specified
            // ja: オプション名2が指定されている場合
            if ( isdefined( optname2 ) )
            {
                self.optstat[optname1].moddata[optname2] = arraydata[randomintrange( 0 , arraydata.size )];
            }
            // en: if option name 2 is not specified
            // ja: オプション名2が指定されていない場合
            else
            {
                self.optstat[optname1] = arraydata[randomintrange( 0 , arraydata.size )];
            }
        }

        // en: if you need to display a message
        // ja: メッセージを表示する必要がある場合
        if ( isdefined( notice ) )
        {
            // en: if option name 2 is specified
            // ja: オプション名2が指定されている場合
            if ( isdefined( optname2 ) )
            {
                // en: if the function does not end at the last item,
                // ja: 最後の項目で機能を終了しない場合は
                if ( !isdefined( lastend ) )
                {
                    // en: display the text "[notification] function name: element name" in the center of the screen.
                    // ja: 画面中央に「[通知] 機能名 : 要素名」という文章を表示する
                    if ( !isdefined( self.optstat[optname1].moddata[optname2].assetname ) ) { self showcentermessage( self.curlang , "notice" , optname2 , undefined , self.optstat[optname1].moddata[optname2] , prefix ); }
                    else                                                                    { self showcentermessage( self.curlang , "notice" , optname2 , undefined , self.optstat[optname1].moddata[optname2].assetname , prefix ); }
                    
                }
                // en: to end the function at the last item
                // ja: 最後の項目で機能を終了する場合は
                else
                {
                    // en: if the parent variable of the specified function exists
                    // ja: 指定の機能の親変数が存在する場合
                    if ( isdefined( self.optstat[optname1] ) )
                    {
                        // en: display the text "[notification] function name: element name" in the center of the screen.
                        // ja: 画面中央に "[通知] 機能名 : 要素名" という文章を表示する
                        if ( !isdefined( self.optstat[optname1].moddata[optname2].assetname ) ) { self showcentermessage( self.curlang , "notice" , optname1 , undefined , self.optstat[optname1].moddata[optname2] , prefix ); }
                        else                                                                    { self showcentermessage( self.curlang , "notice" , optname1 , undefined , self.optstat[optname1].moddata[optname2].assetname , prefix ); }
                    }
                }
            }
            // en: if option name 2 is not specified
            // ja: オプション名2が指定されていない場合
            else
            {
                // en: display the text "[notification] function name: element name" in the center of the screen.
                // ja: 画面中央に "[通知] 機能名 : 要素名" という文章を表示する
                self showcentermessage( self.curlang , "notice" , optname1 , undefined , self.optstat[optname1] , prefix );
            }
        }
    }
}



//++++++++++++++++++++++++++++++
// en : select level variables related to the specified function in order from the specified array
// ja : 指定の機能に関する level 変数を、指定の配列内から順に選択する
//++++++++++++++++++++++++++++++
changelevelparameter( optname1 , optname2 , prefix , optfunc , arraydata , notice , lastend )
{
    // en: run the specified function if it has not already been run
    // ja: 指定された機能がまだ実行されていない場合
    if ( !isdefined( level.lvlstat[optname1] ) )
    {
        // en: run once and create variables for specified functions
        // ja: 一度実行して、指定機能に関する変数を作成する
        self thread [[ optfunc ]]( );
    }
    // en: if the specified function has already been executed
    // ja: 指定された機能が実行済みの場合
    else
    {
        // en: array length loop
        // ja: 配列長分ループ
        for ( index = 0; index < arraydata.size; index++ )
        {
            // en: skip until it matches the item currently being set
            // ja: 現在設定中の項目と一致するまではスキップ
            if ( level.lvlstat[optname1].moddata[optname2] != arraydata[index] ) { continue; }

            // en: if the next item that is currently being set does not exceed the length of the array, set the next item.
            // ja: 現在設定中の項目の一個次が、配列の長さを超えていない場合は、一個次の項目を設定する
            if ( (index + 1) < arraydata.size ) { level.lvlstat[optname1].moddata[optname2] = arraydata[index + 1]; }
            
            // en: if the next item that is currently being set exceeds the length of the array
            // ja: 現在設定中の項目の一個次が、配列の長さを超えてしまう場合は
            else
            {
                // en: if the function does not end at the last item,
                // ja: 最後の項目で機能を終了しない場合は
                if ( !isdefined( lastend ) )
                {
                    // en: set the first item.
                    // ja: 最初の項目を設定する
                    level.lvlstat[optname1].moddata[optname2] = arraydata[0];
                }
                // en: to end the function at the last item
                // ja: 最後の項目で機能を終了する場合は
                else
                {
                    // en: disable specified features
                    // ja: 指定の機能を無効にする
                    self thread [[ optfunc ]]( );
                    wait 0.01;
                }
            }
            
            // en: end loop
            // ja: ループ終了
            break;
        }

        // en: if you need to display a message
        // ja: メッセージを表示する必要がある場合
        if ( isdefined( notice ) )
        {
            // en: if the function does not end at the last item,
            // ja: 最後の項目で機能を終了しない場合は
            if ( !isdefined( lastend ) )
            {
                // en: display the text "[notification] function name: element name" in the center of the screen.
                // ja: 画面中央に「[通知] 機能名 : 要素名」という文章を表示する
                self showcentermessage( self.curlang , "notice" , optname2 , undefined , level.lvlstat[optname1].moddata[optname2] , prefix );
            }
            // en: to end the function at the last item
            // ja: 最後の項目で機能を終了する場合は
            else
            {
                // en: if the parent variable of the specified function exists
                // ja: 指定の機能の親変数が存在する場合
                if ( isdefined( level.lvlstat[optname1] ) )
                {
                    // en: display the text "[notification] function name: element name" in the center of the screen.
                    // ja: 画面中央に "[通知] 機能名 : 要素名" という文章を表示する
                    self showcentermessage( self.curlang , "notice" , optname1 , undefined , level.lvlstat[optname1].moddata[optname2] , prefix );
                }
            }
        }
    }
}



//++++++++++++++++++++++++++++++
// en : select variables related to the specified function in order from the specified array
// ja : 指定の機能に関する変数を、指定の配列内から順に選択する
//++++++++++++++++++++++++++++++
changedvarparameter( optname , prefix , arraydata , dvarname )
{
    l_result = 0;

    // en: array length loop
    // ja: 配列長分ループ
    for ( index = 0; index < arraydata.size; index++ )
    {
        // en: skip until it matches the item currently being set
        // ja: 現在設定中の項目と一致するまではスキップ
        if ( getdvarint( dvarname ) != arraydata[index] ) { continue; }

        // en: if the next item that is currently being set does not exceed the length of the array, set the next item.
        // ja: 現在設定中の項目の一個次が、配列の長さを超えていない場合は、一個次の項目を設定する
        if ( (index + 1) < arraydata.size )
        {
            setdvar( dvarname , arraydata[index + 1] );
            l_result = index + 1;
        }
        
        // en: if the next item that is currently being set exceeds the length of the array, set the first item.
        // ja: 現在設定中の項目の一個次が、配列の長さを超えてしまう場合は、最初の項目を設定する
        else
        {
            setdvar( dvarname , arraydata[0] );
        }

        // en: end loop
        // ja: ループ終了
        break;
    }

    // en: display the text "[notification] function name: element name" in the center of the screen.
    // ja: 画面中央に "[通知] 機能名 : 要素名" という文章を表示する
    self showcentermessage( self.curlang , "notice" , optname , undefined , arraydata[l_result] , prefix );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Subthread generic processing
// ja : サブスレッド汎用処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : general-purpose functions for performing functions that perform loop processing
// ja : ループ処理を行う機能を実行するための汎用関数
//++++++++++++++++++++++++++++++
execloopfunction( optname , optfunc , looptime )
{
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );
    // en: set the specified effect name as the function termination trigger
    // ja: 指定の機能名を関数の終了トリガーとする
    self endon( "finalize_" + optname );


    // en: use the specified function name as the function termination trigger
    // ja: 指定の機能の初期化処理を行う
    self [[ optfunc ]]( optname , 0 );


    // en: loop until specified variable no longer exists
    // ja: 指定の変数が存在しなくなるまでループ
    while ( isdefined( self.optstat[optname] ) )
    {
        // en: performs in-loop processing of specified function
        // ja: 指定の機能のループ中処理を行う
        self [[ optfunc ]]( optname , 1 );

        // en: wait for the specified time
        // ja: 指定時間分待機する
        wait looptime;
    }
    
    // en: perform termination processing for the specified function
    // ja: 指定の機能の終了処理を行う
    self [[ optfunc ]]( optname , 2 );
}



//++++++++++++++++++++++++++++++
// en : generic function to disable duplicate functions if they are activated
// ja : 重複している機能が起動している場合、無効化させるための汎用関数
//++++++++++++++++++++++++++++++
checkduplicatefunction( name , func )
{
    // en: if the specified function is already enabled, disable it due to processing conflict.
    // ja: 指定の機能が既に有効の場合は、処理が競合するため無効にする
    if ( isdefined( self.optstat[name] ) )
    {
        // en: discard function execution flag
        // ja: 機能実行フラグを破棄
        self.optstat[name] = undefined;
        // en: stop the running loop process and call the termination process
        // ja: 実行中のループ処理を停止し、終了処理を呼ぶ
        self notify( "finalize_" + name );
        wait 0.01;
        self [[ func ]]( name , 2 );
    }
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Player permission system
// ja : プレイヤー権限システム
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : revoke mod menu privileges (set unverified)
// ja : モッドメニューの権限を剥奪する（未承認に設定）
//++++++++++++++++++++++++++++++
removeauthunverified( )
{
    self thread changeauth( self.modsystem.menuplayer , 0 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions to "verified"
// ja : モッドメニューの権限を「承認者」に設定する
//++++++++++++++++++++++++++++++
giveauthverified( )
{
    self thread changeauth( self.modsystem.menuplayer , 1 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions to "vip"
// ja : モッドメニューの権限を "要人" に設定する
//++++++++++++++++++++++++++++++
giveauthvip( )
{
    self thread changeauth( self.modsystem.menuplayer , 2 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions to "admin"
// ja : モッドメニューの権限を「管理者」に設定する
//++++++++++++++++++++++++++++++
giveauthadmin( )
{
    self thread changeauth( self.modsystem.menuplayer , 3 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions to "co-host"
// ja : モッドメニューの権限を「副ホスト」に設定する
//++++++++++++++++++++++++++++++
giveauthcohost( )
{
    self thread changeauth( self.modsystem.menuplayer , 4 );
}



//++++++++++++++++++++++++++++++
// en : changes the mod menu permissions of the specified player to the specified permissions.
// ja : 指定したプレイヤーのモッドメニューの権限を、指定した権限に変更する
//++++++++++++++++++++++++++++++
changeauth( targetuser , authlevel )
{
    // en: if the player to be operated is the host, issue a warning that the operation cannot be performed and end the process.
    // ja: 操作する対象のプレイヤーがホストの場合は、操作できない警告をして処理を終了する
    if ( level.players[targetuser] ishost( ) )
    {
        self showcentermessage( self.curlang , "notice" , "cannothost" , undefined , undefined , undefined );
        return;
    }

    // en: get translations of assigned permissions
    // ja: 割り当てられた権限の翻訳を取得する
    l_textlevel = getmttext( self.curlang , getverifiedtext( authlevel ) );
    
    // en: display the text "set [notification] permission: [permission name] player name" for yourself in the center of the screen.
    // ja: 自分に対して "[通知] 権限を設定 : [権限名]プレイヤー名" という文章を、画面中央に表示する
    self showcentermessage( self.curlang , "notice" , "setmenustatus" , undefined , l_textlevel + level.players[targetuser].name , undefined );

    // en: assign specified permissions to the selected player
    // ja: 選択中のプレイヤーに対して、指定した権限を割り当てる
    level.players[targetuser] thread setauth( authlevel );
}



//++++++++++++++++++++++++++++++
// en : assign specified permissions
// ja : 指定した権限を割り当てる
//++++++++++++++++++++++++++++++
setauth( verificationlevel )
{
    lv_unverified = 0;
    value_root = 0;

    // en: if the newly specified permissions are lower than the currently set permissions
    // ja: 新しく指定された権限が、今設定されている権限よりも低い場合
    if ( verificationlevel < self.verificationstatusindex )
    {
        // en: commit suicide
        // ja: 自分を自殺させる
        self suicide( );

        // en: wait 0.31 seconds for mod menu to close
        // ja: モッドメニューが閉じられるまで 0.31秒間 待機する
        wait 0.31;
    }
    
    // en: change to specified permissions
    // ja: 指定された権限に変更する
    self.verificationstatusindex = verificationlevel;
    
    // en: if the specified authority is "unverified" or higher
    // ja: 指定された権限が「未承認」以上の場合
    if ( lv_unverified < verificationlevel )
    {
        // en: if the mod menu is currently open
        // ja: 今現在モッドメニューを開いている場合
        if ( self.modsystem.menuactive )
        {
            // en: close mod menu
            // ja: モッドメニューを閉じる
            self modmenuclose( 0.2 );

            // en: issue a "removeauth" event to yourself (this will end the looping function)
            // ja: 自分に対して「removeauth」イベントを発行する（これでループ処理している関数が終了する）
            self notify( "removeauth" );

            // en: waits for only 1 frame as it waits for the update process to finish.
            // ja: 更新処理の終了待ちの為 1フレーム のみ待機する
            wait 0.001;

            // en: initialize the selection, hierarchy, and depth of the mod menu
            // ja: モッドメニューの選択箇所、階層、深度を初期化する
            self.modsystem.menulayercurrent     = value_root;
            self.modsystem.menuoptioncurrent    = value_root;
            self.modsystem.menulayerdepth       = value_root;

        }
        
        // en : display a "welcome" message
        // ja : 「ようこそ」メッセージを表示する
        self showwelocomemessage( );
            
        // en: start button monitoring process
        // ja: ボタンモニタリング処理を開始する
        self thread onbuttonmonitoring( );
    }
    // en: if the specified authority is "unverified"
    // ja: 指定された権限が「未承認」の場合
    else
    {
        // en : destroy variables that only you use while processing a mod
        // ja : 自分のみがmodの処理中に使う変数を破棄する
        self finalizeselfdata( );
    }
}



//++++++++++++++++++++++++++++++
// en : assign specified permissions to all players
// ja : 指定した権限を全プレイヤーに割り当てる
//++++++++++++++++++++++++++++++
changeauthallplayers( authlevel )
{
    // en: get information on all participating players
    // ja: 参加中の全プレイヤー情報を取得
    for ( targetuser = 0; targetuser < level.players.size; targetuser++ )
    {
        // en : assign specified permissions to all players
        // ja : 指定した権限を全プレイヤーに割り当てる
        self thread changeauth( targetuser , authlevel );
    }
}



//++++++++++++++++++++++++++++++
// en : remove mod menu privileges from all players (set to unauthorized)
// ja : 全プレイヤーのモッドメニューの権限を剥奪する（未承認に設定）
//++++++++++++++++++++++++++++++
removeauthunverifiedforallplayers( )
{
    self thread changeauthallplayers( 0 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions for all players to "verified"
// ja : 全プレイヤーのモッドメニューの権限を "承認者" に設定する
//++++++++++++++++++++++++++++++
giveauthverifiedforallplayers( )
{
    self thread changeauthallplayers( 1 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions for all players to "vip"
// ja : 全プレイヤーのモッドメニューの権限を "要人" に設定する
//++++++++++++++++++++++++++++++
giveauthvipforallplayers( )
{
    self thread changeauthallplayers( 2 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions for all players to "admin"
// ja : 全プレイヤーのモッドメニューの権限を "管理者" に設定する
//++++++++++++++++++++++++++++++
giveauthadminforallplayers( )
{
    self thread changeauthallplayers( 3 );
}



//++++++++++++++++++++++++++++++
// en : set mod menu permissions for all players to "co-host"
// ja : 全プレイヤーのモッドメニューの権限を "副ホスト" に設定する
//++++++++++++++++++++++++++++++
giveauthcohostforallplayers( )
{
    self thread changeauthallplayers( 4 );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : weapons system
// ja : 武器システム
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : get weapon group list
// ja : 武器グループリストを取得する
//++++++++++++++++++++++++++++++
getweapongrouplist( withexplosives , specifiedgroup )
{
    l_weapontype = "";
    l_weaponarray = [];

    // en : if a single weapon group is specified, recreate the weapon group array to only have one.
    // ja : 単一の武器グループの指定がある場合は、武器グループ配列を作り直して1個だけにする
    if ( isdefined( specifiedgroup ) )
    {
        l_weaponarray[0] = specifiedgroup;
    }
    // en : if a single weapon group is not specified
    // ja : 単一の武器グループの指定がない場合
    else
    {
        // en : loop for the number of weapon type groups
        // ja : 武器種類のグループ数分ループ
        for ( weapontype = 0; weapontype <= 14; weapontype++ )
        {
            // en : assemble the weapon type string “weapon_??”
            // ja : 「weapon_??」という武器種類の文字列を組み立てる
            l_weapontype = "weapon_";
            switch ( weapontype )
            {
                case 0:     l_weapontype += "assault";          break;
                case 1:     l_weapontype += "smg";              break;
                case 2:     l_weapontype += "lmg";              break;
                case 3:     l_weapontype += "sniper";           break;
                case 4:     l_weapontype += "dmr";              break;
                case 5:     l_weapontype += "shotgun";          break;
                case 6:     l_weapontype += "pistol";           break;
                case 7:     l_weapontype += "projectile";       break;
                case 8:     l_weapontype += "machine_pistol";   break;
                case 9:     l_weapontype += "grenade";          break;
                case 10:    l_weapontype += "explosive";        break;
                case 11:    l_weapontype += "rail";             break;
                case 12:    l_weapontype += "beam";             break;
                case 13:    l_weapontype += "melee";            break;
                case 14:    l_weapontype += "other";            break;
            }
            // en : add the assembled weapon type string to the array
            // ja : 組み立てた武器種類の文字列を配列に追加する
            l_weaponarray = scripts\engine\utility::array_add( l_weaponarray , l_weapontype );
        }

        // en : exclude explosives from array if random weapons do not include explosives
        // ja : ランダム武器に爆発物を含めない場合は、配列から爆発物を除外する
        if ( !isdefined( withexplosives ) )
        {
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_projectile" );
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_grenade" );
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_explosive" );
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_rail" );
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_beam" );
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_melee" );
            l_weaponarray = scripts\engine\utility::array_remove( l_weaponarray , "weapon_other" );
        }
    }

    return l_weaponarray;
}



//++++++++++++++++++++++++++++++
// en : get weapon camouflage list
// ja : 武器迷彩リストを取得する
//++++++++++++++++++++++++++++++
getweaponcamouflagelist( )
{
    l_camotype = "";
    l_camoarray = [];

    // en : loop for the number of camouflage types
    // ja : 迷彩種類の個数分ループ
    for ( camosize = 1; camosize <= 222; camosize++ )
    {
        l_camotype = "camo";

        // en : if the current loop count is less than 10, fill in 0 with the prefix
        // ja : 今のループ回数が10回未満であれば、プレフィックスで0を補完する
        if      ( camosize < 10 )   l_camotype += "0";
        

        l_camotype += "" + camosize;
        // en : add the assembled camouflage type string to the array
        // ja : 組み立てた迷彩種類の文字列を配列に追加する
        l_camoarray = scripts\engine\utility::array_add( l_camoarray , l_camotype );
    }

    return l_camoarray;
}



//++++++++++++++++++++++++++++++
// en : create a blueprint weapon
// ja : 設計図武器を作成する
//++++++++++++++++++++++++++++++
createblueprintweapon( weaponid , rootid )
{
    l_bpnum = 1;

    // en : randomly select a blueprint number and obtain the corresponding blueprint for the weapon you currently have.
    // ja : 設計図番号をランダムで抽出し、現在の手持ちの武器の該当の設計図を取得する
    switch ( weaponid )
    {
        case "random":
        case "currentbp":
        case "bpcamo":
            l_bpnum = randomintrange( 1 , 51 );
            break;
    }
    
    l_weaponbuild = buildweapon_blueprint( rootid , undefined , undefined , l_bpnum , undefined , undefined , scripts\cp_mp\utility\game_utility::isnightmap( ) );
    // en : if generated weapon data exists
    // ja : 生成された武器データが存在する場合
    if ( isdefined( l_weaponbuild ) )
    {
        // en : get the full weapon name from the generated weapon data
        // ja : 生成された武器データから、完全な武器名を取得する
        return l_weaponbuild;
    }

    return undefined;
}



//++++++++++++++++++++++++++++++
// en : create a specified weapon
// ja : 指定された武器を作成する
//++++++++++++++++++++++++++++++
createspecifiedweapon( weaponid , attachmentsid , attachmenttype , camoid )
{
    // en : generate weapon data from the specified weapon type and camouflage type.
    // ja : 指定の武器種類、迷彩種類から、武器データを生成する
    l_weaponbuild = buildweapon( getweaponrootid( weaponid ) , attachmentsid , camoid , "none" , -1 , undefined , undefined , undefined , scripts\cp_mp\utility\game_utility::isnightmap( ) );
    // en : if generated weapon data exists
    // ja : 生成された武器データが存在する場合
    if ( isdefined( l_weaponbuild ) )
    {
        // en : get random attachment
        // ja : ランダムアタッチメント取得
        l_weaponbuild = providerandomattachment( l_weaponbuild , attachmenttype );
        // en : if generated weapon data exists
        // ja : 生成された武器データが存在する場合
        if ( isdefined( l_weaponbuild ) )
        {
            // en : get the full weapon name from the generated weapon data
            // ja : 生成された武器データから、完全な武器名を取得する
            return l_weaponbuild;
        }
    }
    return undefined;
}



//++++++++++++++++++++++++++++++
// en : get result from give specified weapon
// ja : 指定した武器を与える処理の結果を取得する
//++++++++++++++++++++++++++++++
getresultfromprovideweapon( weaponfullname , onlygetid , changehand , akimbo , notice )
{
    // en : if you want to get only the weapon id
    // ja : 武器idのみを取得する場合
    if ( isdefined( onlygetid ) )
    {
        switch ( onlygetid )
        {
            case 1: return getweaponcompleteid( weaponfullname );
            case 2: return weaponfullname;
        }
    }
    // en : when giving a player a weapon
    // ja : 武器をプレイヤーに持たせる場合
    else
    {
        // en : gives the specified weapon and returns the result whether it was successful or not.
        // ja : 指定した武器を与えて、成功したかどうかの結果を返す
        l_weapondata = self configureweapon( weaponfullname , undefined , changehand , true , akimbo , notice );
        return getweaponcompleteid( l_weapondata );
    }
}



//++++++++++++++++++++++++++++++
// en : give specified weapon
// ja : 指定した武器を与える
//++++++++++++++++++++++++++++++
provideweapon( weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , akimbo , changehand , notice , onlygetid , onlygetdata )
{ 
    if ( isdefined( onlygetdata ) )     onlygetid = 2;
    else if ( isdefined( onlygetid ) )  onlygetid = 1;

    l_weaponarray   = [];
    l_camoarray     = [];
    l_camoid        = camoid;
    l_targetweapon  = undefined;
    l_rootweapon    = undefined;
    l_weaponbuild   = undefined;
    l_bpnum         = 0;

    switch ( weaponid )
    {
        // en : if the weapon type is specified as "random"
        // ja : 武器種類が「ランダム」と指定されている場合
        case "random":
            // en : get weapon group list
            // ja : 武器グループリストを取得する
            l_weaponarray = getweapongrouplist( inprojectile , onlygroup );
            break;
            
        // en : if the weapon type is specified as "currentbp"
        // ja : 武器種類が "currentbp" と指定されている場合
        case "currentbp":
            // en: get information about the weapon you currently have
            // ja: 今持っている武器の情報を取得
            l_targetweapon = self getcurrentweapon( );
            break;
    }

    if ( weaponid == "currentbp" )
    {
        // en: get the root name of the weapon
        // ja: 武器のルート名を取得
        if ( isdefined( l_targetweapon ) ) { l_rootweapon = getweaponrootid( l_targetweapon ); }
        // en: if the weapon information does not exist, the process is aborted.
        // ja: 武器情報が存在しない場合、処理を中断する
        if ( !isdefined( l_targetweapon ) && !isdefined( l_rootweapon ) )
        {
            self showcentermessage( self.curlang , "failed" , "weaponnotavailable" , undefined , undefined , undefined );
            return;
        }
    }
    
    // en : if the camouflage type is specified
    // ja : 迷彩種類が指定されている場合
    if ( isdefined( camoid ) )
    {
        // en : if the camouflage type is specified as "random"
        // ja : 迷彩種類が「ランダム」と指定されている場合
        if ( camoid == "random" )
        {
            // en : get weapon camouflage list
            // ja : 武器迷彩リストを取得する
            l_camoarray = getweaponcamouflagelist( );
        }
        // en : get a random camouflage within a camouflage group
        // ja : 迷彩グループ内でランダムに迷彩を取得する
        else if ( camoid == "group" )
        {
            l_camoid = "camo_" + ( randomintrange( 0 , 12 ) + 1 ) + camogroup;
        }
    }

    for ( i = 0; i < 150; i++ )
    {
        // en : if the camouflage type is specified
        // ja : 迷彩種類が指定されている場合
        if ( isdefined( camoid ) )
        {
            // en : if the camouflage type is specified as "random"
            // ja : 迷彩種類が「ランダム」と指定されている場合
            if ( camoid == "random" )
            {
                // en : pick a camouflage type randomly from the array
                // ja : 配列内からランダムに迷彩種類を取り出す
                l_camoid = scripts\engine\utility::random( l_camoarray );
            }
        }
        // en : if the camouflage type is not specified
        // ja : 迷彩種類が指定されていない場合
        else
        {
            // en : leave camouflage type unspecified
            // ja : 迷彩種類を未指定とする
            l_camoid = undefined;
        }

        switch ( weaponid )
        {
            // en : if the weapon type is specified as "currentbp" , "t9bp" , "s4bp"
            // ja : 武器種類が "currentbp" , "t9bp" , "s4bp" と指定されている場合
            case "currentbp":
                // en : create a blueprint weapon
                // ja : 設計図武器を作成する
                l_weaponfullname = createblueprintweapon( weaponid , l_rootweapon );
                // en : if the weapon name exists, get result from give specified weapon
                // ja : 武器名が存在する場合、指定した武器を与える処理の結果を取得する
                if ( isdefined( l_weaponfullname ) )
                {
                    l_result = self getresultfromprovideweapon( l_weaponfullname , onlygetid , changehand , akimbo , notice );
                    return l_result;
                }
                break;
                
            // en : if the weapon type is specified as "random"
            // ja : 武器種類が「ランダム」と指定されている場合
            case "random":
                // en : pick a weapon type randomly from the array
                // ja : 配列内からランダムに武器種類を取り出す
                l_weapongroupid = scripts\engine\utility::random( l_weaponarray );
                
                if ( isdefined( l_weapongroupid ) )
                {
                    // en : randomly select a weapon from the weapon types
                    // ja : 武器種類からランダムに武器を選ぶ
                    l_weaponid = getrandomweaponfromgroup( l_weapongroupid );
                    if ( isdefined( l_weaponid ) )
                    {
                        if ( isdefined( l_camoid ) && ( l_camoid == "bpcamo" ) )
                        {
                            l_rootweapon = getweaponrootid( l_weaponid );
                            if ( isdefined( l_rootweapon ) )
                            {
                                // en : create a blueprint weapon
                                // ja : 設計図武器を作成する
                                l_weaponfullname = createblueprintweapon( weaponid , l_rootweapon );
                                // en : if the weapon name exists, get result from give specified weapon
                                // ja : 武器名が存在する場合、指定した武器を与える処理の結果を取得する
                                if ( isdefined( l_weaponfullname ) )
                                {
                                    l_result = self getresultfromprovideweapon( l_weaponfullname , onlygetid , changehand , akimbo , notice );
                                    return l_result;
                                }
                            }
                        }
                        else
                        {
                            // en : create a specified weapon
                            // ja : 指定された武器を作成する
                            l_weaponfullname = createspecifiedweapon( l_weaponid , undefined , attachmentid , l_camoid );
                            // en : if the weapon name exists, get result from give specified weapon
                            // ja : 武器名が存在する場合、指定した武器を与える処理の結果を取得する
                            if ( isdefined( l_weaponfullname ) )
                            {
                                l_result = self getresultfromprovideweapon( l_weaponfullname , onlygetid , changehand , akimbo , notice );
                                return l_result;
                            }
                        }
                    }
                }
                break;
                
            // en : when the weapon type is specified directly by id
            // ja : 武器種類が直接id指定されている場合
            default:
                l_attachmentlist = undefined;

                // en : if attachment id is specified
                // ja : アタッチメントidが指定されている場合
                if ( isdefined( attachmentid ) )
                {
                    // en : if the attachment id is not specified as "random"
                    // ja : アタッチメントidが "ランダム" と指定されていない場合
                    if ( attachmentid != "random" )
                    {
                        // en : add attachment id to weapon id
                        // ja : 武器idにアタッチメントidを追加する
                        weaponid += attachmentid;
                        // en : extract attachment id from weapon id
                        // ja : 武器idからアタッチメントidを取り出す
                        l_attachmentlist = strtok( weaponid , "+" );
                    }
                }
                
                if ( isdefined( l_camoid ) && ( l_camoid == "bpcamo" ) )
                {
                    l_rootweapon = getweaponrootid( weaponid );
                    if ( isdefined( l_rootweapon ) )
                    {
                        // en : create a blueprint weapon
                        // ja : 設計図武器を作成する
                        l_weaponfullname = createblueprintweapon( l_camoid , l_rootweapon );
                        // en : if the weapon name exists, get result from give specified weapon
                        // ja : 武器名が存在する場合、指定した武器を与える処理の結果を取得する
                        if ( isdefined( l_weaponfullname ) )
                        {
                            l_result = self getresultfromprovideweapon( l_weaponfullname , onlygetid , changehand , akimbo , notice );
                            return l_result;
                        }
                    }
                }
                else
                {
                    // en : create a specified weapon
                    // ja : 指定された武器を作成する
                    l_weaponfullname = createspecifiedweapon( weaponid , l_attachmentlist , attachmentid , l_camoid );
                    // en : if the weapon name exists, get result from give specified weapon
                    // ja : 武器名が存在する場合、指定した武器を与える処理の結果を取得する
                    if ( isdefined( l_weaponfullname ) )
                    {
                        l_result = self getresultfromprovideweapon( l_weaponfullname , onlygetid , changehand , akimbo , notice );
                        return l_result;
                    }
                }
                break;
        }
        
        wait 0.001;
    }

    // en: display the text "[notification] weapon operation status: weapon id" in the center of the screen.
    // ja: 画面中央に "[通知] 武器の操作状態 : 武器id" という文章を表示する
    self showcentermessage( self.curlang , "notice" , "failedbuildweapon" , undefined , "onprovideweapon" , undefined );
    return "failedweapon";
}



//++++++++++++++++++++++++++++++
// en : get random attachment
// ja : ランダムアタッチメント取得
//++++++++++++++++++++++++++++++
providerandomattachment( weaponbuild , attachmentid )
{
    l_weaponbuild = weaponbuild;

    // en : if attachment id is specified
    // ja : アタッチメントidが指定されている場合
    if ( isdefined( attachmentid ) )
    {
        // en : if the attachment id is specified as "random"
        // ja : アタッチメントidが "ランダム" と指定されている場合
        if ( attachmentid == "random" )
        {
            // en : randomly determine the number of attachments
            // ja : アタッチメントの個数をランダムに決める
            l_attachmentmax = randomintrange( 1 , 8 );
            // en : loop for the number of attachments
            // ja : アタッチメントの個数分ループ
            for ( attachcount = 0; attachcount < l_attachmentmax; attachcount++ )
            {
                // en : get attachment types that can be set in weapon data
                // ja : 武器データに設定可能なアタッチメント種類を取得する
                l_attachmentdata = getrandomgraverobberattachment( l_weaponbuild );
                // en : if attachment data exists
                // ja : アタッチメントデータが存在する場合
                if ( isdefined( l_attachmentdata ) )
                {
                    // en : add attachment to weapon data
                    // ja : 武器データにアタッチメントを追加する
                    l_weaponfulldata = addattachmenttoweapon( l_weaponbuild , l_attachmentdata );
                    // en : update weapon data if weapon data integration is successful
                    // ja : 武器データの統合が成功している場合、武器データを更新する
                    if ( isdefined( l_weaponfulldata ) )
                    {
                        l_weaponbuild = l_weaponfulldata;
                    }
                }
            }
        }
    }

    return l_weaponbuild;
}



//++++++++++++++++++++++++++++++
// en : give or take away the specified weapon
// ja : 指定した武器を与えるか、もしくは取り上げる
//++++++++++++++++++++++++++++++
configureweapon( weapondata , takehand , changehand , randomchoose , akimbo , notice )
{
    l_weapondata = weapondata;
    l_textid = "failedbuildweapon";

    // en : if you already have the specified weapon
    // ja : 既に指定された武器を持っている場合
    if ( self hasweapon( weapondata ) )
    {
        // en : when picking up a weapon
        // ja : 武器を取り上げる場合
        if ( isdefined( takehand ) )
        {
            // en : pick up the specified weapon and initialize the weapon data
            // ja : 指定された武器を取り上げて、武器データを初期化する
            self scripts\cp_mp\utility\inventory_utility::_takeweapon( weapondata );
            l_weapondata = undefined;
            
            // en : set text id
            // ja : テキストidを設定
            l_textid = "takedweapon";

            // en : when switching weapons
            // ja : 武器を切り替える場合
            if ( isdefined( changehand ) )
            {
                // en : waits a millisecond to confirm that the weapon is no longer in your possession.
                // ja : 武器が手元から無くなったことを確認するため、ミリ秒待機する
                wait 0.001;
            }
        }
        // en : when giving a weapon
        // ja : 武器を与える場合
        else
        {
            // en : set text id
            // ja : テキストidを設定
            l_textid = "alreadyhaveweapon";
            // en : switch to the same weapon because you already have it
            // ja : 既に同じ武器を持っているため、その武器に切り替える
            self setspawnweapon( weapondata );
        }
    }
    // en : if you do not have the specified weapon
    // ja : 指定された武器を持っていない場合
    else
    {
        // en : when picking up a weapon
        // ja : 武器を取り上げる場合
        if ( isdefined( takehand ) )
        {
            // en : set text id
            // ja : テキストidを設定
            l_textid = "nohaveweapon";
            // en : set the result of failing to pick up a weapon because you no longer have one
            // ja : 既に武器を持っていないため、武器の取り上げに失敗した結果を設定する
            l_weapondata = undefined;
        }
        // en : when giving a weapon
        // ja : 武器を与える場合
        else
        {
            // en : give specified weapon
            // ja : 指定した武器を与える
            self scripts\cp_mp\utility\inventory_utility::_giveweapon( weapondata , undefined , akimbo , 1 );
            self setspawnweapon( weapondata );
            
            // en: gives maximum ammo for that weapon
            // ja: その武器の最大弾薬数を与える
            self givemaxammo( weapondata );
            
            // en : set text id
            // ja : テキストidを設定
            l_textid = "getweapon";
        }
    }
    
    // en : when switching weapons
    // ja : 武器を切り替える場合
	if ( isdefined( changehand ) )
    {
        // en : if the specified weapon exists
        // ja : 指定された武器が存在する場合
        if ( isdefined( l_weapondata ) )
        {
            // en : switch weapons
            // ja : 武器を切り替える
            self scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( weapondata );
        }
        // en : if the specified weapon does not exist
        // ja : 指定された武器が存在しない場合
        else
        {
            // en : if you don't have any weapons in hand
            // ja : 今手に持っている武器が何もない場合
            if ( isnullweapon( self getcurrentweapon( ) ) )
            {
                // en : if you have a main weapon, switch to that weapon.
                // ja : メイン武器を所持していれば、その武器に切り替える
                if ( isdefined( self.primaryweapon ) )
                {
                    self scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( self.primaryweapon );
                }
            }
        }
    }

    // en: if you need to display a message
    // ja: メッセージを表示する必要がある場合
    if ( isdefined( notice ) )
    {
        // en: display the text "[notification] weapon operation status: weapon id" in the center of the screen.
        // ja: 画面中央に "[通知] 武器の操作状態 : 武器id" という文章を表示する
        self showcentermessage( self.curlang , "notice" , l_textid , undefined , weapondata , undefined );
    }

    // en : return weapon processing results
    // ja : 武器の処理結果を返す
    return l_weapondata;
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : In-game logic generic function
// ja : インゲームロジック汎用関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : play the effect starting from the specified object
// ja : 指定したオブジェクトを起点にエフェクトを再生する
//++++++++++++++++++++++++++++++
playeffecttoobject( time , obj , fx , tag , type , loop , base , fix , angle , range , stop , owner )
{
    l_owner = self;
    if ( isdefined( owner ) ) l_owner = owner;

    if ( type == "special" )
    {
        if ( fx == "nuke" )
        {
            if ( isdefined( obj ) ) self thread execnuclearexplosion( obj.origin    , l_owner );
            else                    self thread execnuclearexplosion( base          , l_owner );
            
            return;
        }
    }

    // en : if the specified object exists
    // ja : 指定されたオブジェクトが存在する場合
    if ( isdefined( obj ) )
    {
        // en: set the specified effect name as the function termination trigger
        // ja: 指定のエフェクト名を関数の終了トリガーとする
        obj endon( "end_" + fx );
        
        // en : if a tag name is specified and the object does not have a tag, fix the tag name.
        // ja : タグ名が指定されていて、そのオブジェクトがタグを持っていない場合は、タグ名を修正する
        if ( isdefined( tag ) )
        {
            if ( scripts\engine\utility::hastag( obj.model , tag ) == false )
            {
                tag = "tag_origin";
            }
        }
    }

    // en : to end the tag effect that is currently playing
    // ja : 再生中のタグエフェクトを終了する場合
    if ( isdefined( stop ) )
    {
        if      ( type == "gettag" )    { stopfxontag( scripts\engine\utility::getfx( fx ) , obj , tag ); }
        else if ( type == "loadtag" )   { stopfxontag( fx , obj , tag ); }

        // en: set the specified option name as the function termination trigger
        // ja: 指定のエフェクト名の終了トリガーを通知する
        obj notify( "end_" + fx );
        return;
    }
    
    // en : if adjustment coordinates are not specified, initialize them.
    // ja : 調整座標を指定されてない場合は、初期化しておく
    if ( !isdefined( fix ) )    { fix = ( 0 , 0 , 0 ); }

    // en: infinite loop
    // ja: 無限ループ
    while ( true )
    {
        // en : if the specified object exists
        // ja : 指定されたオブジェクトが存在する場合
        if ( isdefined( obj ) )
        {
            // en : if a tag name is specified, play the effect at the coordinates of the tag name
            // ja : タグ名が指定されている場合、タグ名の座標にエフェクトを再生する
            if ( isdefined( tag ) )
            {
                if      ( type == "gettag" )    { playfxontag( scripts\engine\utility::getfx( fx ) , obj , tag ); }
                else if ( type == "loadtag" )   { playfxontag( fx , obj , tag ); }
            }
            // en : if no tag name is specified, play the effect at a location shifted from the object to the modified coordinates.
            // ja : タグ名が指定されていない場合、オブジェクトから修正座標にずらした場所にエフェクトを再生する
            else
            {
                if ( isdefined( angle ) )
                {
                    switch ( angle )
                    {
                        case "up":      fix = fix + anglestoup( obj.angles ) * range; break;
                        case "forward": fix = fix + anglestoforward( obj.angles ) * range; break;
                        case "left":    fix = fix + anglestoleft( obj.angles ) * range; break;
                        case "right":   fix = fix + anglestoright( obj.angles ) * range; break;
                    }
                }

                if      ( type == "getplay" )   { playfx( scripts\engine\utility::getfx( fx ) , obj.origin + fix ); }
                else if ( type == "loadplay" )  { playfx( fx , obj.origin + fix ); }

                else if ( type == "getspawn" )  { l_fx = spawnfx( scripts\engine\utility::getfx( fx ) , obj.origin + fix ); triggerfx( l_fx ); l_fx thread deleteaftertime( 5 ); }
                else if ( type == "loadspawn" ) { l_fx = spawnfx( fx , obj.origin + fix ); triggerfx( l_fx ); l_fx thread deleteaftertime( 5 ); }
            }
        }
        // en : if the specified object does not exist
        // ja : 指定されたオブジェクトが存在しない場合
        else
        {
            // en : if basic coordinates are specified, generate effect at specified coordinates
            // ja : 基本座標が指定されている場合、指定された座標にエフェクトを生成する
            if ( isdefined( base ) )
            {
                if      ( type == "getplay" )   { playfx( scripts\engine\utility::getfx( fx ) , base + fix ); }
                else if ( type == "loadplay" )  { playfx( fx , base + fix ); }
                
                else if ( type == "getspawn" )  { l_fx = spawnfx( scripts\engine\utility::getfx( fx ) , base + fix ); triggerfx( l_fx ); l_fx thread deleteaftertime( 5 ); }
                else if ( type == "loadspawn" ) { l_fx = spawnfx( fx , base + fix ); triggerfx( l_fx ); l_fx thread deleteaftertime( 5 ); }
            }

            // en : in the case of loop processing, the loop is interrupted because there is no means to terminate it.
            // ja : ループ処理の場合、終了するための手段を実装していないため、ループを中断する
            if ( isdefined( loop ) ) { break; }
        }

        // en : break the loop if it does not loop infinitely
        // ja : 無限ループしない場合、ループを中断する
        if ( !isdefined( loop ) ) { break; }
        
        wait time;
    }
}



//++++++++++++++++++++++++++++++
// en : delete the specified object after the specified number of seconds
// ja : 指定されたオブジェクトを、指定された秒数経過後に削除する
//++++++++++++++++++++++++++++++
deleteaftertime( time )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );
    
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( time );
    self deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : obtain a trace in the front direction
// ja : 正面方向へのトレースを取得する
//++++++++++++++++++++++++++++++
getplayerforwardtrace( trace , eye , length , up )
{
    // en: when to use tracing
    // ja: トレースを使用する場合
    if ( isdefined( trace ) ) 
        return scripts\engine\trace::_bullet_trace( self geteye( ) , self geteye( ) + ( anglestoforward( self getplayerangles( ) ) * length ) , 1 , self );
    // en: when not to use tracing
    // ja: トレースを使用しない場合
    else
    {
        // en: get the coordinates of the player's front direction
        // ja: プレイヤーの正面方向の座標を取得する
        l_location = getangletrace(
            /* object */    self ,
            /* eye */       eye ,
            /* up */        up ,
            /* center */    undefined ,
            /* forward */   undefined ,
            /* back */      undefined ,
            /* backup */    undefined ,
            /* left */      undefined ,
            /* right */     undefined ,
            /* lrup */      undefined ,
            /* end */       length ,
            /* endup */     undefined ,
            /* enddown */   undefined ,
            /* trace */     trace
            );
        return l_location["end"];
    }
}



//++++++++++++++++++++++++++++++
// en : obtains a frontal trace that matches the angle of the specified object
// ja : 指定したオブジェクトの角度に合わせた、正面方向のトレースを取得する
//++++++++++++++++++++++++++++++
getangletrace( object , eye , up , center , forward , back , backup , left , right , lrup , end , endup , enddown , trace )
{
    if ( !isdefined( object ) )     { return; }
    
    l_angle = undefined;
    if ( !isplayer( object ) )      { l_angle = object.angles; }
    else                            { l_angle = object getplayerangles( ); }

    l_location = [];
    l_location["start"] = object.origin;
    if ( isplayer( object ) )       { if ( isdefined( eye ) ) { l_location["start"] = object geteye( ); } }

    if ( isdefined( up ) )          { l_location["start"]      += vectorscale( anglestoup( l_angle ) , up ); }
    if ( isdefined( center ) )      { l_location["start"]      += vectorscale( anglestoforward( l_angle ) , center ); }
    if ( isdefined( forward ) )     { l_location["forward"]    = l_location["start"] + vectorscale( anglestoforward( l_angle ) , forward ); }
    if ( isdefined( back ) )        { l_location["back"]       = l_location["start"] + vectorscale( anglestoforward( l_angle ) , back ); }
    if ( isdefined( left ) )        { left *= -1; }
    if ( isdefined( left ) )        { l_location["left"]       = l_location["start"] + vectorscale( anglestoright( l_angle ) , left ); }
    if ( isdefined( right ) )       { l_location["right"]      = l_location["start"] + vectorscale( anglestoright( l_angle ) , right ); }
    if ( isdefined( backup ) )
    {
        if ( isdefined( back ) )    { l_location["back"]       += vectorscale( anglestoup( l_angle ) , backup ); }
    }
    if ( isdefined( lrup ) )
    {
        if ( isdefined( left ) )    { l_location["left"]       += vectorscale( anglestoup( l_angle ) , lrup ); }
        if ( isdefined( right ) )   { l_location["right"]      += vectorscale( anglestoup( l_angle ) , lrup ); }
    }
    if ( isdefined( end ) )         { l_location["end"]        = l_location["start"] + vectorscale( anglestoforward( l_angle ) , end ); }
    if ( isdefined( endup ) )       { l_location["endup"]      = l_location["start"] + vectorscale( anglestoup( l_angle ) , endup ); }
    if ( isdefined( enddown ) )     { l_location["enddown"]    = l_location["start"] + vectorscale( anglestoup( l_angle ) , enddown ); }
    if ( isdefined( trace ) )
    {
        if ( isdefined( end ) )
        {
            l_point = scripts\engine\trace::_bullet_trace( l_location["start"] , l_location["end"] , 1 , object );
            l_location["endtrace"] = l_point["position"];
        }
    }

    return l_location;
}



//++++++++++++++++++++++++++++++
// en : get the coordinates that are multiples ahead of the specified coordinates
// ja : 指定の座標に対して、倍数分先の座標を取得する
//++++++++++++++++++++++++++++++
vectorscale( location , length )
{
    return ( location[0] * length , location[1] * length , location[2] * length );
}



//++++++++++++++++++++++++++++++
// en : Plays the specified sound effect locally for players
// ja : プレイヤーに指定したサウンドエフェクトをローカルで再生させる
//++++++++++++++++++++++++++++++
playsoundatallplayers( sfx , target )
{
    if ( !isdefined( target ) )
    {
        // en: get information on all participating players
        // ja: 参加中の全プレイヤー情報を取得
        foreach( player in level.players )
            // en: play se only for yourself
            // ja: seを自分だけ再生する
            player playlocalsound( sfx );
    }
    else
        // en: play se only for yourself
        // ja: seを自分だけ再生する
        target playlocalsound( sfx );
}



//++++++++++++++++++++++++++++++
// en : wait for a bullet to be fired and process the specified event by matching the weapon information.
// ja : 銃弾の発射を待機し、武器情報の照合一致により、指定のイベントを処理する
//++++++++++++++++++++++++++++++
waitfirebullets( optname1 , optname2 , optfunc , notice , specificweapon , effectdata , enddeath )
{
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    // en : if you want to disable the function when you die
    // ja : 死んだ時に機能を無効化したい場合
    if ( isdefined( enddeath ) )
    {
        // en : this function ends processing if "you die"
        // ja : この関数は「自分が死んだ」場合に処理を終了する
        self endon( "death" );
    }
    
    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名を関数の終了トリガーとする
    self endon( "end_" + optname1 );
    
    // en: if an effect is specified, allow the effect to occur on fire.
    // ja: エフェクトが指定されている場合、発射時にエフェクトを発生できるようにする
    if ( isdefined( effectdata ) )
    {
        self.optstat[optname1].effectdata = effectdata;
    }

    // en: make it a variable so that you can adjust the distance of the coordinates to get when firing a gun
    // ja: 銃発射時の取得先の座標の距離を調整できるように変数化する
    self.optstat[optname1].moddata["tracelength"] = 100000;

    // en: infinite loop
    // ja: 無限ループ
    while ( true )
    {
        // en: wait until the bullet is fired
        // ja: 銃弾を発射するまで待機する
        self waittill( "weapon_fired" );

        // en: if the specified variable does not exist, end the loop processing
        // ja: 指定の変数が存在しない場合は、ループ処理を終了する
        if ( !isdefined( self.optstat[optname1] ) ) { break; }
        if ( isdefined( optname2 ) )
        {
            if ( !isdefined( self.optstat[optname1].moddata[optname2] ) ) { break; }
        }
        
        // en: activates with specific weapons
        // ja: 特定の武器で発動する場合
        if ( isdefined( specificweapon ) )
        {
            // en: if there is no weapon data linked to the specified variable, end the loop process.
            // ja: 指定の変数に連携する武器データが存在しない場合は、ループ処理を終了する
            if ( !isdefined( self.optstat[optname1].weapondata ) ) { break; }
            
            // en: if the fired weapon and the weapon linked to the specified variable do not match, restart the process.
            // ja: 発射された武器と、指定の変数に連携する武器が一致しない場合は、処理をやり直す
            if ( getweaponcompleteid( self getcurrentweapon( ) ) != self.optstat[optname1].weapondata ) { continue; }
        }

        // en : obtain trace results for a specified number of distances in the front direction
        // ja : 正面方向へ 指定した数値分先 の距離のトレース結果を取得する
        l_endlocation = self getplayerforwardtrace( true , true , self.optstat[optname1].moddata["tracelength"] );
        
        // en: if coordinate information has been obtained
        // ja: 座標情報が取得できている場合
        if ( isdefined( l_endlocation["position"] ) )
        {
            // en: if effect data exists
            // ja: エフェクトデータが存在する場合
            if ( isdefined( self.optstat[optname1].effectdata ) )
            {
                // en: play the effect at the obtained coordinates
                // ja: 取得した座標にエフェクトを再生する
                playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ self.optstat[optname1].effectdata , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ l_endlocation["position"] , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
            }

            if ( isdefined( notice ) )
            {
                // en: display the text "[notification] request to specified coordinates: function name" in the center of the screen.
                // ja: 画面中央に「[通知] 指定座標に要請 : 機能名」という文章を表示する
                self showcentermessage( self.curlang , "notice" , "requestlocation" , optname1 , undefined , undefined );
            }

            // en: execute the specified function in a subthread (with coordinate arguments)
            // ja: 指定した関数をサブスレッドで実行する（座標引数付き）
            self thread [[ optfunc ]]( l_endlocation["position"] );
        }
    }
}



//++++++++++++++++++++++++++++++
// en : set physical strength to receive damage
// ja : ダメージを受け取る体力設定を行う
//++++++++++++++++++++++++++++++
createdamagingsystem( hpmin , hpmax , dmgtype , dmgfx , brktype , brkfx , dmgse , brkse , del , name , owner )
{
    // en: if maximum health is not specified, do not proceed further.
    // ja: 最大体力が指定されていない場合は、この先の処理を行わない
    if ( !isdefined( hpmax ) ) { return; }


    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    
    // en: set the owner of this object if specified
    // ja: このオブジェクトの所有者が指定されている場合は設定する
    if ( isdefined( owner ) )
    {
        self.owner          = owner;
        self.team           = owner.team;
        self.pers["team"]   = owner.pers["team"];
    }


    // en : allow yourself to take damage
    // ja : 自分自身がダメージを受けられるようにする
    self setcandamage( true );
    
    // en: if minimum health is specified
    // ja: 最低体力が指定されている場合
    if ( isdefined( hpmin ) )
    {
        // en: randomly determine maximum health
        // ja: 最大体力をランダムで決める
        self.health = randomintrange( hpmin , hpmax );
    }
    // en: if minimum health is not specified
    // ja: 最低体力が指定されていない場合
    else
    {
        // en: set maximum health
        // ja: 最大体力を設定
        self.health = hpmax;
    }
    self.maxhealth = self.health;

    // en: infinite loop until stamina runs out
    // ja: 体力が無くなるまで無限ループ
    while ( 0 < self.health )
    {
        // en: wait to take damage
        // ja: ダメージを受けるのを待機する
        self waittill( "damage" , damagedsize , playerinfo , var_2 , damagedpoint , damagetype , var_5 , var_6 , var_7 , var_8 , weaponname , var_10 , var_11 , var_12 , killstreakinfo );

        // en: remember the last player info who caused damage
        // ja: 最後にダメージを与えたプレイヤー情報を記憶する
        self.lastattacker = playerinfo;
        self.lastdamagetype = damagetype;
        self.lastweaponname = weaponname;

        // en: reduces health by the amount of damage received
        // ja: 受けたダメージ分体力を減らす
        self.health = self.health - damagedsize;

        // en: if you still have the energy
        // ja: 体力がまだある場合
        if ( 0 < self.health )
        {
            // en: if a damage effect is specified
            // ja: ダメージエフェクトが指定されている場合
            if ( isdefined( dmgfx ) )
            {
                // en: generates an effect at the damaged coordinates
                // ja: ダメージを受けた座標にエフェクトを発生させる
                playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ dmgfx , /* tag */ undefined , /* type */ dmgtype , /* loop */ undefined , /* base */ damagedpoint, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
            }
            // en: if damage sound effects are specified
            // ja: ダメージサウンドエフェクトが指定されている場合
            if ( isdefined( dmgse ) )
            {
                // en: regenerate se at damaged coordinates
                // ja: ダメージを受けた座標にseを再生させる
                playsoundatpos( damagedpoint , dmgse );
            }
        }
        // en: if you run out of energy
        // ja: 体力が無くなった場合
        else
        {
            // en: if a destruction effect is specified
            // ja: 破壊エフェクトが指定されている場合
            if ( isdefined( brkfx ) )
            {
                // en: play a destruction effect at your center point
                // ja: 自分の中心点に破壊エフェクトを再生する
                playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ brkfx , /* tag */ undefined , /* type */ brktype , /* loop */ undefined , /* base */ self.origin, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
            }
            // en: if a destruction sound effect is specified
            // ja: 破壊サウンドエフェクトが指定されている場合
            if ( isdefined( brkse ) )
            {
                // en: regenerate se at damaged coordinates
                // ja: ダメージを受けた座標にseを再生させる
                playsoundatpos( damagedpoint , brkse );
            }
            
            // en: break the loop
            // ja: ループを中断する
            break;
        }
    }

    // en: when deleting a model when it runs out of health
    // ja: 体力が無くなった時にモデルを削除する場合
    if ( isdefined( del ) )
    {
        wait 0.001;

        if ( isdefined( self.crate ) )
            self.crate deleteentity( );
            
        // en: delete yourself
        // ja: 自分自身を削除する
        self deleteentity( );
    }
    // en: if the model is not deleted when it runs out of health
    // ja: 体力が無くなった時にモデルを削除しない場合
    else
    {
        // en: notify termination trigger due to destruction of specified option name
        // ja: 指定のオプション名の破壊による終了トリガーを通知する
        self notify( "breaked_" + name );
        if ( isdefined( owner ) )
        {
            owner notify( "breaked_" + name );
        }
    }
}



//++++++++++++++++++++++++++++++
// en : creates the specified object at a specified multiple distance from your eye.
// ja : 自分の眼先から指定した倍数先の距離に、指定したオブジェクトを作成
//++++++++++++++++++++++++++++++
createentityobject( notice , location , length , script , model , collide , sync , angle , part , hpmin , hpmax , dmgtype , dmgfx , brktype , brkfx , dmgse , brkse , del , optname )
{
    l_listname = "deletelastobject_objectcount";
    if ( isdefined( level.lvlstat[l_listname] ) )
    {
        if ( 770 < level.lvlstat[l_listname].size )
        {
            // en: display the text "[notification] create object: object name" in the center of the screen
            // ja: 画面中央に「[通知] オブジェクトを作成 : オブジェクト名」という文章を表示する
            self showcentermessage( self.curlang , "failed" , "the number of objects is full, please reduce it." , undefined , model , undefined );
            return;
        }
    }

    // en: if the object data to be created does not exist, generate an error and do not process.
    // ja: 作成するオブジェクトデータが存在無い場合は、エラーを出して処理しない
    if ( !isdefined( model ) )
        return;


    l_objectlocation = undefined;
    // en : get the creation coordinates of the object (place it in front of you, a specified number of minutes away from you)
    // ja : 生成先距離の指定がある場合
    if ( isdefined( length ) )
        // en : get the creation coordinates of the object (place it in front of you, a specified number of minutes away from you)
        // ja : オブジェクトの生成座標を取得（正面方向に 指定数分 倍先の距離、自分の目の前にする）
        l_objectlocation = self getplayerforwardtrace( undefined , true , length , -10 );

    // en: if coordinates are specified, give priority to that information.
    // ja: 座標指定がある場合はその情報を優先する
    if ( isdefined( location ) )
        l_objectlocation = location;

    
    l_objectangle = undefined;
    
    // en: if there is an angle specification, that information takes precedence.
    // ja: 角度指定がある場合はその情報を優先する
    if ( isdefined( angle ) )
        l_objectangle = angle;
    // en: if there is not an angle specification
    // ja: 角度指定が無い場合
    else
    {
        l_objectangle = self getplayerangles( );
        if ( !isdefined( l_objectangle ) )
            l_objectangle = ( 0 , 0 , 0 );
        else
        {
            // en: if "x-axis rotation setting" is enabled
            // ja: "x軸回転設定" が 有効 になっている場合
            if ( isdefined( sync ) )    l_objectangle = ( l_objectangle[0] , l_objectangle[1] , 0 );
            // en: if "x-axis rotation setting" is disabled
            // ja: "x軸回転設定" が 無効 になっている場合
            else                        l_objectangle = ( 0 , l_objectangle[1] , 0 );
        }
    }


    // en : create an empty 3d model at the generation position
    // ja : 生成位置に空の3dモデルを作成する
    l_newobject = spawn( script + ( ( script == "weapon_" ) ? model : "" ) , l_objectlocation );
    // en : set model data
    // ja : モデルデータを設定する
    l_newobject setmodel( ( ( script != "weapon_" ) ? model : "" ) );
    
    // en: set the angle of the generated object
    // ja: 生成したオブジェクトの角度を設定する
    l_newobject.angles = l_objectangle;

    // en : set all script parts status for the specified model
    // ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
    if ( isdefined( part ) )
    {
        if ( ( model != "military_carepackage_01_juggernaut" ) &&
            ( model != "military_carepackage_01_enemy" ) &&
            ( model != "military_carepackage_01_friendly" ) )
            l_newobject thread setallsetscriptablepartstate( );
    }

    // en: when object collision detection is required
    // ja: オブジェクトの衝突判定が必要な場合
    if ( isdefined( collide ) )
    {
        // en: set an object solid
        // ja: オブジェクトを固体設定する
        l_newobject solid( );
        l_newobject dontinterpolate( );
        l_newobject show( );
        //l_newobject setsolid( true );
        l_newobject physics_registerforcollisioncallback( );
        l_newobject.physicson = true;
        l_newobject.unresolved_collision_kill = true;

        
        switch ( model )
        {
            case "vm_equip_gen_care_package_00":
            case "military_carepackage_01_enemy":
            case "military_carepackage_01_juggernaut":
            case "military_carepackage_01_friendly":
            case "com_plasticcase_beige_big_iw6":
                l_newobject createmountmantlemodel( );
                break;
        }
    }
    // en: when object collision detection is not required
    // ja: オブジェクトの衝突判定が不要な場合
    else
        // en: assume an object is not solid
        // ja: オブジェクトを固体ではないとする
        l_newobject notsolid( );
    
    
    // en: set the owner of the generated object
    // ja: 生成したオブジェクトのオーナーを設定する
    l_newobject.owner = self;

    // en: if maximum health is specified
    // ja: 最大体力が指定されている場合
    if ( isdefined( hpmax ) )
    {
        if ( !isdefined( l_newobject.mountmantlemodel ) )
            l_newobject thread createdamagingsystem( hpmin , hpmax , dmgtype , dmgfx , brktype , brkfx , dmgse , brkse , del , optname , self );
        else
            l_newobject.mountmantlemodel thread createdamagingsystem( hpmin , hpmax , dmgtype , dmgfx , brktype , brkfx , dmgse , brkse , del , optname , self );
    }

    // en: add the created object to the managed list
    // ja: 作成されたオブジェクトを管理リストに追加する
    if ( isdefined( l_newobject ) )
    {
        if ( !isdefined( level.lvlstat[l_listname] ) ) level.lvlstat[l_listname] = [];
        level.lvlstat[l_listname][level.lvlstat[l_listname].size] = l_newobject;
        if ( isdefined( l_newobject.mountmantlemodel ) )
            level.lvlstat[l_listname][level.lvlstat[l_listname].size] = l_newobject.mountmantlemodel;
    }

    // en: if you need to display a message
    // ja: メッセージを表示する必要がある場合
    if ( isdefined( notice ) )
        // en: display the text "[notification] create object: object name" in the center of the screen
        // ja: 画面中央に「[通知] オブジェクトを作成 : オブジェクト名」という文章を表示する
        self showcentermessage( self.curlang , "notice" , "createobject" , undefined , model , undefined );

    return l_newobject;
}



//++++++++++++++++++++++++++++++
// en : Gives collision for care packages
// ja : ケアパッケージ用のコリジョンを付与する
//++++++++++++++++++++++++++++++
createmountmantlemodel( )
{
    if ( !isdefined( level.cratedata_mountmantlemodel ) )
        level.cratedata_mountmantlemodel = getent( "care_package_col", "targetname" );

    var_1 = spawn( "script_model" , self.origin );
    var_1 dontinterpolate();
    var_1.angles = self.angles;
    var_1.owner = self.owner;
    var_1.unresolved_collision_kill = 1;
    var_1.killcament = self.killcament;
    var_1.mountmantlemodel = 1;
    var_1 clonebrushmodeltoscriptmodel( level.cratedata_mountmantlemodel );
    var_1 linkto( self );
    self.mountmantlemodel = var_1;
    var_1.crate = self;
}



//++++++++++++++++++++++++++++++
// en : a generic function to remove a specified object (for world entity list interference)
// ja : 指定されたオブジェクトを削除するための汎用関数（ワールドエンティティリスト干渉用）
//++++++++++++++++++++++++++++++
deleteentity( )
{
    l_optname1 = "deletelastobject";
    l_optname2 = "_objectcount";
    l_optname3 = l_optname1 + l_optname2;

    if ( isdefined( level.lvlstat[l_optname3] ) &&
        ( 0 < level.lvlstat[l_optname3].size ) &&
        scripts\engine\utility::array_contains( level.lvlstat[l_optname3] , self )
        )
    {
        level.lvlstat[l_optname3] = scripts\engine\utility::array_remove( level.lvlstat[l_optname3] , self );
    }
    
    if ( isdefined( self.owner ) &&
        isdefined( self.owner.optstat[l_optname3] ) &&
        ( 0 < self.owner.optstat[l_optname3].size ) &&
        scripts\engine\utility::array_contains( self.owner.optstat[l_optname3] , self )
        )
    {
        self.owner.optstat[l_optname3] = scripts\engine\utility::array_remove( self.owner.optstat[l_optname3] , self );
    }
    
    self delete( );
}



//++++++++++++++++++++++++++++++
// en : arrange the specified objects in a circular shape
// ja : 指定したオブジェクトを円形状に配置する
//++++++++++++++++++++++++++++++
//createcirclemode( 3         , 18       , l_basel , undefined , "z" , 45    , "xy" , 65     , undefined   , (0,0,90),undefined, 0.01     , "military_crate_field_upgrade_01" );
createcirclemodels( circlemax , modelmax , basepos , circlefix , dir , space , type , radius , radiscaleup , angle , anglesync , interval , id , optname )
{
    radians         = 0;
    xpos            = 0;
    ypos            = 0;
    zpos            = 0;
    curradius       = 0;
    circlepos       = ( 0 , 0 , 0 );

    if ( !isdefined( circlefix ) ) { circlefix = ( 0 , 0 , 0 ); }
    if ( !isdefined( anglesync ) ) { anglesync = "none"; }
    
    for ( circle = 0; circle < circlemax; circle++ )
    {
        circlepos   = ( 0 , 0 , 0 );
        curradius   = ( ( !isdefined( radiscaleup ) ) ? radius : ( radius * ( circle + 1 ) ) );

        switch ( dir )
        {
            case "x":   circlepos = ( ( circlefix[0] + ( circle * space ) ) , circlefix[1]                          , circlefix[2] );                               break;
            case "y":   circlepos = ( circlefix[0]                          , ( circlefix[1] + ( circle * space ) ) , circlefix[2] );                               break;
            case "xy":  circlepos = ( circlefix[0]                          , circlefix[1]                          , circlefix[2] );                               break;
            case "z+":  circlepos = ( circlefix[0]                          , circlefix[1]                          , ( circlefix[2] + ( circle * space ) ) );      break;
            case "z-":  circlepos = ( circlefix[0]                          , circlefix[1]                          , ( circlefix[2] + ( circle * space * -1 ) ) ); break;
        }

        // 中心点デバッグ用
        //  self createentityobject(
        //  /* notice */ undefined , /* point */ basepos + circlepos , /* length */ undefined , /* script */ "script_model" , /* model */ "military_dogtags_iw8_blue" , /* collide */ true , /* sync */ undefined , /* angle */ undefined , /* part */ true ,
        //  /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
        //  );

        for ( model = 0; model < modelmax; model++ )
        {
            radians = 360 / modelmax;

            switch ( type )
            {
                case "xy":
                    xpos = cos( model * radians ) * curradius;
                    ypos = sin( model * radians ) * curradius;
                    break;

                case "z":
                    ypos = sin( model * radians ) * curradius;
                    zpos = cos( model * radians ) * curradius;
                    break;

                case "linex":
                    if ( model < ( modelmax / 2 ) ) { xpos = model * radius; }
                    else                            { xpos = ( model - ( modelmax / 2 ) ) * radius * -1; }
                    break;

                case "liney":
                    if ( model < ( modelmax / 2 ) ) { ypos = model * radius; }
                    else                            { ypos = ( model - ( modelmax / 2 ) ) * radius * -1; }
                    break;

                case "liney+":
                    ypos = model * radius;
                    break;

                case "liney-":
                    ypos = model * radius * -1;
                    break;

                case "linez+":
                    zpos = model * radius;
                    break;

                case "linez-":
                    zpos = model * radius * -1;
                    break;
            }

            switch ( anglesync )
            {
                case "x":   angle[0] = model * radians;                             break;
                case "y":                               angle[1] = model * radians; break;
                case "xy":  angle[0] = model * radians; angle[1] = model * radians; break;
                case "z":   angle[2] = model * radians;                             break;
            }

            spawned = modelspawner( ( basepos + circlepos + ( xpos , ypos , zpos ) ) , id , angle , interval );
            if ( isdefined( optname ) ) { level.lvlstat[optname][level.lvlstat[optname].size] = spawned; }
        }
    }
}



//++++++++++++++++++++++++++++++
// en : set all script parts status for the specified model
// ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
//++++++++++++++++++++++++++++++
setallsetscriptablepartstate( explode )
{
    if ( !isdefined( explode ) )
    {
        self setscriptablepartstate( "fake_trail"       , "on"      , 0 );
        self setscriptablepartstate( "contrails"        , "on"      , 0 );
        self setscriptablepartstate( "wing_trails"      , "on" );
        self setscriptablepartstate( "trail"            , "active"  , 1 );
        self setscriptablepartstate( "trail"            , "neutral" , 1 );
        self setscriptablepartstate( "smoke"            , "on"      , 0 );
        self setscriptablepartstate( "cloud_contrail"   , "base" );
        self setscriptablepartstate( "fast_contrail"    , "base" );
        self setscriptablepartstate( "engine_smoke"     , "base"    , 0 );
        self setscriptablepartstate( "fx"               , "trails"  , 0 );

        self setscriptablepartstate( "lights"           , "active"  , 1 );
        self setscriptablepartstate( "lights"           , "on" );
        self setscriptablepartstate( "lights2"          , "on"      , 0 );
        self setscriptablepartstate( "blinking_lights"  , "on"      , 0 );
        self setscriptablepartstate( "interior_light"   , "on"      , 0 );
        self setscriptablepartstate( "tail_light"       , "red" );
        self setscriptablepartstate( "cockpit_light"    , "on" );
        self setscriptablepartstate( "infil_lights"     , "on" );
        self setscriptablepartstate( "light"            , "light_on" );
        self setscriptablepartstate( "pulse"            , "on"      , 0 );
        self setscriptablepartstate( "glint"            , "on"      , 0 );

        self setscriptablepartstate( "main_thruster"    , "on"      , 0 );
        self setscriptablepartstate( "sub_thruster"     , "on"      , 0 );
        self setscriptablepartstate( "warhead_thruster" , "on"      , 0 );
        self setscriptablepartstate( "thrusters"        , "active"  , 0 );
        self setscriptablepartstate( "engine"           , "on"      , 0 );
        self setscriptablepartstate( "burning"          , "flareup" , 0 );
        self setscriptablepartstate( "exhaustfx"        , "active" );
        self setscriptablepartstate( "propeller"        , "spin_up" , 0 );
        self setscriptablepartstate( "booster_start"    , "enabled" , 0 );
        self setscriptablepartstate( "booster"          , "enabled" , 0 );
        self setscriptablepartstate( "speedBoost"       , "on" );

        self setscriptablepartstate( "bodyfx"           , "on"      , 0 );
        self setscriptablepartstate( "flyby"            , "on"      , 0 );
        self setscriptablepartstate( "anims"            , "capture" , 0 );
        self setscriptablepartstate( "capture"          , "start"   , 0 );
        self setscriptablepartstate( "rotors"           , "on"      , 0 );
        self setscriptablepartstate( "looping_wave"     , "on"      , 0 );
        self setscriptablepartstate( "launch"           , "active"  , 0 );
        self setscriptablepartstate( "launch"           , "on"      , 0 );
        self setscriptablepartstate( "effects"          , "active"  , 0 );
        self setscriptablepartstate( "wind"             , "50"      , 0 );
        self setscriptablepartstate( "base"             , "active"  , 0 );
        self setscriptablepartstate( "fx"               , "base" );
        self setscriptablepartstate( "stability"        , "stable"  , 1 );
    }
    else
    {
        self setscriptablepartstate( "stuck", "active", 0 );
        self setscriptablepartstate( "beacon", "active", 0 );
        self setscriptablepartstate( "effects" , "explode" , 0 );
        self setscriptablepartstate( "launch" , "off" , 0 );
        self setscriptablepartstate( "explode" , "active" , 0 );
        self setscriptablepartstate( "explode" , "on" , 0 );
        self setscriptablepartstate( "impact" , "on" , 0 );
        self setscriptablepartstate( "flare", "on", 0 );
        self setscriptablepartstate( "ground_explosion", "on", 0 );
        self setscriptablepartstate( "air_explosion", "on", 0 );
    }
}



//++++++++++++++++++++++++++++++
// en : generates a bullet of the specified type
// ja : 指定した種類の弾丸を生成する
//++++++++++++++++++++++++++++++
createmagicbullet( owner , weaponid , pstart , pend )
{
    // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate
    // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす
    l_bullet = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( weaponid ) , pstart, pend , owner );
    l_bullet thread onbulletanimationtrigger( weaponid );
    return l_bullet;
}



//++++++++++++++++++++++++++++++
// en : bullet animation execution process after generation
// ja : 生成後の弾丸のアニメーション実行処理
//++++++++++++++++++++++++++++++
onbulletanimationtrigger( weaponid )
{
    switch ( weaponid )
    {
        case "emp_drone_proj_mp":
            // en : play effects and sounds
            // ja : エフェクトとサウンドを再生する
            playfxontag( scripts\engine\utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" ) , self , "tag_origin" );
            playfxontag( scripts\engine\utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx" ) , self , "tag_origin" );
            playfxontag( scripts\engine\utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx" ) , self , "tag_origin" );
            playfxontag( scripts\engine\utility::getfx( "vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx" ) , self , "j_propeller" );
            self playloopsound( "iw8_rc_plane_engine" );
            // en : execute the landing process for various missiles on a sub-thread
            // ja : 各種ミサイルの着弾処理をサブスレッド上で実行する
            self thread onwaitingtypemissileimpact( weaponid );
            break;
            
        // en : executes "ac130" missile landing process and generates an earthquake
        // ja : "ac130" のミサイルの着弾処理の実行、及び地震を発生させる
        case "ac130_105mm_mp":
            earthquake( 0.2 , 1 , self.origin , 1000 );
            self thread onwaitingmissileimpactac130( weaponid );
            break;
        case "ac130_40mm_mp":
            earthquake( 0.1 , 0.5 , self.origin , 1000 );
            self thread onwaitingmissileimpactac130( weaponid );
            break;
        case "ac130_25mm_mp":
            self thread onwaitingmissileimpactac130( weaponid );
            break;

        default:
            // en : set all script parts status for the specified model
            // ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
            self thread setallsetscriptablepartstate( );
            // en : execute the landing process for various missiles on a sub-thread
            // ja : 各種ミサイルの着弾処理をサブスレッド上で実行する
            self thread onwaitingtypemissileimpact( weaponid );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : impact processing for various missiles
// ja : 各種ミサイルの着弾処理
//++++++++++++++++++++++++++++++
onwaitingtypemissileimpact( weaponid )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );
    
    // en : wait until the missile hits
    // ja : ミサイルが着弾するまで待機する
    // self waittill( "missile_stuck" , var_3 , var_4 , var_5 , var_6 , var_7 , missilevector );
    l_result = self scripts\engine\utility::waittill_any_return( "missile_stuck" , "collision" , "explode" , "death"  );

    switch ( weaponid )
    {
        case "emp_drone_proj_mp":
            // en : play explosion sound and play explosion effect at impact coordinates
            // ja : 爆発音を再生し、着弾座標に爆発エフェクトを再生する
            self playsound( "iw8_rc_plane_engine_exp" );
            playfx( scripts\engine\utility::getfx( "vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx" ) , self.origin , anglestoforward( self.angles ) );
            // en : causes area damage at the impact coordinates
            // ja : 着弾座標に範囲ダメージを発生させる
            self radiusdamage( self.origin , 80 , 120 , 80 , self.owner , "MOD_EXPLOSIVE" , makeweapon( "emp_drone_player_mp" ) );
            // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
            // ja : 指定した座標から、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
            earthquake( 0.3 , 1 , self.origin , 2000 );
            // en : end the specified loop sound
            // ja : 指定したループサウンドを終了する
            self stoploopsound( "iw8_rc_plane_engine" );
            break;

        case "white_phosphorus_proj_mp":
            // en : create an explosion effect model
            // ja : 爆発エフェクトモデルを作成する
            l_expeffect = self createentityobject(
                /* notice */ undefined , /* point */ self.origin , /* length */ undefined , /* script */ "script_model" , /* model */ "ks_white_phosphorus_mp" , /* collide */ undefined , /* sync */ undefined , /* angle */ self.angles , /* part */ true ,
                /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
                );

            // en : set all script parts status for the specified model
            // ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
            self thread setallsetscriptablepartstate( /* explode */ true );
            l_expeffect thread setallsetscriptablepartstate( /* explode */ true );
            // en : causes area damage at the impact coordinates
            // ja : 着弾座標に範囲ダメージを発生させる
            self radiusdamage( self.origin , 512 , 500 , 500 , self.owner, "MOD_EXPLOSIVE", makeweapon( weaponid ) );
            // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
            // ja : 指定した座標から、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
            earthquake( 0.5 , 1 , self.origin , 3000 );
            wait 0.1;
            l_expeffect deleteentity( );
            break;

        case "cruise_proj_mp":
            // en : set all script parts status for the specified model
            // ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
            self thread setallsetscriptablepartstate( /* explode */ true );
            // en : causes area damage at the impact coordinates
            // ja : 着弾座標に範囲ダメージを発生させる
            self radiusdamage( self.origin , 600 , 1000 , 1000 , self.owner, "MOD_EXPLOSIVE", makeweapon( weaponid ) );
            // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
            // ja : 指定した座標から、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
            earthquake( 0.5 , 1 , self.origin , 3000 );
            playfxontag( scripts\engine\utility::getfx( "predator_pod_break" ) , self , "tag_missile" );
            wait 0.1;
            break;
    }
    // en : delete the missile that landed
    // ja : 着弾したミサイルを削除する
    self deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : general-purpose animation processing executed when a special missile is launched.
// ja : 特殊なミサイルが発射された時に実行する汎用アニメーション処理
//++++++++++++++++++++++++++++++
onwaitingfiredmissile( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );
    // en: set the specified effect name as the function termination trigger
    // ja: 指定の機能名を関数の終了トリガーとする
    self endon( "finalize_" + optname );

    // en: loop until specified variable no longer exists
    // ja: 指定の変数が存在しなくなるまでループ
    while ( isdefined( self.optstat[optname] ) )
    {
        // en: wait for missile to launch
        // ja: ミサイルが発射されるのを待機する
        self waittill( "missile_fire" , missiledata );

        l_weaponid = "none";

        // en: if the function performing this process is not "moddedbullets"
        // ja: この処理を実行中の機能が "moddedbullets" ではない場合
        if ( optname != "moddedbullets" )
        {
            // en: get information about the weapon you currently have
            // ja: 今持っている武器の情報を取得
            l_currentweapon = self getcurrentweapon( );
            l_weaponid = l_currentweapon.basename;
        }
        // en: if the function performing this process is "moddedbullets"
        // ja: この処理を実行中の機能が "moddedbullets" の場合
        else
        {
            // en: get the currently set ammunition type
            // ja: 設定中の弾薬種類を取得
            if ( isdefined( self.optstat[optname].moddata["bullettype"] ) )
            {
                l_weaponid = self.optstat[optname].moddata["bullettype"];
            }
        }

        // en: change processing depending on weapon type
        // ja: 武器種類によって処理を変更する
        switch ( l_weaponid )
        {
            // en : executes "ac130" missile landing process and generates an earthquake
            // ja : "ac130" のミサイルの着弾処理の実行、及び地震を発生させる
            case "ac130_105mm_mp":
                earthquake( 0.2 , 1 , self.origin , 1000 );
                missiledata thread onwaitingmissileimpactac130( l_weaponid );
                break;
            case "ac130_40mm_mp":
                earthquake( 0.1 , 0.5 , self.origin , 1000 );
                missiledata thread onwaitingmissileimpactac130( l_weaponid );
                break;
            case "ac130_25mm_mp":
                missiledata thread onwaitingmissileimpactac130( l_weaponid );
                break;
        }
    }
}



//++++++++++++++++++++++++++++++
// en : "ac130" missile impact processing
// ja : "ac130" のミサイルの着弾処理
//++++++++++++++++++++++++++++++
onwaitingmissileimpactac130( weaponid )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );
    
    // en : wait until the missile hits
    // ja : ミサイルが着弾するまで待機する
    self waittill( "missile_stuck" , var_3 , var_4 , var_5 , var_6 , var_7 , missilevector );

    // en : generate a shader for the danger zone
    // ja : 危険地帯のシェーダーを生成する
    l_time = 0.5;
    l_range = 100;
    switch ( weaponid )
    {
        case "ac130_105mm_mp": l_time = 1.5; l_range = 500; break;
        case "ac130_40mm_mp": l_time = 1; l_range = 300; break;
    }
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "spawn" , "addspawndangerzone" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "spawn" , "addspawndangerzone" ) ]]( self.origin , l_range , l_range , self.team , l_time , self , 1 );

    // en : create an explosion effect model
    // ja : 爆発エフェクトモデルを作成する
    l_expeffect = self createentityobject(
        /* notice */        undefined ,
        /* spawnlocation */ self.origin ,
        /* spawnlength */   undefined ,
        /* script */        "script_model" ,
        /* objectname */    "ks_ac130_target_mp" ,
        /* objectcollide */ undefined ,
        /* anglesync */     undefined ,
        /* objectangle */   vectortoangles( missilevector )
        );
        
    // en : link the explosion effect model to the missile that landed
    // ja : 爆発エフェクトモデルを着弾したミサイルに紐づける
    l_expeffect linkto( self , "tag_origin" , ( 0 , 0 , 0 ) , ( 0 , 0 , 0 ) );
    l_expeffect setotherent( self );

    // en : setting effect playback status on explosion effect model
    // ja : 爆発エフェクトモデルにエフェクト再生ステータスを設定する
    l_expeffect setscriptablepartstate( self.weapon_name , "on" , 0 );

    // en : destroy or delete the missile that landed
    // ja : 着弾したミサイルを爆破か削除する
    if ( isdefined( self ) )    { self detonate(); }
    else                        { self deleteentity( ); }

    // en : generates an airstrike earthquake at the blast location
    // ja : 爆破地点に空爆用地震を発生させる
    l_expscale = getac130missileexplscale( self.weapon_name );
    l_expradius = getac130missileexplradius( self.weapon_name );
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "shellshock" , "artillery_earthquake" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "shellshock" , "artillery_earthquake" ) ]]( l_expeffect.origin , l_expscale , 0.75 , l_expradius );

    // en : delete the missile that landed
    // ja : 着弾したミサイルを削除する
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 5 );
    l_expeffect deleteentity( );
    self deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : obtained the explosion scale of the "ac130" missile.
// ja : "ac130" のミサイルの爆発スケールを取得
//++++++++++++++++++++++++++++++
getac130missileexplscale( weaponname )
{
    l_expscale = 1.0; 
    switch ( weaponname )
    {
        case "ac130_105mm_mp": l_expscale = 0.75; break;
        case "ac130_40mm_mp": l_expscale = 0.5; break;
        case "ac130_25mm_mp": l_expscale = 0.15; break;
    } 
    return l_expscale;
}



//++++++++++++++++++++++++++++++
// en : get the missile explosion range of "ac130"
// ja : "ac130" のミサイルの爆発範囲を取得
//++++++++++++++++++++++++++++++
getac130missileexplradius( weaponname )
{
    l_expradius = 1.0; 
    switch ( weaponname )
    {
        case "ac130_105mm_mp": l_expradius = 2000; break;
        case "ac130_40mm_mp": l_expradius = 1300; break;
        case "ac130_25mm_mp": l_expradius = 700; break;
    }
    return l_expradius;
}



//++++++++++++++++++++++++++++++
// en : generates a grenade of the specified type
// ja : 指定した種類のグレネードを生成する
//++++++++++++++++++++++++++++++
createmagicgrenade( owner , obj , eye , length , weaponid , pstart , time )
{
    l_angle = undefined;

    if ( isdefined( obj ) )
    {
        if ( eye )  l_angle = obj getplayerangles( );
        else        l_angle = obj.angles;
    }
    else
        l_angle = ( 0 , 0 , 0 );

    // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate
    // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす
    l_grenade = magicgrenademanual( weaponid , pstart , ( anglestoforward( l_angle ) * length ) , time );
    l_grenade setentityowner( owner );
    l_grenade setotherent( owner );
    l_grenade setscriptablepartstate( "launch" , "active" , 0 );
    l_grenade setscriptablepartstate( "trail" , "active" , 0 );
    l_grenade setscriptablepartstate( "effects" , "active", 0 );
    l_grenade setscriptablepartstate( "launch" , "on" , 0 );
    l_grenade thread ongrenadesanimationtrigger( owner , weaponid , time );

    return l_grenade;
}



//++++++++++++++++++++++++++++++
// en : explosion animation execution process after waiting for grenade after generation
// ja : 生成後のグレネードの待機後の爆発アニメーション実行処理
//++++++++++++++++++++++++++++++
ongrenadesanimationtrigger( owner , weaponid , time )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );

    switch ( weaponid )
    {
        case "toma_proj_mp":
            self.explodeent = self createentityobject( /* not */ undefined , /* loc */ self.origin , /* leng */ undefined , /* script */ "script_model" , /* obj */ "ks_toma_strike_missile_mp" , /* coll */ undefined , /* sync */ undefined , /* ang */ undefined );
            self.explodeent linkto( self );
            self.explodeent dontinterpolate( );
            self.explodeent setentityowner( owner );
            self.killcam = self createentityobject( /* not */ undefined , /* loc */ self.origin , /* leng */ undefined , /* script */ "script_model" , /* obj */ "tag_origin" , /* coll */ undefined , /* sync */ undefined , /* ang */ undefined );
            self.killcam linkto( self , "tag_origin" , ( 10 , 0 , 10 ) , ( 0 , 0 , 0 ) );
            self.killcament = self.killcam;
            self setmissileminimapvisible( true );
            break;
    }

    wait time;
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "effects" , "explode" , 0 );
        self setscriptablepartstate( "launch" , "off" , 0 );
        self thread setallsetscriptablepartstate( );
        // self hide( );

        switch ( weaponid )
        {
            case "toma_proj_mp":
                self setmissileminimapvisible( false );
                self.explodeent unlink( );
                self.explodeent setscriptablepartstate( "explode" , "active" , 0 );
                // en : causes area damage centered around the current ammo coordinates.
                // ja : 現在の弾薬の座標を中心に、範囲ダメージを発生させる
                self radiusdamage( self.origin , 500 , 500 , 10 , owner , "MOD_EXPLOSIVE" , makeweapon( weaponid ) );
                // en : causes an earthquake of the specified power within the specified radius around the current ammunition coordinates for the specified number of seconds.
                // ja : 現在の弾薬の座標を中心に、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
                earthquake( 0.25 , 0.2 , self.origin , 700 );
                wait 0.001;
                self.explodeent deleteentity( );
                self.killcam deleteentity( );
                break;

            case "nuke_mp":
                // en : generates a nuclear explosion at the specified coordinates (earthquake generation and damage included)
                // ja : 指定した座標に 核爆発 を発生させる （地震発生・ダメージ込み）
                self thread execnuclearexplosion( self.origin , owner );
                break;
        }
        wait 0.001;
        self deleteentity( );
    }
}



//++++++++++++++++++++++++++++++
// en : for effect processing purposes, make the specified bullet fly in a transparent state from the specified starting point to the specified ending point.
// ja : エフェクト処理用途で、指定した弾を、指定した開始地点から終了地点まで、透明状態で飛ばす
//++++++++++++++++++++++++++++++
createeffectablebullet( owner , length , up , weaponid , end )
{
    // en : get the ammunition generation coordinates (coordinates a specified distance ahead in the direction of the player's viewpoint)
    // ja : 弾薬の生成座標を取得する（プレイヤーの視点方向に 指定分 先の座標）
    l_start = owner getplayerforwardtrace( /* trace */ undefined , /* eye */ true , /* length */ length , /* up */ up );
    if ( !isdefined( end ) )
    {
        // en : get the coordinates of the bullet's impact (coordinates a specified distance ahead in the direction of the player's viewpoint)
        // ja : 弾薬の着弾座標を取得する（プレイヤーの視点方向に 指定分 先の座標）
        end = owner getplayerforwardtrace( /* trace */ undefined , /* eye */ true , /* length */ 1000000 , /* up */ undefined );
    }
    // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
    // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
    l_bullet = createmagicbullet( owner , weaponid , l_start , end );
    // en: if bullets can be generated
    // ja: 弾が生成出来ている場合
    if ( isdefined( l_bullet ) )
    {
        l_bullet.owner = owner;
        // en : keep ammunition out of sight
        // ja : 弾薬は見えないようにする
        l_bullet hide( );
    }
    return l_bullet;
}



//++++++++++++++++++++++++++++++
// en : a general-purpose process that sets the effect that is always performed while the specified ammunition is moving.
// ja : 指定した弾薬が、移動中に常に実行される効果を設定する汎用処理
//++++++++++++++++++++++++++++++
onprocessbulletmovingfx( owner , time , obj , rumble , radi , max , min , weap , eqp , eqt , eqr , se )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    self endon( "death" );

    l_obj = self;
    if ( isdefined( obj ) ) { l_obj = obj; }

    // en : infinite loop until fired ammunition hits and disappears
    // ja : 発射された弾薬が着弾して消えるまで無限ループ
    while ( isdefined( self ) )
    {
        // en : generates a specified type of vibration at the current ammunition coordinates
        // ja : 現在の弾薬の座標に、指定のタイプの振動を発生させる
        if ( isdefined( rumble ) ) { playrumbleonposition( rumble , self.origin ); }

        // en : causes area damage centered around the current ammo coordinates.
        // ja : 現在の弾薬の座標を中心に、範囲ダメージを発生させる
        l_obj radiusdamage( self.origin , radi , max , min , owner , "MOD_EXPLOSIVE" , makeweapon( weap ) );

        // en : causes an earthquake of the specified power within the specified radius around the current ammunition coordinates for the specified number of seconds.
        // ja : 現在の弾薬の座標を中心に、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
        earthquake( eqp , eqt , self.origin , eqr );
        
        // en: play se to current ammo coordinates
        // ja: 現在の弾薬の座標にseを再生させる
        if ( isdefined( se ) ) { playsoundatpos( self.origin , se ); }

        wait time;
    }
}



//++++++++++++++++++++++++++++++
// en : a general-purpose process that sets the effect to be executed when the specified ammunition disappears.
// ja : 指定した弾薬が消失した時に実行される効果を設定する汎用処理
//++++++++++++++++++++++++++++++
ondeathbulletfx( owner , obj , rumble , radi , max , min , weap , eqp , eqt , eqr , se , fx1 , type1 , rep , time1 , rmin , rmax , fx2 , type2 , se2 , del )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    
    // en : wait for yourself to "dead"
    // ja : 自分が「死んだ」ことを待つ
    self waittill( "death" );

    if ( !isdefined( rep ) ) { rep = 1; }

    l_self = self;
    if ( isdefined( obj ) ) { l_self = obj; }
    
    l_location = self.origin;

    for ( i = 0; i < rep; i++ )
    {
        if ( 1 < rep )
        {
            l_fixlocation = l_location + ( randomintrange( rmin , rmax ) , randomintrange( rmin , rmax ) , randomintrange( rmin , rmax ) );
        }
        else
        {
            l_fixlocation = l_location;
        }

        // en : generates a specified type of vibration at the current ammunition coordinates
        // ja : 現在の弾薬の座標に、指定のタイプの振動を発生させる
        if ( isdefined( rumble ) ) { playrumbleonposition( rumble , l_fixlocation ); }

        // en : causes area damage centered around the current ammo coordinates.
        // ja : 現在の弾薬の座標を中心に、範囲ダメージを発生させる
        l_self radiusdamage( l_fixlocation , radi , max , min , owner , "MOD_EXPLOSIVE" , makeweapon( weap ) );

        // en : causes an earthquake of the specified power within the specified radius around the current ammunition coordinates for the specified number of seconds.
        // ja : 現在の弾薬の座標を中心に、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
        earthquake( eqp , eqt , l_fixlocation , eqr );
        
        // en: play se to current ammo coordinates
        // ja: 現在の弾薬の座標にseを再生させる
        if ( isdefined( se ) ) { playsoundatpos( l_fixlocation , se ); }

        // en: play effect to current ammo coordinates
        // ja: 現在の弾薬の座標にエフェクトを再生させる
        playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ fx1 , /* tag */ undefined , /* type */ type1 , /* loop */ undefined , /* base */ l_fixlocation , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );

        if ( isdefined( time1 ) ) { wait time1; }
    }

    if ( !isdefined( fx2 ) ) { return; }
    wait ( time1 * 2 );
    
    // en : generates a specified type of vibration at the current ammunition coordinates
    // ja : 現在の弾薬の座標に、指定のタイプの振動を発生させる
    if ( isdefined( rumble ) ) { playrumbleonposition( rumble , l_location ); }
    // en : causes area damage centered around the current ammo coordinates.
    // ja : 現在の弾薬の座標を中心に、範囲ダメージを発生させる
    l_self radiusdamage( l_location , ( radi * 2) , ( max * 2 ) , ( min * 2 ) , owner , "MOD_EXPLOSIVE" , makeweapon( weap ) );
    // en : causes an earthquake of the specified power within the specified radius around the current ammunition coordinates for the specified number of seconds.
    // ja : 現在の弾薬の座標を中心に、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
    earthquake( ( eqp * 1.5 ) , ( eqt * 1.5 ) , l_location , ( eqr * 1.5 ) );
    // en: play se to current ammo coordinates
    // ja: 現在の弾薬の座標にseを再生させる
    if ( isdefined( se2 ) ) { playsoundatpos( l_location , se2 ); }
    // en: play effect to current ammo coordinates
    // ja: 現在の弾薬の座標にエフェクトを再生させる
    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ fx2 , /* tag */ undefined , /* type */ type2 , /* loop */ undefined , /* base */ l_location , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    
    // en : if deletion is specified, delete the object
    // ja : 削除指定されている場合、オブジェクトを削除する
    if ( isdefined( del ) ) { obj deleteentity( ); }
}



//++++++++++++++++++++++++++++++
// en : a general-purpose process that links a specified object to the generated projectile and unlinks it upon impact.
// ja : 生成された発射弾に指定のオブジェクトをリンクし、着弾時にリンク解除する汎用処理
//++++++++++++++++++++++++++++++
linkobjecttobullet( object , time , del )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    // en: link object to ammunition
    // ja: オブジェクトを弾薬にリンクする
    object linkto( self );

    // en : if time is specified, wait for the time
    // ja : 時間が指定されている場合、時間分待機する
    if ( isdefined( time ) )
    {
        if ( 0 < time )
        {
            wait time;
        }
        else
        {
            while ( true )
            {
                if ( !isdefined( self ) ) { break; }
                wait 0.001;
            }
        }
    }
    // en : wait for the ammunition to land and disappear
    // ja : 弾薬が着弾して消滅するのを待機する
    else
    {
        l_result = self scripts\engine\utility::waittill_any_return( "death" , "missile_stuck" , "collision" , "explode" );
    }

    // en: unlink a object
    // ja: オブジェクトのリンクを解除する
    if ( isdefined( object ) ) { object unlink( ); }
    
    // en : if time is specified, wait for the time
    // ja : 時間が指定されている場合、時間分待機する
    if ( isdefined( time ) )    { wait time; }
    
    // en : if deletion is specified, delete the object
    // ja : 削除指定されている場合、オブジェクトを削除する
    if ( isdefined( del ) )     { object deleteentity( ); }
}



//++++++++++++++++++++++++++++++
// en : generates a nuclear explosion at the specified coordinates (earthquake generation and damage included)
// ja : 指定した座標に 核爆発 を発生させる （地震発生・ダメージ込み）
//++++++++++++++++++++++++++++++
execnuclearexplosion( location , owner )
{
    // en : play the sound of a nuclear explosion starting from the specified coordinates
    // ja : 指定した座標を起点に、核爆発のサウンドを再生させる
    playsoundatpos( location , "iw8_nuke_impact_low" );
    playsoundatpos( location , "iw8_nuke_incoming_blast_wave" );
    playsoundatpos( location , "iw8_nuke_blast" );
    playsoundatpos( location , "iw8_nuke_blast_tail" );
    
    // en : play nuclear explosion effect at specified coordinates
    // ja : 指定した座標に核爆発のエフェクトを再生させる
    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ "nuke_atomize_body"           , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ location, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ "nuke_rolling_death"          , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ location, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ "vfx_nuke_zone_5000_static_s" , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ location, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );

    // en : change the nuclear explosion effect model caused by game mode
    // ja : ゲームモードによって発生させる核爆発エフェクトモデルを変更する
    l_modelid = "";
    if ( getgametype( ) != "br" )  { l_modelid = "ks_nuke_mp"; }
    else                                                    { l_modelid = "ks_nuke_br"; }

    // en : generate an animated model of a nuclear explosion at specified coordinates
    // ja : 指定した座標に核爆発のアニメーションモデルを生成する
    l_nukeanim = self createentityobject(
        /* notice */    undefined ,
        /* location */  location ,
        /* length */    undefined ,
        /* script */    "script_model" ,
        /* model */     l_modelid ,
        /* collide */   undefined ,
        /* sync */      undefined ,
        /* angle */     undefined ,
        /* part */      undefined ,
        /* hpmin */     undefined ,
        /* hpmax */     undefined ,
        /* dmgtype */   undefined ,
        /* dmgfx */     undefined ,
        /* brktype */   undefined ,
        /* brkfx */     undefined ,
        /* dmgse */     undefined ,
        /* brkse */     undefined ,
        /* del */       undefined ,
        /* optname */   undefined
        );
        
    l_nukeanim setscriptablepartstate( "explode" , "on" , 0 );
    
    // en : as an attacker, inflict damage with explosives of the specified weapon type within a radius of 50,000 from the specified coordinates.
    // ja : 指定した座標から半径50000の範囲まで、自分自身が攻撃者として、指定した武器種類の爆発物でダメージを与える
    self radiusdamage( location , 50000 , 50000 , 50000 , owner , "MOD_EXPLOSIVE" , makeweapon( "nuke_mp" ) );
    
    // en : causes an earthquake with a strength of 0.4 for 5 seconds within a radius of 50,000 from the specified coordinates.
    // ja : 指定した座標から半径 50000 の範囲まで、 0.4 の威力の地震を 5秒間 起こす
    earthquake( 0.4 , 5 , location , 50000 );
    wait 5;
    
    // en : as an attacker, inflict damage with explosives of the specified weapon type within a radius of 50,000 from the specified coordinates.
    // ja : 指定した座標から半径50000の範囲まで、自分自身が攻撃者として、指定した武器種類の爆発物でダメージを与える
    self radiusdamage( location , 25000 , 25000 , 25000 , owner , "MOD_EXPLOSIVE" , makeweapon( "nuke_mp" ) );

    // en : causes an earthquake with a strength of 0.3 for 1 seconds within a radius of 50,000 from the specified coordinates.
    // ja : 指定した座標から半径 50000 の範囲まで、 0.3 の威力の地震を 1秒間 起こす
    earthquake( 0.3 , 1 , location , 50000 );

    // en : when the animation of the created nuclear explosion model finishes playing, delete the object.
    // ja : 作成した核爆発モデルのアニメーション再生が終了したら、オブジェクトを削除する
    wait 25;
    l_nukeanim deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : general function to change the amount of movement of the suboption "tracelength" of the specified function
// ja : 本物のケアパッケージを作成するための汎用関数
//++++++++++++++++++++++++++++++
createrealcarepackage( owner , location , angle )
{
    // en : obtain a random killstreak to be registered in the care package contents.
    // ja : ケアパッケージの中身に登録するキルストリークをランダムで取得する
    l_random = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak( );
    l_streakinfo = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname( l_random , 0 );
    // en : create a care package
    // ja : ケアパッケージを作成する
    return scripts\cp_mp\killstreaks\airdrop::createcrate( owner , owner.team , "killstreak" , location , angle , undefined , undefined , [] , l_streakinfo );
}



//++++++++++++++++++++++++++++++
// en : generic functions for setting goal arrival thresholds, speeds, and goal coordinates for helicopters
// ja : ヘリコプターのゴール到着閾値、速度、ゴール座標を設定するための汎用関数
//++++++++++++++++++++++++++++++
updatehelicoptergoalandspeed( near , speed , accel , location , backup )
{
    if ( isdefined( near ) )                        { self setneargoalnotifydist( near ); }
    if ( isdefined( speed ) && isdefined( accel ) ) { self vehicle_setspeed( speed , accel ); }
    if ( isdefined( location ) )                    { self setvehgoalpos( location , true ); }
    
    if ( isdefined( backup ) )
    {
        if ( isdefined( near ) )                        { backup.neargoal = near; }
        if ( isdefined( speed ) && isdefined( accel ) ) { backup.curspeed = speed; backup.curaccel = accel; }
        if ( isdefined( location ) )                    { backup.endlocation = location; }
    }
}



//++++++++++++++++++++++++++++++
// en : general function to change the amount of movement of the suboption "tracelength" of the specified function
// ja : 指定した機能のサブオプション "tracelength" の移動量を変更する汎用関数
//++++++++++++++++++++++++++++++
changetracesize( name , param , func , notice )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array = [];
    l_array[l_array.size] = 1000000;
    l_array[l_array.size] = 100000;
    l_array[l_array.size] = 50000;
    l_array[l_array.size] = 10000;
    l_array[l_array.size] = 5000;
    l_array[l_array.size] = 2500;
    l_array[l_array.size] = 2000;
    l_array[l_array.size] = 1500;
    l_array[l_array.size] = 1000;
    l_array[l_array.size] = 750;
    l_array[l_array.size] = 500;
    l_array[l_array.size] = 400;
    l_array[l_array.size] = 300;
    l_array[l_array.size] = 250;
    l_array[l_array.size] = 200;
    l_array[l_array.size] = 150;
    l_array[l_array.size] = 100;
    l_array[l_array.size] = 75;
    l_array[l_array.size] = 50;

    self changeselfparameter( name , param , undefined , func , l_array , true , undefined , undefined );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Get list / ID
// ja : リスト / ID 取得
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : get the corresponding weapon id in this game from the specified weapon name.
// ja : 指定した武器名からこのゲーム中に相当する武器idを取得する
//++++++++++++++++++++++++++++++
getbulletid( name )
{
    switch ( name )
    {
        case "rpg7":            return "s4_la_palpha42_mp";
        case "lockonmissile1":  return "s4_la_palpha_mp";
        case "nolockmissile1":  return "s4_la_mkilo1_mp";
        case "nolockmissile2":  return "s4_la_m1bravo_mp";
        case "grenadelauncher": return "s4_la_walpha2_mp";
        case "nuke":            return "nuke_mp";
        case "ksmissile1":      return "ac130_proj_mp";
        case "flashgrenade":    return "s4_smoke_usa_m18_mp";
        case "ksmissile1":      return "apache_proj_mp";
        case "ksmissile2":      return "apache_proj_mp";
        case "ksmissile3":      return "white_phosphorus_proj_mp";
        case "ksmissile4":      return "cruise_proj_mp";
        case "ac130_105mm":     return "ac130_105mm_mp";
        case "ac130_40mm":      return "ac130_40mm_mp";
        case "ac130_25mm":      return "ac130_25mm_mp";
        case "frag_grenade":    return "s4_frag_usa_mk2_mp";
        default:                return "s4_la_palpha42_mp";
    }
}



//++++++++++++++++++++++++++++++
// en : get ammo list
// ja : 弾薬リストを取得する
//++++++++++++++++++++++++++++++
getbulletlist( type )
{
    switch ( type )
    {
        case "allbullet":       return level.lvlstat["wplist_allbt"];
        case "allmissile":      return level.lvlstat["wplist_allms"];
        case "standardmissile": return level.lvlstat["wplist_exp"];
        case "specialmissile":  return level.lvlstat["wplist_ks"];
        case "standardgrenade": return level.lvlstat["wplist_stdgr"];
        case "allgrenade":      return level.lvlstat["wplist_allgr"];
        default:                return level.lvlstat["wplist_allbt"];
    }
}



//++++++++++++++++++++++++++++++
// en : get standard model list
// ja : 標準モデルリストを取得する
//++++++++++++++++++++++++++++++
getstandardmodellist( )
{
    return level.lvlstat["modellistall"];
}



//++++++++++++++++++++++++++++++
// en : get standard model list
// ja : 標準乗り物モデルリストを取得する
//++++++++++++++++++++++++++++++
getstandardvehiclemodellist( )
{
    return level.lvlstat["modellistvehicles"];
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Attraction / Large complex Mod generic processing
// ja : アトラクション・大型複合Mod 汎用処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : attraction function monitoring process for players on the cabinet
// ja : アトラクション機能の、筐体のプレイヤーに対するモニタリング処理
//++++++++++++++++++++++++++++++
onattractionplayersmonitoring( optname , seatarray , distance , linktype , noweap )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : when the attraction is destroyed, end the processing in this function
    // ja : アトラクションが破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );
    
    l_seat = [];
    // en: add a structure to each seat variable
    // ja: 各 シート 変数に構造体を追加する
    for ( i = 0; i < seatarray.size; i++ )
    {
        l_seat[i] = spawnstruct( );
        l_seat[i].occupied = false;
    }
    l_canemptyseat = true;

    // en : perform infinite loop processing while attraction exists
    // ja : アトラクションが存在する間、無限ループ処理を行う
    while ( isdefined( self ) )
    {
        // en : if there is information that there are vacant seats
        // ja : 空き座席があるという情報がある場合
        if ( l_canemptyseat )
        {
            // en : check the seating status of all seats
            // ja : 全座席の着席状況を調べる
            l_canemptyseat = false;
            for ( i = 0; i < l_seat.size; i++ )
            {
                if ( l_seat[i].occupied == false ) { l_canemptyseat = true; break; }
            }
        }

        // en: get information on all participating players
        // ja: 参加中の全プレイヤー情報を取得
        foreach( player in level.players )
        {
            // en : if there are empty seats
            // ja : 空き座席がある場合
            if ( l_canemptyseat )
            {
                // en: when the distance between the player and attraction is less than specified distance
                // ja: プレイヤー と アトラクション の距離が 指定の距離 未満の時に
                if ( distance( self.origin , player.origin ) < distance )
                {
                    // en: if the player is not yet on board attraction
                    // ja: まだプレイヤーが アトラクション に搭乗していない場合
                    if ( !isdefined( player.optstat[optname + "_ride"] ) )
                    {
                        // en: display the specified text in the center of the screen
                        // ja: 画面中央に指定の文章を表示する
                        player showcentermessage( player.curlang , "notice" , "usetoride" , undefined , undefined , undefined );

                        // en: while the "use" button is pressed
                        // ja: "使用" ボタンが押されている間
                        if ( player getkeycodepressed( "buttonuse" , "buttonuse" ) )
                        {
                            // en: choose seats at random
                            // ja: 座席をランダムで選ぶ
                            l_random = randomintrange( 0 , l_seat.size );
                            
                            // en: if no one is boarding the seat yet
                            // ja: まだその座席に誰も搭乗していない場合
                            if ( l_seat[l_random].occupied == false )
                            {
                                // en: remember the player's coordinates before boarding
                                // ja: プレイヤーの搭乗前の座標を記憶する
                                player.optstat[optname + "_origin"] = player.origin;

                                // en: set player posture to crouching, making prone and running impossible
                                // ja: プレイヤーの姿勢を しゃがみ に設定し、伏せと走りを不可能にする
                                player setstance( "crouch" );
                                player allowsprint( false );
                                player allowprone( false );

                                // en: link (sync) players to seats in attraction
                                // ja: プレイヤーを アトラクション の座席にリンク（同期）する
                                switch ( linktype )
                                {
                                    case "default":     player playerlinkto( seatarray[l_random] ); break;
                                    case "delta":       player playerlinktodelta( seatarray[l_random] ); break;
                                    case "absolute":    player playerlinktoabsolute( seatarray[l_random] , "tag_origin" ); break;
                                }

                                // en: disable the weapon if its use is prohibited
                                // ja: 武器の使用が禁止されている場合、武器を無効化する
                                if ( isdefined( noweap ) )
                                {
                                    player disableweapons( );
                                    player disableoffhandweapons( );
                                }

                                // en: assume that you are currently boarding that seat.
                                // ja: その座席に搭乗中であるとする
                                player.optstat[optname + "_ride"] = l_random;
                                l_seat[l_random].occupied = true;

                                // en: notify players when they board an attraction
                                // ja: プレイヤーがアトラクションに搭乗したことを通知する
                                level notify( optname + "_rideplayer" );
                                player notify( optname + "_rideplayer" );

                                wait 0.5;
                            }
                        }
                    }
                }
            }
            
            // en: if the player is already on board attraction
            // ja: 既にプレイヤーが アトラクション に搭乗している場合
            if ( isdefined( player.optstat[optname + "_ride"] ) )
            {
                // en: display the specified text in the center of the screen
                // ja: 画面中央に指定の文章を表示する
                player showcentermessage( player.curlang , "notice" , "usetoride" , undefined , undefined , undefined );

                // en: when the "lethal" button is pressed
                // ja: 「リーサル」ボタンが押されたら
                if ( player getkeycodepressed( "buttonlethal" , "buttonlethal" ) )
                {
                    // en: unlink players and seats
                    // ja: プレイヤーと座席のリンクを解除する
                    player unlink( );

                    // en: set player posture to standing, making prone and running possible
                    // ja: プレイヤーの姿勢を 立ち に設定し、伏せと走りを可能にする
                    player setstance( "stand" );
                    player allowsprint( true );
                    player allowprone( true );
                    
                    // en: return player coordinates to pre-boarding coordinates
                    // ja: プレイヤーの座標を搭乗前の座標に戻す
                    // player setorigin( player.optstat[optname + "_origin"] );
                    
                    // en: activate a weapon if its use was prohibited
                    // ja: 武器の使用が禁止されていた場合、武器を有効化する
                    if ( isdefined( noweap ) )
                    {
                        player enableweapons( );
                        player enableoffhandweapons( );
                    }
                    
                    // en: assume that the seat is not occupied.
                    // ja: その座席に未搭乗であるとする
                    l_seat[player.optstat[optname + "_ride"]].occupied = false;
                    player.optstat[optname + "_ride"] = undefined;
                    player.optstat[optname + "_origin"] = undefined;
                    
                    // en : if there are no empty seats, create an empty seat because the current player got off.
                    // ja : 空き座席が無かった場合、今のプレイヤーが下りたため空き座席を作る
                    if ( !l_canemptyseat ) { l_canemptyseat = true; }

                    // en: notify players when they board an attraction
                    // ja: プレイヤーがアトラクションから降りたことを通知する
                    level notify( optname + "_rideoutplayer" );
                    player notify( optname + "_rideoutplayer" );

                    wait 0.5;
                }
            }
        }

        wait 0.05;
    }
}



//++++++++++++++++++++++++++++++
// en : process for disembarking players who are still boarding the chassis when the specified function is finished
// ja : 指定の機能が終了された時に、まだ筐体に搭乗しているプレイヤーを降車させる処理
//++++++++++++++++++++++++++++++
ondestroydetachplayers( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    
    // en : wait until the specified function is finished
    // ja : 指定の機能が終了されるまで待機する
    level waittill( "end_lobby_" + optname );

    // en: get information on all participating players
    // ja: 参加中の全プレイヤー情報を取得
    foreach( player in level.players )
    {
        // en: if the player is still on board
        // ja: まだプレイヤーが搭乗している場合
        if ( isdefined( player.optstat[optname + "_ride"] ) )
        {
            // en: unlink players and seats
            // ja: プレイヤーと座席のリンクを解除する
            player unlink( );

            // en: set player posture to standing, making prone and running possible
            // ja: プレイヤーの姿勢を 立ち に設定し、伏せと走りを可能にする
            player setstance( "stand" );
            player allowsprint( true );
            player allowprone( true );
            
            // en: activate a weapon
            // ja: 武器を有効化する
            player enableweapons( );
            player enableoffhandweapons( );

            // en: return player coordinates to pre-boarding coordinates
            // ja: プレイヤーの座標を搭乗前の座標に戻す
            // player setorigin( player.optstat[optname + "_origin"] );
            
            // en: assume that the seat is not occupied.
            // ja: その座席に未搭乗であるとする
            player.optstat[optname + "_ride"] = undefined;
            player.optstat[optname + "_origin"] = undefined;
        }
    }

}



//++++++++++++++++++++++++++++++
// en : general-purpose processing that destroys the physical object created when the specified function ends
// ja : 指定した機能が終了された時に 生成された物理オブジェクト を破壊する汎用処理
//++++++++++++++++++++++++++++++
onwaitingdestroyentities( delmode , optname , sfxid , expfxid , discfxid , eqpower , eqtime , eqrange , exptime , delay , lastnuke , nukepoint , owner , objarray , objdelete , listarray , listdelete , dualarray )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    // en : terminate processing when changing the termination method
    // ja : 終了方式を変更する場合に処理を終了する
    level endon( "update_mode_" + optname );

    // en : wait for the specified function to finish
    // ja : 指定した機能が終了されるのを待機する
    level waittill( "end_lobby_" + optname );

    // en : prevent re-creation while being deleted
    // ja : 削除中は再作成できないようにする
    level.lvlstat[optname + "deleting"] = true;

    // en : if the deletion method is random, decide the method randomly
    // ja : 削除方式がランダムの場合は、ランダムで方法を決める
    l_delmode = delmode;
    if ( l_delmode == "random" )
    {
        if ( scripts\engine\utility::cointoss( ) )  { l_delmode = "explode"; }
        else                                        { l_delmode = "discrete"; }
    }

    // en : unlink, perform physical processing, and perform various effects on specified physical objects.
    // ja : 指定した物理オブジェクトに対して、リンクの解除、物理処理、各種エフェクトを実行する
    launchentitydestroyphysics( listarray , listdelete , objarray , objdelete , sfxid , expfxid , discfxid , exptime , eqpower , eqtime , eqrange , l_delmode , delay , dualarray );

    // en : if a nuclear explosion is specified and if it is an explosive type, a nuclear explosion will occur at the end.
    // ja : 核爆発の指定がある場合、且つ爆破式の場合に、最後に核爆発を起こす
    if ( isdefined( lastnuke ) )
    {
        if ( l_delmode == "explode" )
        {
            owner thread execnuclearexplosion( nukepoint , owner );
        }
    }

    // en : wait for the specified time
    // ja : 指定時間分待機する
    wait delay;
    
    // en : delete the specified physical object
    // ja : 指定した物理オブジェクトを削除する
    foreach ( listdata in listarray )
    {
        deleteentities( listdata    , undefined );
    }
    foreach ( objdata in objarray )
    {
        deleteentities( undefined   , objdata );
    }

    // en : now that the deletion has been completed, it can be recreated.
    // ja : 削除が完了したため再作成できるようにする
    level.lvlstat[optname + "deleting"] = undefined;
}



//++++++++++++++++++++++++++++++
// en : general-purpose processing that removes links, performs physical processing, and performs various effects on specified physical objects.
// ja : 指定した物理オブジェクトに対して、リンクの解除、物理処理、各種エフェクトを実行する汎用処理
//++++++++++++++++++++++++++++++
launchentitydestroyphysics( listarray , listdelete , objarray , objdelete , sfxid , expfxid , discfxid , exptime , eqpower , eqtime , eqrange , delmode , delay , dualarray )
{
    l_time = 0;

    // en : when the deletion method is discrete
    // ja : 削除方式が離散式の場合
    if ( delmode == "discrete" )
    {
        // en : get random time required for entity to move
        // ja : エンティティが移動するための所要時間をランダムで取得する
        l_time = randomfloatrange( 1 , ( delay + 1 ) );
    }
    
    // en : if object exists
    // ja : オブジェクトが存在する場合
    if ( isdefined( objarray ) )
    {
        for ( i = 0; i < objarray.size; i++ )
        {
            if ( isdefined( level.lvlstat[objarray[i]] ) )
            {
                // en : performs a deletion effect on the specified object according to the specified mode
                // ja : 指定したオブジェクトに対して、指定したモードに応じた削除エフェクトを実行する
                execentitieseffectivity( level.lvlstat[objarray[i]] , objdelete[i] , sfxid , expfxid , discfxid , exptime , eqpower , eqtime , eqrange , delmode , l_time );
            }
            if ( objdelete[i] == true )
            {
                level.lvlstat[objarray[i]] = undefined;
            }
        }
    }

    // en : if list exists
    // ja : リストが存在する場合
    if ( isdefined( listarray ) )
    {
        // en : if the list format is not a multiple array
        // ja : リスト形式が多重配列ではない場合
        if ( !isdefined( dualarray ) )
        {
            for ( listnum = 0; listnum < listarray.size; listnum++ )
            {
                if ( isdefined( level.lvlstat[listarray[listnum]] ) )
                {
                    // en : for all entities in the list
                    // ja : リスト内の全てのエンティティに対して
                    foreach ( entityobj in level.lvlstat[listarray[listnum]] )
                    {
                        // en : performs a deletion effect on the specified object according to the specified mode
                        // ja : 指定したオブジェクトに対して、指定したモードに応じた削除エフェクトを実行する
                        execentitieseffectivity( entityobj , listdelete[listnum] , sfxid , expfxid , discfxid , exptime , eqpower , eqtime , eqrange , delmode , l_time );
                    }
                    // en : when deleting the list after deleting the object, destroy the variable
                    // ja : オブジェクト消去後にリストを削除する場合、変数を破棄する
                    if ( listdelete[listnum] == true )
                    {
                        level.lvlstat[listarray[listnum]] = undefined;
                    }
                }
            }
        }
        // en : when list format is multiple array
        // ja : リスト形式が多重配列の場合
        else
        {
            // en : when list format is multiple array
            // ja : リストが存在する場合
            if ( isdefined( level.lvlstat[listarray] ) )
            {
                for ( i = 0; i < level.lvlstat[listarray].size; i++ )
                {
                    // en : for all entities in the list
                    // ja : リスト内の全てのエンティティに対して
                    foreach ( entityobj in level.lvlstat[listarray][i] )
                    {
                        // en : performs a deletion effect on the specified object according to the specified mode
                        // ja : 指定したオブジェクトに対して、指定したモードに応じた削除エフェクトを実行する
                        execentitieseffectivity( entityobj , listdelete , sfxid , expfxid , discfxid , exptime , eqpower , eqtime , eqrange , delmode , l_time );
                    }
                }
                // en : when deleting the list after deleting the object, destroy the variable
                // ja : オブジェクト消去後にリストを削除する場合、変数を破棄する
                if ( listdelete == true )
                {
                    level.lvlstat[listarray] = undefined;
                }
            }
        }
    }
}



//++++++++++++++++++++++++++++++
// en : performs a deletion effect on the specified object according to the specified mode
// ja : 指定したオブジェクトに対して、指定したモードに応じた削除エフェクトを実行する
//++++++++++++++++++++++++++++++
execentitieseffectivity( obj , listdel , sfxid , expfxid , discfxid , exptime , eqpower , eqtime , eqrange , delmode , time )
{
    // en : unlink (synchronize) entities
    // ja : エンティティのリンク（同期）を解除する
    obj unlink( );

    // en : branch processing depending on deletion method
    // ja : 削除方式によって処理を分岐
    switch ( delmode )
    {
        // en : in case of an explosion on the spot
        // ja : その場で爆発の場合
        case "explode":
            // en : invoke physical processing on an entity
            // ja : エンティティに物理処理を起動する
            obj physicslaunchserver( obj.origin , ( 0 , 0 , 0 ) );
            // en : instantly explode an entity on the spot
            // ja : エンティティをその場で即爆破する
            obj thread launchentityeffectivity( delmode , undefined , sfxid , expfxid , exptime , eqpower , eqtime , eqrange );
            break;
            
        // en : when it explodes after being dispersed
        // ja : 離散してから爆発する場合
        case "discrete":
            // en : get random coordinates for the entity to move to
            // ja : エンティティが移動する先の座標をランダムで取得する
            l_endlocation = obj.origin + ( randomintrange( -5000 , 5000 ) , randomintrange( -5000 , 5000 ) , randomintrange( 1000 , 10000 ) );
            // en : get the angle to which the entity moves
            // ja : エンティティが移動する先の角度を取得する
            l_angle = vectortoangles( l_endlocation - obj.origin );
            // en : move an entity to the specified coordinates over the specified time
            // ja : エンティティを指定の座標に、指定の時間をかけて移動させる
            obj moveto( l_endlocation , time );
            // en : rotate an entity to a specified angle and for a specified amount of time
            // ja : エンティティを指定の角度に、指定の時間をかけて回転させる
            obj rotateto( l_angle , time );
            // en : blow up an entity after moving it into the air
            // ja : エンティティを空中に移動後に爆破する
            obj thread launchentityeffectivity( delmode , time , sfxid , discfxid , exptime , eqpower , eqtime , eqrange );
            break;
    }

    // en : wait for the specified time
    // ja : 指定時間分待機する
    wait exptime;
    // en : if you want to delete objects in that list now, delete
    // ja : そのリスト内のオブジェクトをこの場で削除する場合、削除する
    if ( listdel == true )
    {
        obj deleteentity( );
    }
}



//++++++++++++++++++++++++++++++
// en : executes various effects on the specified object after the specified number of seconds has elapsed.
// ja : 指定したオブジェクトに対して、指定秒数経過後に各種エフェクトを実行する
//++++++++++++++++++++++++++++++
launchentityeffectivity( delmode , time , sfxid , fxid , exptime , eqpower , eqtime , eqrange )
{
    // en : wait if a time is specified
    // ja : 時間指定がある場合、待機する
    if ( isdefined( time ) )
    {
        wait time;
    }

    // en : play the specified sound effect
    // ja : 指定したサウンドエフェクトを再生する
    playsoundatpos( self.origin , sfxid );
    // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
    // ja : 指定した座標 から 指定した半径の範囲 まで 指定した威力の地震 を 指定した秒数 起こす
    earthquake( eqpower , eqtime , self.origin , eqrange );
    // en : play the specified effect
    // ja : 指定したエフェクトを再生する
    self thread playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ fxid , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ self.origin , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    
    // en : if it is a discrete type, delete it after playing the effect.
    // ja : 離散式の場合、エフェクト再生後に削除する
    if ( delmode == "discrete" )
    {
        wait 0.01;
        self deleteentity( );
    }
}



//++++++++++++++++++++++++++++++
// en : delete the specified physical object
// ja : 指定した物理オブジェクトを削除する
//++++++++++++++++++++++++++++++
deleteentities( listdata , objdata )
{
    // en : if list exists
    // ja : リストが存在する場合
    if ( isdefined( listdata ) )
    {
        if ( isdefined( level.lvlstat[listdata] ) )
        {
            // en : for all entities in the list
            // ja : リスト内の全てのエンティティに対して
            foreach ( entityobj in level.lvlstat[listdata] )
            {
                // en : delete an entity
                // ja : エンティティを削除する
                entityobj deleteentity( );
            }
            level.lvlstat[listdata] = undefined;
        }
    }
    
    // en : if object exists
    // ja : オブジェクトが存在する場合
    if ( isdefined( objdata ) )
    {
        if ( isdefined( level.lvlstat[objdata] ) )
        {
            // en : delete an entity
            // ja : エンティティを削除する
            level.lvlstat[objdata] deleteentity( );
            level.lvlstat[objdata] = undefined;
        }
    }
}



//++++++++++++++++++++++++++++++
// en : after waiting the specified number of seconds, generate the specified model at the specified coordinates and angle.
// ja : 指定した秒数分待機した後、指定したモデルを、指定した座標・角度で生成する
//++++++++++++++++++++++++++++++
modelspawner( origin , modelid , angles , time , collision )
{
    if( isdefined( time ) ) { wait time; }

    obj = self createentityobject(
        /* notice */ undefined , /* point */ origin , /* length */ undefined , /* script */ "script_model" , /* model */ modelid , /* collide */ true , /* sync */ undefined , /* angle */ angles , /* part */ true ,
        /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
        );

    if ( getentarray( ).size >= 2000)
    {
        self iprintlnbold( "^1error^7: please delete some other structures" );
        obj deleteentity( );
    }

    return obj;
}



//++++++++++++++++++++++++++++++
// en : create multiple specified models by shifting them at the specified angle at the same time.
// ja : 指定したモデルを、指定した角度で、複数同時にずらして作成する
//++++++++++++++++++++++++++++++
spawnmultiplemodels( origin , p1 , p2 , p3 , xx , yy , zz , model , angles , length , time )
{
	l_array = [];
	for ( a = 0; a < p1; a++ ) for ( b = 0; b < p2; b++ ) for ( c = 0; c < p3; c++ )
	{
		l_array[l_array.size] = self createentityobject(
            /* notice */    undefined ,
            /* point */     undefined , //( origin[0] + ( a * xx ) , origin[1] + ( b * yy ) , origin[2] + ( c * zz ) ) ,
            /* length */    ( length * ( b + 1 ) ) ,
            /* script */    "script_model" , 
            /* model */     model ,
            /* collide */   true ,
            /* sync */      undefined ,
            /* angle */     angles ,
            /* part */      true ,
            /* hpmin */     undefined ,
            /* hpmax */     undefined ,
            /* dmgtype */   undefined ,
            /* dmgfx */     undefined ,
            /* brktype */   undefined ,
            /* brkfx */     undefined ,
            /* dmgse */     undefined ,
            /* brkse */     undefined ,
            /* del */       undefined ,
            /* optname */   undefined
            );

		wait time;

	}

	return l_array;
}



//++++++++++++++++++++++++++++++
// en : apply physical processing to the specified object after the specified time has elapsed.
// ja : 指定したオブジェクトに対して、指定した時間経過後に、物理処理を与える
//++++++++++++++++++++++++++++++
delayedfall( num , num1 )
{
	if( isdefined( num1 ) )
	{
		wait num1;
	}
	if( isdefined( self ) )
	{
		self physicslaunchserver( self.origin , ( 0 , 0 , 0 ) );
	}
	wait num;
	if( isdefined( self ) )
	{
		self deleteentity();
	}
}



//++++++++++++++++++++++++++++++
// en : create flag object at specified coordinates from string token
// ja : 文字列トークンから指定の座標に旗オブジェクトを作成する
//++++++++++++++++++++++++++++++
createflagfromstrtok( optname , location , data , zaxis , anglefix )
{
    l_location = strtok( data , "," );
    for ( i = 0; i < l_location.size; i += 2 )
    {
        l_angles = self.angles;
        if ( !anglefix ) { l_angles = ( 90 , 0 , 0 ); }
        l_origin = location + ( int( l_location[i] ) , int( l_location[i + 1] ) , zaxis );

        l_modelid = "";
        l_random = randomintrange( 0 , 3 );
        switch ( l_random )
        {
            case 0: l_modelid = "prop_flag_neutral"; break;
            case 1: l_modelid = "ctf_game_flag_east"; break;
            case 2: l_modelid = "ctf_game_flag_west"; break;
        }

        l_obj = self createentityobject(
            /* notice */ undefined , /* point */ l_origin , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ undefined , /* sync */ undefined , /* angle */ l_angles , /* part */ undefined ,
            /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
            );

        if ( isdefined( l_obj ) )
        {
            level.lvlstat[optname + "_flag"][level.lvlstat[optname + "_flag"].size] = l_obj;
        }
    }
}



//++++++++++++++++++++++++++++++
// en : create a care package object from a string token at specified coordinates
// ja : 文字列トークンから指定の座標にケアパッケージオブジェクトを作成する
//++++++++++++++++++++++++++++++
createcpboxfromstrtok( optname , location , data , zaxis , p )
{
    l_location = strtok( data , "," );
    for ( i = 0; i < l_location.size; i += 2 )
    {
        l_angles = self.angles;
        if ( !p ) { l_angles = ( 90 , 0 , 0 ); }
        l_origin = location + ( int( l_location[i] ) , int( l_location[i + 1] ) , zaxis );
        l_modelid = "vm_equip_gen_care_package_00";

        l_obj = self createentityobject(
            /* notice */ undefined , /* point */ l_origin , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ undefined , /* sync */ undefined , /* angle */ l_angles , /* part */ undefined ,
            /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
            );

        if ( isdefined( l_obj ) )
        {
            level.lvlstat[optname + "_box"][level.lvlstat[optname + "_box"].size] = l_obj;
        }
    }
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Other generic functions
// ja : その他汎用関数
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : change language
// ja : 言語を変更する
//++++++++++++++++++++++++++++++
changelanguageenforallplayers( )
{
    ln_en = level.moddef.ln_en;

    // en: get information on all participating players
    // ja: 参加中の全プレイヤー情報を取得
    for ( targetuser = 0; targetuser < level.players.size; targetuser++ )
    {
        // en: if the target player is the host, proceed to the next player without processing.
        // ja: 操作する対象のプレイヤーがホストの場合は、処理せずに次のプレイヤーに進む
        if ( level.players[targetuser] ishost( ) )
        {
            level.players[targetuser] showcentermessage( self.curlang , "notice" , "cannothost" , undefined , undefined , undefined );
            continue;
        }

        // en: change current language to english
        // ja: 現在の言語を英語に変更する
        level.players[targetuser].curlang = ln_en;

        if ( isdefined( level.players[targetuser].modsystem ) && ( level.players[targetuser].modsystem.menuactive == true ) )
        {
            // en: update the text displayed in the mod menu
            // ja: モッドメニューの表示するテキストを更新する
            level.players[targetuser] thread modmenutextupdate( );
        }
    }
}



//++++++++++++++++++++++++++++++
// en : change language
// ja : 言語を変更する
//++++++++++++++++++++++++++++++
changelanguagejaforallplayers( )
{
    ln_ja = 1;

    // en: get information on all participating players
    // ja: 参加中の全プレイヤー情報を取得
    for ( targetuser = 0; targetuser < level.players.size; targetuser++ )
    {
        // en: if the target player is the host, proceed to the next player without processing.
        // ja: 操作する対象のプレイヤーがホストの場合は、処理せずに次のプレイヤーに進む
        if ( level.players[targetuser] ishost( ) )
        {
            level.players[targetuser] showcentermessage( self.curlang , "notice" , "cannothost" , undefined , undefined , undefined );
            continue;
        }

        // en: change current language to japanese
        // ja: 現在の言語を日本語に変更する
        level.players[targetuser].curlang = ln_ja;

        if ( isdefined( level.players[targetuser].modsystem ) && ( level.players[targetuser].modsystem.menuactive == true ) )
        {
            // en: update the text displayed in the mod menu
            // ja: モッドメニューの表示するテキストを更新する
            level.players[targetuser] thread modmenutextupdate( );
        }
    }
}



//++++++++++++++++++++++++++++++
// en : generic function to teleport players
// ja : プレイヤーをテレポートさせるための汎用関数
//++++++++++++++++++++++++++++++
execteleportto( user1 , user2 )
{
    // en: if the target player is the same, the operation will not be possible and the process will end.
    // ja: 操作する対象のプレイヤーが同一の場合、操作できないため処理を終了する
    if ( user1 == user2 )
    {
        return;
    }

    // en : teleports the specified opponent to the specified opponent's coordinates.
    // ja : 指定した相手を、指定した相手の座標にテレポートさせる
    user1 setorigin( user2.origin );

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    user1 showcentermessage( user1.curlang , "notice" , "teleporttohim" , undefined , user2.name , undefined );
    user2 showcentermessage( user2.curlang , "notice" , "teleporttome"  , undefined , user1.name , undefined );
}



//++++++++++++++++++++++++++++++
// en : display text when an item with an unimplemented function is selected
// ja : 未実装機能の項目が選択された時に文章を表示する
//++++++++++++++++++++++++++++++
unimplementedfunction( )
{
    self showcentermessage( self.curlang , "notice" , "unimplementedfunction" , undefined , undefined , undefined );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Other various mods
// ja : その他各種 Mod
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : change the background animation of the mod menu
// ja : モッドメニューの背景アニメーションを変更する
//++++++++++++++++++++++++++++++
onfmodmenubackgroundanimation( )
{
    // en : create or destroy a "switchbackgroundanimation" variable
    // ja : "switchbackgroundanimation" 変数の作成か破棄を行う
    self switchonfselffunction(
        /* optname */       "switchbackgroundanimation" ,
        /* optfunc */       ::emptyfunction ,
        /* message */       undefined ,
        /* optarg1 */       undefined ,
        /* optarg2 */       undefined ,
        /* optarg3 */       undefined ,
        /* optarg4 */       undefined ,
        /* optarg5 */       undefined ,
        /* optarg6 */       undefined ,
        /* optarg7 */       undefined ,
        /* weaponid */      undefined ,
        /* inprojectile */  undefined ,
        /* onlygroup */     undefined ,
        /* attachmentid */  undefined ,
        /* camoid */        undefined ,
        /* camogroup */     undefined ,
        /* dualmode */      undefined
        );
}



//++++++++++++++++++++++++++++++
// en : delete the last object created with the function "createentityobject"
// ja : 機能 "createentityobject" で作成したオブジェクトの内、最後のオブジェクトを削除する
//++++++++++++++++++++++++++++++
execdeletelastobject( )
{
    l_optname1 = "deletelastobject";
    l_optname2 = "_objectcount";
    l_optname3 = l_optname1 + l_optname2;

    if ( !isdefined( level.lvlstat[l_optname3] ) )  return;
    if ( level.lvlstat[l_optname3].size <= 0 )      return;
    
    l_num = level.lvlstat[l_optname3].size - 1;
    
    if ( isdefined( level.lvlstat[l_optname3][l_num] ) )
        level.lvlstat[l_optname3][l_num] deleteentity( );
    
    level.lvlstat[l_optname3][l_num] = undefined;
    
    // en: display the text "[notification] delete object: object name" in the center of the screen
    // ja: 画面中央に「[通知] オブジェクト削除 : オブジェクト名」という文章を表示する
    self showcentermessage( self.curlang , "notice" , l_optname1 , undefined , l_num , undefined );
}



//++++++++++++++++++++++++++++++
// en : toggle the paused state of the timer
// ja : タイマーの一時停止状態を切り替える
//++++++++++++++++++++++++++++++
onfpausetimer( )
{
    // en : change the pausing state of the lobby timer according to the existence state of the "pausetimer" variable.
    // ja : "pausetimer" 変数の存在状態に合わせて、 ロビーのタイマーの一時停止状態 を変更する
    self switchonflevelfunction(
        /* optname */   "pausetimer" ,
        /* optfunc */   ::emptyfunction ,
        /* message */   undefined ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined ,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
    wait 0.05;
    if ( isdefined( level.lvlstat["pausetimer"] ) )
    {
        level scripts\mp\gamelogic::pausetimer( );
    }
    else
    {
        level scripts\mp\gamelogic::resumetimer( );
    }
}



//++++++++++++++++++++++++++++++
// en : restart game lobby
// ja : ゲームロビーを再起動する
//++++++++++++++++++++++++++++++
execfastrestrat( )
{
    level thread scripts\mp\gamelogic::restart( );
}



//++++++++++++++++++++++++++++++
// en : exit the game lobby
// ja : ゲームロビーを終了する
//++++++++++++++++++++++++++++++
execendgame( )
{
    level thread scripts\mp\gamelogic::forceend( );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "sendmessageloop"
// ja : 機能 "sendmessageloop" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsendmessageloop( )
{
    l_optname = "sendmessageloop";
    l_optname2 = l_optname + "_message";
    if ( !isdefined( self.optstat[l_optname2] ) )
    {
        self.optstat[l_optname2] = "yourpromotionmessage2";
    }

    // en : execute execsendmessageloop( ) or exit depending on the existence state of the "sendmessageloop" variable
    // ja : "sendmessageloop" 変数の存在状態に合わせて execsendmessageloop( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   l_optname ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   l_optname ,
        /* optarg2 */   /* optfunc */   ::execsendmessageloop ,
        /* optarg3 */   /* looptime */  3 ,
        /* optarg4 */                   undefined ,
        /* optarg5 */                   undefined ,
        /* optarg6 */                   undefined ,
        /* optarg7 */                   undefined ,
        /* weaponid */                  undefined ,
        /* inprojectile */              undefined ,
        /* onlygroup */                 undefined ,
        /* attachmentid */              undefined ,
        /* camoid */                    undefined ,
        /* camogroup */                 undefined ,
        /* dualmode */                  undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "sendmessageloop"
// ja : 機能 "sendmessageloop" の実行中の処理
//++++++++++++++++++++++++++++++
execsendmessageloop( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: get information on all participating players
            // ja: 参加中の全プレイヤー情報を取得
            foreach( player in level.players )
            {
                player showcentermessage( player.curlang , undefined , self.optstat["sendmessageloop_message"] , undefined , undefined , undefined );
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            self.optstat["sendmessageloop_message"] = undefined;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : change the message displayed by the function "sendmessageloop"
// ja : 機能 "sendmessageloop" で表示するメッセージを変更する
//++++++++++++++++++++++++++++++
execsetloopmessage( )
{
    self.optstat["sendmessageloop" + "_message"] = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].subparam;
    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "updatemessagetext" , undefined , self.optstat["sendmessageloop" + "_message"] , undefined );
}



//++++++++++++++++++++++++++++++
// en : teleport the opponent to your location
// ja : 相手を自分の場所にテレポートさせる
//++++++++++++++++++++++++++++++
execteleporttomesingle( )
{
    execteleportto( level.players[self.modsystem.menuplayer] , self );
}



//++++++++++++++++++++++++++++++
// en : teleport yourself to the other person's location
// ja : 自分を相手の場所にテレポートさせる
//++++++++++++++++++++++++++++++
execteleporttohimsingle( )
{
    execteleportto( self , level.players[self.modsystem.menuplayer] );
}



//++++++++++++++++++++++++++++++
// en : teleport all players to your location
// ja : 全プレイヤーを自分の場所にテレポートさせる
//++++++++++++++++++++++++++++++
execteleporttomeforallplayers( )
{
    // en: get information on all participating players
    // ja: 参加中の全プレイヤー情報を取得
    for ( targetuser = 0; targetuser < level.players.size; targetuser++ )
    {
        execteleportto( level.players[targetuser] , self );
    }
}








































































































































































//      main()
//      {
//          level thread initproject( );
//      }
//      
//      
//      
//      
//      
//      
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : project initialization process
//      // ja : プロジェクト初期化処理
//      //++++++++++++++++++++++++++++++
//      initproject( )
//      {
//          if ( isdefined( level.initproject ) ) { return; }
//          level.initproject = true;
//          
//      
//          // en : subthread onplayerconnect( ) for the entire room
//          // ja : 部屋全体に onplayerconnect( ) をサブスレッドで実行する
//          level thread onplayerconnected( );
//      
//      
//          //initgsc( );
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : processing when a player connects to a room
//      // ja : プレイヤーが部屋に接続してきた時の処理
//      //++++++++++++++++++++++++++++++
//      onplayerconnected( )
//      {
//          // en : this function ends processing when "the match is over"
//          // ja : この関数は「試合が終了した」場合に処理を終了する
//          level endon( "game_ended" );
//      
//      
//          // en : inside this is infinite loop processing
//          // ja : この中は無限ループ処理
//          while ( true )
//          {
//              // en : wait for "a player has connected" from the entire room and receive player information
//              // ja : 部屋全体から「プレイヤーが接続してきた」ことを待ち、プレイヤー情報を受け取る
//              level waittill( "connected", player );
//      
//              // en : run onplayerspawned( ) in a subthread for connected players
//              // ja : 接続されたプレイヤーに対して onplayerspawned( ) をサブスレッドで実行する
//              player thread onplayerspawned( );
//          }
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : processing that occurs when a player spawns in-game
//      // ja : プレイヤーがインゲーム上にスポーンした時に実行される処理
//      //++++++++++++++++++++++++++++++
//      onplayerspawned( )
//      {
//          // en : this function ends the process if "you disconnect from the room"
//          // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
//          self endon( "disconnect" );
//      
//      
//          // en: define a variable array for each item.
//          // ja: 各項目の変数配列を定義する
//          self.optstat = [];
//      
//          self.curlang = 0;
//      
//          // en: start button monitoring process
//          // ja: ボタンモニタリング処理を開始する
//          self thread onbuttonmonitoring( );
//      
//          while ( true )
//          {
//              // en : wait for yourself to "spawn in-game"
//              // ja : 自分が「インゲーム上にスポーンした」ことを待つ
//              //self waittill( "spawned_player" );
//      
//              // en : display a "welcome" message every time you spawn
//              // ja : スポーン時に毎回「ようこそ」メッセージを表示する
//              self showwelocomemessage( );
//      
//              wait 5;
//          }
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : display a "welcome" message
//      // ja : 「ようこそ」メッセージを表示する
//      //++++++++++++++++++++++++++++++
//      showwelocomemessage( )
//      {
//          // en : get the translation equivalent to the specified text id in the current language
//          // ja : 現在の言語で、指定したテキストidに相当する翻訳を取得する
//          l_textwelcome           = getmttext( self.curlang , "welcometo" );
//          l_textprojectname       = getmttext( self.curlang , "projectname" );
//          l_textmoddedlobby       = getmttext( self.curlang , "moddedlobby" );
//          
//          l_textyourmenustatus    = getmttext( self.curlang , "yourmenustatus" );
//          l_textverifiedlevel     = getmttext( self.curlang , "host" );
//          l_textmenudescription   = getmttext( self.curlang , "modmenuopendescription" );
//      
//          // en : display a message in the kill log area at the bottom left of your screen(the kill log has 6 lines, so fill in 3 blank lines)
//          // ja : 自分の画面左下、キルログ部分にメッセージを表示する（キルログは6行あるため、3行空白で埋める）
//          self iprintln( "" );
//          self iprintln( "" );
//          self iprintln( "" );
//          self iprintln( l_textmenudescription );
//          self iprintln( l_textyourmenustatus + l_textverifiedlevel );
//          self iprintln( "^3Welcome to " + "^3P^7roject ^5H^7iN^1A^7tyu" + " ^3modded lobby." );
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : button monitoring process
//      // ja : ボタンモニタリング処理
//      //++++++++++++++++++++++++++++++
//      onbuttonmonitoring( )
//      {
//          // en : this function ends the process if "you disconnect from the room"
//          // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
//          self endon( "disconnect" );
//      
//          // en: infinite loop only while button monitoring processing is running
//          // ja: ボタンモニタリング処理を実行中の間だけ無限ループ
//          while ( true )
//          {
//              if ( self adsbuttonpressed( ) )
//              {
//                  // en: if the "aim" button and "melee attack" button are pressed at the same time
//                  // ja: 「エイム」ボタンと「近接攻撃」ボタンが同時に押されたら
//                  if ( self meleebuttonpressed( ) )
//                  {
//                      // en: scroll item up
//                      // ja: 項目を上にスクロールする
//                      //self modmenuscrollup( );
//                      self onffunc( "godmode & infinityammo" , ::execnohitmode , 0.05 );
//                  }
//                  // en: while the tactical throw button is pressed
//                  // ja: タクティカルを投げるボタンが押されている間
//                  else if ( self jumpbuttonpressed( ) )
//                  {
//                      // en: scroll item up
//                      // ja: 項目を上にスクロールする
//                      //self modmenuscrollup( );
//                      self onffunc( "modded bullets" , ::execmoddedbullets , 0.05 );
//                  }
//                  // en: while the "use" button is pressed and the "aim" button is not pressed
//                  // ja: "使用" ボタンが押されていて、且つ "エイム" ボタンが押されていない間
//                  else if ( self sprintbuttonpressed( ) )
//                  {
//                      // en: scroll item down
//                      // ja: 項目を下にスクロールする
//                      //self modmenuscrolldown( );
//                      //self onffunc( "infinityammo" , &execinfinityammo , 0.01 );
//                      self onffunc( "forge mode" , ::execadvancedforgemode , 0.01 );
//                  }
//                  // en: while the "use" button is pressed and the "aim" button is pressed
//                  // ja: "使用" ボタンが押されていて、且つ "エイム" ボタンが押されている間
//                  else if ( self usebuttonpressed( ) )
//                  {
//                      // en: scroll item down
//                      // ja: 項目を下にスクロールする
//                      //self modmenuscrolldown( );
//                      self onffunc( "bind noclip" , ::execbindnoclip , 0.05 );
//                  }
//              }
//      
//              wait 0.001;
//          }
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : general-purpose functions for performing functions that perform loop processing
//      // ja : ループ処理を行う機能を実行するための汎用関数
//      //++++++++++++++++++++++++++++++
//      onffunc( optname , optfunc , looptime )
//      {
//          if ( !isdefined( self.optstat[optname] ) )
//          {
//              self iprintlnbold( optname + " ^2on" );
//              self.optstat[optname] = true;
//              self thread execloopfunction( optname , optfunc , looptime );
//          }
//          else
//          {
//              self iprintlnbold( optname + " ^1off" );
//              self.optstat[optname] = undefined;
//          }
//      
//          // en: wait 0.15 seconds
//          // ja: 0.15秒待機する
//          wait 0.15;
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : general-purpose functions for performing functions that perform loop processing
//      // ja : ループ処理を行う機能を実行するための汎用関数
//      //++++++++++++++++++++++++++++++
//      execloopfunction( optname , optfunc , looptime )
//      {
//          // en : this function ends the process if "you disconnect from the room"
//          // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
//          self endon( "disconnect" );
//          // en : this function ends processing if "you die"
//          // ja : この関数は「自分が死んだ」場合に処理を終了する
//          //self endon( "death" );
//      
//      
//          // en: use the specified function name as the function termination trigger
//          // ja: 指定の機能の初期化処理を行う
//          self [[ optfunc ]]( optname , 0 );
//      
//          // en: loop until specified variable no longer exists
//          // ja: 指定の変数が存在しなくなるまでループ
//          while ( isdefined( self.optstat[optname] ) )
//          {
//              // en: performs in-loop processing of specified function
//              // ja: 指定の機能のループ中処理を行う
//              self [[ optfunc ]]( optname , 1 );
//      
//              // en: wait for the specified time
//              // ja: 指定時間分待機する
//              wait looptime;
//          }
//          
//          // en: perform termination processing for the specified function
//          // ja: 指定の機能の終了処理を行う
//          self [[ optfunc ]]( optname , 2 );
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : processing during execution of the function "nohitmode"
//      // ja : 機能 "nohitmode" の実行中の処理
//      //++++++++++++++++++++++++++++++
//      execnohitmode( optname , procstage )
//      {
//          // en: running process
//          // ja: 実行中処理
//          if ( procstage == 1 )
//          {
//              //self enableinvulnerability( );
//              // en: increase health to 99999999
//              // ja: 体力を 99999999 に上げる
//              self.maxhealth  = 99999999;
//              self.health     = self.maxhealth;
//              
//              // en: get information about the weapon you currently have
//              // ja: 今持っている武器の情報を取得
//              l_curweap = self getcurrentweapon( );
//              // en: set the number of remaining bullets to the maximum number of bullets for that weapon.
//              // ja: 残弾数をその武器の最大弾数にする
//              self setweaponammostock( l_curweap , 99999 );//l_curweap.maxammo );
//              // en: set the number of bullets to the maximum number of bullets for that weapon.
//              // ja: 装弾数をその武器の最大弾数にする
//              self setweaponammoclip( l_curweap , 99999 ); //l_curweap.clipsize );
//          }
//          // en: end processing
//          // ja: 終了処理
//          else if ( procstage == 2 )
//          {
//              //self disableinvulnerability( );
//              self.maxhealth  = 100;
//              self.health     = self.maxhealth;
//          }
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : processing during execution of the function "bindnoclip"
//      // ja : 機能 "bindnoclip" の実行中の処理
//      //++++++++++++++++++++++++++++++
//      execbindnoclip( optname , procstage )
//      {
//          linkname = optname + "linkobject";
//      
//          // en: running process
//          // ja: 実行中処理
//          if ( procstage == 1 )
//          {
//              // en: if the "tactical throw" button and "melee attack" button are pressed at the same time
//              // ja: "タクティカル投球" ボタンと、「近接攻撃」ボタンが同時に押されたら
//              if ( ( self secondaryoffhandbuttonpressed( ) && self meleebuttonpressed( ) ) )
//              {
//                  // en: if the object used for flight processing has not been created yet
//                  // ja: 飛行処理に使うオブジェクトがまだ生成されてない場合
//                  if ( !isdefined( self.optstat[linkname] ) )
//                  {
//                      // en: create a transparent object used for flight processing with your own coordinates and angle
//                      // ja: 飛行処理に使う透明なオブジェクトを、自分の座標、角度で作成する
//                      self.optstat[linkname] = spawn( "script_origin" , self.origin );
//                      self.optstat[linkname].angles = self.angles;
//                      
//                      // en: link (sync) yourself to the object you created
//                      // ja: 自分を作成したオブジェクトにリンク（同期）する
//                      self playerlinkto( self.optstat[linkname] );
//      
//                      // en: display the specified text in the center of the screen
//                      // ja: 画面中央に指定の文章を表示する
//                      self iprintlnbold( optname + " ^4active" );
//                  }
//                  // en: if the object used for flight processing has already been generated
//                  // ja: 飛行処理に使うオブジェクトが生成済みの場合
//                  else
//                  {
//                      // en: unlink (synchronize) yourself from the created object
//                      // ja: 作成したオブジェクトから自分のリンク（同期）を解除する
//                      // stopnoclip( linkname );
//                      
//                      // en: if the object used for flight processing has already been generated
//                      // ja: 飛行処理に使うオブジェクトが生成済みの場合
//                      if ( isdefined( self.optstat[linkname] ) )
//                      {
//                          // en: unlink (synchronize) yourself from the created object
//                          // ja: 作成したオブジェクトから自分のリンク（同期）を解除する
//                          self unlink( );
//                          
//                          // en: delete the created object
//                          // ja: 作成したオブジェクトを削除する
//                          self.optstat[linkname] delete( );
//                          self.optstat[linkname] = undefined;
//                      }
//      
//                      // en: display the specified text in the center of the screen
//                      // ja: 画面中央に指定の文章を表示する
//                      self iprintlnbold( optname + " ^6deactive" );
//                  }
//      
//                  wait 0.3;
//              }
//      
//              // en: if the object used for flight processing has already been generated
//              // ja: 飛行処理に使うオブジェクトが生成済みの場合
//              if ( isdefined( self.optstat[linkname] ) )
//              {
//                  l_angles = self getplayerangles( );
//                  self.optstat[linkname].angles = l_angles;
//      
//                  l_forward = anglestoforward( l_angles );
//                  l_left = anglestoforward( l_angles - ( 0 , 90 , 0 ) );
//                  l_top = anglestoforward( l_angles - ( 90 , 0 , 0 ) );
//                  l_movement = self getnormalizedmovement( );
//                  l_speed = 30;
//                  
//                  // en: when the "run/hold your breath" button is pressed
//                  // ja: 「走る・息止め」ボタンが押されたら
//                  if ( self sprintbuttonpressed( ) )
//                      l_speed = 350;
//                  
//                  l_vector = ( 0 * l_top ) + ( l_movement[0] * l_forward ) + ( l_movement[1] * ( l_left[0] , l_left[1] , 0 ) );
//                  l_scale =  ( l_vector[0] * l_speed , l_vector[1] * l_speed , l_vector[2] * l_speed ); // vectorscale( l_vector , l_speed );
//                  self.optstat[linkname].origin = self.origin + l_scale;
//              }
//          }
//          // en: end processing
//          // ja: 終了処理
//          else if ( procstage == 2 )
//          {
//              // en: unlink (synchronize) yourself from the created object
//              // ja: 作成したオブジェクトから自分のリンク（同期）を解除する
//              //self stopnoclip( linkname );
//              
//              // en: if the object used for flight processing has already been generated
//              // ja: 飛行処理に使うオブジェクトが生成済みの場合
//              if ( isdefined( self.optstat[linkname] ) )
//              {
//                  // en: unlink (synchronize) yourself from the created object
//                  // ja: 作成したオブジェクトから自分のリンク（同期）を解除する
//                  self unlink( );
//                  
//                  // en: delete the created object
//                  // ja: 作成したオブジェクトを削除する
//                  self.optstat[linkname] delete( );
//                  self.optstat[linkname] = undefined;
//              }
//          }
//      }
//      
//      
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : processing during execution of the function "modded bullet"
//      // ja : 機能「改造弾」の実行中の処理
//      //++++++++++++++++++++++++++++++
//      execmoddedbullets( optname , procstage )
//      {
//          if ( self attackbuttonpressed( ) )
//          {
//              eye = self geteye( );
//              scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon("s4_la_palpha42_mp") , eye , eye + anglestoforward( self getplayerangles( ) ) * 100000 , self );
//              //pos = trace::ray_trace( eye , eye + anglestoforward( self getplayerangles( ) ) * 100000 , self );
//              //weapon_utility::_magicbullet( makeweapon("hover_jet_proj_mp") , eye , pos["position"] , self );
//          }
//      }
//      //++++++++++++++++++++++++++++++
//      // en : processing during execution of the function "advanced forge mode"
//      // ja : 機能「advanced forge mode」の実行中の処理
//      //++++++++++++++++++++++++++++++
//      execadvancedforgemode( optname , procstage )
//      {
//          // en: if the "tactical throw" button and "melee attack" button are pressed at the same time
//          // ja: "タクティカル投球" ボタンと、「近接攻撃」ボタンが同時に押されたら
//          if ( ( self secondaryoffhandbuttonpressed( ) && self usebuttonpressed( ) ) )
//          {
//              obj = spawn( "script_model" , self geteye( ) + anglestoforward( self getplayerangles( ) ) * 100 );
//              obj.angles = self.angles;
//              obj setmodel( "vm_equip_gen_care_package_00" );
//              obj solid( );
//              // en: display the specified text in the center of the screen
//              // ja: 画面中央に指定の文章を表示する
//              self iprintlnbold( "crate ^2spawned!" );
//          }
//          else if ( self adsbuttonpressed( ) )
//          {
//              while ( self adsbuttonpressed( ) )
//              {
//                  result = scripts\engine\trace::_bullet_trace( self geteye( ) , self geteye( ) + anglestoforward( self getplayerangles( ) ) * 100000 , 1 , self );
//                  if ( isdefined( result["entity"] ) )
//                  {
//                      while ( self adsbuttonpressed( ) )
//                      {
//                          pos = self geteye( ) + anglestoforward( self getplayerangles( ) ) * 100;
//                          if ( self attackbuttonpressed( ) )
//                              result["entity"] delete( );
//                          else if ( self fragbuttonpressed( ) )
//                          {
//                              obj = spawn( "script_model" , pos );
//                              obj.angles = self.angles;
//                              obj setmodel( result["entity"].model );
//                              obj solid( );
//                          }
//                          else
//                          {
//                              result["entity"].origin = pos;
//                              //result["entity"] setorigin( result["entity"].origin );
//                              result["entity"].angles = self.angles;
//                              self iprintlnbold( "obj = ^5" + result["entity"].model );
//                          }
//                          wait 0.01;
//                      }
//                  }
//                  wait 0.01;
//              }
//          }
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : returns the corresponding translation for the current language setting.
//      // ja : 現在の言語設定から対応する翻訳を返す
//      //++++++++++++++++++++++++++++++
//      getlangdata( cur , en , ja , cn , ru , de )
//      {
//          switch ( cur )
//          {
//              case 0: return en;
//              case 1: return ja;
//              case 2: return cn;
//              case 3: return ru;
//              case 4: return de;
//              default: return en;
//          }
//      }
//      
//      
//      
//      //++++++++++++++++++++++++++++++
//      // en : returns the corresponding translation from the current language and specified text id
//      // ja : 現在の言語と指定のテキストidから、該当する翻訳文を返す
//      //++++++++++++++++++++++++++++++
//      getmttext( selflang , textid , usegamepad )
//      {
//          switch ( textid )
//          {
//              case "buttonaction":           return "[{+action}]";
//              case "buttonaction1":          return "[{+actionslot 1}]";
//              case "buttonaction2":          return "[{+actionslot 2}]";
//              case "buttonaction3":          return "[{+actionslot 3}]";
//              case "buttonaction4":          return "[{+actionslot 4}]";
//              case "buttonads":              return "[{+speed_throw}]";
//              case "buttonattack":           return "[{+attack}]";
//              case "buttonchangeseat":       return "[{+switchseat}]";
//              case "buttonlethal":           return "[{+frag}]";
//              case "buttontactical":         return "[{+smoke}]";
//              case "buttonjump":             return "[{+gostand}]";
//              case "buttonmelee":            return "[{+melee}]";
//              case "buttonoffhandspecial":   return "[{+offhandspecial}]";
//              case "buttonreload":           return "[{+usereload}]";
//              case "buttonsprint":           return "[{+breath_sprint}]";
//              case "buttonstance":           return "[{+stance}]";
//              case "buttonuse":              return "[{+activate}]";
//              case "buttonvehicleattack":    return "[{+vehicleattack}]";
//              case "buttonvehiclemoveup":    return "[{+vehiclemoveup}]";
//              case "buttonweaponswitch":     return "[{+weapnext_inventory}]";
//      
//              case "projectname":
//                  return getlangdata( selflang ,
//                      "^7project ^5h^7in^1a^7tyu" ,
//                      "^7プロジェクト ^5ひ^7な^1ち^7ゅ" ,
//                      "^5h^7in^1a^7tyu ^7計畫" ,
//                      "^7проект ^5огонь^1на^7чуу" ,
//                      "^7projekt ^5h^7in^1a^7tyu" );
//      
//      
//              case "welcometo":
//                  return getlangdata( selflang ,
//                      "^3welcome to " ,
//                      "^3ようこそ、" ,
//                      "^3欢迎，" ,
//                      "^3добро пожаловать," ,
//                      "^3willkommen bei" );
//      
//                  
//              case "moddedlobby":
//                  return getlangdata( selflang ,
//                      " ^3modded lobby." ,
//                      " ^3の改造部屋へ。" ,
//                      " ^3前往改造后的房间。" ,
//                      " ^3в отремонтированную комнату." ,
//                      " ^3modifizierte lobby." );
//      
//                  
//              case "yourmenustatus":
//                  return getlangdata( selflang ,
//                      "^3" + self.name + " status : " ,
//                      "^3" + self.name + "の権限階級 : " ,
//                      "^3" + self.name + " 地位 : " ,
//                      "^3" + self.name + " положение дел : " ,
//                      "^3" + self.name + " status : " );
//      
//                  
//              case "modmenuopendescription":
//                  return getlangdata( selflang ,
//                      "^3open mod menu to press^1 "            + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + "^3." ,
//                      "^3モッドメニューは^1 "                   + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + " ^3で開けます。" ,
//                      "^3按^1 "                                + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + " ^3可以打开模组菜单。" ,
//                      "^3меню мода можно открыть, нажав^1 "    + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + "." ,
//                      "^3öffne das mod-menü, um zu drücken^1 " + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + "^3." );
//      
//              case "modmenucontroldescription":
//                  if ( usegamepad == true )
//                  {
//                      return getlangdata( selflang ,
//                          "^3scroll "       + getmttext( selflang , "buttonaction3" ) + " " + getmttext( selflang , "buttonaction2" ) + " ^3| decide " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3| back " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3スクロール "   + getmttext( selflang , "buttonaction3" ) + " " + getmttext( selflang , "buttonaction2" ) + " ^3｜決定 "   + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜戻る " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3滚动 "         + getmttext( selflang , "buttonaction3" ) + " " + getmttext( selflang , "buttonaction2" ) + " ^3｜决定 "   + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜后退 " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3прокрутка "    + getmttext( selflang , "buttonaction3" ) + " " + getmttext( selflang , "buttonaction2" ) + " ^3｜решать " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜назад " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3scrollen "    + getmttext( selflang , "buttonaction3" ) + " " + getmttext( selflang , "buttonaction2" ) + " ^3｜entscheiden " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜zurück " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) );
//                  }
//                  else
//                  {
//                      return getlangdata( selflang ,
//                          "^3scroll "       + getmttext( selflang , "buttontactical" ) + " , " + getmttext( selflang , "buttonuse" ) + " ^3| decide " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3| back " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3スクロール "   + getmttext( selflang , "buttontactical" ) + " , " + getmttext( selflang , "buttonuse" ) + " ^3｜決定 "   + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜戻る " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3滚动 "         + getmttext( selflang , "buttontactical" ) + " , " + getmttext( selflang , "buttonuse" ) + " ^3｜决定 "   + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜后退 " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3прокрутка "    + getmttext( selflang , "buttontactical" ) + " , " + getmttext( selflang , "buttonuse" ) + " ^3｜решать " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜назад " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) ,
//                          "^3scrollen "    + getmttext( selflang , "buttontactical" ) + " , " + getmttext( selflang , "buttonuse" ) + " ^3｜entscheiden " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonuse" ) + " ^3｜zurück " + getmttext( selflang , "buttonads" ) + " ^3+ " + getmttext( selflang , "buttonmelee" ) );
//                  }
//      
//              case "host":
//                  return getlangdata( selflang ,
//                      "^7[^5host^7]" ,
//                      "^7[^5ホスト^7]" ,
//                      "^7[^5主持人^7]" ,
//                      "^7[^5хозяин^7]" ,
//                      "^7[^5gastgeber^7]" );
//      
//      
//      
//              default:
//                  if ( !isdefined( textid ) ) textid = "";
//                  return textid;
//          }
//          
//          if ( !isdefined( textid ) ) textid = "";
//          return textid;
//      }
//      
//      
//      
//      
//      
//      
//      
//      
//      
//      
//      
//      