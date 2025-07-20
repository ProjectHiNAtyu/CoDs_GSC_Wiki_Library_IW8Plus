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
// en : display text and execute functions according to the on/off state of specified variables.
// ja : 指定の変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfselffunction( optname , optfunc , message , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6  , optarg7 , weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , dualmode , lvlcheck )
{
    scripts\mp\art::switchonfselffunction( optname , optfunc , message , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6  , optarg7 , weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , dualmode , lvlcheck );
}



//++++++++++++++++++++++++++++++
// en : general-purpose functions for performing functions that perform loop processing
// ja : ループ処理を行う機能を実行するための汎用関数
//++++++++++++++++++++++++++++++
execloopfunction( optname , optfunc , looptime )
{
    scripts\mp\art::execloopfunction( optname , optfunc , looptime );
}



//++++++++++++++++++++++++++++++
// en : display text and execute functions for the specified player according to the on/off state of the specified variable.
// ja : 指定したプレイヤーに対して、指定の変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfplayerfunction( optname , optfunc )
{
    scripts\mp\art::switchonfplayerfunction( optname , optfunc );
}



//++++++++++++++++++++++++++++++
// en : display text and execute functions for all players according to the on/off state of the specified variable.
// ja : 全プレイヤーに対して、指定の変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfallplayersfunction( optname , optfunc , oneway , withhost )
{
    scripts\mp\art::switchonfallplayersfunction( optname , optfunc , oneway , withhost );
}



//++++++++++++++++++++++++++++++
// en : generic function to disable duplicate functions if they are activated
// ja : 重複している機能が起動している場合、無効化させるための汎用関数
//++++++++++++++++++++++++++++++
checkduplicatefunction( name , func )
{
    scripts\mp\art::checkduplicatefunction( name , func );
}



//++++++++++++++++++++++++++++++
// en : obtain input judgment results tailored to keyboard and controller
// ja : キーボード、コントローラーに合わせた入力判定結果を取得する
//++++++++++++++++++++++++++++++
getkeycodepressed( kbtype , controllertype )
{
    return scripts\mp\art::getkeycodepressed( kbtype , controllertype );
}



//++++++++++++++++++++++++++++++
// en : creates the specified object at a specified multiple distance from your eye.
// ja : 自分の眼先から指定した倍数先の距離に、指定したオブジェクトを作成
//++++++++++++++++++++++++++++++
createentityobject( notice , location , length , script , model , collide , sync , angle , part , hpmin , hpmax , dmgtype , dmgfx , brktype , brkfx , dmgse , brkse , del , optname )
{
    return scripts\mp\art::createentityobject( notice , location , length , script , model , collide , sync , angle , part , hpmin , hpmax , dmgtype , dmgfx , brktype , brkfx , dmgse , brkse , del , optname );
}



//++++++++++++++++++++++++++++++
// en : general-purpose processing to display the fixed phrase "[category] sentence 1: sentence 2"
// ja : "[カテゴリ] 文章1 : 文章2" という定型文を表示するための汎用処理
//++++++++++++++++++++++++++++++
showcentermessage( selflang , tagname , msg1 , msg2 , content , prefix )
{
    scripts\mp\art::showcentermessage( selflang , tagname , msg1 , msg2 , content , prefix );
}



//++++++++++++++++++++++++++++++
// en : a generic function to remove a specified object (for world entity list interference)
// ja : 指定されたオブジェクトを削除するための汎用関数（ワールドエンティティリスト干渉用）
//++++++++++++++++++++++++++++++
deleteentity( )
{
    scripts\mp\art::deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : get the coordinates that are multiples ahead of the specified coordinates
// ja : 指定の座標に対して、倍数分先の座標を取得する
//++++++++++++++++++++++++++++++
vectorscale( location , length )
{
    return scripts\mp\art::vectorscale( location , length );
}



//++++++++++++++++++++++++++++++
// en : generates a bullet of the specified type
// ja : 指定した種類の弾丸を生成する
//++++++++++++++++++++++++++++++
createmagicbullet( owner , weaponid , pstart , pend )
{
    return scripts\mp\art::createmagicbullet( owner , weaponid , pstart , pend );
}



//++++++++++++++++++++++++++++++
// en : get ammo list
// ja : 弾薬リストを取得する
//++++++++++++++++++++++++++++++
getbulletlist( type )
{
    return scripts\mp\art::getbulletlist( type );
}


//++++++++++++++++++++++++++++++
// en : select self variables related to the specified function in order from the specified array
// ja : 指定の機能に関する self 変数を、指定の配列内から順に選択する
//++++++++++++++++++++++++++++++
changeselfparameter( optname1 , optname2 , prefix , optfunc , arraydata , notice , lastend , random )
{
    scripts\mp\art::changeselfparameter( optname1 , optname2 , prefix , optfunc , arraydata , notice , lastend , random );
}



//++++++++++++++++++++++++++++++
// en : displays text and executes sub-functions associated with the main function according to the on/off state of specified variables.
// ja : 指定の変数のオンオフ状態に合わせて、文章の表示を行い、メイン機能に付随するサブ機能の実行を行う
//++++++++++++++++++++++++++++++
switchonfselfsubfunction( optname1 , optname2 , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 )
{
    scripts\mp\art::switchonfselfsubfunction( optname1 , optname2 , optdata , optfunc , notice , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6 , optarg7 );
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
// en : get the corresponding weapon id in this game from the specified weapon name.
// ja : 指定した武器名からこのゲーム中に相当する武器idを取得する
//++++++++++++++++++++++++++++++
getbulletid( name )
{
    return scripts\mp\art::getbulletid( name );
}



//++++++++++++++++++++++++++++++
// en : delete the specified object after the specified number of seconds
// ja : 指定されたオブジェクトを、指定された秒数経過後に削除する
//++++++++++++++++++++++++++++++
deleteaftertime( time )
{
    scripts\mp\art::deleteaftertime( time );
}



//++++++++++++++++++++++++++++++
// en : play the effect starting from the specified object
// ja : 指定したオブジェクトを起点にエフェクトを再生する
//++++++++++++++++++++++++++++++
playeffecttoobject( time , obj , fx , tag , type , loop , base , fix , angle , range , stop , owner )
{
    scripts\mp\art::playeffecttoobject( time , obj , fx , tag , type , loop , base , fix , angle , range , stop , owner );
}



//++++++++++++++++++++++++++++++
// en : get the gsc color code from the specified rgb color balance
// ja : 指定したrgb色バランスからgsc用カラーコードを取得する
//++++++++++++++++++++++++++++++
dividecolor( rvalue , gvalue , bvalue )
{
    return scripts\mp\art::dividecolor( rvalue , gvalue , bvalue );
}



//++++++++++++++++++++++++++++++
// en : create a hud (on-screen ui) with specified elements
// ja : 指定した要素でhud（画面上のui）を作成する
//++++++++++++++++++++++++++++++
createrectangle( xalignment , yalignment , xpoint , ypoint , xscale , yscale , colorvalue , shadertype , sortvalue , alphavalue , publish )
{
    return scripts\mp\art::createrectangle( xalignment , yalignment , xpoint , ypoint , xscale , yscale , colorvalue , shadertype , sortvalue , alphavalue , publish );
}



//++++++++++++++++++++++++++++++
// en : set all script parts status for the specified model
// ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
//++++++++++++++++++++++++++++++
setallsetscriptablepartstate( explode )
{
    scripts\mp\art::setallsetscriptablepartstate( explode );
}



//++++++++++++++++++++++++++++++
// en : obtain a trace in the front direction
// ja : 正面方向へのトレースを取得する
//++++++++++++++++++++++++++++++
getplayerforwardtrace( trace , eye , length , up )
{
    return scripts\mp\art::getplayerforwardtrace( trace , eye , length , up );
}



//++++++++++++++++++++++++++++++
// en : get standard model list
// ja : 標準モデルリストを取得する
//++++++++++++++++++++++++++++++
getstandardmodellist( )
{
    return scripts\mp\art::getstandardmodellist( );
}



//++++++++++++++++++++++++++++++
// en : empty function that displays nothing
// ja : 何も表示しない空の関数
//++++++++++++++++++++++++++++++
emptyfunction( )
{

}



//++++++++++++++++++++++++++++++
// en : give specified weapon
// ja : 指定した武器を与える
//++++++++++++++++++++++++++++++
provideweapon( weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , akimbo , changehand , notice , onlygetid , onlygetdata )
{
    return scripts\mp\art::provideweapon( weaponid , inprojectile , onlygroup , attachmentid , camoid , camogroup , akimbo , changehand , notice , onlygetid , onlygetdata );
}



//++++++++++++++++++++++++++++++
// en : generates a grenade of the specified type
// ja : 指定した種類のグレネードを生成する
//++++++++++++++++++++++++++++++
createmagicgrenade( owner , obj , eye , length , weaponid , pstart , time )
{
    return scripts\mp\art::createmagicgrenade( owner , obj , eye , length , weaponid , pstart , time );
}



//++++++++++++++++++++++++++++++
// en : general function to change the amount of movement of the suboption "tracelength" of the specified function
// ja : 指定した機能のサブオプション "tracelength" の移動量を変更する汎用関数
//++++++++++++++++++++++++++++++
changetracesize( name , param , func , notice )
{
    scripts\mp\art::changetracesize( name , param , func , notice );
}



//++++++++++++++++++++++++++++++
// en : for effect processing purposes, make the specified bullet fly in a transparent state from the specified starting point to the specified ending point.
// ja : エフェクト処理用途で、指定した弾を、指定した開始地点から終了地点まで、透明状態で飛ばす
//++++++++++++++++++++++++++++++
createeffectablebullet( owner , length , up , weaponid , end )
{
    return scripts\mp\art::createeffectablebullet( owner , length , up , weaponid , end );
}



//++++++++++++++++++++++++++++++
// en : a general-purpose process that links a specified object to the generated projectile and unlinks it upon impact.
// ja : 生成された発射弾に指定のオブジェクトをリンクし、着弾時にリンク解除する汎用処理
//++++++++++++++++++++++++++++++
linkobjecttobullet( object , time , del )
{
    scripts\mp\art::linkobjecttobullet( object , time , del );
}



//++++++++++++++++++++++++++++++
// en : a general-purpose process that sets the effect that is always performed while the specified ammunition is moving.
// ja : 指定した弾薬が、移動中に常に実行される効果を設定する汎用処理
//++++++++++++++++++++++++++++++
onprocessbulletmovingfx( owner , time , obj , rumble , radi , max , min , weap , eqp , eqt , eqr , se )
{
    scripts\mp\art::onprocessbulletmovingfx( owner , time , obj , rumble , radi , max , min , weap , eqp , eqt , eqr , se );
}



//++++++++++++++++++++++++++++++
// en : wait for a bullet to be fired and process the specified event by matching the weapon information.
// ja : 銃弾の発射を待機し、武器情報の照合一致により、指定のイベントを処理する
//++++++++++++++++++++++++++++++
waitfirebullets( optname1 , optname2 , optfunc , notice , specificweapon , effectdata , enddeath )
{
    scripts\mp\art::waitfirebullets( optname1 , optname2 , optfunc , notice , specificweapon , effectdata , enddeath );
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
// en : general-purpose animation processing executed when a special missile is launched.
// ja : 特殊なミサイルが発射された時に実行する汎用アニメーション処理
//++++++++++++++++++++++++++++++
onwaitingfiredmissile( optname )
{
    scripts\mp\art::onwaitingfiredmissile( optname );
}



//++++++++++++++++++++++++++++++
// en : give or take away the specified weapon
// ja : 指定した武器を与えるか、もしくは取り上げる
//++++++++++++++++++++++++++++++
configureweapon( weapondata , takehand , changehand , randomchoose , akimbo , notice )
{
    return scripts\mp\art::configureweapon( weapondata , takehand , changehand , randomchoose , akimbo , notice );
}



//++++++++++++++++++++++++++++++
// en : general function to change the amount of movement of the suboption "tracelength" of the specified function
// ja : 本物のケアパッケージを作成するための汎用関数
//++++++++++++++++++++++++++++++
createrealcarepackage( owner , location , angle )
{
    return scripts\mp\art::createrealcarepackage( owner , location , angle );
}



//++++++++++++++++++++++++++++++
// en : a general-purpose process that sets the effect to be executed when the specified ammunition disappears.
// ja : 指定した弾薬が消失した時に実行される効果を設定する汎用処理
//++++++++++++++++++++++++++++++
ondeathbulletfx( owner , obj , rumble , radi , max , min , weap , eqp , eqt , eqr , se , fx1 , type1 , rep , time1 , rmin , rmax , fx2 , type2 , se2 , del )
{
    scripts\mp\art::ondeathbulletfx( owner , obj , rumble , radi , max , min , weap , eqp , eqt , eqr , se , fx1 , type1 , rep , time1 , rmin , rmax , fx2 , type2 , se2 , del );
}



//++++++++++++++++++++++++++++++
// en : get standard model list
// ja : 標準乗り物モデルリストを取得する
//++++++++++++++++++++++++++++++
getstandardvehiclemodellist( )
{
    return scripts\mp\art::getstandardvehiclemodellist( );
}



//++++++++++++++++++++++++++++++
// en : display text and execute functions according to the on/off state of specified level variables.
// ja : 指定の level 変数のオンオフ状態に合わせて、文章の表示と機能の実行を行う
//++++++++++++++++++++++++++++++
switchonflevelfunction( optname , optfunc , message , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6  , optarg7 )
{
    scripts\mp\art::switchonflevelfunction( optname , optfunc , message , optarg1 , optarg2 , optarg3 , optarg4 , optarg5 , optarg6  , optarg7 );
}



//++++++++++++++++++++++++++++++
// en : generates a nuclear explosion at the specified coordinates (earthquake generation and damage included)
// ja : 指定した座標に 核爆発 を発生させる （地震発生・ダメージ込み）
//++++++++++++++++++++++++++++++
execnuclearexplosion( location , owner )
{
    scripts\mp\art::execnuclearexplosion( location , owner );
}



//++++++++++++++++++++++++++++++
// en : general-purpose processing that destroys the physical object created when the specified function ends
// ja : 指定した機能が終了された時に 生成された物理オブジェクト を破壊する汎用処理
//++++++++++++++++++++++++++++++
onwaitingdestroyentities( delmode , optname , sfxid , expfxid , discfxid , eqpower , eqtime , eqrange , exptime , delay , lastnuke , nukepoint , owner , objarray , objdelete , listarray , listdelete , dualarray )
{
    scripts\mp\art::onwaitingdestroyentities( delmode , optname , sfxid , expfxid , discfxid , eqpower , eqtime , eqrange , exptime , delay , lastnuke , nukepoint , owner , objarray , objdelete , listarray , listdelete , dualarray );
}



//++++++++++++++++++++++++++++++
// en : create multiple specified models by shifting them at the specified angle at the same time.
// ja : 指定したモデルを、指定した角度で、複数同時にずらして作成する
//++++++++++++++++++++++++++++++
spawnmultiplemodels( origin , p1 , p2 , p3 , xx , yy , zz , model , angles , length , time )
{
    return scripts\mp\art::spawnmultiplemodels( origin , p1 , p2 , p3 , xx , yy , zz , model , angles , length , time );
}


//++++++++++++++++++++++++++++++
// en : attraction function monitoring process for players on the cabinet
// ja : アトラクション機能の、筐体のプレイヤーに対するモニタリング処理
//++++++++++++++++++++++++++++++
onattractionplayersmonitoring( optname , seatarray , distance , linktype , noweap )
{
    scripts\mp\art::onattractionplayersmonitoring( optname , seatarray , distance , linktype , noweap );
}



//++++++++++++++++++++++++++++++
// en : process for disembarking players who are still boarding the chassis when the specified function is finished
// ja : 指定の機能が終了された時に、まだ筐体に搭乗しているプレイヤーを降車させる処理
//++++++++++++++++++++++++++++++
ondestroydetachplayers( optname )
{
    scripts\mp\art::ondestroydetachplayers( optname );
}



//++++++++++++++++++++++++++++++
// en : after waiting the specified number of seconds, generate the specified model at the specified coordinates and angle.
// ja : 指定した秒数分待機した後、指定したモデルを、指定した座標・角度で生成する
//++++++++++++++++++++++++++++++
modelspawner( origin , modelid , angles , time , collision )
{
    return scripts\mp\art::modelspawner( origin , modelid , angles , time , collision );
}



//++++++++++++++++++++++++++++++
// en : select level variables related to the specified function in order from the specified array
// ja : 指定の機能に関する level 変数を、指定の配列内から順に選択する
//++++++++++++++++++++++++++++++
changelevelparameter( optname1 , optname2 , prefix , optfunc , arraydata , notice , lastend )
{
    scripts\mp\art::changelevelparameter( optname1 , optname2 , prefix , optfunc , arraydata , notice , lastend );
}



//++++++++++++++++++++++++++++++
// en : create flag object at specified coordinates from string token
// ja : 文字列トークンから指定の座標に旗オブジェクトを作成する
//++++++++++++++++++++++++++++++
createflagfromstrtok( optname , location , data , zaxis , anglefix )
{
    scripts\mp\art::createflagfromstrtok( optname , location , data , zaxis , anglefix );
}



//++++++++++++++++++++++++++++++
// en : create a care package object from a string token at specified coordinates
// ja : 文字列トークンから指定の座標にケアパッケージオブジェクトを作成する
//++++++++++++++++++++++++++++++
createcpboxfromstrtok( optname , location , data , zaxis , p )
{
    scripts\mp\art::createcpboxfromstrtok( optname , location , data , zaxis , p );
}



//++++++++++++++++++++++++++++++
// en : Check if it's an enemy
// ja : 敵かどうかを確認する
//++++++++++++++++++++++++++++++
checkenemy( player )
{
    return scripts\mp\utility\player::isenemy( player );
}



//++++++++++++++++++++++++++++++
// en : create a hud (on-screen ui) with specified elements
// ja : 指定した要素でhud（画面上のui）を作成する
//++++++++++++++++++++++++++++++
createtextelem( fonttype , fontscale , alignx , aligny , posx , posy , colorvalue , alphavalue , glowcolor , glowalpha , sortvalue , textvalue , parent , value )
{
    return scripts\mp\art::createtextelem( fonttype , fontscale , alignx , aligny , posx , posy , colorvalue , alphavalue , glowcolor , glowalpha , sortvalue , textvalue , parent , value );
}



//++++++++++++++++++++++++++++++
// en : returns the corresponding translation from the current language and specified text id
// ja : 現在の言語と指定のテキストidから、該当する翻訳文を返す
//++++++++++++++++++++++++++++++
getmttext( selflang , textid , usegamepad )
{
    return scripts\mp\gametypes\br_gametype_dmz::getmttext( selflang , textid , usegamepad );
}



//++++++++++++++++++++++++++++++
// en : Change the scale and color of the specified HUD string (UI on the screen) within the specified
// ja : 指定したhud string（画面上のui）のスケール、カラーを、指定した秒数で変更する
//++++++++++++++++++++++++++++++
fontscalecolor( time , scale , color , alpha )
{
    scripts\mp\art::fontscalecolor( time , scale , color , alpha );
}



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : Other various mods
// ja : その他各種 Mod
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "demigod"
// ja : 機能 "demigod" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfdemigod( )
{
    // en : execute execdemigod( ) or exit depending on the existence state of the "demigod" variable
    // ja : "demigod" 変数の存在状態に合わせて、execdemigod( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "demigod" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "demigod" ,
        /* optarg2 */   /* optfunc */   ::execdemigod ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "demigod"
// ja : 機能 "demigod" の実行中の処理
//++++++++++++++++++++++++++++++
execdemigod( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "godmode" , ::execgodmode );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: if your current health is less than 10,000
            // ja: 現在の体力が 75 を下回ったら
            if ( self.health < 75 )
            {
                // en: increase health to 150
                // ja: 体力を 150 に上げる
                self.maxhealth  = 150;
                self.health     = self.maxhealth;
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: return to normal strength
            // ja: 通常の体力に戻す
            self.maxhealth  = 100;
            self.health     = self.maxhealth;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "infinityremainingammo"
// ja : 機能 "infinityremainingammo" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfinfinityremainingammo( )
{
    // en : execute execinfinityremainingammo( ) or exit depending on the existence state of the "infinityremainingammo" variable
    // ja : "infinityremainingammo" 変数の存在状態に合わせて、 execinfinityremainingammo( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "infinityremainingammo" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "infinityremainingammo" ,
        /* optarg2 */   /* optfunc */   ::execinfinityremainingammo ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "infinityremainingammo"
// ja : 機能 "infinityremainingammo" の実行中の処理
//++++++++++++++++++++++++++++++
execinfinityremainingammo( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "infinityammo" , ::execinfinityammo );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: get information about the weapon you currently have
            // ja: 今持っている武器の情報を取得
            l_currentweapon = self getcurrentweapon( );

            // en: if you have any weapons
            // ja: 武器を何か持っている場合
            if ( ( l_currentweapon != "none" ) && isdefined( l_currentweapon.clipsize ) && ( 0 < l_currentweapon.clipsize ) )
            {
                // en: set the number of remaining bullets to the maximum number of bullets for that weapon.
                // ja: 残弾数をその武器の最大弾数にする
                self setweaponammostock( l_currentweapon , weaponmaxammo( l_currentweapon ) );
            }

            // en: wait until reloaded
            // ja: リロードされるまで待機する
            self waittill( "reload" );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "movementspeed1_25x"
// ja : 機能 "movementspeed1_25x" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmovementspeed1_25x( )
{
    // en : execute execmovementspeed1_25x( ) or exit depending on the existence state of the "movementspeed1_25x" variable
    // ja : "movementspeed1_25x" 変数の存在状態に合わせて、 execmovementspeed1_25x( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "movementspeed1_25x" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "movementspeed1_25x" ,
        /* optarg2 */   /* optfunc */   ::execmovementspeed1_25x ,
        /* optarg3 */   /* looptime */  1 ,
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
        /* dualmode */                  undefined , 
        /* lvlcheck */                  "speedhack"
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "movementspeed1_25x"
// ja : 機能 "movementspeed1_25x" の実行中の処理
//++++++++++++++++++++++++++++++
execmovementspeed1_25x( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "movementspeed" , ::execchangemovementspeed );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: set your movement speed to 1.25x
            // ja: 自分の移動速度を 1.25倍 に設定する
            self setmovespeedscale( 1.25 );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: return your movement speed to default
            // ja: 自分の移動速度をデフォルトに戻す
            self setmovespeedscale( 1 );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "norecoil"
// ja : 機能 "norecoil" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfnorecoil( )
{
    // en : execute execnorecoil( ) or exit depending on the existence state of the "norecoil" variable
    // ja : "norecoil" 変数の存在状態に合わせて、 execnorecoil( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "norecoil" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "norecoil" ,
        /* optarg2 */   /* optfunc */   ::execnorecoil ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : processing during execution of the function "norecoil"
// ja : 機能 "norecoil" の実行中の処理
//++++++++++++++++++++++++++++++
execnorecoil( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            self.optstat[optname + "kickscale"] = self getviewkickscale( );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: eliminate recoil when firing a gun
            // ja: 銃発砲時の反動を無くす
            self player_recoilscaleon( 0 );
            self setviewkickscale( 0 );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: enable recoil when firing a gun
            // ja: 銃発砲時の反動を有効にする
            self player_recoilscaleon( 100 );
            self setviewkickscale( self.optstat[optname + "kickscale"] );

            self.optstat[optname + "kickscale"] = undefined;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "thirdperson"
// ja : 機能 "thirdperson" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfthirdperson( )
{
    // en : execute execthirdperson( ) or exit depending on the existence state of the "thirdperson" variable
    // ja : "thirdperson" 変数の存在状態に合わせて、 execthirdperson( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "thirdperson" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "thirdperson" ,
        /* optarg2 */   /* optfunc */   ::execthirdperson ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : enables/disables the feature "thirdperson" for the specified player.
// ja : 指定したプレイヤーに対して、機能 "thirdperson" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfthirdpersonforplayer( )
{
    self switchonfplayerfunction( "thirdperson" , ::onfthirdperson );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "thirdperson" for the all players.
// ja : 全プレイヤーに対して、機能 "thirdperson" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfthirdpersonforallplayers( )
{
    self thread switchonfallplayersfunction( "thirdperson" , ::onfthirdperson , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "thirdperson"
// ja : 機能 "thirdperson" の実行中の処理
//++++++++++++++++++++++++++++++
execthirdperson( optname , procstage )
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
            self setcamerathirdperson( true );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            self setcamerathirdperson( false );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "freezeplayer" for the all players.
// ja : 全プレイヤーに対して、機能 "freezeplayer" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onffreezeplayerforallplayers( )
{
    self thread switchonfallplayersfunction( "freezeplayer" , ::onffreezeplayer , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "freezeplayer"
// ja : 機能 "freezeplayer" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onffreezeplayer( )
{
    // en : execute execfreezeplayer( ) or exit depending on the existence state of the "freezeplayer" variable
    // ja : "freezeplayer" 変数の存在状態に合わせて、execfreezeplayer( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "freezeplayer" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "freezeplayer" ,
        /* optarg2 */   /* optfunc */   ::execfreezeplayer ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : processing during execution of the function "freezeplayer"
// ja : 機能 "freezeplayer" の実行中の処理
//++++++++++++++++++++++++++++++
execfreezeplayer( optname , procstage )
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
            self freezecontrols( true );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            self freezecontrols( false );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : commit suicide
// ja : 自殺する
//++++++++++++++++++++++++++++++
execsuicide( )
{
    // en: commit suicide
    // ja: 自分を自殺させる
    self suicide( );
}



//++++++++++++++++++++++++++++++
// en : set the specified image quality
// ja : 指定の画質を設定する
//++++++++++++++++++++++++++++++
execsetvision( )
{
    l_visionid      = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].textid;
    l_visiontype    = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].subparam;

    self visionsetkillstreakforplayer( "" );
    self visionsetthermalforplayer( "" );
    self visionsetnakedforplayer( "" , 0.0 );

    switch ( l_visiontype )
    {
        case "default": l_visionid = l_visiontype; break;
        case "ks":      self visionsetkillstreakforplayer( l_visionid ); break;
        case "naked":   self visionsetnakedforplayer( l_visionid ); break;
        case "thermal": self visionsetthermalforplayer( l_visionid ); break;
    }

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "setvision" , undefined , l_visionid , undefined );
}



//++++++++++++++++++++++++++++++
// en : change team
// ja : チームを変更する
//++++++++++++++++++++++++++++++
switchchangeteam( )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array =
    [
        "allies" ,
        "axis" ,
        "spectator"
    ];

    self changeselfparameter( "changeteam" , undefined , undefined , undefined , l_array , undefined , undefined , undefined );
    wait 0.05;

    if ( getgametype( ) == "br" )
    {
        // en: get information on all participating players
        // ja: 参加中の全プレイヤー情報を取得
        foreach( player in level.players )
        {
            if ( isdefined( player.pers["team"] )   && ( self.pers["team"] != player.pers["team"] ) )   { self.optstat["changeteam"] = player.pers["team"]; break; }
            if ( isdefined( player.team )           && ( self.team != player.team ) )                   { self.optstat["changeteam"] = player.team; break; }
            if ( isdefined( player.sessionteam )    && ( self.sessionteam != player.sessionteam ) )     { self.optstat["changeteam"] = player.sessionteam; break; }
        }
    }

    self.team           = self.optstat["changeteam"];
    self.sessionteam    = self.optstat["changeteam"];
    self.pers["team"]   = self.optstat["changeteam"];

}



//++++++++++++++++++++++++++++++
// en : commit suicide
// ja : プレイヤーのクローンを作成する
//++++++++++++++++++++++++++++++
execcloneplayer( )
{
    self cloneplayer( 0 );

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "cloneplayer" , undefined , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : create a death animation clone of the player and detonate it after a certain amount of time
// ja : プレイヤーの死亡アニメーションクローンを作成し、一定時間経過後に爆破させる
//++++++++++++++++++++++++++++++
execexplodeddeadclone( )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "explodeddeadclone" , undefined , self.origin , undefined );

    l_clone = self cloneplayer( 1 );
    l_clone startragdoll( );
    wait 5;
    // en : play the effect starting from the specified coordinates
    // ja : 指定した座標を起点に、エフェクトを再生させる
    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ "hoopty_explode" , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ l_clone.origin, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
    // ja : 指定した座標から、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
    earthquake( 0.3 , 0.8 , l_clone.origin , 500 );
    // en : play a sound effect starting from the specified coordinates
    // ja : 指定した座標を起点に、サウンドエフェクトを再生させる
    playsoundatpos( l_clone.origin , "exp_escort_helo" );
    // en : causes area damage centered on the current clone's coordinates.
    // ja : 現在のクローンの座標を中心に、範囲ダメージを発生させる
    l_clone radiusdamage( l_clone.origin , 500 , 750 , 50 , self , "MOD_EXPLOSIVE" , getbulletid( "ksmissile1" ) );
    // en : delete clone
    // ja : クローンを削除する
    wait 0.001;
    l_clone deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "ninjamode"
// ja : 機能 "ninjamode" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfninjamode( )
{
    // en : execute execninjamode( ) or exit depending on the existence state of the "ninjamode" variable
    // ja : "ninjamode" 変数の存在状態に合わせて、 execninjamode( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "ninjamode" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "ninjamode" ,
        /* optarg2 */   /* optfunc */   ::execninjamode ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "ninjamode"
// ja : 機能 "ninjamode" の実行中の処理
//++++++++++++++++++++++++++++++
execninjamode( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            self setcamerathirdperson( true );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            l_clone = self cloneplayer( 9999999 );
            wait 0.1;
            l_clone thread deleteaftertime( 2 );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            self setcamerathirdperson( false );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "jetpack"
// ja : 機能 "jetpack" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfjetpack( )
{
    // en : execute execjetpack( ) or exit depending on the existence state of the "jetpack" variable
    // ja : "jetpack" 変数の存在状態に合わせて execjetpack( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "jetpack" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "jetpack" ,
        /* optarg2 */   /* optfunc */   ::execjetpack ,
        /* optarg3 */   /* looptime */  0.1 ,
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
// en : processing during execution of the function "jetpack"
// ja : 機能 "jetpack" の実行中の処理
//++++++++++++++++++++++++++++++
execjetpack( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            self setcamerathirdperson( true );
            self attach( "wmd_vm_missile_cruise" , "tag_stowed_back3" );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: when the "jump" button is pressed
            // ja: 「ジャンプ」ボタンが押されたら
            if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) )
            {
                // en : play a sound effect starting from the specified coordinates
                // ja : 指定した座標を起点に、サウンドエフェクトを再生させる
                playsoundatpos( self.origin , "ks_a10_fire_dist_crack" );
                // en : play the effect starting from the specified coordinates
                // ja : 指定した座標を起点に、エフェクトを再生させる
                playeffecttoobject( /* time */ undefined , /* obj */ self , /* fx */ "hoopty_explode" , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ self.origin , /* fix */ undefined , /* angle */ "up" , /* range */ -70 , /* stop */ undefined );
                // playeffecttoobject( /* time */ undefined , /* obj */ self , /* fx */ "hoopty_explode" , /* tag */ "j_ankle_le" , /* type */ "getplay" , /* loop */ undefined , /* base */ undefined , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
                // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
                // ja : 指定した座標から、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
                earthquake( 0.15 , 0.2 , self gettagorigin( "j_spine4" ) , 300 );
                // en : move the angular velocity directly upwards
                // ja : 角速度を真上に向けて移動させる
                self setvelocity( self getvelocity( ) + ( 0 , 0 , 100 ) );
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            self setcamerathirdperson( false );
            self detach( "wmd_vm_missile_cruise" , "tag_stowed_back3" );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "shieldman"
// ja : 機能 "shieldman" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfshieldman( )
{
    // en : execute execshieldman( ) or exit depending on the existence state of the "shieldman" variable
    // ja : "shieldman" 変数の存在状態に合わせて、 execshieldman( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "shieldman" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "shieldman" ,
        /* optarg2 */   /* optfunc */   ::execshieldman ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : processing during execution of the function "shieldman"
// ja : 機能 "shieldman" の実行中の処理
//++++++++++++++++++++++++++++++
execshieldman( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            self setcamerathirdperson( true );
            self attach( "offhand_wm_deployable_cover" , "j_head" );
            self attach( "offhand_wm_deployable_cover" , "tag_stowed_back3" );
            self attach( "offhand_wm_deployable_cover" , "tag_weapon_left" );
            self attach( "offhand_wm_deployable_cover" , "j_knee_ri" );
            self attach( "offhand_wm_deployable_cover" , "j_ankle_le" );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            self setcamerathirdperson( false );
            self detach( "offhand_wm_deployable_cover" , "j_head" );
            self detach( "offhand_wm_deployable_cover" , "tag_stowed_back3" );
            self detach( "offhand_wm_deployable_cover" , "tag_weapon_left" );
            self detach( "offhand_wm_deployable_cover" , "j_knee_ri" );
            self detach( "offhand_wm_deployable_cover" , "j_ankle_le" );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "superslide"
// ja : 機能 "superslide" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsuperslide( )
{
    // en : execute execsuperslide( ) or exit depending on the existence state of the "superslide" variable
    // ja : "superslide" 変数の存在状態に合わせて、 execsuperslide( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "superslide" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "superslide" ,
        /* optarg2 */   /* optfunc */   ::execsuperslide ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "superslide"
// ja : 機能 "superslide" の実行中の処理
//++++++++++++++++++++++++++++++
execsuperslide( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            self.optstat[optname].start = false;
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: if super slide is not executed
            // ja: スーパースライドが未実行の場合
            if ( !self.optstat[optname].start )
            {
                // en: flag when sliding starts
                // ja: スライディングが開始されたらフラグを立てる
                if ( self issprintsliding( ) )
                {
                    self.optstat[optname].start = true;
                }
            }
            else
            {
                // en: get movement speed
                // ja: 移動速度を取得
                l_velocity = self getvelocity( );
                
                // en: when movement speed decreases
                // ja: 移動速度が低下した場合
                if ( ( l_velocity[0] < 100 ) || ( l_velocity[1] < 100 ) )
                {
                    // en: when movement speed decreases
                    // ja: 移動速度が低下した場合
                    l_addvelocity = anglestoforward( self getplayerangles( ) ) * 125;
                    self setvelocity( l_velocity + l_addvelocity );
                }

                // en: when the "jump" button is pressed
                // ja: 「ジャンプ」ボタンが押されたら
                if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) )
                {
                    self.optstat[optname].start = false;
                    wait 1;
                }
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : Toggle the function "High Radiation Mode" on or off.
// ja : 機能 "高放射線モード" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfhighradiationmode( )
{
    // en : execute exechighradiationmode( ) or exit depending on the existence state of the "highradiationmode" variable
    // ja : "highradiationmode" 変数の存在状態に合わせて exechighradiationmode( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "highradiationmode" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "highradiationmode" ,
        /* optarg2 */   /* optfunc */   ::exechighradiationmode ,
        /* optarg3 */   /* looptime */  0.01 ,
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
// en : processing during execution of the function "High Radiation Mode"
// ja : 機能 "高放射線モード" の実行中の処理
//++++++++++++++++++++++++++++++
exechighradiationmode( optname , procstage )
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
	        self shellshock( "mp_radiation_high" , 2 );
            break;

        // en: end processing
        // ja: 終了処理
        case 2:
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : Toggle the function "dogtagshoes" on or off.
// ja : 機能 "dogtagshoes" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfdogtagshoes( )
{
    // en : execute execdogtagshoes( ) or exit depending on the existence state of the "dogtagshoes" variable
    // ja : "dogtagshoes" 変数の存在状態に合わせて execdogtagshoes( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "dogtagshoes" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "dogtagshoes" ,
        /* optarg2 */   /* optfunc */   ::execdogtagshoes ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : processing during execution of the function "dogtagshoes"
// ja : 機能 "dogtagshoes" の実行中の処理
//++++++++++++++++++++++++++++++
execdogtagshoes( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            l_modelid = scripts\engine\utility::random( level.lvlstat["modellistdogtags"] );
            self setcamerathirdperson( true );
            self.optstat[optname + "_model1"] = self createentityobject( /* notice */ undefined , /* point */ self.origin , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ undefined , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ undefined );
            self.optstat[optname + "_model2"] = self createentityobject( /* notice */ undefined , /* point */ self.origin , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ undefined , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ undefined );
            self.optstat[optname + "_model1"] linkto( self , "j_ankle_le" , ( 0 , 0 , 0 ) , ( 0 , 50 , 90 ) );
            self.optstat[optname + "_model2"] linkto( self , "j_ankle_ri" , ( 0 , 0 , 0 ) , ( 0 , 50 , 90 ) );
            break;

        // en: running process
        // ja: 実行中処理
        case 1:
            break;

        // en: end processing
        // ja: 終了処理
        case 2:
            self setcamerathirdperson( false );
            self.optstat[optname + "_model1"] deleteentity( );
            self.optstat[optname + "_model2"] deleteentity( );
            self.optstat[optname + "_model"] = undefined;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : Toggle the function "adventureball" on or off.
// ja : 機能 "adventureball" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfadventureball( )
{
    // en : execute execadventureball( ) or exit depending on the existence state of the "adventureball" variable
    // ja : "adventureball" 変数の存在状態に合わせて execadventureball( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "adventureball" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "adventureball" ,
        /* optarg2 */   /* optfunc */   ::execadventureball ,
        /* optarg3 */   /* looptime */  0.01 ,
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
// en : processing during execution of the function "adventureball"
// ja : 機能 "adventureball" の実行中の処理
//++++++++++++++++++++++++++++++
execadventureball( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            l_modelid = scripts\engine\utility::random( level.lvlstat["modellistvehicles"] );
            self setcamerathirdperson( true );
            scripts\mp\outofbounds::enableoobimmunity( self );
            self.optstat[optname + "_model1"] = self createentityobject( /* notice */ undefined , /* point */ self.origin , /* length */ undefined , /* script */ "script_model" , /* model */ "tag_origin" , /* collide */ undefined , /* sync */ undefined , /* angle */ undefined , /* part */ undefined );
            self.optstat[optname + "_model2"] = self createentityobject( /* notice */ undefined , /* point */ self.origin , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ true , /* sync */ undefined , /* angle */ self getplayerangles( ) , /* part */ true );
            self.optstat[optname + "_model2"] linkto( self );
            self playerlinkto( self.optstat[optname + "_model1"] );
            break;

        // en: running process
        // ja: 実行中処理
        case 1:
            // en: set the specified effect name as the function termination trigger
            // ja: 指定の機能名を関数の終了トリガーとする
            self endon( "finalize_" + optname );
            l_time1 = randomintrange( 5 , 8 );
            l_time2 = randomintrange( 2 , 4 );
            l_center = self.origin;
            l_z1 = randomintrange( 1000 , 5000 );
            l_z2 = randomintrange( 6000 , 10000 );
            l_z3 = randomintrange( 1000 , 3000 );
            l_z4 = randomintrange( 0 , 300 );
            self.optstat[optname + "_model1"] moveto( l_center + ( 0                                , 0                                 , l_z1 )    , l_time2 );    wait l_time1;
            self.optstat[optname + "_model1"] moveto( l_center + ( 0                                , randomintrange( -5000 , 5000 )    , l_z1 )    , l_time2 );    wait l_time1;
            self.optstat[optname + "_model1"] moveto( l_center + ( randomintrange( -5000 , 5000 )   , randomintrange( -5000 , 5000 )    , l_z1 )    , l_time2 );    wait l_time1;
            self.optstat[optname + "_model1"] moveto( l_center + ( randomintrange( -5000 , 5000 )   , randomintrange( -5000 , 5000 )    , l_z2 )    , l_time2 );    wait l_time1;
            self.optstat[optname + "_model1"] moveto( l_center + ( 0                                , 0                                 , l_z3 )    , l_time2 );    wait l_time1;
            self.optstat[optname + "_model1"] moveto( l_center + ( 0                                , 0                                 , l_z4 )    , l_time2 );    wait l_time2;
            self onfadventureball( );
            break;

        // en: end processing
        // ja: 終了処理
        case 2:
            self setcamerathirdperson( false );
            scripts\mp\outofbounds::disableoobimmunity( self );
            self unlink( );
            self.optstat[optname + "_model1"] deleteentity( );
            self.optstat[optname + "_model2"] deleteentity( );
            self.optstat[optname + "_model"] = undefined;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : Trigger an earthquake
// ja : 地震を発生させる
//++++++++++++++++++++++++++++++
execearthquake( )
{
	earthquake( randomfloatrange( 0.1 , 1.0 ) , randomintrange( 1 , 10 ) , self.origin , randomintrange( 100 , 100000 ) );

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    foreach ( player in level.players )
        player showcentermessage( player.curlang , "notice" , "earthquakeoccurrence" , undefined , self.origin , undefined );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "saveloadlocation"
// ja : 機能 "saveloadlocation" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsaveloadlocation( )
{
    // en : execute execsaveloadlocation( ) or exit depending on the existence state of the "saveloadlocation" variable
    // ja : "saveloadlocation" 変数の存在状態に合わせて、 execsaveloadlocation( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "saveloadlocation" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "saveloadlocation" ,
        /* optarg2 */   /* optfunc */   ::execsaveloadlocation ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "saveloadlocation"
// ja : 機能 "saveloadlocation" の実行中の処理
//++++++++++++++++++++++++++++++
execsaveloadlocation( optname , procstage )
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
            // en: while the tactical throw button is pressed
            // ja: タクティカルを投げるボタンが押されている間
            if ( self getkeycodepressed( "buttontactical" , "buttontactical" ) )
            {
                // en: when the "jump" button is pressed
                // ja: 「ジャンプ」ボタンが押されたら
                if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) )
                {
                    // en: remember your current coordinates
                    // ja: 今いる座標を記憶する
                    self.optstat[optname].moddata["location"] = self.origin;
                    // en: display the specified text in the center of the screen
                    // ja: 画面中央に指定の文章を表示する
                    self showcentermessage( self.curlang , "notice" , "savelocation" , undefined , self.origin , undefined );
                    wait 0.3;
                }
                // en: when the "crouch/prone" button is pressed
                // ja: 「しゃがみ・伏せ」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonstance" , "buttonstance" ) )
                {
                    // en: if the coordinates are memorized, move to those coordinates.
                    // ja: 座標が記憶されていれば、その座標に移動する
                    if ( isdefined( self.optstat[optname].moddata["location"] ) )
                    {
                        self setorigin( self.optstat[optname].moddata["location"] );
                        // en: display the specified text in the center of the screen
                        // ja: 画面中央に指定の文章を表示する
                        self showcentermessage( self.curlang , "notice" , "loadlocation" , undefined , self.optstat[optname].moddata["location"] , undefined );
                        wait 0.3;
                    }
                }
            }
            break;

        // en: end processing
        // ja: 終了処理
        case 2:
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "outofmappossible"
// ja : 機能 "outofmappossible" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfoutofmappossible( )
{
    // en : execute execoutofmappossible( ) or exit depending on the existence state of the "outofmappossible" variable
    // ja : "outofmappossible" 変数の存在状態に合わせて、 execoutofmappossible( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "outofmappossible" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "outofmappossible" ,
        /* optarg2 */   /* optfunc */   ::execoutofmappossible ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : processing during execution of the function "outofmappossible"
// ja : 機能 "outofmappossible" の実行中の処理
//++++++++++++++++++++++++++++++
execoutofmappossible( optname , procstage )
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
            if ( !isdefined( self.oobimmunity ) )
            {
                scripts\mp\outofbounds::enableoobimmunity( self );
            }
            
            // en: if the player is in a vehicle
            // ja: プレイヤーが乗り物に乗っている場合
            if ( self scripts\cp_mp\utility\player_utility::isinvehicle( ) )
            {
                self.optstat[optname].curvehicle = self scripts\cp_mp\utility\player_utility::getvehicle( );
                scripts\mp\outofbounds::enableoobimmunity( self.optstat[optname].curvehicle );
            }
            // en: if the player is not in a vehicle
            // ja: プレイヤーが乗り物に乗っていない場合
            else
            {
                if ( isdefined( self.optstat[optname].curvehicle ) )
                {
                    scripts\mp\outofbounds::disableoobimmunity( self.optstat[optname].curvehicle );
                    self.optstat[optname].curvehicle = undefined;
                }
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            scripts\mp\outofbounds::disableoobimmunity( self );
            
            if ( isdefined( self.optstat[optname].curvehicle ) )
            {
                scripts\mp\outofbounds::disableoobimmunity( self.optstat[optname].curvehicle );
                self.optstat[optname].curvehicle = undefined;
            }
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "outofmappossible" for the specified player.
// ja : 指定したプレイヤーに対して、機能 "outofmappossible" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfoutofmappossibleforplayer( )
{
    self switchonfplayerfunction( "outofmappossible" , ::onfoutofmappossible );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "outofmappossible" for the all players.
// ja : 全プレイヤーに対して、機能 "outofmappossible" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfoutofmappossibleforallplayers( )
{
    self thread switchonfallplayersfunction( "outofmappossible" , ::onfoutofmappossible , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "setmodel"
// ja : 機能 "setmodel" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsetmodel( )
{
    // en : execute execsetmodel( ) or exit depending on the existence state of the "setmodel" variable
    // ja : "setmodel" 変数の存在状態に合わせて、 execsetmodel( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "setmodel" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "setmodel" ,
        /* optarg2 */   /* optfunc */   ::execsetmodel ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : enable/disable suboption "synccenterbody" of function "setmodel"
// ja : 機能 "setmodel" のサブオプション "synccenterbody" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsetmodelsynccenterbody( )
{
    // en : create or destroy a "synccenterbody" variable
    // ja : "synccenterbody" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "setmodel" ,
        /* optname2 */  "synccenterbody" ,
        /* optdata */   true ,
        /* optfunc */   ::resyncsetmodel ,
        /* notice */    true ,
        /* optarg1 */   "setmodel" ,
        /* optarg2 */   "synccenterbody" ,
        /* optarg3 */   "_objectdata",
        /* optarg4 */   "_objectlinked" ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : change the 3d model synchronization position of the function "setmodel"
// ja : 機能 "setmodel" の3dモデルの同期位置を変更する
//++++++++++++++++++++++++++++++
resyncsetmodel( optname , subparam , objname , linkname )
{
    // en : if a 3d model already exists
    // ja : 既に3dモデルが存在している場合
    if ( isdefined( self.optstat[optname + objname] ) )
    {
        l_noclipbase = "bindnoclip";
        l_nocliplink = "linkobject";

        // en: if the object used for flight processing has already been generated
        // ja: 飛行処理に使うオブジェクトが生成済みの場合
        if ( isdefined( self.optstat[l_noclipbase + l_nocliplink] ) )
        {
            // en : when the link (synchronization) destination of the 3d model is undefined
            // ja : 3dモデルのリンク（同期）先が未定義の場合
            if ( !isdefined( self.optstat[optname + linkname] ) ||
            // en : or if the link (synchronization) destination is yourself
            // ja : もしくはリンク（同期）先が自分自身の場合
                ( isdefined( self.optstat[optname + linkname] ) && ( ( self.optstat[optname + linkname] != "noclip_forward" ) && ( self.optstat[optname + linkname] != "noclip_center" ) ) ) ||
            // en : or, when the link (synchronization) destination is in the forward direction of the object used for flight processing and the model position is adjusted to the center of the body.
            // ja : もしくはリンク（同期）先が飛行処理に使うオブジェクトの前方方向で、且つ体の中央にモデル位置を合わせる場合
                ( isdefined( self.optstat[optname + linkname] ) && ( self.optstat[optname + linkname] == "noclip_forward" ) && isdefined( self.optstat[optname].moddata[subparam] ) ) ||
            // en : or when the link (synchronization) destination is the center point of the object used for flight processing and the model position is adjusted in the forward direction.
            // ja : もしくはリンク（同期）先が飛行処理に使うオブジェクトの中心点で、且つ前方方向にモデル位置を合わせる場合
                ( isdefined( self.optstat[optname + linkname] ) && ( self.optstat[optname + linkname] == "noclip_center" ) && !isdefined( self.optstat[optname].moddata[subparam] ) ) )
            {
                // en : unlink (synchronize) 3d models
                // ja : 3dモデルのリンク（同期）を解除する
                self.optstat[optname + objname] unlink( );

                // en : align the angle of the 3d model and the object used for flight processing
                // ja : 3dモデルと飛行処理に使うオブジェクトの角度を合わせる
                self.optstat[optname + objname].angles = self.optstat[l_noclipbase + l_nocliplink].angles;
                
                // en : when aligning the model position in the forward direction of the object used for flight processing
                // ja : 飛行処理に使うオブジェクトの前方方向にモデル位置を合わせる場合
                if ( !isdefined( self.optstat[optname].moddata[subparam] ) )
                {
                    // en : move the 3d model to the coordinates in front of you and slightly below you
                    // ja : 3dモデルを自分の前方方向、少し下の座標に移動する
                    self.optstat[optname + objname].origin = self getplayerforwardtrace( /* trace */ undefined , /* eye */ undefined , /* length */ 600 , /* up */ -75 );
                    // en : the link (synchronization) destination of the 3d model is the forward direction of the object used for flight processing.
                    // ja : 3dモデルのリンク（同期）先は飛行処理に使うオブジェクトの前方方向とする
                    self.optstat[optname + linkname] = "noclip_forward";
                }
                // en : when aligning the model position to the center of the body
                // ja : 体の中央にモデル位置を合わせる場合
                else
                {
                    // en : align yourself with the 3d model
                    // ja : 3dモデルと自分の位置を合わせる
                    self.optstat[optname + objname].origin = self getplayerforwardtrace( /* trace */ undefined , /* eye */ undefined , /* length */ 15 , /* up */ 15 );
                    // en : assume that 3d model linking (synchronization) is completed.
                    // ja : 3dモデルのリンク（同期）先は自分とする
                    self.optstat[optname + linkname] = "noclip_center";
                }
                // en : link (synchronize) the 3d model to the objects used for flight processing
                // ja : 3dモデルを飛行処理に使うオブジェクトにリンク（同期）する
                self.optstat[optname + objname] linkto( self.optstat[l_noclipbase + l_nocliplink] );
                // en: set an object solid
                // ja: オブジェクトを固体設定する
                self.optstat[optname + objname] solid( );
            }
        }
        // en: if the object used for flight processing has not been created
        // ja: 飛行処理に使うオブジェクトが未生成の場合
        else
        {
            // en : when the link (synchronization) destination of the 3d model is undefined
            // ja : 3dモデルのリンク（同期）先が未定義の場合
            if ( !isdefined( self.optstat[optname + linkname] ) ||
            // en : or if the link (synchronization) destination is an object used for flight processing
            // ja : もしくはリンク（同期）先が飛行処理に使うオブジェクトの場合
                ( isdefined( self.optstat[optname + linkname] ) && ( ( self.optstat[optname + linkname] == "noclip_forward" ) || ( self.optstat[optname + linkname] == "noclip_center" ) ) ) ||
            // en : or if the link (synchronization) destination is your head and you want to align the model position to the center of your body
            // ja : もしくはリンク（同期）先が自分の頭で、且つ体の中央にモデル位置を合わせる場合
                ( isdefined( self.optstat[optname + linkname] ) && ( self.optstat[optname + linkname] == "self_head" ) && isdefined( self.optstat[optname].moddata[subparam] ) ) ||
            // en : or if the link (synchronization) destination is the center of the body and the model position is aligned with the head
            // ja : もしくはリンク（同期）先が体の中央で、且つ頭にモデル位置を合わせる場合
                ( isdefined( self.optstat[optname + linkname] ) && ( self.optstat[optname + linkname] == "self_body" ) && !isdefined( self.optstat[optname].moddata[subparam] ) ) )
            {
                // en : unlink (synchronize) 3d models
                // ja : 3dモデルのリンク（同期）を解除する
                self.optstat[optname + objname] unlink( );

                // en : align your angle with the 3d model
                // ja : 3dモデルと自分の角度を合わせる
                self.optstat[optname + objname].angles = self getplayerangles( );

                // en : when adjusting the model position to the head
                // ja : 頭にモデル位置を合わせる場合
                if ( !isdefined( self.optstat[optname].moddata[subparam] ) )
                {
                    // en : align your head with the 3d model
                    // ja : 3dモデルと自分の頭の位置を合わせる
                    self.optstat[optname + objname].origin = self gettagorigin( "j_head" );
                    // en : link (sync) a 3d model to yourself
                    // ja : 3dモデルを自分にリンク（同期）する
                    self.optstat[optname + objname] linkto( self , "j_head" );
                    // en : link (synchronize) the 3d model to your head
                    // ja : 3dモデルのリンク（同期）先は自分の頭とする
                    self.optstat[optname + linkname] = "self_head";
                }
                // en : when aligning the model position to the center of the body
                // ja : 体の中央にモデル位置を合わせる場合
                else
                {
                    // en : align yourself with the 3d model
                    // ja : 3dモデルと自分の位置を合わせる
                    self.optstat[optname + objname].origin = self.origin;
                    // en : link (sync) a 3d model to yourself
                    // ja : 3dモデルを自分にリンク（同期）する
                    self.optstat[optname + objname] linkto( self );
                    // en : assume that 3d model linking (synchronization) is completed.
                    // ja : 3dモデルのリンク（同期）先は自分とする
                    self.optstat[optname + linkname] = "self_body";
                }

                // en: assume an object is not solid
                // ja: オブジェクトを固体ではないとする
                self.optstat[optname + objname] notsolid( );
            }
        }
    }
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "setmodel" for the specified player.
// ja : 指定したプレイヤーに対して、機能 "setmodel" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsetmodelforplayer( )
{
    self switchonfplayerfunction( "setmodel" , ::onfsetmodel );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "setmodel" for the all players.
// ja : 全プレイヤーに対して、機能 "setmodel" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsetmodelforallplayers( )
{
    self thread switchonfallplayersfunction( "setmodel" , ::onfsetmodel , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : change the type of 3d model in use with the function "setmodel"
// ja : 機能 "setmodel" で使用中の3dモデルの種類を変更する
//++++++++++++++++++++++++++++++
switchchangemodel( )
{
    self changemodelid( true );
}



//++++++++++++++++++++++++++++++
// en : change the type of 3d model in use with the function "setmodel"
// ja : 機能 "setmodel" で使用中の3dモデルの種類を変更する
//++++++++++++++++++++++++++++++
changemodelid( notice )
{
    l_optname = "changemodel";

    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array = getstandardmodellist( );
    if ( !isdefined( self.optstat[l_optname + "_objectid"] ) )
    {
        // en : pick a model id randomly from the array
        // ja : 配列内からランダムにモデルidを取り出す
        self.optstat[l_optname + "_objectid"] = scripts\engine\utility::random( l_array );
    }
    else
    {
        l_find = false;
        for ( i = 0; i < l_array.size; i++ )
        {
            if ( self.optstat[l_optname + "_objectid"] == l_array[i] )
            {
                l_find = true;
                if ( (i + 1) < l_array.size )   { self.optstat[l_optname + "_objectid"] = l_array[(i + 1)]; }
                else                            { self.optstat[l_optname + "_objectid"] = l_array[0]; }
                break;
            }
        }
        if ( !l_find ) { self.optstat[l_optname + "_objectid"] = l_array[0]; }
    }

    // en : if a 3d model already exists
    // ja : 既に3dモデルが存在している場合
    if ( isdefined( self.optstat["setmodel" + "_objectdata"] ) )
    {
        // en : change 3d model
        // ja : 3dモデルを変更する
        self.optstat["setmodel" + "_objectdata"] setmodel( self.optstat[l_optname + "_objectid"] );

        // en : set all script parts status for the specified model
        // ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
        if ( ( self.optstat[l_optname + "_objectid"] != "military_carepackage_01_juggernaut" ) &&
            ( self.optstat[l_optname + "_objectid"] != "military_carepackage_01_enemy" ) &&
            ( self.optstat[l_optname + "_objectid"] != "military_carepackage_01_br" ) &&
            ( self.optstat[l_optname + "_objectid"] != "military_carepackage_01_friendly" ) )
        {
            self.optstat["setmodel" + "_objectdata"] thread setallsetscriptablepartstate( );
        }
    }

    if ( isdefined( notice ) )
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , l_optname , undefined , self.optstat[l_optname + "_objectid"] , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "setmodel"
// ja : 機能 "setmodel" の実行中の処理
//++++++++++++++++++++++++++++++
execsetmodel( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en: if you have not decided on the type of 3d model yet, set the initial model.
            // ja: まだ3dモデルの種類が決まっていない場合は、初期モデルを設定する
            if ( !isdefined( self.optstat["changemodel" + "_objectid"] ) )
            {
                self changemodelid( undefined );
            }

            // en: if no 3d model object has been generated yet
            // ja: まだ3dモデルオブジェクトが生成されていない場合
            if ( !isdefined( self.optstat[optname + "_objectdata"] ) )
            {
                // en : create an 3d model
                // ja : 3dモデルを作成する
                self.optstat[optname + "_objectdata"] = self createentityobject(
                    /* notice */    undefined ,
                    /* location */  self.origin ,
                    /* length */    undefined ,
                    /* script */    "script_model" , 
                    /* model */     self.optstat["changemodel" + "_objectid"] ,
                    /* collide */   undefined ,
                    /* sync */      undefined ,
                    /* angle */     self.angles ,
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

                // en : if the 3d model generation is successful
                // ja : 3dモデルの生成が成功している場合
                if ( isdefined( self.optstat[optname + "_objectdata"] ) )
                {
                    // en : change the 3d model synchronization position of the function "setmodel"
                    // ja : 機能 "setmodel" の3dモデルの同期位置を変更する
                    self resyncsetmodel( optname , "synccenterbody" , "_objectdata" , "_objectlinked" );
                }
            }
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en : change the 3d model synchronization position of the function "setmodel"
            // ja : 機能 "setmodel" の3dモデルの同期位置を変更する
            self resyncsetmodel( optname , "synccenterbody" , "_objectdata" , "_objectlinked" );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en : if the 3d model still exists
            // ja : 3dモデルがまだ存在している場合
            if ( isdefined( self.optstat[optname + "_objectdata"] ) )
            {
                // en : unlink (synchronize) 3d models
                // ja : 3dモデルのリンク（同期）を解除する
                self.optstat[optname + "_objectdata"] unlink( );

                // en : delete 3d model
                // ja : 3dモデルを削除する
                self.optstat[optname + "_objectdata"] deleteentity( );
                self.optstat[optname + "_objectdata"] = undefined;
                
                // en : delete 3d model link information
                // ja : 3dモデルのリンク情報を削除する
                self.optstat[optname + "_objectlinked"] = undefined;
                self.optstat["changemodel" + "_objectid"] = undefined;
            }
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : change the type of 3d model in use with the function "setmodel"
// ja : 機能 "setmodel" で使用中の3dモデルの種類を変更する
//++++++++++++++++++++++++++++++
execchangemodel( )
{
    l_optname1 = "changemodel";
    l_optname2 = "setmodel";

    self.optstat[l_optname1 + "_objectid"] = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].textid;

    // en : if a 3d model already exists
    // ja : 既に3dモデルが存在している場合
    if ( isdefined( self.optstat[l_optname2 + "_objectdata"] ) )
    {
        // en : change 3d model
        // ja : 3dモデルを変更する
        self.optstat[l_optname2 + "_objectdata"] setmodel( self.optstat[l_optname1 + "_objectid"] );

        // en : set all script parts status for the specified model
        // ja : 指定したモデルに全てのスクリプト用パーツステータスを設定する
        if ( ( self.optstat[l_optname1 + "_objectid"] != "military_carepackage_01_juggernaut" ) &&
            ( self.optstat[l_optname1 + "_objectid"] != "military_carepackage_01_enemy" ) &&
            ( self.optstat[l_optname1 + "_objectid"] != "military_carepackage_01_br" ) &&
            ( self.optstat[l_optname1 + "_objectid"] != "military_carepackage_01_friendly" ) )
        {
            self.optstat[l_optname2 + "_objectdata"] thread setallsetscriptablepartstate( );
        }
    }

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , l_optname1 , undefined , self.optstat[l_optname1 + "_objectid"] , undefined );

}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "blueprintweapon"
// ja : 機能 "blueprintweapon" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfblueprintweapon( )
{
    // en : create or destroy a "blueprintweapon" variable
    // ja : "blueprintweapon" 変数の作成か破棄を行う
    self switchonfselffunction(
        /* optname */       "blueprintweapon" ,
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
    
    // en : disable attachments and camo options when feature "blueprintweapon" is enabled
    // ja : 機能 "blueprintweapon" が有効の場合、アタッチメントと迷彩オプションを無効にする
    if ( isdefined( self.optstat["blueprintweapon"] ) )
    {
        if ( isdefined( self.optstat["randomattachment"] ) )    { self.optstat["randomattachment"] = undefined; }
        if ( isdefined( self.optstat["randomcamo"] ) )          { self.optstat["randomcamo"] = undefined; }
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "randomcamo"
// ja : 機能 "randomcamo" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfrandomcamo( )
{
    // en : create or destroy a "randomcamo" variable
    // ja : "randomcamo" 変数の作成か破棄を行う
    self switchonfselffunction(
        /* optname */       "randomcamo" ,
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
    
    // en : disable blueprintweapon options when feature "randomcamo" is enabled
    // ja : 機能 "randomcamo" が有効の場合、 "blueprintweapon" オプションを無効にする
    if ( isdefined( self.optstat["randomcamo"] ) )
    {
        if ( isdefined( self.optstat["blueprintweapon"] ) ) { self.optstat["blueprintweapon"] = undefined; }
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "randomattachment"
// ja : 機能 "randomattachment" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfrandomattachment( )
{
    // en : create or destroy a "randomattachment" variable
    // ja : "randomattachment" 変数の作成か破棄を行う
    self switchonfselffunction(
        /* optname */       "randomattachment" ,
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
    
    // en : disable blueprintweapon options when feature "randomattachment" is enabled
    // ja : 機能 "randomattachment" が有効の場合、 "blueprintweapon" オプションを無効にする
    if ( isdefined( self.optstat["randomattachment"] ) )
    {
        if ( isdefined( self.optstat["blueprintweapon"] ) ) { self.optstat["blueprintweapon"] = undefined; }
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "dualweapon"
// ja : 機能 "dualweapon" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfdualweapon( )
{
    // en : create or destroy a "dualweapon" variable
    // ja : "dualweapon" 変数の作成か破棄を行う
    self switchonfselffunction(
        /* optname */       "dualweapon" ,
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
// en : get a random weapon blueprint for the weapon you currently have
// ja : 現在手持ちの武器の設計図武器をランダムで取得する
//++++++++++++++++++++++++++++++
execgivebpweaponfromcurwp( )
{
    // en : give specified weapon
    // ja : 指定の武器を与える
    self thread provideweapon(
        /* weaponid */      "currentbp" ,
        /* inprojectile */  undefined ,
        /* onlygroup */     undefined ,
        /* attachmentid */  undefined ,
        /* camoid */        undefined ,
        /* camogroup */     undefined ,
        /* akimbo */        undefined ,
        /* changehand */    true ,
        /* notice */        true ,
        /* onlygetid */     undefined
        );
}



//++++++++++++++++++++++++++++++
// en : get a random weapon
// ja : ランダムに武器を取得する
//++++++++++++++++++++++++++++++
execgiverandomweapon( )
{
    // en : get random attachment settings
    // ja : ランダムアタッチメント設定の取得
    l_attachmentid = undefined;
    if ( isdefined( self.optstat["randomattachment"] ) )    { l_attachmentid = "random"; }
    
    // en : get random camouflage settings
    // ja : ランダム迷彩設定の取得
    l_camoid = undefined;
    if ( isdefined( self.optstat["randomcamo"] ) )          { l_camoid = "random"; }
    
    // en : get random blueprint settings
    // ja : ランダム設計図設定の取得
    if ( isdefined( self.optstat["blueprintweapon"] ) )     { l_camoid = "bpcamo"; }
    
    // en : get dual attachment settings
    // ja : デュアルアタッチメント設定の取得
    l_dual = undefined;
    if ( isdefined( self.optstat["dualweapon"] ) )          { l_dual = true; }

    // en : give specified weapon
    // ja : 指定の武器を与える
    self thread provideweapon(
        /* weaponid */      "random" ,
        /* inprojectile */  "random" ,
        /* onlygroup */     undefined ,
        /* attachmentid */  l_attachmentid ,
        /* camoid */        l_camoid ,
        /* camogroup */     undefined ,
        /* akimbo */        l_dual ,
        /* changehand */    true ,
        /* notice */        true ,
        /* onlygetid */     undefined
        );
}



//++++++++++++++++++++++++++++++
// en : drop your weapon on the ground
// ja : 所持中の武器を地面に落とす
//++++++++++++++++++++++++++++++
execdropweapon( )
{
    // en: get information about the weapon you currently have
    // ja: 今持っている武器の情報を取得
    l_currentweapon = self getcurrentweapon( );

    // en: if you own any kind of weapon
    // ja: 何かしらの武器を所持している場合
    if ( isdefined( l_currentweapon ) )
    {
        // en : get basic name of weapon
        // ja : 武器の基本名称を取得
        l_name = getweaponbasename( l_currentweapon );

        // en : drop your weapon on the ground
        // ja : 所持中の武器を地面に落とす
        self dropitem( l_currentweapon );
        
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , "dropweapon" , undefined , l_name , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : pick up your weapon
// ja : 所持中の武器を取り上げる
//++++++++++++++++++++++++++++++
exectakedweapon( )
{
    // en: get information about the weapon you currently have
    // ja: 今持っている武器の情報を取得
    l_currentweapon = self getcurrentweapon( );

    // en: if you own any kind of weapon
    // ja: 何かしらの武器を所持している場合
    if ( isdefined( l_currentweapon ) )
    {
        // en : get basic name of weapon
        // ja : 武器の基本名称を取得
        l_name = getweaponbasename( l_currentweapon );

        // en : pick up your weapon
        // ja : 所持中の武器を取り上げる
        self scripts\cp_mp\utility\inventory_utility::_takeweapon( l_currentweapon );
        
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , "takedweapon" , undefined , l_name , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : pick up your all weapons
// ja : 所持中の全ての武器を取り上げる
//++++++++++++++++++++++++++++++
exectakedallweapons( )
{
    // en : pick up your all weapons
    // ja : 所持中の全ての武器を取り上げる
    self takeallweapons( );
    
    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "takedallweapons" , undefined , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : give specified weapon
// ja : 指定の武器を与える
//++++++++++++++++++++++++++++++
execgiveweapon( )
{
    l_weaponid = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].subparam;

    // en : get random attachment settings
    // ja : ランダムアタッチメント設定の取得
    l_attachmentid = undefined;
    if ( isdefined( self.optstat["randomattachment"] ) )    { l_attachmentid = "random"; }
    
    // en : get random camouflage settings
    // ja : ランダム迷彩設定の取得
    l_camoid = undefined;
    if ( isdefined( self.optstat["randomcamo"] ) )          { l_camoid = "random"; }
    
    // en : get random blueprint settings
    // ja : ランダム設計図設定の取得
    if ( isdefined( self.optstat["blueprintweapon"] ) )     { l_camoid = "bpcamo"; }
    
    // en : get dual attachment settings
    // ja : デュアルアタッチメント設定の取得
    l_dual = undefined;
    if ( isdefined( self.optstat["dualweapon"] ) )          { l_dual = true; }

    // en : give specified weapon
    // ja : 指定の武器を与える
    self thread provideweapon(
        /* weaponid */      l_weaponid ,
        /* inprojectile */  undefined ,
        /* onlygroup */     undefined ,
        /* attachmentid */  l_attachmentid ,
        /* camoid */        l_camoid ,
        /* camogroup */     undefined ,
        /* akimbo */        l_dual ,
        /* changehand */    true ,
        /* notice */        true ,
        /* onlygetid */     undefined
        );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "teleportgun"
// ja : 機能 "teleportgun" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfteleportgun( )
{
    // en : when the "teleportgun" variable is enabled, pass a weapon with the specified settings, execute the execteleportgun( ) function at the coordinates of the target fired with that weapon, and generate the specified effect.
    // ja : "teleportgun" 変数が有効時、指定の設定で武器を渡し、その武器で発射した先の座標に execteleportgun( )関数 を実行、及び指定のエフェクトを発生させる
    self switchonfselffunction(
        /* optname */                               "teleportgun" ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               undefined ,
        /* optarg1 */       /* optname1 */          "teleportgun" ,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::execteleportgun ,
        /* optarg4 */       /* notice */            undefined ,
        /* optarg5 */       /* specificweapon */    true ,
        /* optarg6 */       /* effectdata */        "equipment_sparks" ,
        /* optarg7 */       /* enddeath */          true ,
        /* weaponid */                              "random" ,
        /* inprojectile */                          undefined ,
        /* onlygroup */                             "weapon_smg" ,
        /* attachmentid */                          undefined ,
        /* camoid */                                "bpcamo" ,
        /* camogroup */                             undefined ,
        /* dualmode */                              undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "teleportgun"
// ja : 機能 "teleportgun" の実行中の処理
//++++++++++++++++++++++++++++++
execteleportgun( location )
{
    // en : create a link object
    // ja : リンク用オブジェクトを作成する
    l_link = self createentityobject( /* notice */ undefined , /* spawnlocation */ location + ( 0 , 0 , 50 ) , /* spawnlength */ undefined , /* script */ "script_origin" , /* objectname */ "tag_origin" );
    // en : delete the specified object after the specified number of seconds
    // ja : 指定されたオブジェクトを、指定された秒数経過後に削除する
    l_link thread deleteaftertime( 0.1 );

    // en: teleport to target coordinates
    // ja: 射撃先の座標にテレポートする
    self setorigin( location + ( 0 , 0 , 50 ) );

    // en : link only for 1 frame after teleporting (fall damage prevention)
    // ja : テレポート後に1フレーム間だけリンクする（落下ダメージ防止）
    self playerlinkto( l_link );

    wait 0.001;

    // en : remove player link
    // ja : プレイヤーリンクを解除する
    self unlink( );
    
    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "teleporttolocation" , undefined , location , undefined );
}



//++++++++++++++++++++++++++++++
// en : change the amount of movement of the function "teleportgun"
// ja : 機能 "teleportgun" の 移動量 を変更する
//++++++++++++++++++++++++++++++
switchteleportgunmovesize( )
{
    self changetracesize( "teleportgun" , "tracelength" , ::onfteleportgun , true );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "rocketride"
// ja : 機能 "rocketride" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfrocketride( )
{
    // en : execute execrocketride( ) or exit depending on the existence state of the "rocketride" variable
    // ja : "rocketride" 変数の存在状態に合わせて、 execrocketride( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "rocketride" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "rocketride" ,
        /* optarg2 */   /* optfunc */   ::execrocketride ,
        /* optarg3 */   /* looptime */  0.5 ,
        /* optarg4 */                   undefined ,
        /* optarg5 */                   undefined ,
        /* optarg6 */                   undefined ,
        /* optarg7 */                   undefined ,
        /* weaponid */                  getbulletid( "rpg7" ) ,
        /* inprojectile */              undefined ,
        /* onlygroup */                 undefined ,
        /* attachmentid */              undefined ,
        /* camoid */                    undefined ,
        /* camogroup */                 undefined ,
        /* dualmode */                  undefined
        );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "rocketride" for the specified player.
// ja : 指定したプレイヤーに対して、機能 "rocketride" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfrocketrideforplayer( )
{
    self switchonfplayerfunction( "rocketride" , ::onfrocketride );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "rocketride" for the all players.
// ja : 全プレイヤーに対して、機能 "rocketride" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfrocketrideforallplayers( )
{
    self thread switchonfallplayersfunction( "rocketride" , ::onfrocketride , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "rocketride"
// ja : 機能 "rocketride" の実行中の処理
//++++++++++++++++++++++++++++++
execrocketride( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "infinityremainingammo" , ::execinfinityremainingammo );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            self waittill( "missile_fire" , bulletobject , weaponid );
            
            // en: if the weapon no longer exists, execute the termination process
            // ja: 武器が既に存在しない場合、終了処理を実行する
            if ( isdefined( self.optstat[optname] ) == false )
            {
                self execrocketride( optname , 2 /* moddef.mod_finalize */ );
                return;
            }

            // en: if the fired weapon matches the weapon linked to the specified variable
            // ja: 発射された武器と、指定の変数に連携する武器が一致する場合
            if ( getweaponcompleteid( self getcurrentweapon( ) ) == self.optstat[optname].weapondata )
            {
                // en: if you are already linking to a previously launched missile
                // ja: 既に前に発射したミサイルにリンク中である場合
                if ( isdefined( self.optstat[optname + "_linking"] ) )
                {
                    // en: terminates the missile link standby process that is currently running.
                    // ja: 実行中のミサイルリンク待機処理を終了する
                    self notify( "end_" + optname + "_linking" );

                    // en: unlink (synchronize) yourself from the missile
                    // ja: ミサイルから自分のリンク（同期）を解除する
                    self unlink( );

                    wait 0.001;
                }

                // en: link (synchronize) yourself to the launched missile
                // ja: 自分を発射されたミサイルにリンク（同期）する
                self playerlinkto( bulletobject );

                // en : processing during linking until the missile disappears in the function "rocketride"
                // ja : 機能 "rocketride" のミサイルが消滅するまでのリンク中の処理
                self thread ondeathrocketride( optname , bulletobject );
                
                // en: define missile linking flag
                // ja: ミサイルリンク中フラグを定義する
                self.optstat[optname + "_linking"] = true;
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: if linked to a missile
            // ja: ミサイルにリンク中である場合
            if ( isdefined( self.optstat[optname + "_linking"] ) )
            {
                // en: unlink (synchronize) yourself from the missile
                // ja: ミサイルから自分のリンク（同期）を解除する
                self unlink( );
                
                // en: discard missile link flag
                // ja: ミサイルリンク中フラグを破棄する
                self.optstat[optname + "_linking"] = undefined;
            }
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : processing during linking until the missile disappears in the function "rocketride"
// ja : 機能 "rocketride" のミサイルが消滅するまでのリンク中の処理
//++++++++++++++++++++++++++++++
ondeathrocketride( optname , bulletobject )
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
    self endon( "end_" + optname + "_linking" );

    
    // en: increase your health so you don't die when the missile explodes
    // ja: ミサイルの爆発時に死なないように、体力を上げておく
    self.maxhealth  = 10000;
    self.health     = self.maxhealth;

    // en : wait until the missile explodes
    // ja : ミサイルが爆発するまで待つ
    bulletobject waittill( "death" );
    
    // en: unlink (synchronize) yourself from the missile
    // ja: ミサイルから自分のリンク（同期）を解除する
    self unlink( );
    wait 0.5;

    // en: regain one's strength
    // ja: 体力を元に戻す
    self.maxhealth  = 100;
    self.health     = self.maxhealth;
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "walkingac130"
// ja : 機能 "walkingac130" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfwalkingac130( )
{
    // en : execute execwalkingac130( ) or exit depending on the existence state of the "walkingac130" variable
    // ja : "walkingac130" 変数の存在状態に合わせて execwalkingac130( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "walkingac130" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "walkingac130" ,
        /* optarg2 */   /* optfunc */   ::execwalkingac130 ,
        /* optarg3 */   /* looptime */  0.05 ,
        /* optarg4 */                   undefined ,
        /* optarg5 */                   undefined ,
        /* optarg6 */                   undefined ,
        /* optarg7 */                   undefined ,
        /* weaponid */                  getbulletid( "ac130_25mm" ) ,
        /* inprojectile */              undefined ,
        /* onlygroup */                 undefined ,
        /* attachmentid */              undefined ,
        /* camoid */                    undefined ,
        /* camogroup */                 undefined ,
        /* dualmode */                  undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "walkingac130"
// ja : 機能 "walkingac130" の実行中の処理
//++++++++++++++++++++++++++++++
execwalkingac130( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : give specified weapon
            // ja : 指定の武器を与える
            self thread provideweapon( getbulletid( "ac130_40mm" ) );
            self thread provideweapon( getbulletid( "ac130_105mm" ) );

            // en : executes general animation processing on a subthread when a special missile is launched.
            // ja : 特殊なミサイルが発射された時に実行する汎用アニメーション処理をサブスレッド上で実行する
            self thread onwaitingfiredmissile( optname );
            // en : set the hud to ac130 specifications
            // ja : hudをac130仕様にする
            /*
            self visionsetkillstreakforplayer( "ac130_color" );
            self setclientomnvar( "ui_ac130_hud" , 1 );
            self setclientomnvar( "ui_killstreak_weapon_1_ammo", self getweaponammoclip( "ac130_105mm_mp" ) );
            self setclientomnvar( "ui_killstreak_weapon_2_ammo", self getweaponammoclip( "ac130_40mm_mp" ) );
            self setclientomnvar( "ui_killstreak_weapon_3_ammo", self getweaponammoclip( "ac130_25mm_mp" ) );
            self setclientomnvar( "ui_killstreak_countdown" , gettime( ) + int( self.timeout * 1000 ) );
            self setclientomnvar( "ui_killstreak_health" , self.maxhealth );
            self setclientomnvar( "ui_killstreak_flares" , 2 );
            */
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: get information about the weapon you currently have
            // ja: 今持っている武器の情報を取得
            l_currentweapon = self getcurrentweapon( );
            // en: change processing depending on weapon type
            // ja: 武器種類によって処理を変更する
            switch ( l_currentweapon.basename )
            {
                case "ac130_105mm_mp":
                case "ac130_40mm_mp":
                case "ac130_25mm_mp":
                    // en: set the number of remaining bullets to the maximum number of bullets for that weapon.
                    // ja: 残弾数をその武器の最大弾数にする
                    self setweaponammostock( l_currentweapon , weaponmaxammo( l_currentweapon ) );
                    // en: set the number of bullets to the maximum number of bullets for that weapon.
                    // ja: 装弾数をその武器の最大弾数にする
                    self setweaponammoclip( l_currentweapon , l_currentweapon.clipsize );
                    break;
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: pick up the target's weapon
            // ja: 持っている対象の武器を取り上げる
            self configureweapon( /* weapondata */ getbulletid( "ac130_40mm" ) , /* takehand */ true );
            self configureweapon( /* weapondata */ getbulletid( "ac130_105mm" ) , /* takehand */ true );

            // en : restore hud to default
            // ja : hudをデフォルトに戻す
            /*
            self setclientomnvar( "ui_ac130_hud" , 0 );
            self visionsetkillstreakforplayer( "" );
            self scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate( );
            */
            // en : finish the general animation process that is executed when a special missile is launched.
            // ja : 特殊なミサイルが発射された時に実行する汎用アニメーション処理を終了する
            self notify( "finalize_" + optname );
            self.optstat[optname] = undefined;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "realcarepackagegun"
// ja : 機能 "realcarepackagegun" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfrealcarepackagegun( )
{
    l_optname = "realcarepackagegun";

    // en : when the "realcarepackagegun" variable is enabled, pass the weapon with the specified settings and pass the coordinates of the target fired with the weapon to the execrealcarepackagegun( ) function.
    // ja : "realcarepackagegun" 変数が有効時、指定の設定で武器を渡し、その武器で発射した先の座標を execrealcarepackagegun( )関数 にデータを渡す
    self switchonfselffunction(
        /* optname */                               l_optname ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               undefined ,
        /* optarg1 */       /* optname1 */          l_optname ,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::execrealcarepackagegun ,
        /* optarg4 */       /* notice */            undefined ,
        /* optarg5 */       /* specificweapon */    true ,
        /* optarg6 */       /* effectdata */        undefined ,
        /* optarg7 */       /* enddeath */          true ,
        /* weaponid */                              "random" ,
        /* inprojectile */                          undefined ,
        /* onlygroup */                             "weapon_pistol" ,
        /* attachmentid */                          undefined ,
        /* camoid */                                "bpcamo" ,
        /* camogroup */                             undefined ,
        /* dualmode */                              undefined
        );

    wait 0.05;
    // en: shorten the distance of the coordinates to obtain when firing a gun
    // ja: 銃発射時の取得先の座標の距離を短くする
    if ( isdefined( self.optstat[l_optname] ) ) { self.optstat[l_optname].moddata["tracelength"] = 1000; }
}



//++++++++++++++++++++++++++++++
// en : when the "realcarepackagegun" variable is enabled, a care package is created and launched towards the specified coordinates.
// ja : "realcarepackagegun" 変数が有効時、指定の座標に向けてケアパッケージを作成し、発射させる
//++++++++++++++++++++++++++++++
execrealcarepackagegun( location )
{
    // en : get the coordinates of the aircraft's destination (coordinates a specified distance ahead in the direction of the player's viewpoint)
    // ja : ケアパッケージの生成座標を取得する（プレイヤーの視点方向に 指定分 先の座標）
    l_cratelocation = self getplayerforwardtrace( /* trace */ undefined , /* eye */ true , /* length */ 100 , /* up */ undefined );
    // en : create a care package
    // ja : ケアパッケージを作成する
    l_package = createrealcarepackage( /* owner */ self , /* location */ l_cratelocation , /* angle */ self getplayerangles( ) );

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , "createobject" , undefined , location , undefined );
    wait 0.001;

    // en : for effect processing purposes, make the specified bullet fly in a transparent state from the specified starting point to the specified ending point.
    // ja : エフェクト処理用途で、指定した弾を、指定した開始地点から終了地点まで、透明状態で飛ばす
    l_bullet = self createeffectablebullet( self , 150 , 0 , getbulletid( "rpg7" ) , location );
    // en: if bullets can be generated
    // ja: 弾が生成出来ている場合
    if ( isdefined( l_bullet ) )
    {
        // en : executes the process during the movement of ammunition fired with the function "realcarepackagegun" on a subthread.
        // ja : 機能 "realcarepackagegun" で発射された弾薬が移動中の処理を、サブスレッド上で実行する
        l_bullet thread linkobjecttobullet( /* object */ l_package , /* time */ undefined , /* del */ undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "frameball"
// ja : 機能 "frameball" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfframeball( )
{
    // en : when the "frameball" variable is enabled, pass a weapon with the specified settings, execute the execframeball( ) function at the coordinates of the target fired with that weapon, and generate the specified effect.
    // ja : "frameball" 変数が有効時、指定の設定で武器を渡し、その武器で発射した先の座標に execframeball( )関数 を実行、及び指定のエフェクトを発生させる
    self switchonfselffunction(
        /* optname */                               "frameball" ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               undefined ,
        /* optarg1 */       /* optname1 */          "frameball" ,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::execframeball ,
        /* optarg4 */       /* notice */            undefined ,
        /* optarg5 */       /* specificweapon */    true ,
        /* optarg6 */       /* effectdata */        undefined ,
        /* optarg7 */       /* enddeath */          true ,
        /* weaponid */                              "random" ,
        /* inprojectile */                          undefined ,
        /* onlygroup */                             "weapon_pistol" ,
        /* attachmentid */                          undefined ,
        /* camoid */                                "bpcamo" ,
        /* camogroup */                             undefined ,
        /* dualmode */                              undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "frameball"
// ja : 機能 "frameball" の実行中の処理
//++++++++++++++++++++++++++++++
execframeball( location )
{
    l_loopfx        = "hoopty_explode";//"van_explode";
    l_tag           = undefined;
    l_fxtype        = "getplay";
    l_loop          = true;

    l_time          = 5;
    l_exptime       = l_time + 0.1;
    l_weaponid      = getbulletid( "frag_grenade" );
    l_owner         = self;
    l_obj           = l_owner;
    l_useeye        = true;
    l_length        = 700;
    l_start         = self geteye( );

    l_looptime      = 0.2;
    l_dmgbase       = l_owner;
    l_rumble        = "grenade_rumble";
    l_loopradi      = 400;
    l_loopdmgmax    = 300;
    l_dmgmin        = 1;
    l_loopeqpower   = 0.2;
    l_loopeqtime    = 0.7;
    l_loopeqrange   = l_loopradi + 100;
    l_loopse        = "ks_a10_fire_dist_crack";

    l_distradi      = l_loopeqrange + 100;
    l_distdmgmax    = l_loopdmgmax * 3;
    l_disteqpower   = l_loopeqpower * 2;
    l_disteqtime    = l_loopeqtime * 2;
    l_disteqrange   = l_distradi + 100;
    l_distse        = "iw8_ks_ac130_dist_rkt_explo";
    l_distfx        = "hoopty_explode";
    l_distfxtype    = "getplay";
    l_playcount     = 1;

    // en: generates a specified type of grenade and launches it from the start coordinate to the end coordinate (you are the owner of the bullet)
    // ja: 指定した種類のグレネードを生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
    l_grenade = createmagicgrenade( l_owner , l_obj , l_useeye , l_length , l_weaponid , l_start , l_exptime );
    
    // en : Play the specified effect on the specified object in an infinite loop.
    // ja : 指定されたオブジェクトに対して、指定されたエフェクトを無限ループで再生し続ける
    l_grenade thread playeffecttoobject( l_looptime , l_grenade , l_loopfx , l_tag , l_fxtype , l_loop , /* base */ undefined , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    
    // en : processing of ammunition fired with the function "thundergun"
    // ja : 指定した弾薬が、移動中に常に実行される効果を設定する汎用処理
    l_grenade thread onprocessbulletmovingfx( l_owner , l_looptime , l_dmgbase , l_rumble , l_loopradi , l_loopdmgmax , l_dmgmin , l_weaponid , l_loopeqpower , l_loopeqtime , l_loopeqrange , l_loopse );

    // en : a general-purpose process that sets the effect to be executed when the specified ammunition disappears.
    // ja : 指定した弾薬が消失した時に実行される効果を設定する汎用処理
    l_grenade thread ondeathbulletfx( l_owner , l_dmgbase , l_rumble , l_distradi , l_distdmgmax , l_dmgmin , l_weaponid , l_disteqpower , l_disteqtime , l_disteqrange , l_distse , l_distfx , l_distfxtype , l_playcount , /* time */ undefined , /* rmin */ undefined , /* rmax */ undefined , /* fx2 */ undefined , /* type2 */ undefined , /* se2 */ undefined , /* del */ undefined );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "moddedgrenades"
// ja : 機能 "moddedgrenades" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmoddedgrenades( )
{
    // en : execute execmoddedgrenades( ) or exit depending on the existence state of the "moddedgrenades" variable
    // ja : "moddedgrenades" 変数の存在状態に合わせて、 execmoddedgrenades( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "moddedgrenades" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "moddedgrenades" ,
        /* optarg2 */   /* optfunc */   ::execmoddedgrenades ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "moddedgrenades"
// ja : 機能 "moddedgrenades" の実行中の処理
//++++++++++++++++++++++++++++++
execmoddedgrenades( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en: if the "grenadetype" variable does not exist
            // ja: "grenadetype" 変数が存在しない場合
            if ( !isdefined( self.optstat[optname].moddata["grenadetype"] ) )
            {
                // en : pick a weapon id randomly from the array and set it
                // ja : 配列内からランダムに 武器id を取り出して設定する
                self changegrenadestype( undefined , true );
            }
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: do not proceed to the next process while the "attack" button is not pressed.
            // ja: "攻撃" ボタンが押されていない間は、次の処理に進まない
            if ( self getkeycodepressed( "buttonattack" , "buttonattack" ) == false ) { return; }

            // en: get the bullet generation start coordinates (shift about 50 points from the coordinates of your eyes in the direction the muzzle is facing)
            // ja: 弾の生成開始座標を取得（自分の目の座標から、銃口が向いてる方向に 50 程度ずらす）
            l_startlocation = self getplayerforwardtrace( /* trace */ undefined , /* eye */ true , /* length */ 50 , /* up */ undefined );
            
            // en: generates a specified type of grenade and launches it from the start coordinate to the end coordinate (you are the owner of the bullet)
            // ja: 指定した種類のグレネードを生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
            createmagicgrenade( /* owner */ self , /* obj */ self , /* eye */ true , /* length */ 1000 , /* weaponid */ self.optstat[optname].moddata["grenadetype"] , /* pstart */ l_startlocation , /* time */ 5 );
            wait 0.05;
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : change the type of ammunition for the function "moddedgrenades"
// ja : 機能　"moddedgrenades" の弾薬の種類を変更する 
//++++++++++++++++++++++++++++++
switchgrenadestype( )
{
    self changegrenadestype( true , undefined );
}



//++++++++++++++++++++++++++++++
// en : change the type of ammunition for the function "moddedgrenades" (with or without notification specified)
// ja : 機能　"moddedgrenades" の弾薬の種類を変更する （通知の有無の指定有り）
//++++++++++++++++++++++++++++++
changegrenadestype( notice , random )
{
    // en : get ammo list
    // ja : 弾薬リストを取得する
    l_array = getbulletlist( "allgrenade" );


    self changeselfparameter( "moddedgrenades" , "grenadetype" , undefined , ::onfmoddedgrenades , l_array , notice , undefined , random );
}



//++++++++++++++++++++++++++++++
// en : change the type of ammunition for the function "modded bullets"
// ja : 機能　"modded bullets" の弾薬の種類を変更する 
//++++++++++++++++++++++++++++++
switchbulletstype( )
{
    // en : change the type of ammunition for the function "modded bullet" (with notification)
    // ja : 機能　"modded bullet" の弾薬の種類を変更する （通知有り）
    self changebulletstype( true , undefined );
}



//++++++++++++++++++++++++++++++
// en : change the type of ammunition for the function "modded bullet" (with or without notification specified)
// ja : 機能　"modded bullet" の弾薬の種類を変更する （通知の有無の指定有り）
//++++++++++++++++++++++++++++++
changebulletstype( notice , random )
{
    // en : get ammo list
    // ja : 弾薬リストを取得する
    l_array = getbulletlist( "allbullet" );

    self changeselfparameter( "moddedbullets" , "bullettype" , undefined , ::onfmoddedbullets , l_array , notice , undefined , random );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "modded bullet" for the specified player.
// ja : 指定したプレイヤーに対して、機能「modded bullet」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmoddedbulletsforplayer( )
{
    // en : execute onfmoddedbullets( ) or exit for the specified player, depending on the existence state of the "moddedbullets" variable.
    // ja : 指定したプレイヤーに対して、 "moddedbullets" 変数の存在状態に合わせて、onfmoddedbullets( ) を実行するか終了する
    self switchonfplayerfunction( "moddedbullets" , ::onfmoddedbullets );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "moddedbullets" for the all players.
// ja : 全プレイヤーに対して、機能 "moddedbullets" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmoddedbulletsforallplayers( )
{
    self thread switchonfallplayersfunction( "moddedbullets" , ::onfmoddedbullets , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "moddedbulletsfiretrigger" of function "modded bullets"
// ja : 機能 "modded bullets" のサブオプション "moddedbulletsfiretrigger" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmoddedbulletsfiretrigger( )
{
    // en : create or destroy a "moddedbulletsfiretrigger" variable
    // ja : "moddedbulletsfiretrigger" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "moddedbullets" ,
        /* optname2 */  "moddedbulletsfiretrigger" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "moddedbulletsnum5" of function "modded bullets"
// ja : 機能 "modded bullets" のサブオプション "moddedbulletsnum5" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmoddedbulletsnum5( )
{
    // en : create or destroy a "moddedbulletsnum5" variable
    // ja : "moddedbulletsnum5" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "moddedbullets" ,
        /* optname2 */  "moddedbulletsnum5" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "modded bullet"
// ja : 機能「modded bullet」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmoddedbullets( )
{
    // en : execute execmoddedbullets( ) or exit depending on the existence state of the "moddedbullets" variable
    // ja : "moddedbullets" 変数の存在状態に合わせて、execmoddedbullets( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "moddedbullets" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "moddedbullets" ,
        /* optarg2 */   /* optfunc */   ::execmoddedbullets ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "modded bullet"
// ja : 機能「改造弾」の実行中の処理
//++++++++++++++++++++++++++++++
execmoddedbullets( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en: if the "bullettype" variable does not exist
            // ja: 「bullettype」変数が存在しない場合
            if ( !isdefined( self.optstat[optname].moddata["bullettype"] ) )
            {
                // en : pick a weapon id randomly from the array and set it
                // ja : 配列内からランダムに 武器id を取り出して設定する
                self changebulletstype( undefined , true );
            }
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: when waiting for a gun firing event to occur using the waittill function
            // ja: waittill 関数による 銃発射 イベントの発生を待機する場合
            if ( isdefined( self.optstat[optname].moddata["moddedbulletsfiretrigger"] ) )
            {
                self waittill( "weapon_fired" );
            }
            // en: when not using the gun firing event using the waittill function
            // ja: waittill 関数による 銃発射 イベントを利用しない場合
            else
            {
                // en: do not proceed to the next process while the "attack" button is not pressed.
                // ja: "攻撃" ボタンが押されていない間は、次の処理に進まない
                if ( self getkeycodepressed( "buttonattack" , "buttonattack" ) == false ) { return; }
            }

            // en: whether 3d model is being generated and noclip is in progress
            // ja: 3dモデル生成中で、且つnoclip中かどうか
            l_modelnoclip = false;
            // en: define ammunition coordinate information to be used during 3d model generation and noclip.
            // ja: 3dモデル生成中で、且つnoclip中の時に使う、弾薬座標情報を定義しておく
            l_bulletstart = [];
            l_bulletend = [];
            // en: get eye location
            // ja: 目の座標を取得
            l_eyelocation = self geteye( );
            // en: get front direction
            // ja: 正面方向を取得
            l_forwardangle = anglestoforward( self getplayerangles( ) );
            // en: get the bullet generation start coordinates (shift about 50 points from the coordinates of your eyes in the direction the muzzle is facing)
            // ja: 弾の生成開始座標を取得（自分の目の座標から、銃口が向いてる方向に 50 程度ずらす）
            l_startlocation = ( l_eyelocation + ( l_forwardangle * 50 ) );
            // en: get the bullet generation start coordinates (shift about 1000000 points from the coordinates of your eyes in the direction the muzzle is facing)
            // ja: 弾の生成開始座標を取得（自分の目の座標から、銃口が向いてる方向に 1000000 程度ずらす）
            l_endlocation = ( l_eyelocation + ( l_forwardangle * 1000000 ) );
            
            // en : if a 3d model has been generated
            // ja : 3dモデルの生成がされている場合
            if ( isdefined( self.optstat["setmodel" + "_objectdata"] ) )
            {
                // en: if the object used for flight processing has already been generated
                // ja: 飛行処理に使うオブジェクトが生成済みの場合
                if ( isdefined( self.optstat["bindnoclip" + "linkobject"] ) )
                {
                    // en: 3d model is being generated and noclip is in progress
                    // ja: 3dモデル生成中で、且つnoclip中とする
                    l_modelnoclip = true;
                    // en : get 3d model coordinates
                    // ja : 3dモデルの座標を取得
                    l_eyelocation = self.optstat["setmodel" + "_objectdata"].origin;
                    // en: get front direction
                    // ja: 正面方向を取得
                    l_forwardangle = anglestoforward( self.optstat["setmodel" + "_objectdata"].angles );
                    // en: get right direction
                    // ja: 右方向を取得
                    l_rightangle = anglestoright( self.optstat["setmodel" + "_objectdata"].angles );
                    // en: get left direction
                    // ja: 左向を取得
                    l_leftangle = anglestoleft( self.optstat["setmodel" + "_objectdata"].angles );
                    // en: obtain the bullet generation start coordinates (shift slightly to the left and right from the coordinates of the 3d model, and shift about 300 in the front direction)
                    // ja: 弾の生成開始座標を取得（3dモデルの座標から少し左右にずらし、正面方向に 300 程度ずらす）
                    l_bulletstart["right"]  = ( l_eyelocation + ( l_rightangle * 100 ) + ( 0 , 0 , -75 ) + ( l_forwardangle * 300 ) );
                    l_bulletstart["left"]   = ( l_eyelocation + ( l_leftangle * 100 ) + ( 0 , 0 , -75 ) + ( l_forwardangle * 300 ) );
                    // en: get the bullet generation start coordinates (shift slightly to the left and right from the coordinates of the 3d model, and shift about 1000000 in the front direction)
                    // ja: 弾の生成開始座標を取得（3dモデルの座標から少し左右にずらし、正面方向に 1000000 程度ずらす）
                    l_bulletend["right"]    = ( l_eyelocation + ( l_rightangle * 100 ) + ( 0 , 0 , -75 ) + ( l_forwardangle * 1000000 ) );
                    l_bulletend["left"]     = ( l_eyelocation + ( l_leftangle * 100 ) + ( 0 , 0 , -75 ) + ( l_forwardangle * 1000000 ) );
                }
            }
            
            // en: when firing 5 bullets at the same time
            // ja: 弾発射数を5発同時に撃つ場合
            if ( isdefined( self.optstat[optname].moddata["moddedbulletsnum5"] ) )
            {
                // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
                // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
                createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , ( l_startlocation + ( 0 , 0 , 100 ) ) , l_endlocation );
                wait 0.05;
                createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , ( l_startlocation + ( 100 , 0 , 0 ) ) , l_endlocation );
                wait 0.05;
                createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , ( l_startlocation + ( -100 , 0 , 0 ) ) , l_endlocation );
                wait 0.05;
                createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , ( l_startlocation + ( 100 , 0 , 100 ) ) , l_endlocation );
                wait 0.05;
                createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , ( l_startlocation + ( -100 , 0 , 100 ) ) , l_endlocation );
                wait 0.05;
            }
            // en: when only one bullet is fired
            // ja: 弾発射数が1発だけの場合
            else
            {
                // en: when generating a 3d model, but not during noclip
                // ja: 3dモデル生成中、noclip中ではない場合
                if ( l_modelnoclip == false )
                {
                    // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
                    // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
                    createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , l_startlocation , l_endlocation );
                    wait 0.05;
                }
                // en: when 3d model is being generated and noclip is in progress
                // ja: 3dモデル生成中で、且つnoclip中の場合
                else
                {
                    // en: a ray is sent from the left and right bullet launch coordinates to the end coordinate, and information on hit data is obtained.
                    // ja: 左右の弾丸発射座標から終了座標へ向けて、レイを飛ばし、ヒットしたデータの情報を取得する
                    l_bulletleft = scripts\engine\trace::_bullet_trace( l_bulletstart["left"] , l_bulletend["left"] , 0 , undefined );
                    l_bulletright = scripts\engine\trace::_bullet_trace( l_bulletstart["right"] , l_bulletend["right"] , 0 , undefined );
                    
                    // en: if you are not shooting the bullet on the left side
                    // ja: 左側の弾を撃っていない場合
                    if ( !isdefined( self.optstat[optname].moddata["noclipbulletlefted"] ) )
                    {
                        // en: if coordinate information has been obtained
                        // ja: 座標情報が取得できている場合
                        if ( isdefined( l_bulletleft["position"] ) )
                        {
                            // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
                            // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
                            createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , l_bulletstart["left"] , l_bulletleft["position"] );
                            
                            // en: suppose you shoot the bullet on the left.
                            // ja: 左側の弾を撃ったとする
                            self.optstat[optname].moddata["noclipbulletlefted"] = true;
                            wait 0.1;
                        }
                    }
                    // en: after shooting the bullet on the left
                    // ja: 左側の弾を撃った後の場合
                    else
                    {
                        // en: if coordinate information has been obtained
                        // ja: 座標情報が取得できている場合
                        if ( isdefined( l_bulletright["position"] ) )
                        {
                            // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
                            // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
                            createmagicbullet( self , self.optstat[optname].moddata["bullettype"] , l_bulletstart["right"] , l_bulletright["position"] );
                            
                            // en: suppose you shoot the bullet on the right.
                            // ja: 右側の弾を撃ったとする
                            self.optstat[optname].moddata["noclipbulletlefted"] = undefined;
                            wait 0.1;
                        }
                    }
                }
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en : finish the general animation process that is executed when a special missile is launched.
            // ja : 特殊なミサイルが発射された時に実行する汎用アニメーション処理を終了する
            self notify( "finalize_" + optname );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "infinity ammo"
// ja : 機能「弾無限」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfinfinityammo( )
{
    // en : execute execinfinityammo( ) or exit depending on the existence state of the "infinityammo" variable
    // ja : 「infammo」変数の存在状態に合わせて、execinfinityammo( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "infinityammo" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "infinityammo" ,
        /* optarg2 */   /* optfunc */   ::execinfinityammo ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : enables/disables the feature "infinity ammo" for the specified player.
// ja : 指定したプレイヤーに対して、機能「弾無限」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfinfinityammoforplayer( )
{
    // en : execute onfinfinityammo( ) or exit for the specified player, depending on the existence state of the "infinityammo" variable.
    // ja : 指定したプレイヤーに対して、「infammo」変数の存在状態に合わせて、onfinfinityammo( ) を実行するか終了する
    self switchonfplayerfunction( "infinityammo" , ::onfinfinityammo );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "infinityammo" for the all players.
// ja : 全プレイヤーに対して、機能 "infinityammo" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfinfinityammoforallplayers( )
{
    self thread switchonfallplayersfunction( "infinityammo" , ::onfinfinityammo , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "infinity ammo"
// ja : 機能「弾無限」の実行中の処理
//++++++++++++++++++++++++++++++
execinfinityammo( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "infinityremainingammo" , ::execinfinityremainingammo );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: get information about the weapon you currently have
            // ja: 今持っている武器の情報を取得
            l_currentweapon = self getcurrentweapon( );

            // en: if you have any weapons
            // ja: 武器を何か持っている場合
            //if ( ( l_currentweapon != "none" ) && isdefined( l_currentweapon.clipsize ) && ( 0 < l_currentweapon.clipsize ) )
            if ( isdefined( l_currentweapon ) && ( l_currentweapon.basename != "none" ) && ( 0 < weaponclipsize( l_currentweapon ) ) )
            {
                // en: set the number of remaining bullets to the maximum number of bullets for that weapon.
                // ja: 残弾数をその武器の最大弾数にする
                self setweaponammostock( l_currentweapon , weaponmaxammo( l_currentweapon ) );
                
                // en: set the number of bullets to the maximum number of bullets for that weapon.
                // ja: 装弾数をその武器の最大弾数にする
                self setweaponammoclip( l_currentweapon , weaponclipsize( l_currentweapon ) );

                // en: gives maximum ammo for that weapon
                // ja: その武器の最大弾薬数を与える
                self givemaxammo( l_currentweapon );
            }

            l_result = self scripts\engine\utility::waittill_any_return( "weapon_fired" , "reload" , "grenade_fire" , "missile_fire" , "weapon_change" , "melee" );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "bindnoclip"
// ja : 機能 "bindnoclip" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfbindnoclip( )
{
    // en : execute execbindnoclip( ) or exit depending on the existence state of the "bindnoclip" variable
    // ja : "bindnoclip" 変数の存在状態に合わせて、 execbindnoclip( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "bindnoclip" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "bindnoclip" ,
        /* optarg2 */   /* optfunc */   ::execbindnoclip ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : enables/disables the feature "bindnoclip" for the specified player.
// ja : 指定したプレイヤーに対して、機能 "bindnoclip" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfbindnoclipforplayer( )
{
    self switchonfplayerfunction( "bindnoclip" , ::onfbindnoclip );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "bindnoclip" for the all players.
// ja : 全プレイヤーに対して、機能 "bindnoclip" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfbindnoclipforallplayers( )
{
    self thread switchonfallplayersfunction( "bindnoclip" , ::onfbindnoclip , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "bindnoclip"
// ja : 機能 "bindnoclip" の実行中の処理
//++++++++++++++++++++++++++++++
execbindnoclip( optname , procstage )
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
        lv_unverified = 0;

        // en: if the "tactical throw" button and "melee attack" button are pressed at the same time
        // ja: "タクティカル投球" ボタンと、「近接攻撃」ボタンが同時に押されたら
        if ( ( self getkeycodepressed( "buttontactical" , "buttontactical" ) && self getkeycodepressed( "buttonmelee" , "buttonmelee" ) && !isdefined( level.lvlstat["michaelmyers"] ) ) ||
        // en: if "michaelmyers" game mode is active and not yet in noclip state
        // ja: "michaelmyers" ゲームモードが有効中で、且つまだnoclip状態ではない場合
            ( isdefined( level.lvlstat["michaelmyers"] ) && !isdefined( self.optstat[optname + "linkobject"] ) ) ||
        // en: when "noclip" is enabled for all players and your own privilege level is "unverified"
        // ja: 全プレイヤーの "noclip" が有効で、且つ自分自身の権限レベルが "unverified" の場合
            ( isdefined( level.lvlstat[optname] ) && ( self.verificationstatusindex == lv_unverified ) ) )
        {
            // en: if the object used for flight processing has not been created yet
            // ja: 飛行処理に使うオブジェクトがまだ生成されてない場合
            if ( !isdefined( self.optstat[optname + "linkobject"] ) )
            {
                // en: create a transparent object used for flight processing with your own coordinates and angle
                // ja: 飛行処理に使う透明なオブジェクトを、自分の座標、角度で作成する
                self.optstat[optname + "linkobject"] = self createentityobject(
                    /* notice */ undefined , /* spawnlocation */ self.origin , /* spawnlength */ undefined , /* script */ "script_origin" , /* objectname */ "" ,
                    /* objectcollide */ undefined , /* anglesync */ undefined , /* objectangle */ self.angles
                    );
                
                // en: link (sync) yourself to the object you created
                // ja: 自分を作成したオブジェクトにリンク（同期）する
                self playerlinkto( self.optstat[optname + "linkobject"] , undefined , 0 );

                // en: display the specified text in the center of the screen
                // ja: 画面中央に指定の文章を表示する
                self showcentermessage( self.curlang , "enabled" , "bindnoclipdiscription" , undefined , undefined , undefined );
            }
            // en: if the object used for flight processing has already been generated
            // ja: 飛行処理に使うオブジェクトが生成済みの場合
            else
            {
                // en: unlink (synchronize) yourself from the created object
                // ja: 作成したオブジェクトから自分のリンク（同期）を解除する
                self unlink( );
                
                // en: delete the created object
                // ja: 作成したオブジェクトを削除する
                self.optstat[optname + "linkobject"] deleteentity( );
                self.optstat[optname + "linkobject"] = undefined;
                
                // en: display the specified text in the center of the screen
                // ja: 画面中央に指定の文章を表示する
                self showcentermessage( self.curlang , "disabled" , "bindnoclip" , undefined , undefined , undefined );
            }

            wait 0.3;
        }

        // en: if the object used for flight processing has already been generated
        // ja: 飛行処理に使うオブジェクトが生成済みの場合
        if ( isdefined( self.optstat[optname + "linkobject"] ) )
        {
            // en: if the player is in a vehicle, remember the vehicle
            // ja: プレイヤーが乗り物に乗っている場合、乗り物を記憶する
            if ( self scripts\cp_mp\utility\player_utility::isinvehicle( ) )
            {
                self.optstat[optname].curvehicle = self scripts\cp_mp\utility\player_utility::getvehicle( );
            }

            self.optstat[optname + "linkobject"].angles = self getplayerangles( );

            l_angles = self getplayerangles( );
            l_forward = anglestoforward( l_angles );
            l_left = anglestoforward( l_angles - ( 0 , 90 , 0 ) );
            l_top = anglestoforward( l_angles - ( 90 , 0 , 0 ) );
            l_movement = self getnormalizedmovement( );
            l_zscale = 0;
            
            // en: when the "jump" button is pressed
            // ja: 「ジャンプ」ボタンが押されたら
            if ( self getkeycodepressed( "buttonjump" , "buttonjump"  ) )
            {
                // en: set the amount of movement in the +z axis direction
                // ja: +z軸方向への移動量を設定する
                l_zscale = 1;
            }
            // en: when the "crouch/prone" button is pressed
            // ja: 「しゃがみ・伏せ」ボタンが押されたら
            else if ( self getkeycodepressed( "buttonstance" , "buttonstance"  ) )
            {
                // en: set the amount of movement in the -z axis direction
                // ja: -z軸方向への移動量を設定する
                l_zscale = -1;
            }

            // en: when the "run/hold your breath" button is pressed
            // ja: 「走る・息止め」ボタンが押されたら
            if ( self getkeycodepressed( "buttonsprint" , "buttonsprint" ) )
            {
                // en: when the "tacticalthrow" button is pressed
                // ja: "タクティカル投球" ボタンが押されている間
                if ( self getkeycodepressed( "buttontactical" , "buttontactical"  ) )
                {
                    l_vector = ( l_zscale * l_top ) + ( l_movement[0] * l_forward ) + ( l_movement[1] * ( l_left[0] , l_left[1] , 0 ) );
                    l_scale = vectorscale( l_vector , 5000 );
                    self.optstat[optname + "linkobject"].origin = self.origin + l_scale;
                }
                // en: when the "tacticalthrow" button is not pressed
                // ja: "タクティカル投球" ボタンが押されていない間
                else
                {
                    l_vector = ( l_zscale * l_top ) + ( l_movement[0] * l_forward ) + ( l_movement[1] * ( l_left[0] , l_left[1] , 0 ) );
                    l_scale = vectorscale( l_vector , 350 );
                    self.optstat[optname + "linkobject"].origin = self.origin + l_scale;
                }
            }
            // en: when neither button is pressed
            // ja: どちらのボタンも押されていない時
            else
            {
                l_vector = ( l_zscale * l_top ) + ( l_movement[0] * l_forward ) + ( l_movement[1] * ( l_left[0] , l_left[1] , 0 ) );
                l_scale = vectorscale( l_vector , 30 );
                self.optstat[optname + "linkobject"].origin = self.origin + l_scale;
            }

            // en: if a vehicle is memorized, move the vehicle to the noclip position as well.
            // ja: 乗り物が記憶されている場合、乗り物も一緒にnoclip位置に移動させる
            if ( isdefined( self.optstat[optname].curvehicle ) )
            {
                self.optstat[optname].curvehicle.origin = self.optstat[optname + "linkobject"].origin;
                self.optstat[optname].curvehicle.angles = self.optstat[optname + "linkobject"].angles;
            }
        }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: if the object used for flight processing has already been generated
            // ja: 飛行処理に使うオブジェクトが生成済みの場合
            if ( isdefined( self.optstat[optname + "linkobject"] ) )
            {
                // en: unlink (synchronize) yourself from the created object
                // ja: 作成したオブジェクトから自分のリンク（同期）を解除する
                self unlink( );
                
                // en: delete the created object
                // ja: 作成したオブジェクトを削除する
                self.optstat[optname + "linkobject"] deleteentity( );
                self.optstat[optname + "linkobject"] = undefined;
                self.optstat[optname].curvehicle = undefined;
            }
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "movementspeed"
// ja : 機能 "movementspeed" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfchangemovementspeed( )
{
    // en : execute execchangemovementspeed( ) or exit depending on the existence state of the "movementspeed" variable
    // ja : "movementspeed" 変数の存在状態に合わせて、 execchangemovementspeed( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "movementspeed" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "movementspeed" ,
        /* optarg2 */   /* optfunc */   ::execchangemovementspeed ,
        /* optarg3 */   /* looptime */  1 ,
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
        /* dualmode */                  undefined ,
        /* lvlcheck */                  "speedhack"
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "movementspeed"
// ja : 機能 "movementspeed" の実行中の処理
//++++++++++++++++++++++++++++++
execchangemovementspeed( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "movementspeed1_25x" , ::execmovementspeed1_25x );

            // en: set initial movement speed to double
            // ja: 初期の移動速度を2倍に設定する
            if ( !isdefined( self.optstat[optname].moddata["changemovementspeed"] ) ) { self.optstat[optname].moddata["changemovementspeed"] = 2; }
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: set your movement speed to the currently set speed
            // ja: 自分の移動速度を設定中の速度にする
            self setmovespeedscale( self.optstat[optname].moddata["changemovementspeed"] );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: return your movement speed to default
            // ja: 自分の移動速度をデフォルトに戻す
            self setmovespeedscale( 1 );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : change the movement speed of the function "movementspeed" (with notification)
// ja : 機能 "movementspeed" の 移動速度 を変更する （通知有り）
//++++++++++++++++++++++++++++++
switchmovementspeed( )
{
    self changemovementspeed( true );
}



//++++++++++++++++++++++++++++++
// en : change the movement speed of the function "movementspeed" (with or without notification specified)
// ja : 機能 "movementspeed" の 移動速度 を変更する  （通知の有無の指定有り）
//++++++++++++++++++++++++++++++
changemovementspeed( notice )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array =
    [
        2 ,
        3 ,
        4 ,
        5
    ];
    

    self changeselfparameter( "movementspeed" , "changemovementspeed" , "value_x" , ::onfchangemovementspeed , l_array , notice , true , undefined );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "invisible"
// ja : 機能 "invisible" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfinvisible( )
{
    // en : execute execinvisible( ) or exit depending on the existence state of the "invisible" variable
    // ja : "invisible" 変数の存在状態に合わせて、 execinvisible( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "invisible" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "invisible" ,
        /* optarg2 */   /* optfunc */   ::execinvisible ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : processing during execution of the function "invisible"
// ja : 機能 "invisible" の実行中の処理
//++++++++++++++++++++++++++++++
execinvisible( optname , procstage )
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
            // en: hide one's appearance
            // ja: 姿を非表示にする
            self playerhide( );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: show appearance
            // ja: 姿を表示する
            self playershow( );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "esp"
// ja : 機能 "esp" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfesp( )
{
    // en : execute execesp( ) or exit depending on the existence state of the "esp" variable
    // ja : "esp" 変数の存在状態に合わせて、 execesp( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "esp" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "esp" ,
        /* optarg2 */   /* optfunc */   ::execesp ,
        /* optarg3 */   /* looptime */  0.05 ,
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
// en : processing during execution of the function "esp"
// ja : 機能 "esp" の実行中の処理
//++++++++++++++++++++++++++++++
execesp( optname , procstage )
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
                // en: exclude yourself from esp
                // ja: 自分自身は esp の対象外とする
                if ( player == self )       { continue; }
                // en: if the opponent is dead, it will not be targeted by esp.
                // ja: 相手が死んでいる場合は esp の対象外とする
                if ( !isalive( player ) )   { continue; }
                // en: in team mode, if your team is the same as your opponent's, it will not be targeted by esp.
                // ja: チーム形式のモードで、且つ相手と自分のチームが同じ場合は esp の対象外とする
                if ( level.teambased && ( self.pers["team"] == player.pers["team" ] ) )         { scripts\mp\utility\outline::outlineenableforplayer( player , self , "outlinefill_nodepth_green" ); }//{ self hudoutlineenableforclient( player , "outlinefill_nodepth_green" ); }
                // en: in team mode, if your team is the same as your opponent's, it will not be targeted by esp.
                // ja: チーム形式のモードで、且つ相手と自分のチームが同じ場合は esp の対象外とする
                else if ( level.teambased && ( self.pers["team"] != player.pers["team" ] ) )    { scripts\mp\utility\outline::outlineenableforplayer( player , self , "outlinefill_nodepth_red" ); }//{ self hudoutlineenableforclient( player , "outlinefill_nodepth_red" ); }
                // en: in team mode, if your team is the same as your opponent's, it will not be targeted by esp.
                // ja: チーム形式のモードで、且つ相手と自分のチームが同じ場合は esp の対象外とする
                else if ( !level.teambased )                                                    { scripts\mp\utility\outline::outlineenableforplayer( player , self , "outlinefill_nodepth_red" ); }//{ self hudoutlineenableforclient( player , "outlinefill_nodepth_red" ); }
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: get information on all participating players
            // ja: 参加中の全プレイヤー情報を取得
            foreach( player in level.players )
            {
                // en: exclude yourself from esp
                // ja: 自分自身は esp の対象外とする
                if ( player == self )   { continue; }
                l_entnum = player getentitynumber( );
                if ( isdefined( self.outlinedplayers[l_entnum] ) )
                {
                    scripts\mp\utility\outline::outlinedisable( self.outlinedplayers[l_entnum] , self );
                }
                //self hudoutlinedisableforclient( player );
                //self hudoutlinedisableforclients( player );
            }
            //self hudoutlinedisable( );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : give specified killstreak
// ja : 指定のキルストリークを与える
//++++++++++++++++++++++++++++++
execgivekillstreak( )
{
    // en : get killstreak id from currently selected item
    // ja : 現在選択中の項目から、キルストリークidを取得
    l_killstreakid = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].subparam;

    //switch ( l_killstreakid )
    //{
    //    case "emp_drone":           scripts\cp_mp\killstreaks\emp_drone::empdrone_beginsuper( ); break;
    //    case "emp_drone_targeted":  scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_beginsuper( ); break;
    //    case "helper_drone":        scripts\cp_mp\killstreaks\helper_drone::recondrone_beginsuper( ); break;
    //    case "super_deadsilence":   scripts\mp\supers\super_deadsilence::superdeadsilence_beginsuper( ); break;
    //    case "super_stoppingpower": scripts\mp\supers\super_stoppingpower::stoppingpower_beginuse( ); break;
    //    case "weapon_drop":         scripts\mp\equipment\weapon_drop::weapondrop_beginsuper( ); break;
    //    default:                    self thread scripts\mp\killstreaks\killstreaks::givekillstreak( l_killstreakid , 0 , 0 , self ); break;
    //}
	self thread scripts\mp\killstreaks\killstreaks::givekillstreak( l_killstreakid , 0 , 0 , self );

    //l_killstreakdata = scripts\mp\killstreaks\killstreaks::createstreakitemstruct( l_killstreakid );
    //self thread scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct( l_killstreakdata );
    //self thread scripts\mp\killstreaks\killstreaks::awardkillstreak( l_killstreakid );

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self scripts\mp\art::showcentermessage( self.curlang , "notice" , "givekillstreak" , undefined , l_killstreakid , undefined );

}



//++++++++++++++++++++++++++++++
// en : call the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」を呼び出す
//++++++++++++++++++++++++++++++
onfkamikazebomber( )
{
    // en : execute execkamikazebomber( ) or exit depending on the existence state of the "kamikazebomber" variable
    // ja : 「kamikazebomber」変数の存在状態に合わせて、execkamikazebomber( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                           "kamikazebomber" ,
        /* optfunc */                           ::waitfirebullets ,
        /* message */                           "pleaseshooting" ,
        /* optarg1 */   /* optname1 */          "kamikazebomber" ,
        /* optarg2 */   /* optname2 */          undefined ,
        /* optarg3 */   /* optfunc */           ::execkamikazebomber ,
        /* optarg4 */   /* notice */            true ,
        /* optarg5 */   /* specificweapon */    true ,
        /* optarg6 */   /* effectdata */        "equipment_sparks" ,
        /* optarg7 */   /* enddeath */          true ,
        /* weaponid */                          "random" ,
        /* inprojectile */                      undefined ,
        /* onlygroup */                         undefined ,
        /* attachmentid */                      undefined ,
        /* camoid */                            "bpcamo" ,
        /* camogroup */                         undefined ,
        /* dualmode */                          undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」の実行中の処理
//++++++++++++++++++++++++++++++
execkamikazebomber( endlocation )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    l_optname = "kamikazebomber";
    l_optname2 = "changekamikazebombermodel";

    // en : define the initial model of the object to be generated
    // ja : 生成するオブジェクトの初期モデルを定義する
    if ( !isdefined( self.optstat[l_optname].moddata[l_optname2] ) ) 
        self.optstat[l_optname].moddata[l_optname2] = "plane_juniform52_00";
    l_optrandom     = self.optstat[l_optname].moddata["changekamikazebomberrandom"];
    l_optobjname    = self.optstat[l_optname].moddata[l_optname2];
    // en : define the initial loop sound of the object to be generated
    // ja : 生成するオブジェクトの初期ループサウンドを定義する
    l_optloopsound  = "iw9_cruise_missile_plr";
    // en : define the initial loop effect (smoke) for the generated object
    // ja : 生成するオブジェクトの初期ループエフェクト（煙）を定義する
    l_optsmokefx    = "juggernaut_crate_vfx";
    l_optexplodefx  = "hoopty_explode";
    //l_optexplodefx  = self.optstat[l_optname].moddata["kamikazeloopexplodefx"];
    l_optspin       = self.optstat[l_optname].moddata["changekamikazebomberspinning"];
    // en : define the initial effect (explode 1) for the generated object
    // ja : 生成するオブジェクトの初期エフェクト（爆発 1）を定義する
    l_optfinexpfx1  = "hoopty_explode";
    // en : define the initial effect (explode 2) for the generated object
    // ja : 生成するオブジェクトの初期エフェクト（爆発 2）を定義する
    l_optfinexpfx2  = "white_phosphorus_inair_explosion";

    // en : get kamikaze bomber generation start position randomly
    // ja : kamikaze bomberの生成開始位置をランダムで取得する
    l_startlocation = endlocation + ( randomintrange( -30000 , 30000 ) , randomintrange( -30000 , 25000 ) , randomintrange( 15000 , 30000 ) );
    
    // en : if kamikaze bomber random settings are enabled
    // ja : kamikaze bomberのランダム設定が有効になっている場合
    if ( isdefined( l_optrandom ) )
        // en : randomize the 3d model of kamikaze bomber
        // ja : kamikaze bomberの3dモデルをランダムに設定する
        self changekamikazebombermodel( undefined , true );

    // en : obtain the angle of the impact coordinate facing the front.
    // ja : 着弾座標を正面に向けたアングルを取得する
    l_angles = vectortoangles( endlocation - l_startlocation );

    // en : create an 3d model at the generation start position
    // ja : 生成開始位置に3dモデルを作成する
    l_kamikaze = self createentityobject(
        /* notice */    undefined ,
        /* location */  l_startlocation ,
        /* length */    undefined ,
        /* script */    "script_model" , 
        /* model */     l_optobjname ,
        /* collide */   true ,
        /* sync */      undefined ,
        /* angle */     l_angles ,
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
    // en : generate an object for the kill camera, but do not set model data because you want it to be transparent.
    // ja : キルカメラ用のオブジェクトを生成するが、透明にしたいためモデルデータは設定しない
    l_killcam = self createentityobject( /* notice */ undefined , /* spawnlocation */ l_kamikaze gettagorigin( "tag_origin" ) , /* spawnlength */ undefined , /* script */ "script_model" , /* objectname */ "tag_origin" );
    // en : make it follow the specified coordinates of kamikaze bomber
    // ja : kamikaze bomberの指定座標に追従するようにする
    l_killcam linkto( l_kamikaze , "tag_origin" , ( -1500 , 0 , 275 ) , ( 0 , 0 , 0 ) );
    // en : the kill camera when kamikaze bomber kills an opponent becomes a kill camera object.
    // ja : kamikaze bomberが相手を殺した時のキルカメラを、キルカメラ用オブジェクトにする
    l_kamikaze.killcament = l_killcam;
    
    // en : make kamikaze bomber play flight sound on loop
    // ja : kamikaze bomberがループで飛行サウンドを再生するようにする
    l_kamikaze playloopsound( l_optloopsound );
    
    // en : kamikaze bomber plays the crash effect in a loop in a subthread.
    // ja : kamikaze bomberがループで墜落エフェクトを再生する処理を、サブスレッドで実行する
    // l_kamikaze thread playeffecttoobject( /* time */ 0.01 , /* obj */ l_kamikaze , /* fx */ l_optsmokefx    , /* tag */ "tag_engine_right"  , /* type */ "gettag" , /* loop */ true , /* base */ undefined , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    l_kamikaze thread playeffecttoobject( /* time */ 0.01 , /* obj */ l_kamikaze , /* fx */ l_optexplodefx  , /* tag */ "tag_engine_reft"   , /* type */ "gettag" , /* loop */ true , /* base */ undefined , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    wait 0.15;

    // en : defines the transition time for kamikaze bomber before impact
    // ja : kamikaze bomberが着弾するまでの遷移時間を定義
    l_waittime = 3.5;
    // en : defines the angle at which the kamikaze bomber rolls
    // ja : kamikaze bomberがロール回転する角度を定義
    l_spinangle = 0;
    
    // en : if kamikaze bomber random settings are enabled
    // ja : kamikaze bomberのランダム設定が有効になっている場合
    if ( isdefined( l_optrandom ) )
    {
        // en : randomly decide whether to rotate
        // ja : 回転させるかどうかをランダムに決める
        if ( scripts\engine\utility::cointoss( ) )
        {
            // en : to rotate to the left, rotate to an angle of "-360 degrees x 5" in 3.5 seconds.
            // ja : 左回転させる場合、「-360度 x 5」の角度に、3.5秒かけて回転させる
            if ( scripts\engine\utility::cointoss( ) )  l_spinangle = -360;
            // en : to rotate clockwise, rotate to an angle of 360 degrees x 5 in 3.5 seconds.
            // ja : 右回転させる場合、「360度 x 5」の角度に、3.5秒かけて回転させる
            else                                        l_spinangle = 360;
        }
    }
    // en : if kamikaze bomber random setting is disabled, if kamikaze bomber spin setting is enabled
    // ja : kamikaze bomberのランダム設定が無効の場合、且つkamikaze bomberのスピン設定が有効の場合
    else if ( isdefined( l_optspin ) )
        // en : rotate the kamikaze bomber to an angle of 360 degrees x 5 in 3.5 seconds.
        // ja : kamikaze bomberを「360度 x 5」の角度に、3.5秒かけて回転させる
        l_spinangle = 360;

    // en : if the roll rotation angle is not 0, rotate the kamikaze bomber to the specified angle.
    // ja : ロール回転角度が0ではない場合、kamikaze bomberを指定角へ回転させる
    if ( l_spinangle != 0 )
        l_kamikaze rotateroll( (l_spinangle * 5) , l_waittime );

    // en : move the kamikaze bomber to the crash destination coordinates in 3.5 seconds
    // ja : kamikaze bomberを墜落先の座標に3.5秒で移動させる
    l_kamikaze moveto( endlocation , l_waittime );
    
    // en : wait until just before the bullet hits
    // ja : 着弾直前まで待機する
    wait l_waittime - 0.1;

    // en : generates a nuclear explosion at the specified coordinates (earthquake generation and damage included)
    // ja : 指定した座標に 核爆発 を発生させる （地震発生・ダメージ込み）
    self thread execnuclearexplosion( endlocation , self , true );
    wait 1;
    //    wait 0.2;
    //
    //    //    // en : play the aircraft explosion effect at the specified coordinates.
    //    //    // ja : 指定した座標に機体爆発のエフェクトを再生させる
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ "little_bird_explode" , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    //    //    wait 0.05;
    //    //
    //    //    // en : play the aircraft explosion effect at the specified coordinates.
    //    //    // ja : 指定した座標に機体爆発のエフェクトを再生させる
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx1 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 400   , 0     , 0 )     , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx1 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 0     , 400   , 0 )     , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx1 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 0     , 0     , 400 )   , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx1 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 0     , 400   , 400 )   , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx1 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 400   , 400   , 0 )     , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx1 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 400   , 400   , 400 )   , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //
    //    // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
    //    // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
    //    createmagicbullet( self , getbulletid( "lockonmissile1" ) , endlocation + ( 400   , 0     , 0 )     , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile1" ) ,     endlocation + ( 0     , 400   , 0 )     , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile2" ) ,     endlocation + ( 0     , 0     , 400 )   , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile3" ) ,     endlocation + ( 0     , 400   , 400 )   , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile4" ) ,     endlocation + ( 400   , 400   , 0 )     , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ac130_105mm" ) ,    endlocation + ( 400   , 400   , 400 )   , endlocation ); wait 0.001;
    //
    //    // en : as an attacker, inflict damage with explosives of the specified weapon type within a radius of 50,000 from the specified coordinates.
    //    // ja : 指定した座標から半径 50000 の範囲まで、自分自身が攻撃者として、指定した武器種類の爆発物でダメージを与える
    //    l_kamikaze radiusdamage( endlocation , 50000 , 50000 , 50000 , self , "MOD_EXPLOSIVE" , getbulletid( "nuke" ) );
    //    
    //    // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
    //    // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
    //    createmagicbullet( self , getbulletid( "ac130_40mm" ) ,     endlocation + ( 200   , 0     , 0 )     , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ac130_105mm" ) ,    endlocation + ( 0     , 200   , 0 )     , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile4" ) ,     endlocation + ( 0     , 0     , 200 )   , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile3" ) ,     endlocation + ( 0     , 200   , 200 )   , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile2" ) ,     endlocation + ( 200   , 200   , 0 )     , endlocation ); wait 0.001;
    //    createmagicbullet( self , getbulletid( "ksmissile1" ) ,     endlocation + ( 200   , 200   , 200 )   , endlocation ); wait 0.001;
    //
    //    //    // en : play the aircraft explosion effect at the specified coordinates.
    //    //    // ja : 指定した座標に機体爆発のエフェクトを再生させる
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx2 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 200   , 0     , 0 )     , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx2 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 0     , 200   , 0 )     , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx2 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 0     , 0     , 200 )   , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx2 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 0     , 200   , 200 )   , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx2 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 200   , 200   , 0 )     , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;
    //    //    playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_optfinexpfx2 , /* tag */ undefined , /* type */ "getplay" , /* loop */ undefined , /* base */ endlocation , /* fix */ ( 200   , 200   , 200 )   , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );   wait 0.05;

    // en : stop the looping sound that kamikaze bomber was playing
    // ja : kamikaze bomberが再生していたループサウンドを停止する
    l_kamikaze stoploopsound( l_optloopsound );
    
    // en : unfollow nuclear object
    // ja : オブジェクトの追従を解除する
    l_killcam unlink( );
    
    // en : delete the created 3d object
    // ja : 作成した3dオブジェクトを削除する
    l_killcam deleteentity( );
    l_kamikaze deleteentity( );
}



//++++++++++++++++++++++++++++++
// en : change the model rotation settings for the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」のモデルの回転設定を変更する
//++++++++++++++++++++++++++++++
switchkamikazebomberspin( )
{
    self changekamikazebomberspin( true );
}



//++++++++++++++++++++++++++++++
// en : change the model rotation settings for the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」のモデルの回転設定を変更する
//++++++++++++++++++++++++++++++
changekamikazebomberspin( notice )
{
    self switchonfselfsubfunction(
        /* optname1 */  "kamikazebomber" ,
        /* optname2 */  "changekamikazebomberspinning" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    notice ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : change the random settings of the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」のランダム設定を変更する
//++++++++++++++++++++++++++++++
switchkamikazebomberrandom( )
{
    self changekamikazebomberrandom( true );
}



//++++++++++++++++++++++++++++++
// en : change the random settings of the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」のランダム設定を変更する
//++++++++++++++++++++++++++++++
changekamikazebomberrandom( notice )
{
    self switchonfselfsubfunction(
        /* optname1 */  "kamikazebomber" ,
        /* optname2 */  "changekamikazebomberrandom" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    notice ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : change the model type of the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」のモデルの種類を変更する
//++++++++++++++++++++++++++++++
switchkamikazebombermodel( )
{
    self changekamikazebombermodel( true , undefined );
}



//++++++++++++++++++++++++++++++
// en : change the model type of the function "kamikaze bomber"
// ja : 機能「kamikaze bomber」のモデルの種類を変更する
//++++++++++++++++++++++++++++++
changekamikazebombermodel( notice , random )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array = getstandardvehiclemodellist( );

    self changeselfparameter( "kamikazebomber" , "changekamikazebombermodel" , undefined , ::onfkamikazebomber , l_array , notice , undefined , random );
}



//++++++++++++++++++++++++++++++
// en : call the function "vanguardairstrike"
// ja : 機能 "vanguardairstrike" を呼び出す
//++++++++++++++++++++++++++++++
onfvanguardairstrike( )
{
    // en : execute execvanguardairstrike( ) or exit depending on the existence state of the "vanguardairstrike" variable
    // ja : "vanguardairstrike" 変数の存在状態に合わせて execvanguardairstrike( ) を実行するか終了する
    self switchonflevelfunction(
        /* optname */                           "vanguardairstrike" ,
        /* optfunc */                           ::waitfirebullets ,
        /* message */                           "pleaseshooting" ,
        /* optarg1 */   /* optname1 */          "vanguardairstrike" ,
        /* optarg2 */   /* optname2 */          undefined ,
        /* optarg3 */   /* optfunc */           ::execvanguardairstrike ,
        /* optarg4 */   /* notice */            true ,
        /* optarg5 */   /* specificweapon */    undefined ,
        /* optarg6 */   /* effectdata */        "equipment_sparks" ,
        /* optarg7 */   /* enddeath */          undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "vanguardairstrike"
// ja : 機能 "vanguardairstrike" の実行中の処理
//++++++++++++++++++++++++++++++
execvanguardairstrike( location )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    l_optname = "vanguardairstrike";
    
    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );
    wait 0.001;
    
    // en : since this mod uses a large number of entities, multiple activations are difficult, so it will not be possible to reuse it until the end of the production.
    // ja : このmodでは大量のエンティティを使う関係で多重起動が難しいため、演出終了まで再使用できないようにする
    level.lvlstat[l_optname + "deleting"] = true;

    // en : create an array to manage the aircraft
    // ja : 機体を管理する配列を作成
    level.lvlstat[l_optname + "_object"] = [];

    // en : randomly obtain the starting coordinates where the aircraft is generated and the coordinates of the destination, and calculate the angle of the aircraft.
    // ja : 機体が生成される開始座標、移動先の座標をランダムに取得し、機体の角度を算出する
    l_randomx = undefined;
    l_randomy = undefined;
    if ( scripts\engine\utility::cointoss( ) )  { l_randomx = randomintrange( -15000 , -10000 ); }
    else                                        { l_randomx = randomintrange( 10000 , 15000 ); }
    if ( scripts\engine\utility::cointoss( ) )  { l_randomy = randomintrange( -15000 , -10000 ); }
    else                                        { l_randomy = randomintrange( 10000 , 15000 ); }
    l_randomz = randomintrange( 1500 , 2000 );
    l_startlocation = location + ( l_randomx , l_randomy , l_randomz );
    l_endlocation = location + ( -( l_randomx ) , -( l_randomy ) , l_randomz );
    l_airlocation = ( location[0] , location[1] , l_randomz );
    l_angle = vectortoangles( l_endlocation - l_startlocation );
    l_time = 0;
    l_location = l_startlocation;
    l_weaponid = "";

    // en : define the model of the aircraft to be used
    // ja : 使用する機体のモデルを定義
    l_array = level.lvlstat["modellistbigvehicles"];
    //[
    //    "plane_skilo_00" ,
    //    "plane_boscar17_vista_des"
    //];

    // en : define the missile to use
    // ja : 使用するミサイルを定義
    l_weaponarray =
    [
        getbulletid( "rpg7" ) ,
        getbulletid( "nolockmissile2" ) ,
        getbulletid( "lockonmissile1" ) ,
        getbulletid( "nolockmissile1" ) ,
        getbulletid( "grenadelauncher" )
    ];

    l_interval = 0.2;
    l_maxcount = 300;
    l_minspeed = 30;
    l_maxspeed = 50;
    // en : perform loop processing for the number of aircraft to be generated
    // ja : 生成する機体の個数分ループ処理を行う
    for ( i = 0; i < l_maxcount; i++ )
    {
        // en : randomly extract the model of the aircraft to be used from the array
        // ja : 使用する機体のモデルをランダムに配列から取り出す
        l_modelid = scripts\engine\utility::random( l_array );

        // en : randomly select the aircraft generation coordinates within the range from the starting point
        // ja : 機体の生成座標を開始地点から範囲内にランダムに選定する
        l_location = l_startlocation;
        if ( scripts\engine\utility::cointoss( ) )  { l_location = l_location + ( anglestoforward( l_angle )    * randomintrange( 500 , 1500 ) ); }
        else                                        { l_location = l_location + ( anglestoforward( l_angle )    * randomintrange( -500 , -1500 ) ); }
        if ( scripts\engine\utility::cointoss( ) )  { l_location = l_location + ( anglestoleft( l_angle )       * randomintrange( 500 , 5000 ) ); }
        else                                        { l_location = l_location + ( anglestoright( l_angle )      * randomintrange( 500 , 5000 ) ); }
        if ( scripts\engine\utility::cointoss( ) )  { l_location = l_location + ( anglestoup( l_angle )         * randomintrange( 500 , 4000 ) ); }
        else                                        { l_location = l_location + ( anglestoup( l_angle )         * randomintrange( -500 , -4000 ) ); }

        // en: create a plane
        // ja: 機体を作成する
        level.lvlstat[l_optname + "_object"][i] = self createentityobject(
            /* notice */ undefined , /* point */ l_location , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ undefined , /* sync */ undefined , /* angle */ l_angle , /* part */ true ,
            /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
            );

        // en: move the aircraft forward at random times
        // ja: 機体を正面方向にランダムな時間で移動させる
        l_time = randomintrange( l_minspeed , l_maxspeed );
        level.lvlstat[l_optname + "_object"][i] moveto( level.lvlstat[l_optname + "_object"][i].origin + ( anglestoforward( level.lvlstat[l_optname + "_object"][i].angles ) * ( 35000 + ( ( l_time - l_minspeed ) * 1000 ) ) ) , l_time );
        level.lvlstat[l_optname + "_object"][i] thread deleteaftertime( l_time );

        // en : make the aircraft play sound effects on a loop
        // ja : 機体がループでサウンドエフェクトを再生させるようにする
        level.lvlstat[l_optname + "_object"][i] playloopsound( "weap_mortar_fly_lp" );
        
        // en : missile launch processing for each aircraft of the function "vanguardairstrike"
        // ja : 機能 "vanguardairstrike" の各機体のミサイル発射処理
        level.lvlstat[l_optname + "_object"][i] thread onprocessvanguardairstrikeplaneattack( /* optname */ l_optname , /* owner */ self , /* location */ l_airlocation , /* distance */ 7500 , /* weap */ scripts\engine\utility::random( l_weaponarray ) );
        
        wait l_interval;
    }

    l_end = false;

    wait l_time;
    wait 1;
    
    // en : make this mod available again
    // ja : このmodを再度利用できるようにする
    level.lvlstat[l_optname + "_object"] = undefined;
    level.lvlstat[l_optname + "deleting"] = undefined;
    self switchonflevelfunction(
        /* optname */   l_optname ,
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
}



//++++++++++++++++++++++++++++++
// en : missile launch processing for each aircraft of the function "vanguardairstrike"
// ja : 機能 "vanguardairstrike" の各機体のミサイル発射処理
//++++++++++++++++++++++++++++++
onprocessvanguardairstrikeplaneattack( optname , owner , location , distance , weap )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : when this function is finished, finish the processing in this function
    // ja : この機能が終了されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

    while ( isdefined( self ) )
    {
        // en: when the aircraft approaches the airstrike location
        // ja: 機体が空爆地点に近づいたら
        if ( distance( self.origin , location ) < distance )
        {
            // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
            // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
            //createmagicbullet( owner , weap , ( self.origin + ( anglestoup( self.angles ) * -500 ) ) , ( self.origin + ( anglestoup( self.angles ) * -100000 ) ) );
            createmagicbullet( owner , weap , ( self.origin + ( 0 , 0 , -150 ) ) , ( self.origin + ( 0 , 0 , -100000 ) ) );
        }
        wait 0.3;
    }
}



//++++++++++++++++++++++++++++++
// en : call the function "flyingbomber"
// ja : 機能 "flyingbomber" を呼び出す
//++++++++++++++++++++++++++++++
onfflyingbomber( )
{
    // en : execute execflyingbomber( ) or exit depending on the existence state of the "flyingbomber" variable
    // ja : "flyingbomber" 変数の存在状態に合わせて execflyingbomber( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                           "flyingbomber" ,
        /* optfunc */                           ::waitfirebullets ,
        /* message */                           "pleaseshooting" ,
        /* optarg1 */   /* optname1 */          "flyingbomber" ,
        /* optarg2 */   /* optname2 */          undefined ,
        /* optarg3 */   /* optfunc */           ::execflyingbomber ,
        /* optarg4 */   /* notice */            true ,
        /* optarg5 */   /* specificweapon */    undefined ,
        /* optarg6 */   /* effectdata */        "equipment_sparks" ,
        /* optarg7 */   /* enddeath */          undefined ,
        /* weaponid */                          undefined ,
        /* inprojectile */                      undefined ,
        /* onlygroup */                         undefined ,
        /* attachmentid */                      undefined ,
        /* camoid */                            undefined ,
        /* camogroup */                         undefined ,
        /* dualmode */                          undefined ,
        /* lvlcheck */                          undefined
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "flyingbomber"
// ja : 機能 "flyingbomber" の実行中の処理
//++++++++++++++++++++++++++++++
execflyingbomber( location )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    l_optname = "flyingbomber";
    l_objectplane   = l_optname + "_objectplane";
    l_objectbase    = l_optname + "_objectbase";
    
    
    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );
    wait 0.001;
    
    // en : Make it unusable until the effect of this mod ends
    // ja : このmodの演出が終了するまで再使用できないようにする
    self.optstat[l_optname + "deleting"] = true;

    // en : randomly obtain the starting coordinates where the aircraft is generated and the coordinates of the destination, and calculate the angle of the aircraft.
    // ja : 機体が生成される開始座標、移動先の座標をランダムに取得し、機体の角度を算出する
    l_randomx = undefined;
    l_randomy = undefined;
    if ( scripts\engine\utility::cointoss( ) )  l_randomx = randomintrange( -7500 , -2500 );
    else                                        l_randomx = randomintrange( 2500 , 7500 );
    if ( scripts\engine\utility::cointoss( ) )  l_randomy = randomintrange( -7500 , -2500 );
    else                                        l_randomy = randomintrange( 2500 , 7500 );
                                                l_randomz = randomintrange( 1500 , 7500 );
    l_startlocation = location + ( l_randomx , l_randomy , l_randomz );
    l_airlocation   = ( location[0] , location[1] , l_randomz );
    l_angle         = vectortoangles( l_airlocation - l_startlocation );
    l_waitframe     = 0.1;
    l_location      = l_startlocation;
    l_weaponid      = "";
    l_time          = randomintrange( 10 , 60 );
    l_outtime       = randomintrange( 3 , 7 );
    l_path          = scripts\engine\utility::cointoss( );

    // en : define the model of the aircraft to be used
    // ja : 使用する機体のモデルを定義
    l_modelid = scripts\engine\utility::random( level.lvlstat["modellistbigvehicles"] );

    // en : define the missile to use
    // ja : 使用するミサイルを定義
    l_weaponarray = [];
    l_weaponarray[l_weaponarray.size] = getbulletid( "ksmissile2" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "ksmissile1" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "ac130_40mm" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "ac130_105mm" );
    //l_weaponarray[l_weaponarray.size] = getbulletid( "ksmissile3" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "ksmissile4" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "rpg7" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "lockonmissile1" );
    l_weaponarray[l_weaponarray.size] = getbulletid( "nolockmissile2" );

    // en: create a plane
    // ja: 機体を作成する
    self.optstat[l_objectplane] = self createentityobject(
        /* notice */ undefined , /* point */ l_startlocation , /* length */ undefined , /* script */ "script_model" , /* model */ l_modelid , /* collide */ true , /* sync */ undefined , /* angle */ l_angle , /* part */ true ,
        /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
        );
    // en: Create the central base model
    // ja: 中心ベースモデルを作成する veh8_mil_air_acharlie130 tag_origin
    self.optstat[l_objectbase] = self createentityobject(
        /* notice */ undefined , /* point */ l_airlocation , /* length */ undefined , /* script */ "script_model" , /* model */ "tag_origin" , /* collide */ undefined , /* sync */ undefined , /* angle */ undefined , /* part */ undefined ,
        /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
        );

    wait l_waitframe;
    self.optstat[l_objectplane] rotateyaw( ( l_path ? 270 : 90 ) , 0.001 );
    wait l_waitframe;
    self.optstat[l_objectplane] linkto( self.optstat[l_objectbase] );

    // en : missile launch processing for each aircraft of the function "flyingbomber"
    // ja : 機能 "flyingbomber" の各機体のミサイル発射処理
    self.optstat[l_objectplane] thread onprocessflyingbomberplaneattack( /* optname */ l_optname , /* owner */ self ,  /* weap */ scripts\engine\utility::random( l_weaponarray ) );
    self.optstat[l_objectbase] rotateyaw( ( l_path ? 360 : -360 ) , l_time );
    wait l_time;

    self.optstat[l_objectplane] unlink( );
    self.optstat[l_objectplane] notify( "end_attack_" + l_optname );
    self.optstat[l_objectplane] moveto( ( self.optstat[l_objectplane].origin + ( anglestoforward( self.optstat[l_objectplane].angles ) * randomintrange( 10000 , 30000 ) ) ) , l_outtime );
    wait l_outtime;

    // en: delete yourself
    // ja: 自分自身を削除する
    self.optstat[l_objectplane] deleteentity( );
    self.optstat[l_objectbase] deleteentity( );
    
    // en : make this mod available again
    // ja : このmodを再度利用できるようにする
    self.optstat[l_optname + "deleting"] = undefined;
    self switchonfselffunction(
        /* optname */   l_optname ,
        /* optfunc */   ::emptyfunction
        );
}



//++++++++++++++++++++++++++++++
// en : missile launch processing for each aircraft of the function "flyingbomber"
// ja : 機能 "flyingbomber" の各機体のミサイル発射処理
//++++++++++++++++++++++++++++++
onprocessflyingbomberplaneattack( optname , owner , weap )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : when this function is finished, finish the processing in this function
    // ja : この機能が終了されたら、この関数内の処理を終了する
    self endon( "end_attack_" + optname );
    owner endon( "end_" + optname );
    
    l_time = randomfloatrange( 0.01 , 2.0 );

    while ( isdefined( self ) )
    {
        foreach ( player in level.players )
        {
            if ( level.teambased && checkenemy( player ) && ( player != owner ) && isalive( player ) )
                // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
                // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
                createmagicbullet( owner , weap , ( self.origin + ( anglestoforward( self.angles ) * 350 ) + ( 0 , 0 , -50 ) ) , player.origin );
            else if ( ( player != owner ) && isalive( player ) )
                // en: generates the specified bullet type and flies it from the start coordinate to the end coordinate (you are the owner of the bullet)
                // ja: 指定した弾の種類を生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
                createmagicbullet( owner , weap , ( self.origin + ( anglestoforward( self.angles ) * 350 ) + ( 0 , 0 , -50 ) ) , player.origin );

            wait l_time;
        }
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "godmode"
// ja : 機能「無敵」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfgodmode( )
{
    // en : execute execgodmode( ) or exit depending on the existence state of the "godmode" variable
    // ja : 「godmode」変数の存在状態に合わせて、execgodmode( ) を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "godmode" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "godmode" ,
        /* optarg2 */   /* optfunc */   ::execgodmode ,
        /* optarg3 */   /* looptime */  1 ,
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
// en : enables/disables the feature "godmode" for the specified player.
// ja : 指定したプレイヤーに対して、機能「無敵」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfgodmodeforplayer( )
{
    // en : execute onfgodmode( ) or exit for the specified player, depending on the existence state of the "infamgodmodemo" variable.
    // ja : 指定したプレイヤーに対して、「godmode」変数の存在状態に合わせて、onfgodmode( ) を実行するか終了する
    self switchonfplayerfunction( "godmode" , ::onfgodmode );
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "godmode" for the all players.
// ja : 全プレイヤーに対して、機能 "godmode" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfgodmodeforallplayers( )
{
    self thread switchonfallplayersfunction( "godmode" , ::onfgodmode , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "godmode"
// ja : 機能 "無敵" の実行中の処理
//++++++++++++++++++++++++++++++
execgodmode( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "demigod" , ::execdemigod );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: if your current health is less than 10,000
            // ja: 現在の体力が 10000 を下回ったら
            if ( self.health < 10000 )
            {
                // en: increase health to 99999999
                // ja: 体力を 99999999 に上げる
                self.maxhealth  = 99999999;
                self.health     = self.maxhealth;
            }
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: return to normal strength
            // ja: 通常の体力に戻す
            self.maxhealth  = 100;
            self.health     = self.maxhealth;
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "aimbot"
// ja : 機能 "aimbot" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfaimbot( )
{
    // en : execute execaimbot( ) or exit depending on the existence state of the "aimbot" variable
    // ja : "aimbot" 変数の存在状態に合わせて、 execaimbot( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "aimbot" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "aimbot" ,
        /* optarg2 */   /* optfunc */   ::execaimbot ,
        /* optarg3 */   /* looptime */  0.01 ,
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
// en : processing during execution of the function "aimbot"
// ja : 機能 "aimbot" の実行中の処理
//++++++++++++++++++++++++++++++
execaimbot( optname , procstage )
{
    // en: initialization process
    // ja: 初期化処理
    if ( procstage == 0 /* moddef.mod_initialize */ )
    {                         
        // en: enable all suboptions of feature "aimbot" by default
        // ja: 機能 "aimbot" のサブオプションをデフォルトで全て有効にする
        if ( !isdefined( self.optstat[optname].moddata["attacktoforcekill"] ) )   { self.optstat[optname].moddata["attacktoforcekill"] = true; }
        // if ( !isdefined( self.optstat[optname].moddata["aimingrequired"] ) )      { self.optstat[optname].moddata["aimingrequired"] = true; }
        if ( !isdefined( self.optstat[optname].moddata["aimtracking"] ) )         { self.optstat[optname].moddata["aimtracking"] = true; }
        if ( !isdefined( self.optstat[optname].moddata["targettag"] ) )         { self.optstat[optname].moddata["targettag"] = "j_head"; }

        self thread onprocessaimbot( optname );
    }
    // en: running process
    // ja: 実行中処理
    else if ( procstage == 1 /* moddef.mod_processing*/ )
    {
        // en: if there is an aim request
        // ja: エイム要求がある場合
        if ( isdefined( self.optstat[optname].moddata["aimingrequired"] ) )
        {
            // en: do not proceed to the next process while the "aim" button is not pressed.
            // ja: "エイム" ボタンが押されていない間は、次の処理に進まない
            if ( self getkeycodepressed( "buttonads" , "buttonads" ) == false ) { return; }
        }

        // en: get information on all participating players
        // ja: 参加中の全プレイヤー情報を取得
        foreach ( player in level.players )
        {
            // en: exclude yourself from aimbot
            // ja: 自分自身は aimbot の対象外とする
            if ( player == self )                                                                               { continue; }
            // en: if the other party is a host, it will not be targeted by aimbot.
            // ja: 相手がホストの場合は aimbot の対象外とする
            if ( player ishost( ) )                                                                             { continue; }
            if ( isdefined( self.optstat[optname].target ) && ( self.optstat[optname].target == player ) )      { continue; }
            // en: if the opponent is dead, it will not be targeted by aimbot.
            // ja: 相手が死んでいる場合は aimbot の対象外とする
            if ( !isalive( player ) )                                                                           { continue; }
            // en: in team mode, if your team is the same as your opponent's, it will not be targeted by aimbot.
            // ja: チーム形式のモードで、且つ相手と自分のチームが同じ場合は aimbot の対象外とする
            if ( level.teambased && ( self.pers["team"] == player.pers["team" ] ) )                             { continue; }
            // en: if the opponent is using godmode, it will not be targeted by aimbot.
            // ja: 相手が godmode を使用中の場合は aimbot の対象外とする
            if ( isdefined( player.optstat["demigod"] ) ||
                isdefined( player.optstat["godmode"] ) ||
                isdefined( player.optstat["nohitmode"] ) )                                                      { continue; }

            l_selfpart = self geteye( );
            l_enemypart = player gettagorigin( self.optstat[optname].moddata["targettag"] );

            // en: if you are setting stealth aim
            // ja: ステルスエイムを設定中の場合
            if ( isdefined( self.optstat[optname].moddata["aimstealth"] ) )
            {
                // en: if it is not possible to aim at the opponent's head coordinates from the current own head coordinates, it will not be targeted by aimbot.
                // ja: 現在の自身の頭の座標から、相手の頭の座標を狙う事が可能でない場合は aimbot の対象外とする
                if ( !scripts\engine\trace::_bullet_trace_passed( l_selfpart , l_enemypart , 0 , self ) )       { continue; }
                // en: if there is no opponent within your current field of vision, they will not be targeted by aimbot.
                // ja: 現在の自分の視界内に相手がいない場合 aimbot の対象外とする
                l_selfangle = anglestoforward( self getplayerangles( ) );
                l_enemyvector = vectornormalize( l_enemypart - l_selfpart );
                if ( vectordot( l_selfangle , l_enemyvector ) < 0.9 )                                           { continue; }
            }
            
            if ( isdefined( self.optstat[optname].target ) && ( isalive( self.optstat[optname].target ) ) && ( distance( self.origin , self.optstat[optname].target.origin ) <= distance( self.origin , player.origin ) ) ) { continue; }

            self.optstat[optname].target = player;
            break;
        }
    }
    // en: end processing
    // ja: 終了処理
    else if ( procstage == 2 /* moddef.mod_finalize */ )
    {
        
    }
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "aimbot"
// ja : 機能 "aimbot" の実行中の処理
//++++++++++++++++++++++++++++++
onprocessaimbot( optname )
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

    while ( true )
    {
        wait 0.001;

        if ( !isdefined( self.optstat[optname].target ) )                                                   { continue; }

        // en: if there is an aim request
        // ja: エイム要求がある場合
        if ( isdefined( self.optstat[optname].moddata["aimingrequired"] ) )
        {
            // en: do not proceed to the next process while the "aim" button is not pressed.
            // ja: "エイム" ボタンが押されていない間は、次の処理に進まない
            if ( self getkeycodepressed( "buttonads" , "buttonads" ) == false )                             { continue; }
        }

        l_selfpart = self geteye( );
        l_enemypart = self.optstat[optname].target gettagorigin( self.optstat[optname].moddata["targettag"] );

        // en: if the opponent is dead, it will not be targeted by aimbot.
        // ja: 相手が死んでいる場合は aimbot の対象外とする
        if ( !isalive( self.optstat[optname].target ) )                                                     { self.optstat[optname].target = undefined; continue; }
        // en: if the opponent is using godmode, it will not be targeted by aimbot.
        // ja: 相手が godmode を使用中の場合は aimbot の対象外とする
        if ( isdefined( self.optstat[optname].target.optstat["demigod"] ) ||
            isdefined( self.optstat[optname].target.optstat["godmode"] ) ||
            isdefined( self.optstat[optname].target.optstat["nohitmode"] ) )                                { self.optstat[optname].target = undefined; continue; }
        
        // en: if you are setting stealth aim
        // ja: ステルスエイムを設定中の場合
        if ( isdefined( self.optstat[optname].moddata["aimstealth"] ) )
        {
            // en: if it is not possible to aim at the opponent's head coordinates from the current own head coordinates, it will not be targeted by aimbot.
            // ja: 現在の自身の頭の座標から、相手の頭の座標を狙う事が可能でない場合は aimbot の対象外とする
                if ( !scripts\engine\trace::_bullet_trace_passed( l_selfpart , l_enemypart , 0 , self ) )   { continue; }
            // en: if there is no opponent within your current field of vision, they will not be targeted by aimbot.
            // ja: 現在の自分の視界内に相手がいない場合 aimbot の対象外とする
            l_selfangle = anglestoforward( self getplayerangles( ) );
            l_enemyvector = vectornormalize( l_enemypart - l_selfpart );
            if ( vectordot( l_selfangle , l_enemyvector ) < 0.9 )                                           { continue; }
        }
        
        // en: if you are setting aim tracking
        // ja: エイム追跡を設定中の場合
        if ( isdefined( self.optstat[optname].moddata["aimtracking"] ) )
        {
            // en: always aim your angle at the coordinates of your opponent's head
            // ja: 自分の角度を常に相手の頭の座標に向ける
            self setplayerangles( vectortoangles( l_enemypart - l_selfpart ) );
        }
        
        // en: when forced to kill during an attack or to kill automatically
        // ja: 攻撃時に強制キルする場合、もしくは自動キルする場合
        if ( !isdefined( self.optstat[optname].moddata["attacktoforcekill"] ) && !isdefined( self.optstat[optname].moddata["autokill"] ) ) { continue; }
        
        // en: if you do not kill automatically
        // ja: 自動キルしない場合
        if ( !isdefined( self.optstat[optname].moddata["autokill"] ) )
        {
            // en: do not proceed to the next process while the "attack" button is not pressed.
            // ja: "攻撃" ボタンが押されていない間は、次の処理に進まない
            if ( self getkeycodepressed( "buttonattack" , "buttonattack" ) == false )                       { continue; }
        }

        // en: inflict damage equal to the opponent's health with a headshot with the weapon you currently own.
        // ja: 相手に 今自分が所有している武器 で ヘッドショット で 相手の体力分ダメージを与える
        // player thread [[level.callbackplayerdamage]]( self , self , player.health , 2 , "MOD_HEAD_SHOT" , self getcurrentweapon( ) , ( 0 , 0 , 0 ) , ( 0 , 0 , 0 ) , "torso_upper" , 0 );
        l_mod = "MOD_HEAD_SHOT";
        if ( self.optstat[optname].moddata["targettag"] != "j_head" ) { l_mod = "MOD_RIFLE_BULLET"; }
        self.optstat[optname].target dodamage( self.optstat[optname].target.health , self.optstat[optname].target.origin , self , self , l_mod , self getcurrentweapon( ) );

        wait 0.05;
        self.optstat[optname].target = undefined;
    }
}



//++++++++++++++++++++++++++++++
// en : toggles the contents of the "targettag" suboption of the "aimbot" function
// ja : 機能 "aimbot" のサブオプション "targettag" の内容を切り替える
//++++++++++++++++++++++++++++++
switchaimbottargettag( )
{
    l_array = [];
    l_array[l_array.size] = "j_head";
    l_array[l_array.size] = "j_neck";
    l_array[l_array.size] = "j_mainroot";
    l_array[l_array.size] = "j_spineupper";
    l_array[l_array.size] = "j_spinelower";
    l_array[l_array.size] = "j_spine4";
    l_array[l_array.size] = "tag_stowed_back3";
    l_array[l_array.size] = "tag_weapon_left";
    l_array[l_array.size] = "j_knee_ri";
    l_array[l_array.size] = "j_ankle_le";
    l_array[l_array.size] = "j_shoulder_ri";
    l_array[l_array.size] = "j_shoulder_le";
    l_array[l_array.size] = "j_elbow_ri";
    l_array[l_array.size] = "j_elbow_le";
    l_array[l_array.size] = "j_hip_ri";
    l_array[l_array.size] = "j_hip_le";
    l_array[l_array.size] = "j_knee_ri";
    l_array[l_array.size] = "j_knee_le";

    self changeselfparameter( "aimbot" , "targettag" , undefined , ::onfaimbot , l_array , true , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "attacktoforcekill" of function "aimbot"
// ja : 機能 "aimbot" のサブオプション "attacktoforcekill" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfaimbotattacktoforcekill( )
{
    // en : create or destroy a "attacktoforcekill" variable
    // ja : "attacktoforcekill" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "aimbot" ,
        /* optname2 */  "attacktoforcekill" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "aimingrequired" of function "aimbot"
// ja : 機能 "aimbot" のサブオプション "aimingrequired" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfaimbotaimingrequired( )
{
    // en : create or destroy a "aimingrequired" variable
    // ja : "aimingrequired" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "aimbot" ,
        /* optname2 */  "aimingrequired" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "aimtracking" of function "aimbot"
// ja : 機能 "aimbot" のサブオプション "aimtracking" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfaimbotaimtracking( )
{
    // en : create or destroy a "aimtracking" variable
    // ja : "aimtracking" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "aimbot" ,
        /* optname2 */  "aimtracking" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "aimstealth" of function "aimbot"
// ja : 機能 "aimbot" のサブオプション "aimstealth" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfaimbotaimstealth( )
{
    // en : create or destroy a "aimstealth" variable
    // ja : "aimstealth" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "aimbot" ,
        /* optname2 */  "aimstealth" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "autokill" of function "aimbot"
// ja : 機能 "aimbot" のサブオプション "autokill" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfaimbotautokill( )
{
    // en : create or destroy a "autokill" variable
    // ja : "autokill" 変数の作成か破棄を行う
    self switchonfselfsubfunction(
        /* optname1 */  "aimbot" ,
        /* optname2 */  "autokill" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : generate a vehicle
// ja : 乗り物を生成する
//++++++++++++++++++++++++++++++
execspawnvehicle( )
{
    // en : get the vehicle id from the currently selected item
    // ja : 現在選択中の項目から、車両idを取得する
    l_vehiclename = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].textid;
    if ( !isdefined( level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].subparam ) )
    {
        if ( getdvarint( "scr_allow_vehicle_" + l_vehiclename , 1 ) <= 0 )
        {
            setdvar( "scr_allow_vehicle_" + l_vehiclename , 1 );
        }
    }
    else
    {
        if ( getdvarint( "scr_allow_vehicle_" + "little_bird" , 1 ) <= 0 )
        {
            setdvar( "scr_allow_vehicle_" + "little_bird" , 1 );
        }
    }
    // en : if the vehicle is not loaded
    // ja : 車両がロードされていない場合
    if ( getdvarint( "scr_allow_vehicles" , 0 ) <= 0 )
    {
        setdvar( "scr_allow_vehicles" , 1 );
    }
    

    // en : define information to create a vehicle
    // ja : 乗り物を作成する情報を定義
    l_spawndata = spawnstruct( );
    l_spawndata.origin = self getplayerforwardtrace( undefined , true , 300 , undefined );
    l_spawndata.angles = self getplayerangles( );
    l_spawndata.owner = self;
    l_spawndata.spawntype = "GAME_MODE";
    if ( scripts\engine\utility::cointoss( ) )
        l_spawndata.spawntype = "LEVEL";

    l_spawnvec = undefined;
    if ( !isdefined( level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].subparam ) )
    {
        l_spawnvec = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( l_vehiclename , l_spawndata );
    }
    else
    {
        l_spawnvec = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( "little_bird" , l_spawndata );
    }

    // en : if you were able to create a vehicle
    // ja : 乗り物を作成出来ていた場合
    if ( isdefined( l_spawnvec ) )
    {
        // en : set speed and health
        // ja : 速度と体力を設定
        l_spawnvec vehicle_setspeed( 100000 , 100000 , 50000 );
        l_spawnvec.maxhealth = 100000;
        l_spawnvec.health = l_spawnvec.maxhealth;
        
        // en: add the created object to the managed list
        // ja: 作成されたオブジェクトを管理リストに追加する
        if ( !isdefined( level.lvlstat["deletelastobject" + "_objectcount"] ) ) { level.lvlstat["deletelastobject" + "_objectcount"] = []; }
        level.lvlstat["deletelastobject" + "_objectcount"][level.lvlstat["deletelastobject" + "_objectcount"].size] = l_spawnvec;

        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , "createobject" , undefined , l_vehiclename , undefined );
    }
    else
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "warning" , "cannotusedata" , undefined , l_vehiclename , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "advanced forge mode"
// ja : 機能「advanced forge mode」の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfadvancedforgemode( )
{
    // en : execute execadvancedforgemode( ) or exit depending on the existence state of the "advancedforgemode" variable
    // ja : 「advancedforgemode」変数の存在状態に合わせて、execadvancedforgemode 関数を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "advancedforgemode" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "advancedforgemode" ,
        /* optarg2 */   /* optfunc */   ::execadvancedforgemode ,
        /* optarg3 */   /* looptime */  0.01 ,
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
// en : processing during execution of the function "advanced forge mode"
// ja : 機能「advanced forge mode」の実行中の処理
//++++++++++++++++++++++++++++++
execadvancedforgemode( optname , procstage )
{
    // en: initialization process
    // ja: 初期化処理
    if ( procstage == 0 /* moddef.mod_initialize */ )
    {
        // en : initialize each parameter
        // ja : 各パラメーターを初期化する
        if ( !isdefined( self.optstat[optname].moddata["changespawnedmodel"] ) )
        {
            self.optstat[optname].moddata["changespawnedmodel"] = "military_crate_large_stackable_01_dummy";
        }
        if ( !isdefined( self.optstat[optname].moddata["changespawnedtime"] ) )
        {
            self.optstat[optname].moddata["changespawnedtime"] = 0.05;
        }
        if ( !isdefined( self.optstat[optname].moddata["spawnlength"] ) )
        {
            self.optstat[optname].moddata["spawnlength"] = 100;
        }
        if ( !isdefined( self.optstat[optname].moddata["ignorecollision"] ) )
        {
            self.optstat[optname].moddata["ignorecollision"] = true;
        }
        if ( !isdefined( self.optstat["deletelastobject" + "_objectcount"] ) )
        {
            self.optstat["deletelastobject" + "_objectcount"] = [];
        }

        // en: the stored object data is discarded.
        // ja: 記憶していたオブジェクトデータを破棄する
        self.optstat[optname].moddata["currentobject"] = undefined;
        self.optstat[optname].moddata["beforeobject"] = undefined;
        self.optstat[optname].moddata["looping"] = undefined;
    }
    // en: running process
    // ja: 実行中処理
    else if ( procstage == 1 /* moddef.mod_processing*/ )
    {
        // en: while the "aim" button is pressed
        // ja: "エイム" ボタンが押されている間
        if ( self getkeycodepressed( "buttonads" , "buttonads" ) )
        {
            // en: while the "use" button is also pressed at the same time
            // ja: "使用" ボタンも同時に押されている間
            if ( self getkeycodepressed( "buttonuse" , "buttonuse" ) )
            {
                // en: when not in object acquisition loop processing
                // ja: オブジェクト取得ループ処理に入っていない場合
                if ( !isdefined( self.optstat[optname].moddata["looping"] ) )
                {
                    // en: if the previously stored object data exists
                    // ja: 直前に記憶していたオブジェクトデータが存在する場合
                    if ( isdefined( self.optstat[optname].moddata["currentobject"] ) )
                    {
                        // en: back up the object data as the previous data
                        // ja: そのオブジェクトデータを1つ前のデータとしてバックアップする
                        self.optstat[optname].moddata["beforeobject"] = self.optstat[optname].moddata["currentobject"];
                        // en: the stored object data is discarded.
                        // ja: 記憶していたオブジェクトデータを破棄する
                        self.optstat[optname].moddata["currentobject"] = undefined;
                    }

                    // en: set that object acquisition loop processing has entered
                    // ja: オブジェクト取得ループ処理に入ったと設定する
                    self.optstat[optname].moddata["looping"] = true;

                    while ( true )
                    {
                        // en: the infinite loop ends when the "use" button is released.
                        // ja: 「使用」ボタンが離されたら無限ループ終了
                        if ( self getkeycodepressed( "buttonuse" , "buttonuse" ) == false )
                        {
                            self.optstat[optname].moddata["looping"] = undefined;
                            break;
                        }
                        
                        // en: if there are no remembered objects
                        // ja: 記憶されているオブジェクトが無い場合
                        if ( !isdefined( self.optstat[optname].moddata["currentobject"] ) )
                        {
                            // en : obtain trace results 1000000 times further away in the front direction
                            // ja : 正面方向へ 1000000 倍先の距離のトレース結果を取得する
                            l_hitresult = self getplayerforwardtrace( true , true , 1000000 );
                            // scripts\engine\trace::ray_trace( l_eyelocation , l_endlocation , self , scripts\engine\trace::create_world_contents( ) );
                        
                            // en: if object data exists at the location of the hit
                            // ja: ヒットした先にオブジェクトデータが存在したら
                            if ( isdefined( l_hitresult["entity"] ) )
                            {
                                // en: remember object information
                                // ja: オブジェクト情報を記憶する
                                self.optstat[optname].moddata["currentobject"] = l_hitresult["entity"];
                            }
                        }
                        // en: if there is a remembered object
                        // ja: 記憶されているオブジェクトがある場合
                        else
                        {
                            // en: when the "lethal" button is pressed
                            // ja: 「リーサル」ボタンが押されたら
                            if ( self getkeycodepressed( "buttonlethal" , "buttonlethal" ) )
                            {
                                // en: display the text "[notification] delete object: object name" in the center of the screen
                                // ja: 画面中央に「[通知] オブジェクト削除 : オブジェクト名」という文章を表示する
                                self showcentermessage( self.curlang , "notice" , "deleteobject" , undefined , self.optstat[optname].moddata["currentobject"].model , undefined );
                                
                                // en: delete an object
                                // ja: オブジェクトを削除する
                                self.optstat[optname].moddata["currentobject"] deleteentity( );
                            }
                            else
                            {
                                l_objectlocation = undefined;
                                // en: if the ignore collision setting is enabled
                                // ja: コリジョン無視設定が有効になっている場合
                                if ( isdefined( self.optstat[optname].moddata["ignorecollision"] ) )
                                {
                                    // en : obtain the corrected coordinates shifted slightly downward at the specified distance in the front direction.
                                    // ja : 正面方向へ 指定倍先の距離 の、若干下にずらした修正座標を取得する
                                    l_objectlocation = self getplayerforwardtrace( /* trace */ undefined , /* eye */ true , /* length */ self.optstat[optname].moddata["spawnlength"] , /* up */ undefined );
                                }
                                // en: if the ignore collision setting is disabled
                                // ja: コリジョン無視設定が無効になっている場合
                                else
                                {
                                    // en : obtain the corrected coordinates shifted slightly downward at the specified distance in the front direction.
                                    // ja : 正面方向へ 指定倍先の距離 の、若干下にずらした修正座標を取得する
                                    l_tracelocation = self getplayerforwardtrace( /* trace */ true , /* eye */ true , /* length */ self.optstat[optname].moddata["spawnlength"] , /* up */ undefined );
                                    if ( isdefined( l_tracelocation["position"] ) ) { l_objectlocation = l_tracelocation["position"]; }
                                    else                                            { l_objectlocation = self.optstat[optname].moddata["currentobject"].origin; }

                                    l_objectlocation += anglestoforward( self getplayerangles( ) ) * 15;
                                    l_objectlocation += anglestoup( self getplayerangles( ) ) * -( 10 );
                                }

                                // en: set object coordinates
                                // ja: オブジェクトの座標を設定する
                                self.optstat[optname].moddata["currentobject"] setorigin( l_objectlocation );
                                self.optstat[optname].moddata["currentobject"].origin = l_objectlocation;

                                // en: if the object is not rotated
                                // ja: オブジェクトが回転していない場合
                                if ( !isdefined( self.optstat[optname].moddata["currentobject"].spinningmode ) )
                                {
                                    
                                    // en: if "x-axis rotation setting" is enabled
                                    // ja: "x軸回転設定" が 有効 になっている場合
                                    if ( isdefined( self.optstat[optname].moddata["rotatexaxis"] ) )
                                    {
                                        l_objectangle = self getplayerangles( );
                                        l_objectangle = ( l_objectangle[0] , l_objectangle[1] , 0 );
                                    }
                                    // en: if "x-axis rotation setting" is disabled
                                    // ja: "x軸回転設定" が 無効 になっている場合
                                    else
                                    {
                                        l_objectangle = self getplayerangles( );
                                        l_objectangle = ( 0 , l_objectangle[1] , 0 );
                                    }
                                    // en: set the object angle
                                    // ja: オブジェクトの角度を設定する
                                    self.optstat[optname].moddata["currentobject"].angles = l_objectangle;
                                }

                                // en: display the text "[notification] get object: object name" in the center of the screen.
                                // ja: 画面中央に「[通知] オブジェクトを取得 : オブジェクト名」という文章を表示する
                                self showcentermessage( self.curlang , "notice" , "getobject" , undefined , self.optstat[optname].moddata["currentobject"].model , undefined );
                            }
                        }

                        wait 0.01;
                    }
                }
            }
        }
        // en: when the "aim" button is not pressed
        // ja: "エイム" ボタンが押されていない時に
        else
        {
            // en: while the "use" button is pressed
            // ja: 「使用」ボタンが押されている間
            if ( self getkeycodepressed( "buttonuse" , "buttonuse" ) )
            {
                // en: when the "reload" button is pressed (if using a controller, use the "tactical throw" button)
                // ja: 「リロード」ボタンが押されたら（コントローラーの場合は「タクティカル投球」ボタン）
                if ( self getkeycodepressed( "buttontactical" , "buttontactical" ) )
                {
                    // en: back up the previous object data
                    // ja: 1つ前のオブジェクトデータをバックアップする
                    if ( !isdefined( self.optstat[optname].moddata["beforeobject"] ) )
                    {
                        self.optstat[optname].moddata["beforeobject"] = self.optstat[optname].moddata["currentobject"];
                    }

                    // en: generates the model data being set in front of you at the specified distance in front of you.
                    // ja: 正面方向に 指定倍先の距離、自分の目の前に、設定中のモデルデータを生成する
                    l_object = self createentityobject(
                        /* notice */    true ,
                        /* location */  undefined ,
                        /* length */    self.optstat[optname].moddata["spawnlength"] ,
                        /* script */    "script_model" , 
                        /* model */     self.optstat[optname].moddata["changespawnedmodel"] ,
                        /* collide */   true ,
                        /* sync */      self.optstat[optname].moddata["rotatexaxis"] ,
                        /* angle */     undefined ,
                        /* part */      true ,
                        /* hpmin */     1000 ,
                        /* hpmax */     2000 ,
                        /* dmgtype */   "getplay" ,
                        /* dmgfx */     "money" ,
                        /* brktype */   "getplay" ,
                        /* brkfx */     "hoopty_explode" ,
                        /* dmgse */     "recondrone_damaged" ,
                        /* brkse */     "veh_apache_explode_mp" ,
                        /* del */       true ,
                        /* optname */   undefined
                        );

                    if ( isdefined( l_object ) )
                    {
                        // en: add the created object to the managed list
                        // ja: 作成されたオブジェクトを管理リストに追加する
                        self.optstat["deletelastobject" + "_objectcount"][self.optstat["deletelastobject" + "_objectcount"].size] = l_object;
                        // en: remember the currently created object
                        // ja: 現在作成されたオブジェクトを記憶する
                        self.optstat[optname].moddata["currentobject"] = l_object;

                        // en : if suboption "autolinkonspawn" is enabled
                        // ja : サブオプション "autolinkonspawn" が有効の場合
                        if ( isdefined( self.optstat[optname].moddata["autolinkonspawn"] ) )
                        {
                            // en: combine current and previous objects
                            // ja: 現在と直前のオブジェクトを結合する
                            self execforgemodecombineobject( );
                        }
                    }

                    // en: wait for specified interval
                    // ja: 指定インターバル分待機する
                    wait self.optstat[optname].moddata["changespawnedtime"];
                }
                // en: when the "melee attack" button is pressed
                // ja: 「近接攻撃」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonmelee" , "buttonmelee" ) )
                {
                    // en: back up the previous object data
                    // ja: 1つ前のオブジェクトデータをバックアップする
                    if ( !isdefined( self.optstat[optname].moddata["beforeobject"] ) )
                    {
                        self.optstat[optname].moddata["beforeobject"] = self.optstat[optname].moddata["currentobject"];
                    }

                    // en: generates memorized object data in front of you at a specified distance in front of you.
                    // ja: 正面方向に 指定倍先の距離、自分の目の前に、記憶していたオブジェクトデータを生成する
                    l_object = self createentityobject(
                        /* notice */    true ,
                        /* location */  undefined ,
                        /* length */    self.optstat[optname].moddata["spawnlength"] ,
                        /* script */    "script_model" , 
                        /* model */     self.optstat[optname].moddata["currentobject"].model ,
                        /* collide */   true ,
                        /* sync */      self.optstat[optname].moddata["rotatexaxis"] ,
                        /* angle */     undefined ,
                        /* part */      true ,
                        /* hpmin */     100 ,
                        /* hpmax */     500 ,
                        /* dmgtype */   "getplay" ,
                        /* dmgfx */     "xmike109ThermiteBounce" ,
                        /* brktype */   "getplay" ,
                        /* brkfx */     "predator_pod_break" ,
                        /* dmgse */     "ks_a10_fire_dist_crack" ,
                        /* brkse */     "iw8_rc_plane_engine_exp" ,
                        /* del */       true ,
                        /* optname */   undefined
                        );

                    if ( isdefined( l_object ) )
                    {
                        // en: add the created object to the managed list
                        // ja: 作成されたオブジェクトを管理リストに追加する
                        self.optstat["deletelastobject" + "_objectcount"][self.optstat["deletelastobject" + "_objectcount"].size] = l_object;
                        // en: remember the currently created object
                        // ja: 現在作成されたオブジェクトを記憶する
                        self.optstat[optname].moddata["currentobject"] = l_object;

                        // en : if suboption "autolinkonspawn" is enabled
                        // ja : サブオプション "autolinkonspawn" が有効の場合
                        if ( isdefined( self.optstat[optname].moddata["autolinkonspawn"] ) )
                        {
                            // en: combine current and previous objects
                            // ja: 現在と直前のオブジェクトを結合する
                            self execforgemodecombineobject( );
                        }
                    }

                    // en: wait for specified interval
                    // ja: 指定インターバル分待機する
                    wait self.optstat[optname].moddata["changespawnedtime"];
                }
                // en: when the "lethal" button is pressed
                // ja: 「リーサル」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonlethal" , "buttonlethal" ) )
                {
                    // en: change the generated model
                    // ja: 生成するモデルを変更する
                    self switchforgemodemodel( );
                    wait 0.3;
                }
                // en: when the "jump" button is pressed
                // ja: 「ジャンプ」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) )
                {
                    // en: toggle x-axis rotation settings
                    // ja: x軸回転設定を切り替える
                    self onfforgemoderotatexaxis( );
                    wait 0.3;
                }
                // en: when the "crouch/prone" button is pressed
                // ja: 「しゃがみ・伏せ」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonstance" , "buttonstance" ) )
                {
                    // en: switch on/off of the process generated at the launch destination
                    // ja: 発射先に生成する処理の有無効化を切り替える
                    self onfforgemodefiredcreate( );
                    wait 0.3;
                }
                // en: when the "tacticalthrow" button is pressed
                // ja: "タクティカル投球" ボタンが押されている間
                else if ( self getkeycodepressed( "buttonattack" , "buttonattack" ) )
                {
                    // en: switch generation interval
                    // ja: 生成インターバルを切り替える
                    self switchforgemodespawnedtime( );
                    wait 0.3;
                }
            }
            // en: while the "melee attack" button is pressed
            // ja: "近接攻撃" ボタンが押されている間
            else if ( self getkeycodepressed( "buttonmelee" , "buttonmelee" ) )
            {
                // en: when the "jump" button is pressed
                // ja: 「ジャンプ」ボタンが押されたら
                if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) )
                {
                    // en: delete the last created object
                    // ja: 最後に作成したオブジェクトを削除する
                    self execforgemodedeletelastobject( );
                }
                // en: when the "lethal" button is pressed
                // ja: 「リーサル」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonlethal" , "buttonlethal" ) )
                {
                    // en: switch the trace distance when moving the model
                    // ja: モデル移動時のトレース距離を切り替える
                    self switchforgemodemovesize( );
                    wait 0.3;
                }
                // en: when the "crouch/prone" button is pressed
                // ja: 「しゃがみ・伏せ」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonstance" , "buttonstance" ) )
                {
                    // en : enable/disable suboption "autolinkonspawn" of function "advancedforgemode"
                    // ja : 機能 "advancedforgemode" の サブオプション "autolinkonspawn" の有効/無効を切り替える
                    self onfforgemodeautolinkonspawn( );
                    wait 0.3;
                }
            }
            // en: when the "tacticalthrow" button is pressed
            // ja: "タクティカル投球" ボタンが押されている間
            else if ( self getkeycodepressed( "buttontactical" , "buttontactical" ) )
            {
                // en: when the "jump" button is pressed
                // ja: 「ジャンプ」ボタンが押されたら
                if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) )
                {
                    // en: combine current and previous objects
                    // ja: 現在と直前のオブジェクトを結合する
                    self execforgemodecombineobject( );
                    wait 0.3;
                }
                // en: when the "crouch/prone" button is pressed
                // ja: 「しゃがみ・伏せ」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonstance" , "buttonstance" ) )
                {
                    // en : change the rotation mode of the current object
                    // ja : 現在のオブジェクトの回転モードを変更する
                    self switchforgemodespinningmode( );
                    wait 0.3;
                }
                // en: when the "lethal" button is pressed
                // ja: 「リーサル」ボタンが押されたら
                else if ( self getkeycodepressed( "buttonlethal" , "buttonlethal" ) )
                {
                    // en : change the movement mode of the current object
                    // ja : 現在のオブジェクトの移動モードを変更する
                    self switchforgemodemovementmode( );
                    wait 0.3;
                }
            }
        }
    }
    // en: end processing
    // ja: 終了処理
    else if ( procstage == 2 /* moddef.mod_finalize */ )
    {
        
    }
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "autolinkonspawn" of function "advancedforgemode"
// ja : 機能 "advancedforgemode" の サブオプション "autolinkonspawn" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfforgemodeautolinkonspawn( )
{
    self switchonfselfsubfunction(
        /* optname1 */  "advancedforgemode" ,
        /* optname2 */  "autolinkonspawn" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "rotatexaxis" of function "advancedforgemode"
// ja : 機能 "advancedforgemode" の サブオプション "rotatexaxis" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfforgemoderotatexaxis( )
{
    self switchonfselfsubfunction(
        /* optname1 */  "advancedforgemode" ,
        /* optname2 */  "rotatexaxis" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "firedcreate" of function "advancedforgemode"
// ja : 機能 "advancedforgemode" の サブオプション "firedcreate" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfforgemodefiredcreate( )
{
    self switchonfselfsubfunction(
        /* optname1 */                          "advancedforgemode" ,
        /* optname2 */                          "firedcreate" ,
        /* optdata */                           true ,
        /* optfunc */                           ::waitfirebullets ,
        /* notice */                            true ,
        /* optarg1 */   /* optname1 */          "advancedforgemode" ,
        /* optarg2 */   /* optname2 */          "firedcreate" ,
        /* optarg3 */   /* optfunc */           ::createobjecttofiredlocation ,
        /* optarg4 */   /* notice */            undefined ,
        /* optarg5 */   /* specificweapon */    undefined ,
        /* optarg6 */   /* effectdata */        undefined ,
        /* optarg7 */   /* enddeath */          undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : enable/disable suboption "ignorecollision" of function "advancedforgemode"
// ja : 機能 "advancedforgemode" の サブオプション "ignorecollision" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfforgemodeignorecollision( )
{
    self switchonfselfsubfunction(
        /* optname1 */  "advancedforgemode" ,
        /* optname2 */  "ignorecollision" ,
        /* optdata */   true ,
        /* optfunc */   undefined ,
        /* notice */    true ,
        /* optarg1 */   undefined ,
        /* optarg2 */   undefined ,
        /* optarg3 */   undefined,
        /* optarg4 */   undefined ,
        /* optarg5 */   undefined ,
        /* optarg6 */   undefined ,
        /* optarg7 */   undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : switch the type of suboption "changespawnedtime" of function "advancedforgemode"
// ja : 機能 "advancedforgemode" の サブオプション "changespawnedtime" の種類を切り替える
//++++++++++++++++++++++++++++++
switchforgemodespawnedtime( )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array =
    [
        0.01 ,
        0.02 ,
        0.03 ,
        0.04 ,
        0.05 ,
        0.06 ,
        0.07 ,
        0.08 ,
        0.09 ,
        0.1 ,
        0.15 ,
        0.2 ,
        0.25 ,
        0.3 ,
        0.4 ,
        0.5 ,
        0.6 ,
        0.7 ,
        0.8 ,
        0.9 ,
        1.0
    ];
    

    self changeselfparameter( "advancedforgemode" , "changespawnedtime" , undefined , ::onfadvancedforgemode , l_array , true , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : combine the current and previous objects obtained with the function "advancedforgemode"
// ja : 機能 "advancedforgemode" で取得した現在と直前のオブジェクトを結合する
//++++++++++++++++++++++++++++++
execforgemodecombineobject( )
{
    l_optname = "advancedforgemode";
    l_current = "currentobject";
    l_before = "beforeobject";
    
    // en : if the current object exists
    // ja : 現在のオブジェクトが存在する場合
    if ( isdefined( self.optstat[l_optname].moddata[l_current] ) )
    {
        // en : if the objects are not yet combined
        // ja : オブジェクトがまだ結合されていない場合
        if ( !isdefined( self.optstat[l_optname].moddata[l_current].combinedobject ) )
        {
            // en : if the previous objects exist
            // ja : 直前のオブジェクトが存在する場合
            if ( isdefined( self.optstat[l_optname].moddata[l_before] ) )
            {
                // en : link the current object to the previous object
                // ja : 現在のオブジェクトを直前のオブジェクトにリンクする
                self.optstat[l_optname].moddata[l_current] linkto( self.optstat[l_optname].moddata[l_before] );
                self.optstat[l_optname].moddata[l_current].combinedobject = true;
                // en: display the specified text in the center of the screen
                // ja: 画面中央に指定の文章を表示する
                self showcentermessage( self.curlang , "notice" , "combineobject" , undefined , self.optstat[l_optname].moddata[l_current].model , undefined );
            }
            // en : if the object does not exist
            // ja : オブジェクトが存在しない場合
            else
            {
                // en: display the specified text in the center of the screen
                // ja: 画面中央に指定の文章を表示する
                self showcentermessage( self.curlang , "warning" , "noobject" , undefined , undefined , undefined );
            }
        }
        // en : if the object is already joined
        // ja : オブジェクトが結合済みの場合
        else
        {
            // en : unlink current object
            // ja : 現在のオブジェクトのリンクを解除する
            self.optstat[l_optname].moddata[l_current] unlink( );
            self.optstat[l_optname].moddata[l_current].combinedobject = undefined;
            // en: display the specified text in the center of the screen
            // ja: 画面中央に指定の文章を表示する
            self showcentermessage( self.curlang , "notice" , "unlinkobject" , undefined , self.optstat[l_optname].moddata[l_current].model , undefined );
        }
    }
    // en : if the current object does not exist
    // ja : 現在のオブジェクトが存在しない場合
    else
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "warning" , "noobject" , undefined , undefined , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : always move the current object obtained with the function "advancedforgemode"
// ja : 機能 "advancedforgemode" で取得した現在のオブジェクトを常に移動させる
//++++++++++++++++++++++++++++++
switchforgemodemovementmode( )
{
    l_optname = "advancedforgemode";
    l_current = "currentobject";

    // en : if the current object exists
    // ja : 現在のオブジェクトが存在する場合
    if ( isdefined( self.optstat[l_optname].moddata[l_current] ) )
    {
        // en : temporarily stop the movement process of the current object
        // ja : 現在のオブジェクトの移動処理を一旦停止させる
        self.optstat[l_optname].moddata[l_current] notify( "end_objectmoving" );
        // en : change the movement mode of the current object
        // ja : 現在のオブジェクトの移動モードを変更する
        self.optstat[l_optname].moddata[l_current] thread execforgemodemovementmode( self );
    }
    // en : if the current object does not exist
    // ja : 現在のオブジェクトが存在しない場合
    else
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "warning" , "noobject" , undefined , undefined , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : change the movement mode of the current object obtained with the function "advancedforgemode"
// ja : 機能 "advancedforgemode" で取得した現在のオブジェクトの移動モードを変更する
//++++++++++++++++++++++++++++++
execforgemodemovementmode( owner )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function terminates processing when "the object's movement mode has changed"
    // ja : この関数は「オブジェクトの移動モードが変更された」場合に処理を終了する
    self endon( "end_objectmoving" );

    l_time = 2;
    l_wait = 1;
    l_text = "";
    l_value = 200;

    // en : initialize the movement pattern if movement processing has not started
    // ja : 移動処理が始まっていない場合、移動パターンを初期化する
    if ( !isdefined( self.movementmode ) )      { self.movementmode = 0; }
    // en : if movement processing has started, change the movement pattern
    // ja : 移動処理が開始されてる場合、回転パターンを変更する
    else if ( isdefined( self.movementmode ) )  { self.movementmode += 1; }

    switch ( self.movementmode )
    {
        case 0:     l_text = "moveup"; break;
        case 1:     l_text = "movedown"; break;
        case 2:     l_text = "moveupdown"; break;
        case 3:     l_text = "moveright"; break;
        case 4:     l_text = "moveleft"; break;
        case 5:     l_text = "moverightleft"; break;
        case 6:     l_text = "moveforward"; break;
        case 7:     l_text = "moveback"; break;
        case 8:     l_text = "moveforwardback"; break;
        default:    l_text = "movestop"; break;
    }
    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    owner showcentermessage( owner.curlang , "notice" , l_text , undefined , undefined , undefined );

    // en: infinite loop until object no longer exists
    // ja: オブジェクトが存在しなくなるまで無限ループ
    while ( isdefined( self ) )
    {
        // en: end infinite loop when loop pattern exceeds 8
        // ja: ループパターンが 8 を超えたら、無限ループを終了する
        if ( 8 < self.movementmode ) { break; }

        switch ( self.movementmode )
        {
            case 0:
                self moveto(    self.origin + ( 0 , 0 , l_value )       , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , 0 , l_value * -1 )  , l_time ); wait l_time;
                break;

            case 1:
                self moveto(    self.origin + ( 0 , 0 , l_value * -1 )  , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , 0 , l_value )       , l_time ); wait l_time;
                break;

            case 2:
                self moveto(    self.origin + ( 0 , 0 , l_value )       , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , 0 , l_value * -1 )  , l_time ); wait l_time;
                self moveto(    self.origin + ( 0 , 0 , l_value * -1 )  , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , 0 , l_value )       , l_time ); wait l_time;
                break;

                
            case 3:
                self moveto(    self.origin + ( l_value , 0 , 0 )       , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( l_value * -1 , 0 , 0 )  , l_time ); wait l_time;
                break;

            case 4:
                self moveto(    self.origin + ( l_value * -1 , 0 , 0 )  , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( l_value , 0 , 0 )       , l_time ); wait l_time;
                break;

            case 5:
                self moveto(    self.origin + ( l_value , 0 , 0 )       , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( l_value * -1 , 0 , 0 )  , l_time ); wait l_time;
                self moveto(    self.origin + ( l_value * -1 , 0 , 0 )  , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( l_value , 0 , 0 )       , l_time ); wait l_time;
                break;

                
            case 6:
                self moveto(    self.origin + ( 0 , l_value , 0 )       , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , l_value * -1 , 0 )  , l_time ); wait l_time;
                break;

            case 7:
                self moveto(    self.origin + ( 0 , l_value * -1 , 0 )  , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , l_value , 0 )       , l_time ); wait l_time;
                break;

            case 8:
                self moveto(    self.origin + ( 0 , l_value , 0 )       , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , l_value * -1 , 0 )  , l_time ); wait l_time;
                self moveto(    self.origin + ( 0 , l_value * -1 , 0 )  , l_time ); wait l_time; wait l_wait;
                self moveto(    self.origin + ( 0 , l_value , 0 )       , l_time ); wait l_time;
                break;
        }
        wait l_time;
    }

    self.movementmode = undefined;
}



//++++++++++++++++++++++++++++++
// en : always rotate the current object obtained with the function "advancedforgemode"
// ja : 機能 "advancedforgemode" で取得した現在のオブジェクトを常に回転させる
//++++++++++++++++++++++++++++++
switchforgemodespinningmode( )
{
    l_optname = "advancedforgemode";
    l_current = "currentobject";

    // en : if the current object exists
    // ja : 現在のオブジェクトが存在する場合
    if ( isdefined( self.optstat[l_optname].moddata[l_current] ) )
    {
        // en : temporarily stop the rotation process of the current object
        // ja : 現在のオブジェクトの回転処理を一旦停止させる
        self.optstat[l_optname].moddata[l_current] notify( "end_objectrotation" );
        // en : change the rotation mode of the current object
        // ja : 現在のオブジェクトの回転モードを変更する
        self.optstat[l_optname].moddata[l_current] thread execforgemodespinningmode( self );
    }
    // en : if the current object does not exist
    // ja : 現在のオブジェクトが存在しない場合
    else
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "warning" , "noobject" , undefined , undefined , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : change the rotation mode of the current object obtained with the function "advancedforgemode"
// ja : 機能 "advancedforgemode" で取得した現在のオブジェクトの回転モードを変更する
//++++++++++++++++++++++++++++++
execforgemodespinningmode( owner )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function terminates processing when "the object's rotation mode has changed"
    // ja : この関数は「オブジェクトの回転モードが変更された」場合に処理を終了する
    self endon( "end_objectrotation" );

    l_time = 0;
    l_text = "";
    l_value = 0;

    // en : initialize the rotation pattern if rotation processing has not started
    // ja : 回転処理が始まっていない場合、回転パターンを初期化する
    if ( !isdefined( self.spinningmode ) )      { self.spinningmode = 0;}
    // en : if rotation processing has started, change the rotation pattern
    // ja : 回転処理が開始されてる場合、回転パターンを変更する
    else if ( isdefined( self.spinningmode ) )  { self.spinningmode += 1; }

    switch ( self.spinningmode )
    {
        case 0:     l_text = "spinyaw";     l_value = 360;  l_time = 3; break;
        case 1:     l_text = "spinyaw";     l_value = 360;  l_time = 2; break;
        case 2:     l_text = "spinyaw";     l_value = 360;  l_time = 1; break;
        case 3:     l_text = "spinyaw";     l_value = -360; l_time = 3; break;
        case 4:     l_text = "spinyaw";     l_value = -360; l_time = 2; break;
        case 5:     l_text = "spinyaw";     l_value = -360; l_time = 1; break;
        case 6:     l_text = "spinroll";    l_value = 360;  l_time = 3; break;
        case 7:     l_text = "spinroll";    l_value = 360;  l_time = 2; break;
        case 8:     l_text = "spinroll";    l_value = 360;  l_time = 1; break;
        case 9:     l_text = "spinroll";    l_value = -360; l_time = 3; break;
        case 10:    l_text = "spinroll";    l_value = -360; l_time = 2; break;
        case 11:    l_text = "spinroll";    l_value = -360; l_time = 1; break;
        case 12:    l_text = "spinpitch";   l_value = 360;  l_time = 3; break;
        case 13:    l_text = "spinpitch";   l_value = 360;  l_time = 2; break;
        case 14:    l_text = "spinpitch";   l_value = 360;  l_time = 1; break;
        case 15:    l_text = "spinpitch";   l_value = -360; l_time = 3; break;
        case 16:    l_text = "spinpitch";   l_value = -360; l_time = 2; break;
        case 17:    l_text = "spinpitch";   l_value = -360; l_time = 1; break;
        default:    l_text = "spinstop"; break;
    }
    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    owner showcentermessage( owner.curlang , "notice" , l_text , undefined , l_value + " / " + l_time , undefined );

    // en: infinite loop until object no longer exists
    // ja: オブジェクトが存在しなくなるまで無限ループ
    while ( isdefined( self ) )
    {
        // en: end infinite loop when loop pattern exceeds 17
        // ja: ループパターンが 17 を超えたら、無限ループを終了する
        if ( 17 < self.spinningmode ) { break; }

        switch ( self.spinningmode )
        {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                self rotateyaw(     l_value , l_time );
                break;
                
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
                self rotateroll(    l_value , l_time );
                break;
                
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
                self rotatepitch(    l_value , l_time );
                break;
        }
        wait l_time;
    }

    self.spinningmode = undefined;
}



//++++++++++++++++++++++++++++++
// en : always sync the current object obtained with the function "advancedforgemode" to yourself
// ja : 機能 "advancedforgemode" で取得した現在のオブジェクトを常に自分に同期させる
//++++++++++++++++++++++++++++++
switchforgemodelinkself( )
{
    l_optname = "advancedforgemode";
    l_current = "currentobject";

    // en : if the current object exists
    // ja : 現在のオブジェクトが存在する場合
    if ( isdefined( self.optstat[l_optname].moddata[l_current] ) )
    {
        // en : change the current object's player following state
        // ja : 現在のオブジェクトのプレイヤー追従状態を変更する
        self.optstat[l_optname].moddata[l_current] thread execforgemodelinkself( self );
    }
    // en : if the current object does not exist
    // ja : 現在のオブジェクトが存在しない場合
    else
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "warning" , "noobject" , undefined , undefined , undefined );
    }
}



//++++++++++++++++++++++++++++++
// en : always sync the current object obtained with the function "advancedforgemode" to yourself
// ja : 機能 "advancedforgemode" で取得した現在のオブジェクトを常に自分に同期させる
//++++++++++++++++++++++++++++++
execforgemodelinkself( owner )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    l_init = false;
    l_text = "";

    // en : if player link processing has not started, initialize it.
    // ja : プレイヤーリンク処理が始まっていない場合、初期化する
    if ( !isdefined( self.playerlinkmode ) )    { self.playerlinkmode = owner; l_text = "enabled"; l_init = true; }
    // en : if player link processing has not started, initialize it.
    // ja : プレイヤーリンク処理が開始済みの場合、ループ処理を終了させる
    else                                        { self.playerlinkmode = undefined; l_text = "disabled"; }

    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    owner showcentermessage( owner.curlang , l_text , "linkobject" , undefined , undefined , undefined );

    // en : if synchronous processing has already been executed in a subthread, loop processing will not be entered within this function.
    // ja : 既に同期処理がサブスレッドで実行済みの場合、この関数内ではループ処理に入らない
    if ( !l_init ) { return; }

    // en: infinite loop until object no longer exists
    // ja: オブジェクトが存在しなくなるまで無限ループ
    while ( isdefined( self ) )
    {
        // en: end the infinite loop when the player link processing flag disappears.
        // ja: プレイヤーリンク処理フラグが消えたら、無限ループを終了する
        if ( !isdefined( self.playerlinkmode ) ) { break; }
        // en: end the infinite loop if the linked player no longer exists
        // ja: リンク対象のプレイヤーが存在しなくなった場合、無限ループを終了する
        if ( !isdefined( owner ) ) { break; }

        // en: if object rotation processing is not performed
        // ja: オブジェクトの回転処理が実行されていない場合
        if ( !isdefined( self.spinningmode ) )
        {
            // en: always set object angle to player angle
            // ja: オブジェクトの角度を常にプレイヤーの角度に設定する
            self.angles = owner getplayerangles( );
        }

        // en: always set object coordinates to player coordinates
        // ja: オブジェクトの座標を常にプレイヤーの座標に設定する
        self.origin = owner.origin;
        
        wait 0.05;
    }

    self.playerlinkmode = undefined;
}



//++++++++++++++++++++++++++++++
// en : delete the last object created with the function "advancedforgemode"
// ja : 機能 "advancedforgemode" で作成したオブジェクトの内、最後のオブジェクトを削除する
//++++++++++++++++++++++++++++++
execforgemodedeletelastobject( )
{
    l_optname = "deletelastobject";

    if ( isdefined( self.optstat[l_optname+ "_objectcount"] ) )
    {
        if ( 0 <= self.optstat[l_optname + "_objectcount"].size )
        {
            self.optstat[l_optname + "_objectcount"][( self.optstat[l_optname + "_objectcount"].size - 1 )] deleteentity( );
            self.optstat[l_optname + "_objectcount"][( self.optstat[l_optname + "_objectcount"].size - 1 )] = undefined;
            
            // en: display the text "[notification] delete object: object name" in the center of the screen
            // ja: 画面中央に「[通知] オブジェクト削除 : オブジェクト名」という文章を表示する
            self showcentermessage( self.curlang , "notice" , l_optname , undefined , ( self.optstat[l_optname + "_objectcount"].size - 1 ) , undefined );
        }
    }
}



//++++++++++++++++++++++++++++++
// en : create an object at the firing destination coordinates while the suboption "firedcreate" of the function "advanced forge mode" is enabled.
// ja : 機能 "advanced forge mode" の サブオプション "firedcreate" が有効中に、発射先の座標にオブジェクトを作成する
//++++++++++++++++++++++++++++++
createobjecttofiredlocation( location )
{
    // en: generate the model data being set at the specified coordinates
    // ja: 指定された座標に、設定中のモデルデータを生成する
    location = location + ( 0 , 0 , -10 );
    l_object = self createentityobject(
        /* notice */    true ,
        /* location */  location ,
        /* length */    undefined ,
        /* script */    "script_model" , 
        /* model */     self.optstat["advancedforgemode"].moddata["changespawnedmodel"] ,
        /* collide */   true ,
        /* sync */      self.optstat["advancedforgemode"].moddata["rotatexaxis"] ,
        /* angle */     undefined ,
        /* part */      true ,
        /* hpmin */     1000 ,
        /* hpmax */     5000 ,
        /* dmgtype */   "getplay" ,
        /* dmgfx */     "money" ,
        /* brktype */   "getplay" ,
        /* brkfx */     "hoopty_explode" ,
        /* dmgse */     "recondrone_damaged" ,
        /* brkse */     "veh_apache_explode_mp" ,
        /* del */       true ,
        /* optname */   undefined
        );

    // en: add the created object to the managed list
    // ja: 作成されたオブジェクトを管理リストに追加する
    if ( isdefined( l_object ) )
    {
        self.optstat["advancedforgemode" + "_objectcount"][self.optstat["advancedforgemode" + "_objectcount"].size] = l_object;
    }
}



//++++++++++++++++++++++++++++++
// en : change the model type of the function "advancedforgemode"
// ja : 機能 "advancedforgemode" のモデルの種類を変更する
//++++++++++++++++++++++++++++++
execchangeforgemodemodel( )
{
    l_optname1 = "advancedforgemode";
    l_optname2 = "changespawnedmodel";

    self.optstat[l_optname1].moddata[l_optname2] = level.modmenudata[self.modsystem.menulayercurrent].item[self.modsystem.menuoptioncurrent].textid;
    
    // en: display the specified text in the center of the screen
    // ja: 画面中央に指定の文章を表示する
    self showcentermessage( self.curlang , "notice" , l_optname2 , undefined , self.optstat[l_optname1].moddata[l_optname2] , undefined );
}



//++++++++++++++++++++++++++++++
// en : change the model type of the function "advanced forge mode"
// ja : 機能「advanced forge mode」のモデルの種類を変更する
//++++++++++++++++++++++++++++++
switchforgemodemodel( )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array = getstandardmodellist( );
    
    self changeselfparameter( "advancedforgemode" , "changespawnedmodel" , undefined , ::onfadvancedforgemode , l_array , true , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : change the amount of trace movement of the function "advancedforgemode"
// ja : 機能 "advancedforgemode" の トレース移動量 を変更する
//++++++++++++++++++++++++++++++
switchforgemodemovesize( )
{
    self changetracesize( "advancedforgemode" , "spawnlength" , ::onfadvancedforgemode , true );
}



//++++++++++++++++++++++++++++++
// en : change the model type of the function "mexicanwave"
// ja : 機能 "mexicanwave" のモデルの種類を変更する
//++++++++++++++++++++++++++++++
switchmexicanwavemodel( )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array = getstandardmodellist( );
    
    self changeselfparameter( "changemodel_mexicanwave" , undefined , undefined , ::emptyfunction , l_array , true , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "mexicanwave"
// ja : 機能 "mexicanwave" を自身の目の前に作成する
//++++++++++++++++++++++++++++++
execmexicanwave( )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );


    l_optname = "mexicanwave";
    l_modelid = "";

    // en : if no "mexicanwave" has been created yet
    // ja : まだ "mexicanwave" が 1つも作成されていない場合
    if ( !isdefined( level.lvlstat[l_optname] ) )
    {
        // en : create or destroy a "mexicanwave" variable
        // ja : "mexicanwave" 変数の作成か破棄を行う
        self switchonflevelfunction(
            /* optname */   l_optname ,
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
            
        level.lvlstat[l_optname + "_object"] = [];

        // en : initialize the "mexicanwave" model
        // ja : "mexicanwave" のモデルを初期化する
        if ( !isdefined( self.optstat["changemodel_" + l_optname] ) )
        {
            self.optstat["changemodel_" + l_optname] = "tag_origin";
        }
    }
        
    l_modelid = self.optstat["changemodel_" + l_optname];

    if ( isdefined( self.optstat["changemodel_" + l_optname] ) && ( self.optstat["changemodel_" + l_optname] == "tag_origin" ) )
    {
        l_list = getstandardmodellist( );
        l_rand = scripts\engine\utility::random( l_list );
        l_modelid = l_rand;
    }

    wait 0.01;
    
    // en : if no "mexicanwave" has been created yet, do not perform any further processing.
    // ja : まだ "mexicanwave" が 1つも作成されていない場合、以降の処理は行わない
    if ( !isdefined( level.lvlstat[l_optname] ) ) { return; }

    // en : get the corrected coordinates of the specified distance in the front direction
    // ja : 正面方向へ 指定倍 先の距離の修正座標を取得する
    l_location = self getplayerforwardtrace( /* trace */ undefined , /* eye */ true , /* length */ 150 , /* up */ undefined );

    // en : create "mexicanwave" at specified coordinates
    // ja : 指定した座標に "mexicanwave" を作成する
    level.lvlstat[l_optname + "_object"][level.lvlstat[l_optname + "_object"].size] = spawnmultiplemodels( l_location , 1 , 10 , 1 , 0 , 0 , 0 , l_modelid , self getplayerangles( ) , 50 , 0.05 );
    
    // en : have each object perform behavior processing on the created "mexicanwave"
    // ja : 作成された "mexicanwave" に対して、挙動処理を各オブジェクトに実行させる
	for( i = 0; i < level.lvlstat[l_optname + "_object"][( level.lvlstat[l_optname + "_object"].size - 1)].size; i++ )
	{
		level.lvlstat[l_optname + "_object"][( level.lvlstat[l_optname + "_object"].size - 1)][i] thread onprocessmexicanmove( l_optname );
		wait 0.1;
	}
}



//++++++++++++++++++++++++++++++
// en : behavior processing of function "mexicanwave"
// ja : 機能 "mexicanwave" の挙動処理
//++++++++++++++++++++++++++++++
onprocessmexicanmove( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    // en : if the function "mexicanwave" is destroyed, terminate processing in this function
    // ja : 機能 "mexicanwave" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

	while( isdefined( self ) )
	{
		self movez( 80 , 1 , 0.2 , 0.4 );
		wait 1;
		self movez( -80 , 1 , 0.2 , 0.4 );
		wait 1;
	}
}



//++++++++++++++++++++++++++++++
// en : delete the feature "mexicanwave"
// ja : 機能 "mexicanwave" を削除する
//++++++++++++++++++++++++++++++
execdeletemexicanwave( )
{
    l_optname = "mexicanwave";

    // en : if no "mexicanwave" has been created yet, do not perform any further processing.
    // ja : まだ "mexicanwave" が 1つも作成されていない場合、以降の処理は行わない
    if ( !isdefined( level.lvlstat[l_optname] ) ) { return; }
    
    // en : execute the completion wait process for the function "mexicanwave"
    // ja : 機能 "mexicanwave" の終了待機処理を実行する
    level thread onwaitingdestroyentities(
        /* delmode */   "random" ,              /* optname */       l_optname ,                     /* sfxid */     "exp_helicopter_fuel" ,
        /* expfxid */   "hoopty_explode" ,    /* discfxid */      "hoopty_explode" ,
        /* eqpower */   0.3 ,                   /* eqtime */        1 ,                             /* eqrange */   2000 ,
        /* exptime */   0.01 ,                  /* delay */         3 ,
        /* lastnuke */  undefined ,             /* nukepoint */     undefined ,                     /* owner */     undefined ,
        /* objarray */  undefined ,             /* objdelete */     undefined ,
        /* listarray */ l_optname + "_object" , /* listdelete */    true ,                          /* dualarray */ true
        );

    wait 0.01;
    
    // en : destroy a "mexicanwave" variable
    // ja : "mexicanwave" 変数の破棄を行う
    self switchonflevelfunction(
        /* optname */   l_optname ,
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
}




//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "skyplazaver2"
// ja : 機能 "skyplazaver2" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfskyplazaver2( )
{
    l_optname = "skyplazaver2";

    // en : execute waitfirebullets( ) or exit depending on the existence state of the "skyplazaver2" variable
    // ja : "skyplazaver2" 変数の存在状態に合わせて、 "waitfirebullets" 関数を実行するか終了する
    self switchonflevelfunction(
        /* optname */                               l_optname ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               "pleaseshooting" ,
        /* optarg1 */       /* optname1 */          l_optname,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::createskyplazaver2 ,
        /* optarg4 */       /* notice */            true ,
        /* optarg5 */       /* specificweapon */    undefined ,
        /* optarg6 */       /* effectdata */        "hoopty_explode" ,
        /* optarg7 */       /* enddeath */          undefined 
        );
    wait 0.1;
    // en: shorten the distance of the coordinates to obtain when firing a gun
    // ja: 銃発射時の取得先の座標の距離を短くする
    if ( isdefined( self.optstat[l_optname] ) ) { self.optstat[l_optname].moddata["tracelength"] = 1500; }
}



//++++++++++++++++++++++++++++++
// en : create a casing for the function "skyplazaver2" at the coordinates of the launch destination.
// ja : 機能 "skyplazaver2" の筐体を、発射先の座標に作成する
//++++++++++++++++++++++++++++++
createskyplazaver2( location )
{
    l_optname = "skyplazaver2";

    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );
    wait 0.001;
    
    level.lvlstat[l_optname + "_flag"] = [];
    level.lvlstat[l_optname + "_box"] = [];
    
    l_listarray     = [];                   l_listdel       = [];
    l_listarray[0]  = l_optname + "_box";   l_listdel[0]    = false;
    l_listarray[1]  = l_optname + "_flag";  l_listdel[1]    = true;

    // en : execute the completion wait process for the function "skyplazaver2"
    // ja : 機能 "skyplazaver2" の終了待機処理を実行する
    level thread onwaitingdestroyentities(
        /* delmode */   "random" ,              /* optname */       l_optname ,                     /* sfxid */     "exp_helicopter_fuel" ,
        /* expfxid */   "hoopty_explode" ,    /* discfxid */      "hoopty_explode" ,
        /* eqpower */   0.3 ,                   /* eqtime */        1 ,                             /* eqrange */   2000 ,
        /* exptime */   0.01 ,                  /* delay */         10 ,
        /* lastnuke */  undefined ,				/* nukepoint */     undefined ,                 	/* owner */     undefined ,
        /* objarray */  undefined ,             /* objdelete */     undefined ,
        /* listarray */ l_listarray ,           /* listdelete */    l_listdel ,                     /* dualarray */ undefined
        );
    
    createflagfromstrtok( l_optname , location , "0,0,1375,870,55,1470",150,1);
    createflagfromstrtok( l_optname , location , "0,0",390,1);
    createflagfromstrtok( l_optname , location , "0,0",620,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",0,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470",25,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,880,690,990,690,1100,690,1155,690,1210,690,1265,690,1320,690,1375,690,550,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,495,750,550,750,605,750,660,750,770,750,880,750,1045,750,1100,750,1155,750,1375,750,550,780,1045,780,1100,780,1155,780,1375,780,1045,810,1100,810,1375,810,1045,840,1100,840,1375,840,1045,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,1045,900,1100,900,1155,900,1210,900,1265,900,1320,900,1375,900,110,930,0,1470,55,1470,110,1470",50,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",75,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",100,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",125,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,605,240,550,270,605,270,605,300,605,330,605,360,605,390,605,420,660,420,715,420,770,420,825,420,880,420,935,420,935,450,605,480,935,480,605,510,935,510,935,540,990,540,1045,540,1100,540,1155,540,605,570,1155,570,1210,570,1210,600,1265,600,165,630,330,630,495,630,550,630,605,630,660,630,1210,630,1265,630,165,660,330,660,495,660,1210,660,1265,660,1320,660,330,690,495,690,1210,690,1265,690,1320,690,1375,690,165,720,330,720,385,720,440,720,495,720,550,720,605,720,660,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,495,750,660,750,1100,750,1155,750,1375,750,495,780,660,780,935,780,990,780,1045,780,1100,780,1155,780,1375,780,330,810,385,810,440,810,495,810,660,810,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,935,960,935,990,935,1020,935,1050,935,1080,935,1110,935,1140,935,1170,935,1200,935,1230,935,1260,935,1290,935,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,825,1350,880,1350,935,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",150,1);
    createcpboxfromstrtok( l_optname , location , "165,0",160,1);
    createcpboxfromstrtok( l_optname , location , "220,0",170,1);
    createcpboxfromstrtok( l_optname , location , "275,0",180,1);
    createcpboxfromstrtok( l_optname , location , "330,0",190,1);
    createcpboxfromstrtok( l_optname , location , "385,0",200,1);
    createcpboxfromstrtok( l_optname , location , "440,0",210,1);
    createcpboxfromstrtok( l_optname , location , "495,0",220,1);
    createcpboxfromstrtok( l_optname , location , "540,0",230,1);
    createcpboxfromstrtok( l_optname , location , "595,0",240,1);
    createcpboxfromstrtok( l_optname , location , "650,0",250,1);
    createcpboxfromstrtok( l_optname , location , "705,0",260,1);
    createcpboxfromstrtok( l_optname , location , "760,0",270,1);
    createcpboxfromstrtok( l_optname , location , "760,30,760,90,760,60",270,1);
    createcpboxfromstrtok( l_optname , location , "705,90",280,1);
    createcpboxfromstrtok( l_optname , location , "650,90",290,1);
    createcpboxfromstrtok( l_optname , location , "595,90",300,1);
    createcpboxfromstrtok( l_optname , location , "540,90",310,1);
    createcpboxfromstrtok( l_optname , location , "495,90",320,1);
    createcpboxfromstrtok( l_optname , location , "440,90",330,1);
    createcpboxfromstrtok( l_optname , location , "385,90",340,1);
    createcpboxfromstrtok( l_optname , location , "330,90",350,1);
    createcpboxfromstrtok( l_optname , location , "275,90",360,1);
    createcpboxfromstrtok( l_optname , location , "220,90",370,1);
    createcpboxfromstrtok( l_optname , location , "165,90",380,1);
    createcpboxfromstrtok( l_optname , location , "105,90",380,1);
    createcpboxfromstrtok( l_optname , location , "0,30,55,30,0,60,55,60,0,90,55,90",390,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0",390,1);
    createcpboxfromstrtok( l_optname , location , "105,0",400,1);
    createcpboxfromstrtok( l_optname , location , "165,0",400,1);
    createcpboxfromstrtok( l_optname , location , "220,0",410,1);
    createcpboxfromstrtok( l_optname , location , "275,0",420,1);
    createcpboxfromstrtok( l_optname , location , "330,0",430,1);
    createcpboxfromstrtok( l_optname , location , "385,0",440,1);
    createcpboxfromstrtok( l_optname , location , "440,0",450,1);
    createcpboxfromstrtok( l_optname , location , "495,0",460,1);
    createcpboxfromstrtok( l_optname , location , "540,0",470,1);
    createcpboxfromstrtok( l_optname , location , "595,0",480,1);
    createcpboxfromstrtok( l_optname , location , "650,0",490,1);
    createcpboxfromstrtok( l_optname , location , "705,0",500,1);
    createcpboxfromstrtok( l_optname , location , "760,0",510,1);
    createcpboxfromstrtok( l_optname , location , "760,30,760,90,760,60",510,1);
    createcpboxfromstrtok( l_optname , location , "705,90",520,1);
    createcpboxfromstrtok( l_optname , location , "650,90",530,1);
    createcpboxfromstrtok( l_optname , location , "595,90",540,1);
    createcpboxfromstrtok( l_optname , location , "540,90",550,1);
    createcpboxfromstrtok( l_optname , location , "495,90",560,1);
    createcpboxfromstrtok( l_optname , location , "440,90",570,1);
    createcpboxfromstrtok( l_optname , location , "385,90",580,1);
    createcpboxfromstrtok( l_optname , location , "330,90",590,1);
    createcpboxfromstrtok( l_optname , location , "275,90",600,1);
    createcpboxfromstrtok( l_optname , location , "220,90",610,1);
    createcpboxfromstrtok( l_optname , location , "165,90",620,1);
    createcpboxfromstrtok( l_optname , location , "105,90",620,1);
    createcpboxfromstrtok( l_optname , location , "0,30,55,30,0,60,55,60,0,90,55,90",620,1);
    createcpboxfromstrtok( l_optname , location , "0,0,55,0",0,1);
    createcpboxfromstrtok( l_optname , location , "165,1410",0,1);
    createcpboxfromstrtok( l_optname , location , "220,1410",20,1);
    createcpboxfromstrtok( l_optname , location , "275,1410",40,1);
    createcpboxfromstrtok( l_optname , location , "330,1410",60,1);
    createcpboxfromstrtok( l_optname , location , "385,1410",80,1);
    createcpboxfromstrtok( l_optname , location , "440,1410",100,1);
    createcpboxfromstrtok( l_optname , location , "495,1410",120,1);
    createcpboxfromstrtok( l_optname , location , "550,1410",140,1);
    createcpboxfromstrtok( l_optname , location , "550,1390",140,1);
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "discodancer"
// ja : 機能 "discodancer" を自身の目の前に作成する
//++++++++++++++++++++++++++++++
execdiscodancer( )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );


    l_optname = "discodancer";
    l_combinedname = l_optname + "_object";

    // en : if no "discodancer" has been created yet
    // ja : まだ "discodancer" が 1つも作成されていない場合
    if ( !isdefined( level.lvlstat[l_optname] ) )
    {
        // en : create or destroy a "discodancer" variable
        // ja : "discodancer" 変数の作成か破棄を行う
        self switchonflevelfunction(
            /* optname */   l_optname ,
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
            
        level.lvlstat[l_combinedname] = [];
    }

    wait 0.01;
    
    // en : if no "discodancer" has been created yet, do not perform any further processing.
    // ja : まだ "discodancer" が 1つも作成されていない場合、以降の処理は行わない
    if ( !isdefined( level.lvlstat[l_optname] ) ) return;

    l_model = self.model; //"mw_test_soldier"

    // en : create "discodancer" at specified coordinates
    // ja : 指定した座標に "discodancer" を作成する
    l_obj1 = self createentityobject( /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ l_model                         , /* collide */ true , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ true );
    l_obj2 = self createentityobject( /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ "axis_guide_createfx_rot"       , /* collide */ true , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ true );
    l_obj3 = self createentityobject( /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ "ks_cruise_predator_mp" , /* collide */ true , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ undefined );
    l_obj4 = self createentityobject( /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ "ks_cruise_predator_mp" , /* collide */ true , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ undefined );
    l_obj5 = self createentityobject( /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ "ks_cruise_predator_mp" , /* collide */ true , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ undefined );
    l_obj6 = self createentityobject( /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ "ks_cruise_predator_mp" , /* collide */ true , /* sync */ undefined , /* angle */ ( 0 , 0 , 0 ) , /* part */ undefined );
    
    // en : Link the decoration model to the base model
    // ja : ベースモデルに対して装飾モデルをリンクする
    l_obj2 linkto( l_obj1 , "tag_origin" , ( 0 , 0      , 65 )  , ( 0   , 0 , 0 ) );
    l_obj3 linkto( l_obj1 , "tag_origin" , ( 20 , 20    , 40 )  , ( 0   , 0 , 0 ) );
    l_obj4 linkto( l_obj1 , "tag_origin" , ( 20 , -20   , 40 )  , ( 0   , 0 , 0 ) );
    l_obj5 linkto( l_obj1 , "tag_origin" , ( 0 , 8      , -10 ) , ( 270 , 0 , 0 ) );
    l_obj6 linkto( l_obj1 , "tag_origin" , ( 0 , -8     , -10 ) , ( 270 , 0 , 0 ) );

    l_obj1.angles = self getplayerangles( );

    // en : add the created object to the managed list for deletion
    // ja : 作成したオブジェクトを削除用管理リストに追加する
    level.lvlstat[l_combinedname][level.lvlstat[l_combinedname].size] = l_obj1;
    level.lvlstat[l_combinedname][level.lvlstat[l_combinedname].size] = l_obj2;
    level.lvlstat[l_combinedname][level.lvlstat[l_combinedname].size] = l_obj3;
    level.lvlstat[l_combinedname][level.lvlstat[l_combinedname].size] = l_obj4;
    level.lvlstat[l_combinedname][level.lvlstat[l_combinedname].size] = l_obj5;
    level.lvlstat[l_combinedname][level.lvlstat[l_combinedname].size] = l_obj6;
    wait 0.001;
    playeffecttoobject( /* time */ undefined , /* obj */ l_obj2 , /* fx */ "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" , /* tag */ "tag_origin" , /* type */ "gettag" , /* loop */ undefined , /* base */ undefined , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    // playfxontag( scripts\engine\utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" ) , l_obj2 , "tag_origin" );

    // en : Execute behavior processing for the created 'discodancer'
    // ja : 作成された "discodancer" に対して、挙動処理を実行させる
    l_obj1 thread onprocessdiscodancer( l_optname );
}



//++++++++++++++++++++++++++++++
// en : animation processing of function "discodancer"
// ja : 機能 "discodancer" のアニメーション処理
//++++++++++++++++++++++++++++++
onprocessdiscodancer( owner , optname , yawonly , attack , specpos1 , specpos2 )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    // en : if the function "discodancer" is destroyed, terminate processing in this function
    // ja : 機能 "discodancer" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

    // en : define various variables
    // ja : 各種変数を定義
    l_origin    = self.origin;
    l_time1     = 1;
    l_time2     = 0.5;
    l_value1    = -180;
    l_value2    = 180;
    l_value3    = 90;
    l_value4    = -90;

    // en : this animation thread executes a loop only while the object it is running on is alive.
    // ja : このアニメーションスレッドが実行されている自分自身のオブジェクトが生存している間だけループ処理を行う
	while( isdefined( self ) )
	{
        self rotateyaw( 9000        , 9 );
        self moveto(    self.origin + ( 0 , l_value1 , 0 )  , l_time1 );    wait l_time1;
        self moveto(    self.origin + ( 0 , l_value2 , 0 )  , l_time1 );    wait l_time1;
        self moveto(    self.origin + ( l_value1 , 0 , 0 )  , l_time1 );    wait l_time1;
        self moveto(    self.origin + ( l_value2 , 0 , 0 )  , l_time1 );    wait l_time1;
        self movez(     l_value3    , l_time2 );    wait l_time2;
        self movez(     l_value4    , l_time2 );    wait l_time2;
        self moveto(    self.origin + ( 0 , l_value2 , 0 )  , l_time1 );    wait l_time1;
        self moveto(    self.origin + ( 0 , l_value1 , 0 )  , l_time1 );    wait l_time1;
        self moveto(    self.origin + ( l_value2 , 0 , 0 )  , l_time1 );    wait l_time1;
        self moveto(    self.origin + ( l_value1 , 0 , 0 )  , l_time1 );    wait l_time1;
	}
}



//++++++++++++++++++++++++++++++
// en : delete the feature "discodancer"
// ja : 機能 "discodancer" を削除する
//++++++++++++++++++++++++++++++
execdeletediscodancer( )
{
    l_optname = "discodancer";

    // en : if no "discodancer" has been created yet, do not perform any further processing.
    // ja : まだ "discodancer" が 1つも作成されていない場合、以降の処理は行わない
    if ( !isdefined( level.lvlstat[l_optname] ) ) { return; }
    
    l_listarray     = [];                       l_listdel       = [];
    l_listarray[0]  = l_optname + "_object";    l_listdel[0]    = true;
    
    // en : execute the completion wait process for the function "discodancer"
    // ja : 機能 "discodancer" の終了待機処理を実行する
    level thread onwaitingdestroyentities(
        /* delmode */   "random" ,              /* optname */       l_optname ,                     /* sfxid */     "exp_helicopter_fuel" ,
        /* expfxid */   "hoopty_explode" ,    /* discfxid */      "hoopty_explode" ,
        /* eqpower */   0.3 ,                   /* eqtime */        1 ,                             /* eqrange */   2000 ,
        /* exptime */   0.01 ,                  /* delay */         3 ,
        /* lastnuke */  undefined ,             /* nukepoint */     undefined ,                     /* owner */     undefined ,
        /* objarray */  undefined ,             /* objdelete */     undefined ,
        /* listarray */ l_listarray ,           /* listdelete */    l_listdel ,                     /* dualarray */ undefined
        );

    wait 0.01;
    
    // en : destroy a "discodancer" variable
    // ja : "discodancer" 変数の破棄を行う
    self switchonflevelfunction(
        /* optname */   l_optname ,
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
}



//++++++++++++++++++++++++++++++
// en : change the model type of the function "spindancer"
// ja : 機能 "spindancer" のモデルの種類を変更する
//++++++++++++++++++++++++++++++
switchmodelspindancer( )
{
    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array = getstandardmodellist( );
    
    self changeselfparameter( ( "changemodel_spindancer" ) , undefined , undefined , ::emptyfunction , l_array , true , undefined , undefined );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "spindancer"
// ja : 機能 "spindancer" を自身の目の前に作成する
//++++++++++++++++++++++++++++++
execspindancer( )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );


    l_optname = "spindancer";
    l_modelid = "";

    // en : if no "spindancer" has been created yet
    // ja : まだ "spindancer" が 1つも作成されていない場合
    if ( !isdefined( level.lvlstat[l_optname] ) )
    {
        // en : create or destroy a "spindancer" variable
        // ja : "spindancer" 変数の作成か破棄を行う
        self switchonflevelfunction(
            /* optname */   l_optname ,
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
            
        level.lvlstat[l_optname + "_object"] = [];

        // en : initialize the "spindancer" model
        // ja : "spindancer" のモデルを初期化する
        if ( !isdefined( self.optstat["changemodel_" + l_optname] ) )
        {
            self.optstat["changemodel_" + l_optname] = "tag_origin";
        }
    }
        
    l_modelid = self.optstat["changemodel_" + l_optname];

    if ( isdefined( self.optstat["changemodel_" + l_optname] ) && ( self.optstat["changemodel_" + l_optname] == "tag_origin" ) )
    {
        l_list = getstandardmodellist( );
        l_rand = scripts\engine\utility::random( l_list );
        l_modelid = l_rand;
    }

    wait 0.01;
    
    // en : if no "spindancer" has been created yet, do not perform any further processing.
    // ja : まだ "spindancer" が 1つも作成されていない場合、以降の処理は行わない
    if ( !isdefined( level.lvlstat[l_optname] ) ) { return; }

    // en : create object "spindancer" with specified settings
    // ja : オブジェクト "spindancer" を指定した設定で作成する
    l_obj = self createentityobject(
        /* notice */ undefined , /* point */ undefined , /* length */ 150 , /* script */ "script_model" , /* model */ l_modelid , /* collide */ true , /* sync */ undefined , /* angle */ self getplayerangles( ) , /* part */ true ,
        /* hpmin */ undefined , /* hpmax */ undefined , /* dmgtype */ undefined , /* dmgfx */ undefined , /* brktype */ undefined , /* brkfx */ undefined , /* dmgse */ undefined , /* brkse */ undefined , /* enddel */ undefined , /* name */ undefined
    );
        
    // en : execute animation processing of object "spindancer" in subthread
    // ja : オブジェクト "spindancer" のアニメーション処理をサブスレッドで実行する
	l_obj thread onprocessspindancer( self , l_optname , undefined , undefined , undefined , undefined );

    // en : add the created object to the managed list for deletion
    // ja : 作成したオブジェクトを削除用管理リストに追加する
    level.lvlstat[l_optname + "_object"][level.lvlstat[l_optname + "_object"].size] = l_obj;
}



//++++++++++++++++++++++++++++++
// en : animation processing of function "spindancer"
// ja : 機能 "spindancer" のアニメーション処理
//++++++++++++++++++++++++++++++
onprocessspindancer( owner , optname , yawonly , attack , specpos1 , specpos2 )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );

    // en : if the function "spindancer" is destroyed, terminate processing in this function
    // ja : 機能 "spindancer" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

    // en : define various variables
    // ja : 各種変数を定義
    l_time      = 1;
    l_count     = 1;
    l_zaxis     = 50;
    l_fall      = 1;
    l_wait      = 1;
    l_accel     = 1;
    l_fxid      = "";
    l_fxtype    = "";
    l_sfx       = "";
    l_start     = self.origin;
    l_startpos  = l_start;
    l_endpos    = ( 0 , 0 , 0 );

    // en : this animation thread executes a loop only while the object it is running on is alive.
    // ja : このアニメーションスレッドが実行されている自分自身のオブジェクトが生存している間だけループ処理を行う
	while( isdefined( self ) )
	{
        // en : randomly obtain the numbers required for each operation
        // ja : 各処理に要する数値をランダムに取得する
        l_time  = randomfloatrange( 0.5 , 5 );
        l_count = randomintrange( 5 , 15 );
        l_zaxis = randomintrange( 50 , 1000 );
        l_wait  = randomfloatrange( 0.5 , 2.5 );
        l_fall  = randomfloatrange( 0.25 , 1 );

        // en : get a random rotation direction
        // ja : 回転方向をランダムに取得する
        switch ( randomintrange( 0 , ( isdefined( yawonly ) ? 2 : 6 ) ) )
        {
            case 0: self rotateyaw(     ( 360   * l_count ) , l_time ); break;
            case 1: self rotateyaw(     ( -360  * l_count ) , l_time ); break;
            case 2: self rotateroll(    ( 360   * l_count ) , l_time ); break;
            case 3: self rotateroll(    ( -360  * l_count ) , l_time ); break;
            case 4: self rotatepitch(   ( 360   * l_count ) , l_time ); break;
            case 5: self rotatepitch(   ( -360  * l_count ) , l_time ); break;
        }

        // en : moves itself directly above the coordinates where it was generated
        // ja : 自分自身を生成された座標から真上に移動させる
        self moveto( l_start + ( 0 , 0 , l_zaxis )  , l_time );

        // en : if no attack process is to be performed, wait that many seconds.
        // ja : 攻撃処理を実行しない場合はその秒数分待機する
        if ( !isdefined( attack ) ) { wait l_time; }
        else
        {
            // en : when performing an attack process, the time until the end of rotation is temporarily divided into 20 parts.
            // ja : 攻撃処理を実行する場合、暫定で回転終了までの時間を20分割する
            for ( i = 0; i < 20; i++ )
            {   
                // en : wait for the divided time
                // ja : 分割した時間分待機する
		        wait ( l_time / 20 );
                
                // en : get random attack coordinates
                // ja : 攻撃先の座標をランダムに取得する
                l_endpos = ( randomintrange( -1000 , 1000 ) , randomintrange( -1000 , 1000 ) , randomintrange( -1000 , -50 ) );
                l_endpos = ( ( self.origin[0] + l_endpos[0] ) , ( self.origin[1] + l_endpos[1] ) , ( self.origin[2] + l_endpos[2] ) );
                
                // en : if the attack coordinates are specified, calculate the coordinates.
                // ja : 攻撃元座標が指定されている場合、座標を算出する
                if ( isdefined( specpos1 ) || isdefined( specpos2 ) )
                {
                    if      ( !isdefined( specpos1 ) ) { l_startpos = ( ( self.origin[0] + specpos2[0] ) , ( self.origin[1] + specpos2[1] ) , ( self.origin[2] + specpos2[2] ) ); }
                    else if ( !isdefined( specpos2 ) ) { l_startpos = ( ( self.origin[0] + specpos1[0] ) , ( self.origin[1] + specpos1[1] ) , ( self.origin[2] + specpos1[2] ) ); }
                    else
                    {
                        if ( scripts\engine\utility::cointoss( ) )  { l_startpos = ( ( self.origin[0] + specpos1[0] ) , ( self.origin[1] + specpos1[1] ) , ( self.origin[2] + specpos1[2] ) ); }
                        else                                        { l_startpos = ( ( self.origin[0] + specpos2[0] ) , ( self.origin[1] + specpos2[1] ) , ( self.origin[2] + specpos2[2] ) ); }
                    }
                }
                
                // en : launch a missile
                // ja : ミサイルを発射させる
                createmagicbullet( owner , getbulletid( "nolockmissile2" ) , l_startpos , l_endpos );
            }
        }
        // en : wait a few seconds after the rotation is complete
        // ja : 回転終了後に数秒待機する
        wait l_wait;

        // en : descend to original coordinates
        // ja : 元の座標まで降下する
        self moveto( l_start , l_fall );
		wait l_fall;

        // en : get a random effect
        // ja : ランダムでエフェクトを取得する
        switch ( randomintrange( 0 , 5 ) )
        {
            case 0: l_fxid = "glsmoke";                                 l_fxtype = "getplay";   break;
            case 1: l_fxid = "gunship_flares";                          l_fxtype = "getplay";   break;
            case 2: l_fxid = "predator_pod_break";                      l_fxtype = "getplay";   break;
            case 3: l_fxid = "hoopty_explode";                                l_fxtype = "getplay";   break;
            case 4: l_fxid = level._effect["cranked_explode"];          l_fxtype = "loadplay"; break;
        }

        // en : get a random sound
        // ja : ランダムでサウンドを取得する
        switch ( randomintrange( 0 , 8 ) )
        {
            case 0: l_sfx = "iw8_rc_plane_engine_exp"; break;
            case 1: l_sfx = "ks_a10_fire_dist_crack"; break;
            case 2: l_sfx = "iw8_ks_ac130_dist_rkt_explo"; break;
            case 3: l_sfx = "weap_hellfire_impact"; break;
            case 4: l_sfx = "veh_apache_explode_mp"; break;
            case 5: l_sfx = "mp_killstreak_disappear"; break;
            case 6: l_sfx = "sentry_explode_smoke"; break;
            case 7: l_sfx = "exp_helicopter_fuel"; break;
        }

        // en: play the effect at the obtained coordinates
        // ja: 取得した座標にエフェクトを再生する
        playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_fxid , /* tag */ undefined , /* type */ l_fxtype , /* loop */ undefined , /* base */ self.origin , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
        // en : causes an earthquake of the specified strength from the specified coordinates to the specified radius for the specified number of seconds.
        // ja : 指定した座標から、指定した半径の範囲まで、指定した威力の地震を、指定した秒数間起こす
        earthquake( 0.3 , 1 , self.origin , 750 );
        // en : play the specified sound effect
        // ja : 指定したサウンドエフェクトを再生する
        playsoundatpos( self.origin , l_sfx );
        // en : causes area damage centered on the current object's coordinates.
        // ja : 現在のオブジェクトの座標を中心に、範囲ダメージを発生させる
        self radiusdamage( self.origin , 500 , 500 , 10 , owner , "MOD_EXPLOSIVE" , getweaponcompleteid( owner getcurrentweapon( ) ) );
        wait l_wait;
	}
}



//++++++++++++++++++++++++++++++
// en : delete the feature "spindancer"
// ja : 機能 "spindancer" を削除する
//++++++++++++++++++++++++++++++
execdeletespindancer( )
{
    l_optname = "spindancer";

    // en : if no "spindancer" has been created yet, do not perform any further processing.
    // ja : まだ "spindancer" が 1つも作成されていない場合、以降の処理は行わない
    if ( !isdefined( level.lvlstat[l_optname] ) ) { return; }
    
    l_listarray     = [];                       l_listdel       = [];
    l_listarray[0]  = l_optname + "_object";    l_listdel[0]    = true;
    
    // en : execute the completion wait process for the function "spindancer"
    // ja : 機能 "spindancer" の終了待機処理を実行する
    level thread onwaitingdestroyentities(
        /* delmode */   "random" ,              /* optname */       l_optname ,                     /* sfxid */     "exp_helicopter_fuel" ,
        /* expfxid */   "hoopty_explode" ,    /* discfxid */      "hoopty_explode" ,
        /* eqpower */   0.3 ,                   /* eqtime */        1 ,                             /* eqrange */   2000 ,
        /* exptime */   0.01 ,                  /* delay */         3 ,
        /* lastnuke */  undefined ,             /* nukepoint */     undefined ,                     /* owner */     undefined ,
        /* objarray */  undefined ,             /* objdelete */     undefined ,
        /* listarray */ l_listarray ,           /* listdelete */    l_listdel ,                     /* dualarray */ undefined
        );

    wait 0.01;
    
    // en : destroy a "spindancer" variable
    // ja : "spindancer" 変数の破棄を行う
    self switchonflevelfunction(
        /* optname */   l_optname ,
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
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "speedhack" for the all players.
// ja : 全プレイヤーに対して、機能 "speedhack" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
execspeedhackforallplayers( )
{
    self thread switchonfallplayersfunction( "speedhack" , ::onfspeedhack , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "speedhack"
// ja : 機能 "speedhack" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfspeedhack( )
{
    // en : execute execspeedhack( ) or exit depending on the existence state of the "speedhack" variable
    // ja : "speedhack" 変数の存在状態に合わせて、 execspeedhack( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "speedhack" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "speedhack" ,
        /* optarg2 */   /* optfunc */   ::execspeedhack ,
        /* optarg3 */   /* looptime */  1
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "speedhack"
// ja : 機能 "speedhack" の実行中の処理
//++++++++++++++++++++++++++++++
execspeedhack( optname , procstage )
{
    switch ( procstage )
    {
        // en: initialization process
        // ja: 初期化処理
        case 0:
            // en : if duplicate functions are activated, disable them
            // ja : 重複している機能が起動している場合、無効化させる
            self checkduplicatefunction( "movementspeed1_25x" , ::execmovementspeed1_25x );
            self checkduplicatefunction( "movementspeed" ,      ::execchangemovementspeed );
            break;
            
        // en: running process
        // ja: 実行中処理
        case 1:
            // en: set your movement speed to the currently set speed
            // ja: 自分の移動速度を設定中の速度にする
            self setmovespeedscale( 5 );
            break;
            
        // en: end processing
        // ja: 終了処理
        case 2:
            // en: return your movement speed to default
            // ja: 自分の移動速度をデフォルトに戻す
            self setmovespeedscale( 1 );
            break;
    }
}



//++++++++++++++++++++++++++++++
// en : enables/disables the feature "superjump" for the all players.
// ja : 全プレイヤーに対して、機能 "superjump" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
execsuperjumpforallplayers( )
{
    self thread switchonfallplayersfunction( "superjump" , ::onfsuperjump , undefined , true );
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "superjump"
// ja : 機能 "superjump" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfsuperjump( )
{
    // en : execute execsuperjump( ) or exit depending on the existence state of the "superjump" variable
    // ja : "superjump" 変数の存在状態に合わせて、 execsuperjump( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */                   "superjump" ,
        /* optfunc */                   ::execloopfunction ,
        /* message */                   undefined ,
        /* optarg1 */   /* optname */   "superjump" ,
        /* optarg2 */   /* optfunc */   ::execsuperjump ,
        /* optarg3 */   /* looptime */  0.05
        );
}



//++++++++++++++++++++++++++++++
// en : processing during execution of the function "superjump"
// ja : 機能 "superjump" の実行中の処理
//++++++++++++++++++++++++++++++
execsuperjump( optname , procstage )
{
    // en: when the "jump" button is pressed
    // ja: 「ジャンプ」ボタンが押されたら
    if ( self getkeycodepressed( "buttonjump" , "buttonjump" ) == false ) return;

    // en : move the angular velocity directly upwards
    // ja : 角速度を真上に向けて移動させる
    self setvelocity( self getvelocity( ) + ( 0 , 0 , 2000 ) );

    wait 0.5;

    l_velocity = undefined;
    l_pos = undefined;
    l_dist = undefined;
    while ( self isonground( ) == false )
    {
        // en: get movement speed
        // ja: 移動速度を取得
        l_velocity = self getvelocity( );

        // en: obtain the coordinates directly below and measure the distance to the ground
        // ja: 真下の座標を取得して、地面との距離を計測
        l_pos = scripts\engine\trace::_bullet_trace( self.origin , self.origin + ( 0 , 0 , -100000 ) , 0 , undefined );
        l_dist = distance( self.origin , l_pos["position"] );

        //self iprintlnbold( "vel = " + l_velocity[2] );
        //self iprintlnbold( "dist / vel (" + l_dist + " / " + l_velocity[2] + ")" );
        
        // en: if the falling speed exceeds the jump speed or is close to the ground, the falling speed is cancelled out.
        // ja: 落下速度がジャンプ時の速度を超えるか、もしくは地面に近い場合、落下速度を打ち消す
        if ( l_velocity[2] < -2000 )
            self setvelocity( l_velocity + ( 0 , 0 , ( l_velocity[2] * -1 ) ) );
        if ( l_dist < 100 )
        {
            self setvelocity( l_velocity + ( 0 , 0 , ( l_velocity[2] * -1 ) ) );
            wait 0.5;
        }
        
        wait 0.001;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "forcerespawnpoint"
// ja : 機能 "forcerespawnpoint" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfforcerespawnpoint( )
{
    // en : execute waitfirebullets( ) or exit depending on the existence state of the "forcerespawnpoint" variable
    // ja : "forcerespawnpoint" 変数の存在状態に合わせて、 "waitfirebullets" 関数を実行するか終了する
    self switchonflevelfunction(
        /* optname */                               "forcerespawnpoint" ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               "pleaseshooting" ,
        /* optarg1 */       /* optname1 */          "forcerespawnpoint" ,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::createforcerespawnpoint ,
        /* optarg4 */       /* notice */            true ,
        /* optarg5 */       /* specificweapon */    undefined ,
        /* optarg6 */       /* effectdata */        "hoopty_explode" ,
        /* optarg7 */       /* enddeath */          undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : create a casing for the function "forcerespawnpoint" at the coordinates of the launch destination.
// ja : 機能 "forcerespawnpoint" の筐体を、発射先の座標に作成する
//++++++++++++++++++++++++++++++
createforcerespawnpoint( location )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    l_optname = "forcerespawnpoint";
    
    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );
    wait 0.001;

    // en: create a flag object
    // ja: 旗オブジェクトを作成する
    l_object = self createentityobject(
        /* notice */    undefined ,
        /* location */  location ,
        /* length */    undefined ,
        /* script */    "script_model" , 
        /* model */     "prop_flag_neutral" ,
        /* collide */   true ,
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
    
    // en: if the creation of the flag object was successful
    // ja: 旗オブジェクトの作成が成功していた場合
    if ( isdefined( l_object ) )
    {
        // en: remember flag object
        // ja: 旗オブジェクトを記憶する
        level.lvlstat["forcerespawnpoint" + "_flag"] = l_object;
        // en: start the animation process for the flag object
        // ja: 旗オブジェクトのアニメーション処理を開始する
        l_object thread animatedforcerespawnpoint( l_optname );
    }
}



//++++++++++++++++++++++++++++++
// en : animation processing of the housing of the function "forcerespawnpoint"
// ja : 機能 "forcerespawnpoint" の筐体のアニメーション処理
//++++++++++++++++++++++++++++++
animatedforcerespawnpoint( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : if the function "forcerespawnpoint" is destroyed, terminate processing in this function
    // ja : 機能 "forcerespawnpoint" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

    // en : create various objects
    // ja : 各種オブジェクトを作成する
    l_rotate        = self createentityobject( /* notice */ undefined , /* spawnlocation */ self.origin + ( 0 , 0 , 150 ) ,     /* spawnlength */   undefined , /* script */ "script_origin" , /* objectname */ "tag_origin" );
    l_decoration    = self createentityobject( /* notice */ undefined , /* spawnlocation */ l_rotate.origin + ( 100 , 0 , 0 ) , /* spawnlength */   undefined , /* script */ "script_model" , /* objectname */ "veh8_mil_lnd_whotel" , /* objectcollide */ undefined , /* anglesync */ undefined , /* objectangle */ ( 0 , 90 , 0 ) , /* part */ true );
    //l_move          = self createentityobject( /* notice */ undefined , /* spawnlocation */ self.origin ,                       /* spawnlength */   undefined , /* objectname */ "tag_origin" );
    
    // en : link (synchronize) decorative objects to the central rotation object
    // ja : 装飾オブジェクトを中央の回転用オブジェクトにリンク（同期）する
    l_decoration linkto( l_rotate );

    // en : play effects on various objects in subthreads
    // ja : 各種オブジェクトにエフェクトをサブスレッドで再生させる
    l_decoration thread playeffecttoobject( /* time */ 0.25 , /* obj */ l_decoration , /* fx */ "equipment_sparks" , /* tag */ undefined , /* type */ "getplay" , /* loop */ true , /* base */ undefined, /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    
    // en : make the function termination process of the function "forcerespawnpoint" wait in a subthread
    // ja : 機能 "forcerespawnpoint" の機能終了処理をサブスレッドで待機させる
    self thread onendforcerespawnpoint( optname , l_rotate , l_decoration );

    // en : loop processing while function "forcerespawnpoint" is enabled
    // ja : 機能 "forcerespawnpoint" が有効の間はループ処理を行う
    while ( isdefined( level.lvlstat["forcerespawnpoint"] ) )
    {
        //l_move moveto( self.origin + ( 0 , 0 , 100 ) , 2 );
        l_rotate rotateyaw( 360 , 3 );
        wait 3;
        //l_move moveto( self.origin , 2 );
        //l_rotate rotateyaw( 360 , 3 );
        //wait 3;
    }
}



//++++++++++++++++++++++++++++++
// en : function end processing for function "forcerespawnpoint"
// ja : 機能 "forcerespawnpoint" の機能終了処理
//++++++++++++++++++++++++++++++
onendforcerespawnpoint( optname , obj1 , obj2 )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : wait until function "forcerespawnpoint" finishes
    // ja : 機能 "forcerespawnpoint" が終了されるまで待機する
    level waittill( "end_lobby_" + optname );

    obj1 deleteentity( );
    obj2 deleteentity( );
    self deleteentity( );
    level.lvlstat["forcerespawnpoint" + "_flag"] = undefined;
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "pokemonball"
// ja : 機能 "pokemonball" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfpokemonball( )
{
    l_optname = "pokemonball";

    // en : since the process of deleting the previously created case is in progress, the process is interrupted as it cannot be recreated.
    // ja : 前回作った筐体の削除処理が実行中の為、再作成できないとして処理を中断する
    if ( isdefined( self.optstat[l_optname + "deleting"] ) )
    {
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        self showcentermessage( self.curlang , "notice" , "waitendfunction" , undefined , undefined , undefined );
        return;
    }

    // en : execute execpokemonball( ) or exit depending on the existence state of the "pokemonball" variable
    // ja : "pokemonball" 変数の存在状態に合わせて、 execpokemonball( )関数 を実行するか終了する
    self switchonfselffunction(
        /* optname */       l_optname ,
        /* optfunc */       ::execpokemonball ,
        /* message */       undefined ,
        /* optarg1 */       l_optname ,
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
// en : processing during execution of the function "pokemonball"
// ja : 機能 "pokemonball" の実行中の処理
//++++++++++++++++++++++++++++++
execpokemonball( optname )
{
    // en : prevent re-creation while being deleted
    // ja : 削除中は再作成できないようにする
    self.optstat[optname + "deleting"] = true;

    //// en : give specified weapon
    //// ja : 指定の武器を与える
    //self.optstat[optname].weapondata = self provideweapon(
    //    /* weaponid */      "snapshot_grenade_mp" ,
    //    /* isoneshot */     undefined ,
    //    /* onlygroup */     undefined ,
    //    /* attachmentid */  undefined ,
    //    /* camoid */        undefined ,
    //    /* camogroup */     undefined ,
    //    /* akimbo */        undefined ,
    //    /* changehand */    true ,
    //    /* notice */        undefined ,
    //    /* onlygetid */     undefined
    //    );
    //self.optstat[optname].weapondata = self scripts\mp\utility\weapon::_launchgrenade( "snapshot_grenade_mp" , self geteye( ) + anglestoforward( self getplayerangles( ) ) * 100 , ( 0 , 0 , 0 ) , 0.05 , 1 );
    
    l_time = 4;

    // en: generates a specified type of grenade and launches it from the start coordinate to the end coordinate (you are the owner of the bullet)
    // ja: 指定した種類のグレネードを生成し、開始座標から終了座標に向けて飛ばす（弾の所有者は自分自身）
    self.optstat[optname].weapondata = createmagicgrenade( /* owner */ self , /* obj */ self , /* eye */ true , /* length */ 500 , /* weaponid */ getbulletid( "frag_grenade" ) , /* pstart */ self geteye( ) , /* time */ ( l_time + 0.1 ) );


    // en : register onpokemonballfired( ) as a callback function when a grenade is fired.
    // ja : グレネードが発射された時のコールバック関数に onpokemonballfired( ) を登録する
    self.optstat[optname].weapondata thread onpokemonballfired( optname , self , l_time );
}



//++++++++++++++++++++++++++++++
// en : process executed when a grenade is fired
// ja : グレネードが発射された時に実行される処理
//++++++++++++++++++++++++++++++
onpokemonballfired( optname , owner , time )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    owner endon( "disconnect" );
    // en : this function ends processing if "you die"
    // ja : この関数は「自分が死んだ」場合に処理を終了する
    //self endon( "death" );

    wait time;
    l_origin = self.origin;
    wait 0.1;
    
    // en : wait until the fired grenade explodes
    // ja : 発射されたグレネードが爆発するまで待機する
    //l_result = self scripts\engine\utility::waittill_any_return( "death" , "missile_stuck" , "explode" , "projectile_impact" );
 
    // en : obtain animal models randomly
    // ja : 動物モデルをランダムで取得する
    l_modelid = scripts\engine\utility::random( level.lvlstat["modellistanimal"] );
    // en : get a random model
    // ja : ランダムでモデルを取得する
    //switch ( randomintrange( 0 , 2 ) )
    //{
    //    case 0: l_modelid = "mw_test_soldier";   break;
    //    case 1: l_modelid = "pilot_viewmodel_arms";   break;
    //}

    // en : create an 3d model at the generation start position
    // ja : 生成開始位置に3dモデルを作成する
    l_pokemon = createentityobject(
        /* notice */    undefined ,
        /* location */  l_origin ,
        /* length */    undefined ,
        /* script */    "script_model" , 
        /* model */     l_modelid ,
        /* collide */   true ,
        /* sync */      undefined ,
        /* angle */     undefined ,
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

    if ( !isdefined( l_pokemon ) )
    {
        // en : now that the deletion has been completed, it can be recreated.
        // ja : 削除が完了したため再作成できるようにする
        owner.optstat[optname + "deleting"] = undefined;
        owner.optstat[optname] = undefined;
        // en: display the specified text in the center of the screen
        // ja: 画面中央に指定の文章を表示する
        owner showcentermessage( owner.curlang , "failed" , "failedspawnobject" , undefined , l_modelid , undefined );
        return;
    }
    
    l_spawnfx = scripts\engine\utility::random( level.lvlstat["effectlist"] );
    l_movefx = scripts\engine\utility::random( level.lvlstat["effectlist"] );
    
    // en : play the explosion effect at the generation start position
    // ja : 生成開始位置に爆発エフェクトを再生させる
    l_pokemon playeffecttoobject( /* time */ undefined , /* obj */ undefined , /* fx */ l_spawnfx.assetdata , /* tag */ undefined , /* type */ l_spawnfx.typename , /* loop */ undefined , /* base */ l_origin , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    

    l_uptime        = randomfloatrange( 1.0 , 5.0 );
    l_waittime      = randomfloatrange( 1.0 , 2.5 );
    l_movetime      = randomfloatrange( 0.5 , 1.5 );
    l_count         = randomintrange( 1 , 10 );
    l_path          = randomintrange( 0 , 6 );
    l_z             = randomintrange( 1000 , 3000 );
    l_forward       = randomintrange( 1000 , 5000 );
    l_rotatetime    = l_uptime / l_count;

    // en : randomly rotate the yaw angle of a 3d model
    // ja : 3dモデルのヨー角度をランダムに回転させる
    l_pokemon rotateyaw( randomintrange( 0 , 360 ) , 0.01 );
    
    wait l_movetime;

    // en : play the explosion effect at the generation start position
    // ja : 生成開始位置に爆発エフェクトを再生させる
    l_pokemon thread playeffecttoobject( /* time */ 0.01 , /* obj */ l_pokemon , /* fx */ l_movefx.assetdata , /* tag */ undefined , /* type */ l_movefx.typename , /* loop */ true , /* base */ undefined , /* fix */ undefined , /* angle */ undefined , /* range */ undefined , /* stop */ undefined );
    
    l_defaultangle = l_pokemon.angles;

    l_pokemon moveto( l_pokemon.origin + ( 0 , 0 , l_z ) , l_uptime );

    for ( i = 0; i < l_count; i++ )
    {
        switch ( l_path )
        {
            case 0: l_pokemon rotateyaw(    360  , l_rotatetime ); break;
            case 1: l_pokemon rotateyaw(    -360 , l_rotatetime ); break;
            case 2: l_pokemon rotateroll(   360  , l_rotatetime ); break;
            case 3: l_pokemon rotateroll(   -360 , l_rotatetime ); break;
            case 4: l_pokemon rotatepitch(  360  , l_rotatetime ); break;
            case 5: l_pokemon rotatepitch(  -360 , l_rotatetime ); break;
        }
        wait l_rotatetime;
    }
    wait 0.01;
    l_pokemon.angles = l_defaultangle;
    
    wait l_waittime;

    l_location = l_pokemon.origin + ( anglestoforward( l_pokemon.angles ) * l_forward );

    l_pokemon moveto( l_location , l_movetime );
    wait l_movetime;
    // en : generates a nuclear explosion at the specified coordinates (earthquake generation and damage included)
    // ja : 指定した座標に 核爆発 を発生させる （地震発生・ダメージ込み）
    l_pokemon thread execnuclearexplosion( l_location , owner );
    wait 0.1;
    l_pokemon deleteentity( );

    // en : make this mod available again
    // ja : このmodを再度利用できるようにする
    if ( isdefined( owner.optstat[optname + "deleting"] ) )
    {
        owner.optstat[optname + "deleting"] = undefined;
        owner switchonfselffunction(
            /* optname */       optname ,
            /* optfunc */       ::emptyfunction ,
            /* message */       undefined ,
            /* optarg1 */       optname ,
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
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "theclaw"
// ja : 機能 "theclaw" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onftheclaw( )
{
    // en : execute waitfirebullets( ) or exit depending on the existence state of the "theclaw" variable
    // ja : "theclaw" 変数の存在状態に合わせて、 "waitfirebullets" 関数を実行するか終了する
    self switchonflevelfunction(
        /* optname */                               "theclaw" ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               "pleaseshooting" ,
        /* optarg1 */       /* optname1 */          "theclaw" ,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::createtheclaw ,
        /* optarg4 */       /* notice */            true ,
        /* optarg5 */       /* specificweapon */    undefined ,
        /* optarg6 */       /* effectdata */        "hoopty_explode" ,
        /* optarg7 */       /* enddeath */          undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : create a casing for the function "theclaw" at the coordinates of the launch destination.
// ja : 機能 "theclaw" の筐体を、発射先の座標に作成する
//++++++++++++++++++++++++++++++
createtheclaw( location )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );

    l_optname = "theclaw";

    // en : if the function "theclaw" is destroyed, terminate processing in this function
    // ja : 機能 "theclaw" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + l_optname );
    
    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );
    wait 0.001;

    l_objarray      = [];
    l_objarray[0]   = l_optname + "_attach";
    l_objarray[1]   = l_optname + "_link";
    l_objdel        = [];
    l_objdel[0]     = false;
    l_objdel[1]     = false;
    l_listarray     = [];
    l_listarray[0]  = l_optname + "_legs";
    l_listarray[1]  = l_optname + "_boxes";
    l_listarray[2]  = l_optname + "_seats";
    l_listdel       = [];
    l_listdel[0]    = true;
    l_listdel[1]    = true;
    l_listdel[2]    = true;

    // en : execute the completion wait process for the function "theclaw"
    // ja : 機能 "theclaw" の終了待機処理を実行する
    level thread onwaitingdestroyentities(
        /* delmode */   "random" ,              /* optname */       l_optname ,                     /* sfxid */     "exp_helicopter_fuel" ,
        /* expfxid */   "hoopty_explode" ,    /* discfxid */      "hoopty_explode" ,
        /* eqpower */   0.3 ,                   /* eqtime */        1 ,                             /* eqrange */   2000 ,
        /* exptime */   0.01 ,                  /* delay */         10 ,
        /* lastnuke */  true ,                  /* nukepoint */     location ,                      /* owner */     self ,
        /* objarray */  l_objarray ,            /* objdelete */     l_objdel ,
        /* listarray */ l_listarray ,           /* listdelete */    l_listdel
        );
    
    pos = location + ( 0 , 15 , 460 );
    level.lvlstat[l_optname + "_seats"] = [];
    level.lvlstat[l_optname + "_boxes"] = [];
    level.lvlstat[l_optname + "_legs"] = [];
    
    level.lvlstat[l_optname + "_attach"] = modelspawner(location+(0,55,60),"tag_origin" , ( 0 , 0 , 0 ) );
    level.lvlstat[l_optname + "_link"] = modelspawner(pos,"tag_origin" , ( 0 , 0 , 0 ) );

    l_modelid = "military_carepackage_01_enemy";
    l_modelid2 = "military_carepackage_01_enemy";
    l_modelid3 = "military_carepackage_01_enemy";
    l_modelid4 = "military_carepackage_01_enemy";


    for ( e = 0; e < 2; e++ )
    {
        for ( a = 0; a < 8; a++ )
        {
            level.lvlstat[l_optname + "_legs"][level.lvlstat[l_optname + "_legs"].size] = modelspawner( location + ( -220 , -145+e*320 , 0 ) + ( a*28 , 0 , a*60 ) ,
                                                        l_modelid , // military_carepackage_01_juggernaut
                                                        ( 25 , 0 , 90 ) ,
                                                        0.05
                                                        );
        }
    }
    for ( e = 0; e < 2; e++ )
    {
        for ( a = 0; a < 8; a++ )
        {
            level.lvlstat[l_optname + "_legs"][level.lvlstat[l_optname + "_legs"].size] = modelspawner( location + ( 220 , -145+e*320 , 0 ) + ( a*-28 , 0 , a*60 ) ,
                                                        l_modelid , // military_carepackage_01_juggernaut
                                                        ( -25 , 0 , 90 ) ,
                                                        0.05
                                                        );
        }
    }
    for ( a = 0; a < 5; a++ )
    {
        for ( e = 0; e < 8; e++ )
        {
            level.lvlstat[l_optname + "_boxes"][level.lvlstat[l_optname + "_boxes"].size] = modelspawner( location + ( 0 , -125+a*70 , 460 ) + ( sin( -90+e*45 ) *25 , 0 , sin( e*45 ) *25 ) ,
                                                        l_modelid2 , // military_carepackage_01_enemy
                                                        ( ( e*45 ) , 180 , 0 ) ,
                                                        0.05
                                                        );
        }
    }
    for ( a = 0; a < 8; a++ )
    {
        for ( e = 0; e < 6; e++ )
        {
            level.lvlstat[l_optname + "_boxes"][level.lvlstat[l_optname + "_boxes"].size] = modelspawner( location + ( 0 , 15 , 460 ) + ( cos( a*45 )*30 , sin( a*45 )*30 , e*-70 ) ,
                                                        l_modelid3 , // military_crate_large_stackable_01_dummy
                                                        ( 0 , (a*45) + 90 , 90 ) ,
                                                        0.05
                                                        );
        }
    }
    level.lvlstat[l_optname + "_boxes"][level.lvlstat[l_optname + "_boxes"].size] = modelspawner( location + ( 0 , 15 , 60 ) ,
                                                l_modelid4 , // military_crate_large_stackable_01_dummy
                                                ( 0 , 90 , 90 ) ,
                                                0.05
                                                );
    for ( a = 0; a < 2; a++ )
    {
        for ( e = 0; e < 12; e++ )
        {
            level.lvlstat[l_optname + "_boxes"][level.lvlstat[l_optname + "_boxes"].size] = modelspawner( location + ( 0 , 15 , 100 ) + ( cos( e*30 )*40+a*55 , sin( e*30 )*40+a*55 , -70 ) ,
                                                        l_modelid2 , // military_crate_large_stackable_01_jugg
                                                        ( 0 , ( e*30 )+-90+a*90 , 0 ) ,
                                                        0.05
                                                        );
        }
    }
    for ( e = 0; e < 12; e++ )
    {
        level.lvlstat[l_optname + "_seats"][level.lvlstat[l_optname + "_seats"].size] = modelspawner( location + ( 0 , 15 , 95 ) + ( cos( e*30 )*95 , sin( e*30 )*95 , -70) ,
                                                            l_modelid2 , // military_crate_large_stackable_01_dummy
                                                            undefined ,
                                                            0.05
                                                            );
    }
    foreach ( model in level.lvlstat[l_optname + "_boxes"] )
    {
        model linkto( level.lvlstat[l_optname + "_link"] );
    }

    foreach ( model in level.lvlstat[l_optname + "_seats"] )
    {
        model linkto( level.lvlstat[l_optname + "_link"] );
    }

    level.lvlstat[l_optname + "_link"] thread clawmovements( l_optname );
    level.lvlstat[l_optname + "_attach"] thread onattractionplayersmonitoring( l_optname , level.lvlstat[l_optname + "_seats"] , 400 , "delta" );
    level.lvlstat[l_optname + "_attach"] thread ondestroydetachplayers( l_optname );
}



//++++++++++++++++++++++++++++++
// en : function "theclaw" housing behavior processing
// ja : 機能 "theclaw" の筐体の挙動処理
//++++++++++++++++++++++++++++++
clawmovements( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : if the function "theclaw" is destroyed, terminate processing in this function
    // ja : 機能 "theclaw" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

    for ( a = 0; a >= -40; a -= 2 )
    {
        self rotateto( ( a , self.angles[1] , 0 ) , 0.5 );
        wait 0.1;
    }

    for ( a = a; a <= 60; a += 3 )
    {
        self rotateto( ( a , self.angles[1] , 0 ) , 0.5 );
        wait 0.1;
    }

    for ( a = a; a >= -80; a -= 3 )
    {
        self rotateto( ( a , self.angles[1] , 0 ) , 0.5 );
        wait 0.05;
    }

    for ( a = a; a <= 100; a += 4 )
    {
        self rotateto( ( a , self.angles[1] , 0 ) , 0.5 );
        wait 0.05;
    }

    while( true )
    {
        for ( a = a; a >= -105; a -= 5 )
        {
            self rotateto( ( a , self.angles[1] , 0 ) , 0.5 );
            wait 0.05;
        }

        for ( a = a; a <= 105; a += 5 )
        {
            self rotateto( ( a , self.angles[1] , 0 ) , 0.5 );
            wait 0.05;
        }
        wait 0.05;
    }
}



//++++++++++++++++++++++++++++++
// en : switch the enable/disable state of the function "merrygoround"
// ja : 機能 "merrygoround" の有効/無効を切り替える
//++++++++++++++++++++++++++++++
onfmerrygoround( )
{
    // en : execute waitfirebullets( ) or exit depending on the existence state of the "merrygoround" variable
    // ja : "merrygoround" 変数の存在状態に合わせて、 "waitfirebullets" 関数を実行するか終了する
    self switchonflevelfunction(
        /* optname */                               "merrygoround" ,
        /* optfunc */                               ::waitfirebullets ,
        /* message */                               "pleaseshooting" ,
        /* optarg1 */       /* optname1 */          "merrygoround" ,
        /* optarg2 */       /* optname2 */          undefined ,
        /* optarg3 */       /* optfunc */           ::createmerrygoround ,
        /* optarg4 */       /* notice */            true ,
        /* optarg5 */       /* specificweapon */    undefined ,
        /* optarg6 */       /* effectdata */        "hoopty_explode" ,
        /* optarg7 */       /* enddeath */          undefined 
        );
}



//++++++++++++++++++++++++++++++
// en : create a casing for the function "merrygoround" at the coordinates of the launch destination.
// ja : 機能 "merrygoround" の筐体を、発射先の座標に作成する
//++++++++++++++++++++++++++++++
createmerrygoround( location )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : this function ends the process if "you disconnect from the room"
    // ja : この関数は「自分が部屋から切断した」場合に処理を終了する
    self endon( "disconnect" );
    
    l_optname = "merrygoround";

    // en : if the function "merrygoround" is destroyed, terminate processing in this function
    // ja : 機能 "merrygoround" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + l_optname );
    
    // en: set the specified option name as the function termination trigger
    // ja: 指定のオプション名の終了トリガーを通知する
    self notify( "end_" + l_optname );
    wait 0.001;
    
    l_objarray      = [];                       l_objdel        = [];
    l_objarray[0]   = l_optname + "_move";      l_objdel[0]     = true;
    
    l_listarray     = [];                       l_listdel       = [];
    l_listarray[0]  = l_optname + "_body";      l_listdel[0]    = true;
    l_listarray[1]  = l_optname + "_seats";     l_listdel[1]    = true;
    l_listarray[2]  = l_optname + "_seattag";   l_listdel[2]    = true;
    l_listarray[3]  = l_optname + "_lights";    l_listdel[3]    = true;

    // en : execute the completion wait process for the function "merrygoround"
    // ja : 機能 "merrygoround" の終了待機処理を実行する
    level thread onwaitingdestroyentities(
        /* delmode */   "random" ,              /* optname */       l_optname ,                     /* sfxid */     "exp_helicopter_fuel" ,
        /* expfxid */   "hoopty_explode" ,    /* discfxid */      "hoopty_explode" ,
        /* eqpower */   0.3 ,                   /* eqtime */        1 ,                             /* eqrange */   2000 ,
        /* exptime */   0.01 ,                  /* delay */         10 ,
        /* lastnuke */  undefined ,             /* nukepoint */     undefined ,                     /* owner */     undefined ,
        /* objarray */  l_objarray ,            /* objdelete */     l_objdel ,
        /* listarray */ l_listarray ,           /* listdelete */    l_listdel
        );

    level.lvlstat[l_optname].moddata["changespeedmerrygoround"]           = 6;
    level.lvlstat[l_optname + "_body"]         = [];
    level.lvlstat[l_optname + "_seats"]    = [];
    level.lvlstat[l_optname + "_seattag"] = [];
    level.lvlstat[l_optname + "_lights"]   = [];
    level.lvlstat[l_optname + "_move"]     = modelspawner(location + (0,0,35) , "tag_origin" , ( 0 , 0 , 0 ) );
    //modelspawner(self.origin + (0,0,35) + anglestoforward(self getplayerangles())*20, "tag_origin");
    
    sizes       = [0,43,75,107,138,170];
    sizesseats  = [93,139];
    sizeslights = [104,138];

    num = 0;
    time = 0.05;

    l_modelid = "military_carepackage_01_enemy";
    l_modelid2 = "military_carepackage_01_enemy";
    l_modelid3 = "military_carepackage_01_enemy";
    l_modelid4 = "military_carepackage_01_enemy";


    wait 0.5;
    for(e = 0; e < 3; e++) for(i = 0; i < 6; i++)
        level.lvlstat[l_optname + "_body"][level.lvlstat[l_optname + "_body"].size] = modelspawner(level.lvlstat[l_optname + "_move"].origin + (cos(i*60) * 13, sin(i*60) * 13, 15 + e*55), l_modelid, (90, (i*60) + 90, 0), time, level.airdropcratecollision );
    
    for(z = 0; z < 2; z++) for(e = 0; e < 6; e++) for(i = 0; i < 6*e; i++)
    {
        switch ( z )
        {
            case 0: l_modelid = l_modelid3; break;
            case 1: l_modelid = l_modelid4; break;
        }
        level.lvlstat[l_optname + "_body"][level.lvlstat[l_optname + "_body"].size] = modelspawner(level.lvlstat[l_optname + "_move"].origin + (cos(i*360 / (6*e)) * sizes[e], sin(i*360 / (6*e)) * sizes[e], -20 + 180*z), l_modelid, (0, (i* 360 / (6*e)) + 90, 0), time, level.airdropcratecollision );
        level.lvlstat[l_optname + "_body"][level.lvlstat[l_optname + "_body"].size -1] linkto(level.lvlstat[l_optname + "_move"]);
    }
    
    for(e = 0; e < 10; e++) 
    {
        level.lvlstat[l_optname + "_lights"][e] = modelspawner(level.lvlstat[l_optname + "_move"].origin + (cos(e*36) * sizeslights[e%2], sin(e*36) * sizeslights[e%2], 148), "tag_origin", (0, (e*36), 0), time );
        level.lvlstat[l_optname + "_lights"][e+10] = modelspawner(level.lvlstat[l_optname + "_move"].origin + (cos(e*36) * 168, sin(e*36) * 168, 148), "tag_origin", (0, (e*36), 0), time);
        wait 0.05;
        playfxontag( scripts\engine\utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" ) , level.lvlstat[l_optname + "_lights"][e], "tag_origin");
        playfxontag( scripts\engine\utility::getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" ) , level.lvlstat[l_optname + "_lights"][e+10], "tag_origin");

        if      ( e % 4 == 0 ) { l_modelid = "veh8_ind_air_bombing_drone"; }
        else if ( e % 4 == 1 ) { l_modelid = "c_s4_doberman_01"; }
        else if ( e % 4 == 2 ) { l_modelid = "veh8_mil_lnd_whotel"; }
        else if ( e % 4 == 3 ) { l_modelid = "c_s4_doberman_03"; }
        
        level.lvlstat[l_optname + "_seats"][level.lvlstat[l_optname + "_seats"].size] = modelspawner(level.lvlstat[l_optname + "_move"].origin + (cos(e*36) * sizesseats[e%2], sin(e*36) * sizesseats[e%2], 12), l_modelid, (0, (e*36), 0), time );
        level.lvlstat[l_optname + "_seattag"][level.lvlstat[l_optname + "_seattag"].size] = modelspawner(level.lvlstat[l_optname + "_move"].origin + (0, 0, 12), "tag_origin", (0, (e*36), 0), time);
        
        level.lvlstat[l_optname + "_seats"][level.lvlstat[l_optname + "_seats"].size -1] linkto(level.lvlstat[l_optname + "_seattag"][level.lvlstat[l_optname + "_seattag"].size -1]);
    } 
    
    level.lvlstat[l_optname + "_move"] thread rotatemerrygoround( l_optname );
    foreach(tags in level.lvlstat[l_optname + "_seattag"])
    {
        tags thread rotatemerrygoround( l_optname );
        tags thread moveseatsmerrygoround( l_optname );
        //tags thread monitorseats( "merry go round", level.lvlstat[l_optname + "_seats"] );
        
        level.lvlstat[l_optname + "_seats"][ num ] linkto( tags );
        level.lvlstat[l_optname + "_lights"][ num ] linkto( level.lvlstat[l_optname + "_move"] );
        level.lvlstat[l_optname + "_lights"][ num + 10 ] linkto( level.lvlstat[l_optname + "_move"] );
        num++;
    }
    
    level.lvlstat[l_optname + "_move"] thread onattractionplayersmonitoring( l_optname , level.lvlstat[l_optname + "_seats"] , 300 , "default" );
    level.lvlstat[l_optname + "_move"] thread ondestroydetachplayers( l_optname );
    //thread array_thread(level.lvlstat[l_optname + "_seats"], ::monitorseats, "merry go round", level.lvlstat[l_optname + "_seats"] );
}



//++++++++++++++++++++++++++++++
// en : move seats in function "merrygoround"
// ja : 機能 "merrygoround" の座席を移動させる
//++++++++++++++++++++++++++++++
moveseatsmerrygoround( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : if the function "merrygoround" is destroyed, terminate processing in this function
    // ja : 機能 "merrygoround" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );

    while(isdefined(self))
    {
        randnum = randomfloatrange(1,3);
        self movez(65,randnum,0.4,0.4);
        wait randnum;
        randnum = randomfloatrange(1,3);
        self movez(-65,randnum,0.4,0.4);
        wait randnum;
    }
}



//++++++++++++++++++++++++++++++
// en : rotate the casing of the function "merrygoround"
// ja : 機能 "merrygoround" の筐体を回転させる
//++++++++++++++++++++++++++++++
rotatemerrygoround( optname )
{
    // en : this function ends processing when "the match is over"
    // ja : この関数は「試合が終了した」場合に処理を終了する
    level endon( "game_ended" );
    // en : if the function "merrygoround" is destroyed, terminate processing in this function
    // ja : 機能 "merrygoround" が破壊されたら、この関数内の処理を終了する
    level endon( "end_lobby_" + optname );
    // en : when the speed of the function "merrygoround" is changed, finish processing in this function
    // ja : 機能 "merrygoround" の速度が変更されたら、この関数内の処理を終了する
    level endon("changespeed_" + optname );
    
    while(isdefined(self))
    {
        self rotateyaw(360, level.lvlstat[optname].moddata["changespeedmerrygoround"]);
        wait level.lvlstat[optname].moddata["changespeedmerrygoround"];
    }
}



//++++++++++++++++++++++++++++++
// en : change the rotation speed of the casing of the function "merrygoround"
// ja : 機能 "merrygoround" の筐体の回転速度を変更する
//++++++++++++++++++++++++++++++
switchmerrygoroundrotatespeed( )
{
    l_optname = "merrygoround";

    // en: define an array and perform an operation that changes the current parameter from within the array
    // ja: 配列を定義して、配列内から現在のパラメーターを変更する処理を実行する
    l_array     = [];
    
    l_array[0]  = 50;
    l_array[1]  = 40;
    l_array[2]  = 30;
    l_array[3]  = 25;
    l_array[4]  = 20;
    l_array[5]  = 18;
    l_array[6]  = 16;
    l_array[7]  = 14;
    l_array[8]  = 12;
    l_array[9]  = 10;
    l_array[10] = 9;
    l_array[11] = 8;
    l_array[12] = 7;
    l_array[13] = 6;
    l_array[14] = 5;
    l_array[15] = 4;
    l_array[16] = 3;
    l_array[17] = 2;
    l_array[18] = 1;
    l_array[19] = 0.9;
    l_array[20] = 0.8;
    l_array[21] = 0.7;
    l_array[22] = 0.6;
    l_array[23] = 0.5;
    l_array[24] = 0.4;
    l_array[25] = 0.3;
    l_array[26] = 0.2;
    l_array[27] = 0.1;

    self changelevelparameter( l_optname , "changespeed" + l_optname , undefined , ::onfmerrygoround , l_array , true , undefined );

    if ( isdefined( level.lvlstat[l_optname + "_move"] ) )
    {
        wait 0.1;
        level notify("changespeed_" + l_optname);
        level.lvlstat[l_optname + "_move"] thread rotatemerrygoround( l_optname );
        foreach(tags in level.lvlstat[l_optname + "_seattag"])
        {
            tags thread rotatemerrygoround(l_optname);
        }
    }
}











































































































































































// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : The original GSC function (emptied to avoid DEV ERROR when called from an external class)
// ja : 元GSCの関数（外部クラスからのコール時のDEV ERROR回避用に空にする）
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



main(){}
_id_81CB(){}
_id_AB9A(){}
_id_10972(){}
_id_1631(){}
_id_117F(){}
_id_FC7A(){}
_id_6CB4( var_0 ){}
_id_827A(){}
_id_FF55( var_0 ){}
_id_6D2C(){}
_id_3879(){}
_id_6D2F( var_0, var_1 ){}
_id_6D8D( var_0, var_1 ){}
_id_AB46( var_0 ){}
_id_AB50( var_0 ){}
_id_AAF2(){}
_id_AB91(){}
_id_AB8E(){}
_id_D706( var_0 ){}
_id_9FF2(){}
_id_AB4E( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 ){}
_id_4314(){}
_id_AB2C( var_0, var_1, var_2, var_3, var_4, var_5 ){}
_id_AB5D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ){}
_id_34B9(){}
_id_ABAD(){}
_id_ABB0(){}
_id_3502(){}
_id_34F3(){}
_id_AA90( var_0 ){}
_id_ABAE( var_0 ){}
_id_3535( var_0 ){}
_id_1A3C( var_0, var_1, var_2, var_3, var_4 ){}
_id_D69E(){}
_id_CA15(){}
_id_FC82(){}
_id_2CDD(){}
_id_2CE1( var_0, var_1, var_2 ){}
_id_2CE5( var_0, var_1, var_2 ){}
_id_6D46(){}
_id_FF64( var_0 ){}
_id_FF65( var_0 ){}
_id_6D47(){}
_id_6D48(){}
_id_D8AB(){}
_id_2CE7( var_0 ){}
_id_4615(){}
_id_FD08(){}
_id_2E85(){}
_id_FCAA( var_0, var_1 ){}
_id_1A94( var_0, var_1 ){}
_id_1A93( var_0, var_1 ){}
_id_1A92( var_0 ){}
_id_2CE3(){}
_id_6CB5( var_0 ){}
_id_82A2(){}
_id_D8BC(){}
_id_6CB0(){}
_id_E3A4( var_0, var_1, var_2 ){}
_id_5BDB( var_0 ){}
_id_69F4( var_0 ){}
_id_69F2( var_0 ){}
_id_69F1( var_0 ){}
_id_9A20( var_0, var_1 ){}
_id_10ADC(){}
_id_3510( var_0 ){}
_id_34CC( var_0 ){}
_id_34FE( var_0 ){}
_id_5020( var_0 ){}
_id_10BCD(){}
_id_FC00( var_0 ){}
_id_2E7E( var_0 ){}
_id_D531(){}
_id_6A6A( var_0 ){}
_id_6A6B( var_0, var_1 ){}
_id_D532( var_0 ){}
_id_E2F0( var_0 ){}
_id_DCA6(){}
_id_1A83( var_0 ){}
_id_1A85( var_0, var_1, var_2, var_3 ){}
_id_1A84( var_0, var_1, var_2 ){}
_id_1A82( var_0 ){}
_id_1A81(){}
_id_5E85(){}
_id_4AB5(){}
_id_C492(){}
_id_475F(){}
_id_D85D(){}
_id_3FA4( var_0 ){}
_id_5339( var_0 ){}
_id_533A( var_0, var_1, var_2 ){}
_id_5338( var_0 ){}
_id_5336(){}
_id_5337( var_0 ){}
_id_533B( var_0, var_1 ){}
_id_533C( var_0 ){}
_id_692E(){}
_id_6F7D( var_0, var_1 ){}
_id_E704(){}
_id_DB9B(){}
_id_4749(){}
_id_4CC1( var_0 ){}
_id_4CC5( var_0 ){}
_id_ACC1(){}
_id_C489(){}
_id_A69F(){}
_id_ACC6( var_0, var_1 ){}
_id_ACF3(){}
_id_6BCF( var_0, var_1 ){}
_id_3971(){}
_id_D078(){}
_id_FCC0(){}
_id_D5A0(){}
_id_D8BA(){}
_id_8936(){}
_id_89C9(){}
_id_8965(){}
_id_886D(){}
_id_89F4(){}
_id_89CB(){}
_id_89C7(){}
_id_89CD(){}
_id_89CA(){}
_id_89CC(){}
_id_89CE(){}
_id_89C8(){}
_id_89C3(){}
_id_DFBC(){}
_id_D8A5(){}
_id_10BFC( var_0, var_1 ){}
_id_10869( var_0 ){}
_id_DFBE(){}
