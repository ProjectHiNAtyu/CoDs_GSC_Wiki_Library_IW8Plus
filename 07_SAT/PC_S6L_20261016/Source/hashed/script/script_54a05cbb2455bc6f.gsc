// script_54a05cbb2455bc6f  (hash_54a05cbb2455bc6f.gscc) (size: 19059 Bytes / 0x4a73 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x297e7bc4 (696155076)
// size ...... 19059 (0x4a73)
// includes .. 15  (offset: 0x4617)
// strings ... 59  (offset: 0x468f)
// dev strs .. 18  (offset: 0x4997)
// exports ... 50  (offset: 0x2fef)
// cseg ...... 0x676 + 0x2979 (0x2fef)
// imports ... 115 (offset: 0x37bf)
// animtree1 . 0   (offset: 0x4a73)
// animtree2 . 0   (offset: 0x4a73)
#using script_2b3f8b011222f912;
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_fate;

// Namespace ztron_fate
// Params 0, eflags: 0x5
// Checksum 0xec3599f2, Offset: 0x694
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_fate", #"ztron_item", undefined, &init );
}

// Namespace ztron_fate
// Params 0
// Checksum 0x1e4f0355, Offset: 0x6bd
// Size: 0xbe
function init()
{
    level.ztronfate = spawnstruct();
    level.ztronfate.playerspawnpoints = utility::getstructarray( "room_of_fate_player_spawnpoint", "targetname" );
    level.ztronfate.fatespawnpoints = utility::getstructarray( "room_of_fate_origin", "targetname" );
    level.ztronfate.defs = [];
    level.ztronfate.rocks = [];
    ztron_sound::function_4ac735395b173fe( "fate_rock_impact_OS", "evt_ztron_roomoffate_rock_impact" );
    ztron_sound::function_4ac735395b173fe( "fate_rock_activated_OS", "evt_ztron_roomoffate_touch_rock" );
    ztron_sound::function_4ac735395b173fe( "fate_fate_awarded_OS", "evt_ztron_roomoffate_power_given" );
    
    /#
        function_cbf8ec997d112380();
    #/
}

// Namespace ztron_fate
// Params 8
// Checksum 0x2d0ff44e, Offset: 0x783
// Size: 0x171
function function_4b268a9ddf9d18b4( fatetype, name, activatecb, deactivatecb, faterock, awardmodel, sndalias, var_8333bad7b6193183 = 1 )
{
    assert( isdefined( faterock ), "<dev string:x24>" );
    assert( isdefined( awardmodel ), "<dev string:x52>" );
    fate = spawnstruct();
    fate.type = fatetype;
    fate.name = name;
    fate.activatecb = activatecb;
    fate.deactivatecb = deactivatecb;
    fate.faterock = faterock;
    fate.awardmodel = awardmodel;
    fate.var_8333bad7b6193183 = var_8333bad7b6193183;
    fate.sndalias = sndalias;
    level.ztronfate.defs[ fatetype ] = fate;
    var_e932ba5418b9f26 = ztron_item::function_71e133b37011bee6( faterock );
    type = getscriptbundlefieldvalue( var_e932ba5418b9f26, #"genericstring" );
    ztron_item::function_5844a9c240f7dc8d( type, #"use", &function_7579619b39c53b6a );
    ztron_item::function_5844a9c240f7dc8d( type, #"canautouse", &function_727d21daded00935 );
    
    /#
        function_87f4c10c33065d6( fate );
    #/
}

// Namespace ztron_fate
// Params 1, eflags: 0x4
// Checksum 0x28222b54, Offset: 0x8fc
// Size: 0xa4
function private function_ecedada7175a772c( itemref )
{
    foreach ( fatedata in level.ztronfate.defs )
    {
        if ( fatedata.spawnitem == itemref )
        {
            return fatedata.type;
        }
    }
    
    return 0;
}

// Namespace ztron_fate
// Params 1, eflags: 0x4
// Checksum 0x45ab3c32, Offset: 0x9a9
// Size: 0xa7
function private function_7579619b39c53b6a( params )
{
    ref = level.ztron.itemdef.itemdata[ params.scriptable.var_8593f17418a81b6e ].ref;
    fatetype = function_cc146592f948e7da( ref );
    assert( fatetype != 0, "<dev string:x82>" );
    self.ztron.var_9576a9b0cd868e6e = 1;
    thread function_cfbe4f58c8652fc( fatetype );
    ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_happy" ) );
}

// Namespace ztron_fate
// Params 1
// Checksum 0x6c8ee7f6, Offset: 0xa58
// Size: 0x78
function function_cfbe4f58c8652fc( fatetype )
{
    self notify( #"hash_86828e203f63d64e" );
    self endon( #"hash_86828e203f63d64e" );
    self endon( #"disconnect" );
    ztron_sound::ztron_playsound( "fate_rock_activated_OS", self.origin );
    function_3eee572c160b94e8( fatetype, 0 );
    self.ztron.var_b11b66f5583f1049 = fatetype;
    self.ztron.var_9576a9b0cd868e6e = undefined;
}

// Namespace ztron_fate
// Params 1, eflags: 0x4
// Checksum 0x83b6b05, Offset: 0xad8
// Size: 0x3f, Type: bool
function private function_727d21daded00935( params )
{
    if ( isdefined( self.ztron.var_b11b66f5583f1049 ) )
    {
        return false;
    }
    
    if ( self.ztron.var_9576a9b0cd868e6e )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_fate
// Params 0
// Checksum 0xbfeb707f, Offset: 0xb20
// Size: 0x1f
function function_88bf17dbb3480c1b()
{
    return level.ztron.var_95d8c7a469393957 ? 1 : 3;
}

// Namespace ztron_fate
// Params 1, eflags: 0x4
// Checksum 0xa7066a3c, Offset: 0xb48
// Size: 0xa4
function private function_cc146592f948e7da( rockref )
{
    foreach ( fatedata in level.ztronfate.defs )
    {
        if ( fatedata.faterock == rockref )
        {
            return fatedata.type;
        }
    }
    
    return 0;
}

// Namespace ztron_fate
// Params 1
// Checksum 0x5d7068c, Offset: 0xbf5
// Size: 0x83
function function_ae31dc85d3cf758( time )
{
    if ( isdefined( self.ztron.var_930cb6796e836ff7 ) )
    {
        time *= self.ztron.var_930cb6796e836ff7;
        self.ztron.var_930cb6796e836ff7 = undefined;
    }
    
    if ( !hasfate( 2 ) )
    {
        return time;
    }
    
    if ( function_c93d5c389d532c34( 2, 4 ) )
    {
        return int( time * 2.25 );
    }
    
    return int( time * 1.8 );
}

// Namespace ztron_fate
// Params 1
// Checksum 0xa13f1031, Offset: 0xc81
// Size: 0x27
function function_6ddf81aedfabc3d6( time )
{
    if ( !hasfate( 5 ) )
    {
        return time;
    }
    
    return int( time * 1.6 );
}

// Namespace ztron_fate
// Params 0
// Checksum 0x1c23caf1, Offset: 0xcb1
// Size: 0xa4
function function_a7aeaa00437cf945()
{
    var_49447cf7bffb51dd = 0;
    
    foreach ( fatedata in level.ztronfate.defs )
    {
        if ( hasfate( fatedata.type ) )
        {
            var_49447cf7bffb51dd += 1;
        }
    }
    
    return var_49447cf7bffb51dd;
}

// Namespace ztron_fate
// Params 7
// Checksum 0x25048293, Offset: 0xd5e
// Size: 0x2ab
function function_3eee572c160b94e8( type, delay = 0, banner = 1, timeout, bombitem = 1, loadgame = 0, storebought = 0 )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    assert( isdefined( self.ztron.fatemask ) );
    fatedata = level.ztronfate.defs[ type ];
    assert( fatedata, "<dev string:x97>" + ( type ?? "<dev string:xc7>" ) );
    
    if ( banner )
    {
        ztron_ui::function_65167952d8c180ac( fatedata.name );
        
        if ( isdefined( timeout ) )
        {
            ztron_dialog::function_927bb94feca983e8( getxhash( "player_fate_limited" ) );
        }
    }
    
    if ( bombitem )
    {
        if ( utility::issharedfuncdefined( fatedata.name, #"get_award_model" ) )
        {
            awardmodel = utility::callsharedfunc( fatedata.name, #"get_award_model", fatedata );
        }
        else
        {
            awardmodel = utility::spawn_model( fatedata.awardmodel, self.origin + ( 0, 0, 1500 ) );
        }
        
        awardmodel thread function_b25b58251fb02a5e( self, 0, 3.5 );
        awardmodel utility::waittill_any_timeout( 3.5, "bombsAway" );
        awardmodel delete();
    }
    
    playfxontagforclients( utility::getfx( "ztron_protal_radial_burst" ), self, "tag_origin", self );
    ztron_sound::ztron_playsound( "fate_fate_awarded_OS", self.origin );
    ztron_util::function_40ad6a6cc144aa3f( fatedata.sndalias );
    self notify( "killRemoveFateInTimeout" + type );
    
    if ( !isdefined( timeout ) && !storebought )
    {
        callback::callback( #"hash_6c71d319dc089c27", { #player:self, #event:#"sat_doa_foreverfated" } );
    }
    
    if ( hasfate( type ) && !isdefined( self.ztron.fate_timeout[ type ] ) )
    {
        return;
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.ztron.fatemask |= 1 << type;
    
    if ( isdefined( fatedata.activatecb ) )
    {
        self [[ fatedata.activatecb ]]( loadgame );
    }
    
    if ( isdefined( timeout ) )
    {
        thread removefateintimeout( type, timeout );
    }
}

// Namespace ztron_fate
// Params 2
// Checksum 0x65156f35, Offset: 0x1011
// Size: 0x11a
function removefateintimeout( type, timeout )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.ztron.fate_timeout ) )
    {
        self.ztron.fate_timeout = [];
    }
    
    self.ztron.fate_timeout[ type ] = timeout;
    killmsg = "killRemoveFateInTimeout" + type;
    
    while ( self.ztron.fate_timeout[ type ] > 0 )
    {
        msg = utility::waittill_any_timeout( 60, killmsg );
        
        if ( msg == killmsg )
        {
            break;
        }
        
        self.ztron.fate_timeout[ type ] -= 60;
    }
    
    self.ztron.fate_timeout[ type ] = undefined;
    thread function_ff095f8444baf059( type );
    
    if ( msg != killmsg )
    {
        ztron_dialog::function_927bb94feca983e8( getxhash( "player_fate_expired" ) );
    }
}

// Namespace ztron_fate
// Params 1
// Checksum 0xf1e89823, Offset: 0x1133
// Size: 0x44, Type: bool
function function_82e3fd31de411edf( type )
{
    if ( !isdefined( self.ztron.fate_timeout ) )
    {
        return false;
    }
    
    if ( isdefined( self.ztron.fate_timeout[ type ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_fate
// Params 0
// Checksum 0xa144d18b, Offset: 0x1180
// Size: 0x1db
function function_3e597b414cec37ea()
{
    var_4d01bfa75973b4de = [];
    
    if ( hasfate( 4 ) && !function_82e3fd31de411edf( 4 ) )
    {
        if ( !function_c93d5c389d532c34( 4, 1 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_feet_upgrade_1";
        }
        
        if ( !function_c93d5c389d532c34( 4, 2 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_feet_upgrade_2";
        }
    }
    
    if ( hasfate( 1 ) && !function_82e3fd31de411edf( 1 ) )
    {
        if ( !function_c93d5c389d532c34( 1, 1 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fire_upgrade_1";
        }
        
        if ( !function_c93d5c389d532c34( 1, 2 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fire_upgrade_2";
        }
    }
    
    if ( hasfate( 3 ) && !function_82e3fd31de411edf( 3 ) )
    {
        if ( !function_c93d5c389d532c34( 3, 1 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_friend_upgrade_1";
        }
        
        if ( function_c93d5c389d532c34( 3, 1 ) && !function_c93d5c389d532c34( 3, 2 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_friend_upgrade_2";
        }
        
        if ( !function_c93d5c389d532c34( 3, 3 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_friend_upgrade_3";
        }
        
        if ( !function_c93d5c389d532c34( 3, 4 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_friend_upgrade_4";
        }
    }
    
    if ( hasfate( 2 ) && !function_82e3fd31de411edf( 2 ) )
    {
        if ( !function_c93d5c389d532c34( 2, 1 ) && level.ztron.var_95d8c7a469393957 )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fortune_upgrade_1";
        }
        
        if ( !function_c93d5c389d532c34( 2, 2 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fortune_upgrade_2";
        }
        
        if ( !function_c93d5c389d532c34( 2, 3 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fortune_upgrade_3";
        }
        
        if ( !function_c93d5c389d532c34( 2, 4 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fortune_upgrade_4";
        }
        
        if ( !function_c93d5c389d532c34( 2, 5 ) )
        {
            var_4d01bfa75973b4de[ var_4d01bfa75973b4de.size ] = "ztron_store_fate_fortune_upgrade_5";
        }
    }
    
    return var_4d01bfa75973b4de;
}

// Namespace ztron_fate
// Params 1
// Checksum 0x5828325c, Offset: 0x1364
// Size: 0x150
function function_2106022388ab40d( event = 0 )
{
    var_c2e3cf4d5b6bde83 = [];
    
    if ( event == 0 )
    {
        return var_c2e3cf4d5b6bde83;
    }
    
    if ( event == 2 )
    {
        availablechoices = [ "ztron_store_fate_devine_shield", "ztron_store_fate_devine_chalice" ];
    }
    else if ( event == 1 )
    {
        availablechoices = function_3e597b414cec37ea();
        
        if ( hasfate( 3 ) )
        {
            availablechoices = arrayremove( availablechoices, "ztron_store_fate_friend_upgrade_1" );
            
            if ( !arraycontains( availablechoices, "ztron_store_fate_fortune_upgrade_2" ) )
            {
                if ( !function_c93d5c389d532c34( 3, 2 ) )
                {
                    availablechoices[ availablechoices.size ] = "ztron_store_fate_friend_upgrade_2";
                }
            }
        }
        
        if ( hasfate( 2 ) )
        {
            availablechoices = arrayremove( availablechoices, "ztron_store_fate_fortune_upgrade_2" );
            availablechoices = arrayremove( availablechoices, "ztron_store_fate_fortune_upgrade_3" );
        }
    }
    
    foreach ( itemref in availablechoices )
    {
        item = ztron_slayer::function_714b4f935c8d2f0c( itemref );
        
        if ( isdefined( item ) )
        {
            var_c2e3cf4d5b6bde83[ var_c2e3cf4d5b6bde83.size ] = item;
        }
    }
    
    return var_c2e3cf4d5b6bde83;
}

// Namespace ztron_fate
// Params 2
// Checksum 0x1271e2e7, Offset: 0x14bd
// Size: 0x41
function function_9181381444523b30( timeout, eventtype = 0 )
{
    var_ba5237719d033edf = function_2106022388ab40d( eventtype );
    
    if ( var_ba5237719d033edf.size )
    {
        ztron_ui::ztron_fate_upgrade_show( var_ba5237719d033edf, timeout );
    }
}

// Namespace ztron_fate
// Params 1
// Checksum 0xeb4652dd, Offset: 0x1506
// Size: 0xa5
function function_8702f386a2296415( timeout )
{
    self notify( #"hash_54f9e7ffd7014ef2" );
    self endon( #"hash_54f9e7ffd7014ef2" );
    level utility::flag_set( "arena_hold_teleporter" );
    level.ztron.var_3678ff7453f3c5cf = "ztron_fate_upgrade_choices_finished";
    msg = level utility::waittill_any_timeout( timeout, "ztron_fate_upgrade_choices_finished" );
    
    if ( msg == "timeout" )
    {
        level notify( level.ztron.var_3678ff7453f3c5cf );
    }
    
    level.ztron.var_3678ff7453f3c5cf = undefined;
    level utility::flag_clear( "arena_hold_teleporter" );
}

// Namespace ztron_fate
// Params 0, eflags: 0x4
// Checksum 0x16650268, Offset: 0x15b3
// Size: 0x91, Type: bool
function private function_8915330bdef27255()
{
    foreach ( player in level.players )
    {
        if ( player hasfate( 5 ) || player hasfate( 6 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_fate
// Params 0, eflags: 0x4
// Checksum 0x9ae84480, Offset: 0x164d
// Size: 0xd9
function private function_499673ff6d3ab43f()
{
    upgradedfate = 0;
    
    foreach ( player in level.players )
    {
        if ( player.ztron.fatesubmask != 0 )
        {
            for ( type = 1; type <= 5 ; type++ )
            {
                if ( ( player.ztron.fatesubmask & 1 << type ) != 0 )
                {
                    upgradedfate++;
                }
            }
            
            break;
        }
    }
    
    return upgradedfate;
}

// Namespace ztron_fate
// Params 3, eflags: 0x4
// Checksum 0xa907d186, Offset: 0x172f
// Size: 0x169
function private function_3dc0e1a32c672d7a( min, max, params )
{
    invalid_round = 0;
    
    if ( params.var_f7cf03ba4027bf0e )
    {
        if ( level.ztron.roundnumber > max )
        {
            return invalid_round;
        }
        
        if ( level.ztron.roundnumber >= min )
        {
            if ( params.type == 2 && function_8915330bdef27255() )
            {
                return invalid_round;
            }
            
            if ( params.type == 1 )
            {
                var_d9ebfd868c1d9ed7 = function_499673ff6d3ab43f();
                
                if ( var_d9ebfd868c1d9ed7 >= params.upgradeindex )
                {
                    return invalid_round;
                }
            }
            
            min = level.ztron.roundnumber;
        }
    }
    
    var_a2d5ef4dbe3e90fb = 1;
    laprounds = 80;
    arenarounds = 4;
    candidaterounds = [];
    
    for ( i = min; i <= max ; i++ )
    {
        if ( params.var_5a0dfbec1c00a3a0 )
        {
            if ( i % laprounds != 1 && i % arenarounds == var_a2d5ef4dbe3e90fb )
            {
                continue;
            }
        }
        
        candidaterounds = arraycombineunique( candidaterounds, [ i ] );
    }
    
    if ( candidaterounds.size > 0 )
    {
        return utility::array_random( candidaterounds );
    }
    
    return 0;
}

// Namespace ztron_fate
// Params 0
// Checksum 0x199860ba, Offset: 0x18a0
// Size: 0x3ed
function function_18f662f900ff4485()
{
    self notify( #"hash_a6f21fd8095888d5" );
    self endon( #"hash_a6f21fd8095888d5" );
    
    if ( !getdvarint( @"hash_9c736d34fd856b43", 1 ) )
    {
        return;
    }
    
    level endon( #"game_over" );
    utility::flag_wait( "ztron_restore_finished" );
    params = spawnstruct();
    params.var_5a0dfbec1c00a3a0 = 1;
    params.var_f7cf03ba4027bf0e = level.ztron.var_cccdb0a426251ee0;
    
    if ( params.var_f7cf03ba4027bf0e )
    {
        level waittill( #"round_about_to_start" );
    }
    
    params.type = 2;
    var_539b69b075422e76 = function_3dc0e1a32c672d7a( 40, 50, params );
    params.type = 1;
    params.upgradeindex = 1;
    var_e1b3b8eef7a2d474 = function_3dc0e1a32c672d7a( 55, 70, params );
    params.upgradeindex = 2;
    var_dd65c51ba95a52e2 = function_3dc0e1a32c672d7a( 81, 90, params );
    doevent = 0;
    
    /#
        if ( getdvarint( @"hash_8f7bc8d890573580", 0 ) == 1 )
        {
            var_539b69b075422e76 = 1;
            var_e1b3b8eef7a2d474 = 2;
            var_dd65c51ba95a52e2 = 3;
        }
    #/
    
    ztron_debug::debugmsg( "presentFateChoicEventWatcher on Round: " + var_539b69b075422e76 + ", Round: " + var_e1b3b8eef7a2d474 + ", Round: " + var_dd65c51ba95a52e2 );
    
    while ( true )
    {
        level waittill( #"round_begin" );
        
        if ( level.ztron.roundnumber == var_e1b3b8eef7a2d474 )
        {
            doevent = 1;
        }
        else if ( level.ztron.roundnumber == var_dd65c51ba95a52e2 )
        {
            doevent = 1;
        }
        else if ( level.ztron.roundnumber == var_539b69b075422e76 )
        {
            doevent = 2;
        }
        
        if ( level.ztron.activechallenge )
        {
            continue;
        }
        
        if ( doevent )
        {
            ztron_ui::function_37aad40e39a9fdfe( "slayer_boss_coming_zursa", "zursa" );
            ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Slayer_Boss_Zursa" ] );
            wait 5;
            spots = level.ztron.active_arena.lootspots;
            spot = spots[ randomint( spots.size ) ];
            spots = arrayremove( spots, spot );
            zursadef = ztron_enemy::function_96eea0d09d5640d1( "zursa" );
            zursa = ztron_enemy::function_77e1bf43b991b4a( zursadef, 1, spot.origin, 0, undefined, undefined, undefined, undefined, undefined, undefined, 1, 1 );
            
            if ( isdefined( zursa ) )
            {
                zursa ztron_ai_zombie::zombie_sethealth( 25000 + level.players.size * 6000 );
                zursa.var_63c94fe1b2260b34 = 1;
            }
            
            if ( level.players.size > 2 )
            {
                wait 3;
                spot = spots[ randomint( spots.size ) ];
                zursa = ztron_enemy::function_77e1bf43b991b4a( zursadef, 1, spot.origin, 0, undefined, undefined, undefined, undefined, undefined, undefined, 1, 1 );
                
                if ( isdefined( zursa ) )
                {
                    zursa ztron_ai_zombie::zombie_sethealth( 25000 + ( level.players.size + 2 ) * 6000 );
                    zursa.var_63c94fe1b2260b34 = 1;
                }
            }
            
            level waittill( #"round_over" );
            timeout = 60;
            level thread function_8702f386a2296415( timeout );
            
            foreach ( player in level.players )
            {
                player thread function_9181381444523b30( timeout, doevent );
            }
            
            doevent = 0;
        }
    }
}

// Namespace ztron_fate
// Params 1
// Checksum 0xf2b9652a, Offset: 0x1c95
// Size: 0x47, Type: bool
function function_42606f145c609140( itemref )
{
    switch ( itemref )
    {
        case #"hash_d8436ae2b569ef05":
            thread function_3eee572c160b94e8( 5 );
            return true;
        case #"hash_cb4853e4be395a71":
            thread function_3eee572c160b94e8( 6 );
            return true;
    }
    
    return false;
}

// Namespace ztron_fate
// Params 1
// Checksum 0xef08e00b, Offset: 0x1ce5
// Size: 0x169, Type: bool
function function_3a560377b08e2c42( itemref )
{
    switch ( itemref )
    {
        case #"hash_1dc3aab5b9855a57":
            function_618da6e0e827b49c( 4, 1 );
            return true;
        case #"hash_1dc3abb5b9855bea":
            function_618da6e0e827b49c( 4, 2 );
            return true;
        case #"hash_535788bd9a24441f":
            function_618da6e0e827b49c( 1, 1 );
            return true;
        case #"hash_535789bd9a2445b2":
            function_618da6e0e827b49c( 1, 2 );
            return true;
        case #"hash_c6447a4b4b9a1b53":
            function_618da6e0e827b49c( 3, 1 );
            return true;
        case #"hash_c6447b4b4b9a1ce6":
            function_618da6e0e827b49c( 3, 2 );
            return true;
        case #"hash_c6447c4b4b9a1e79":
            function_618da6e0e827b49c( 3, 3 );
            return true;
        case #"hash_c6447d4b4b9a200c":
            function_618da6e0e827b49c( 3, 4 );
            return true;
        case #"hash_3b17410b9d77382":
            function_618da6e0e827b49c( 2, 1 );
            return true;
        case #"hash_3b17310b9d771ef":
            function_618da6e0e827b49c( 2, 2 );
            return true;
        case #"hash_3b17210b9d7705c":
            function_618da6e0e827b49c( 2, 3 );
            return true;
        case #"hash_3b17110b9d76ec9":
            function_618da6e0e827b49c( 2, 4 );
            return true;
        case #"hash_3b17010b9d76d36":
            function_618da6e0e827b49c( 2, 5 );
            return true;
    }
    
    return false;
}

// Namespace ztron_fate
// Params 1
// Checksum 0x3cf2df1f, Offset: 0x1e57
// Size: 0x54, Type: bool
function hasfate( type )
{
    if ( !isplayer( self ) || !isdefined( self.ztron.fatemask ) )
    {
        return false;
    }
    
    if ( type == 0 )
    {
        return false;
    }
    
    return ( self.ztron.fatemask & 1 << type ) != 0;
}

// Namespace ztron_fate
// Params 0
// Checksum 0x7f09123c, Offset: 0x1eb4
// Size: 0xb8
function function_a0f4e201932db40e()
{
    foreach ( fatedata in level.ztronfate.defs )
    {
        function_ff095f8444baf059( fatedata.type );
    }
    
    self.ztron.fatemask = 0;
    self.ztron.fatesubmask = 0;
}

// Namespace ztron_fate
// Params 1
// Checksum 0xd55c69c4, Offset: 0x1f74
// Size: 0xb8
function function_ff095f8444baf059( type )
{
    fatedata = level.ztronfate.defs[ type ];
    assert( fatedata, "<dev string:xd1>" );
    
    if ( !hasfate( type ) )
    {
        return;
    }
    
    self notify( "killRemoveFateInTimeout" + type );
    self.ztron.fatemask &= ~( 1 << type );
    
    if ( isdefined( fatedata.deactivatecb ) )
    {
        self [[ fatedata.deactivatecb ]]();
    }
    
    playfxontagforclients( utility::getfx( "ztron_fate_removal" ), self, "tag_origin", self );
}

// Namespace ztron_fate
// Params 4
// Checksum 0xdb1eac91, Offset: 0x2034
// Size: 0xf8
function function_6b69ec848417cf3b( mask, clear = 1, bombitem = 1, loadgame = 0 )
{
    if ( clear )
    {
        function_a0f4e201932db40e();
    }
    
    foreach ( fatedata in level.ztronfate.defs )
    {
        type = fatedata.type;
        
        if ( ( mask & 1 << type ) != 0 )
        {
            thread function_3eee572c160b94e8( type, 0, 0, undefined, bombitem, loadgame );
        }
    }
}

// Namespace ztron_fate
// Params 0
// Checksum 0x9714617e, Offset: 0x2134
// Size: 0x1c4
function roomoffate()
{
    self notify( #"hash_f246a0e98912b8b8" );
    self endon( #"hash_f246a0e98912b8b8" );
    level endon( #"fateexited" );
    level thread function_2e0f020e838fe559();
    ztron_ui::function_58681cbec0799512();
    
    foreach ( player in level.players )
    {
        player val::set( "ztron_room_of_fate", "allow_movement", 0 );
    }
    
    wait 1;
    ztron_sound::function_ac1e49175da7897d( "gameEvent", "roomOfFate" );
    ztron_ui::function_37aad40e39a9fdfe( "fate_start" );
    ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4sbchrofi" );
    ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4rofch", 2 );
    wait 5.5;
    tributetext = "fate_tribute_full";
    
    if ( !level.ztron.var_d1004540ba0cd3ff )
    {
        tributetext = "fate_tribute_fail";
    }
    
    ztron_ui::function_37aad40e39a9fdfe( tributetext );
    level thread function_85fdcabf23104c3d( level.ztron.var_d1004540ba0cd3ff );
    wait 1.5;
    
    foreach ( player in level.players )
    {
        player val::reset_all( "ztron_room_of_fate" );
    }
}

// Namespace ztron_fate
// Params 0
// Checksum 0xaafa478f, Offset: 0x2300
// Size: 0x140
function function_2e0f020e838fe559()
{
    self notify( #"hash_aeb06ea90e583daf" );
    self endon( #"hash_aeb06ea90e583daf" );
    var_8d1f606531959b2d = 0;
    timeout = gettime() + 60000;
    var_65b7044029c59d61 = gettime() + 40000;
    var_1cdc0adb355a38bf = 0;
    
    while ( !var_8d1f606531959b2d )
    {
        nowtime = gettime();
        
        if ( gettime() > timeout )
        {
            break;
        }
        
        if ( !var_1cdc0adb355a38bf && nowtime > var_65b7044029c59d61 )
        {
            ztron_ui::function_37aad40e39a9fdfe( "fate_hurry" );
            ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4hry" );
            var_1cdc0adb355a38bf = 1;
        }
        
        wait 1;
        var_8d1f606531959b2d = 1;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.ztron.var_b11b66f5583f1049 ) )
            {
                var_8d1f606531959b2d = 0;
                break;
            }
        }
    }
    
    roomoffateend();
}

// Namespace ztron_fate
// Params 0
// Checksum 0xbca94298, Offset: 0x2448
// Size: 0xb0
function roomoffateend()
{
    function_bf0b887e847b6ea7();
    ztron_ui::function_37aad40e39a9fdfe( "fate_decided" );
    
    foreach ( player in level.players )
    {
        player ztron_util::function_40ad6a6cc144aa3f( "dx_zm_ztr4_anno_anz4_d4rofdn" );
        player val::reset_all( "ztron_room_of_fate" );
    }
    
    wait 4;
    level notify( #"fateexited" );
}

// Namespace ztron_fate
// Params 1
// Checksum 0x2ef17ae7, Offset: 0x2500
// Size: 0xdd
function function_85fdcabf23104c3d( var_59f962715b46d69b )
{
    self notify( #"hash_90f7724543b9b221" );
    self endon( #"hash_90f7724543b9b221" );
    level endon( #"fateexited" );
    fates = function_f457cde738de3145();
    spawnpoints = arrayrandomize( level.ztronfate.fatespawnpoints );
    fates = arrayrandomize( fates );
    
    for ( i = 0; i < fates.size && i < spawnpoints.size ; i++ )
    {
        rock = function_6aed78eb7ea46ed2( fates[ i ], spawnpoints[ i ].origin, undefined, var_59f962715b46d69b );
        level.ztronfate.rocks[ level.ztronfate.rocks.size ] = rock;
    }
}

// Namespace ztron_fate
// Params 0
// Checksum 0xae36ffbb, Offset: 0x25e5
// Size: 0xac
function function_f457cde738de3145()
{
    fates = [];
    
    foreach ( ztronfate in level.ztronfate.defs )
    {
        if ( !ztronfate.var_8333bad7b6193183 )
        {
            continue;
        }
        
        fates[ fates.size ] = ztronfate.type;
    }
    
    return fates;
}

// Namespace ztron_fate
// Params 4
// Checksum 0x944b80ad, Offset: 0x269a
// Size: 0x11a
function function_6aed78eb7ea46ed2( type, origin, offset = 0, var_59f962715b46d69b )
{
    fatedata = level.ztronfate.defs[ type ];
    assert( isdefined( fatedata.faterock ), "<dev string:xe8>" );
    var_ba4127a17011b0ae = ztron_item::function_71e133b37011bee6( fatedata.faterock );
    params = spawnstruct();
    params.overridelifetime = 9999;
    params.modelspinning = 0;
    
    if ( !var_59f962715b46d69b )
    {
        params.overridestate = "model_unpaid";
    }
    
    rock = level ztron_item::spawnitem( var_ba4127a17011b0ae, origin, offset, undefined, params );
    falldown_anim = var_59f962715b46d69b ? "start_falldown" : "start_falldown_unpaid";
    rock setscriptablepartstate( rock.type, falldown_anim );
    rock thread function_46a14a6b4a245ac7( origin );
    return rock;
}

// Namespace ztron_fate
// Params 1
// Checksum 0x3a19e2cc, Offset: 0x27bd
// Size: 0xb9
function function_46a14a6b4a245ac7( origin )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    wait 1.2;
    
    if ( isdefined( self ) )
    {
        objectiveindex = objidpoolmanager::requestobjectiveid();
        
        if ( objectiveindex != -1 )
        {
            objectoffset = ( 0, 0, 80 );
            objidpoolmanager::objective_add_objective( objectiveindex, "current", origin + objectoffset, "ui_icon_ztron_question_mark" );
            objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
            objidpoolmanager::update_objective_setneutrallabel( objectiveindex, &"ztron_hud/fate_rock" );
            objidpoolmanager::objective_playermask_showtoall( objectiveindex );
            objidpoolmanager::objective_showdistance( objectiveindex, 0 );
            self.objectiveindex = objectiveindex;
            thread function_7e08ba77cf0c6448();
        }
    }
}

// Namespace ztron_fate
// Params 0
// Checksum 0x2fd631cf, Offset: 0x287e
// Size: 0x42
function function_7e08ba77cf0c6448()
{
    level endon( #"ztron_game_is_over" );
    self waittill( #"death" );
    
    if ( isdefined( self.objectiveindex ) )
    {
        objidpoolmanager::returnobjectiveid( self.objectiveindex );
        self.objectiveindex = undefined;
    }
}

// Namespace ztron_fate
// Params 0
// Checksum 0x3b4b0000, Offset: 0x28c8
// Size: 0xa0
function function_bf0b887e847b6ea7()
{
    foreach ( rock in level.ztronfate.rocks )
    {
        if ( isdefined( rock ) )
        {
            ztron_item::clearitem( rock );
        }
    }
    
    level.ztronfate.rocks = [];
}

// Namespace ztron_fate
// Params 3, eflags: 0x4
// Checksum 0xdaf3c406, Offset: 0x2970
// Size: 0x108
function private function_b25b58251fb02a5e( player, height = 1200, time = 2 )
{
    self endon( #"death" );
    self.origin += ( 0, 0, height );
    timefailsafe = gettime() + time * 1000;
    
    while ( isdefined( self ) && isdefined( player ) )
    {
        nowtime = gettime();
        
        if ( nowtime >= timefailsafe )
        {
            break;
        }
        
        if ( self.origin[ 2 ] < player.origin[ 2 ] )
        {
            self.origin = player.origin;
            break;
        }
        
        self.origin = ( player.origin[ 0 ], player.origin[ 1 ], self.origin[ 2 ] - 32 );
        waitframe();
    }
    
    self notify( #"bombsaway" );
}

// Namespace ztron_fate
// Params 0
// Checksum 0x65821e88, Offset: 0x2a80
// Size: 0x17, Type: bool
function function_d244c31ca9622810()
{
    return self.ztron.fatesubmask != 0;
}

// Namespace ztron_fate
// Params 2
// Checksum 0xc0b6319d, Offset: 0x2aa0
// Size: 0x70, Type: bool
function function_c93d5c389d532c34( type, upgradetype )
{
    if ( !isplayer( self ) || !isdefined( self.ztron.fatesubmask ) )
    {
        return false;
    }
    
    if ( hasfate( type ) == 0 )
    {
        return false;
    }
    
    if ( function_82e3fd31de411edf( type ) )
    {
        return false;
    }
    
    return ( self.ztron.fatesubmask & 1 << upgradetype ) != 0;
}

// Namespace ztron_fate
// Params 2
// Checksum 0xedcd7c74, Offset: 0x2b19
// Size: 0x97
function function_618da6e0e827b49c( fatetype, upgradetype )
{
    assert( hasfate( fatetype ), "<dev string:x113>" );
    assert( upgradetype > 0 && upgradetype <= 5 );
    
    if ( !isdefined( self.ztron.fatesubmask ) )
    {
        self.ztron.fatesubmask = 0;
    }
    
    self.ztron.fatesubmask |= 1 << upgradetype;
}

/#

    // Namespace ztron_fate
    // Params 1
    // Checksum 0x70071903, Offset: 0x2bb8
    // Size: 0x4e, Type: dev
    function function_87f4c10c33065d6( fatestruct )
    {
        devgui::function_9082edeb5db93280( "<dev string:x13e>" );
        devgui::function_cd4e263c1f3018ae( getxhashsourcename( fatestruct.name ), "<dev string:x14c>" + fatestruct.type, &function_e573ed3c22ff8a5e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_fate
    // Params 1
    // Checksum 0x7e7e3d59, Offset: 0x2c0e
    // Size: 0xc9, Type: dev
    function function_e573ed3c22ff8a5e( params )
    {
        type = isdefined( params[ 0 ] ) ? int( params[ 0 ] ) : undefined;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player function_3eee572c160b94e8( type );
                player.ztron.var_63a2c00323be75ea = player function_2106022388ab40d();
            }
        }
    }

    // Namespace ztron_fate
    // Params 0
    // Checksum 0xfb5c5887, Offset: 0x2cdf
    // Size: 0x92, Type: dev
    function function_cbf8ec997d112380()
    {
        devgui::function_9082edeb5db93280( "<dev string:x13e>" );
        devgui::add_devgui_func( "<dev string:x15e>", "<dev string:x174>", &function_4187960516cf6f2f );
        devgui::add_devgui_func( "<dev string:x190>", "<dev string:x1a8>", &function_d354afd9c54be255 );
        devgui::add_devgui_func( "<dev string:x1c5>", "<dev string:x1dc>", &function_a884b021f3da3de );
        
        for ( index = 1; index <= 5 ; index++ )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x1fb>" + index, "<dev string:x20b>" + index, &function_30aa5670a21ab9e0 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_fate
    // Params 1
    // Checksum 0x9e065863, Offset: 0x2d79
    // Size: 0xc1, Type: dev
    function function_30aa5670a21ab9e0( params )
    {
        upgradetype = int( params[ 0 ] );
        
        foreach ( player in level.players )
        {
            player.ztron.fatesubmask |= 1 << upgradetype;
        }
    }

    // Namespace ztron_fate
    // Params 0
    // Checksum 0x6c26aab8, Offset: 0x2e42
    // Size: 0x8c, Type: dev
    function function_a884b021f3da3de()
    {
        foreach ( player in level.players )
        {
            player.ztron.fatesubmask = 0;
        }
    }

    // Namespace ztron_fate
    // Params 0
    // Checksum 0xdfe79b07, Offset: 0x2ed6
    // Size: 0x8d, Type: dev
    function function_d354afd9c54be255()
    {
        foreach ( player in level.players )
        {
            player.ztron.fatesubmask = 255;
        }
    }

    // Namespace ztron_fate
    // Params 0
    // Checksum 0x73c41ccf, Offset: 0x2f6b
    // Size: 0x84, Type: dev
    function function_4187960516cf6f2f()
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player function_a0f4e201932db40e();
            }
        }
    }

#/
