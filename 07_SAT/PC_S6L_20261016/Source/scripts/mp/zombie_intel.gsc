// scripts\mp\zombie_intel.gsc  (hash_04c1c79908638037.gscc) (size: 17926 Bytes / 0x4606 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77485e53 (2001231443)
// size ...... 17926 (0x4606)
// includes .. 13  (offset: 0x427e)
// strings ... 26  (offset: 0x42e6)
// dev strs .. 36  (offset: 0x4446)
// exports ... 31  (offset: 0x2cbe)
// cseg ...... 0x241 + 0x2a7d (0x2cbe)
// imports ... 138 (offset: 0x3196)
// animtree1 . 0   (offset: 0x4606)
// animtree2 . 0   (offset: 0x4606)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\intel;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;

#namespace intel;

// Namespace intel
// Params 0, eflags: 0x5
// Checksum 0xe24a34f1, Offset: 0x25f
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zombie_intel", #"intel", &zmpreinit, &zmpostinit );
}

// Namespace intel
// Params 0
// Checksum 0x28cfdb69, Offset: 0x28c
// Size: 0x95
function zmpreinit()
{
    if ( !is_intel_enabled() )
    {
        return;
    }
    
    function_c1df74e26817e678( game_utility::getmapname() );
    callback::add( #"player_connect", &function_1c077eb1ecd1777e );
    callback::add( #"player_disconnect", &on_disconnect );
    callback::add( #"player_spawned", &function_f556df84f573f3b5 );
    utility::registersharedfunc( #"intel", #"collect_intel", &zm_collect_intel );
    utility::registersharedfunc( #"intel", #"hash_e95998f599062eec", &function_785e4b26cccb3955 );
}

// Namespace intel
// Params 0
// Checksum 0xac6c969d, Offset: 0x329
// Size: 0x7e
function zmpostinit()
{
    if ( !is_intel_enabled() )
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    waittillframeend();
    level thread spawn_intel_at_start();
    
    /#
        level thread zm_intel_devgui();
    #/
    
    utility::registersharedfunc( #"intel", #"get_intel_collected", &function_3785d1a8cfde0196 );
    utility::registersharedfunc( #"intel", #"set_intel_collected", &function_45e54c5e25f5957a );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_f3b5cabd9ba10c27", &function_facdfefc1c0f0318 );
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0x42f4a04b, Offset: 0x3af
// Size: 0x38, Type: bool
function private function_3785d1a8cfde0196( str_intel )
{
    return self getplayerdata( level.var_6f9b00680ed002d8, "zombieIntel", str_intel ) || arraycontains( self.var_494c972f36b38d9e, getxhash( str_intel ) );
}

// Namespace intel
// Params 2, eflags: 0x4
// Checksum 0x11ab482d, Offset: 0x3f0
// Size: 0x2b
function private function_45e54c5e25f5957a( str_intel, value )
{
    return self setplayerdata( level.var_6f9b00680ed002d8, "zombieIntel", str_intel, value );
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0x4ba4adb2, Offset: 0x424
// Size: 0x39, Type: bool
function private is_in_current_season( s_intel )
{
    if ( !isdefined( s_intel.season ) || s_intel.season <= level.var_1929d52bee550c97 )
    {
        return true;
    }
    
    return false;
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0xcfbf1b80, Offset: 0x466
// Size: 0x51
function private function_1c077eb1ecd1777e( params )
{
    self.var_494c972f36b38d9e = [];
    self.var_1da75b5b0386a82 = [];
    
    if ( !isdefined( self.var_cf7679a4425c10b3 ) )
    {
        self.var_cf7679a4425c10b3 = 0;
    }
    
    utility::callsharedfunc( #"intel", #"post_player_on_connect", params );
}

// Namespace intel
// Params 1, eflags: 0x4
// Checksum 0xf8894a50, Offset: 0x4bf
// Size: 0x1ff
function private on_disconnect( params )
{
    if ( isarray( self.var_1da75b5b0386a82 ) )
    {
        foreach ( e_intel_sound in self.var_1da75b5b0386a82 )
        {
            if ( isdefined( e_intel_sound ) )
            {
                e_intel_sound delete();
            }
        }
    }
    
    self.var_1da75b5b0386a82 = undefined;
    
    if ( level.var_d269a296de42db6b )
    {
        foreach ( s_intel_location in level.var_d269a296de42db6b )
        {
            if ( isstruct( s_intel_location ) )
            {
                if ( isarray( s_intel_location.a_mdl_intel ) )
                {
                    foreach ( mdl_intel in s_intel_location.a_mdl_intel )
                    {
                        if ( mdl_intel.owningplayer == self )
                        {
                            mdl_intel freescriptable();
                        }
                    }
                    
                    s_intel_location.a_mdl_intel = function_5713d46873b29625( s_intel_location.a_mdl_intel );
                }
            }
        }
    }
    
    if ( level.var_bb461868542d6ed3 )
    {
        level.var_bb461868542d6ed3 = function_5713d46873b29625( level.var_bb461868542d6ed3 );
    }
}

// Namespace intel
// Params 1
// Checksum 0x89b3ff77, Offset: 0x6c6
// Size: 0xd6
function function_f556df84f573f3b5( params )
{
    if ( utility::flag( "spawn_intel_at_start_complete" ) && !self.var_b11b148d61fd3147 )
    {
        foreach ( s_intel_loc in level.var_d269a296de42db6b )
        {
            if ( isstruct( s_intel_loc ) )
            {
                if ( isdefined( s_intel_loc.str_intel_name ) )
                {
                    spawn_intel_at_location( s_intel_loc, undefined, undefined, undefined, undefined, s_intel_loc.v_landing );
                }
            }
        }
    }
    
    self.var_b11b148d61fd3147 = 1;
}

// Namespace intel
// Params 2
// Checksum 0x6c4bcc60, Offset: 0x7a4
// Size: 0x2c
function function_6ba0f4cc512549dc( itembundlename, func )
{
    level.var_14030c25357c4890[ itembundlename ] = func ?? &function_bbcaa0902ce64bf9;
}

// Namespace intel
// Params 1
// Checksum 0x18758e99, Offset: 0x7d8
// Size: 0x58
function function_bbcaa0902ce64bf9( spawnoptions )
{
    spawnoptions.var_c580c0e8b49f1fcc = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.cleanupdisabled = 1;
    spawnoptions.critical = 1;
    spawnoptions.var_4a4b419f66681601 = [ self ];
    return spawnoptions;
}

// Namespace intel
// Params 0
// Checksum 0x8236fe52, Offset: 0x839
// Size: 0xb1
function spawn_intel_at_start()
{
    if ( utility::flag_exist( "begin_round_logic" ) )
    {
        utility::flag_wait( "begin_round_logic" );
    }
    
    foreach ( s_intel_loc in level.var_d269a296de42db6b )
    {
        if ( !isdefined( s_intel_loc.a_mdl_intel ) )
        {
            spawn_intel_at_location( s_intel_loc );
        }
    }
    
    utility::flag_set( "spawn_intel_at_start_complete" );
}

// Namespace intel
// Params 1
// Checksum 0xebc60d5a, Offset: 0x8f2
// Size: 0x92
function function_26a590a81bb1e5af( player )
{
    if ( player.interactions_disabled )
    {
        return;
    }
    
    switch ( self.s_intel.inteltype )
    {
        case #"audiolog":
            break;
        case #"Document":
            break;
        case #"artifact":
            break;
    }
    
    if ( !isdefined( str_intel_name ) )
    {
        str_intel_name = self.s_intel.ref;
    }
    
    player thread zm_collect_intel( str_intel_name, self );
}

// Namespace intel
// Params 4, eflags: 0x4
// Checksum 0xb159152a, Offset: 0x98c
// Size: 0x4d5
function private zm_collect_intel( str_intel_name, mdl_intel, e_sound_source, b_skip_audio = 0 )
{
    player = self;
    s_intel = mdl_intel.s_intel ?? level.var_b15dba0426867c77[ getxhash( str_intel_name ) ];
    
    if ( player player_has_intel( str_intel_name ) )
    {
        if ( mdl_intel.var_7c9b22441aa0927b )
        {
            level notify( #"intel_played", str_intel_name );
            player callback::callback( #"hash_4228c0dfe35c7523", { #s_intel:s_intel, #mdl_intel:mdl_intel, #str_intel_name:str_intel_name } );
            
            if ( !isdefined( mdl_intel.owningplayer ) || mdl_intel.owningplayer == player )
            {
                mdl_intel disablescriptableplayeruse( player );
            }
            
            player function_6a62df1b25709a7a( s_intel, e_sound_source ?? mdl_intel );
            
            if ( isplayer( player ) )
            {
                player callback::callback( #"hash_875577910e58057b", { #mdl_intel:mdl_intel, #str_intel_name:str_intel_name } );
            }
            
            if ( isdefined( mdl_intel ) && isdefined( player ) && ( !isdefined( mdl_intel.owningplayer ) || mdl_intel.owningplayer == player ) )
            {
                mdl_intel enablescriptableplayeruse( player );
            }
            
            return;
        }
        
        if ( isdefined( mdl_intel ) && mdl_intel isscriptableinstance() && !mdl_intel.b_ignore_delete )
        {
            mdl_intel function_708fc834ab7190d8( player );
        }
        
        return;
    }
    
    /#
        var_b77051a4f72b5b81 = getarraykeys( level.var_b15dba0426867c77 );
        assert( arraycontains( var_b77051a4f72b5b81, getxhash( str_intel_name ) ), getxhashsourcename( str_intel_name ) + "<dev string:x24>" );
    #/
    
    if ( isdefined( mdl_intel ) )
    {
        mdl_intel disablescriptableplayeruse( player );
    }
    
    player set_intel_stat( str_intel_name );
    str_intel_name = getxhash( str_intel_name );
    player playrumbleonentity( "damage_heavy" );
    player.var_494c972f36b38d9e = arraycombineunique( player.var_494c972f36b38d9e, [ str_intel_name ] );
    level notify( #"intel_collected", str_intel_name );
    player notify( #"intel_collected", str_intel_name );
    player callback::callback( #"hash_476fcd5501956e2c", { #s_intel:s_intel, #mdl_intel:mdl_intel, #str_intel_name:str_intel_name } );
    type_index = 0;
    
    switch ( s_intel.inteltype )
    {
        case #"audiolog":
            type_index = 0;
            
            if ( isdefined( mdl_intel ) )
            {
                mdl_intel utility::function_7c10ea82c1e305b8( str_intel_name, "collected" );
            }
            
            level notify( #"intel_played", str_intel_name );
            player callback::callback( #"hash_4228c0dfe35c7523", { #s_intel:s_intel, #mdl_intel:mdl_intel, #str_intel_name:str_intel_name } );
            break;
        case #"Document":
            type_index = 1;
            break;
        case #"artifact":
            type_index = 2;
            break;
    }
    
    player setclientomnvar( "collected_intel_type", type_index );
    player thread hud_message::showsplash( "zm_intel_splash" );
    var_9a9ea5863769a026 = mdl_intel && mdl_intel isscriptableinstance() && !mdl_intel getscriptableisreserved();
    
    if ( var_9a9ea5863769a026 )
    {
        newitembundle = getscriptbundle( mdl_intel.s_intel.itemspawnentry );
        itemdata = common_item::function_a48ae6cbf7e8c2d5( mdl_intel );
        player common_item::function_2e0436a8625e3515( newitembundle, 1, itemdata );
    }
    
    currentprogress = player function_54b709e97f690761();
    totalprogress = level.var_34153452a8dfb6e2;
    
    /#
        iprintln( "<dev string:x43>" + player getentitynumber() + "<dev string:x4b>" + getxhashsourcename( str_intel_name ) );
    #/
    
    level.var_5e8c1b99eb6194bb[ str_intel_name ][ player.name ] = 1;
    
    if ( !b_skip_audio )
    {
        player function_6a62df1b25709a7a( s_intel, e_sound_source ?? mdl_intel );
        
        if ( isplayer( player ) )
        {
            player callback::callback( #"hash_875577910e58057b", { #mdl_intel:mdl_intel, #str_intel_name:str_intel_name } );
        }
    }
    
    if ( isplayer( player ) )
    {
        level.var_5e8c1b99eb6194bb[ str_intel_name ][ player.name ] = undefined;
    }
    
    if ( isdefined( mdl_intel ) && isdefined( player ) )
    {
        if ( mdl_intel.var_7c9b22441aa0927b )
        {
            mdl_intel enablescriptableplayeruse( player );
        }
        else if ( var_9a9ea5863769a026 )
        {
            waitframe();
            mdl_intel enablescriptableplayeruse( player );
        }
    }
    
    if ( isdefined( mdl_intel ) && !mdl_intel.b_ignore_delete )
    {
        if ( mdl_intel.var_7a65426f252841e7 || function_1ba3132f2aafe8cc( str_intel_name ) )
        {
            mdl_intel function_708fc834ab7190d8( player );
        }
    }
}

// Namespace intel
// Params 1
// Checksum 0xd39082da, Offset: 0xe69
// Size: 0x75
function function_708fc834ab7190d8( player )
{
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isplayer( player ) )
    {
        self disablescriptableplayeruse( player );
    }
    
    calloutmarkerping::function_608710c894185549();
    self notify( #"death" );
    
    if ( self getscriptableisreserved() )
    {
        level.var_bb461868542d6ed3 = arrayremove( level.var_bb461868542d6ed3, self );
        self freescriptable();
        return;
    }
    
    utility::function_7c10ea82c1e305b8( self.type, "hidden" );
}

// Namespace intel
// Params 2
// Checksum 0x19c7592e, Offset: 0xee6
// Size: 0x20c
function intel_per_player_hint( usable, player )
{
    if ( player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( isdefined( usable.s_intel.ref ) && player player_has_intel( usable.s_intel.ref ) && !usable.var_7c9b22441aa0927b )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( isdefined( usable.s_intel.inteltype ) )
    {
        switch ( usable.s_intel.inteltype )
        {
            case #"audiolog":
                intel_icon = "ui_icon_zm_ping_door_buy";
                intel_title = &"ZOMBIE_INTEL/AUDIOLOG_USE";
                intel_action = &"ZOMBIE_INTEL/PLAY";
                break;
            case #"Document":
                intel_icon = "ui_icon_zm_ping_door_buy";
                intel_title = &"ZOMBIE_INTEL/DOCUMENT_USE";
                intel_action = &"ZOMBIE_INTEL/PICK_UP";
                break;
            case #"artifact":
                intel_icon = "ui_icon_zm_ping_door_buy";
                intel_title = &"ZOMBIE_INTEL/ARTIFACT_USE";
                intel_action = &"ZOMBIE_INTEL/PICK_UP";
                break;
        }
        
        obj = { #icon:intel_icon, #description:usable.s_intel.title, #title:intel_title, #buttoncallout:intel_action, #string:intel_action, #type:"HINT_BUTTON" };
        return obj;
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace intel
// Params 7
// Checksum 0x42b1976b, Offset: 0x10fb
// Size: 0x83d
function spawn_intel_at_location( s_intel_loc, str_targetname, v_pos, v_ang, str_intel_name, v_landing, var_1da057ed47f25cec = 0 )
{
    if ( !is_intel_enabled() )
    {
        return;
    }
    
    if ( isdefined( str_targetname ) )
    {
        s_intel_loc = utility::getstruct( str_targetname, "targetname" );
    }
    else if ( isdefined( v_pos ) && isdefined( v_ang ) )
    {
        var_d981cebbe5db0ec0 = level.gametypebundle.inteltag;
        
        if ( !isdefined( var_d981cebbe5db0ec0 ) )
        {
            var_d981cebbe5db0ec0 = "zombie_intel";
        }
        
        s_intel_loc = { #script_noteworthy:var_d981cebbe5db0ec0, #angles:v_ang, #origin:v_pos };
        level.var_d269a296de42db6b[ level.var_d269a296de42db6b.size ] = s_intel_loc;
    }
    
    if ( !isdefined( s_intel_loc ) )
    {
        return;
    }
    
    if ( !isdefined( s_intel_loc.str_intel_name ) )
    {
        s_intel_loc.str_intel_name = str_intel_name ?? s_intel_loc.script_string;
    }
    
    if ( !is_intel_valid( s_intel_loc.str_intel_name ) )
    {
        return;
    }
    
    s_intel_loc.str_intel_type = level.var_b15dba0426867c77[ getxhash( s_intel_loc.str_intel_name ) ].inteltype;
    s_intel = level.var_b15dba0426867c77[ getxhash( s_intel_loc.str_intel_name ) ];
    
    if ( !isdefined( s_intel_loc.a_mdl_intel ) )
    {
        s_intel_loc.a_mdl_intel = [];
    }
    
    var_af3dbcd37ee30a3 = [];
    
    if ( isstruct( s_intel_loc ) )
    {
        var_d5e0991d50120446 = [];
        
        foreach ( player in level.players )
        {
            if ( !player player_has_intel( s_intel_loc.str_intel_name ) || var_1da057ed47f25cec )
            {
                if ( isarray( s_intel_loc.a_mdl_intel ) )
                {
                    var_a9cce3f832f17ca8 = 0;
                    
                    foreach ( mdl_intel in s_intel_loc.a_mdl_intel )
                    {
                        if ( mdl_intel.var_7a65426f252841e7 && mdl_intel.owningplayer === player )
                        {
                            var_a9cce3f832f17ca8 = 1;
                        }
                    }
                    
                    if ( !var_a9cce3f832f17ca8 )
                    {
                        var_d5e0991d50120446[ var_d5e0991d50120446.size ] = player;
                    }
                    
                    continue;
                }
                
                var_d5e0991d50120446[ var_d5e0991d50120446.size ] = player;
            }
        }
        
        if ( !var_d5e0991d50120446.size )
        {
            return;
        }
        
        if ( isdefined( v_landing ) )
        {
            /#
                sphere( s_intel_loc.origin, 8, ( 1, 1, 1 ), undefined, 200 );
                line( s_intel_loc.origin, v_landing, ( 1, 1, 1 ), 1, undefined, 200 );
                sphere( v_landing, 8, ( 1, 1, 1 ), undefined, 200 );
            #/
        }
        
        if ( isdefined( s_intel.itemspawnentry ) )
        {
            itembundle = getscriptbundle( s_intel.itemspawnentry );
            
            if ( isdefined( v_landing ) )
            {
                spawnoptions = common_item::function_f5dfaa3bbdf99a33( v_landing, s_intel_loc.origin, s_intel_loc.angles );
            }
            else
            {
                spawnoptions = common_item::function_bc5ff2958b71a708( s_intel_loc.origin, s_intel_loc.angles );
            }
            
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.var_c580c0e8b49f1fcc = 1;
            spawnoptions.critical = 1;
            spawnoptions.cleanupdisabled = 1;
            spawnoptions.var_4a4b419f66681601 = var_d5e0991d50120446;
            var_af3dbcd37ee30a3 = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
            
            if ( !isarray( var_af3dbcd37ee30a3 ) )
            {
                var_af3dbcd37ee30a3 = [ var_af3dbcd37ee30a3 ];
            }
            
            s_intel_loc.a_mdl_intel = arraycombineunique( s_intel_loc.a_mdl_intel, var_af3dbcd37ee30a3 );
            s_intel_loc.mdl_intel = s_intel_loc.a_mdl_intel[ 0 ];
        }
        else
        {
            assertmsg( "<dev string:x57>" + s_intel_loc.str_intel_name );
        }
        
        if ( isdefined( v_landing ) )
        {
            s_intel_loc.v_landing = v_landing;
        }
    }
    else
    {
        s_intel_loc utility::function_7c10ea82c1e305b8( s_intel_loc.type, "visible" );
        s_intel_loc.var_fd47e835523b473f = 1;
        s_intel_loc.critical = 1;
        s_intel_loc.cleanupdisabled = 1;
        s_intel_loc.b_ignore_delete = 1;
        var_af3dbcd37ee30a3 = [ s_intel_loc ];
        s_intel_loc.a_mdl_intel = arraycombineunique( s_intel_loc.a_mdl_intel, var_af3dbcd37ee30a3 );
        s_intel_loc.mdl_intel = s_intel_loc.a_mdl_intel[ 0 ];
    }
    
    if ( s_intel_loc.str_intel_type == #"audiolog" && var_1da057ed47f25cec )
    {
        if ( isarray( s_intel_loc.a_mdl_intel ) )
        {
            foreach ( mdl_intel in s_intel_loc.a_mdl_intel )
            {
                mdl_intel.var_7c9b22441aa0927b = 1;
            }
        }
        else
        {
            s_intel_loc.mdl_intel.var_7c9b22441aa0927b = 1;
        }
    }
    
    if ( isarray( s_intel_loc.a_mdl_intel ) )
    {
        level.var_bb461868542d6ed3 = arraycombineunique( level.var_bb461868542d6ed3, s_intel_loc.a_mdl_intel );
        
        foreach ( mdl_intel in s_intel_loc.a_mdl_intel )
        {
            if ( isdefined( mdl_intel ) )
            {
                mdl_intel.s_intel = s_intel;
                mdl_intel set_intel_draggable( 0 );
            }
        }
    }
    
    foreach ( mdl_intel_new in var_af3dbcd37ee30a3 )
    {
        entnum = isdefined( mdl_intel_new.owningplayer ) ? mdl_intel_new.owningplayer getentitynumber() : "none";
        logstring( "====Intel Spawned: " + s_intel_loc.str_intel_name + " at " + s_intel_loc.origin + " at time " + gettime() + " for owning player " + entnum );
    }
    
    if ( s_intel.inteltype == #"audiolog" )
    {
        if ( isarray( s_intel_loc.a_mdl_intel ) )
        {
            foreach ( mdl_intel in s_intel_loc.a_mdl_intel )
            {
                mdl_intel.b_ignore_delete = 1;
            }
        }
    }
    
    return s_intel_loc;
}

// Namespace intel
// Params 1
// Checksum 0x31853608, Offset: 0x1941
// Size: 0x21
function set_intel_draggable( b_draggable = 1 )
{
    self.disable_dragged = !b_draggable;
}

// Namespace intel
// Params 2
// Checksum 0x54a0dcd2, Offset: 0x196a
// Size: 0x583
function function_6a62df1b25709a7a( s_intel, e_sound_source = self )
{
    str_intel_name = s_intel.ref;
    self endon( #"hash_497eab2ef470d568" );
    
    if ( self issplitscreenplayer() )
    {
        foreach ( other_player in level.players )
        {
            if ( self === other_player )
            {
                continue;
            }
            
            if ( self getothersplitscreenplayer() === other_player && level.var_5e8c1b99eb6194bb[ str_intel_name ][ other_player.name ] )
            {
                var_19b07e0e97e87ea4 = 1;
                break;
            }
        }
    }
    
    if ( isarray( e_sound_source.var_fbb0bf1ffd339091 ) && e_sound_source.var_fbb0bf1ffd339091.size )
    {
        foreach ( var_9370c106aae0d55b in e_sound_source.var_fbb0bf1ffd339091 )
        {
            e_sound_source stopsounds();
        }
        
        e_sound_source.var_fbb0bf1ffd339091 = [];
    }
    
    if ( isdefined( e_sound_source.origin ) && ( e_sound_source utility::function_de1f80d93273abf5() && !e_sound_source getscriptableparthasstate( "audio", "on" ) || !e_sound_source utility::function_de1f80d93273abf5() ) )
    {
        playsoundatpos( e_sound_source.origin + ( 0, 0, 50 ), #"hash_b3c22ae8343ee2b5" );
    }
    
    b_played_audio = e_sound_source utility::function_7c10ea82c1e305b8( "audio", "on" );
    
    if ( b_played_audio )
    {
        wait 1;
    }
    
    if ( isarray( s_intel.var_eda3378ac504bc39 ) && s_intel.var_eda3378ac504bc39.size )
    {
        foreach ( var_5dbf98f197b02dc9 in s_intel.var_eda3378ac504bc39 )
        {
            if ( !isdefined( var_5dbf98f197b02dc9.alias ) )
            {
                assertmsg( "<dev string:x86>" + getxhashsourcename( s_intel.ref ) );
                continue;
            }
            
            if ( !soundexists( var_5dbf98f197b02dc9.alias ) )
            {
                assertmsg( "<dev string:xa7>" + getxhashsourcename( var_5dbf98f197b02dc9.alias ) + "<dev string:xb4>" + getxhashsourcename( s_intel.ref ) + "<dev string:xb9>" );
                continue;
            }
            
            if ( !isplayer( self ) )
            {
                break;
            }
            
            b_played_audio = 1;
            
            if ( isdefined( var_5dbf98f197b02dc9.delaybefore ) )
            {
                wait var_5dbf98f197b02dc9.delaybefore;
            }
            
            if ( !isplayer( self ) )
            {
                break;
            }
            
            if ( !isdefined( self.var_1da75b5b0386a82[ str_intel_name ] ) )
            {
                self.var_1da75b5b0386a82[ str_intel_name ] = utility::spawn_tag_origin( e_sound_source.origin, e_sound_source.angles );
            }
            
            self.var_1da75b5b0386a82[ str_intel_name ].origin = e_sound_source.origin;
            self.var_1da75b5b0386a82[ str_intel_name ].angles = e_sound_source.angles;
            n_wait = utility::function_6f5d2e1f1ff70482( lookupsoundlength( var_5dbf98f197b02dc9.alias, 1 ) );
            n_wait_buffer = 0.5;
            
            if ( isdefined( var_5dbf98f197b02dc9.waittimeoverride ) )
            {
                n_wait = var_5dbf98f197b02dc9.waittimeoverride;
                n_wait_buffer = 0;
            }
            else if ( isdefined( var_5dbf98f197b02dc9.waittimenegative ) )
            {
                n_wait -= var_5dbf98f197b02dc9.waittimenegative;
                n_wait_buffer = 0;
            }
            
            namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( var_5dbf98f197b02dc9.alias, self, self.var_1da75b5b0386a82[ str_intel_name ] );
            
            foreach ( other_player in level.players )
            {
                if ( other_player == self )
                {
                    continue;
                }
                
                if ( other_player getspectatingplayer() == self )
                {
                    other_player namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( var_5dbf98f197b02dc9.alias, other_player, self.var_1da75b5b0386a82[ str_intel_name ] );
                }
            }
            
            wait max( n_wait + n_wait_buffer, 0 );
            
            if ( isdefined( var_5dbf98f197b02dc9.delayafter ) )
            {
                wait var_5dbf98f197b02dc9.delayafter;
            }
        }
        
        if ( isdefined( self.var_1da75b5b0386a82[ str_intel_name ] ) )
        {
            self.var_1da75b5b0386a82[ str_intel_name ] delete();
        }
    }
    
    if ( isdefined( e_sound_source ) )
    {
        e_sound_source utility::function_7c10ea82c1e305b8( "audio", "off" );
    }
    
    if ( b_played_audio )
    {
        waitframe();
    }
}

// Namespace intel
// Params 1
// Checksum 0x38e5bcdf, Offset: 0x1ef5
// Size: 0x105
function function_5ac74c7d9763e7d7( str_intel_type )
{
    if ( isdefined( level.var_a2d1850dcd377888 ) )
    {
        str_intel_name = level.var_a2d1850dcd377888;
        level.var_a2d1850dcd377888 = undefined;
        return str_intel_name;
    }
    
    a_s_intel = get_intel_list( str_intel_type );
    
    if ( !isarray( a_s_intel ) || !a_s_intel.size )
    {
        println( "<dev string:xdd>" + getxhashsourcename( str_intel_type ) + "<dev string:xfc>" );
        return;
    }
    
    foreach ( s_intel in a_s_intel )
    {
        if ( !player_has_intel( s_intel.ref ) )
        {
            return s_intel.ref;
        }
    }
}

// Namespace intel
// Params 1
// Checksum 0xa0aadf4, Offset: 0x2002
// Size: 0xa0, Type: bool
function function_39bf7a56e562b1d4( str_intel_type )
{
    a_s_intel = get_intel_list( str_intel_type );
    
    foreach ( s_intel in a_s_intel )
    {
        if ( !player_has_intel( s_intel.ref ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace intel
// Params 0, eflags: 0x4
// Checksum 0x82c70dee, Offset: 0x20ab
// Size: 0x22d
function private function_45e5ea91f4e97980()
{
    if ( level.zm_intel_type.size > 0 )
    {
        return level.zm_intel_type;
    }
    
    zm_intel_type = [];
    zm_intel_type[ #"zmintel_t10_quartz_document_3" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_3" );
    zm_intel_type[ #"zmintel_t10_quartz_document_4" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_4" );
    zm_intel_type[ #"zmintel_t10_quartz_document_5" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_5" );
    zm_intel_type[ #"zmintel_t10_quartz_document_6" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_6" );
    zm_intel_type[ #"zmintel_t10_quartz_artifact_1" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_artifact_1" );
    zm_intel_type[ #"zmintel_t10_quartz_audiolog_2" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_audiolog_2" );
    zm_intel_type[ #"zmintel_t10_quartz_audiolog_5" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_audiolog_5" );
    zm_intel_type[ #"zmintel_t10_quartz_audiolog_6" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_audiolog_6" );
    zm_intel_type[ #"zmintel_t10_quartz_audiolog_9" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_audiolog_9" );
    zm_intel_type[ #"zmintel_t10_quartz_audiolog_14" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_audiolog_14" );
    zm_intel_type[ #"zmintel_t10_quartz_audiolog_15" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_audiolog_15" );
    zm_intel_type[ #"zmintel_t10_quartz_document_1" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_1" );
    zm_intel_type[ #"zmintel_t10_quartz_document_7" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_7" );
    zm_intel_type[ #"zmintel_t10_quartz_document_10" ] = ae_utility::function_2d1565a236387b2( #"zm_intel_bitfield", #"zmintel_t10_quartz_document_10" );
    level.zm_intel_type = zm_intel_type;
    return zm_intel_type;
}

// Namespace intel
// Params 2
// Checksum 0x36bac9d8, Offset: 0x22e1
// Size: 0x1dc
function function_785e4b26cccb3955( player, intel )
{
    if ( !challenges::challengesenabled() )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_eba284bc321f1afe", 1 ) == 0 )
    {
        return;
    }
    
    str_intel_name = getxhash( intel.str_intel_name );
    var_34c2be1201c6ab0c = function_45e5ea91f4e97980();
    intel_bit = challenges::function_a23641f33e985edb( 0, var_34c2be1201c6ab0c[ str_intel_name ] );
    aeeventname = #"zm_intel_collect";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    gamemode = challenges::getchallengegamemode();
    gametype = challenges::function_9edd00e9e48c0821();
    
    if ( intel.mdl_intel )
    {
        lootid = common_item::function_6d301ac91c3cd13d( intel.mdl_intel );
    }
    
    if ( !isdefined( lootid ) && isdefined( intel.s_intel.ref ) )
    {
        lootid = common_item::items_getlootidfromref( intel.s_intel.ref );
    }
    
    if ( !isdefined( lootid ) )
    {
        script::demoforcesre( "Failed to get intel '" + intel.str_intel_name + "' lootID for AE Event '" + aeeventname + "'. This is bad, it means players will lose this progression data!" );
    }
    
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_intel_bitfield" ) ] = intel_bit;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid;
    player function_2e45314624fdfdb8( aeeventid, eventparams );
}

/#

    // Namespace intel
    // Params 0, eflags: 0x4
    // Checksum 0xfd91f9a8, Offset: 0x24c5
    // Size: 0x16a, Type: dev
    function private zm_intel_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:xfe>" );
        devgui::add_devgui_func( "<dev string:x108>", "<dev string:x114>", &function_36123c5b7dbaacc6, 1 );
        devgui::add_devgui_func( "<dev string:x126>", "<dev string:x143>", &function_2b260f506e11eb53 );
        
        foreach ( hash_intel_name, s_intel in level.var_b15dba0426867c77 )
        {
            str_intel_name = getxhashsourcename( hash_intel_name );
            devgui::function_cd4e263c1f3018ae( "<dev string:x157>" + str_intel_name, "<dev string:x160>" + str_intel_name, &devgui_collect_intel );
            devgui::function_cd4e263c1f3018ae( "<dev string:x16f>" + str_intel_name, "<dev string:x178>" + str_intel_name, &function_d2c473df0dd4eda );
            devgui::function_cd4e263c1f3018ae( "<dev string:x187>" + str_intel_name, "<dev string:x1a3>" + str_intel_name, &function_31e333b5f6ee4eab );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1b5>" + str_intel_name + "<dev string:x1ce>", "<dev string:x1db>" + str_intel_name + "<dev string:x1f4>", &function_192ead4142aa07e8 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1b5>" + str_intel_name + "<dev string:x200>", "<dev string:x1db>" + str_intel_name + "<dev string:x208>", &function_192ead4142aa07e8 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace intel
    // Params 0, eflags: 0x4
    // Checksum 0xe324d564, Offset: 0x2637
    // Size: 0xfd, Type: dev
    function private function_2b260f506e11eb53()
    {
        foreach ( hash_intel_name, s_intel in level.var_b15dba0426867c77 )
        {
            str_intel_name = getxhashsourcename( hash_intel_name );
            
            foreach ( player in level.players )
            {
                player thread zm_collect_intel( str_intel_name );
            }
        }
    }

    // Namespace intel
    // Params 1, eflags: 0x4
    // Checksum 0xe7d3806e, Offset: 0x273c
    // Size: 0xe1, Type: dev
    function private devgui_collect_intel( params )
    {
        str_intel_name = params[ 0 ];
        
        foreach ( s_intel_loc in level.var_d269a296de42db6b )
        {
            if ( s_intel_loc.str_intel_name === str_intel_name && isdefined( s_intel_loc.mdl_intel ) )
            {
                level.players[ 0 ] thread zm_collect_intel( str_intel_name, s_intel_loc.mdl_intel );
                return;
            }
        }
        
        level.players[ 0 ] thread zm_collect_intel( str_intel_name );
    }

    // Namespace intel
    // Params 1, eflags: 0x4
    // Checksum 0x2e5879b0, Offset: 0x2825
    // Size: 0xd2, Type: dev
    function private function_192ead4142aa07e8( params )
    {
        str_intel_name = params[ 0 ];
        player = level.players[ 0 ];
        v_start = player geteye();
        v_ground = player.origin + anglestoforward( player getplayerangles() ) * 100;
        v_ground = getgroundposition( v_ground + ( 0, 0, 8 ), 32 ) + ( 0, 0, 0.5 );
        
        if ( params[ 1 ] == "<dev string:x210>" )
        {
            spawn_intel_at_location( undefined, undefined, v_start, player.angles, str_intel_name, v_ground, 1 );
            return;
        }
        
        spawn_intel_at_location( undefined, undefined, v_ground, player.angles, str_intel_name, undefined, 1 );
    }

    // Namespace intel
    // Params 1, eflags: 0x4
    // Checksum 0xb77ec900, Offset: 0x28ff
    // Size: 0x12e, Type: dev
    function private function_d2c473df0dd4eda( params )
    {
        str_intel_name = params[ 0 ];
        
        foreach ( s_intel_loc in level.var_d269a296de42db6b )
        {
            if ( s_intel_loc.str_intel_name === str_intel_name && isdefined( s_intel_loc.mdl_intel ) )
            {
                v_pos = getclosestpointonnavmesh( s_intel_loc.origin );
                
                if ( isdefined( v_pos ) )
                {
                    level.players[ 0 ] setorigin( v_pos );
                    yaw = vectortoyaw( s_intel_loc.origin - v_pos );
                    level.players[ 0 ] setplayerangles( ( 0, yaw, 0 ) );
                    return;
                }
                
                level.players[ 0 ] setorigin( s_intel_loc.origin );
                return;
            }
        }
    }

    // Namespace intel
    // Params 1, eflags: 0x4
    // Checksum 0xfae122f3, Offset: 0x2a35
    // Size: 0x1b, Type: dev
    function private function_31e333b5f6ee4eab( params )
    {
        level.var_a2d1850dcd377888 = params[ 0 ];
    }

    // Namespace intel
    // Params 0, eflags: 0x4
    // Checksum 0x73bd5639, Offset: 0x2a58
    // Size: 0x266, Type: dev
    function private function_36123c5b7dbaacc6()
    {
        while ( true )
        {
            foreach ( s_intel_location in level.var_d269a296de42db6b )
            {
                print3d( s_intel_location.origin, "<dev string:x21b>" + ( s_intel_location.str_intel_name ?? "<dev string:x229>" ), ( 1, 1, 1 ), undefined, 0.25 );
                
                if ( isarray( s_intel_location.a_mdl_intel ) )
                {
                    foreach ( i, mdl_intel in s_intel_location.a_mdl_intel )
                    {
                        if ( isdefined( mdl_intel.owningplayer ) )
                        {
                            v_pos = s_intel_location.origin + ( 0, 0, -5 * ( i + 1 ) );
                            entnum = mdl_intel.owningplayer getentitynumber();
                            
                            if ( mdl_intel.owningplayer player_has_intel( s_intel_location.str_intel_name ) )
                            {
                                var_cf861766ba2efd44 = "<dev string:x233>" + mdl_intel.owningplayer.name + "<dev string:x24b>" + entnum + "<dev string:x256>";
                            }
                            else
                            {
                                var_cf861766ba2efd44 = "<dev string:x233>" + mdl_intel.owningplayer.name + "<dev string:x24b>" + entnum + "<dev string:x263>";
                            }
                            
                            print3d( v_pos, var_cf861766ba2efd44, ( 1, 1, 1 ), undefined, 0.25 );
                        }
                    }
                }
                
                sphere( s_intel_location.origin, 25, ( 1, 1, 1 ) );
                println( "<dev string:x274>", s_intel_location.str_intel_name, "<dev string:x28d>", s_intel_location.origin );
            }
            
            waitframe();
        }
    }

#/
