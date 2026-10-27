// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_talisman.gsc  (hash_5c391fd6c0860dcf.gscc) (size: 41174 Bytes / 0xa0d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd628763 (3714221923)
// size ...... 41174 (0xa0d6)
// includes .. 19  (offset: 0x97be)
// strings ... 92  (offset: 0x9856)
// dev strs .. 47  (offset: 0x9e8a)
// exports ... 74  (offset: 0x6fd6)
// cseg ...... 0x7c7 + 0x680f (0x6fd6)
// imports ... 211 (offset: 0x7b66)
// animtree1 . 0   (offset: 0xa0d6)
// animtree2 . 0   (offset: 0xa0d6)
#using script_16ea1b94f0f381b3;
#using script_7f0fdfedd9ca7570;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_boss_fight;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_talisman;

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0x5
// Checksum 0x40432e77, Offset: 0x7e5
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"talisman", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0x4
// Checksum 0x27fa7e74, Offset: 0x80a
// Size: 0x36
function private function_7cf8dacb278a2665()
{
    if ( getdvarint( @"disable_talismans", 0 ) )
    {
        return;
    }
    
    utility::add_fx( "zm_sat_hornet_talisman_impact", "vfx_sat_gameplay_zm_ai_diana_talisman_charged_imp" );
    utility::add_fx( "zm_sat_hornet_talisman_banner_hornetww_impact", "vfx_sat_gameplay_zm_weapons_ww_hornet_impact" );
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0x4
// Checksum 0xab2ddd05, Offset: 0x848
// Size: 0x4aa
function private postmain_init()
{
    if ( getdvarint( @"disable_talismans", 0 ) )
    {
        return;
    }
    
    level scriptable::scriptable_adddamagedcallback( &function_aea918576079ee14 );
    
    if ( !isdefined( level.hornetww_settings ) )
    {
        level.hornetww_settings = spawnstruct();
    }
    
    level.hornetww_settings.var_23366fc8363b2fd6 = &function_2f8ac1abfef1ef65;
    level.talisman_system = {};
    level.talisman_system.talismans = [];
    level.talisman_system.hidden_talismans = [];
    level.talisman_system.var_af34bc9458b6a4ce = [];
    level.talisman_system.active_talismans = [];
    level.talisman_system.upper_talismans = [];
    level.talisman_system.lower_talismans = [];
    level.talisman_system.var_557f3cd0c097ab37 = 50;
    level.talisman_system.var_b084bbe7334df291 = 20;
    var_88a75e6b9c978007 = [ 45, 135, 225, 315 ];
    talisman_locs = utility::getstructarray( "zm_sat_hornet_talisman", "targetname" );
    
    foreach ( talismanloc in talisman_locs )
    {
        talisman = {};
        var_973d974a764cf4ed = utility::array_random( var_88a75e6b9c978007 );
        var_bafc86b46059313c = randomfloatrange( -50, -40 );
        talisman.scriptable = spawnscriptable( "zm_sat_hornet_talisman", talismanloc.origin, talismanloc.angles ?? ( 0, 0, 0 ) );
        talisman.trigger = spawn( "noent_volume_trigger_rotatable_radius", talismanloc.origin, 0, 240, 200 );
        talisman.banner = spawnscriptable( "zm_sat_hornet_talisman_banner", talismanloc.origin + ( 0, 0, 0 ), ( 0, var_973d974a764cf4ed + var_bafc86b46059313c, 0 ) );
        talisman.var_22c178ba78aafbf7 = talismanloc.origin + ( 0, 0, 0 );
        talisman.var_2831fc59790b6c90 = var_973d974a764cf4ed + var_bafc86b46059313c;
        set_talisman_state( talisman, "hidden" );
        level.talisman_system.talismans = arraycombineunique( level.talisman_system.talismans, [ talisman ] );
        level.talisman_system.hidden_talismans = arraycombineunique( level.talisman_system.hidden_talismans, [ talisman ] );
        
        if ( talismanloc.target == "starting_tailsman_loc" )
        {
            level.talisman_system.starting_talisman = talisman;
            talisman.location = "center";
        }
        
        if ( talismanloc.script_noteworthy == "upper" )
        {
            level.talisman_system.upper_talismans = arraycombineunique( level.talisman_system.upper_talismans, [ talisman ] );
            
            if ( talismanloc.origin[ 0 ] < 33369 )
            {
                talisman.location = "upper_right";
            }
            else
            {
                talisman.location = "upper_left";
            }
            
            continue;
        }
        
        if ( talismanloc.script_noteworthy == "lower" )
        {
            level.talisman_system.lower_talismans = arraycombineunique( level.talisman_system.lower_talismans, [ talisman ] );
            talisman.location = "center";
            
            if ( talismanloc.origin[ 0 ] > 34000 )
            {
                talisman.location = "lower_left";
                continue;
            }
            
            talisman.location = "lower_center";
        }
    }
    
    level.talisman_system.var_2c28be7abff7e769 = ( 0, 0, 0 );
    level.talisman_system.init_complete = 1;
    
    /#
        function_b9e98ae1e76ea210();
    #/
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0x2f10db26, Offset: 0xcfa
// Size: 0x22
function function_f0665edb8caafe15( searchorigin )
{
    level.talisman_system.var_2c28be7abff7e769 = searchorigin;
}

// Namespace zm_sat_hornet_talisman
// Params 2
// Checksum 0x391a02f2, Offset: 0xd24
// Size: 0x40
function function_d2691457fcb21c95( tetherpoint, tetherradius )
{
    level.talisman_system.var_c9011c3f44522697 = { #tetherradius:tetherradius, #tetherpoint:tetherpoint };
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0x23688211, Offset: 0xd6c
// Size: 0x22
function function_96dd573261cf2dc6( points )
{
    level.talisman_system.var_557f3cd0c097ab37 = points;
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0x76022642, Offset: 0xd96
// Size: 0x22
function function_c367c0ea85e3b628( var_ad3ff314c1292464 )
{
    level.talisman_system.var_b084bbe7334df291 = var_ad3ff314c1292464;
}

// Namespace zm_sat_hornet_talisman
// Params 4
// Checksum 0x9186e1c0, Offset: 0xdc0
// Size: 0x715
function set_talisman_state( talisman, state, diana, var_a53620d5600638e5 )
{
    if ( talisman.state && state == "charged" && talisman.state != "charged" )
    {
        talisman.scriptable notify( #"talisman_charged" );
        
        if ( !isdefined( level.talisman_system.charged_talismans ) )
        {
            level.talisman_system.charged_talismans = [];
        }
        
        level.talisman_system.charged_talismans = arraycombineunique( level.talisman_system.charged_talismans, [ talisman ] );
        
        if ( level.talisman_system.charged_talismans.size == level.talisman_system.var_af34bc9458b6a4ce.size )
        {
            foreach ( chargedtalisman in level.talisman_system.charged_talismans )
            {
                if ( chargedtalisman.scriptable == talisman.scriptable )
                {
                    var_5553af8acd1fae85 = chargedtalisman;
                }
                
                level callback::callback( "on_hornet_boss_talisman_charged", { #talisman:talisman } );
                set_talisman_state( chargedtalisman, "active", diana );
            }
            
            if ( var_5553af8acd1fae85 )
            {
                level notify( #"all_talismans_charged" );
                level.talisman_system.charged_talismans = [];
                return;
            }
        }
    }
    
    if ( talisman.state && talisman.state == "hidden" && state != "hidden" )
    {
        if ( !level.talisman_system.var_500719c5c1826208 )
        {
            level.talisman_system.var_500719c5c1826208 = 1;
            level thread function_a8d4794791369ce();
        }
        
        level.talisman_system.hidden_talismans = arrayremove( level.talisman_system.hidden_talismans, talisman );
        level.talisman_system.var_af34bc9458b6a4ce = arraycombineunique( level.talisman_system.var_af34bc9458b6a4ce, [ talisman ] );
        function_a42769859da02826( talisman );
    }
    
    if ( talisman.state && state == "inactive" && talisman.state == "destroyed" )
    {
        level.talisman_system.destroyed_talismans = arrayremove( level.talisman_system.destroyed_talismans, talisman );
    }
    
    if ( talisman.state == "active" && state == "destroyed" )
    {
        if ( !isdefined( level.var_c50a6791b09e24ba ) )
        {
            level.var_c50a6791b09e24ba = 0;
        }
        
        level.var_c50a6791b09e24ba++;
        
        if ( level.var_c50a6791b09e24ba == 2 )
        {
            level notify( #"hash_c765e7a3c3acfaa9" );
        }
    }
    
    switch ( state )
    {
        case #"hash_2c6dd295e7428eef":
        case #"hash_61f1a95d6bf95699":
        case #"hash_bee8aefcdf5a9a8f":
        case #"hash_f2b431c975ba652c":
            function_30d19ebe1259c991( talisman );
            break;
        case #"hash_174d75faff6dcf22":
        case #"hash_376a634585ba02b8":
        case #"hash_feb6a1f938941775":
            function_a42769859da02826( talisman );
            break;
    }
    
    talisman.state = state;
    talisman.scriptable.state = state;
    
    if ( level.talisman_system.init_complete && state != "decharging" )
    {
        talisman.scriptable utility::function_32b24db3127bff40( "state", state );
    }
    
    if ( talisman.banner && level.talisman_system.init_complete )
    {
        switch ( state )
        {
            case #"hash_174d75faff6dcf22":
            case #"hash_376a634585ba02b8":
                talisman.banner utility::function_32b24db3127bff40( "state", state );
                break;
            case #"hash_feb6a1f938941775":
                talisman.banner utility::function_32b24db3127bff40( "state", "decharging" );
                break;
            case #"hash_2c6dd295e7428eef":
            case #"hash_61f1a95d6bf95699":
            case #"hash_bee8aefcdf5a9a8f":
            case #"hash_f2b431c975ba652c":
                talisman.banner utility::function_32b24db3127bff40( "state", "hidden" );
                break;
        }
    }
    
    switch ( state )
    {
        case #"hash_61f1a95d6bf95699":
            level.talisman_system.hidden_talismans = arraycombineunique( level.talisman_system.hidden_talismans, [ talisman ] );
            level.talisman_system.var_af34bc9458b6a4ce = arrayremove( level.talisman_system.var_af34bc9458b6a4ce, talisman );
            talisman.scriptable notify( #"talisman_hidden" );
            break;
        case #"hash_376a634585ba02b8":
            talisman.scriptable notify( #"talisman_inactive" );
            level thread function_55e7491230fde072( talisman, diana );
            break;
        case #"hash_174d75faff6dcf22":
            talisman.scriptable notify( #"talisman_charging" );
            level thread function_cb12787847452ba8( talisman, diana );
            break;
        case #"hash_feb6a1f938941775":
            talisman.scriptable notify( #"hash_77ff6d49d3b0dccf" );
            level thread function_a0bd5e7f3eea98e3( talisman, diana );
            break;
        case #"hash_bee8aefcdf5a9a8f":
            level.talisman_system.active_talismans = arraycombineunique( level.talisman_system.active_talismans, [ talisman ] );
            level thread function_2935cfd1533704bf( talisman, diana, var_a53620d5600638e5 );
            break;
        case #"hash_f2b431c975ba652c":
            if ( !isdefined( level.talisman_system.destroyed_talismans ) )
            {
                level.talisman_system.destroyed_talismans = [];
            }
            
            level.talisman_system.destroyed_talismans = arraycombineunique( level.talisman_system.destroyed_talismans, [ talisman ] );
            talisman.scriptable notify( #"talisman_destroyed" );
            level thread on_talisman_destroyed( talisman, diana, var_a53620d5600638e5 );
            break;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0xd50a6980, Offset: 0x14dd
// Size: 0x2ef
function function_4a11d946b66c1758( destroyedtalisman )
{
    destroyedtalisman.scriptable notify( #"hash_baf2ca2ae7346c23" );
    
    if ( destroyedtalisman.orion )
    {
        if ( destroyedtalisman.orion.banner )
        {
            destroyedtalisman.orion.banner delete();
        }
        
        destroyedtalisman.orion.var_903fc8bde3d8fb01 = 1;
        destroyedtalisman.orion kill();
        return;
    }
    
    if ( destroyedtalisman.var_712c628c05be5736 )
    {
        destroyedtalisman.var_712c628c05be5736 delete();
        destroyedtalisman.var_712c628c05be5736 = undefined;
        return;
    }
    
    if ( destroyedtalisman.talisman_destroyed_orion_banner )
    {
        if ( destroyedtalisman.talisman_destroyed_orion_banner.trigger )
        {
            destroyedtalisman.scriptable notify( #"hash_ad7f1f996c6c34f8" );
            destroyedtalisman.talisman_destroyed_orion_banner.trigger delete();
            destroyedtalisman.talisman_destroyed_orion_banner.trigger = undefined;
        }
        else
        {
            destroyedtalisman.var_62b3d40b0824ee20.var_74112479b8333c3a = undefined;
            destroyedtalisman.var_62b3d40b0824ee20 notify( #"hash_c5d7a6cc65090420" );
            
            if ( destroyedtalisman.var_62b3d40b0824ee20 callback::exists( #"player_disconnect", &function_ab5eddc5386c6c5e ) )
            {
                destroyedtalisman.var_62b3d40b0824ee20 callback::remove( #"player_disconnect", &function_ab5eddc5386c6c5e );
            }
            
            if ( destroyedtalisman.var_62b3d40b0824ee20 callback::exists( #"player_death", &function_306481ca7e8657c1 ) )
            {
                destroyedtalisman.var_62b3d40b0824ee20 callback::remove( #"player_death", &function_306481ca7e8657c1 );
            }
            
            if ( destroyedtalisman.var_62b3d40b0824ee20 callback::exists( #"player_laststand", &function_b50749195a106daa ) )
            {
                destroyedtalisman.var_62b3d40b0824ee20 callback::remove( #"player_laststand", &function_b50749195a106daa );
            }
            
            if ( destroyedtalisman.var_62b3d40b0824ee20 callback::exists( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac ) )
            {
                destroyedtalisman.var_62b3d40b0824ee20 callback::remove( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
            }
            
            if ( destroyedtalisman.var_62b3d40b0824ee20 callback::exists( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb ) )
            {
                destroyedtalisman.var_62b3d40b0824ee20 callback::remove( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
            }
            
            destroyedtalisman.var_62b3d40b0824ee20 setclientomnvar( "ui_hud_carried_item_index", 10 );
            destroyedtalisman.var_62b3d40b0824ee20 setclientomnvar( "ui_hud_carried_item_count", 0 );
            destroyedtalisman.var_62b3d40b0824ee20 = undefined;
        }
        
        destroyedtalisman.talisman_destroyed_orion_banner delete();
        destroyedtalisman.talisman_destroyed_orion_banner = undefined;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 0
// Checksum 0xca48110d, Offset: 0x17d4
// Size: 0x113
function function_34532b42a097d6b5()
{
    foreach ( talisman in level.talisman_system.talismans )
    {
        switch ( talisman.state )
        {
            case #"hash_174d75faff6dcf22":
            case #"hash_2c6dd295e7428eef":
            case #"hash_bee8aefcdf5a9a8f":
            case #"hash_f2b431c975ba652c":
            case #"hash_feb6a1f938941775":
                function_4a11d946b66c1758( talisman );
                break;
            case #"hash_61f1a95d6bf95699":
                continue;
        }
        
        set_talisman_state( talisman, "hidden" );
    }
    
    level.talisman_system.var_500719c5c1826208 = undefined;
    level notify( #"end_talisman_system" );
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0x834a6977, Offset: 0x18ef
// Size: 0x1d3
function private function_55e7491230fde072( talisman, diana )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_charged" );
    talisman.scriptable endon( #"talisman_destroyed" );
    talisman.charge = 0;
    talisman.trigger.players_inside_talisman = [];
    
    while ( true )
    {
        talisman.trigger waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent, 0, 1 ) && ( !talisman.trigger.players_inside_talisman || !arraycontains( talisman.trigger.players_inside_talisman, ent ) || talisman.var_e5b35d7d2ef5c8b2 ) )
        {
            if ( talisman.var_e5b35d7d2ef5c8b2 )
            {
                talisman.var_e5b35d7d2ef5c8b2 = undefined;
            }
            
            if ( talisman.state == "inactive" || talisman.state == "decharging" )
            {
                set_talisman_state( talisman, "charging", diana );
            }
            
            talisman.trigger.players_inside_talisman = arraycombineunique( talisman.trigger.players_inside_talisman, [ ent ] );
            
            if ( talisman.charge_objid )
            {
                objidpoolmanager::objective_pin_player( talisman.charge_objid, ent );
                objidpoolmanager::function_b3b969f2930890eb( 2, ent );
            }
            
            ent thread function_510226aba819a087( talisman, diana );
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0x4879b3d4, Offset: 0x1aca
// Size: 0x170
function private function_510226aba819a087( talisman, diana )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_charged" );
    talisman.scriptable endon( #"talisman_destroyed" );
    self endon( #"death_or_disconnect" );
    var_f91915c5ed4119b0 = 15;
    var_f10794adbedb27a7 = squared( 240 + var_f91915c5ed4119b0 );
    thread function_c22c2afc0ccbcab6( talisman, diana );
    
    while ( true )
    {
        if ( distance2dsquared( self.origin, talisman.scriptable.origin ) > var_f10794adbedb27a7 )
        {
            if ( talisman.charge_objid )
            {
                objidpoolmanager::objective_unpin_player( talisman.charge_objid, self );
                objidpoolmanager::function_b3b969f2930890eb( 0, self );
            }
            
            talisman.trigger.players_inside_talisman = arrayremove( talisman.trigger.players_inside_talisman, self );
            
            if ( talisman.trigger.players_inside_talisman.size == 0 && talisman.state == "charging" )
            {
                set_talisman_state( talisman, "decharging", diana );
            }
            
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xe9938dd6, Offset: 0x1c42
// Size: 0x114
function private function_c22c2afc0ccbcab6( talisman, diana )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_charged" );
    talisman.scriptable endon( #"talisman_destroyed" );
    self waittill( #"death_or_disconnect" );
    
    if ( talisman.charge_objid )
    {
        objidpoolmanager::objective_unpin_player( talisman.charge_objid, self );
        objidpoolmanager::function_b3b969f2930890eb( 0, self );
    }
    
    talisman.trigger.players_inside_talisman = arrayremove( talisman.trigger.players_inside_talisman, self );
    
    if ( talisman.trigger.players_inside_talisman.size == 0 && talisman.state == "charging" )
    {
        set_talisman_state( talisman, "decharging", diana );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xefdf2abf, Offset: 0x1d5e
// Size: 0x2b6
function private function_cb12787847452ba8( talisman, diana )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"hash_77ff6d49d3b0dccf" );
    talisman.scriptable endon( #"talisman_charged" );
    talisman.scriptable endon( #"talisman_destroyed" );
    var_a0da0f1f8520466e = gettime();
    
    if ( level.var_62b3ff7bb81cf843 )
    {
        level thread zm_quest::update_guidance( undefined, #"hornet_boss_fight_guidance", #"charging_talisman" );
        level.var_62b3ff7bb81cf843 = undefined;
    }
    
    if ( !level.talisman_system.var_42dd618734d04af2 )
    {
        level.talisman_system.var_42dd618734d04af2 = 1;
        level thread function_8f37c6bba9068806();
        level thread function_26c8ca89fbcea7f2();
    }
    
    level thread function_c6bb7849ba397bf3( talisman );
    var_9eb19c146134b2cc = talisman.trigger.players_inside_talisman.size == 0 ? gettime() : undefined;
    
    while ( true )
    {
        if ( gettime() - var_a0da0f1f8520466e >= 500 )
        {
            var_a0da0f1f8520466e = gettime();
            var_6f47a89543a96d4c = talisman.trigger.players_inside_talisman.size;
            var_7589be1d135a74fe = level.talisman_system.var_2b0091f0c7d0a2fd && level.talisman_system.var_2b0091f0c7d0a2fd > 0 ? level.talisman_system.var_2b0091f0c7d0a2fd : 1;
            var_a5abf10fd441e88b = 10 / var_7589be1d135a74fe;
            talisman.charge += var_6f47a89543a96d4c * var_a5abf10fd441e88b / 4;
            talisman.banner function_f27ed9845d047a7a( talisman.charge );
            
            if ( talisman.charge >= level.talisman_system.var_557f3cd0c097ab37 )
            {
                talisman.banner utility::function_32b24db3127bff40( "reveal", "100_percent" );
                level thread set_talisman_state( talisman, "charged", diana );
                return;
            }
            
            if ( var_6f47a89543a96d4c == 0 )
            {
                var_9eb19c146134b2cc = var_9eb19c146134b2cc ? var_9eb19c146134b2cc : gettime();
                
                if ( gettime() - var_9eb19c146134b2cc >= 3000 )
                {
                    talisman.var_184ffc498effed19 = 1;
                    level thread set_talisman_state( talisman, "decharging", diana );
                    return;
                }
            }
            else
            {
                var_9eb19c146134b2cc = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0xc
// Checksum 0x2966fffb, Offset: 0x201c
// Size: 0xcb
function private function_8f37c6bba9068806()
{
    self notify( #"hash_e995bc9b7c07f8e1" );
    self endon( #"hash_e995bc9b7c07f8e1" );
    level endon( #"death" );
    level endon( #"hash_cf893de1f65a21ac" );
    
    if ( !isdefined( level.talisman_system.search_for_nearby_alive_players_for_talisman_charging_throttle ) )
    {
        level.talisman_system.search_for_nearby_alive_players_for_talisman_charging_throttle = throttle::throttle_initialize( "search_for_nearby_alive_players_for_talisman_charging_throttle", 1, 1 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.talisman_system.search_for_nearby_alive_players_for_talisman_charging_throttle, self );
        nearbyplayers = getplayersinradius( level.talisman_system.var_2c28be7abff7e769, 3000 );
        level.talisman_system.var_2b0091f0c7d0a2fd = nearbyplayers.size;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0xc
// Checksum 0xf0c0f7b3, Offset: 0x20ef
// Size: 0x15b
function private function_26c8ca89fbcea7f2()
{
    self notify( #"hash_34ff06a0f513fe52" );
    self endon( #"hash_34ff06a0f513fe52" );
    level endon( #"death" );
    
    if ( !isdefined( level.talisman_system.track_when_to_stop_tracking_nearby_alive_throttle ) )
    {
        level.talisman_system.track_when_to_stop_tracking_nearby_alive_throttle = throttle::throttle_initialize( "track_when_to_stop_tracking_nearby_alive_throttle", 1, 1 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.talisman_system.track_when_to_stop_tracking_nearby_alive_throttle, self );
        var_1386b9e2f161763e = 0;
        
        foreach ( talisman in level.talisman_system.talismans )
        {
            if ( talisman.state == "charging" )
            {
                var_1386b9e2f161763e = 1;
                break;
            }
        }
        
        if ( !var_1386b9e2f161763e )
        {
            level.talisman_system.var_42dd618734d04af2 = undefined;
            level.talisman_system.var_2b0091f0c7d0a2fd = undefined;
            level notify( #"hash_cf893de1f65a21ac" );
            return;
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xe43f5026, Offset: 0x2252
// Size: 0x1af
function private function_a0bd5e7f3eea98e3( talisman, diana )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_charged" );
    talisman.scriptable endon( #"talisman_charging" );
    talisman.scriptable endon( #"talisman_destroyed" );
    level thread function_c6bb7849ba397bf3( talisman );
    
    if ( !talisman.var_184ffc498effed19 )
    {
        wait 3;
    }
    
    talisman.var_184ffc498effed19 = undefined;
    talisman.scriptable utility::function_32b24db3127bff40( "state", "decharging" );
    talisman.banner utility::function_32b24db3127bff40( "state", "decharging" );
    var_ed59026bf3243f8d = gettime();
    
    while ( true )
    {
        if ( gettime() - var_ed59026bf3243f8d >= 250 )
        {
            var_ed59026bf3243f8d = gettime();
            talisman.charge -= 2.5;
            talisman.banner function_f27ed9845d047a7a( talisman.charge );
            
            if ( talisman.charge <= 0 )
            {
                talisman.charge = 0;
                talisman.charge_display = 0;
                talisman.banner utility::function_32b24db3127bff40( "reveal", "00_percent" );
                function_29e16944a2cc199c( talisman, 0 );
                set_talisman_state( talisman, "inactive", diana );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0xb8d9c496, Offset: 0x2409
// Size: 0x13d
function private function_f27ed9845d047a7a( charge )
{
    var_3541b972c1bdef70 = charge / level.talisman_system.var_557f3cd0c097ab37 * 100;
    
    if ( var_3541b972c1bdef70 <= 0 )
    {
        utility::function_32b24db3127bff40( "reveal", "00_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 10 )
    {
        utility::function_32b24db3127bff40( "reveal", "10_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 20 )
    {
        utility::function_32b24db3127bff40( "reveal", "20_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 30 )
    {
        utility::function_32b24db3127bff40( "reveal", "30_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 40 )
    {
        utility::function_32b24db3127bff40( "reveal", "40_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 50 )
    {
        utility::function_32b24db3127bff40( "reveal", "50_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 60 )
    {
        utility::function_32b24db3127bff40( "reveal", "60_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 70 )
    {
        utility::function_32b24db3127bff40( "reveal", "70_percent" );
        return;
    }
    
    if ( var_3541b972c1bdef70 < 80 )
    {
        utility::function_32b24db3127bff40( "reveal", "80_percent" );
        return;
    }
    
    utility::function_32b24db3127bff40( "reveal", "90_percent" );
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0xe7b05e53, Offset: 0x254e
// Size: 0xc7
function private function_a42769859da02826( talisman )
{
    if ( !talisman.charge_objid )
    {
        var_3017d07087bdb6c1 = level.var_a74764204d9643c;
        level.var_a74764204d9643c = undefined;
        talisman.charge_objid = zm_quest::function_b98d4144845ffc13( "tal_chg", 0, "sat_ui_hud_zm_assault_round_icon", undefined, "current", talisman.scriptable.origin + ( 0, 0, 50 ), 0 );
        objidpoolmanager::update_objective_setbackground( talisman.charge_objid, 1 );
        objidpoolmanager::objective_set_show_progress( talisman.charge_objid, 1 );
        objidpoolmanager::objective_set_progress( talisman.charge_objid, 0 );
        level.var_a74764204d9643c = var_3017d07087bdb6c1;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0xb1bb1944, Offset: 0x261d
// Size: 0x37
function private function_30d19ebe1259c991( talisman )
{
    if ( talisman.charge_objid )
    {
        objidpoolmanager::returnobjectiveid( talisman.charge_objid );
        talisman.charge_objid = undefined;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xe8152ee8, Offset: 0x265c
// Size: 0xbc
function private function_29e16944a2cc199c( talisman, progress = 0 )
{
    if ( talisman.charge_objid )
    {
        progress = clamp( progress, 0, 1 );
        objidpoolmanager::objective_set_progress( talisman.charge_objid, progress );
        
        if ( progress > 0 )
        {
            if ( talisman.state == "decharging" )
            {
                objidpoolmanager::update_objective_setneutrallabel( talisman.charge_objid, &"hash_7d68bfce1c771fd7" );
            }
            else
            {
                objidpoolmanager::update_objective_setneutrallabel( talisman.charge_objid, &"hash_6ec139c7cfedaf02" );
            }
            
            return;
        }
        
        objidpoolmanager::update_objective_setneutrallabel( talisman.charge_objid, &"" );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x8d2dcd92, Offset: 0x2720
// Size: 0x1a1
function private function_c6bb7849ba397bf3( talisman )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_charged" );
    talisman.scriptable endon( #"talisman_inactive" );
    talisman.scriptable endon( #"talisman_destroyed" );
    talisman.scriptable endon( #"talisman_charging" );
    talisman.scriptable endon( #"hash_77ff6d49d3b0dccf" );
    n_display = talisman.charge_display ?? function_536a258ae17afc40( talisman );
    n_last_target = function_536a258ae17afc40( talisman );
    var_eef2435b4425e4d3 = 0;
    var_a08731824a7c9a2f = 0;
    
    while ( true )
    {
        var_e40e771c883c3094 = function_536a258ae17afc40( talisman );
        
        if ( var_e40e771c883c3094 != n_last_target )
        {
            if ( var_a08731824a7c9a2f > 0 )
            {
                var_eef2435b4425e4d3 = ( var_e40e771c883c3094 - n_last_target ) / var_a08731824a7c9a2f;
            }
            
            n_last_target = var_e40e771c883c3094;
            var_a08731824a7c9a2f = 0;
        }
        
        n_projected = var_e40e771c883c3094 + var_eef2435b4425e4d3 * min( var_a08731824a7c9a2f, 1 );
        n_projected = clamp( n_projected, 0, 1 );
        n_display += ( n_projected - n_display ) * min( 0.2, 1 );
        
        if ( abs( n_projected - n_display ) < 0.001 )
        {
            n_display = n_projected;
        }
        
        talisman.charge_display = n_display;
        function_29e16944a2cc199c( talisman, n_display );
        var_a08731824a7c9a2f += 0.05;
        wait 0.05;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0xdde543a6, Offset: 0x28c9
// Size: 0x44
function private function_536a258ae17afc40( talisman )
{
    charge = talisman.charge ?? 0;
    return clamp( charge / level.talisman_system.var_557f3cd0c097ab37, 0, 1 );
}

// Namespace zm_sat_hornet_talisman
// Params 3, eflags: 0x4
// Checksum 0xfd398e92, Offset: 0x2916
// Size: 0x376
function private function_2935cfd1533704bf( talisman, diana, var_a53620d5600638e5 )
{
    function_111c6a84c810ffd5( talisman.scriptable.origin, 240 );
    talisman.active_start_time = gettime();
    
    if ( diana && isalive( diana ) && isdefined( diana.var_522fe5be5b52b8df ) && !level.talisman_system.var_6e849cb6ef5166a9 )
    {
        level.talisman_system.var_6e849cb6ef5166a9 = diana.var_522fe5be5b52b8df;
        diana zombie_diana_winged_tornado_attack::function_c1f639281246500a( 0 );
    }
    
    if ( !talisman.var_833fa5c081e5e9e5 )
    {
        talisman.badplaceid = function_8bf6c5fe849106c4( talisman.scriptable.origin, talisman.scriptable.angles, 10, 240, 100 );
        talisman.zombieattractor = zombie_attractor_manager::add_attractor( talisman.scriptable, 1, 240, 0, &function_56cc52510ed5b1db, &zombie_attractor_validate );
        level thread function_11599172dafbe6ff( talisman );
        level notify( #"hash_7748191fb2849b3b", talisman );
    }
    else
    {
        talisman.var_833fa5c081e5e9e5 = undefined;
    }
    
    if ( var_a53620d5600638e5 )
    {
        level utility::waittill_notify_or_timeout( "fast_travel_into_boss_arena_complete", 30 );
    }
    else
    {
        var_c5718053c8bb323f = talisman.scriptable utility::waittill_any_in_array_or_timeout( [ "talisman_destroyed", "talisman_hidden", "talisman_activated_via_locust_powerup", "death" ], level.talisman_system.var_b084bbe7334df291 );
    }
    
    if ( diana && isalive( diana ) && var_c5718053c8bb323f == "timeout" )
    {
        if ( diana getaiblackboarddynamic( "in_necrotic_beam" ) || diana getaiblackboarddynamic( "in_necrotic_projectile" ) || diana getaiblackboarddynamic( "in_necrotic_fan" ) )
        {
            diana utility::waittill_any_in_array_or_timeout( [ "necrotic_beam_end", "necrotic_projectile_end", "necrotic_fan_aoe_finished" ], 10 );
        }
        
        if ( level.var_d93860aec3ce5714 )
        {
            level waittill( #"necrotic_fan_aoe_finished" );
        }
        
        wait randomfloat( 1 );
    }
    
    if ( var_a53620d5600638e5 || var_c5718053c8bb323f != "talisman_activated_via_locust_powerup" )
    {
        if ( talisman.badplaceid )
        {
            destroynavobstacle( talisman.badplaceid );
            talisman.badplaceid = undefined;
        }
        
        if ( talisman.zombieattractor )
        {
            zombie_attractor_manager::remove_attractor( talisman.zombieattractor );
            talisman.zombieattractor = undefined;
        }
        
        level.talisman_system.active_talismans = arrayremove( level.talisman_system.active_talismans, talisman );
        
        if ( isdefined( level.talisman_system.var_6e849cb6ef5166a9 ) && level.talisman_system.active_talismans.size == 0 )
        {
            if ( diana && isalive( diana ) )
            {
                diana zombie_diana_winged_tornado_attack::function_c1f639281246500a( level.talisman_system.var_6e849cb6ef5166a9 );
            }
            
            level.talisman_system.var_6e849cb6ef5166a9 = undefined;
        }
        
        if ( var_a53620d5600638e5 || var_c5718053c8bb323f == "timeout" )
        {
            set_talisman_state( talisman, "destroyed", diana, var_a53620d5600638e5 );
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xad99f3df, Offset: 0x2c94
// Size: 0x208
function private function_111c6a84c810ffd5( talismanorigin, var_d346497e1b44655d )
{
    var_92e2905d6d306c4c = getaiarrayinradius( talismanorigin, var_d346497e1b44655d, "team_two_hundred" );
    
    foreach ( var_3dacb5c7d3509269 in var_92e2905d6d306c4c )
    {
        if ( var_3dacb5c7d3509269.noragdoll || var_3dacb5c7d3509269.script_noragdoll )
        {
            var_3dacb5c7d3509269.forceannihilate = 1;
        }
        else
        {
            var_5578caa0fe2c139e = 2000;
            var_fae092e301affe78 = 15;
            var_94322c56585b8489 = vectornormalize2( var_3dacb5c7d3509269.origin - talismanorigin );
            var_81b926fa18ad27d6 = vectorcross( var_94322c56585b8489, ( 0, 0, 1 ) );
            impactvector = rotatepointaroundvector( var_81b926fa18ad27d6, var_94322c56585b8489, var_fae092e301affe78 );
            var_3dacb5c7d3509269.ragdollimpactvector = impactvector * var_5578caa0fe2c139e;
            var_3dacb5c7d3509269.ragdollhitloc = "torso_lower";
            var_3dacb5c7d3509269.ragdoll_damagelocation_none = "torso_lower";
            var_3dacb5c7d3509269.forceragdollimmediate = 1;
        }
        
        var_49f8800a24c64dee = anglestoforward( var_3dacb5c7d3509269.angles );
        
        if ( var_49f8800a24c64dee == ( 0, 0, 0 ) )
        {
            var_49f8800a24c64dee = ( 0, 1, 0 );
        }
        
        var_baa6c7c3d5ff08be = anglestoup( var_3dacb5c7d3509269.angles );
        
        if ( var_baa6c7c3d5ff08be == ( 0, 0, 0 ) )
        {
            var_baa6c7c3d5ff08be = ( 0, 0, 1 );
        }
        
        playfx( utility::getfx( "zm_sat_hornet_talisman_impact" ), var_3dacb5c7d3509269.origin + var_3dacb5c7d3509269 getboundsmidpoint(), var_49f8800a24c64dee, var_baa6c7c3d5ff08be );
        var_3dacb5c7d3509269 kill();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xfa62bded, Offset: 0x2ea4
// Size: 0xba
function private function_56cc52510ed5b1db( attractor, zombie )
{
    talismanshield = attractor.source;
    offset = vectornormalize2( zombie.origin - talismanshield.origin );
    
    if ( talismanshield.trigger.players_inside_talisman && talismanshield.trigger.players_inside_talisman.size == level.players.size )
    {
        return ( talismanshield.origin + offset * 240 );
    }
    
    goalpoint = talismanshield.origin + offset;
    return goalpoint;
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xedf31803, Offset: 0x2f67
// Size: 0x37, Type: bool
function private zombie_attractor_validate( attractor, zombie )
{
    return attractor.source.trigger.players_inside_talisman.size > 0;
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0xecf5fe13, Offset: 0x2fa7
// Size: 0x151
function private function_11599172dafbe6ff( talisman )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_destroyed" );
    talisman.scriptable endon( #"talisman_hidden" );
    
    while ( true )
    {
        talisman.trigger waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent, 0, 1 ) && !ent.var_f468cf5c9e75db1 )
        {
            if ( ent val::get( "damage" ) )
            {
                ent val::set( "talisman_shield", "damage", 0 );
                ent val::set( "talisman_shield", "ignoreme", 1 );
                ent.var_f468cf5c9e75db1 = 1;
                pbgpostfxbundlestart( ent, "sat_zm_talisman_shield" );
            }
            
            talisman.trigger.players_inside_talisman = arraycombineunique( talisman.trigger.players_inside_talisman, [ ent ] );
            ent thread function_f6d4fc413fd22226( talisman );
            
            if ( !talisman.var_221539dbf1cc4bbb )
            {
                talisman.var_221539dbf1cc4bbb = 1;
                level thread function_221539dbf1cc4bbb( talisman );
            }
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x4b2111cc, Offset: 0x3100
// Size: 0x108
function private function_221539dbf1cc4bbb( talisman )
{
    talisman.scriptable utility::waittill_any_in_array_or_timeout( [ "talisman_destroyed", "talisman_hidden" ], level.talisman_system.var_b084bbe7334df291 );
    
    foreach ( player in talisman.trigger.players_inside_talisman )
    {
        player val::reset( "talisman_shield", "damage" );
        player val::reset( "talisman_shield", "ignoreme" );
        player.var_f468cf5c9e75db1 = undefined;
        pbgpostfxbundleend( player, "sat_zm_talisman_shield" );
    }
    
    talisman.var_221539dbf1cc4bbb = undefined;
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0xc21a5e02, Offset: 0x3210
// Size: 0x11d
function private function_f6d4fc413fd22226( talisman )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_destroyed" );
    self endon( #"death_or_disconnect" );
    var_f91915c5ed4119b0 = 15;
    var_f10794adbedb27a7 = squared( 240 + var_f91915c5ed4119b0 );
    thread function_6f25dddf8663694b( talisman );
    
    while ( true )
    {
        if ( distance2dsquared( self.origin, talisman.scriptable.origin ) > var_f10794adbedb27a7 )
        {
            val::reset( "talisman_shield", "damage" );
            val::reset( "talisman_shield", "ignoreme" );
            self.var_f468cf5c9e75db1 = undefined;
            pbgpostfxbundleend( self, "sat_zm_talisman_shield" );
            talisman.trigger.players_inside_talisman = arrayremove( talisman.trigger.players_inside_talisman, self );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x6cb3498e, Offset: 0x3335
// Size: 0xc2
function private function_6f25dddf8663694b( talisman )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_destroyed" );
    self waittill( #"death_or_disconnect" );
    val::reset( "talisman_shield", "damage" );
    val::reset( "talisman_shield", "ignoreme" );
    self.var_f468cf5c9e75db1 = undefined;
    pbgpostfxbundleend( self, "sat_zm_talisman_shield" );
    talisman.trigger.players_inside_talisman = arrayremove( talisman.trigger.players_inside_talisman, self );
}

// Namespace zm_sat_hornet_talisman
// Params 11
// Checksum 0x59441fab, Offset: 0x33ff
// Size: 0xc0
function function_aea918576079ee14( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.type ) ) || instance.type != "zm_sat_hornet_talisman" || isplayer( eattacker ) || weapon_utility::isbulletweapon( objweapon ) )
    {
        return;
    }
    
    playfx( utility::getfx( "zm_sat_hornet_talisman_impact" ), vpoint, vectortoangles( vdir ) );
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0x609ec1a, Offset: 0x34c7
// Size: 0x5f5
function private function_2f8ac1abfef1ef65( attacker, projectile )
{
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    var_d9e7a6316937016f = 135;
    var_33bb9f26c26585f5 = 0.9;
    
    if ( !level.talisman_system )
    {
        return;
    }
    
    fireorigin = projectile.origin;
    firedir = anglestoforward( projectile.angles );
    targettalisman = undefined;
    closestdistsq = undefined;
    
    foreach ( talisman in level.talisman_system.talismans )
    {
        if ( !talisman.banner )
        {
            continue;
        }
        
        if ( talisman.state == "hidden" || talisman.state == "charged" || talisman.state == "active" || talisman.state == "destroyed" )
        {
            continue;
        }
        
        var_9b32067af83592aa = vectornormalize( talisman.banner.origin - fireorigin );
        
        if ( vectordot( firedir, var_9b32067af83592aa ) <= var_33bb9f26c26585f5 )
        {
            continue;
        }
        
        distsq = distancesquared( fireorigin, talisman.banner.origin );
        
        if ( !closestdistsq || distsq < closestdistsq )
        {
            closestdistsq = distsq;
            targettalisman = talisman;
        }
    }
    
    if ( !targettalisman )
    {
        return;
    }
    
    bannerorigin = targettalisman.banner.origin + ( 0, 0, var_d9e7a6316937016f );
    bannerangles = targettalisman.banner.angles;
    bannerforward = anglestoforward( bannerangles );
    bannerright = anglestoright( bannerangles );
    bannerup = anglestoup( bannerangles );
    prevorigin = projectile.origin;
    
    while ( isdefined( projectile ) )
    {
        /#
            if ( getdvarint( @"hash_f0707c8acd95ee2d", 0 ) )
            {
                hf = bannerforward * 1;
                hr = bannerright * 25;
                hu = bannerup * 55;
                c = [];
                c[ 0 ] = bannerorigin + hf + hr + hu;
                c[ 1 ] = bannerorigin + hf + hr - hu;
                c[ 2 ] = bannerorigin + hf - hr - hu;
                c[ 3 ] = bannerorigin + hf - hr + hu;
                c[ 4 ] = bannerorigin - hf + hr + hu;
                c[ 5 ] = bannerorigin - hf + hr - hu;
                c[ 6 ] = bannerorigin - hf - hr - hu;
                c[ 7 ] = bannerorigin - hf - hr + hu;
                
                for ( i = 0; i < 4 ; i++ )
                {
                    j = i + 1;
                    
                    if ( j == 4 )
                    {
                        j = 0;
                    }
                    
                    line( c[ i ], c[ j ], ( 1, 1, 0 ), 1, 0, 1 );
                    line( c[ i + 4 ], c[ j + 4 ], ( 1, 1, 0 ), 1, 0, 1 );
                    line( c[ i ], c[ i + 4 ], ( 1, 1, 0 ), 1, 0, 1 );
                }
                
                sphere( projectile.origin, 5 );
            }
        #/
        
        prevoffset = prevorigin - bannerorigin;
        curoffset = projectile.origin - bannerorigin;
        prevlocal = ( vectordot( prevoffset, bannerforward ), vectordot( prevoffset, bannerright ), vectordot( prevoffset, bannerup ) );
        curlocal = ( vectordot( curoffset, bannerforward ), vectordot( curoffset, bannerright ), vectordot( curoffset, bannerup ) );
        dir = curlocal - prevlocal;
        halfsizes = ( 1, 25, 55 );
        tnear = 0;
        tfar = 1;
        hit = 1;
        
        for ( axis = 0; axis < 3 ; axis++ )
        {
            if ( abs( dir[ axis ] ) < 0.001 )
            {
                if ( abs( prevlocal[ axis ] ) > halfsizes[ axis ] )
                {
                    hit = 0;
                    break;
                }
                
                continue;
            }
            
            invd = 1 / dir[ axis ];
            t1 = ( halfsizes[ axis ] * -1 - prevlocal[ axis ] ) * invd;
            t2 = ( halfsizes[ axis ] - prevlocal[ axis ] ) * invd;
            
            if ( t1 > t2 )
            {
                temp = t1;
                t1 = t2;
                t2 = temp;
            }
            
            if ( t1 > tnear )
            {
                tnear = t1;
            }
            
            if ( t2 < tfar )
            {
                tfar = t2;
            }
            
            if ( tnear > tfar )
            {
                hit = 0;
                break;
            }
        }
        
        if ( hit && tnear <= 1 && tfar >= 0 )
        {
            hitt = max( tnear, 0 );
            var_947af1d9e97ce417 = prevorigin + ( projectile.origin - prevorigin ) * hitt;
            vdir = vectornormalize( bannerorigin - var_947af1d9e97ce417 );
            playfx( utility::getfx( "zm_sat_hornet_talisman_banner_hornetww_impact" ), var_947af1d9e97ce417, vectortoangles( vdir ) );
            level thread function_3195cad9f5c00cdd( targettalisman );
            projectile delete();
        }
        
        prevorigin = projectile.origin;
        waitframe();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x8cfcda13, Offset: 0x3ac4
// Size: 0xe9
function private function_3195cad9f5c00cdd( talisman )
{
    talisman.charge = min( ( talisman.charge ?? 0 ) + 0.5, level.talisman_system.var_557f3cd0c097ab37 );
    talisman.banner function_f27ed9845d047a7a( talisman.charge );
    
    if ( talisman.charge >= level.talisman_system.var_557f3cd0c097ab37 )
    {
        talisman.banner utility::function_32b24db3127bff40( "reveal", "100_percent" );
        level thread set_talisman_state( talisman, "charged" );
        return;
    }
    
    if ( talisman.state == "inactive" || talisman.state == "decharging" )
    {
        level thread set_talisman_state( talisman, "charging" );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 3, eflags: 0x4
// Checksum 0xdde72f8f, Offset: 0x3bb5
// Size: 0x3bc
function private on_talisman_destroyed( talisman, diana, var_816207f294094f8c )
{
    talisman.scriptable endon( #"hash_baf2ca2ae7346c23" );
    var_344e54e22d04a279 = 4;
    level thread function_179bdb5657d84a4e( talisman, diana );
    
    if ( var_816207f294094f8c )
    {
        orionspawnpos = utility::drop_to_ground( ( 33349, 41664, 16683 ) );
    }
    else
    {
        orionspawnpos = get_orion_spawn_position( talisman );
        wait randomfloatrange( 7, 13 );
    }
    
    level thread function_337951b39c5dd9bd( talisman, orionspawnpos );
    talisman.scriptable utility::waittill_notify_or_timeout( "transition_trails_done", var_344e54e22d04a279 );
    
    if ( var_816207f294094f8c )
    {
        talisman.talisman_destroyed_orion_banner = utility::spawn_model( "zm_sat_hornet_talisman_orion_banner", orionspawnpos, ( 0, 45, 0 ) );
        talisman.talisman_destroyed_orion_banner utility::function_32b24db3127bff40( "state", "on_ground" );
        talisman.talisman_destroyed_orion_banner.trigger = spawn( "noent_volume_trigger_rotatable_radius", orionspawnpos, 0, 76, 76 );
        level thread function_77630afda3d0852d( talisman, var_816207f294094f8c );
        return;
    }
    
    orionaitype = function_b3988325430ce242( "zombie_orion" );
    
    if ( !isdefined( orionaitype ) )
    {
        return;
    }
    
    orionspawnangles = vectortoangles( orionspawnpos - talisman.scriptable.origin );
    orion = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( orionaitype, orionspawnpos, orionspawnangles, "team_two_hundred" );
    
    while ( !orion )
    {
        zombies = arrayrandomize( getaiarray( zm_utility::get_zombie_team() ) );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || zombie.subclass == "zombie_diana" )
            {
                continue;
            }
            
            zombie.nocorpse = 1;
            zombie kill();
            waitframe();
            waitframe();
            break;
        }
        
        orion = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( orionaitype, orionspawnpos, orionspawnangles, "team_two_hundred" );
        
        if ( orion )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( orion )
    {
        talisman.orion = orion;
        orion.spawn_fast = 1;
        orion thread function_415bf80f35f4ed56();
        bannerpos = orion gettagorigin( "J_SpineLower" );
        orion.banner = utility::spawn_model( "zm_sat_hornet_talisman_orion_banner", bannerpos, orion.angles );
        orion.banner utility::function_32b24db3127bff40( "state", "orion_carrying" );
        orion.banner linkto( orion, "J_SpineLower", ( getdvarfloat( @"hash_a474fc92daba1156", 0 ), getdvarfloat( @"hash_a474fd92daba1389", 4.2 ), 0 ), ( 90, 0, 0 ) );
        orion.talisman = talisman;
        n_round = zm_utility::get_round_number();
        n_round = max( n_round, zm_sat_hornet_boss_fight::function_b80976b7930587b4() ?? 30 );
        
        if ( orion zombie_utils::get_zombie_round_difficulty() < n_round )
        {
            orion zombie_utils::set_zombie_round_difficulty( n_round, 1, 1 );
        }
        
        orion.no_powerups = 1;
        orion zombie_utils::function_a8ce00e0448cb6f0( "sprint", "talisman", 1 );
        orion val::set( "talisman_system", "ammomod_immune", 1 );
        orion callback::add( "on_zombie_ai_killed", &function_b502cfd8de0bdcfc );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0x4
// Checksum 0x91c92290, Offset: 0x3f79
// Size: 0x31
function private function_415bf80f35f4ed56()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    wait 0.5;
    utility::function_32b24db3127bff40( "icon", "active_force_top" );
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x87a616e1, Offset: 0x3fb2
// Size: 0xf9
function private get_orion_spawn_position( talisman )
{
    var_b6dca47e2f373aa0 = 20;
    
    for ( var_7c4b354d7b13cb9e = 0; var_7c4b354d7b13cb9e <= var_b6dca47e2f373aa0 ; var_7c4b354d7b13cb9e++ )
    {
        var_c546775ba48c1d2a = ai::function_7bcb54b16c07d1ec( 1, talisman.scriptable.origin, 80, 600, 400, undefined, undefined, undefined, undefined, var_b6dca47e2f373aa0 );
        
        if ( var_c546775ba48c1d2a.size > 0 )
        {
            if ( level.talisman_system.var_c9011c3f44522697 )
            {
                var_3e3f7c8ef0a5dda5 = var_c546775ba48c1d2a[ 0 ];
                
                if ( distance2dsquared( var_3e3f7c8ef0a5dda5, level.talisman_system.var_c9011c3f44522697.tetherpoint ) <= squared( level.talisman_system.var_c9011c3f44522697.tetherradius ) )
                {
                    return var_3e3f7c8ef0a5dda5;
                }
                
                continue;
            }
            
            return var_c546775ba48c1d2a[ 0 ];
        }
    }
    
    return talisman.scriptable.origin;
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xa8ffe381, Offset: 0x40b4
// Size: 0x2f9
function private function_179bdb5657d84a4e( talisman, diana )
{
    talisman.scriptable endon( #"death" );
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.scriptable endon( #"talisman_inactive" );
    talisman.scriptable endon( #"hash_baf2ca2ae7346c23" );
    talisman.scriptable endon( #"talisman_destroyed" );
    
    while ( true )
    {
        talisman.trigger waittill( #"trigger", ent );
        
        if ( ent.var_74112479b8333c3a )
        {
            level.talisman_system.var_e82e1fde1eac3e75 = arrayremove( level.talisman_system.var_e82e1fde1eac3e75, ent );
            
            if ( level.talisman_system.var_e82e1fde1eac3e75.size == 0 )
            {
                foreach ( destroyedtalisman in level.talisman_system.destroyed_talismans )
                {
                    destroyedtalisman.scriptable utility::function_32b24db3127bff40( "state", "destroyed" );
                }
            }
            
            originaltalisman = ent.var_74112479b8333c3a;
            ent callback::remove( #"player_disconnect", &function_ab5eddc5386c6c5e );
            ent callback::remove( #"player_death", &function_306481ca7e8657c1 );
            ent callback::remove( #"player_laststand", &function_b50749195a106daa );
            ent callback::remove( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
            ent callback::remove( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
            originaltalisman.talisman_destroyed_orion_banner delete();
            originaltalisman.talisman_destroyed_orion_banner = undefined;
            originaltalisman.var_62b3d40b0824ee20 = undefined;
            ent.var_74112479b8333c3a = undefined;
            talisman.var_e5b35d7d2ef5c8b2 = 1;
            ent notify( #"hash_c5d7a6cc65090420" );
            ent setclientomnvar( "ui_hud_carried_item_index", 10 );
            ent setclientomnvar( "ui_hud_carried_item_count", 0 );
            
            if ( ent.var_6f5a1af8d811af87 )
            {
                level thread zm_quest::update_guidance( undefined, #"hornet_boss_fight_guidance", #"deliver_banner" );
                ent.var_6f5a1af8d811af87 = undefined;
                level.var_62b3ff7bb81cf843 = 1;
            }
            
            level callback::callback( "on_hornet_boss_talisman_repaired", { #talisman:talisman, #player:ent } );
            level thread set_talisman_state( talisman, "inactive", diana );
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xbdac729f, Offset: 0x43b5
// Size: 0x1e9
function private function_337951b39c5dd9bd( talisman, orionspawnpos )
{
    level endon( #"game_ended" );
    talisman.scriptable endon( #"hash_baf2ca2ae7346c23" );
    talisman.scriptable endon( #"talisman_destroyed" );
    var_48eaf7a66133360d = 4;
    var_a2a135273c789693 = 50;
    var_dd0f62546f87db3d = 300;
    var_8990d6d7140b3622 = 1;
    var_5ce1d3d8ebdbb850 = talisman.scriptable.origin + ( 0, 0, 0 + var_a2a135273c789693 );
    talisman.var_712c628c05be5736 = utility::spawn_model( "zm_sat_hornet_talisman_orion_trail", var_5ce1d3d8ebdbb850 );
    talisman.var_712c628c05be5736 utility::function_7c10ea82c1e305b8( "transition_trail", "on" );
    talisman.var_712c628c05be5736 thread utility::function_9a9165839779317f( talisman.var_712c628c05be5736, "talisman_destroyed" );
    talisman.var_712c628c05be5736 utility::delaycall( var_48eaf7a66133360d, &delete );
    var_35c5d54ae028c5cb = ( orionspawnpos + var_5ce1d3d8ebdbb850 ) / 2 + ( 0, 0, randomintrange( int( var_dd0f62546f87db3d / 2 ), int( var_dd0f62546f87db3d * 2 ) ) );
    talisman.var_712c628c05be5736 thread utility::function_8001268940441423( var_5ce1d3d8ebdbb850, orionspawnpos, var_35c5d54ae028c5cb, var_48eaf7a66133360d, 0, 1, 1 );
    wait var_48eaf7a66133360d;
    
    if ( talisman.var_712c628c05be5736 )
    {
        talisman.var_712c628c05be5736 utility::function_32b24db3127bff40( "impact", "on" );
    }
    
    wait var_8990d6d7140b3622;
    
    if ( talisman.var_712c628c05be5736 )
    {
        talisman.var_712c628c05be5736 delete();
        talisman.var_712c628c05be5736 = undefined;
    }
    
    if ( talisman.scriptable )
    {
        talisman.scriptable notify( #"transition_trails_done" );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x1ed4d95d, Offset: 0x45a6
// Size: 0x108
function private function_b502cfd8de0bdcfc( params )
{
    if ( self.banner )
    {
        self.banner delete();
    }
    
    talisman = self.talisman;
    
    if ( !self.var_903fc8bde3d8fb01 )
    {
        talisman.talisman_destroyed_orion_banner = utility::spawn_model( "zm_sat_hornet_talisman_orion_banner", self.origin, self.angles );
        talisman.talisman_destroyed_orion_banner utility::function_32b24db3127bff40( "state", "on_ground" );
        talisman.talisman_destroyed_orion_banner.trigger = spawn( "noent_volume_trigger_rotatable_radius", self.origin, 0, 76, 76 );
        
        if ( talisman.talisman_destroyed_orion_banner.trigger )
        {
            level thread function_77630afda3d0852d( talisman );
        }
        else if ( talisman.talisman_destroyed_orion_banner )
        {
            talisman.talisman_destroyed_orion_banner delete();
        }
    }
    
    talisman.orion = undefined;
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xdaaeacbb, Offset: 0x46b6
// Size: 0xda
function private function_77630afda3d0852d( talisman, var_816207f294094f8c )
{
    talisman.scriptable endon( #"hash_ad7f1f996c6c34f8" );
    
    while ( talisman.talisman_destroyed_orion_banner.trigger )
    {
        talisman.talisman_destroyed_orion_banner.trigger waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent, 0, 0 ) && !ent.var_74112479b8333c3a && ( !ent.var_6ce1b4bb7c7cdeb9 || gettime() >= ent.var_6ce1b4bb7c7cdeb9 ) && !ent.var_9dabcc4edb9438f )
        {
            ent.var_6ce1b4bb7c7cdeb9 = undefined;
            ent pick_up_orion_banner( talisman, var_816207f294094f8c );
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0xcdf216fb, Offset: 0x4798
// Size: 0x3a3
function private pick_up_orion_banner( talisman, var_816207f294094f8c )
{
    self.var_74112479b8333c3a = talisman;
    
    if ( !isdefined( level.talisman_system.var_e82e1fde1eac3e75 ) )
    {
        level.talisman_system.var_e82e1fde1eac3e75 = [];
    }
    
    level.talisman_system.var_e82e1fde1eac3e75 = arraycombineunique( level.talisman_system.var_e82e1fde1eac3e75, [ self ] );
    var_c83739ff04573fc1 = self gettagorigin( "tag_shield_back", 1 );
    var_df6e65e2e39ac1cf = self gettagangles( "tag_shield_back", 1 );
    
    if ( !var_c83739ff04573fc1 && !var_df6e65e2e39ac1cf )
    {
        return;
    }
    
    if ( var_816207f294094f8c && zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_guidance( undefined, #"hornet_boss_fight_guidance", #"deliver_banner" );
        self.var_6f5a1af8d811af87 = 1;
        params = { #var_b0e2d22682bc49e2:1 };
    }
    
    var_b00d2a2b31ddb4a9 = utility::spawn_model( "zm_sat_hornet_talisman_orion_banner", var_c83739ff04573fc1, var_df6e65e2e39ac1cf );
    var_b00d2a2b31ddb4a9 utility::function_32b24db3127bff40( "state", "player_carrying" );
    var_b00d2a2b31ddb4a9 linkto( self, "J_SpineLower", ( getdvarfloat( @"hash_a474fc92daba1156", -25 ), 4.2, 0 ), ( 90, 0, 0 ) );
    
    if ( !self getcamerathirdperson() )
    {
        var_b00d2a2b31ddb4a9 hidefromplayer( self );
        var_b00d2a2b31ddb4a9.var_b8e0555630cd7c3a = 0;
    }
    else
    {
        var_b00d2a2b31ddb4a9.var_b8e0555630cd7c3a = 1;
    }
    
    thread function_4827087fd1f54643();
    talisman.var_62b3d40b0824ee20 = self;
    thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    callback::add( #"player_disconnect", &function_ab5eddc5386c6c5e, params );
    callback::add( #"player_death", &function_306481ca7e8657c1, params );
    callback::add( #"player_laststand", &function_b50749195a106daa, params );
    callback::add( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac, params );
    callback::add( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb, params );
    thread function_4a51c21e389ef090( talisman );
    
    if ( talisman.talisman_destroyed_orion_banner )
    {
        talisman.talisman_destroyed_orion_banner.trigger delete();
        talisman.talisman_destroyed_orion_banner delete();
        talisman.talisman_destroyed_orion_banner.trigger = undefined;
    }
    
    talisman.talisman_destroyed_orion_banner = var_b00d2a2b31ddb4a9;
    level callback::callback( "on_hornet_boss_banner_picked_up", { #talisman:talisman, #player:self } );
    
    if ( level.talisman_system.var_e82e1fde1eac3e75.size == 1 )
    {
        foreach ( destroyedtalisman in level.talisman_system.destroyed_talismans )
        {
            destroyedtalisman.scriptable utility::function_32b24db3127bff40( "state", "banner_picked_up" );
            destroyedtalisman.banner utility::function_32b24db3127bff40( "state", "destroyed" );
        }
    }
    
    self setclientomnvar( "ui_hud_carried_item_index", 10 );
    self setclientomnvar( "ui_hud_carried_item_count", 1 );
    talisman.scriptable notify( #"hash_ad7f1f996c6c34f8" );
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0xc
// Checksum 0x50467e06, Offset: 0x4b43
// Size: 0xf6
function private function_4827087fd1f54643()
{
    self notify( #"hash_4e876d879cb0e616" );
    self endon( #"hash_4e876d879cb0e616" );
    self endon( #"death" );
    
    while ( self.var_74112479b8333c3a.talisman_destroyed_orion_banner )
    {
        self waittill( #"hash_79c6d8e931c7139d" );
        
        if ( self.var_74112479b8333c3a.talisman_destroyed_orion_banner.var_b8e0555630cd7c3a )
        {
            self.var_74112479b8333c3a.talisman_destroyed_orion_banner hidefromplayer( self );
            self.var_74112479b8333c3a.talisman_destroyed_orion_banner.var_b8e0555630cd7c3a = 0;
            continue;
        }
        
        if ( self.var_74112479b8333c3a.talisman_destroyed_orion_banner )
        {
            self.var_74112479b8333c3a.talisman_destroyed_orion_banner showtoplayer( self );
            self.var_74112479b8333c3a.talisman_destroyed_orion_banner.var_b8e0555630cd7c3a = 1;
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x4cf65fde, Offset: 0x4c41
// Size: 0x8e
function private function_4a51c21e389ef090( talisman )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c5d7a6cc65090420" );
    
    if ( getdvarint( @"hash_e5f722886d4a403", 0 ) && !isbot( self ) )
    {
        self notifyonplayercommand( "talisman_drop_banner_notify", "+stance" );
        self notifyonplayercommand( "talisman_drop_banner_notify", "+prone" );
        self notifyonplayercommand( "talisman_drop_banner_notify", "+movedown" );
    }
    
    while ( true )
    {
        self waittill( #"talisman_drop_banner_notify" );
        drop_orion_banner( talisman );
        return;
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2, eflags: 0x4
// Checksum 0x9bed155a, Offset: 0x4cd7
// Size: 0x24b
function private drop_orion_banner( talisman, var_b0e2d22682bc49e2 )
{
    level.talisman_system.var_e82e1fde1eac3e75 = arrayremove( level.talisman_system.var_e82e1fde1eac3e75, self );
    
    if ( level.talisman_system.var_e82e1fde1eac3e75.size == 0 )
    {
        foreach ( destroyedtalisman in level.talisman_system.destroyed_talismans )
        {
            destroyedtalisman.scriptable utility::function_32b24db3127bff40( "state", "destroyed" );
        }
    }
    
    talisman.talisman_destroyed_orion_banner delete();
    talisman.talisman_destroyed_orion_banner = undefined;
    talisman.var_62b3d40b0824ee20 = undefined;
    self.var_74112479b8333c3a = undefined;
    var_716c241e1f99afba = utility::drop_to_ground( getclosestpointonnavmesh( self.origin ) );
    talisman.talisman_destroyed_orion_banner = utility::spawn_model( "zm_sat_hornet_talisman_orion_banner", var_716c241e1f99afba, self.angles );
    talisman.talisman_destroyed_orion_banner utility::function_32b24db3127bff40( "state", "on_ground" );
    talisman.talisman_destroyed_orion_banner.trigger = spawn( "noent_volume_trigger_rotatable_radius", var_716c241e1f99afba, 0, 76, 76 );
    level thread function_77630afda3d0852d( talisman, var_b0e2d22682bc49e2 );
    callback::remove( #"player_disconnect", &function_ab5eddc5386c6c5e );
    callback::remove( #"player_death", &function_306481ca7e8657c1 );
    callback::remove( #"player_laststand", &function_b50749195a106daa );
    callback::remove( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
    callback::remove( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
    self.var_6ce1b4bb7c7cdeb9 = gettime() + 1500;
    self setclientomnvar( "ui_hud_carried_item_index", 10 );
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self notify( #"hash_c5d7a6cc65090420" );
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0xb5d98cfe, Offset: 0x4f2a
// Size: 0x4a
function function_ab5eddc5386c6c5e( params )
{
    self.var_6f5a1af8d811af87 = undefined;
    var_b0e2d22682bc49e2 = params.var_b0e2d22682bc49e2;
    talisman = self.var_74112479b8333c3a;
    drop_orion_banner( talisman, var_b0e2d22682bc49e2 );
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0xd8db114d, Offset: 0x4f7c
// Size: 0x4a
function function_306481ca7e8657c1( params )
{
    self.var_6f5a1af8d811af87 = undefined;
    var_b0e2d22682bc49e2 = params.var_b0e2d22682bc49e2;
    talisman = self.var_74112479b8333c3a;
    drop_orion_banner( talisman, var_b0e2d22682bc49e2 );
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0x34d60f25, Offset: 0x4fce
// Size: 0x4a
function function_b50749195a106daa( params )
{
    self.var_6f5a1af8d811af87 = undefined;
    var_b0e2d22682bc49e2 = params.var_b0e2d22682bc49e2;
    talisman = self.var_74112479b8333c3a;
    drop_orion_banner( talisman, var_b0e2d22682bc49e2 );
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0xc53c047, Offset: 0x5020
// Size: 0x6b
function function_15d45e40acfbebac( params )
{
    if ( params.streakname == "zm_dinj" && self.var_74112479b8333c3a )
    {
        self.var_6f5a1af8d811af87 = undefined;
        var_b0e2d22682bc49e2 = params.var_b0e2d22682bc49e2;
        talisman = self.var_74112479b8333c3a;
        drop_orion_banner( talisman, var_b0e2d22682bc49e2 );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 1
// Checksum 0x7eddc46f, Offset: 0x5093
// Size: 0x56
function function_ae5b33fac9103bfb( params )
{
    if ( self.var_74112479b8333c3a )
    {
        self.var_6f5a1af8d811af87 = undefined;
        var_b0e2d22682bc49e2 = params.var_b0e2d22682bc49e2;
        talisman = self.var_74112479b8333c3a;
        drop_orion_banner( talisman, var_b0e2d22682bc49e2 );
    }
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0xc
// Checksum 0xe859c13e, Offset: 0x50f1
// Size: 0x1fa
function private function_a8d4794791369ce()
{
    self notify( #"hash_a59ebbcc242b83f1" );
    self endon( #"hash_a59ebbcc242b83f1" );
    level endon( #"game_ended" );
    level endon( #"end_talisman_system" );
    
    while ( true )
    {
        wait 3;
        
        if ( !level.talisman_system.var_e82e1fde1eac3e75.size )
        {
            continue;
        }
        
        var_6e6c7276b09be891 = function_2e8a809e41c71455();
        var_93dd3ac8b1c31eee = [];
        
        foreach ( player in level.talisman_system.var_e82e1fde1eac3e75 )
        {
            if ( !isdefined( player ) || !player.var_74112479b8333c3a )
            {
                var_93dd3ac8b1c31eee[ var_93dd3ac8b1c31eee.size ] = player;
                continue;
            }
            
            if ( var_6e6c7276b09be891 )
            {
                player.var_ed9cae73e9852022 = undefined;
                continue;
            }
            
            if ( !isdefined( player.var_ed9cae73e9852022 ) )
            {
                player.var_ed9cae73e9852022 = gettime();
            }
            
            if ( utility::time_has_passed( player.var_ed9cae73e9852022, 10 ) )
            {
                var_93dd3ac8b1c31eee[ var_93dd3ac8b1c31eee.size ] = player;
            }
        }
        
        foreach ( player in var_93dd3ac8b1c31eee )
        {
            if ( isdefined( player ) )
            {
                player function_3585bb5f92f09aa7();
                continue;
            }
            
            level.talisman_system.var_e82e1fde1eac3e75 = arrayremove( level.talisman_system.var_e82e1fde1eac3e75, player );
        }
    }
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0x4
// Checksum 0xa349c141, Offset: 0x52f3
// Size: 0xbd, Type: bool
function private function_2e8a809e41c71455()
{
    if ( !level.talisman_system.destroyed_talismans.size )
    {
        return false;
    }
    
    foreach ( talisman in level.talisman_system.destroyed_talismans )
    {
        if ( talisman.state == "destroyed" && talisman.trigger )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_talisman
// Params 0, eflags: 0x4
// Checksum 0x9e8e5dc, Offset: 0x53b9
// Size: 0x146
function private function_3585bb5f92f09aa7()
{
    talisman = self.var_74112479b8333c3a;
    level.talisman_system.var_e82e1fde1eac3e75 = arrayremove( level.talisman_system.var_e82e1fde1eac3e75, self );
    
    if ( callback::exists( #"player_disconnect", &function_ab5eddc5386c6c5e ) )
    {
        callback::remove( #"player_disconnect", &function_ab5eddc5386c6c5e );
        callback::remove( #"player_death", &function_306481ca7e8657c1 );
        callback::remove( #"player_laststand", &function_b50749195a106daa );
        callback::remove( #"hash_5b8b82c2527d7aa2", &function_15d45e40acfbebac );
        callback::remove( #"hash_21d7e4119185d412", &function_ae5b33fac9103bfb );
    }
    
    if ( talisman )
    {
        if ( talisman.talisman_destroyed_orion_banner )
        {
            talisman.talisman_destroyed_orion_banner delete();
            talisman.talisman_destroyed_orion_banner = undefined;
        }
        
        talisman.var_62b3d40b0824ee20 = undefined;
    }
    
    self.var_74112479b8333c3a = undefined;
    self.var_ed9cae73e9852022 = undefined;
    self.var_6ce1b4bb7c7cdeb9 = gettime() + 1500;
    self setclientomnvar( "ui_hud_carried_item_index", 10 );
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self notify( #"hash_c5d7a6cc65090420" );
}

// Namespace zm_sat_hornet_talisman
// Params 1, eflags: 0x4
// Checksum 0x9e75d398, Offset: 0x5507
// Size: 0x3c1
function private function_5d570a5f83f8c702( talisman )
{
    talisman.scriptable endon( #"talisman_hidden" );
    talisman.banner endon( #"death" );
    baseorigin = talisman.var_22c178ba78aafbf7;
    baseyaw = talisman.var_2831fc59790b6c90;
    time = 0;
    currentyaw = baseyaw;
    var_d412ff3ce3911401 = 0;
    dt = 0.05;
    lasttime = gettime();
    var_bede65062a1b7992 = undefined;
    var_49a1d05e81173973 = 0;
    var_c2182f88863206c3 = 0;
    
    while ( true )
    {
        now = gettime();
        dt = ( now - lasttime ) / 1000;
        
        if ( dt <= 0 )
        {
            dt = 0.05;
        }
        
        lasttime = now;
        time += clamp( getdvarfloat( @"hash_9d545b3a25dc14a4", 0.1 ) / 4, 0, 4 );
        offset = sin( time * 360 ) * 5;
        talisman.banner.origin = baseorigin + ( 0, 0, offset );
        
        if ( getdvarint( @"hash_6e5cf6a1e7476509", 0 ) )
        {
            chargefrac = function_536a258ae17afc40( talisman );
            var_ff3f6f2f9bdb9b53 = ( talisman.state == "charging" || talisman.state == "decharging" ) && chargefrac > 0;
            var_3983a921f064c699 = var_ff3f6f2f9bdb9b53 ? 0 + chargefrac * 1440 : 0;
            
            if ( var_3983a921f064c699 > var_d412ff3ce3911401 )
            {
                lerpspeed = 3;
            }
            else
            {
                lerpspeed = 6;
            }
            
            var_d412ff3ce3911401 += ( var_3983a921f064c699 - var_d412ff3ce3911401 ) * min( lerpspeed * dt, 1 );
            
            if ( abs( var_3983a921f064c699 - var_d412ff3ce3911401 ) < 0.5 )
            {
                var_d412ff3ce3911401 = var_3983a921f064c699;
            }
            
            if ( var_d412ff3ce3911401 > 0.5 && talisman.state != "decharging" )
            {
                currentyaw += var_d412ff3ce3911401 * dt;
                var_bede65062a1b7992 = undefined;
                var_c2182f88863206c3 = 0;
            }
            else if ( talisman.state == "decharging" )
            {
                if ( !isdefined( var_bede65062a1b7992 ) )
                {
                    var_bede65062a1b7992 = currentyaw;
                    var_c2182f88863206c3 = 0;
                    naturaltotal = var_d412ff3ce3911401 * 3 * 0.5;
                    basediff = angleclamp180( baseyaw - currentyaw );
                    numrotations = int( ( naturaltotal - basediff ) / 360 + 0.5 );
                    
                    if ( numrotations < 0 )
                    {
                        numrotations = 0;
                    }
                    
                    var_49a1d05e81173973 = numrotations * 360 + basediff;
                    
                    if ( var_49a1d05e81173973 < 0 )
                    {
                        var_49a1d05e81173973 += 360;
                    }
                }
                
                var_c2182f88863206c3 += dt;
                frac = clamp( var_c2182f88863206c3 / 3, 0, 1 );
                posfrac = 2 * frac - 2 * frac * frac * frac + frac * frac * frac * frac;
                currentyaw = var_bede65062a1b7992 + var_49a1d05e81173973 * posfrac;
                velfrac = 2 - 6 * frac * frac + 4 * frac * frac * frac;
                var_d412ff3ce3911401 = var_49a1d05e81173973 * velfrac / 3;
            }
            else
            {
                currentyaw = baseyaw + angleclamp180( currentyaw - baseyaw );
                yawdiff = angleclamp180( baseyaw - currentyaw );
                
                if ( abs( yawdiff ) > 0.5 )
                {
                    currentyaw += yawdiff * min( 4 * dt, 1 );
                }
                else
                {
                    currentyaw = baseyaw;
                }
                
                var_bede65062a1b7992 = undefined;
                var_c2182f88863206c3 = 0;
            }
            
            talisman.banner.angles = ( 0, currentyaw, 0 );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_talisman
// Params 2
// Checksum 0x88629c3a, Offset: 0x58d0
// Size: 0x2e2
function function_96e2e12ddf2498e5( taskid, params )
{
    if ( !level.talisman_system || !level.talisman_system.active_talismans || level.talisman_system.active_talismans.size == 0 )
    {
        return 1;
    }
    
    aliveplayers = [];
    
    foreach ( player in level.players )
    {
        if ( zm_player::function_f37cfdf04b932a03( player, 0, 1 ) )
        {
            aliveplayers[ aliveplayers.size ] = player;
        }
    }
    
    if ( aliveplayers.size == 0 )
    {
        return 1;
    }
    
    foreach ( player in aliveplayers )
    {
        var_14c8415c1c16410f = 0;
        
        foreach ( talisman in level.talisman_system.active_talismans )
        {
            if ( talisman.trigger.players_inside_talisman && arraycontains( talisman.trigger.players_inside_talisman, player ) )
            {
                var_14c8415c1c16410f = 1;
                break;
            }
        }
        
        if ( !var_14c8415c1c16410f )
        {
            return 1;
        }
    }
    
    foreach ( talisman in level.talisman_system.active_talismans )
    {
        elapsedsec = ( gettime() - ( talisman.active_start_time ?? 0 ) ) / 1000;
        remainingsec = level.talisman_system.var_b084bbe7334df291 - elapsedsec;
        
        if ( remainingsec > 10 )
        {
            return 1;
        }
    }
    
    return 1.5;
}

/#

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xd10314ed, Offset: 0x5bbb
    // Size: 0x110, Type: dev
    function private function_b9e98ae1e76ea210()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x40>", "<dev string:x52>", &function_af589556ec230ce3, 1 );
        devgui::add_devgui_func( "<dev string:x6d>", "<dev string:x88>", &function_e8d84f12f16b4ea0, 1 );
        devgui::add_devgui_func( "<dev string:xa5>", "<dev string:xc3>", &function_e0ae54a2433b47f3, 1 );
        devgui::add_devgui_func( "<dev string:xe3>", "<dev string:x100>", &function_94faca9da9a32493, 1 );
        devgui::add_devgui_func( "<dev string:x11f>", "<dev string:x13b>", &function_9c5505acea5a5689, 1 );
        devgui::add_devgui_func( "<dev string:x156>", "<dev string:x177>", &function_693a18e47fdd470e, 1 );
        devgui::add_devgui_func( "<dev string:x196>", "<dev string:x1b1>", &function_4d852308d2ac649a, 1 );
        devgui::add_devgui_func( "<dev string:x1cc>", "<dev string:x1e9>", &function_f0bb2ed1fc68b33, 1 );
        devgui::add_devgui_func( "<dev string:x20c>", "<dev string:x21f>", &function_c4ee5f52a9d5a9ac, 1 );
        devgui::add_devgui_func( "<dev string:x238>", "<dev string:x24c>", &function_cbf163e0a532d1e8, 1 );
        devgui::function_77df7fe7dd273e10();
        level thread function_b018a1807f5dfbf3();
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0x9c20f5d7, Offset: 0x5cd3
    // Size: 0x17b, Type: dev
    function private function_b018a1807f5dfbf3()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"talisman_debug_draw", 0 ) )
            {
                foreach ( index, talisman in level.talisman_system.talismans )
                {
                    function_aa8f75070ee0e371( talisman, index );
                }
                
                function_2b28bf82dc983ddd();
            }
            
            if ( getdvarint( @"talisman_debug_sphere", 0 ) )
            {
                foreach ( talisman in level.talisman_system.talismans )
                {
                    color = function_93185f149a79ef8e( talisman.state ?? "<dev string:x269>" );
                    sphere( talisman.scriptable.origin, 240, color, 0, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 2, eflags: 0x4
    // Checksum 0x838054de, Offset: 0x5e56
    // Size: 0x88d, Type: dev
    function private function_aa8f75070ee0e371( talisman, index )
    {
        var_6376c56c52259359 = 24;
        var_e3b5c8d2f4cbbc28 = 1.2;
        var_c27d33ae5293d45a = 14;
        state = talisman.state ?? "<dev string:x269>";
        color = function_93185f149a79ef8e( state );
        origin = talisman.scriptable.origin;
        debug_draw_circle( origin, 240, color, var_6376c56c52259359 );
        debug_draw_circle( origin + ( 0, 0, 200 ), 240, color, var_6376c56c52259359 );
        
        for ( i = 0; i < 4 ; i++ )
        {
            angle = i * 90;
            offsetx = cos( angle ) * 240;
            offsety = sin( angle ) * 240;
            var_ae72a4375a0d5cd5 = origin + ( offsetx, offsety, 0 );
            toppoint = origin + ( offsetx, offsety, 200 );
            line( var_ae72a4375a0d5cd5, toppoint, color, 0, 1 );
        }
        
        debugstar( origin, color, 10, 1 );
        textorigin = origin + ( 0, 0, 280 );
        linenum = 0;
        print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x271>" + index + "<dev string:x27f>", color, 1, var_e3b5c8d2f4cbbc28, 1 );
        linenum++;
        print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x284>" + state, color, 1, var_e3b5c8d2f4cbbc28, 1 );
        linenum++;
        charge = talisman.charge ?? 0;
        chargepercent = int( charge / level.talisman_system.var_557f3cd0c097ab37 * 100 );
        
        if ( chargepercent > 100 )
        {
            chargepercent = 100;
        }
        
        chargecolor = function_ce595874f37fbd3b( chargepercent );
        print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x28c>" + int( charge ) + "<dev string:x295>" + level.talisman_system.var_557f3cd0c097ab37 + "<dev string:x297>" + chargepercent + "<dev string:x29a>", chargecolor, 1, var_e3b5c8d2f4cbbc28, 1 );
        linenum++;
        
        if ( charge > 0 )
        {
            var_455c76da00cf0f9d = 200;
            barorigin = origin + ( 0, 0, 230 );
            var_4c450c76e44bf574 = barorigin - ( var_455c76da00cf0f9d / 2, 0, 0 );
            var_7183421bcf7d795a = barorigin + ( var_455c76da00cf0f9d / 2, 0, 0 );
            var_beb29c48e3e0b407 = var_4c450c76e44bf574 + ( var_455c76da00cf0f9d * chargepercent / 100, 0, 0 );
            line( var_4c450c76e44bf574, var_7183421bcf7d795a, ( 0.3, 0.3, 0.3 ), 0, 1 );
            line( var_4c450c76e44bf574, var_beb29c48e3e0b407, chargecolor, 0, 1 );
        }
        
        playersinside = 0;
        
        if ( isdefined( talisman.trigger ) && isdefined( talisman.trigger.players_inside_talisman ) )
        {
            playersinside = talisman.trigger.players_inside_talisman.size;
        }
        
        playerscolor = playersinside > 0 ? ( 0, 1, 0 ) : ( 1, 1, 1 );
        print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x29d>" + playersinside, playerscolor, 1, var_e3b5c8d2f4cbbc28, 1 );
        linenum++;
        
        if ( level.players.size > 0 )
        {
            dist = int( distance( origin, level.players[ 0 ].origin ) );
            print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x2ae>" + dist, ( 1, 1, 1 ), 1, var_e3b5c8d2f4cbbc28, 1 );
            linenum++;
        }
        
        if ( state == "<dev string:x2bb>" && isdefined( talisman.active_start_time ) )
        {
            elapsedsec = ( gettime() - talisman.active_start_time ) / 1000;
            remainingraw = level.talisman_system.var_b084bbe7334df291 - elapsedsec;
            remainingsec = remainingraw > 0 ? remainingraw : 0;
            timercolor = ( 1, 1, 1 );
            
            if ( remainingsec <= 5 )
            {
                timercolor = ( 1, 0, 0 );
            }
            else if ( remainingsec <= 15 )
            {
                timercolor = ( 1, 1, 0 );
            }
            
            print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x2c2>" + int( remainingsec ) + "<dev string:x2d1>" + int( level.talisman_system.var_b084bbe7334df291 ) + "<dev string:x2d6>", timercolor, 1, var_e3b5c8d2f4cbbc28, 1 );
            linenum++;
        }
        
        if ( isdefined( talisman.badplaceid ) )
        {
            print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x2d8>", ( 0, 0.5, 1 ), 1, var_e3b5c8d2f4cbbc28, 1 );
            linenum++;
        }
        
        if ( isdefined( talisman.zombieattractor ) )
        {
            print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x2ed>", ( 0, 0.5, 1 ), 1, var_e3b5c8d2f4cbbc28, 1 );
            linenum++;
        }
        
        if ( state == "<dev string:x2ff>" )
        {
            if ( isdefined( talisman.orion ) && isalive( talisman.orion ) )
            {
                orionhealth = talisman.orion.health;
                var_2b0e866ded92556f = talisman.orion.maxhealth ?? orionhealth;
                oriondist = int( distance( origin, talisman.orion.origin ) );
                print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x309>" + orionhealth + "<dev string:x295>" + var_2b0e866ded92556f + "<dev string:x31b>" + oriondist, ( 1, 0.3, 0.3 ), 1, var_e3b5c8d2f4cbbc28, 1 );
                linenum++;
                line( origin + ( 0, 0, 50 ), talisman.orion.origin + ( 0, 0, 36 ), ( 1, 0, 0 ), 0, 1 );
                debugstar( talisman.orion.origin + ( 0, 0, 72 ), ( 1, 0, 0 ), 8, 1 );
            }
            else
            {
                print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x323>", ( 0.5, 0.5, 0.5 ), 1, var_e3b5c8d2f4cbbc28, 1 );
                linenum++;
            }
            
            if ( isdefined( level.talisman_system.var_c9011c3f44522697 ) )
            {
                debug_draw_circle( level.talisman_system.var_c9011c3f44522697.tetherpoint, level.talisman_system.var_c9011c3f44522697.tetherradius, ( 1, 0.2, 0.2 ), 16 );
            }
        }
        
        if ( isdefined( talisman.var_62b3d40b0824ee20 ) )
        {
            print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x336>" + talisman.var_62b3d40b0824ee20.name, ( 1, 0.8, 0 ), 1, var_e3b5c8d2f4cbbc28, 1 );
            linenum++;
            line( origin + ( 0, 0, 50 ), talisman.var_62b3d40b0824ee20.origin + ( 0, 0, 60 ), ( 1, 0.8, 0 ), 0, 1 );
        }
        
        if ( isdefined( talisman.talisman_destroyed_orion_banner ) && !isdefined( talisman.var_62b3d40b0824ee20 ) )
        {
            bannerorigin = talisman.talisman_destroyed_orion_banner.origin;
            print3d( textorigin - ( 0, 0, var_c27d33ae5293d45a * linenum ), "<dev string:x347>", ( 1, 0.5, 0 ), 1, var_e3b5c8d2f4cbbc28, 1 );
            linenum++;
            debugstar( bannerorigin + ( 0, 0, 20 ), ( 1, 0.5, 0 ), 8, 1 );
            debug_draw_circle( bannerorigin, 76, ( 1, 0.5, 0 ), 12 );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xc8b2a40, Offset: 0x66eb
    // Size: 0xc4, Type: dev
    function private function_2b28bf82dc983ddd()
    {
        if ( !isdefined( level.talisman_system.var_42dd618734d04af2 ) || !level.talisman_system.var_42dd618734d04af2 )
        {
            return;
        }
        
        searchorigin = level.talisman_system.var_2c28be7abff7e769;
        var_b024ad36e1bd223 = level.talisman_system.var_2b0091f0c7d0a2fd ?? 0;
        debug_draw_circle( searchorigin, 3000, ( 0.3, 1, 0.3 ), 32 );
        print3d( searchorigin + ( 0, 0, 100 ), "<dev string:x359>" + var_b024ad36e1bd223, ( 0.3, 1, 0.3 ), 1, 1, 1 );
    }

    // Namespace zm_sat_hornet_talisman
    // Params 4, eflags: 0x4
    // Checksum 0x6c53b79e, Offset: 0x67b7
    // Size: 0xc4, Type: dev
    function private debug_draw_circle( center, radius, color, segments )
    {
        anglestep = 360 / segments;
        
        for ( i = 0; i < segments ; i++ )
        {
            var_ebb5a4dd27af9458 = i * anglestep;
            var_ebb5a7dd27af9af1 = ( i + 1 ) * anglestep;
            point1 = center + ( cos( var_ebb5a4dd27af9458 ) * radius, sin( var_ebb5a4dd27af9458 ) * radius, 0 );
            point2 = center + ( cos( var_ebb5a7dd27af9af1 ) * radius, sin( var_ebb5a7dd27af9af1 ) * radius, 0 );
            line( point1, point2, color, 0, 1 );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 1, eflags: 0x4
    // Checksum 0x3f5b3de7, Offset: 0x6883
    // Size: 0xe9, Type: dev
    function private function_93185f149a79ef8e( state )
    {
        switch ( state )
        {
            case #"hash_61f1a95d6bf95699":
                return ( 0.5, 0.5, 0.5 );
            case #"hash_376a634585ba02b8":
                return ( 1, 1, 1 );
            case #"hash_174d75faff6dcf22":
                return ( 1, 1, 0 );
            case #"hash_feb6a1f938941775":
                return ( 1, 0.5, 0 );
            case #"hash_2c6dd295e7428eef":
                return ( 0, 1, 0 );
            case #"hash_bee8aefcdf5a9a8f":
                return ( 0, 0.5, 1 );
            case #"hash_f2b431c975ba652c":
                return ( 1, 0, 0 );
            default:
                return ( 1, 0, 1 );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 1, eflags: 0x4
    // Checksum 0x10f02940, Offset: 0x6974
    // Size: 0x7d, Type: dev
    function private function_ce595874f37fbd3b( chargepercent )
    {
        if ( chargepercent >= 100 )
        {
            return ( 0, 1, 0 );
        }
        else if ( chargepercent >= 75 )
        {
            return ( 0.5, 1, 0 );
        }
        else if ( chargepercent >= 25 )
        {
            return ( 1, 1, 0 );
        }
        else if ( chargepercent > 0 )
        {
            return ( 1, 0.5, 0 );
        }
        
        return ( 1, 1, 1 );
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xe9dcea80, Offset: 0x69f9
    // Size: 0x38, Type: dev
    function private function_af589556ec230ce3()
    {
        currentval = getdvarint( @"talisman_debug_draw", 0 );
        setdvar( @"talisman_debug_draw", currentval ? 0 : 1 );
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0x994afcd2, Offset: 0x6a39
    // Size: 0x38, Type: dev
    function private function_cbf163e0a532d1e8()
    {
        currentval = getdvarint( @"talisman_debug_sphere", 0 );
        setdvar( @"talisman_debug_sphere", currentval ? 0 : 1 );
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0x910f323b, Offset: 0x6a79
    // Size: 0x8d, Type: dev
    function private function_e8d84f12f16b4ea0()
    {
        foreach ( talisman in level.talisman_system.talismans )
        {
            set_talisman_state( talisman, "<dev string:x2bb>" );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xa2a2ba09, Offset: 0x6b0e
    // Size: 0x2b, Type: dev
    function private function_e0ae54a2433b47f3()
    {
        closesttalisman = function_29e3ab11fda8cf0c();
        
        if ( isdefined( closesttalisman ) )
        {
            set_talisman_state( closesttalisman, "<dev string:x2bb>" );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xc15d0cfc, Offset: 0x6b41
    // Size: 0x8d, Type: dev
    function private function_94faca9da9a32493()
    {
        foreach ( talisman in level.talisman_system.talismans )
        {
            set_talisman_state( talisman, "<dev string:x386>" );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0x9afc9db7, Offset: 0x6bd6
    // Size: 0xac, Type: dev
    function private function_9c5505acea5a5689()
    {
        foreach ( talisman in level.talisman_system.talismans )
        {
            talisman.charge = level.talisman_system.var_557f3cd0c097ab37;
            set_talisman_state( talisman, "<dev string:x3a3>" );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xc0663654, Offset: 0x6c8a
    // Size: 0x2b, Type: dev
    function private function_693a18e47fdd470e()
    {
        closesttalisman = function_29e3ab11fda8cf0c();
        
        if ( isdefined( closesttalisman ) )
        {
            set_talisman_state( closesttalisman, "<dev string:x2ff>" );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xb4226b64, Offset: 0x6cbd
    // Size: 0xa1, Type: dev
    function private function_4d852308d2ac649a()
    {
        foreach ( talisman in level.talisman_system.talismans )
        {
            if ( talisman.state == "<dev string:x37f>" )
            {
                set_talisman_state( talisman, "<dev string:x386>" );
            }
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0xbdb897d2, Offset: 0x6d66
    // Size: 0x6c, Type: dev
    function private function_f0bb2ed1fc68b33()
    {
        if ( level.players.size == 0 )
        {
            return;
        }
        
        closesttalisman = function_29e3ab11fda8cf0c();
        
        if ( isdefined( closesttalisman ) )
        {
            teleportpos = closesttalisman.scriptable.origin + ( 290, 0, 0 );
            level.players[ 0 ] setorigin( teleportpos );
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0x8d85a997, Offset: 0x6dda
    // Size: 0xb1, Type: dev
    function private function_c4ee5f52a9d5a9ac()
    {
        foreach ( talisman in level.talisman_system.talismans )
        {
            if ( isdefined( talisman.orion ) && isalive( talisman.orion ) )
            {
                talisman.orion kill();
            }
        }
    }

    // Namespace zm_sat_hornet_talisman
    // Params 0, eflags: 0x4
    // Checksum 0x9729f432, Offset: 0x6e93
    // Size: 0x143, Type: dev
    function private function_29e3ab11fda8cf0c()
    {
        if ( level.players.size == 0 || level.talisman_system.talismans.size == 0 )
        {
            return;
        }
        
        playerorigin = level.players[ 0 ].origin;
        closesttalisman = level.talisman_system.talismans[ 0 ];
        closestdistsq = distancesquared( closesttalisman.scriptable.origin, playerorigin );
        
        foreach ( talisman in level.talisman_system.talismans )
        {
            distsq = distancesquared( talisman.scriptable.origin, playerorigin );
            
            if ( distsq < closestdistsq )
            {
                closesttalisman = talisman;
                closestdistsq = distsq;
            }
        }
        
        return closesttalisman;
    }

#/
