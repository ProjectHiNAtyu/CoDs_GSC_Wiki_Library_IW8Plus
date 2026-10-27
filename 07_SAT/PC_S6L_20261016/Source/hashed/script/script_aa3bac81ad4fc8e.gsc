// script_aa3bac81ad4fc8e  (hash_0aa3bac81ad4fc8e.gscc) (size: 41623 Bytes / 0xa297 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd5ec447 (3445539911)
// size ...... 41623 (0xa297)
// includes .. 18  (offset: 0x992b)
// strings ... 99  (offset: 0x99bb)
// dev strs .. 59  (offset: 0x9f5b)
// exports ... 132 (offset: 0x66cf)
// cseg ...... 0x9d9 + 0x5cf6 (0x66cf)
// imports ... 237 (offset: 0x7b6f)
// animtree1 . 0   (offset: 0xa297)
// animtree2 . 0   (offset: 0xa297)
#using scripts\anim\utility;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;

#namespace bgb;

// Namespace bgb
// Params 0, eflags: 0x5
// Checksum 0x515790d2, Offset: 0x9f7
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"bgb", undefined, &__init__, &__main__ );
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x4db39f0d, Offset: 0xa1c
// Size: 0x151
function private __init__()
{
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
    
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "on_round_end", &on_round_end );
    callback::add( "zm_exfil_success", &on_exfil_end );
    callback::add( "on_exfil_complete_timeout", &on_exfil_end );
    callback::add( #"hash_66c054d5a487b8bf", &on_gobblegum_changed );
    level._effect[ "bgb_bubble_blow" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_bubble_blow_zmb" );
    level.bgb = [];
    level.var_60ef36d37839ce06 = [];
    init_gobblegums();
    laststand::register_revive_reason( "last_stand_bgb", 0, 0 );
    utility::registersharedfunc( #"bgb", #"hash_115aa98d3b2427aa", &function_818710eb09fefc5b );
    utility::registersharedfunc( #"bgb", #"hash_906f42b697e67e35", &function_72e29aa5298bfe16 );
    utility::registersharedfunc( #"bgb", #"hash_e47d9b7a1bc28040", &function_3f4197e347068219 );
    utility::registersharedfunc( #"bgb", #"is_enabled", &is_enabled );
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x71eee481, Offset: 0xb75
// Size: 0x2c
function private __main__()
{
    if ( getdvarint( @"hash_294f374ff45e6632" ) || getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return;
    }
    
    function_9ace8dcf9a05142c();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xe0916f4b, Offset: 0xba9
// Size: 0x177
function private init_gobblegums()
{
    level.gobblegums = [];
    gobblegumlist = level.gametypebundle.gobblegumlist ?? level.gamemodebundle.gobblegumlist ?? level.projectbundle.gobblegumlist;
    
    if ( isdefined( gobblegumlist ) )
    {
        var_f7205f1247721cd9 = getscriptbundle( gobblegumlist );
        
        foreach ( gumasset in var_f7205f1247721cd9.gobblegums )
        {
            if ( isdefined( gumasset.gobblegum ) )
            {
                bundle = getscriptbundle( gumasset.gobblegum );
                gumdata = bundle;
                gumdata.index = function_43b5ed5a14a56573( #"scriptbundle_gobblegum", gumasset.gobblegum );
                level.gobblegums[ bundle.ref ] = gumdata;
            }
        }
    }
    
    level.var_d530db481b62eed2 = level.gobblegums[ #"empty" ].index ?? 0;
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x27728687, Offset: 0xd28
// Size: 0x39
function private on_player_connect( params )
{
    function_c9f648e2e5e129c2();
    thread function_711d178811abe36c();
    thread function_a9baee584ca65cf3();
    thread function_54437483c30aecc9();
    thread init_gobblegum_amount();
    
    /#
        thread setup_devgui();
    #/
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x33577a9a, Offset: 0xd69
// Size: 0x7c
function private on_player_spawned( params )
{
    self.var_a0b1f41aaeb1ce10 = undefined;
    var_fcccc3d2a616b1c7 = 0;
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_e1eecff22a023276" ) )
    {
        var_fcccc3d2a616b1c7 = utility::callsharedfunc( #"zombie", #"hash_e1eecff22a023276" );
    }
    
    if ( var_fcccc3d2a616b1c7 )
    {
        callback::add( #"hash_79b197636e7199f", &function_2c6edf42c0de1e95 );
        return;
    }
    
    thread function_11ccc1392899956b();
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x550c6e61, Offset: 0xded
// Size: 0x1ea
function private function_711d178811abe36c()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "begin_round_logic" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, value );
        println( "<dev string:x24>" + value );
        
        switch ( channel )
        {
            case #"hash_e5e9edbf93074d95":
                value = int( clamp( value, 1, 3 ) );
                
                if ( is_slot_loaded( value ) )
                {
                    if ( self.var_f1dccd054c74a27e[ value ] || !function_f88abb570e486ee7( self.var_b02f6e7abbbc8a84[ value ], value, 1 ) || is_enabled( self.var_b02f6e7abbbc8a84[ value ] ) )
                    {
                        self playlocalsound( #"hash_d8d9c4eb514390a7" );
                        continue;
                    }
                    
                    thread use_action_slot( value );
                }
                
                break;
            case #"hash_cfd489dbc870e8c6":
                value = int( clamp( value, 1, 3 ) );
                var_f654f27feebfbaa5 = getdvarint( @"hash_8f346cd186641d5", 1 );
                
                if ( is_slot_loaded( value ) && var_f654f27feebfbaa5 )
                {
                    if ( self.var_f1dccd054c74a27e[ value ] || !function_59449da4704f08db( self.var_b02f6e7abbbc8a84[ value ], value ) || is_enabled( self.var_b02f6e7abbbc8a84[ value ] ) )
                    {
                        self playlocalsound( #"hash_d8d9c4eb514390a7" );
                        continue;
                    }
                    
                    println( "<dev string:x3e>" + value );
                    
                    if ( utility::issharedfuncdefined( #"bgb", #"convert_gobblegum" ) )
                    {
                        self.var_5784e9f8a9abbabf[ value ] = 1;
                        utility::callsharedfunc( #"bgb", #"convert_gobblegum", value );
                        self.var_5784e9f8a9abbabf[ value ] = 0;
                    }
                }
                
                break;
        }
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x8ab1a0d1, Offset: 0xfdf
// Size: 0x6d
function private function_a9baee584ca65cf3()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level utility::flag_wait( "begin_round_logic" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, value );
        
        if ( channel == "gobblegum_converted" )
        {
            println( "<dev string:x3e>" + value );
        }
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x5f858da, Offset: 0x1054
// Size: 0x95
function private function_54437483c30aecc9()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, value );
        
        if ( channel == "gobblegum_selected_pack_in_game" )
        {
            var_ad51538d36de61f4 = value;
            params = { #var_ad51538d36de61f4:var_ad51538d36de61f4 };
            callback::callback( "gobblegum_selected_pack_changed", params );
            
            if ( level.onlinegame )
            {
                function_315a16e087454c6f( var_ad51538d36de61f4 );
            }
        }
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x573ced2f, Offset: 0x10f1
// Size: 0x7c
function private function_818710eb09fefc5b()
{
    if ( isdefined( level.var_8e3d9df005542454 ) )
    {
        return self [[ level.var_8e3d9df005542454 ]]();
    }
    
    var_de48a70a55b51b66 = [ #"", #"", #"", #"", #"" ];
    
    if ( self hasplayerdata() )
    {
        return function_72e29aa5298bfe16( 0 );
    }
    
    return var_de48a70a55b51b66;
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x54b6ae15, Offset: 0x1176
// Size: 0xa8
function private function_72e29aa5298bfe16( index )
{
    if ( isdefined( level.var_62bb99225010cdf3 ) )
    {
        return self [[ level.var_62bb99225010cdf3 ]]( index );
    }
    
    var_37dc0376726efd20 = [];
    
    for ( gumindex = 0; gumindex < 5 ; gumindex++ )
    {
        gumlootid = self getplayerdata( level.loadoutsgroup, "equippedPack", "gumLootIDs", gumindex );
        gumref = loot::function_f54ecb89dfab8e8c( gumlootid );
        
        if ( isdefined( gumref ) )
        {
            var_37dc0376726efd20[ gumindex ] = getxhash( gumref );
            continue;
        }
        
        var_37dc0376726efd20[ gumindex ] = #"";
    }
    
    return var_37dc0376726efd20;
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xa9619e50, Offset: 0x1227
// Size: 0x112
function private function_40685d3eedc7c99a()
{
    self endon( #"disconnect" );
    
    if ( self.pers[ #"hash_2d068f36cafc5193" ] )
    {
        return;
    }
    else
    {
        self.pers[ #"hash_2d068f36cafc5193" ] = 1;
    }
    
    var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
    n_count = 0;
    var_f23ff753f2a97d28 = getdvarint( @"hash_92e178598a3de1c", 128 );
    
    for ( milestone_index = 0; milestone_index < var_f23ff753f2a97d28 ; milestone_index++ )
    {
        self setplayerdata( var_6f9b00680ed002d8, "milestoneAcquiredGums", milestone_index, "milestoneDifferentGumsAmount", 0 );
        
        for ( gum_index = 0; gum_index < 6 ; gum_index++ )
        {
            self setplayerdata( var_6f9b00680ed002d8, "milestoneAcquiredGums", milestone_index, "milestoneAcquiredGumsData", gum_index, "lootID", 0 );
            self setplayerdata( var_6f9b00680ed002d8, "milestoneAcquiredGums", milestone_index, "milestoneAcquiredGumsData", gum_index, "amount", 0 );
        }
        
        if ( n_count >= 3 )
        {
            n_count = 0;
            waitframe();
        }
        
        n_count++;
    }
    
    self setplayerdata( var_6f9b00680ed002d8, "gobblegumMilestoneReached", 0 );
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xc21a74df, Offset: 0x1341
// Size: 0x5d8
function private function_c9f648e2e5e129c2()
{
    self endon( #"disconnect" );
    
    if ( isdefined( self.var_cde87e02d2e3970f ) )
    {
        return;
    }
    
    self.bgb = "none";
    self.var_71280c614e54bce2 = 0;
    self.var_94750b503029583c = 1;
    self.var_cde87e02d2e3970f = [];
    self.var_f1dccd054c74a27e = [];
    self.var_5784e9f8a9abbabf = [];
    
    for ( x = 1; x <= 3 ; x++ )
    {
        self.var_f1dccd054c74a27e[ x ] = 0;
        self.var_5784e9f8a9abbabf[ x ] = 0;
    }
    
    var_37dc0376726efd20 = function_818710eb09fefc5b();
    var_84fc1f816ce3d604 = [];
    keys = getarraykeys( level.bgb );
    
    foreach ( bgb in var_37dc0376726efd20 )
    {
        foreach ( var_66cc4d3d21a0ce0d in keys )
        {
            if ( getxhash( var_66cc4d3d21a0ce0d ) === bgb && !level.bgb[ var_66cc4d3d21a0ce0d ].banned )
            {
                var_84fc1f816ce3d604[ var_84fc1f816ce3d604.size ] = var_66cc4d3d21a0ce0d;
            }
        }
    }
    
    var_b997400033c51296 = [];
    keys = getarraykeys( level.bgb );
    
    if ( !level.onlinegame )
    {
        var_b997400033c51296 = utility::array_random_slice( keys, 5 );
    }
    else
    {
        var_37dc0376726efd20 = arrayrandomize( var_37dc0376726efd20 );
        keys = getarraykeys( level.bgb );
        
        foreach ( bgb in var_37dc0376726efd20 )
        {
            foreach ( var_66cc4d3d21a0ce0d in keys )
            {
                if ( getxhash( var_66cc4d3d21a0ce0d ) === bgb && !level.bgb[ var_66cc4d3d21a0ce0d ].banned )
                {
                    var_b997400033c51296[ var_b997400033c51296.size ] = var_66cc4d3d21a0ce0d;
                }
            }
        }
    }
    
    var_ea92f88903bc485 = 0;
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_8b52dcc4e869e5e5" ) )
    {
        var_ea92f88903bc485 = utility::callsharedfunc( #"zombie", #"hash_8b52dcc4e869e5e5" );
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_c2f3b4bd5b181dd0" ) )
    {
        var_ea92f88903bc485 |= utility::callsharedfunc( #"zombie", #"hash_c2f3b4bd5b181dd0" );
    }
    
    if ( isdefined( level.bgb_pack_override ) )
    {
        var_b997400033c51296 = level.bgb_pack_override;
        var_84fc1f816ce3d604 = level.bgb_pack_override;
    }
    
    if ( getdvarint( @"hash_a7dd6191064a0709", 1 ) && !var_ea92f88903bc485 && level.onlinegame )
    {
        self.var_cde87e02d2e3970f = var_84fc1f816ce3d604;
    }
    else
    {
        self.var_cde87e02d2e3970f = var_b997400033c51296;
    }
    
    self.var_3435b1427f82ce41 = [];
    self.var_b02f6e7abbbc8a84 = [];
    self.bgb_enabled = [];
    self.var_48081f882523254d = [];
    
    foreach ( bgb in keys )
    {
        if ( bgb == "weapon_null" )
        {
            continue;
        }
        
        if ( !level.bgb[ bgb ].consumable )
        {
            continue;
        }
        
        self.var_48081f882523254d[ bgb ] = spawnstruct();
        self.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08 = get_gum_count( bgb );
        
        if ( !level.onlinegame )
        {
            self.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08 = randomintrange( 0, 5 );
        }
        
        if ( isdefined( level.var_cf8d14596f3d42d6 ) )
        {
            self.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08 = level.var_cf8d14596f3d42d6;
        }
        
        self.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b = 0;
    }
    
    thread function_40685d3eedc7c99a();
    self.var_71280c614e54bce2 = 0;
    function_716ca22c40cfb70f();
    
    for ( i = 1; i <= 3 ; i++ )
    {
        clear_action_slot( i );
    }
    
    thread function_e1263310b13f9536();
    thread function_5eaa69d9f11fab2e();
    thread function_3c3187481b92e6ab();
    
    if ( getdvarint( @"hash_a7dd6191064a0709", 1 ) && !var_ea92f88903bc485 )
    {
        for ( x = 0; x < 3 ; x++ )
        {
            if ( self.var_48081f882523254d[ self.var_cde87e02d2e3970f[ x ] ].var_842e3f6ee3ebdb08 )
            {
                function_c068e36660508e7c( self.var_cde87e02d2e3970f[ x ] );
            }
        }
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x17a3abd6, Offset: 0x1921
// Size: 0xfb
function private function_9e1a713b9554d08a( bgb_str_array )
{
    for ( i = 1; i <= 3 ; i++ )
    {
        clear_action_slot( i );
    }
    
    action_pack_index = 3;
    
    for ( x = 0; x < 3 ; x++ )
    {
        var_66cc4d3d21a0ce0d = bgb_str_array[ x ];
        
        if ( !isdefined( var_66cc4d3d21a0ce0d ) || !function_e2d5ed5687ea5bc2( var_66cc4d3d21a0ce0d ) )
        {
            continue;
        }
        
        self.var_b02f6e7abbbc8a84[ action_pack_index ] = var_66cc4d3d21a0ce0d;
        var_c2afe1a671205584 = getxhash( var_66cc4d3d21a0ce0d );
        index = level.gobblegums[ var_c2afe1a671205584 ].index;
        
        if ( !isdefined( index ) )
        {
            self.var_b02f6e7abbbc8a84[ action_pack_index ] = undefined;
            continue;
        }
        
        self setclientomnvar( get_ui_slot_name( action_pack_index ), index );
        self setclientomnvar( "ui_focused_gobblegum_slot_index", action_pack_index );
        action_pack_index -= 1;
        
        if ( action_pack_index == 0 )
        {
            return;
        }
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x7b3f1907, Offset: 0x1a24
// Size: 0x19c
function private function_315a16e087454c6f( var_ad51538d36de61f4 )
{
    bgbarray = function_72e29aa5298bfe16( var_ad51538d36de61f4 );
    var_7772181955d357a5 = [];
    keys = getarraykeys( level.bgb );
    
    foreach ( bgb in bgbarray )
    {
        foreach ( var_66cc4d3d21a0ce0d in keys )
        {
            if ( getxhash( var_66cc4d3d21a0ce0d ) === bgb && !level.bgb[ var_66cc4d3d21a0ce0d ].banned )
            {
                var_7772181955d357a5[ var_7772181955d357a5.size ] = var_66cc4d3d21a0ce0d;
            }
        }
    }
    
    self.var_cde87e02d2e3970f = arrayrandomize( var_7772181955d357a5 );
    self.var_3435b1427f82ce41 = [];
    
    if ( self.var_94750b503029583c && !arraycontains( self.var_f1dccd054c74a27e ?? [], 1 ) && !arraycontains( self.var_5784e9f8a9abbabf ?? [], 1 ) )
    {
        function_9e1a713b9554d08a( var_7772181955d357a5 );
    }
}

// Namespace bgb
// Params 1
// Checksum 0x1fcf3120, Offset: 0x1bc8
// Size: 0x28
function function_2c6edf42c0de1e95( params )
{
    thread function_11ccc1392899956b();
    callback::remove( #"hash_79b197636e7199f", &function_2c6edf42c0de1e95 );
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x28a7646f, Offset: 0x1bf8
// Size: 0xc6
function private function_11ccc1392899956b()
{
    level endon( #"game_ended" );
    self endon( #"disconnect", #"hash_3dad25c07d2f05d4" );
    
    if ( !self.var_94750b503029583c )
    {
        return;
    }
    
    telemetry = self.pers[ "telemetry" ];
    var_ab8b6e740ffdd457 = 0;
    reload_flag = isdefined( telemetry.var_efd960f3c3cf6f19 );
    
    if ( reload_flag )
    {
        saveddata = telemetry.var_efd960f3c3cf6f19;
        var_ab8b6e740ffdd457 = saveddata.prev_time_played ?? 0;
    }
    
    remaining_countdown_time = 180 - var_ab8b6e740ffdd457;
    
    if ( remaining_countdown_time < 0 )
    {
        self.var_94750b503029583c = 0;
        return;
    }
    
    wait remaining_countdown_time;
    self.var_94750b503029583c = 0;
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x805ad474, Offset: 0x1cc6
// Size: 0xfc
function private function_5eaa69d9f11fab2e()
{
    self endon( #"disconnect" );
    
    if ( !level utility::flag_exist( "consumables_reported" ) )
    {
        level utility::flag_init( "consumables_reported" );
    }
    
    utility::ent_flag_init( "finished_reporting_consumables" );
    self waittill( #"report_bgb_consumption" );
    
    foreach ( bgb in self.var_cde87e02d2e3970f )
    {
        if ( !isdefined( self.var_48081f882523254d[ bgb ] ) || !self.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b )
        {
            continue;
        }
        
        level utility::flag_set( "consumables_reported" );
    }
    
    utility::ent_flag_set( "finished_reporting_consumables" );
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xd5599dc1, Offset: 0x1dca
// Size: 0x1fb
function private function_9ace8dcf9a05142c()
{
    bgb_list = getscriptbundle( "gobblegumlist:" + "cer_gobblegums" );
    test = getscriptbundle( "gobblegum:" + "kill_joy" );
    keys = getarraykeys( level.bgb );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        bundle = getscriptbundle( "gobblegum:" + keys[ i ] );
        level.bgb[ keys[ i ] ].rarity = bundle.rarity;
        level.bgb[ keys[ i ] ].consumable = 1;
        level.bgb[ keys[ i ] ].banned = 0;
        level.bgb[ keys[ i ] ].a_banned = bundle.var_97d2ae71a2f702e5;
        level.bgb[ keys[ i ] ].hint = bundle.machineprompt;
        level.bgb[ keys[ i ] ].hint_oos = bundle.var_163fa699d13ea8c;
        
        foreach ( var_ba39b89925cb2697 in level.bgb[ keys[ i ] ].a_banned )
        {
            if ( game_utility::getgametype() == var_ba39b89925cb2697.var_cfce22d4b21b82be )
            {
                level.bgb[ keys[ i ] ].banned = 1;
                level.var_85c21b354abbcadd = 1;
            }
        }
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xeef44817, Offset: 0x1fcd
// Size: 0x76
function private function_e1263310b13f9536()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        str_return = level utility::waittill_any_return( "bgb_round_end", "restart_round" );
        
        if ( isdefined( level.zm_bgb_player_monitor_validation ) )
        {
            if ( !self [[ level.zm_bgb_player_monitor_validation ]]() )
            {
                continue;
            }
        }
        
        if ( !level.var_10c8ad612d031d9 )
        {
            self notify( #"hash_ebc09e8558d2c7d7" );
        }
        
        self.var_71280c614e54bce2 = 0;
    }
}

// Namespace bgb
// Params 1
// Checksum 0xf8eb145f, Offset: 0x204b
// Size: 0x88
function function_701b66d2240de5a4( count = 1 )
{
    if ( count > 3 )
    {
        assertmsg( "<dev string:x64>" + count );
        return;
    }
    
    aeeventname = #"zm_grant_whimsical";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = count;
    
    if ( isdefined( aeeventid ) )
    {
        self function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

/#

    // Namespace bgb
    // Params 0, eflags: 0x4
    // Checksum 0xc9e51b7e, Offset: 0x20db
    // Size: 0x188, Type: dev
    function private setup_devgui()
    {
        self endon( #"disconnect" );
        wait 2;
        var_39702b88f0f04345 = 6;
        
        if ( !isdefined( level.var_d314737a0d08ce04 ) )
        {
            level.var_d314737a0d08ce04 = 0;
        }
        
        if ( level.var_d314737a0d08ce04 > var_39702b88f0f04345 )
        {
            return;
        }
        
        level.var_d314737a0d08ce04 += 1;
        var_45f07a83b517548 = "<dev string:xba>";
        str_player_name = self.name;
        keys = getarraykeys( level.bgb );
        
        foreach ( key in keys )
        {
            devgui::function_9082edeb5db93280( "<dev string:xcf>" + str_player_name + "<dev string:xd7>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:xd9>" + key, "<dev string:xec>" + key + "<dev string:x101>" + str_player_name, &function_616c10efe98ee629 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x103>" + key, "<dev string:x116>" + key + "<dev string:x101>" + str_player_name, &function_18b849efb434e8a3 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x12b>" + key, "<dev string:x13e>" + key + "<dev string:x101>" + str_player_name, &function_2b87f7d8d7531279 );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace bgb
    // Params 0, eflags: 0x4
    // Checksum 0xb983404f, Offset: 0x226b
    // Size: 0x48, Type: dev
    function private function_75b9b8979367760b()
    {
        for ( ;; )
        {
            var_4129b526397c5f18 = getdvar( @"hash_96487b6d70903c69" );
            
            if ( var_4129b526397c5f18 )
            {
                function_9d420d811c62ca43( var_4129b526397c5f18 );
            }
            
            setdvar( @"hash_96487b6d70903c69", "<dev string:x155>" );
            wait 0.5;
        }
    }

    // Namespace bgb
    // Params 1, eflags: 0x4
    // Checksum 0xeeb63e4a, Offset: 0x22bb
    // Size: 0x8d, Type: dev
    function private function_9d420d811c62ca43( var_857d41afdbb921d5 )
    {
        playerid = getdvarint( @"hash_de99de3ccd19b3fe" );
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( playerid != -1 && playerid != i )
            {
                continue;
            }
            
            if ( "<dev string:x156>" == var_857d41afdbb921d5 )
            {
                players[ i ] thread take();
                continue;
            }
            
            players[ i ] thread function_a5d37b16547199e4( var_857d41afdbb921d5, 0 );
        }
    }

#/

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0xdafe8d11, Offset: 0x2350
// Size: 0x125
function private function_3c3187481b92e6ab()
{
    /#
        self.var_e31fa44d3f590f81 = newclienthudelem( self );
        self.var_e31fa44d3f590f81.elemtype = "<dev string:x15b>";
        self.var_e31fa44d3f590f81.font = "<dev string:x160>";
        self.var_e31fa44d3f590f81.fontscale = 1.8;
        self.var_e31fa44d3f590f81.horzalign = "<dev string:x16a>";
        self.var_e31fa44d3f590f81.vertalign = "<dev string:x171>";
        self.var_e31fa44d3f590f81.alignx = "<dev string:x16a>";
        self.var_e31fa44d3f590f81.aligny = "<dev string:x171>";
        self.var_e31fa44d3f590f81.sort = 2;
        self.var_e31fa44d3f590f81.color = ( 1, 1, 1 );
        self.var_e31fa44d3f590f81.alpha = 1;
        self.var_e31fa44d3f590f81.hidewheninmenu = 1;
    #/
}

// Namespace bgb
// Params 2, eflags: 0xc
// Checksum 0xf3c16a42, Offset: 0x247d
// Size: 0x3f
function private function_1cbb7c4779626c18( name, var_b25d6408b605808 )
{
    self notify( #"hash_285c6946aaccd8ec" );
    self endon( #"hash_285c6946aaccd8ec" );
}

/#

    // Namespace bgb
    // Params 1
    // Checksum 0x4c875d80, Offset: 0x2594
    // Size: 0x3d, Type: dev
    function debug_give_bgb( a_params )
    {
        var_66cc4d3d21a0ce0d = a_params[ 0 ];
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        player function_a5d37b16547199e4( var_66cc4d3d21a0ce0d, 0 );
    }

    // Namespace bgb
    // Params 1
    // Checksum 0x91c874c6, Offset: 0x25d9
    // Size: 0xb2, Type: dev
    function function_8befd331d0a539e0( a_params )
    {
        var_e97a4f4962bc3f25 = int( a_params[ 0 ] );
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        
        if ( isdefined( player.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ] ) )
        {
            iprintlnbold( "<dev string:x1ac>" + getxhashsourcename( player.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ] ) + "<dev string:x1b3>" + var_e97a4f4962bc3f25 + "<dev string:x1c4>" + player.name );
            player use_action_slot( var_e97a4f4962bc3f25 );
            return;
        }
        
        iprintlnbold( "<dev string:x1ca>" + var_e97a4f4962bc3f25 + "<dev string:x1c4>" + player.name + "<dev string:x1db>" );
    }

    // Namespace bgb
    // Params 1
    // Checksum 0xbfaf615a, Offset: 0x2693
    // Size: 0x43, Type: dev
    function function_616c10efe98ee629( a_params )
    {
        var_66cc4d3d21a0ce0d = a_params[ 0 ];
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        player set_action_slot( 1, var_66cc4d3d21a0ce0d, 1, 1 );
    }

    // Namespace bgb
    // Params 1
    // Checksum 0xd4096dce, Offset: 0x26de
    // Size: 0x43, Type: dev
    function function_18b849efb434e8a3( a_params )
    {
        var_66cc4d3d21a0ce0d = a_params[ 0 ];
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        player set_action_slot( 2, var_66cc4d3d21a0ce0d, 1, 1 );
    }

    // Namespace bgb
    // Params 1
    // Checksum 0x63ce92c4, Offset: 0x2729
    // Size: 0x43, Type: dev
    function function_2b87f7d8d7531279( a_params )
    {
        var_66cc4d3d21a0ce0d = a_params[ 0 ];
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        player set_action_slot( 3, var_66cc4d3d21a0ce0d, 1, 1 );
    }

    // Namespace bgb
    // Params 1
    // Checksum 0x3f74724c, Offset: 0x2774
    // Size: 0x93, Type: dev
    function function_fdfae7e5048bf698( str_name )
    {
        foreach ( player in level.players )
        {
            if ( player.name == str_name )
            {
                return player;
            }
        }
    }

    // Namespace bgb
    // Params 1
    // Checksum 0xf81a6b23, Offset: 0x280f
    // Size: 0xa0, Type: dev
    function function_97d3d4488aa16e89( bgb )
    {
        println( bgb + "<dev string:x1ee>" + self.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08 );
        println( bgb + "<dev string:x208>" + self.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b );
        var_5416af710ee23d6c = self.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08 - self.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b;
        println( bgb + "<dev string:x21d>" + var_5416af710ee23d6c );
    }

#/

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0xbc565d9a, Offset: 0x28b7
// Size: 0x40
function private function_b112ae0371a28800( bgb )
{
    if ( !isdefined( self.var_48081f882523254d[ bgb ] ) || !level.bgb[ bgb ].consumable )
    {
        return 0;
    }
    
    return 1;
}

// Namespace bgb
// Params 3
// Checksum 0xebcd355e, Offset: 0x28ff
// Size: 0x2b6
function function_4818e19472b65502( bgb, var_e97a4f4962bc3f25, in_params )
{
    if ( !function_b112ae0371a28800( bgb ) )
    {
        return;
    }
    
    if ( isdefined( level.bgb[ bgb ].consumption_override_func ) && ![[ level.bgb[ bgb ].consumption_override_func ]]() )
    {
        return;
    }
    
    self.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b++;
    utility::ent_flag_set( "used_consumable" );
    
    if ( level utility::flag_exist( "first_consumables_used" ) )
    {
        level utility::flag_set( "first_consumables_used" );
    }
    
    xuid = function_fffbd405b1911268( self getxuid() );
    level.var_60ef36d37839ce06[ xuid ][ bgb ] = undefined;
    gametype = challenges::function_9edd00e9e48c0821();
    gamemode = challenges::getchallengegamemode();
    var_c2afe1a671205584 = getxhash( bgb );
    index = level.gobblegums[ var_c2afe1a671205584 ].index;
    rarity = level.gobblegums[ var_c2afe1a671205584 ].rarity;
    aeeventname = #"zm_gobblegum_activated";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    rarity_number = get_bgb_rarity( rarity );
    lootid = loot::getlootidfromref( bgb );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = var_e97a4f4962bc3f25;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_rarity" ) ] = rarity_number;
    var_3776f7611c433549 = function_34fe46bbb524c496( bgb );
    
    if ( isdefined( aeeventid ) && var_3776f7611c433549 )
    {
        self function_2e45314624fdfdb8( aeeventid, eventparams );
    }
    
    var_46993e9f6a989d94 = in_params.var_46993e9f6a989d94;
    params = { #var_46993e9f6a989d94:var_46993e9f6a989d94, #rarity:rarity, #name:bgb };
    callback::callback( "on_gobblegum_consumed", params );
    params.event = #"zm_on_gobblegum_consumed";
    callback::callback( #"hash_6c71d319dc089c27", params );
    
    /#
        function_97d3d4488aa16e89( bgb );
    #/
}

// Namespace bgb
// Params 1
// Checksum 0xea2fb5ea, Offset: 0x2bbd
// Size: 0x4c, Type: bool
function function_34fe46bbb524c496( bgb )
{
    if ( getdvarint( @"hash_6e123915112954c", 0 ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_4317de3baf10e68d ) && self.var_4317de3baf10e68d[ 0 ] === bgb )
    {
        self.var_4317de3baf10e68d = undefined;
        return false;
    }
    
    return true;
}

// Namespace bgb
// Params 1
// Checksum 0xaf6b20e0, Offset: 0x2c12
// Size: 0x98, Type: bool
function function_e2d5ed5687ea5bc2( bgb )
{
    if ( !isdefined( bgb ) )
    {
        return false;
    }
    
    if ( !isdefined( self.var_48081f882523254d[ bgb ] ) || !level.bgb[ bgb ].consumable )
    {
        return true;
    }
    
    var_1a5ca312de3c35df = self.var_48081f882523254d[ bgb ].var_842e3f6ee3ebdb08;
    var_8746e07bf52b6830 = self.var_48081f882523254d[ bgb ].var_d2ccdc3b4353d23b;
    var_a69066f372ada233 = var_1a5ca312de3c35df - var_8746e07bf52b6830;
    return 0 < var_a69066f372ada233;
}

// Namespace bgb
// Params 3, eflags: 0x4
// Checksum 0xee0c148, Offset: 0x2cb3
// Size: 0x7b
function private function_d4d79c2a7099a82d( bgb, activating, var_e97a4f4962bc3f25 )
{
    if ( !level.bgb[ bgb ].var_f201d6c52dcc7908 )
    {
        return;
    }
    
    val::set( "bgb", "damage", 0 );
    utility::waittill_any_timeout( 2.5, "bgb_bubble_blow_complete" + var_e97a4f4962bc3f25 );
    wait 0.6;
    
    if ( isdefined( self ) )
    {
        val::reset( "bgb", "damage" );
    }
}

// Namespace bgb
// Params 3
// Checksum 0x1bda7880, Offset: 0x2d36
// Size: 0x204
function function_a5d37b16547199e4( bgb, activating, var_e97a4f4962bc3f25 )
{
    self endon( #"disconnect" );
    level endon( #"end_game" );
    
    if ( activating )
    {
        thread function_d4d79c2a7099a82d( bgb, activating, var_e97a4f4962bc3f25 );
        self.var_44c8fd4fb28eb652 = bgb;
    }
    
    while ( self isswitchingweapon() )
    {
        waitframe();
    }
    
    thread function_d527e80e3a3527e9( bgb, activating );
    evt = utility::waittill_any_timeout( 3, "death", "last_stand_enter", "gesture_stopped", "disconnect", "weapon_gesture_failed" );
    succeeded = 0;
    
    if ( evt != "death" && evt != "last_stand_enter" && evt != "disconnect" )
    {
        if ( evt == "timeout" && activating )
        {
            return succeeded;
        }
        
        succeeded = 1;
        
        if ( activating )
        {
            if ( !isdefined( var_e97a4f4962bc3f25 ) )
            {
                if ( bgb == "mr_peeks" )
                {
                    self setscriptablepartstate( "bgb_bubble_pop_fx", "bgb_bubble_pop_white_negative" );
                }
                
                return;
            }
            
            if ( level.bgb[ bgb ].var_2835271953fa6c93 || function_f88abb570e486ee7( bgb, var_e97a4f4962bc3f25 ) )
            {
                switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
                {
                    case #"hash_4f89286e3448ad44":
                    case #"hash_d80a36cf43c842b8":
                        function_b62ba460d1b3dac9( bgb );
                        break;
                    case #"hash_d9a7b65f9477385c":
                        self notify( #"bgb_gumball_anim_activate", bgb );
                        function_1ab5a545e01943e5( var_e97a4f4962bc3f25 );
                        thread function_eee93a5975c3c02b( bgb, var_e97a4f4962bc3f25 );
                        break;
                }
            }
            else
            {
                self playlocalsound( #"hash_d8d9c4eb514390a7" );
                self.var_44c8fd4fb28eb652 = undefined;
                succeeded = 0;
            }
        }
        else
        {
            self notify( #"bgb_gumball_anim_give", bgb );
            function_c068e36660508e7c( bgb, 1 );
            health = 0;
            
            if ( isdefined( self.health ) )
            {
                health = self.health;
            }
        }
    }
    
    self.var_44c8fd4fb28eb652 = undefined;
    return succeeded;
}

// Namespace bgb
// Params 3
// Checksum 0xdf0a92a8, Offset: 0x2f43
// Size: 0xf0
function function_eee93a5975c3c02b( bgb, var_e97a4f4962bc3f25, load_run = 0 )
{
    self endon( #"disconnect" );
    function_bcbff0270055a8e5( 1, var_e97a4f4962bc3f25 );
    
    if ( !load_run )
    {
        function_b62ba460d1b3dac9( bgb );
    }
    
    self notify( "bgb_bubble_blow_complete" + var_e97a4f4962bc3f25 );
    self [[ level.bgb[ bgb ].var_eeaed1eb223197cd ]]();
    function_bcbff0270055a8e5( 0, var_e97a4f4962bc3f25 );
    activation_complete( var_e97a4f4962bc3f25 );
    var_c2afe1a671205584 = getxhash( bgb );
    params = spawnstruct();
    params.name = bgb;
    params.var_e97a4f4962bc3f25 = var_e97a4f4962bc3f25;
    params.rarity = level.gobblegums[ var_c2afe1a671205584 ].rarity;
    callback::callback( "on_gobblegum_activated", params );
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0x4b3585a7, Offset: 0x303b
// Size: 0x57
function private function_8e7259c2100d0096( bgb, activating )
{
    if ( activating )
    {
        return ( "cer_zm_vm_ges_bgb_grab_" + level.bgb[ bgb ].name );
    }
    
    return "cer_zm_vm_ges_bgb_hold_" + level.bgb[ bgb ].name;
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0x9616bb3b, Offset: 0x309a
// Size: 0x4e
function private function_d527e80e3a3527e9( bgb, activating )
{
    gesture = function_8e7259c2100d0096( bgb, activating );
    
    if ( isdefined( gesture ) )
    {
        utility::function_72b6372d2d8c997( gesture, 1, 1 );
        
        if ( activating )
        {
            self notify( #"chewed_gum" );
        }
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0xe32149f8, Offset: 0x30f0
// Size: 0x33
function private function_c6350c3d46b0c910( var_e97a4f4962bc3f25 )
{
    self notify( "bgb_limit_monitor" + var_e97a4f4962bc3f25 );
    self notify( "bgb_activation_monitor" + var_e97a4f4962bc3f25 );
    self.var_d0aba4df93e5778c = undefined;
    function_fbd83ac3c8000c91();
}

// Namespace bgb
// Params 3, eflags: 0x4
// Checksum 0x9f16318e, Offset: 0x312b
// Size: 0x52b
function private bgb_limit_monitor( bgb, var_e97a4f4962bc3f25, override_limit )
{
    self endon( #"disconnect" );
    self endon( "bgb_update" + var_e97a4f4962bc3f25 );
    self notify( "bgb_limit_monitor" + var_e97a4f4962bc3f25 );
    self endon( "bgb_limit_monitor" + var_e97a4f4962bc3f25 );
    var_6123eea429d6e467 = function_bc8c83873f4039ba( var_e97a4f4962bc3f25 );
    var_3bd60cc6edafb960 = function_aa94462478309658( var_e97a4f4962bc3f25 );
    
    switch ( level.bgb[ bgb ].var_882452eafdaa1626 )
    {
        case #"hash_d9a7b65f9477385c":
            thread bgb_activation_monitor( bgb, var_e97a4f4962bc3f25 );
            self setclientomnvar( var_3bd60cc6edafb960, 1 );
            xuid = function_fffbd405b1911268( self getxuid() );
            
            if ( !isdefined( level.var_60ef36d37839ce06[ xuid ][ bgb ] ) )
            {
                level.var_60ef36d37839ce06[ xuid ][ bgb ] = 0;
            }
            
            level.var_60ef36d37839ce06[ xuid ][ bgb ] += 1;
            
            for ( i = level.bgb[ bgb ].limit; i > 0 ; i-- )
            {
                level.bgb[ bgb ].n_remaining_uses = i;
                
                if ( level.bgb[ bgb ].var_31c35a24cb99c2bb )
                {
                    fill_timer();
                }
                else
                {
                    function_617295e701ea7630( i, level.bgb[ bgb ].limit );
                }
                
                thread function_1cbb7c4779626c18( bgb, i );
                
                while ( function_ac908f1b9fcec331( var_e97a4f4962bc3f25 ) )
                {
                    waitframe();
                }
            }
            
            level.bgb[ bgb ].n_remaining_uses = 0;
            self playsoundtoplayer( #"hash_1c75f6c0e0690a9f", self );
            function_617295e701ea7630( 0, level.bgb[ bgb ].limit );
            
            while ( self.var_3d6f7510b53d3eee[ var_e97a4f4962bc3f25 ] )
            {
                waitframe();
            }
            
            break;
        case #"hash_4f89286e3448ad44":
            thread function_1cbb7c4779626c18( bgb );
            thread function_e4cf4f6a0ade874d( level.bgb[ bgb ].limit, var_6123eea429d6e467, override_limit );
            wait_time = override_limit ?? level.bgb[ bgb ].limit;
            self.bgb_enabled[ bgb ] = spawnstruct();
            self.bgb_enabled[ bgb ].start_time = gettime();
            self.bgb_enabled[ bgb ].time_left_at_start = wait_time;
            xuid = function_fffbd405b1911268( self getxuid() );
            
            if ( !isdefined( level.var_60ef36d37839ce06[ xuid ][ bgb ] ) )
            {
                level.var_60ef36d37839ce06[ xuid ][ bgb ] = 0;
            }
            
            level.var_60ef36d37839ce06[ xuid ][ bgb ] += 1;
            str_response = utility::waittill_any_timeout( wait_time, "bgb_end_type_time_limit" + var_6123eea429d6e467 );
            
            if ( str_response != "timeout" )
            {
                self setclientomnvar( var_6123eea429d6e467, 0 );
            }
            
            self playsoundtoplayer( #"hash_1c75f6c0e0690a9f", self );
            self.bgb_enabled = function_a5c1175d3ea3c25a( self.bgb_enabled, self.bgb_enabled[ bgb ] );
            break;
        case #"hash_d80a36cf43c842b8":
            thread function_1cbb7c4779626c18( bgb );
            self.bgb_enabled[ bgb ] = spawnstruct();
            count = override_limit ?? level.bgb[ bgb ].limit;
            self.bgb_enabled[ bgb ].rounds_left = count;
            self setclientomnvar( var_3bd60cc6edafb960, 1 );
            
            for ( i = 0; i < count ; i++ )
            {
                level waittill( #"bgb_round_end" );
                self.bgb_enabled[ bgb ].rounds_left--;
            }
            
            self playsoundtoplayer( #"hash_1c75f6c0e0690a9f", self );
            self.bgb_enabled = function_a5c1175d3ea3c25a( self.bgb_enabled, self.bgb_enabled[ bgb ] );
            break;
        case #"hash_a77aa76e7d308f7f":
            thread function_1cbb7c4779626c18( bgb );
            self.bgb_enabled[ bgb ] = spawnstruct();
            self setclientomnvar( var_3bd60cc6edafb960, 1 );
            self setclientomnvar( var_6123eea429d6e467, 1 );
            self [[ level.bgb[ bgb ].limit ]]();
            self playsoundtoplayer( #"hash_1c75f6c0e0690a9f", self );
            self.bgb_enabled = function_a5c1175d3ea3c25a( self.bgb_enabled, self.bgb_enabled[ bgb ] );
            self setclientomnvar( var_6123eea429d6e467, 0 );
            break;
        default:
            assert( 0, "<dev string:x22a>" + bgb + "<dev string:x24a>" + level.bgb[ bgb ].var_882452eafdaa1626 + "<dev string:x25a>" );
            break;
    }
    
    waitframe();
    self setclientomnvar( var_3bd60cc6edafb960, 0 );
    self setclientomnvar( "ui_gobblegum_effect_finished", gettime() );
    function_279d7169a70211bd( 0 );
    function_4818e19472b65502( bgb, var_e97a4f4962bc3f25 );
    thread take( var_e97a4f4962bc3f25 );
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xee680f56, Offset: 0x365e
// Size: 0xaf
function private bgb_activation_monitor( bgb, var_e97a4f4962bc3f25 )
{
    self endon( #"disconnect" );
    self notify( "bgb_activation_monitor" + var_e97a4f4962bc3f25 );
    self endon( "bgb_activation_monitor" + var_e97a4f4962bc3f25 );
    
    if ( "activated" != level.bgb[ bgb ].var_882452eafdaa1626 )
    {
        return;
    }
    
    for ( ;; )
    {
        self waittill( #"bgb_activation_request", index );
        
        if ( !function_f88abb570e486ee7( bgb, var_e97a4f4962bc3f25 ) )
        {
            continue;
        }
        
        if ( function_a5d37b16547199e4( bgb, 1 ) )
        {
            self notify( "bgb_activation" + var_e97a4f4962bc3f25, bgb );
            
            if ( isdefined( index ) )
            {
                self.var_b02f6e7abbbc8a84[ index ] = undefined;
            }
        }
    }
}

// Namespace bgb
// Params 3
// Checksum 0x68f46b95, Offset: 0x3715
// Size: 0x23f, Type: bool
function function_f88abb570e486ee7( bgb, var_e97a4f4962bc3f25, b_show_splash = 0 )
{
    var_1022428e5bb5e58c = isdefined( level.bgb[ bgb ].var_866744e27c70eb1c ) && !self [[ level.bgb[ bgb ].var_866744e27c70eb1c ]]();
    var_2d5943b2b10cebab = isdefined( level.var_23378cc637cedbd7 ) && !self [[ level.var_23378cc637cedbd7 ]]( bgb );
    weapon = self getcurrentweapon();
    var_e93806357f75edc0 = 1;
    
    if ( self.var_eeb6ebe322e71cd1 || level.var_eeb6ebe322e71cd1 )
    {
        var_cdc7f7151bb13a50 = #"hash_d496b2ae81866b";
        var_e93806357f75edc0 = 0;
    }
    else if ( self.var_3d6f7510b53d3eee[ var_e97a4f4962bc3f25 ] )
    {
        var_cdc7f7151bb13a50 = #"hash_77dcd037886838e7";
        var_e93806357f75edc0 = 0;
    }
    else if ( self.insertingarmorplate || player::isinlaststand( self ) || self isonladder() || self isonascender() || self.var_d1c4c78b9fb7d153 || self.is_crafting || self isgestureplaying() && !self isswimming() || self isoffhandweaponreadytothrow() || self isthrowinggrenade() || player::isreviving() || self ismantling() || self isswitchingweapon() || self issprintsliding() || self isdiving() || self ismeleeing() || self isspectatinganyone() || vehicle::is_in_vehicle() || killstreakdeploy::function_9670f0716ada309b( weapon.basename ) || killstreak_utility::iskillstreakdeployweapon( weapon ) || utility::isusingremote() || self.geigercounterstruct.pulledout || self.var_fd68d41f12eb9022 )
    {
        var_cdc7f7151bb13a50 = #"hash_237605e1c7778d6b";
        var_e93806357f75edc0 = 0;
    }
    else if ( var_1022428e5bb5e58c || var_2d5943b2b10cebab )
    {
        var_cdc7f7151bb13a50 = #"hash_375264cf5b1fecce";
        var_e93806357f75edc0 = 0;
    }
    
    if ( !var_e93806357f75edc0 )
    {
        if ( b_show_splash )
        {
            function_4f13eb3f058c04e5( bgb, var_cdc7f7151bb13a50 );
        }
        
        return false;
    }
    
    return true;
}

// Namespace bgb
// Params 2
// Checksum 0xb732d65c, Offset: 0x395d
// Size: 0x155, Type: bool
function function_59449da4704f08db( bgb, var_e97a4f4962bc3f25 )
{
    weapon = self getcurrentweapon();
    
    if ( self.var_eeb6ebe322e71cd1 || self.var_3d6f7510b53d3eee[ var_e97a4f4962bc3f25 ] || level.var_eeb6ebe322e71cd1 || self.insertingarmorplate || player::isinlaststand( self ) || self isonladder() || self isonascender() || self.var_d1c4c78b9fb7d153 || self.is_crafting || self isgestureplaying() && !self isswimming() || self isoffhandweaponreadytothrow() || self isthrowinggrenade() || player::isreviving() || self ismantling() || self isswitchingweapon() || self issprintsliding() || self isdiving() || self ismeleeing() || self isspectatinganyone() || vehicle::is_in_vehicle() || killstreakdeploy::function_9670f0716ada309b( weapon.basename ) || killstreak_utility::iskillstreakdeployweapon( weapon ) || utility::isusingremote() || self.geigercounterstruct.pulledout || self.var_fd68d41f12eb9022 )
    {
        return false;
    }
    
    return true;
}

// Namespace bgb
// Params 2
// Checksum 0xb8e615c0, Offset: 0x3abb
// Size: 0x43, Type: bool
function function_8d73c875d02279fe( bgb, var_e97a4f4962bc3f25 )
{
    if ( level.bgb[ bgb ].is_coop_only && level.players.size == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace bgb
// Params 1
// Checksum 0xcc3929a1, Offset: 0x3b07
// Size: 0x24
function enable_action_slot( n_value )
{
    self setactionslot( 2, "" );
    self.var_d0aba4df93e5778c = 1;
}

// Namespace bgb
// Params 1
// Checksum 0x1e9f6366, Offset: 0x3b33
// Size: 0x16
function disable_action_slot( n_value )
{
    self.var_d0aba4df93e5778c = undefined;
}

// Namespace bgb
// Params 1
// Checksum 0x90bd177, Offset: 0x3b51
// Size: 0x25
function function_31c35a24cb99c2bb( name )
{
    level.bgb[ name ].var_31c35a24cb99c2bb = 1;
}

// Namespace bgb
// Params 1
// Checksum 0xf93c4ac7, Offset: 0x3b7e
// Size: 0x123
function function_b62ba460d1b3dac9( str_name )
{
    if ( !utility::ispointinwater( self.origin ) )
    {
        switch ( level.bgb[ str_name ].rarity )
        {
            case #"hash_56dca9558042f91d":
                self setscriptablepartstate( "bgb_bubble_pop_fx", "bgb_bubble_pop_blue", 0 );
                break;
            case #"hash_9f79c9fc1aa660aa":
                self setscriptablepartstate( "bgb_bubble_pop_fx", "bgb_bubble_pop_orange", 0 );
                break;
            case #"hash_c81e81c97be2c6a8":
                self setscriptablepartstate( "bgb_bubble_pop_fx", "bgb_bubble_pop_purple", 0 );
                break;
            case #"hash_ca3e413b1500d035":
                self setscriptablepartstate( "bgb_bubble_pop_fx", "bgb_bubble_pop_red", 0 );
                break;
            case #"hash_b8ce55e0f7e8f868":
                var_35a7e90f80366839 = utility::array_random( [ "bgb_bubble_pop_green", "bgb_bubble_pop_red", "bgb_bubble_pop_purple", "bgb_bubble_pop_orange", "bgb_bubble_pop_blue", "bgb_bubble_pop_white" ] );
                self setscriptablepartstate( "bgb_bubble_pop_fx", var_35a7e90f80366839, 0 );
                break;
        }
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x193e9d2b, Offset: 0x3ca9
// Size: 0x1b
function private function_1ab5a545e01943e5( var_e97a4f4962bc3f25 )
{
    self.var_3d6f7510b53d3eee[ var_e97a4f4962bc3f25 ] = 1;
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0xdcf18332, Offset: 0x3ccc
// Size: 0x25
function private activation_complete( var_e97a4f4962bc3f25 )
{
    self.var_3d6f7510b53d3eee[ var_e97a4f4962bc3f25 ] = 0;
    self notify( "activation_complete" + var_e97a4f4962bc3f25 );
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0x68571096, Offset: 0x3cf9
// Size: 0x23
function private function_bcbff0270055a8e5( b_is_active, var_e97a4f4962bc3f25 )
{
    self.var_cc25c471a4d7eca0[ var_e97a4f4962bc3f25 ] = b_is_active;
}

// Namespace bgb
// Params 1
// Checksum 0x4612313f, Offset: 0x3d24
// Size: 0x19, Type: bool
function function_ac908f1b9fcec331( var_e97a4f4962bc3f25 )
{
    return istrue( self.var_cc25c471a4d7eca0[ var_e97a4f4962bc3f25 ] );
}

// Namespace bgb
// Params 1
// Checksum 0x6e0492c2, Offset: 0x3d46
// Size: 0x4e, Type: bool
function is_active( name )
{
    for ( x = 1; x <= 3 ; x++ )
    {
        if ( self.var_b02f6e7abbbc8a84[ x ] === name && self.var_cc25c471a4d7eca0[ x ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bgb
// Params 0
// Checksum 0x4c0613b5, Offset: 0x3d9d
// Size: 0x60
function get_all_active()
{
    a_all_active = [];
    
    for ( x = 1; x <= 3 ; x++ )
    {
        if ( isdefined( self.var_b02f6e7abbbc8a84[ x ] ) && self.var_cc25c471a4d7eca0[ x ] )
        {
            return 1;
        }
    }
    
    return a_all_active;
}

// Namespace bgb
// Params 1
// Checksum 0x2b8d75a3, Offset: 0x3e06
// Size: 0x8c, Type: bool
function function_447feb302f24fc1( name )
{
    foreach ( player in level.players )
    {
        if ( player is_active( name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bgb
// Params 0
// Checksum 0x3ceccca4, Offset: 0x3e9b
// Size: 0x5d, Type: bool
function function_3f4197e347068219()
{
    for ( x = 1; x <= 3 ; x++ )
    {
        if ( ( self.var_b02f6e7abbbc8a84[ x ] === "anywhere_but_here" || self.var_b02f6e7abbbc8a84[ x ] === "nowhere_but_there" ) && self.var_3d6f7510b53d3eee[ x ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bgb
// Params 1
// Checksum 0x6e4d442e, Offset: 0x3f01
// Size: 0x5a
function function_b87991eaf97e2279( name )
{
    if ( !isdefined( level.bgb[ name ] ) )
    {
        return 0;
    }
    
    orig_ref_count = level.bgb[ name ].var_78f0f63e7166815b;
    level.bgb[ name ].var_78f0f63e7166815b++;
    return orig_ref_count;
}

// Namespace bgb
// Params 1
// Checksum 0xa4b1a730, Offset: 0x3f64
// Size: 0x4c
function function_e46a4ef6b724b555( name )
{
    if ( !isdefined( level.bgb[ name ] ) )
    {
        return 0;
    }
    
    level.bgb[ name ].var_78f0f63e7166815b--;
    return level.bgb[ name ].var_78f0f63e7166815b;
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0x9036085b, Offset: 0x3fb9
// Size: 0x54
function private function_3ccc66cb2eb3dd0b( start_time, end_time )
{
    if ( 0 >= end_time - start_time )
    {
        return 0;
    }
    
    now = gettime();
    frac = float( end_time - now ) / float( end_time - start_time );
    return clamp( frac, 0, 1 );
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xc5b79c75, Offset: 0x4016
// Size: 0x78
function private function_14ff35e90272e0b0( orig_percent, percent )
{
    self endon( #"disconnect" );
    self endon( #"hash_6ae783a3051b411b" );
    start_time = gettime();
    end_time = start_time + 1000;
    curr_percent = orig_percent;
    
    while ( curr_percent > percent )
    {
        curr_percent = lerp_float( percent, orig_percent, function_3ccc66cb2eb3dd0b( start_time, end_time ) );
        waitframe();
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x326e48de, Offset: 0x4096
// Size: 0x44
function private function_7d36f0e011d07c4a( percent )
{
    self notify( #"hash_6ae783a3051b411b" );
    orig_percent = 0;
    
    if ( percent < orig_percent && 0.1 <= orig_percent - percent )
    {
        thread function_14ff35e90272e0b0( orig_percent, percent );
    }
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x5b0c8891, Offset: 0x40e2
// Size: 0xb
function private fill_timer()
{
    function_7d36f0e011d07c4a( 1 );
}

// Namespace bgb
// Params 2
// Checksum 0xf0e68130, Offset: 0x40f5
// Size: 0x20
function function_617295e701ea7630( current, max )
{
    function_7d36f0e011d07c4a( current / max );
}

// Namespace bgb
// Params 3
// Checksum 0xd3b31b2a, Offset: 0x411d
// Size: 0x104
function function_e4cf4f6a0ade874d( max, omnvarname, override_start )
{
    level endon( #"game_ended" );
    shouldnotify = isdefined( omnvarname );
    self endon( #"death_or_disconnect" );
    
    if ( shouldnotify )
    {
        self notify( "bgb_run_timer" + omnvarname );
        self endon( "bgb_run_timer" + omnvarname );
        self endon( "bgb_end_type_time_limit" + omnvarname );
    }
    else
    {
        self notify( #"bgb_run_timer" );
        self endon( #"bgb_run_timer" );
    }
    
    current = override_start ?? max;
    progress = 1;
    
    while ( current > 0 )
    {
        function_617295e701ea7630( current, max );
        waitframe();
        current -= level.framedurationseconds;
        
        if ( shouldnotify )
        {
            progress = clamp( current / max, 0, 1 );
            self setclientomnvar( omnvarname, progress );
        }
    }
    
    if ( shouldnotify )
    {
        self setclientomnvar( omnvarname, 0 );
    }
    
    function_fbd83ac3c8000c91();
}

// Namespace bgb
// Params 2
// Checksum 0xe0722c2f, Offset: 0x4229
// Size: 0x3d
function function_dfffb969b73ce4df( omnvarname, var_4168e1b0a662402e )
{
    percent_remaining = clamp( 1 - var_4168e1b0a662402e, 0, 1 );
    self setclientomnvar( omnvarname, percent_remaining );
}

// Namespace bgb
// Params 0
// Checksum 0x8e2b5c, Offset: 0x426e
// Size: 0x16
function function_fbd83ac3c8000c91()
{
    function_7d36f0e011d07c4a( 0 );
    self notify( #"bgb_run_timer" );
}

// Namespace bgb
// Params 7
// Checksum 0x4dd724d5, Offset: 0x428c
// Size: 0x255
function register( name, var_882452eafdaa1626, limit, var_eeb9a3815362758c, var_e187252c277f51b1, var_866744e27c70eb1c, var_eeaed1eb223197cd )
{
    assert( isdefined( name ), "<dev string:x26d>" );
    assert( "<dev string:x156>" != name, "<dev string:x293>" + "<dev string:x156>" + "<dev string:x2b5>" );
    assert( isdefined( var_882452eafdaa1626 ), "<dev string:x2ec>" + name + "<dev string:x303>" );
    assert( isdefined( limit ), "<dev string:x2ec>" + name + "<dev string:x321>" );
    
    switch ( var_882452eafdaa1626 )
    {
        case #"hash_d9a7b65f9477385c":
            assert( isdefined( var_eeaed1eb223197cd ), "<dev string:x2ec>" + name + "<dev string:x33a>" + var_882452eafdaa1626 + "<dev string:x36e>" );
        case #"hash_4f89286e3448ad44":
        case #"hash_d80a36cf43c842b8":
            assert( isint( limit ), "<dev string:x2ec>" + name + "<dev string:x370>" + limit + "<dev string:x37b>" + var_882452eafdaa1626 + "<dev string:x36e>" );
            break;
        case #"hash_a77aa76e7d308f7f":
            break;
        default:
            assert( 0, "<dev string:x2ec>" + name + "<dev string:x24a>" + var_882452eafdaa1626 + "<dev string:x25a>" );
            break;
    }
    
    level.bgb[ name ] = spawnstruct();
    level.bgb[ name ].name = name;
    level.bgb[ name ].var_882452eafdaa1626 = var_882452eafdaa1626;
    level.bgb[ name ].limit = limit;
    level.bgb[ name ].var_eeb9a3815362758c = var_eeb9a3815362758c;
    level.bgb[ name ].var_e187252c277f51b1 = var_e187252c277f51b1;
    level.bgb[ name ].var_866744e27c70eb1c = var_866744e27c70eb1c;
    
    if ( "activated" == var_882452eafdaa1626 )
    {
        level.bgb[ name ].var_eeaed1eb223197cd = var_eeaed1eb223197cd;
        level.bgb[ name ].var_31c35a24cb99c2bb = 0;
    }
    
    level.bgb[ name ].var_78f0f63e7166815b = 0;
}

// Namespace bgb
// Params 2
// Checksum 0x512815b0, Offset: 0x44e9
// Size: 0x50
function function_bc2a4a6b96b64f8c( name, var_a904d4168b913f1 )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x39d>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].var_a904d4168b913f1 = var_a904d4168b913f1;
}

// Namespace bgb
// Params 2
// Checksum 0xffa92350, Offset: 0x4541
// Size: 0x50
function function_230e27d6848f8b61( name, var_3f2176afa11ea3de )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x3e1>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].var_3f2176afa11ea3de = var_3f2176afa11ea3de;
}

// Namespace bgb
// Params 2
// Checksum 0xda197318, Offset: 0x4599
// Size: 0x50
function function_ec61fd34f7dc60f1( name, var_579aec493af994ca )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x410>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].var_579aec493af994ca = var_579aec493af994ca;
}

// Namespace bgb
// Params 3
// Checksum 0xa88fbba4, Offset: 0x45f1
// Size: 0x66
function function_c9046bccce2a4ac8( name, var_5d573c4e09b4515, var_56978ea557d90fe9 )
{
    if ( !isdefined( level.a_lost_perk_override_func ) )
    {
        level.a_lost_perk_override_func = [];
    }
    
    assert( !isdefined( level.a_lost_perk_override_func[ name ] ), "<dev string:x43c>" + name + "<dev string:x3ca>" );
    level.a_lost_perk_override_func[ name ] = var_5d573c4e09b4515;
}

// Namespace bgb
// Params 3
// Checksum 0x2d1cdd96, Offset: 0x465f
// Size: 0x71
function register_add_to_player_score_override( name, var_1aa4a0aa96095b74, var_a8bbdb86fcca80a2 )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x466>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].var_1aa4a0aa96095b74 = var_1aa4a0aa96095b74;
    level.bgb[ name ].var_a8bbdb86fcca80a2 = var_a8bbdb86fcca80a2;
}

// Namespace bgb
// Params 2
// Checksum 0xdb81fe4b, Offset: 0x46d8
// Size: 0x50
function function_dbfbba0189f602fa( name, var_f201d6c52dcc7908 )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x49a>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].var_f201d6c52dcc7908 = var_f201d6c52dcc7908;
}

// Namespace bgb
// Params 2
// Checksum 0xd61828b9, Offset: 0x4730
// Size: 0x50
function register_consumption_override( name, consumption_override_func )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x4d0>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].consumption_override_func = consumption_override_func;
}

// Namespace bgb
// Params 1
// Checksum 0x5ebd5790, Offset: 0x4788
// Size: 0x48
function function_ce86ce7072318af3( name )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x4fc>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].var_2835271953fa6c93 = 1;
}

// Namespace bgb
// Params 1
// Checksum 0xff9d02ce, Offset: 0x47d8
// Size: 0x48
function function_ecc4426f6a3d4e88( name )
{
    assert( isdefined( level.bgb[ name ] ), "<dev string:x4fc>" + name + "<dev string:x3ca>" );
    level.bgb[ name ].is_coop_only = 1;
}

// Namespace bgb
// Params 4
// Checksum 0xf65e53ca, Offset: 0x4828
// Size: 0x10f
function give_slot( var_e97a4f4962bc3f25, name, override_limit, should_enable = 1 )
{
    if ( "none" == name || "empty" == name )
    {
        return;
    }
    
    assert( isdefined( level.bgb[ name ] ), "<dev string:x52c>" + name + "<dev string:x3ca>" );
    self notify( "bgb_update" + var_e97a4f4962bc3f25, name );
    self notify( "bgb_update_give_" + name );
    self.var_f1dccd054c74a27e[ var_e97a4f4962bc3f25 ] = 1;
    
    if ( should_enable )
    {
        if ( isdefined( level.bgb[ name ].var_eeb9a3815362758c ) )
        {
            self thread [[ level.bgb[ name ].var_eeb9a3815362758c ]]();
        }
    }
    
    if ( name == "support_group" && override_limit && isdefined( level.bgb[ name ].var_eeaed1eb223197cd ) )
    {
        thread function_eee93a5975c3c02b( name, var_e97a4f4962bc3f25, 1 );
        waitframe();
    }
    
    thread bgb_limit_monitor( name, var_e97a4f4962bc3f25, override_limit );
}

// Namespace bgb
// Params 2
// Checksum 0x8bbed88d, Offset: 0x493f
// Size: 0x125
function take( var_e97a4f4962bc3f25, skip_disable = 0 )
{
    bgb = self.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ];
    
    if ( !isdefined( bgb ) || "none" == bgb || "empty" == bgb )
    {
        return;
    }
    
    thread function_1cbb7c4779626c18( "none" );
    
    if ( isdefined( level.bgb[ bgb ].var_e187252c277f51b1 ) && !skip_disable )
    {
        self thread [[ level.bgb[ bgb ].var_e187252c277f51b1 ]]();
    }
    
    function_c6350c3d46b0c910( var_e97a4f4962bc3f25 );
    self notify( "bgb_update" + var_e97a4f4962bc3f25, "none", bgb );
    self notify( "bgb_update_take_" + bgb );
    clear_action_slot( var_e97a4f4962bc3f25 );
    self.var_f1dccd054c74a27e[ var_e97a4f4962bc3f25 ] = 0;
    var_d1e1920ac64d4d1a = function_bc8c83873f4039ba( var_e97a4f4962bc3f25 );
    self notify( "bgb_end_type_time_limit" + var_d1e1920ac64d4d1a );
    self setclientomnvar( var_d1e1920ac64d4d1a, 0 );
    self.bgb_enabled = function_a5c1175d3ea3c25a( self.bgb_enabled, self.bgb_enabled[ bgb ] );
}

// Namespace bgb
// Params 1
// Checksum 0xb06f225d, Offset: 0x4a6c
// Size: 0x61
function get_bgb_rarity( raritystr )
{
    switch ( raritystr )
    {
        case #"hash_56dca9558042f91d":
            return 1;
        case #"hash_c81e81c97be2c6a8":
            return 2;
        case #"hash_9f79c9fc1aa660aa":
            return 3;
        case #"hash_ca3e413b1500d035":
            return 4;
        case #"hash_b8ce55e0f7e8f868":
            return 5;
    }
}

// Namespace bgb
// Params 0
// Checksum 0x457560bf, Offset: 0x4ad5
// Size: 0x20
function function_ae299ca378406354()
{
    return isdefined( self.bgb_enabled ) ? getarraykeys( self.bgb_enabled ) : [];
}

// Namespace bgb
// Params 1
// Checksum 0x11de7af8, Offset: 0x4afe
// Size: 0x19, Type: bool
function is_enabled( name )
{
    return isdefined( self.bgb_enabled[ name ] );
}

// Namespace bgb
// Params 0
// Checksum 0x9084a249, Offset: 0x4b20
// Size: 0x1e
function function_1f3af7c544dec322()
{
    assert( isdefined( self.bgb_enabled ) );
    return self.bgb_enabled.size;
}

// Namespace bgb
// Params 1
// Checksum 0xfa823d36, Offset: 0x4b47
// Size: 0x92, Type: bool
function function_7743e959edeca6c4( str_name )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.bgb_enabled[ str_name ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bgb
// Params 2
// Checksum 0x3d739112, Offset: 0x4be2
// Size: 0x8f
function function_d38deee41dc2c68b( var_6616f335e5230913 = 0, var_b6081b1b6ba5e8b5 = 120 )
{
    powerup_origin = self.origin + anglestoforward( ( 0, self getplayerangles()[ 1 ], 0 ) ) * var_b6081b1b6ba5e8b5 + ( 0, 0, powerups::get_powerup_var( "drop_height_offset" ) );
    
    if ( var_6616f335e5230913 )
    {
        var_313663700b9fea38 = getrandomnavpoint( powerup_origin, 32 );
        
        if ( isdefined( var_313663700b9fea38 ) )
        {
            powerup_origin = var_313663700b9fea38 + ( 0, 0, powerups::get_powerup_var( "drop_height_offset" ) );
        }
    }
    
    return powerup_origin;
}

// Namespace bgb
// Params 3
// Checksum 0xa02e900a, Offset: 0x4c7a
// Size: 0x3b
function function_9ecd75f64d86a93f( str_powerup, v_origin, safe_spawn )
{
    utility::callsharedfunc( #"bgb", #"hash_6a2d092be9b7041e", str_powerup, v_origin, safe_spawn );
}

// Namespace bgb
// Params 1
// Checksum 0x65bc89a6, Offset: 0x4cbd
// Size: 0x1dc
function function_8afa2c5e22cc4af4( e_powerup )
{
    if ( !isdefined( e_powerup ) )
    {
        return;
    }
    
    e_powerup hide();
    e_powerup.clone_model = utility::spawn_model( e_powerup.model, e_powerup.origin, e_powerup.angles );
    e_powerup.clone_model linkto( e_powerup );
    direction = e_powerup.origin;
    direction = ( direction[ 1 ], direction[ 0 ], 0 );
    
    if ( direction[ 1 ] < 0 || direction[ 0 ] > 0 && direction[ 1 ] > 0 )
    {
        direction = ( direction[ 0 ], direction[ 1 ] * -1, 0 );
    }
    else if ( direction[ 0 ] < 0 )
    {
        direction = ( direction[ 0 ] * -1, direction[ 1 ], 0 );
    }
    
    if ( !e_powerup.var_d41b3208b6bce83a )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isalive( players[ i ] ) )
            {
            }
        }
    }
    
    e_powerup.clone_model unlink();
    e_powerup.clone_model movez( 60, 1, 0.25, 0.25 );
    e_powerup.clone_model vibrate( direction, 1.5, 2.5, 1 );
    e_powerup.clone_model waittill( #"movedone" );
    
    if ( isdefined( self.damagearea ) )
    {
        self.damagearea delete();
    }
    
    if ( isdefined( e_powerup.clone_model ) )
    {
        e_powerup.clone_model delete();
    }
    
    if ( isdefined( e_powerup ) )
    {
        if ( isdefined( e_powerup.damagearea ) )
        {
            e_powerup.damagearea delete();
        }
        
        e_powerup powerups::powerup_delete();
    }
}

// Namespace bgb
// Params 12
// Checksum 0x706b6253, Offset: 0x4ea1
// Size: 0x165
function function_631cb872de47f966( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, var_34df9789ee8e27b8, surfacetype )
{
    if ( !level.var_bbc77801abf4d365 )
    {
        return damage;
    }
    
    if ( isplayer( attacker ) )
    {
        var_1d0011af59d73ab6 = attacker function_ae299ca378406354();
        
        foreach ( name in var_1d0011af59d73ab6 )
        {
            if ( name != "none" && isdefined( level.bgb[ name ] ) && isdefined( level.bgb[ name ].var_a904d4168b913f1 ) )
            {
                damage = [[ level.bgb[ name ].var_a904d4168b913f1 ]]( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, var_34df9789ee8e27b8, surfacetype );
            }
        }
    }
    
    return damage;
}

// Namespace bgb
// Params 15
// Checksum 0x3f660273, Offset: 0x500f
// Size: 0x184
function function_8e48be3ff1208ff7( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, var_fb456defff49bb87, psoffsettime, var_8c00b8245a4ff9a1, modelindex, partname, var_bc5761d86882d550 )
{
    if ( !level.var_bbc77801abf4d365 )
    {
        return idamage;
    }
    
    if ( isplayer( eattacker ) )
    {
        var_1d0011af59d73ab6 = eattacker function_ae299ca378406354();
        
        foreach ( name in var_1d0011af59d73ab6 )
        {
            if ( name != "none" && isdefined( level.bgb[ name ] ) && isdefined( level.bgb[ name ].var_3f2176afa11ea3de ) )
            {
                idamage = [[ level.bgb[ name ].var_3f2176afa11ea3de ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, var_fb456defff49bb87, psoffsettime, var_8c00b8245a4ff9a1, modelindex, partname, var_bc5761d86882d550 );
            }
        }
    }
    
    return idamage;
}

// Namespace bgb
// Params 1
// Checksum 0x881f7272, Offset: 0x519c
// Size: 0xfa
function function_11bbe650307af1bb( attacker )
{
    if ( !level.var_bbc77801abf4d365 )
    {
        return 0;
    }
    
    if ( isplayer( attacker ) )
    {
        var_1d0011af59d73ab6 = attacker function_ae299ca378406354();
        
        foreach ( name in var_1d0011af59d73ab6 )
        {
            if ( name != "none" && isdefined( level.bgb[ name ] ) && isdefined( level.bgb[ name ].var_579aec493af994ca ) )
            {
                damage = [[ level.bgb[ name ].var_579aec493af994ca ]]( attacker );
            }
        }
    }
    
    return damage;
}

// Namespace bgb
// Params 1
// Checksum 0xacd6f44a, Offset: 0x529f
// Size: 0x20d
function function_e4c9e826f4da942( perk )
{
    var_66071b7285da1614 = 0;
    
    if ( !level.var_bbc77801abf4d365 )
    {
        return var_66071b7285da1614;
    }
    
    if ( !self.laststand )
    {
        return var_66071b7285da1614;
    }
    
    keys = getarraykeys( level.bgb );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        name = keys[ i ];
        
        if ( level.bgb[ name ].var_56978ea557d90fe9 && isdefined( level.bgb[ name ].var_5d573c4e09b4515 ) )
        {
            var_66071b7285da1614 = [[ level.bgb[ name ].var_5d573c4e09b4515 ]]( perk, self, undefined );
            
            if ( var_66071b7285da1614 )
            {
                return var_66071b7285da1614;
            }
        }
    }
    
    foreach ( player in level.activeplayers )
    {
        var_1d0011af59d73ab6 = player function_ae299ca378406354();
        
        foreach ( name in var_1d0011af59d73ab6 )
        {
            if ( name != "none" && isdefined( level.bgb[ name ] ) && isdefined( level.bgb[ name ].var_5d573c4e09b4515 ) )
            {
                var_66071b7285da1614 = [[ level.bgb[ name ].var_5d573c4e09b4515 ]]( perk, self, player );
                
                if ( var_66071b7285da1614 )
                {
                    return var_66071b7285da1614;
                }
            }
        }
    }
    
    return var_66071b7285da1614;
}

// Namespace bgb
// Params 2
// Checksum 0xc5267fdf, Offset: 0x54b5
// Size: 0x1a3
function function_ed911cdbb38c6719( var_eb8fc40490886d0a, var_18484ecb85b885be )
{
    if ( getmatchrulesdata( "zmData", "disableBGB" ) )
    {
        return 0;
    }
    
    var_1d0011af59d73ab6 = function_ae299ca378406354();
    keys = getarraykeys( level.bgb );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        var_66cc4d3d21a0ce0d = keys[ i ];
        
        if ( arraycontains( var_1d0011af59d73ab6, var_66cc4d3d21a0ce0d ) )
        {
            continue;
        }
        
        if ( level.bgb[ var_66cc4d3d21a0ce0d ].var_a8bbdb86fcca80a2 && isdefined( level.bgb[ var_66cc4d3d21a0ce0d ].var_1aa4a0aa96095b74 ) )
        {
            return_points = [[ level.bgb[ var_66cc4d3d21a0ce0d ].var_1aa4a0aa96095b74 ]]( var_eb8fc40490886d0a, var_18484ecb85b885be, 0 );
        }
    }
    
    foreach ( name in var_1d0011af59d73ab6 )
    {
        if ( name != "none" && isdefined( level.bgb[ name ] ) && isdefined( level.bgb[ name ].var_1aa4a0aa96095b74 ) )
        {
            return_points = [[ level.bgb[ name ].var_1aa4a0aa96095b74 ]]( var_eb8fc40490886d0a, var_18484ecb85b885be, 1 );
        }
    }
    
    if ( !isdefined( return_points ) )
    {
        return_points = 0;
    }
    
    return return_points;
}

// Namespace bgb
// Params 0
// Checksum 0xc554f577, Offset: 0x5661
// Size: 0x82
function function_c1f3a463f59450e4()
{
    keys = getarraykeys( level.bgb );
    keys = arrayrandomize( keys );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( level.bgb[ keys[ i ] ].rarity != 1 )
        {
            continue;
        }
        
        if ( level.bgb[ keys[ i ] ].var_f3c4afaab82ad52c > 0 )
        {
            continue;
        }
        
        return keys[ i ];
    }
}

// Namespace bgb
// Params 4
// Checksum 0x7f71dbb5, Offset: 0x56eb
// Size: 0x46
function player_proximity_watcher( s_bgb_name, var_f1049b8a723a44d5, var_ee74f5c08773dd01, var_9d750119fbee4b60 )
{
    utility::callsharedfunc( #"bgb", #"player_proximity_watcher", s_bgb_name, var_f1049b8a723a44d5, var_ee74f5c08773dd01, var_9d750119fbee4b60 );
}

// Namespace bgb
// Params 3
// Checksum 0xcbd1db4b, Offset: 0x5739
// Size: 0x5d, Type: bool
function function_c697fa83a109543f( n_distance, e_object_1, e_object_2 )
{
    n_max_distance_squared = n_distance * n_distance;
    n_current_distance_squared = distancesquared( e_object_1.origin, e_object_2.origin );
    
    if ( n_current_distance_squared <= n_max_distance_squared )
    {
        return true;
    }
    
    return false;
}

// Namespace bgb
// Params 0
// Checksum 0xbf46d8b4, Offset: 0x579f
// Size: 0x2
function deny_ui()
{
    
}

// Namespace bgb
// Params 0
// Checksum 0x3dd9d840, Offset: 0x57a9
// Size: 0xe
function function_8bc22ace10c93961()
{
    utility::flag_clear( "bgb_weapon_cycling" );
}

// Namespace bgb
// Params 0
// Checksum 0x2fa19ef8, Offset: 0x57bf
// Size: 0xe
function function_fbc51506a7149d0c()
{
    utility::flag_set( "bgb_weapon_cycling" );
}

// Namespace bgb
// Params 0
// Checksum 0x10b01599, Offset: 0x57d5
// Size: 0x29
function function_716ca22c40cfb70f()
{
    if ( !utility::flag_exist( "bgb_weapon_cycling" ) )
    {
        utility::flag_init( "bgb_weapon_cycling" );
    }
    
    utility::flag_set( "bgb_weapon_cycling" );
}

// Namespace bgb
// Params 0
// Checksum 0x855cba1e, Offset: 0x5806
// Size: 0xe
function function_45c138fd8539afbe()
{
    utility::flag_wait( "bgb_weapon_cycling" );
}

// Namespace bgb
// Params 1
// Checksum 0x236a4b96, Offset: 0x581c
// Size: 0xa1
function revive_and_return_perk_on_bgb_activation( perk )
{
    self notify( "revive_and_return_perk_on_bgb_activation" + perk );
    self endon( "revive_and_return_perk_on_bgb_activation" + perk );
    self endon( #"disconnect" );
    self endon( #"last_stand_bleedout" );
    self waittill( #"player_revived", var_8d52b82dc48e7dab );
    
    if ( self.var_a0b1f41aaeb1ce10 || isdefined( var_8d52b82dc48e7dab ) && is_enabled( "zm_bgb_near_death_experience" ) || isdefined( var_8d52b82dc48e7dab.bgb ) && var_8d52b82dc48e7dab is_enabled( "zm_bgb_near_death_experience" ) )
    {
        waitframe();
        thread zombie_perks::give_perk( perk, 0 );
    }
}

// Namespace bgb
// Params 0
// Checksum 0x4464832e, Offset: 0x58c5
// Size: 0x49
function function_cc02815a6734823c()
{
    self endon( #"death_or_disconnect" );
    self.var_a0b1f41aaeb1ce10 = 1;
    self waittill( #"laststand_revived" );
    waitframe();
    
    if ( self.var_a0b1f41aaeb1ce10 )
    {
        self notify( #"bgb_revive" );
        self.var_a0b1f41aaeb1ce10 = undefined;
    }
}

// Namespace bgb
// Params 3
// Checksum 0x43e4562f, Offset: 0x5916
// Size: 0x27
function lerp_float( from, to, delta )
{
    return from + delta * ( to - from );
}

// Namespace bgb
// Params 1
// Checksum 0xcf3d006d, Offset: 0x5946
// Size: 0x18
function on_round_end( params )
{
    level notify( #"bgb_round_end" );
}

// Namespace bgb
// Params 1
// Checksum 0xf80fffd3, Offset: 0x5966
// Size: 0xb7
function on_exfil_end( params )
{
    if ( params.a_exfil_players )
    {
        foreach ( player in params.a_exfil_players )
        {
            if ( isplayer( player ) )
            {
                player val::set( "exfil_end", "allow_scripted_bgb_use", 0 );
            }
        }
        
        return;
    }
    
    level.var_eeb6ebe322e71cd1 = 1;
}

// Namespace bgb
// Params 2
// Checksum 0x9f65dcfa, Offset: 0x5a25
// Size: 0x32
function function_f6c20f50c45b4e6b( v_origin, str_powerup )
{
    return utility::callsharedfunc( #"bgb", #"hash_56f7ba41e3b2f7b8", v_origin, str_powerup, 1 );
}

// Namespace bgb
// Params 1
// Checksum 0xafb0b5, Offset: 0x5a60
// Size: 0x26
function function_5e53a4c5e5a4250e( a_v_origins )
{
    return utility::callsharedfunc( #"bgb", #"hash_8f6e526f4e3003f9", a_v_origins );
}

// Namespace bgb
// Params 0
// Checksum 0x4479ddcf, Offset: 0x5a8f
// Size: 0x57
function function_9c71926abe552c83()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait randomintrange( 20, 60 );
        slot = randomintrange( 0, 3 );
        self.var_b02f6e7abbbc8a84[ slot ] = utility::array_random( self.var_cde87e02d2e3970f );
        use_action_slot( slot );
    }
}

// Namespace bgb
// Params 1
// Checksum 0xd8786489, Offset: 0x5aee
// Size: 0x20, Type: bool
function is_slot_loaded( var_e97a4f4962bc3f25 )
{
    if ( isdefined( self.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bgb
// Params 0
// Checksum 0xae9b6e9d, Offset: 0x5b17
// Size: 0x32
function function_c0286238eba807()
{
    for ( x = 3; x >= 1 ; x-- )
    {
        if ( !isdefined( self.var_b02f6e7abbbc8a84[ x ] ) )
        {
            return x;
        }
    }
}

// Namespace bgb
// Params 2
// Checksum 0x55e23e5e, Offset: 0x5b52
// Size: 0x125
function function_c068e36660508e7c( var_66cc4d3d21a0ce0d, var_98b2a8feeb72583e = 0 )
{
    xuid = function_fffbd405b1911268( self getxuid() );
    
    if ( !var_98b2a8feeb72583e && level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] > 2 )
    {
        function_4818e19472b65502( var_66cc4d3d21a0ce0d );
        level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] = undefined;
        return;
    }
    
    if ( !isdefined( level.bgb[ var_66cc4d3d21a0ce0d ].name ) )
    {
        return;
    }
    
    for ( x = 3; x >= 1 ; x-- )
    {
        if ( !isdefined( self.var_b02f6e7abbbc8a84[ x ] ) )
        {
            self.var_b02f6e7abbbc8a84[ x ] = var_66cc4d3d21a0ce0d;
            var_c2afe1a671205584 = getxhash( var_66cc4d3d21a0ce0d );
            index = level.gobblegums[ var_c2afe1a671205584 ].index;
            
            if ( !isdefined( index ) )
            {
                self.var_b02f6e7abbbc8a84[ x ] = undefined;
                return;
            }
            
            self setclientomnvar( get_ui_slot_name( x ), index );
            self setclientomnvar( "ui_focused_gobblegum_slot_index", x );
            function_279d7169a70211bd( x );
            return;
        }
    }
}

// Namespace bgb
// Params 4
// Checksum 0x5610ce2e, Offset: 0x5c7f
// Size: 0xe5
function set_action_slot( var_e97a4f4962bc3f25, var_66cc4d3d21a0ce0d, var_b1c06955782a4193 = 1, var_5b9e64b65e1b5b74 = 0 )
{
    self.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ] = var_66cc4d3d21a0ce0d;
    var_c2afe1a671205584 = getxhash( var_66cc4d3d21a0ce0d );
    index = level.gobblegums[ var_c2afe1a671205584 ].index;
    
    if ( !isdefined( index ) )
    {
        self.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ] = undefined;
        return;
    }
    
    self setclientomnvar( get_ui_slot_name( var_e97a4f4962bc3f25 ), index );
    self setclientomnvar( "ui_focused_gobblegum_slot_index", var_e97a4f4962bc3f25 );
    
    if ( var_b1c06955782a4193 )
    {
        function_279d7169a70211bd( var_e97a4f4962bc3f25 );
    }
    
    if ( var_5b9e64b65e1b5b74 )
    {
        lootid = level.gobblegums[ var_c2afe1a671205584 ].lootid;
        function_94dc417dd511cefa( lootid );
    }
}

// Namespace bgb
// Params 1
// Checksum 0xb5bdd35e, Offset: 0x5d6c
// Size: 0x3e, Type: bool
function function_494d09a33a97fefb( var_66cc4d3d21a0ce0d )
{
    for ( x = 1; x <= 3 ; x++ )
    {
        if ( self.var_b02f6e7abbbc8a84[ x ] === var_66cc4d3d21a0ce0d )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bgb
// Params 1
// Checksum 0x3c79de7e, Offset: 0x5db3
// Size: 0x3d
function get_bgb_slot( var_66cc4d3d21a0ce0d )
{
    for ( x = 1; x <= 3 ; x++ )
    {
        if ( self.var_b02f6e7abbbc8a84[ x ] === var_66cc4d3d21a0ce0d )
        {
            return x;
        }
    }
}

// Namespace bgb
// Params 1
// Checksum 0xf9c0cf3b, Offset: 0x5df9
// Size: 0x19
function function_279d7169a70211bd( var_e97a4f4962bc3f25 )
{
    self setclientomnvar( "ui_gobblegum_slot_acquired_notify", var_e97a4f4962bc3f25 );
}

// Namespace bgb
// Params 1
// Checksum 0xb5b3a2e, Offset: 0x5e1a
// Size: 0x28
function function_94dc417dd511cefa( lootid )
{
    self setclientomnvar( "ui_gobblegum_splash", lootid );
    self setclientomnvar( "ui_gobblegum_splash_notify", gettime() );
}

// Namespace bgb
// Params 1
// Checksum 0x78feae38, Offset: 0x5e4a
// Size: 0xc4
function use_action_slot( var_e97a4f4962bc3f25 )
{
    self endon( #"disconnect" );
    self.var_f1dccd054c74a27e[ var_e97a4f4962bc3f25 ] = 1;
    bgb = self.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ];
    
    if ( function_a5d37b16547199e4( bgb, 1, var_e97a4f4962bc3f25 ) )
    {
        self notify( "bgb_activation" + var_e97a4f4962bc3f25, bgb );
        self.var_94750b503029583c = 0;
        self notify( #"hash_3dad25c07d2f05d4" );
        callback::callback( "on_gobblegum_used", { #var_e97a4f4962bc3f25:var_e97a4f4962bc3f25, #name:bgb } );
        function_b0af7e10a5498433( "zm_gobblegum_activated", bgb, var_e97a4f4962bc3f25 );
        give_slot( var_e97a4f4962bc3f25, bgb );
        wait 0.15;
        return;
    }
    
    self.var_f1dccd054c74a27e[ var_e97a4f4962bc3f25 ] = 0;
}

// Namespace bgb
// Params 1
// Checksum 0x9971c74, Offset: 0x5f16
// Size: 0x2f
function clear_action_slot( var_e97a4f4962bc3f25 )
{
    self.var_b02f6e7abbbc8a84[ var_e97a4f4962bc3f25 ] = undefined;
    self setclientomnvar( get_ui_slot_name( var_e97a4f4962bc3f25 ), level.var_d530db481b62eed2 );
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0x36618281, Offset: 0x5f4d
// Size: 0x55
function private get_ui_slot_name( var_e97a4f4962bc3f25 )
{
    switch ( var_e97a4f4962bc3f25 )
    {
        case 2:
            return "ui_gobblegum_slot_2";
        case 3:
            return "ui_gobblegum_slot_3";
        default:
            return "ui_gobblegum_slot_1";
    }
}

// Namespace bgb
// Params 1
// Checksum 0x31e3208b, Offset: 0x5faa
// Size: 0x67
function function_bc8c83873f4039ba( var_e97a4f4962bc3f25 )
{
    var_6123eea429d6e467 = undefined;
    
    switch ( var_e97a4f4962bc3f25 )
    {
        case 1:
            var_6123eea429d6e467 = "ui_gobblegum_slot_in_use_percent_1";
            break;
        case 2:
            var_6123eea429d6e467 = "ui_gobblegum_slot_in_use_percent_2";
            break;
        case 3:
            var_6123eea429d6e467 = "ui_gobblegum_slot_in_use_percent_3";
            break;
    }
    
    return var_6123eea429d6e467;
}

// Namespace bgb
// Params 1
// Checksum 0x8f52b3e3, Offset: 0x601a
// Size: 0x67
function function_aa94462478309658( var_e97a4f4962bc3f25 )
{
    var_3bd60cc6edafb960 = undefined;
    
    switch ( var_e97a4f4962bc3f25 )
    {
        case 1:
            var_3bd60cc6edafb960 = "ui_gobblegum_slot_in_use_1";
            break;
        case 2:
            var_3bd60cc6edafb960 = "ui_gobblegum_slot_in_use_2";
            break;
        case 3:
            var_3bd60cc6edafb960 = "ui_gobblegum_slot_in_use_3";
            break;
    }
    
    return var_3bd60cc6edafb960;
}

// Namespace bgb
// Params 1
// Checksum 0x6e939e61, Offset: 0x608a
// Size: 0xac
function get_gum_count( str_name )
{
    if ( !isdefined( self.gobblegumsAmount ) )
    {
        init_gobblegum_amount();
    }
    
    var_c2afe1a671205584 = getxhash( str_name );
    
    foreach ( var_d025f0a3f61f7f2a, n_count in self.gobblegumsAmount )
    {
        if ( var_c2afe1a671205584 == var_d025f0a3f61f7f2a )
        {
            return n_count;
        }
    }
    
    return 0;
}

// Namespace bgb
// Params 0, eflags: 0x4
// Checksum 0x73fd45c7, Offset: 0x613f
// Size: 0xdb
function private init_gobblegum_amount()
{
    if ( isdefined( self.gobblegumsAmount ) )
    {
        return;
    }
    
    self.gobblegumsAmount = [];
    
    for ( x = 0; x < 60 ; x++ )
    {
        str_gum = self getplayerdata( level.loadoutsgroup, "gobblegumsAmount", x, "name" );
        
        if ( !isdefined( str_gum ) || str_gum == "" )
        {
            continue;
        }
        
        n_count = self getplayerdata( level.loadoutsgroup, "gobblegumsAmount", x, "amount" );
        
        if ( n_count > 0 )
        {
            self.gobblegumsAmount[ str_gum ] = n_count;
            println( "<dev string:x53f>" + self.name + "<dev string:x548>" + getxhashsourcename( str_gum ) + "<dev string:x556>" + n_count + "<dev string:x569>" );
        }
    }
}

// Namespace bgb
// Params 1, eflags: 0x4
// Checksum 0xbcc0eb09, Offset: 0x6222
// Size: 0x149
function private on_gobblegum_changed( params )
{
    if ( params.var_fcb998a8bdd57c94.size )
    {
        foreach ( var_dd4cd334974cc578 in params.var_fcb998a8bdd57c94 )
        {
            function_c70812c5734a296d( var_dd4cd334974cc578.var_2f44e2e5ee5bf197, var_dd4cd334974cc578.count * -1 );
        }
    }
    
    if ( params.var_3986b2a4b47dd83d.size )
    {
        foreach ( grant in params.var_3986b2a4b47dd83d )
        {
            function_c70812c5734a296d( grant.var_2f44e2e5ee5bf197, grant.count );
        }
    }
}

// Namespace bgb
// Params 2, eflags: 0x4
// Checksum 0xb46ab8c6, Offset: 0x6373
// Size: 0x158
function private function_c70812c5734a296d( var_2f44e2e5ee5bf197, count )
{
    if ( isdefined( var_2f44e2e5ee5bf197 ) && isdefined( count ) && count != 0 )
    {
        str_gum = loot::function_f54ecb89dfab8e8c( var_2f44e2e5ee5bf197 );
        
        if ( !isdefined( str_gum ) )
        {
            msg = "Error: [PlayerAchievementCustomPushMessage] Failed to get gobblegum name from loot ID [" + var_2f44e2e5ee5bf197 + "]. Failed to update gobblegum amount in game and record the gobblegum dlog.";
            logstring( msg );
            assertmsg( msg );
            return;
        }
        
        hash_gum = isxhash( str_gum ) ? str_gum : getxhash( str_gum );
        
        if ( !isdefined( self.gobblegumsAmount[ hash_gum ] ) )
        {
            self.gobblegumsAmount[ hash_gum ] = 0;
        }
        
        self.gobblegumsAmount[ hash_gum ] += count;
        callback::callback( "gobblegum_changed", { #var_aa835dbce8ed5712:self.gobblegumsAmount[ hash_gum ], #count:count, #var_2f44e2e5ee5bf197:var_2f44e2e5ee5bf197, #gobblegum:hash_gum } );
        
        /#
            str_name = isxhash( str_gum ) ? getxhashsourcename( str_gum ) : str_gum;
            println( "<dev string:x53f>" + self.name + "<dev string:x548>" + str_name + "<dev string:x56c>" + count + "<dev string:x569>" );
        #/
    }
}

// Namespace bgb
// Params 3
// Checksum 0x20d04fc4, Offset: 0x64d3
// Size: 0xe7
function function_b0af7e10a5498433( splashname, bgb, var_e97a4f4962bc3f25 )
{
    if ( isdefined( level.gobblegums ) )
    {
        index = level.gobblegums[ getxhash( bgb ) ].index;
        
        if ( index != level.var_d530db481b62eed2 )
        {
            foreach ( player in level.players )
            {
                player thread hud_message::showsplash( splashname, index, self );
            }
            
            self setclientomnvar( "ui_gobblegum_slot_activated_notify", var_e97a4f4962bc3f25 );
        }
    }
}

// Namespace bgb
// Params 2
// Checksum 0x34b389b, Offset: 0x65c2
// Size: 0x65
function function_4f13eb3f058c04e5( bgb, var_54e62ba1ea9686c8 = #"hash_1cc194546923aa0c" )
{
    index = level.gobblegums[ getxhash( bgb ) ].index;
    
    if ( index != level.var_d530db481b62eed2 )
    {
        thread hud_message::showsplash( var_54e62ba1ea9686c8, index, self );
    }
}

// Namespace bgb
// Params 1
// Checksum 0xe1a4a3db, Offset: 0x662f
// Size: 0xa0
function function_9a379c43e82c78cd( splashname = "zm_bgb_restricted_removed" )
{
    if ( !level.var_85c21b354abbcadd )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( splashname );
    }
}

