// script_496824bf1de5dd83  (hash_496824bf1de5dd83.gscc) (size: 20061 Bytes / 0x4e5d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdda0211c (3718258972)
// size ...... 20061 (0x4e5d)
// includes .. 33  (offset: 0x4acd)
// strings ... 44  (offset: 0x4bd5)
// dev strs .. 8   (offset: 0x4dfd)
// exports ... 56  (offset: 0x2e69)
// cseg ...... 0x39e + 0x2acb (0x2e69)
// imports ... 169 (offset: 0x3729)
// animtree1 . 0   (offset: 0x4e5d)
// animtree2 . 0   (offset: 0x4e5d)
#using script_23eca243497ca70a;
#using script_2444b97a3516cbb0;
#using script_26ccbfe3954cacf4;
#using script_4a7080e904a6380e;
#using script_4c9bd9a3bf3f8cf7;
#using script_559a5ee3e046d0e4;
#using script_5ebd466e28731b7a;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_util;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_armor;
#using scripts\mp\loot\common_item_database;

#namespace bt_bot_br;

// Namespace bt_bot_br
// Params 0, eflags: 0x5
// Checksum 0x27397021, Offset: 0x3bc
// Size: 0x26
function private autoexec main()
{
    var_8cd1c14d997fbe7f = bots_util::function_37a3a6193a454294();
    
    if ( var_8cd1c14d997fbe7f == "bot_br" )
    {
        thread function_2353ac3de7b0f1cb();
    }
}

// Namespace bt_bot_br
// Params 0, eflags: 0x5
// Checksum 0xc132a640, Offset: 0x3ea
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"bt_bot_br", undefined, undefined, &postmain );
}

// Namespace bt_bot_br
// Params 0
// Checksum 0x26b2c1a7, Offset: 0x40b
// Size: 0x24
function postmain()
{
    if ( !level.var_eed87bbca312c1a0 )
    {
        return;
    }
    
    if ( level.var_935a32375dac97bf )
    {
        return;
    }
    
    super_bot::function_71585fa0eb269a5f();
}

// Namespace bt_bot_br
// Params 0
// Checksum 0xdd3dc254, Offset: 0x437
// Size: 0x19f
function function_2353ac3de7b0f1cb()
{
    level.var_eed87bbca312c1a0 = 1;
    level.var_3db2463af78badf7 = &function_cb0e9b3465599c45;
    level.var_d87075686581c9fb = &function_b93869edbe1ed3a2;
    level callback::add( #"hash_92f629d70137a6ae", &function_5b678a0881a59ed2 );
    flags::function_2f3408423ccc9b2e( "bots_setup_callbacks_ended" );
    function_ec8ca478e05373ae();
    level.bot_funcs[ "gametype_think" ] = &function_affd73aa0dca4392;
    level.bot_funcs[ "player_spawned_gamemode" ] = &spawned;
    
    if ( manager::isenabled() )
    {
        level callback::add( #"player_connect", &manager::onplayerconnect );
        level callback::add( #"player_disconnect", &manager::onplayerdisconnect );
    }
    
    level callback::add( #"player_disconnect", &onplayerdisconnect );
    level callback::add( #"on_contract_start", &oncontractstart );
    level callback::add( #"on_contract_end", &oncontractend );
    level callback::add( #"on_contract_shown", &function_a58e3c70128852f2 );
    level callback::add( #"on_contract_hidden", &function_c4ea0c282b3b7095 );
    
    if ( getdvarint( @"hash_eea8fef00f2edc7f", 0 ) == 1 && bots_gametype_br_super::function_3130ca8d103182cd() )
    {
        level callback::add( #"player_spawned", &onplayerspawned );
    }
    
    level.bots_gametype_handles_class_choice = !level.br_allowloadoutonlyinprelobby && !game_utility_mp::allowclasschoice();
    level.var_d4909c0acc55763c = function_d4c5523a3a80a15a( bots_util::function_8a733bde8a63352d() );
    namespace_626c96a2fc3e681b::function_b2fbe53036657d2b();
    namespace_626c96a2fc3e681b::function_e8cce0f7a7bcff7f();
    level thread bots_gametype_br_super::function_c04979d72c02f51d();
    namespace_f1c6181bdb874edd::init();
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x87e6f3c8, Offset: 0x5de
// Size: 0x1c
function private onplayerspawned( params )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    thread function_effb8c7171cf4bf0();
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xbd642eba, Offset: 0x602
// Size: 0x132
function private function_effb8c7171cf4bf0()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
        
        if ( self isonground() )
        {
            continue;
        }
        
        var_71c20e29a7ebd2c5 = getclosestpointonnavmesh( self.origin );
        
        while ( !self isonground() )
        {
            if ( self isparachuting() || self isparachutedeployed() )
            {
                parachuteposition = self.origin;
                recordedtime = gettime();
                teammates = teams::getteamdata( self.team, "alivePlayers" );
                
                foreach ( player in teammates )
                {
                    if ( isbot( player ) )
                    {
                        player function_69ef797f6c78f2fe( var_71c20e29a7ebd2c5, parachuteposition, self, recordedtime );
                    }
                }
                
                while ( !self isonground() )
                {
                    waitframe();
                }
                
                break;
            }
            
            waitframe();
        }
    }
}

// Namespace bt_bot_br
// Params 4, eflags: 0x4
// Checksum 0x73a29fb4, Offset: 0x73c
// Size: 0x95
function private function_69ef797f6c78f2fe( var_71c20e29a7ebd2c5, parachuteposition, var_57f06685d6d47d0f, recordedtime )
{
    self._blackboard.var_c2168fde9e1c1037 = var_71c20e29a7ebd2c5;
    self._blackboard.var_4c0b8a56bd3cfb04 = parachuteposition;
    self._blackboard.var_b86500bad17e7a7d = var_57f06685d6d47d0f;
    self._blackboard.var_5b1af86c0986c779 = recordedtime;
    self._blackboard.var_226cbe6d1355a04d = 1;
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x753cc95a, Offset: 0x7d9
// Size: 0x1c
function private onplayerdisconnect( params )
{
    if ( !isbot( self ) )
    {
        return;
    }
    
    self function_4f40a18f7416a01e();
}

// Namespace bt_bot_br
// Params 2, eflags: 0x4
// Checksum 0x1d573280, Offset: 0x7fd
// Size: 0x3a
function private function_cb0e9b3465599c45( var_7dc27bc9fa62c763, var_d094491947d7985 )
{
    assert( isdefined( var_7dc27bc9fa62c763 ) );
    super_bot::function_58e0d490b945efe( var_d094491947d7985 );
    manager::initialize( var_7dc27bc9fa62c763 );
    level thread bots_gametype_br_super::function_91ad800039e8b01d();
}

// Namespace bt_bot_br
// Params 1
// Checksum 0xbfc51dd0, Offset: 0x83f
// Size: 0xb9
function function_2d71740f6c8b496d( taskid )
{
    if ( !isdefined( level.var_b7611ddaf43956e1 ) )
    {
        function_701c5a7783aaf294();
    }
    
    if ( namespace_ddca46d216b096e2::isenabled() )
    {
        namespace_ddca46d216b096e2::function_30b9db7247f23009();
        self._blackboard.var_4fcb04961ec730bb = self.bba_id;
    }
    
    bots::bot_set_xuid();
    self.onlyscriptenemy = 1;
    bots_util_mp::bot_set_personality( "run_and_gun" );
    
    if ( isautopilot( self ) )
    {
        function_e6d0c4a7c1d366df();
    }
    
    item_armor::update_max_armor_plate();
    thread function_9991ab57a03392ae();
    assert( !isdefined( level.mind ) && !isdefined( self.mind ), "<dev string:x24>" );
    return anim.success;
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x6420c4f8, Offset: 0x901
// Size: 0xb8
function private function_5b678a0881a59ed2( params )
{
    foreach ( tablet in level.activitymanager.visibletablets )
    {
        ref = tablet.associatedactivityinstance.varianttag;
        
        if ( function_1c2142a6331e0ee3( ref ) )
        {
            function_676a060277eaf678( tablet, ref );
        }
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x6fa1d173, Offset: 0x9c1
// Size: 0x40
function private function_a58e3c70128852f2( params )
{
    ref = params.ref;
    
    if ( function_1c2142a6331e0ee3( ref ) )
    {
        function_676a060277eaf678( params.tablet, ref );
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x880e9284, Offset: 0xa09
// Size: 0x30
function private function_c4ea0c282b3b7095( params )
{
    if ( function_1c2142a6331e0ee3( params.ref ) )
    {
        function_b230779ec82efed5( params.tablet );
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x6bd7f450, Offset: 0xa41
// Size: 0xf1
function private oncontractstart( params )
{
    task = params.task;
    ref = task.varianttag;
    
    if ( !isdefined( ref ) )
    {
        ref = task.type.ref;
    }
    
    if ( function_1c2142a6331e0ee3( ref ) )
    {
        type = { #ref:ref };
        domflagindex = task.domflag.index;
        domflagradius = task.domflag.radius;
        var_1de59aa6234e7ba5 = { #domflagradius:domflagradius, #domflagindex:domflagindex, #type:type };
        function_7e45bf92fa00637c( params.index, var_1de59aa6234e7ba5 );
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x3dcf37eb, Offset: 0xb3a
// Size: 0x1d
function private oncontractend( params )
{
    function_7e45bf92fa00637c( params.index, undefined );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x766014ef, Offset: 0xb5f
// Size: 0x44, Type: bool
function private function_1c2142a6331e0ee3( ref )
{
    return ref == "assassination" || ref == "recon" || ref == "scavenger" || ref == "vip" || ref == "timedrun";
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x592582d8, Offset: 0xbac
// Size: 0x1d5
function private function_58af24392f39f194()
{
    var_232857ed7c70890f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73() : undefined;
    var_4375d83555c8dd6f = var_232857ed7c70890f[ 0 ];
    assert( isdefined( var_4375d83555c8dd6f ) );
    backpacksize = common_inventory::function_9cd65c8312048802();
    
    for ( index = 0; index < backpacksize ; index++ )
    {
        [ r, c ] = common_inventory_groups::function_12ee5af12df204b4( var_4375d83555c8dd6f, index );
        
        if ( !( isdefined( r ) && isdefined( c ) ) )
        {
            continue;
        }
        
        buttondefinition = common_inventory_groups::function_62e8f7d021e6a61e( var_4375d83555c8dd6f, r, c );
        typedata = common_inventory_groups::function_ec48255a23c8526f( buttondefinition );
        
        if ( typedata.alloweditems.size != 1 )
        {
            var_e777a4e7ababdcba = buttondefinition.alloweditemtypes[ 0 ].itemtype;
            
            if ( var_e777a4e7ababdcba )
            {
                typeref = getscriptbundlefieldvalue( var_e777a4e7ababdcba, #"typeref" );
                
                if ( typeref != #"ammo" )
                {
                    continue;
                }
            }
            
            assertmsg( "<dev string:x3c>" + getxhashsourcename( var_232857ed7c70890f[ 1 ] ) );
            continue;
        }
        
        itembundlename = typedata.alloweditems[ 0 ].itemspawnentry;
        ref = getscriptbundlefieldvalue( itembundlename, #"ref" );
        
        if ( !isdefined( ref ) )
        {
            assertmsg( "<dev string:x98>" + getxhashsourcename( itembundlename ) + "<dev string:xc5>" );
            continue;
        }
        
        lootid = common_item::items_getlootidfromref( ref );
        upgrade = level.backpackupgrades[ ref ] ?? 0;
        function_7f579a554ff38996( lootid, index, upgrade );
    }
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xa875b377, Offset: 0xd89
// Size: 0x232
function private function_701c5a7783aaf294()
{
    level.var_b7611ddaf43956e1 = { #var_8a8eeef162319d29:[] };
    level callback::add( #"hash_a1314093a84c7a9d", &function_d47bf3eafe44dfdc );
    level callback::add( "killstreak_equipped", &function_d47bf3eafe44dfdc );
    level callback::add( #"player_laststand", &function_3a49debcd5f98521 );
    level callback::add( #"player_laststand_exit", &function_4ed2f73e77a2b961 );
    level callback::add( #"redeploy_station_setup", &function_56c01a3bdc03ff0c );
    level callback::add( #"redeploy_station_destroy", &function_3a68145ed6f39043 );
    level callback::add( #"hash_c68091d0c9dcd5d5", &function_2336a5380efc65b6 );
    level callback::add( #"hash_12899373e61ab1f9", &function_dbd1c5a07146608f );
    level.bot_funcs[ "select_class_from_airdrop" ] = &function_b99b753a2ef95ce2;
    utility::registersharedfunc( #"bots", #"acceleratebotsgulagmatch", &bots_gametype_br_super::onacceleratebotsgulagmatch );
    
    if ( manager::isenabled() )
    {
        utility::registersharedfunc( #"gametype", #"mayconsiderplayerdead", &bots_gametype_br_super::function_ad6462143397c488, 1 );
        utility::registersharedfunc( #"bots", #"hash_b4affa645366edaa", &ui_bot::DropUIBotsIfNecessary );
    }
    
    super_bot::function_f1fe54955f1a92d9();
    function_7d3d422411b707f0();
    level.var_6a8e88d5a8429194.var_22be9d548062d8ba = 4000000;
    level.var_6a8e88d5a8429194.var_9a182c18e1149590 = 4000000;
    thread function_9f9b68569116bc7e();
    thread function_30874da3f8b5254d();
    thread function_354fb49cb97b34c4();
    thread function_c1010d1df449549c();
    thread function_634314ee126ca0ef();
    level.var_6a8e88d5a8429194.var_2cee662e72a4aeb = 95062500;
    level.var_6a8e88d5a8429194.var_ef1b9156f84b502a = 95062500;
    level.var_6a8e88d5a8429194.var_a1182db4305f7ce9 = isdefined( level.prematchspawnorigins ) && level.prematchspawnorigins.size > 0;
    function_d94e16e210f6e19f();
    level.var_6a8e88d5a8429194.var_6a3bee986f1241ad = istrue( level.var_5a32b792b8e156b0 );
    function_58af24392f39f194();
    function_a7ff14f023189abc();
}

// Namespace bt_bot_br
// Params 0
// Checksum 0xefd0a1ba, Offset: 0xfc3
// Size: 0x7e
function function_affd73aa0dca4392()
{
    self endon( #"bot_suspended" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    ui_bot::laterecoverbotprofile();
    
    if ( gamelogic_mp::inprematch() )
    {
        if ( manager::tryrecycle( 1 ) )
        {
            return;
        }
    }
    else if ( level.skipprematch && !level.br_infils_disabled )
    {
        if ( manager::tryrecycle( 2 ) )
        {
            return;
        }
    }
    
    childthread bots_gametype_br_super::function_ef8f5c98be46bfdb();
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xe98bce45, Offset: 0x1049
// Size: 0x59
function private function_88ae7ca68bb09f1d()
{
    self botsetflag( "enable_deploy_parachute", 1 );
    self botsetflag( "ignore_script_weapon", 1 );
    self botsetflag( "allow_laststand_decision", 1 );
    self botsetflag( "disable_random_goal", 1 );
    self botsetflag( "allow_slide_for_any_script_goal", 1 );
    self botsetflag( "disable_search_look", 1 );
    self function_fd0539a38d8fa649( 3000 );
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x1cd5bf2c, Offset: 0x10aa
// Size: 0xbd
function private spawned()
{
    function_e6d0c4a7c1d366df();
    var_dd1a337b4637b544 = istrue( self.uibot.var_a29e5f57c1ef9e35 );
    var_eb7d41eda118fcce = self.gulaguses > 0;
    var_fd343e009afe2d40 = !var_dd1a337b4637b544 && !var_eb7d41eda118fcce && !self.respawningfromtoken;
    self.var_64507fe370f400b2 = var_eb7d41eda118fcce;
    
    if ( var_dd1a337b4637b544 )
    {
        player::function_e4f77222086e66b( 1 );
    }
    
    if ( var_fd343e009afe2d40 )
    {
        bots_gametype_br_super::function_812cf778216054c7();
    }
    
    ui_bot::RecoverBotProfile();
    
    if ( var_fd343e009afe2d40 && !gamelogic_mp::inprematch() )
    {
        var_27abb5ea87c4bbb5 = getmatchrulesdata( "brData", "plunderBotStartAmount" );
        br_plunder::playersetplundercount( var_27abb5ea87c4bbb5 );
    }
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xfb41214f, Offset: 0x116f
// Size: 0x38
function private function_8e6602fded8d92c8()
{
    profilestart();
    
    if ( isautopilot( self ) )
    {
        self.var_e2512b84b839d80f = 1;
        profilestop();
        return;
    }
    
    if ( recycle_manager::isenabled() )
    {
        if ( recycle_manager::function_82a8830ca0d038c( self ) )
        {
            profilestop();
            return;
        }
    }
    
    self.var_e2512b84b839d80f = 0;
    profilestop();
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x5c7a8a45, Offset: 0x11af
// Size: 0x106
function private function_e6d0c4a7c1d366df()
{
    function_88ae7ca68bb09f1d();
    function_8e6602fded8d92c8();
    
    if ( !self.jumped )
    {
        isInInfilPlane = isdefined( self.c130 );
        self.jumped = level.br_infils_disabled || !gamelogic_mp::inprematch() && !isInInfilPlane;
    }
    
    self._blackboard.infiljumped = istrue( self.jumped );
    self._blackboard.var_50edfe96f927ca5 = val::get( "armor" );
    self._blackboard.backpacksize = common_inventory::function_9cd65c8312048802();
    self._blackboard.desiredzoneindex = -1;
    self function_786bb6aa1b76c7ee( "combatUpdateInterval", 10 );
    function_d47bf3eafe44dfdc();
    function_dbd1c5a07146608f();
    
    if ( self.var_8eaddde9453c280b && bots_gametype_br_super::function_3130ca8d103182cd() )
    {
        self.var_8eaddde9453c280b = 0;
        onplayerrespawn();
    }
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x67c0f26f, Offset: 0x12bd
// Size: 0x99
function private onplayerrespawn()
{
    player = self;
    
    if ( !isbot( player ) )
    {
        return;
    }
    
    player._blackboard.parachutingleader = undefined;
    player._blackboard.parachutingtarget = undefined;
    human = player function_1e66c2d6c9fe61d7();
    
    if ( !human )
    {
        return;
    }
    
    if ( human isskydiving() )
    {
        player._blackboard.parachutingleader = human;
        return;
    }
    
    player._blackboard.parachutingtarget = human;
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xea9946cb, Offset: 0x135e
// Size: 0x97
function private function_1e66c2d6c9fe61d7()
{
    teammates = teams::getteamdata( self.team, "alivePlayers" );
    
    foreach ( player in teammates )
    {
        if ( bots_gametype_br_super::function_af39e3160ea3eca4( player ) )
        {
            return player;
        }
    }
}

// Namespace bt_bot_br
// Params 0
// Checksum 0xc1595614, Offset: 0x13fe
// Size: 0x67e
function function_9991ab57a03392ae()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"exit_autopilot" );
    self.var_d137e4e4c2e4c70c = [];
    
    while ( true )
    {
        waitframe();
        tmpvalue = manager::function_c8a525cf7247da07();
        
        if ( !( self.var_d137e4e4c2e4c70c[ 607 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 607 ] = tmpvalue;
            self._blackboard.var_8aae61f0b3f11132 = tmpvalue;
        }
        
        tmpvalue = self.maxarmorhealth;
        
        if ( !( self.var_d137e4e4c2e4c70c[ 609 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 609 ] = tmpvalue;
            self._blackboard.maxarmorhealth = tmpvalue;
        }
        
        tmpvalue = istrue( self.insertingarmorplate );
        
        if ( !( self.var_d137e4e4c2e4c70c[ 610 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 610 ] = tmpvalue;
            self._blackboard.insertingarmorplate = tmpvalue;
        }
        
        tmpvalue = istrue( self.jumped );
        
        if ( !( self.var_d137e4e4c2e4c70c[ 611 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 611 ] = tmpvalue;
            self._blackboard.infiljumped = tmpvalue;
        }
        
        tmpvalue = int( max( self.lastdamagedtime ?? 0, self.var_ee1eedef79be45b2 ?? 0 ) );
        
        if ( !( self.var_d137e4e4c2e4c70c[ 612 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 612 ] = tmpvalue;
            self._blackboard.var_5f820b15f4f95252 = tmpvalue;
        }
        
        tmpvalue = self.gasmaskhealth;
        
        if ( !( self.var_d137e4e4c2e4c70c[ 613 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 613 ] = tmpvalue;
            self._blackboard.gasmaskhealth = tmpvalue;
        }
        
        tmpvalue = isdefined( self.var_c9936bbb7d91d9e );
        
        if ( !( self.var_d137e4e4c2e4c70c[ 614 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 614 ] = tmpvalue;
            self._blackboard.var_25046ccdd693b27a = tmpvalue;
        }
        
        tmpvalue = isdefined( self.br_infil_type );
        
        if ( !( self.var_d137e4e4c2e4c70c[ 615 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 615 ] = tmpvalue;
            self._blackboard.var_6b1ff69e6190d585 = tmpvalue;
        }
        
        tmpvalue = self.equipment[ "health" ];
        
        if ( !( self.var_d137e4e4c2e4c70c[ 616 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 616 ] = tmpvalue;
            self._blackboard.var_7d1769e9dc6af047 = tmpvalue;
        }
        
        tmpvalue = self.equipment[ "primary" ];
        
        if ( !( self.var_d137e4e4c2e4c70c[ 617 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 617 ] = tmpvalue;
            self._blackboard.var_69da353967c59a1 = tmpvalue;
        }
        
        tmpvalue = self.equipment[ "secondary" ];
        
        if ( !( self.var_d137e4e4c2e4c70c[ 618 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 618 ] = tmpvalue;
            self._blackboard.var_41df877266edf739 = tmpvalue;
        }
        
        tmpvalue = self.self_revive_item.ref;
        
        if ( !( self.var_d137e4e4c2e4c70c[ 619 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 619 ] = tmpvalue;
            self._blackboard.selfreviveref = tmpvalue;
        }
        
        tmpvalue = self.n_self_revives ?? 0;
        
        if ( !( self.var_d137e4e4c2e4c70c[ 620 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 620 ] = tmpvalue;
            self._blackboard.selfReviveCount = tmpvalue;
        }
        
        if ( isdefined( self.arena ) )
        {
            tmpvalue = self.arena.arenaplayers[ 0 ];
            
            if ( !( self.var_d137e4e4c2e4c70c[ 624 ] === tmpvalue ) )
            {
                self.var_d137e4e4c2e4c70c[ 624 ] = tmpvalue;
                self._blackboard.var_2b01e1dfe8d2aac0 = tmpvalue;
            }
            
            tmpvalue = self.arena.arenaplayers[ 1 ];
            
            if ( !( self.var_d137e4e4c2e4c70c[ 625 ] === tmpvalue ) )
            {
                self.var_d137e4e4c2e4c70c[ 625 ] = tmpvalue;
                self._blackboard.var_2b01e2dfe8d2acf3 = tmpvalue;
            }
            
            tmpvalue = self.arena.arenaplayers[ 2 ];
            
            if ( !( self.var_d137e4e4c2e4c70c[ 626 ] === tmpvalue ) )
            {
                self.var_d137e4e4c2e4c70c[ 626 ] = tmpvalue;
                self._blackboard.var_2b01e3dfe8d2af26 = tmpvalue;
            }
            
            tmpvalue = self.arena.arenaplayers[ 3 ];
            
            if ( !( self.var_d137e4e4c2e4c70c[ 627 ] === tmpvalue ) )
            {
                self.var_d137e4e4c2e4c70c[ 627 ] = tmpvalue;
                self._blackboard.var_2b01e4dfe8d2b159 = tmpvalue;
            }
        }
        
        if ( self.inlaststand )
        {
            iseligible = laststand::function_aab0a23ef041d1f9();
            canselfrevive = iseligible && !laststand::function_f2bf1b505a78c70b();
            tmpvalue = canselfrevive;
            
            if ( !( self.var_d137e4e4c2e4c70c[ 634 ] === tmpvalue ) )
            {
                self.var_d137e4e4c2e4c70c[ 634 ] = tmpvalue;
                self._blackboard.var_1fd152a518fd116 = tmpvalue;
            }
            
            tmpvalue = iseligible;
            
            if ( !( self.var_d137e4e4c2e4c70c[ 635 ] === tmpvalue ) )
            {
                self.var_d137e4e4c2e4c70c[ 635 ] = tmpvalue;
                self._blackboard.var_f03c546273fd54c2 = tmpvalue;
            }
            
            continue;
        }
        
        tmpvalue = 0;
        
        if ( !( self.var_d137e4e4c2e4c70c[ 639 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 639 ] = tmpvalue;
            self._blackboard.var_1fd152a518fd116 = tmpvalue;
        }
        
        tmpvalue = 0;
        
        if ( !( self.var_d137e4e4c2e4c70c[ 640 ] === tmpvalue ) )
        {
            self.var_d137e4e4c2e4c70c[ 640 ] = tmpvalue;
            self._blackboard.var_f03c546273fd54c2 = tmpvalue;
        }
    }
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x329b7f10, Offset: 0x1a84
// Size: 0x3f
function private function_d94e16e210f6e19f()
{
    assert( bots_gametype_br_super::iscommonitemenabled(), "<dev string:xe4>" );
    var_84d9ba829df9c743 = [];
    
    if ( bots_gametype_br_super::iscommonitemenabled() )
    {
        var_84d9ba829df9c743 = function_984bcd616874bc26( "cache" );
    }
    
    function_a29d5b795d7d4e58( var_84d9ba829df9c743 );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x79c0280f, Offset: 0x1acb
// Size: 0xc7
function private function_984bcd616874bc26( itemtype )
{
    array = [];
    bundlenames = common_item_database::function_eb5323bad2b41c84( itemtype );
    
    if ( isdefined( bundlenames ) )
    {
        foreach ( bundlename in bundlenames )
        {
            bundle = common_item::function_90c3e0c1fd55d6b6( bundlename );
            
            if ( isdefined( bundle ) )
            {
                array[ array.size ] = bundle.scriptable;
            }
        }
    }
    
    return arrayremoveduplicates( array );
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xb4260b12, Offset: 0x1b9b
// Size: 0x29d
function private function_354fb49cb97b34c4()
{
    level endon( #"game_ended" );
    var_bebe2b19b531b4e = istrue( level.br_c130spawndone );
    
    if ( level.br_infils_disabled || var_bebe2b19b531b4e )
    {
        level.var_6a8e88d5a8429194.var_4d239fe84f3804fa = 0;
        level.var_6a8e88d5a8429194.var_b4b2e61e40726363 = undefined;
        return;
    }
    
    if ( !level.c130inbounds )
    {
        level waittill( #"br_c130_in_bounds" );
    }
    
    plane = level.br_ac130;
    level.var_6a8e88d5a8429194.var_4d239fe84f3804fa = level.c130inbounds;
    level.var_6a8e88d5a8429194.var_b4b2e61e40726363 = plane;
    level.var_6a8e88d5a8429194.var_d4e0c5b5af181ab = br_c130::getc130speed();
    level.var_6a8e88d5a8429194.var_cd28922768812157 = plane.pathstruct.startpt ?? ( 0, 0, 0 );
    level.var_6a8e88d5a8429194.var_60570b032e887dd = plane.pathstruct.startptui ?? ( 0, 0, 0 );
    level.var_6a8e88d5a8429194.var_1bacd6bb89944c62 = plane.pathstruct.endpt ?? ( 0, 0, 0 );
    level.var_6a8e88d5a8429194.var_8bcae05c30b84c34 = plane.pathstruct.endptui ?? ( 0, 0, 0 );
    level.var_6a8e88d5a8429194.var_b08b26dfe506030c = plane.pathstruct.angle ?? ( 0, 0, 0 );
    level.var_6a8e88d5a8429194.var_58a0959887af3601 = plane.pathstruct.pathdir ?? ( 0, 0, 0 );
    level.var_6a8e88d5a8429194.var_65f5986e6b351d7c = plane.pathstruct.centerpt ?? ( 0, 0, 0 );
    level waittill( #"br_c130_left_bounds" );
    level.var_6a8e88d5a8429194.var_4d239fe84f3804fa = 0;
    level.var_6a8e88d5a8429194.var_b4b2e61e40726363 = undefined;
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x51c43d6b, Offset: 0x1e40
// Size: 0x3e
function private function_9f9b68569116bc7e()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_a77cfbf997d227c2();
        level utility::waittill_any( "prematch_cleanup_done", "br_circle_init", "br_circle_set", "br_circle_relocation", "br_circle_started" );
    }
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xed503ee7, Offset: 0x1e86
// Size: 0x248
function private function_a77cfbf997d227c2()
{
    if ( !isdefined( level.br_circle.circleindex ) || !isdefined( level.br_level.br_circleclosetimes ) || !isdefined( level.br_level.br_circleradii ) )
    {
        return;
    }
    
    multicirclecount = undefined;
    dangerents = [];
    safeents = [];
    circlecenters = [];
    
    if ( level.br_multi_circle_enabled )
    {
        multicirclecount = br_circle_util::function_7c3401c47d505872();
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            dangerents[ dangerents.size ] = level.br_multi_circle.circles[ i ].entdata.dangerent;
            safeents[ safeents.size ] = level.br_multi_circle.circles[ i ].entdata.safeent;
            circlecenters[ circlecenters.size ] = level.br_multi_circle.circles[ i ].circlecenters;
        }
    }
    else
    {
        multicirclecount = 1;
        dangerents[ 0 ] = level.br_circle.dangercircleent;
        safeents[ 0 ] = level.br_circle.safecircleent;
        circlecenters[ 0 ] = level.br_level.br_circlecenters;
    }
    
    if ( multicirclecount <= 0 )
    {
        return;
    }
    
    if ( dangerents.size == 0 || safeents.size == 0 )
    {
        return;
    }
    
    builtin [[ level.var_d87075686581c9fb ]]( multicirclecount, level.br_level.br_circleclosetimes.size, level.br_circle.circleindex, level.br_circle.circleinittime, level.br_level.br_movingcirclecount, level.circleclosing, level.br_level.staticcircle, dangerents, safeents, level.br_level.br_circleradii, level.br_level.br_circleclosetimes, circlecenters, level.br_level.br_circledelaytimes );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x76ef523f, Offset: 0x20d6
// Size: 0xbe
function private function_d47bf3eafe44dfdc( params )
{
    if ( !isdefined( self._blackboard ) )
    {
        return;
    }
    
    if ( !isbot( self ) && !isautopilot( self ) )
    {
        return;
    }
    
    var_e92d5eae409a92aa = "";
    selectedkillstreakavailable = 0;
    selectedkillstreak = killstreaks::getselectedkillstreak();
    
    if ( isdefined( selectedkillstreak ) )
    {
        var_e92d5eae409a92aa = selectedkillstreak.streakname;
        selectedkillstreakavailable = istrue( selectedkillstreak.available );
    }
    
    self._blackboard.var_f04e4feb1665635c = var_e92d5eae409a92aa;
    self._blackboard.var_7771b1827f422917 = var_e92d5eae409a92aa;
    self._blackboard.var_df360557262445bf = selectedkillstreakavailable;
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x24b6b6ac, Offset: 0x219c
// Size: 0x5e
function private function_dbd1c5a07146608f( params )
{
    if ( !isdefined( self._blackboard ) )
    {
        return;
    }
    
    if ( !isbot( self ) && !isautopilot( self ) )
    {
        return;
    }
    
    self._blackboard.var_2d29ae354139f801 = self.armor_upgrade.name ?? "none";
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x5168f966, Offset: 0x2202
// Size: 0x3c
function private function_30874da3f8b5254d()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    flags::gameflagwait( "graceperiod_done" );
    level.var_6a8e88d5a8429194.var_d267f8696fd736a0 = 1;
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x3b425551, Offset: 0x2246
// Size: 0x31
function private function_c1010d1df449549c()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_b9057e404291bae( level.outofboundstriggers );
        level waittill( #"oob_triggers_changed" );
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x6fc9838a, Offset: 0x227f
// Size: 0x3d
function private function_3a49debcd5f98521( params )
{
    if ( !isbot( self ) && !isautopilot( self ) )
    {
        return;
    }
    
    self._blackboard.laststandattacker = self.laststandattacker;
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0xe3cb07bb, Offset: 0x22c4
// Size: 0x33
function private function_4ed2f73e77a2b961( params )
{
    if ( !isbot( self ) && !isautopilot( self ) )
    {
        return;
    }
    
    self._blackboard.laststandattacker = undefined;
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0xe25044ee, Offset: 0x22ff
// Size: 0x14, Type: bool
function private function_b99b753a2ef95ce2()
{
    self endon( #"player_ishaywire" );
    return bots_gametype_br_super::function_b99b753a2ef95ce2();
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x55d373f, Offset: 0x231c
// Size: 0x11e
function private function_ec8ca478e05373ae()
{
    var_519d6543b491bfe6 = "br_bot_landing_group";
    var_e9384402dace4d8 = var_519d6543b491bfe6 + "_" + game_utility::getgametype();
    level.var_efdfeeff16492e8d = utility::getstructarray( var_e9384402dace4d8, "script_noteworthy" );
    
    if ( !isdefined( level.var_efdfeeff16492e8d ) || level.var_efdfeeff16492e8d.size == 0 )
    {
        logstring( "Landing spots: " + var_e9384402dace4d8 + " script_noteworthy not exists/contains no data, fallback to " + var_519d6543b491bfe6 );
        level.var_efdfeeff16492e8d = utility::getstructarray( var_519d6543b491bfe6, "script_noteworthy" );
    }
    
    foreach ( rawzone in level.var_efdfeeff16492e8d )
    {
        rawzone.landingspots = rawzone utility::get_target_array();
    }
    
    callback::callback( #"hash_685fc05b0ab7c1c5" );
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x7afe1f4b, Offset: 0x2442
// Size: 0xb1
function private function_600351883aa661ba()
{
    spots = [ ( 100, 100, -450 ), ( 2000, 2000, -450 ), ( 2000, -2000, -450 ), ( 0, -2000, -450 ), ( 0, 2000, -450 ), ( 3000, 3000, -450 ), ( -3000, -3000, -450 ), ( 3000, 0, -450 ), ( 0, 3000, -450 ) ];
    super_bot::function_7af21960125481f9( spots );
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x2a27f2c1, Offset: 0x24fb
// Size: 0x2c7
function private function_7d3d422411b707f0()
{
    rawzones = level.var_efdfeeff16492e8d;
    
    if ( rawzones.size == 0 && isdefined( level.landingspots ) && level.landingspots.size > 0 )
    {
        rawzones = level.landingspots;
    }
    
    if ( rawzones.size == 0 )
    {
        println( "<dev string:x130>" );
        function_600351883aa661ba();
        rawzones = level.landingspots;
    }
    
    zones = [];
    level.var_b7611ddaf43956e1.var_7befb8d60420cd1 = [];
    
    for ( index = 0; index < rawzones.size ; index++ )
    {
        rawzone = rawzones[ index ];
        zone = {};
        zone.name = rawzone.target;
        zone.centralpoint = rawzone.origin;
        zone.weight = int( rawzone.script_parameters );
        
        if ( zone.weight <= 0 )
        {
            assertmsg( "<dev string:x1d8>" + zone.name + "<dev string:x1f5>" );
            zone.weight = 0;
        }
        
        zone.landingspots = [];
        zones[ zones.size ] = zone;
        landingspots = rawzone.landingspots ?? [];
        landingspots[ landingspots.size ] = { #origin:rawzone.origin };
        
        foreach ( landingspot in landingspots )
        {
            struct = {};
            struct.origin = getclosestpointonnavmesh( landingspot.origin );
            zone.landingspots[ zone.landingspots.size ] = struct;
            
            if ( zone.weight > 0 && isdefined( struct.origin ) )
            {
                level.var_b7611ddaf43956e1.var_7befb8d60420cd1[ level.var_b7611ddaf43956e1.var_7befb8d60420cd1.size ] = struct.origin;
            }
        }
        
        function_c1ed0761d3bf0089( index, zone.name, zone.centralpoint, zone.weight, zone.landingspots );
    }
    
    level thread function_13602862e6227120( zones );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x253e388c, Offset: 0x27ca
// Size: 0x83
function private function_13602862e6227120( zones )
{
    level endon( #"game_ended" );
    function_d03879a5ca76106e( zones );
    
    if ( level.br_infils_disabled )
    {
        return;
    }
    
    while ( true )
    {
        result = level utility::waittill_any_in_array_return( [ "br_c130_in_bounds", "br_circle_started", "br_c130_left_bounds" ] );
        
        if ( result == "br_c130_left_bounds" )
        {
            function_d03879a5ca76106e( zones );
            return;
        }
        
        function_74651a600ebf9c26( zones );
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0xb9a202ba, Offset: 0x2855
// Size: 0x6a
function private function_d03879a5ca76106e( zones )
{
    sum = 0;
    
    for ( index = 0; index < zones.size ; index++ )
    {
        zone = zones[ index ];
        assert( isdefined( zone ) );
        sum += zone.weight;
        function_c886494f19d4e0f2( index, sum );
    }
    
    function_72d86fdb0a28da6( sum );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x907a585f, Offset: 0x28c7
// Size: 0x111
function private function_74651a600ebf9c26( zones )
{
    sumweight = 0;
    startpoint = level.infilstruct.c130pathstruct.startpt;
    endpoint = level.infilstruct.c130pathstruct.endpt;
    
    for ( index = 0; index < zones.size ; index++ )
    {
        zone = zones[ index ];
        weight = zone.weight;
        linetopoint = vectorfromlinetopoint( startpoint, endpoint, zone.centralpoint );
        distancesq = length2dsquared( linetopoint );
        
        if ( distancesq <= 6.25e+08 )
        {
            weight *= 100;
        }
        
        if ( function_9a45f3dc900c5a6d( zone.centralpoint ) )
        {
            weight *= 100;
        }
        
        sumweight += weight;
        function_c886494f19d4e0f2( index, sumweight );
    }
    
    function_72d86fdb0a28da6( sumweight );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x60ecc556, Offset: 0x29e0
// Size: 0x2d
function private function_9a45f3dc900c5a6d( point )
{
    if ( level.circleclosing )
    {
        return function_d11b162a8828a042( point );
    }
    
    return function_b98dbd08bf502830( point );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x9facbcdf, Offset: 0x2a15
// Size: 0x2d
function private function_d11b162a8828a042( point )
{
    if ( level.br_multi_circle_enabled )
    {
        return br_circle_util::function_7dba95e6f0e08799( point );
    }
    
    return ispointincurrentsafecircle( point );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x38f1f706, Offset: 0x2a4a
// Size: 0x38
function private ispointincurrentsafecircle( point )
{
    circleorigin = br_circle::getsafecircleorigin();
    circleradius = br_circle::getsafecircleradius();
    return utility::ispointinsidecircle( point, circleorigin, circleradius );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0xb8650cf9, Offset: 0x2a8b
// Size: 0x2d
function private function_b98dbd08bf502830( point )
{
    if ( level.br_multi_circle_enabled )
    {
        return br_circle_util::ispointinmulticircledanger( point );
    }
    
    return br_circle::function_52d62d96409e20b( point );
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x96e7469d, Offset: 0x2ac0
// Size: 0x12a
function private function_634314ee126ca0ef()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.5;
        
        foreach ( station in level.var_b7611ddaf43956e1.var_8a8eeef162319d29 )
        {
            valid = function_b9ce19f7dec0b156( station );
            activity = station.activity;
            team = activity.captureactivity.player.team ?? "none";
            captureradius = activity.captureactivity.var_332f929de1894b2b.captureradius ?? 0;
            function_f30bb323e67c58a5( station, valid, team, int( captureradius ) );
        }
    }
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0xf80cd8e2, Offset: 0x2bf2
// Size: 0x6c, Type: bool
function private function_b9ce19f7dec0b156( station )
{
    activity = station.activity;
    
    if ( !isdefined( activity ) || activity.oncooldown || activity_instance_common::getactivitystate( activity ) != "Active" )
    {
        return false;
    }
    
    if ( isdefined( activity.captureactivity ) )
    {
        return true;
    }
    
    return activity.numcharges > 0;
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x9b501fed, Offset: 0x2c67
// Size: 0x4d
function private function_56c01a3bdc03ff0c( params )
{
    station = params.station;
    
    if ( !isdefined( station ) )
    {
        return;
    }
    
    level.var_b7611ddaf43956e1.var_8a8eeef162319d29[ station.index ] = station;
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0xcf1bebe7, Offset: 0x2cbc
// Size: 0x58
function private function_3a68145ed6f39043( params )
{
    station = params.station;
    
    if ( !isdefined( station ) )
    {
        return;
    }
    
    level.var_b7611ddaf43956e1.var_8a8eeef162319d29[ station.index ] = undefined;
    function_f30bb323e67c58a5( station, 0, "none", 0 );
}

// Namespace bt_bot_br
// Params 1, eflags: 0x4
// Checksum 0x11f50b31, Offset: 0x2d1c
// Size: 0x35
function private function_2336a5380efc65b6( params )
{
    if ( !isdefined( self._blackboard ) )
    {
        return;
    }
    
    self._blackboard.var_dc717925d3fb5781 = function_5d99ea95e11f6a23();
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x9cd25264, Offset: 0x2d59
// Size: 0x98, Type: bool
function private function_5d99ea95e11f6a23()
{
    foreach ( bubbleshield in self.var_ae2956efdf721fbe )
    {
        if ( bubbleshield.connectedplayer.team == self.team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bt_bot_br
// Params 0, eflags: 0x4
// Checksum 0x4a3eb259, Offset: 0x2dfa
// Size: 0x6f
function private function_a7ff14f023189abc()
{
    level.var_b7611ddaf43956e1.var_2646facf78fe3e9d = level.gametypebundle.var_fd3a1a6b45be175c[ #"hash_fc3e08496426bcba" ].var_2646facf78fe3e9d ?? 0;
    
    if ( !level.var_b7611ddaf43956e1.var_2646facf78fe3e9d )
    {
        return;
    }
    
    level callback::add( #"on_squad_eliminated", &manager::onteameliminated );
}

