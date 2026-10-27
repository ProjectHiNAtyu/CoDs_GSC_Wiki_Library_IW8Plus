// scripts\mp\common\powerups\br_powerups.gsc  (hash_7204344a1167b7a8.gscc) (size: 14292 Bytes / 0x37d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1712dca5 (387112101)
// size ...... 14292 (0x37d4)
// includes .. 16  (offset: 0x33ac)
// strings ... 31  (offset: 0x342c)
// dev strs .. 33  (offset: 0x35c8)
// exports ... 40  (offset: 0x1f00)
// cseg ...... 0x21d + 0x1ce3 (0x1f00)
// imports ... 118 (offset: 0x2540)
// animtree1 . 0   (offset: 0x37d4)
// animtree2 . 0   (offset: 0x37d4)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\hud_message;
#using scripts\mp\rank;

#namespace br_powerups;

// Namespace br_powerups
// Params 0, eflags: 0x1
// Checksum 0x4bdd9d9d, Offset: 0x23b
// Size: 0x25
function autoexec main()
{
    if ( getdvarint( @"scr_br_powerups_enabled", 0 ) )
    {
        level thread init();
        
        /#
            debug_init();
        #/
    }
}

// Namespace br_powerups
// Params 0
// Checksum 0xd4e2ab8b, Offset: 0x268
// Size: 0x1cb
function init()
{
    powerups_cpmp::init( &util_give_points, &function_4aa1d175b03e7bb2, 1 );
    wait 1;
    root = powerups::get_powerups_root();
    bundle = powerups::get_bundle_list();
    root.cache_drop_chance = getdvarfloat( @"hash_7948f34b09080935", bundle.var_1f33ff37e7838dbc );
    root.kill_drop_chance = getdvarfloat( @"hash_4e713f489454977f", bundle.var_3d01bdd4221215e2 );
    root.var_6cd2e2a3fe7ea414 = getdvarfloat( @"hash_59bd7161c6f93044", bundle.var_3a8d076dd0f5523c );
    root.ftue_enabled = getdvarint( @"hash_f5cbffbd7abd0eb8", 1 );
    root.use_gravity_arc = getdvarint( @"hash_7a7f041ab83276e7", 1 );
    utility::registersharedfunc( #"powerups", #"doPowerupScoreEvent", &function_4dfff50b5990a2f1 );
    utility::registersharedfunc( #"powerups", #"dropPowerup", &br_powerup_drop );
    root.var_f5dfcec9ed595419 = 1;
    root.duration_mod = 1;
    utility::registersharedfunc( #"powerups", #"doPowerupScoreEvent", &function_4dfff50b5990a2f1 );
    utility::registersharedfunc( #"powerups", #"dropPowerup", &br_powerup_drop );
    utility::registersharedfunc( #"powerups", #"hash_83f466ecbcf4b5c", &function_aaf3aad5434f15e6 );
    utility::registersharedfunc( #"powerups", #"hash_b62399caeae7e835", &function_32002226bb48a278 );
    level.powerup_timeout_override = &br_powerup_timeout_override;
    level thread init_post_prematch();
}

// Namespace br_powerups
// Params 0
// Checksum 0x7c6cbde8, Offset: 0x43b
// Size: 0x22
function init_post_prematch()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_fade_done" );
    init_callbacks();
}

// Namespace br_powerups
// Params 0
// Checksum 0x53d6af65, Offset: 0x465
// Size: 0x10e
function init_callbacks()
{
    root = powerups::get_powerups_root();
    
    if ( root.cache_drop_chance > 0 )
    {
        level callback::add( "lootcache_looted", &br_on_cache_opened );
    }
    
    if ( root.kill_drop_chance > 0 )
    {
        level callback::add( #"player_death", &br_on_player_death );
        level callback::add( "on_ai_killed", &function_86be59809e5021a4 );
    }
    
    if ( !function_347b1d7244bb492a() )
    {
        foreach ( powerup in root.powerups )
        {
            if ( isdefined( powerup.scriptable ) )
            {
                scriptable::scriptable_addusedcallbackbypart( powerup.scriptable, &function_73a13f9356310ce7 );
            }
        }
    }
}

// Namespace br_powerups
// Params 1
// Checksum 0x74a6805f, Offset: 0x57b
// Size: 0xa4
function br_on_player_death( params )
{
    foreach ( ref in self.var_bb807542a9b20cf0 )
    {
        powerups::remove_powerup_timer( "hud_powerup_" + ref );
    }
    
    powerups::function_b6d20332b27fa42e();
    br_handle_death( params.attacker );
}

// Namespace br_powerups
// Params 1
// Checksum 0x28718323, Offset: 0x627
// Size: 0x1e
function function_86be59809e5021a4( params )
{
    br_handle_death( params.eattacker );
}

// Namespace br_powerups
// Params 1
// Checksum 0xb3ad85da, Offset: 0x64d
// Size: 0x22f
function br_handle_death( attacker )
{
    if ( attacker == self || !isplayer( attacker ) || attacker br_public::isplayeringulag() || self.vehicle )
    {
        /#
            if ( getdvarint( @"hash_340406f5e0972920" ) )
            {
                if ( !isdefined( attacker ) )
                {
                    function_f92b2dbeab56ebb( self.origin, "<dev string:x24>", "<dev string:x52>", 0 );
                }
                
                if ( attacker == self )
                {
                    function_f92b2dbeab56ebb( self.origin, "<dev string:x56>", "<dev string:x52>", 0 );
                }
                
                if ( !isplayer( attacker ) )
                {
                    function_f92b2dbeab56ebb( self.origin, "<dev string:x7e>", "<dev string:x52>", 0 );
                }
            }
        #/
        
        return;
    }
    
    root = powerups::get_powerups_root();
    roll = randomfloatrange( 0, 1 );
    var_dcef9be67174ef20 = isplayer( self ) ? root.kill_drop_chance : root.var_6cd2e2a3fe7ea414;
    var_dcef9be67174ef20 *= root.var_f5dfcec9ed595419;
    
    if ( roll > var_dcef9be67174ef20 )
    {
        /#
            if ( getdvarint( @"hash_340406f5e0972920" ) )
            {
                var_8ab5b154237cd1cf = isplayer( self ) ? "<dev string:xab>" : "<dev string:xb2>";
                function_f92b2dbeab56ebb( self.origin, "<dev string:xb5>" + var_8ab5b154237cd1cf + "<dev string:xc4>" + roll + "<dev string:xd5>" + var_dcef9be67174ef20 + "<dev string:xe7>", "<dev string:x52>", 0 );
            }
        #/
        
        return;
    }
    
    context = spawnstruct();
    context.player = attacker;
    context.victim = self;
    context.method = "kill";
    
    /#
        if ( getdvarint( @"hash_340406f5e0972920" ) )
        {
            var_8ab5b154237cd1cf = isplayer( self ) ? "<dev string:xab>" : "<dev string:xb2>";
            function_f92b2dbeab56ebb( self.origin, "<dev string:xb5>" + var_8ab5b154237cd1cf + "<dev string:xc4>" + roll + "<dev string:xe9>" + var_dcef9be67174ef20 + "<dev string:xe7>", "<dev string:xfb>", 0 );
        }
    #/
    
    level thread function_9dc6ca249bdd2cd3( self.origin, context );
}

// Namespace br_powerups
// Params 1
// Checksum 0x661c8de9, Offset: 0x884
// Size: 0x212
function br_on_cache_opened( params )
{
    root = powerups::get_powerups_root();
    
    if ( params.player br_public::isplayeringulag() )
    {
        return;
    }
    
    roll = randomfloatrange( 0, 1 );
    
    if ( roll > root.cache_drop_chance * root.var_f5dfcec9ed595419 )
    {
        /#
            if ( getdvarint( @"hash_340406f5e0972920" ) )
            {
                function_f92b2dbeab56ebb( params.cacheinstance.origin, "<dev string:x101>" + roll + "<dev string:xd5>" + root.cache_drop_chance + "<dev string:xe7>", "<dev string:x52>", 0 );
            }
        #/
        
        return;
    }
    
    var_de871460bc51277b = var_de871460bc51277b ?? params.cacheinstance.origin;
    var_a8613ee6f50b32dc = undefined;
    var_6e42fa8934079576 = isdefined( var_a8613ee6f50b32dc ) ? anglestoforward( params.cacheinstance.angles + ( 0, var_a8613ee6f50b32dc, 0 ) ) : anglestoleft( params.cacheinstance.angles );
    spawn_origin = var_de871460bc51277b + var_6e42fa8934079576 * 50 + ( 0, 0, root.powerup_vars[ "drop_height_offset" ] );
    context = spawnstruct();
    context.player = params.player;
    context.cache = params.cacheinstance;
    context.method = "cache";
    context.var_de871460bc51277b = var_de871460bc51277b;
    
    /#
        if ( getdvarint( @"hash_340406f5e0972920" ) )
        {
            function_f92b2dbeab56ebb( params.cacheinstance.origin, "<dev string:x101>" + roll + "<dev string:xe9>" + root.cache_drop_chance + "<dev string:xe7>", "<dev string:xfb>", 0 );
        }
    #/
    
    level thread function_9dc6ca249bdd2cd3( spawn_origin, context );
}

// Namespace br_powerups
// Params 2
// Checksum 0xba8e1a0b, Offset: 0xa9e
// Size: 0xd2
function function_9dc6ca249bdd2cd3( location, context )
{
    root = powerups::get_powerups_root();
    
    if ( isdefined( context ) )
    {
        powerup = function_c7f1f2207b6657bc( location, context );
    }
    else
    {
        powerup = utility::array_random( root.powerup_drop_array );
    }
    
    source = "undefined";
    
    switch ( context.method )
    {
        case #"hash_dc0a55772fe305c5":
            source = "cache";
            break;
        case #"hash_611825599f1b56f9":
            source = isplayer( context.victim ) ? "player" : "ai";
            break;
    }
    
    function_52bad1f01672b8e4( powerup, source );
    br_powerup_drop( powerup, location );
}

// Namespace br_powerups
// Params 2
// Checksum 0xea58e621, Offset: 0xb78
// Size: 0x3d3
function function_c7f1f2207b6657bc( location, context )
{
    /#
        if ( getdvarint( @"hash_340406f5e0972920" ) )
        {
            var_f1e47669f7416b3e = 0;
        }
    #/
    
    root = powerups::get_powerups_root();
    weights = [];
    sum = 0;
    
    foreach ( powerup_ref in root.powerup_drop_array )
    {
        if ( context.player.var_631ee2c4edd21820 == powerup_ref )
        {
            /#
                if ( getdvarint( @"hash_340406f5e0972920" ) )
                {
                    function_f92b2dbeab56ebb( location, "<dev string:x125>" + powerup_ref + "<dev string:x12f>", "<dev string:x52>", var_f1e47669f7416b3e );
                    var_f1e47669f7416b3e++;
                }
            #/
            
            continue;
        }
        
        info = powerups::get_powerup_info( powerup_ref );
        
        if ( isdefined( info.func_should_drop_with_regular_powerups ) )
        {
            var_66646fcceb16b26f = [[ info.func_should_drop_with_regular_powerups ]]();
            
            if ( !var_66646fcceb16b26f )
            {
                /#
                    if ( getdvarint( @"hash_340406f5e0972920" ) )
                    {
                        function_f92b2dbeab56ebb( location, "<dev string:x125>" + powerup_ref + "<dev string:x157>", "<dev string:x52>", var_f1e47669f7416b3e );
                        var_f1e47669f7416b3e++;
                    }
                #/
                
                continue;
            }
        }
        
        chance = 1;
        
        switch ( context.method )
        {
            case #"hash_611825599f1b56f9":
                chance = info.var_3d01bdd4221215e2 ?? chance;
                break;
            case #"hash_dc0a55772fe305c5":
                chance = info.var_1f33ff37e7838dbc ?? chance;
                break;
        }
        
        if ( isdefined( info.var_73b0c01f8e3a1d0e ) )
        {
            chance = [[ info.var_73b0c01f8e3a1d0e ]]( chance, context );
        }
        
        if ( chance <= 0 )
        {
            /#
                if ( getdvarint( @"hash_340406f5e0972920" ) )
                {
                    function_f92b2dbeab56ebb( location, "<dev string:x125>" + powerup_ref + "<dev string:x170>", "<dev string:x52>", var_f1e47669f7416b3e );
                    var_f1e47669f7416b3e++;
                }
            #/
            
            continue;
        }
        
        weight = int( 1000 * chance );
        weights[ powerup_ref ] = weight;
        sum += weight;
    }
    
    var_ddf24b010015c8af = randomintrange( 0, sum );
    var_c4f08400c4885fc5 = "";
    
    foreach ( powerup_ref, weight in weights )
    {
        var_ddf24b010015c8af -= weight;
        
        if ( var_ddf24b010015c8af <= 0 )
        {
            var_c4f08400c4885fc5 = powerup_ref;
            break;
        }
    }
    
    context.player.var_631ee2c4edd21820 = var_c4f08400c4885fc5;
    
    /#
        if ( getdvarint( @"hash_340406f5e0972920" ) )
        {
            foreach ( powerup_ref, weight in weights )
            {
                if ( powerup_ref == var_c4f08400c4885fc5 )
                {
                    function_f92b2dbeab56ebb( location, "<dev string:x125>" + powerup_ref + "<dev string:x188>" + weight, "<dev string:xfb>", var_f1e47669f7416b3e );
                }
                else
                {
                    function_f92b2dbeab56ebb( location, "<dev string:x125>" + powerup_ref + "<dev string:x188>" + weight, "<dev string:x193>", var_f1e47669f7416b3e );
                }
                
                var_f1e47669f7416b3e++;
            }
        }
    #/
    
    return var_c4f08400c4885fc5;
}

// Namespace br_powerups
// Params 0
// Checksum 0x326c9927, Offset: 0xf54
// Size: 0x12, Type: bool
function function_347b1d7244bb492a()
{
    return getdvarint( @"hash_22a13e9daae02e19", 0 ) == 0;
}

// Namespace br_powerups
// Params 1
// Checksum 0x52bcb785, Offset: 0xf6f
// Size: 0x266, Type: bool
function function_77c68420f36bbaa0( player )
{
    level endon( #"game_ended" );
    
    if ( !player val::get( "powerup_pickup" ) )
    {
        return false;
    }
    
    root = powerups::get_powerups_root();
    info = powerups::get_powerup_info( self.ref );
    
    if ( !info.var_a5947be6c50a6f68 && !isplayer( player ) )
    {
        return false;
    }
    
    if ( !info.powerupcanpickupinlaststand && player.inlaststand )
    {
        return false;
    }
    
    level thread function_9cb32c6aa5df51( self.ref );
    utility::function_7c10ea82c1e305b8( "effects", "grab" );
    utility::function_7c10ea82c1e305b8( "model", "hide" );
    
    if ( isdefined( info.var_45d15f3dfa9e51c3 ) )
    {
        a_players = player powerups::get_powerup_players( self.ref, self.origin );
        
        foreach ( var_299cbdc598dfc72e in a_players )
        {
            if ( isalive( var_299cbdc598dfc72e ) )
            {
                var_299cbdc598dfc72e util_play_vo( info.var_45d15f3dfa9e51c3 );
            }
        }
    }
    
    level callback::callback( #"player_powerup", { #player:player, #powerup:self } );
    player powerups::powerup_activate( self.ref, self );
    
    if ( isdefined( info.splashreference ) )
    {
        player hud_message::showsplash( info.splashreference );
    }
    
    player namespace_9d8e359c3b1041e5::dopowerupscoreeventsharedfunc();
    
    if ( !isdefined( player.var_aba5734958a86143 ) )
    {
        player.var_aba5734958a86143 = [];
    }
    
    if ( root.ftue_enabled && !player.var_aba5734958a86143[ self.ref ] )
    {
        player.var_aba5734958a86143[ self.ref ] = 1;
        player thread ftue_play( self.ref );
    }
    
    self notify( #"powerup_grabbed", player );
    thread function_a77cdd5e98c61643();
    return true;
}

// Namespace br_powerups
// Params 1
// Checksum 0x1fe54a4d, Offset: 0x11de
// Size: 0xa2
function function_8e55608e34fdffe4( var_e272431efe9b6f6f )
{
    root = powerups::get_powerups_root();
    
    foreach ( ref, powerup in root.powerups )
    {
        if ( powerup.scriptable == var_e272431efe9b6f6f )
        {
            return ref;
        }
    }
}

// Namespace br_powerups
// Params 6
// Checksum 0x4b64c06, Offset: 0x1289
// Size: 0x65
function function_73a13f9356310ce7( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.ref ) )
    {
        instance.ref = function_8e55608e34fdffe4( part );
    }
    
    instance function_77c68420f36bbaa0( player );
}

// Namespace br_powerups
// Params 3
// Checksum 0x4fd3aee4, Offset: 0x12f6
// Size: 0x246
function br_powerup_drop( powerup_ref, spawn_pos, drop_lifetime_override )
{
    root = powerups::get_powerups_root();
    info = powerups::get_powerup_info( powerup_ref );
    
    if ( !isdefined( info.scriptable ) )
    {
        return powerups::powerup_drop( powerup_ref, spawn_pos, drop_lifetime_override );
    }
    
    height_offset = ( 0, 0, root.powerup_vars[ "drop_height_offset" ] );
    ground_pos = getgroundposition( spawn_pos, 1, 15000 );
    
    if ( spawn_pos[ 2 ] - ground_pos[ 2 ] >= 15000 )
    {
        return;
    }
    
    ground_pos += height_offset;
    payload = calcscriptablepayloadgravityarc( spawn_pos, ground_pos );
    powerup = spawnscriptable( info.scriptable, ground_pos, ( 0, 0, 0 ), undefined, payload );
    powerup utility::function_7c10ea82c1e305b8( "effects", "spawn" );
    powerup utility::function_7c10ea82c1e305b8( "model", root.use_gravity_arc ? "dropped" : "show" );
    powerup.ref = powerup_ref;
    var_431b27fafafe9216 = powerup utility::function_7c45b71b8e0d3cff();
    
    if ( function_347b1d7244bb492a() )
    {
        if ( isdefined( var_431b27fafafe9216 ) && !isdefined( var_431b27fafafe9216.groundent.vehicletype ) )
        {
            powerup utility::scriptable_setparententity( var_431b27fafafe9216.groundent, var_431b27fafafe9216.localorigin + height_offset, var_431b27fafafe9216.localangles );
            powerup.trigger = spawn( "trigger_radius", ground_pos, 0, 10, 10 );
            powerup.trigger enablelinkto();
            powerup.trigger linkto( var_431b27fafafe9216.groundent, "", var_431b27fafafe9216.localorigin + height_offset, var_431b27fafafe9216.localangles );
        }
        else
        {
            powerup.trigger = spawn( "noent_volume_trigger_radius", ground_pos, 0, 10, 10 );
        }
    }
    
    powerup thread function_582a75d142142a41( drop_lifetime_override );
    
    if ( function_347b1d7244bb492a() )
    {
        powerup thread br_powerup_wait_for_pickup( 1 );
    }
    
    powerup thread br_powerup_watch_game_ended();
    return powerup;
}

// Namespace br_powerups
// Params 1
// Checksum 0x32927f7f, Offset: 0x1545
// Size: 0x123
function function_582a75d142142a41( drop_lifetime_override )
{
    if ( drop_lifetime_override < 0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"powerup_grabbed" );
    self endon( #"powerup_removed" );
    self endon( #"death" );
    powerup_info = powerups::get_powerup_info( self.ref );
    lifetime = drop_lifetime_override ?? powerup_info.var_60abd2a73af466c4;
    blinktime = 10;
    fast_blinktime = 3;
    var_94adba0a81c4216c = lifetime - blinktime;
    wait var_94adba0a81c4216c;
    self.var_e273a3c3affc79c0 = 0.5;
    self.var_72dc8ded5cc26e19 = "blink_show_audio";
    childthread function_9beadc48d51ffee9();
    wait blinktime - fast_blinktime;
    self.var_e273a3c3affc79c0 = 0.25;
    self.var_72dc8ded5cc26e19 = "blink_show";
    wait fast_blinktime;
    utility::function_7c10ea82c1e305b8( "blink", "off" );
    utility::function_7c10ea82c1e305b8( "effects", "timed_out" );
    utility::function_7c10ea82c1e305b8( "model", "hide" );
    thread function_a77cdd5e98c61643();
}

// Namespace br_powerups
// Params 0
// Checksum 0xfda36c22, Offset: 0x1670
// Size: 0x55
function function_9beadc48d51ffee9()
{
    state = 1;
    
    while ( true )
    {
        state = !state;
        state_name = state ? "blink_hide_audio" : self.var_72dc8ded5cc26e19;
        utility::function_7c10ea82c1e305b8( "blink", state_name );
        wait self.var_e273a3c3affc79c0;
    }
}

// Namespace br_powerups
// Params 1
// Checksum 0x24dcf660, Offset: 0x16cd
// Size: 0xb6
function br_powerup_wait_for_pickup( delay )
{
    level endon( #"game_ended" );
    self endon( #"powerup_removed" );
    self endon( #"death" );
    wait delay;
    root = powerups::get_powerups_root();
    
    while ( true )
    {
        self.trigger waittill( #"trigger", ent );
        player = ent;
        
        if ( isdefined( root.var_d3bf519d8023999a ) )
        {
            player = ent [[ root.var_d3bf519d8023999a ]]();
        }
        
        if ( isdefined( player ) && player::isreallyalive( player ) )
        {
            if ( function_77c68420f36bbaa0( player ) )
            {
                return;
            }
        }
    }
}

// Namespace br_powerups
// Params 0
// Checksum 0x332fe643, Offset: 0x178b
// Size: 0x2e
function br_powerup_watch_game_ended()
{
    self endon( #"death" );
    self endon( #"powerup_removed" );
    level waittill( #"game_ended" );
    thread function_a77cdd5e98c61643();
}

// Namespace br_powerups
// Params 1
// Checksum 0x4a0406df, Offset: 0x17c1
// Size: 0x35
function function_aaf3aad5434f15e6( mod )
{
    root = powerups::get_powerups_root();
    root.var_f5dfcec9ed595419 = max( mod, 1 );
}

// Namespace br_powerups
// Params 1
// Checksum 0xf6e82f30, Offset: 0x17fe
// Size: 0x35
function function_32002226bb48a278( mod )
{
    root = powerups::get_powerups_root();
    root.duration_mod = max( mod, 0.1 );
}

// Namespace br_powerups
// Params 1
// Checksum 0x2b810f3d, Offset: 0x183b
// Size: 0x2c
function br_powerup_timeout_override( lifetime )
{
    root = powerups::get_powerups_root();
    return lifetime * root.duration_mod;
}

// Namespace br_powerups
// Params 1
// Checksum 0x9b3c1377, Offset: 0x1870
// Size: 0x7b
function util_play_vo( alias )
{
    soundname = tolower( alias );
    
    if ( soundexists( soundname ) )
    {
        if ( !isdefined( self.var_7325e0e63abc4e1f ) )
        {
            self.var_7325e0e63abc4e1f = 0;
        }
        
        if ( self.var_7325e0e63abc4e1f - gettime() < 0 )
        {
            soundlength = lookupsoundlength( soundname, 1 );
            self.var_7325e0e63abc4e1f = gettime() + soundlength;
            self playsoundtoplayer( soundname, self );
        }
    }
}

// Namespace br_powerups
// Params 1
// Checksum 0x3ad59898, Offset: 0x18f3
// Size: 0x8d
function ftue_play( ref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !ftue_progress::ftue_enabled() )
    {
        return;
    }
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    tip = hashcat( #"powerup_", ref );
    ftue_tip::function_c9cca7ed21647155( tip );
    wait 8;
    params = { #duration:8 };
    ftue_tip::function_84dafc5c5a3f97ff( tip, 1, params );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace br_powerups
// Params 0
// Checksum 0xeda02b52, Offset: 0x1988
// Size: 0x35
function function_a77cdd5e98c61643()
{
    self notify( #"powerup_removed" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    wait 0.25;
    self freescriptable();
}

// Namespace br_powerups
// Params 3
// Checksum 0xb6beb92, Offset: 0x19c5
// Size: 0x48
function util_give_points( eventstring, points, victim )
{
    if ( !isplayer( self ) || player::isinlaststand( self ) )
    {
        return;
    }
    
    points::doscoreevent( eventstring, undefined, points, undefined, victim, undefined, undefined, undefined, undefined, 1 );
}

// Namespace br_powerups
// Params 1
// Checksum 0xf54deeba, Offset: 0x1a15
// Size: 0x37
function function_4aa1d175b03e7bb2( value )
{
    assert( isplayer( self ), "<dev string:x19a>" );
    self.point_scalar = value;
    rank::addrankxpmultiplier( value, "br_poweurup" );
}

// Namespace br_powerups
// Params 0
// Checksum 0x4ba2aa30, Offset: 0x1a54
// Size: 0x1c
function function_4dfff50b5990a2f1()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    thread points::doscoreevent( #"br_powerup" );
}

// Namespace br_powerups
// Params 1
// Checksum 0x4bf7493f, Offset: 0x1a78
// Size: 0x37
function function_9cb32c6aa5df51( powerup_name )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "powerup_name";
    eventparams[ eventparams.size ] = powerup_name;
    dlog_recordevent( "dlog_event_br_powerup_collected", eventparams );
}

// Namespace br_powerups
// Params 2
// Checksum 0x1b51440c, Offset: 0x1ab7
// Size: 0x4c
function function_52bad1f01672b8e4( powerup_name, spawn_method )
{
    eventparams = [ "powerup_name", powerup_name, "spawn_method", spawn_method ];
    dlog_recordevent( "dlog_event_br_powerup_spawned", eventparams );
}

/#

    // Namespace br_powerups
    // Params 0
    // Checksum 0xe31cc876, Offset: 0x1b0b
    // Size: 0x44, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1c6>" );
        devgui::add_devgui_func( "<dev string:x1d3>", "<dev string:x1e8>", &function_8c05c64a7542ebf6 );
        devgui::add_devgui_func( "<dev string:x20c>", "<dev string:x21c>", &function_c3d5aff16a51ed5d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0x499d3000, Offset: 0x1b57
    // Size: 0x1b9, Type: dev
    function function_8c05c64a7542ebf6()
    {
        origin = level.player.origin + ( 0, 0, 500 );
        info = powerups::get_powerup_info( "<dev string:x23c>" );
        scriptable_name = info.scriptable;
        ent = spawn( "<dev string:x24a>", origin );
        ent setmodel( "<dev string:x257>" );
        powerup = spawnscriptable( scriptable_name, origin, ( 0, 0, 0 ) );
        powerup utility::function_7c10ea82c1e305b8( "<dev string:x262>", "<dev string:x26a>" );
        powerup utility::scriptable_setparententity( ent, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        ent thread function_b7b101579f3d647c();
        ent = spawn( "<dev string:x24a>", origin );
        ent setmodel( "<dev string:x257>" );
        powerup = spawnscriptable( scriptable_name, origin, ( 0, 0, 0 ) );
        powerup utility::function_7c10ea82c1e305b8( "<dev string:x262>", "<dev string:x26a>" );
        powerup utility::scriptable_setparententity( ent, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        ent thread function_6e48b71b6315e671();
        ent = spawn( "<dev string:x24a>", origin );
        ent setmodel( "<dev string:x257>" );
        powerup = spawnscriptable( scriptable_name, origin, ( 0, 0, 0 ) );
        powerup utility::function_7c10ea82c1e305b8( "<dev string:x262>", "<dev string:x26a>" );
        powerup utility::scriptable_setparententity( ent, ( 0, 100, 0 ), ( 0, 0, 0 ) );
        ent thread function_6e48b61b6315e43e();
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0xd0c80904, Offset: 0x1d18
    // Size: 0x7c, Type: dev
    function function_b7b101579f3d647c()
    {
        origin = self.origin;
        
        while ( true )
        {
            newpos = origin;
            newpos += ( 0, 250, 0 ) * sin( gettime() * 0.05 );
            newpos += ( 250, 0, 0 ) * cos( gettime() * 0.05 );
            self.origin = newpos;
            waitframe();
        }
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0x529d0f2a, Offset: 0x1d9c
    // Size: 0x56, Type: dev
    function function_6e48b71b6315e671()
    {
        origin = self.origin;
        
        while ( true )
        {
            self moveto( origin + ( 0, 0, -500 ), 3 );
            wait 3;
            self moveto( origin, 3 );
            wait 3;
        }
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0x1372ed3f, Offset: 0x1dfa
    // Size: 0x2b, Type: dev
    function function_6e48b61b6315e43e()
    {
        while ( true )
        {
            self rotateby( ( 0, 180, 0 ), 5 );
            wait 5;
        }
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0x236dfafb, Offset: 0x1e2d
    // Size: 0x27, Type: dev
    function function_c3d5aff16a51ed5d()
    {
        if ( !getdvarint( @"hash_340406f5e0972920" ) )
        {
            function_d54d6f4f8e92a6df();
            return;
        }
        
        function_ac1574f68caacd63();
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0x3ebc0c9e, Offset: 0x1e5c
    // Size: 0x1f, Type: dev
    function function_d54d6f4f8e92a6df()
    {
        setdvar( @"hash_340406f5e0972920", 1 );
        iprintlnbold( "<dev string:x270>" );
    }

    // Namespace br_powerups
    // Params 0
    // Checksum 0x8d05cc47, Offset: 0x1e83
    // Size: 0x2a, Type: dev
    function function_ac1574f68caacd63()
    {
        setdvar( @"hash_340406f5e0972920", 0 );
        iprintlnbold( "<dev string:x28b>" );
        level notify( #"hash_ab17fba335cd85fd" );
    }

    // Namespace br_powerups
    // Params 4
    // Checksum 0xbbb25fcf, Offset: 0x1eb5
    // Size: 0x4b, Type: dev
    function function_f92b2dbeab56ebb( v_pos, var_166ae00b4da0d41d, str_color, var_f1e47669f7416b3e )
    {
        debug::print3d( v_pos, var_166ae00b4da0d41d, str_color, undefined, "<dev string:x2a7>", undefined, 1, 0.15, 35 - 2 * var_f1e47669f7416b3e );
    }

#/
