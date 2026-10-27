// scripts\mp\zm\ztron\ztron_utility.gsc  (hash_764cab28b23ab290.gscc) (size: 19421 Bytes / 0x4bdd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ed32db5 (1859333557)
// size ...... 19421 (0x4bdd)
// includes .. 16  (offset: 0x4921)
// strings ... 34  (offset: 0x49a1)
// dev strs .. 9   (offset: 0x4b5d)
// exports ... 75  (offset: 0x2ea1)
// cseg ...... 0x2c7 + 0x2bda (0x2ea1)
// imports ... 122 (offset: 0x3a59)
// animtree1 . 0   (offset: 0x4bdd)
// animtree2 . 0   (offset: 0x4bdd)
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\damage_numbers;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_util;

// Namespace ztron_util
// Params 7
// Checksum 0x7283bd0d, Offset: 0x2e5
// Size: 0xc9
function radialdamage( origin, playerradius = 64, airadius = 128, damageplayer = 100, damageai = 512, owner = undefined, mod = "MOD_EXPLOSIVE" )
{
    radiusdamage( origin, playerradius, damageplayer, damageplayer >> 2, owner, mod );
    
    /#
        if ( getdvarint( @"hash_8ea44c9fb3058bb5", 0 ) >= 1 )
        {
            level thread ztron_debug::drawsphere( origin, playerradius, 1, ( 1, 0, 0 ) );
        }
    #/
    
    function_7e8b8153f3f2566( origin, airadius, damageai, owner );
}

// Namespace ztron_util
// Params 5
// Checksum 0x72d41ec6, Offset: 0x3b6
// Size: 0x1e9
function function_7e8b8153f3f2566( origin, radius = 128, damage = 512, owner = undefined, mod = "MOD_EXPLOSIVE" )
{
    /#
        if ( getdvarint( @"hash_8ea44c9fb3058bb5", 0 ) >= 1 )
        {
            level thread ztron_debug::drawsphere( origin, radius, 1, ( 1, 1, 0 ) );
        }
    #/
    
    aigroup = getaiarrayinradius( origin, radius );
    processed = 0;
    radiussq = radius * radius;
    
    foreach ( ai in aigroup )
    {
        if ( ai.team == owner.team )
        {
            continue;
        }
        
        if ( ai.ztron.boss )
        {
            continue;
        }
        
        if ( !isalive( owner ) )
        {
            owner = undefined;
        }
        
        fracdmg = clamp( distance2dsquared( ai.origin, origin ) / radiussq, 0, 1 );
        dmg = int( damage * fracdmg );
        ai dodamage( dmg, origin + ( 0, 0, 12 ), owner, owner, mod );
        
        if ( ai.health > 0 )
        {
            if ( ai zombie_knockdown::function_19d6107cb6bdff5c() == 0 )
            {
                ai zombie_knockdown::function_6fc167d4a3590991( origin );
            }
        }
        
        processed++;
        
        if ( processed > 5 )
        {
            processed = 0;
            waitframe();
        }
    }
}

// Namespace ztron_util
// Params 2
// Checksum 0x3b67ab15, Offset: 0x5a7
// Size: 0x135
function killallenemies( var_7336555f4fb16f50 = 1, deleteai = 0 )
{
    self notify( #"hash_ecd915aff8fde12b" );
    self endon( #"hash_ecd915aff8fde12b" );
    level.ztron.var_87c3bb3342238709 = 1;
    zombies = level.ztron.zombies;
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( !var_7336555f4fb16f50 && zombie.ztron.boss )
        {
            continue;
        }
        
        if ( deleteai )
        {
            zombie delete();
        }
        else
        {
            zombie kill();
        }
        
        waitframe();
    }
    
    level.ztron.var_87c3bb3342238709 = 0;
}

// Namespace ztron_util
// Params 7
// Checksum 0xaed702ba, Offset: 0x6e4
// Size: 0xc3
function function_c8250171b708089c( ent = level, flag = "ztron_round_spawning", time = 0, attacker, mod = "MOD_UNKNOWN", var_f7ac6c0c54ca2011 = 1, bosscheck = 1 )
{
    self notify( #"hash_942f04fc1e9c0172" );
    self endon( #"hash_942f04fc1e9c0172" );
    self endon( #"death" );
    
    while ( ent utility::flag( flag ) )
    {
        wait 0.5;
    }
    
    thread function_ea0a0be5c5468c48( time, attacker, mod, var_f7ac6c0c54ca2011, bosscheck );
}

// Namespace ztron_util
// Params 5
// Checksum 0x4192db57, Offset: 0x7af
// Size: 0x132
function function_ea0a0be5c5468c48( time = 0, attacker, mod = "MOD_UNKNOWN", var_f7ac6c0c54ca2011 = 1, bosscheck = 1 )
{
    self notify( #"hash_fad296df3b4f9a45" );
    self endon( #"hash_fad296df3b4f9a45" );
    level endon( #"ztron_game_is_over" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_d89c9a083a4bef17 )
    {
        return;
    }
    
    if ( self.ztron.boss && bosscheck )
    {
        return;
    }
    
    self endon( #"death" );
    function_d2b15d607da99c9c( time );
    
    while ( gettime() < self.var_def84e346e4db0c2 )
    {
        wait 0.28;
    }
    
    self setcandamage( 1 );
    val::set_allow_death( 1 );
    self.var_a436a6789de5017c = var_f7ac6c0c54ca2011;
    
    if ( self.ztron.boss )
    {
        self kill();
        return;
    }
    
    self dodamage( self.health, self.origin, attacker, attacker, mod, undefined );
}

// Namespace ztron_util
// Params 3
// Checksum 0x11ac9aff, Offset: 0x8e9
// Size: 0x9d
function function_b9c77e54af91a636( dir, dirmag = 100, var_24ed309d808c077a )
{
    profilestart();
    
    if ( self.no_ragdoll )
    {
        profilestop();
        return;
    }
    
    self.var_33df89471a965163 = 1;
    
    if ( !isdefined( var_24ed309d808c077a ) )
    {
        var_24ed309d808c077a = self getcorpseentity();
    }
    
    if ( dir && isdefined( var_24ed309d808c077a ) )
    {
        dirmag = clamp( dirmag, 0, 400000 );
        v_launch = dir * dirmag;
        var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch );
        ztron_sound::ztron_playsound( "ztron_ragdoll_launched", self.origin );
    }
    
    profilestop();
    return var_24ed309d808c077a;
}

// Namespace ztron_util
// Params 4
// Checksum 0x73bfbff0, Offset: 0x990
// Size: 0xa3
function function_afa1f6a404783c8a( dir, dirmag = 100, attacker, var_f7ac6c0c54ca2011 = 1 )
{
    assert( !isplayer( self ) );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.ztron.boss )
    {
        return;
    }
    
    function_ea0a0be5c5468c48( 0, attacker, undefined, var_f7ac6c0c54ca2011 );
    
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        return;
    }
    
    if ( self.var_33df89471a965163 )
    {
        return;
    }
    
    dir = vectornormalize( dir );
    return function_b9c77e54af91a636( dir, dirmag );
}

// Namespace ztron_util
// Params 1
// Checksum 0x970ca7c5, Offset: 0xa3c
// Size: 0x42
function function_d2b15d607da99c9c( timesec )
{
    dietime = gettime();
    
    if ( isdefined( timesec ) )
    {
        dietime += timesec * 1000;
    }
    
    self.marked_for_death = 1;
    self.var_def84e346e4db0c2 = dietime;
}

// Namespace ztron_util
// Params 2
// Checksum 0x68671d54, Offset: 0xa86
// Size: 0x64
function function_494e6b73ea596cc7( timeout = 5, var_62674cf7698a32f9 )
{
    if ( timeout > 0 )
    {
        timeout = gettime() + timeout * 1000;
        
        while ( function_cdd411b0cc1f9d80( var_62674cf7698a32f9 ).size > 0 && gettime() < timeout )
        {
            waitframe();
        }
        
        return;
    }
    
    while ( function_cdd411b0cc1f9d80( var_62674cf7698a32f9 ).size > 0 )
    {
        waitframe();
    }
}

// Namespace ztron_util
// Params 3
// Checksum 0x9d78bf09, Offset: 0xaf2
// Size: 0x6b
function function_3fe38741460a4a49( start, var_7aacb80d67dab837 = 48, downdelta = -1024 )
{
    groundtracecontents = trace::create_world_contents();
    groundtrace = trace::ray_trace( start + ( 0, 0, var_7aacb80d67dab837 ), start + ( 0, 0, downdelta ), undefined, groundtracecontents );
    return groundtrace[ "position" ];
}

// Namespace ztron_util
// Params 3
// Checksum 0xf5b5723c, Offset: 0xb66
// Size: 0x8e
function function_edbdef29925b4c66( start, var_7aacb80d67dab837 = 48, downdelta = -1024 )
{
    groundtracecontents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_itemclip", "physicscontents_water" ] );
    groundtrace = trace::ray_trace( start + ( 0, 0, var_7aacb80d67dab837 ), start + ( 0, 0, downdelta ), undefined, groundtracecontents );
    return groundtrace[ "position" ];
}

// Namespace ztron_util
// Params 1
// Checksum 0x97e6f681, Offset: 0xbfd
// Size: 0x94
function deletemedelay( time )
{
    self endon( #"death" );
    
    if ( time > 0 )
    {
        wait time;
    }
    
    self notify( #"deletemedelay" );
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    if ( isdefined( self.pickup ) )
    {
        self.pickup = undefined;
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    waittillframeend();
    
    if ( isai( self ) )
    {
        agent_utils::despawnagent();
        return;
    }
    
    self delete();
}

// Namespace ztron_util
// Params 2
// Checksum 0x76ec1316, Offset: 0xc99
// Size: 0x37
function retrynotification( note, waittime = 6 )
{
    self endon( #"death" );
    self endon( note );
    wait waittime;
    self notify( note );
}

// Namespace ztron_util
// Params 1
// Checksum 0x4386be7, Offset: 0xcd8
// Size: 0x1a
function function_d54d1c1fe00833d6( waitdelay )
{
    if ( isdefined( waitdelay ) )
    {
        wait waitdelay;
    }
    
    removeallcorpses();
}

// Namespace ztron_util
// Params 0
// Checksum 0xb8742ff6, Offset: 0xcfa
// Size: 0x17
function function_7b0c2b51587cc10b()
{
    enemies = function_cdd411b0cc1f9d80();
    return enemies.size;
}

// Namespace ztron_util
// Params 1
// Checksum 0xbee79d82, Offset: 0xd1a
// Size: 0xd3
function function_8d52724a8d58c635( name )
{
    results = [];
    
    foreach ( enemy in function_cdd411b0cc1f9d80() )
    {
        if ( isdefined( enemy.var_71c2b26838e90f44.name ) && getxhash( enemy.var_71c2b26838e90f44.name ) == getxhash( name ) )
        {
            results = arraycombineunique( results, [ enemy ] );
        }
    }
    
    return results.size;
}

// Namespace ztron_util
// Params 1
// Checksum 0x1ba9077, Offset: 0xdf6
// Size: 0xc8
function function_cdd411b0cc1f9d80( var_62674cf7698a32f9 = 0 )
{
    enemies = level.ztron.zombies;
    
    if ( var_62674cf7698a32f9 )
    {
        var_642a703e8da6eabc = [];
        
        foreach ( enemy in enemies )
        {
            if ( enemy.allowdeath )
            {
                var_642a703e8da6eabc[ var_642a703e8da6eabc.size ] = enemy;
            }
        }
        
        return var_642a703e8da6eabc;
    }
    
    return enemies;
}

// Namespace ztron_util
// Params 0
// Checksum 0x275127a0, Offset: 0xec6
// Size: 0x84
function function_4430e75095fb2a8()
{
    enemies = function_cdd411b0cc1f9d80();
    
    foreach ( var_47e68fbe52b828e8 in enemies )
    {
        var_47e68fbe52b828e8 thread deletemedelay();
    }
}

// Namespace ztron_util
// Params 4
// Checksum 0x87c6f23d, Offset: 0xf52
// Size: 0x75
function function_618be0d14a064e83( killNote = "death", note, callback, param )
{
    self notify( #"hash_6187e1ec70cfddc7" );
    self endon( #"hash_6187e1ec70cfddc7" );
    self endon( killNote );
    self waittill( note );
    
    if ( !isdefined( callback ) )
    {
        return;
    }
    
    if ( isdefined( param ) )
    {
        self thread [[ callback ]]( param );
        return;
    }
    
    self thread [[ callback ]]();
}

// Namespace ztron_util
// Params 3
// Checksum 0xdec49bde, Offset: 0xfcf
// Size: 0x46
function function_5006c63bedcbf32( note, callback, param )
{
    self notify( #"hash_757ef4a0474f393d" );
    self endon( #"hash_757ef4a0474f393d" );
    function_618be0d14a064e83( "disconnect", note, callback, param );
}

// Namespace ztron_util
// Params 1
// Checksum 0xd4777386, Offset: 0x101d
// Size: 0x69
function function_1544885c712921f8( player )
{
    assert( isdefined( self ), "<dev string:x24>" );
    assert( isdefined( player ), "<dev string:x45>" );
    assert( isplayer( player ), "<dev string:x68>" );
    self endon( #"death" );
    player waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        deletemedelay( 0.05 );
    }
}

// Namespace ztron_util
// Params 1
// Checksum 0x510a363, Offset: 0x108e
// Size: 0x2c
function function_f7544bfa701db406( other )
{
    self endon( #"death" );
    other waittill( #"death" );
    self delete();
}

// Namespace ztron_util
// Params 2
// Checksum 0xc09d19c0, Offset: 0x10c2
// Size: 0x92
function function_36239518d8da65f0( other, note )
{
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    killNote = function_86d9bcab81b0ff0d( "DeleteNote" );
    thread function_2cd33e629c27f1a( other, killNote );
    
    if ( isplayer( other ) )
    {
        if ( note == "disconnect" )
        {
            other waittill( note, killNote );
        }
        else
        {
            other utility::waittill_any( note, "disconnect", killNote );
        }
    }
    else
    {
        other waittill( note, killNote );
    }
    
    if ( isdefined( self ) )
    {
        deletemedelay( 0 );
    }
}

// Namespace ztron_util
// Params 1
// Checksum 0x157d57de, Offset: 0x115c
// Size: 0x97
function function_86d9bcab81b0ff0d( note )
{
    if ( !isdefined( level.ztron.var_ca3e3ed09aecd236 ) )
    {
        level.ztron.var_ca3e3ed09aecd236 = [];
    }
    
    if ( !isdefined( level.ztron.var_ca3e3ed09aecd236[ note ] ) )
    {
        level.ztron.var_ca3e3ed09aecd236[ note ] = 0;
    }
    
    level.ztron.var_ca3e3ed09aecd236[ note ]++;
    return note + level.ztron.var_ca3e3ed09aecd236[ note ];
}

// Namespace ztron_util
// Params 2
// Checksum 0xfb1be0cc, Offset: 0x11fc
// Size: 0x3f
function function_2cd33e629c27f1a( other, note )
{
    self endon( note );
    other endon( #"death" );
    self waittill( #"death" );
    
    if ( isdefined( other ) )
    {
        other notify( note );
    }
}

// Namespace ztron_util
// Params 3, eflags: 0x40 variadic
// Checksum 0x4a4b892b, Offset: 0x1243
// Size: 0xab
function function_b0697f1cfec70e89( other, ... )
{
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    killNote = function_86d9bcab81b0ff0d( "killNote" );
    thread function_2cd33e629c27f1a( other, killNote );
    
    if ( isplayer( other ) )
    {
        vararg[ vararg.size ] = "disconnect";
    }
    
    other utility::waittill_any_in_array( vararg );
    
    if ( isdefined( self ) )
    {
        self notify( killNote );
        self.var_733489a99ee7b669 = undefined;
        self.allowdeath = 1;
        self dodamage( self.health + 187, self.origin );
    }
}

// Namespace ztron_util
// Params 1
// Checksum 0x1d05ce0, Offset: 0x12f6
// Size: 0x1f
function function_9ecee6f38c56d30f( var_748d21f0ae3805f1 )
{
    thread fade_out_hold( var_748d21f0ae3805f1 );
    
    if ( var_748d21f0ae3805f1 > 0 )
    {
        wait var_748d21f0ae3805f1;
    }
}

// Namespace ztron_util
// Params 0
// Checksum 0xdd591190, Offset: 0x131d
// Size: 0xa0
function function_52cbd62de5b033c9()
{
    self notify( #"hash_7efa5ec337acbfb7" );
    self endon( #"hash_7efa5ec337acbfb7" );
    
    foreach ( player in level.players )
    {
        player fade_in();
    }
    
    level utility::flag_clear( "ztron_screen_faded" );
}

// Namespace ztron_util
// Params 1
// Checksum 0xc02a5247, Offset: 0x13c5
// Size: 0xdd
function fade_out_hold( var_748d21f0ae3805f1 = 0 )
{
    self notify( #"hash_2a9be336a1ec77d4" );
    self endon( #"hash_2a9be336a1ec77d4" );
    level endon( #"ztron_game_is_over" );
    level endon( #"hash_29ae96b30157b13c" );
    level utility::flag_set( "ztron_screen_faded", 1 );
    level notify( #"fade_out_started" );
    
    foreach ( player in level.players )
    {
        player fade_out( 1, 0, var_748d21f0ae3805f1 );
    }
}

// Namespace ztron_util
// Params 3
// Checksum 0x900ce13a, Offset: 0x14aa
// Size: 0x12b
function fade_out( b_freeze = 1, b_keep_ui = 0, var_748d21f0ae3805f1 = 1 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( b_freeze )
    {
        set_player_frozen_vars( 1, "ztron_fade" );
    }
    
    screenfaded = b_keep_ui ? self.ztron.var_3adf48c8e0d5c38 : self.ztron.var_826c4ba9ffdf5dda;
    
    if ( isdefined( self.ztron ) && !screenfaded )
    {
        if ( b_keep_ui )
        {
            self.ztron.var_3adf48c8e0d5c38 = 1;
            thread game_utility::fadetoblackforplayerkeepui( self, 1, var_748d21f0ae3805f1 );
        }
        else
        {
            self.ztron.var_826c4ba9ffdf5dda = 1;
            thread game_utility::fadetoblackforplayer( self, 1, var_748d21f0ae3805f1 );
        }
    }
    
    ztron_debug::debugmsg( "Player fade_out called: " + self.name );
    level notify( #"fade_out_complete" );
    self notify( #"fade_out_complete" );
}

// Namespace ztron_util
// Params 3
// Checksum 0x116be61, Offset: 0x15dd
// Size: 0x123
function fade_in( b_unfreeze = 1, b_keep_ui = 0, var_748d21f0ae3805f1 = 1 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    level notify( #"hash_29ae96b30157b13c" );
    screenfaded = b_keep_ui ? self.ztron.var_3adf48c8e0d5c38 : self.ztron.var_826c4ba9ffdf5dda;
    
    if ( screenfaded )
    {
        if ( b_keep_ui )
        {
            self.ztron.var_3adf48c8e0d5c38 = 0;
            thread game_utility::fadetoblackforplayerkeepui( self, 0, var_748d21f0ae3805f1 );
        }
        else
        {
            self.ztron.var_826c4ba9ffdf5dda = 0;
            thread game_utility::fadetoblackforplayer( self, 0, var_748d21f0ae3805f1 );
        }
    }
    
    if ( b_unfreeze )
    {
        set_player_frozen_vars( 0, "ztron_fade" );
    }
    
    ztron_debug::debugmsg( "Player fade_in called: " + self.name );
    level notify( #"fade_in_complete" );
    self notify( #"fade_in_complete" );
}

// Namespace ztron_util
// Params 2
// Checksum 0x9d4dbf0b, Offset: 0x1708
// Size: 0x96
function teleport_player( v_origin, v_angles )
{
    profilestart();
    
    if ( ztron_player_utility::isplayerspectating() )
    {
        profilestop();
        return;
    }
    
    self dontinterpolate();
    
    if ( isdefined( self.ztron.vehicle ) )
    {
        var_79858549043f6653 = ( 0, 0, 0 );
        
        if ( isdefined( v_angles ) )
        {
            var_79858549043f6653 = v_angles;
        }
        
        self.ztron.vehicle vehicle_teleport( v_origin, var_79858549043f6653 );
    }
    else
    {
        self setorigin( v_origin );
        
        if ( isdefined( v_angles ) )
        {
            self setplayerangles( v_angles );
        }
    }
    
    profilestop();
}

// Namespace ztron_util
// Params 4
// Checksum 0x47cbfbc3, Offset: 0x17a6
// Size: 0x13b
function warpplayer( player, point, var_73b42356d9fb64b5 = 1, fade = 1 )
{
    player endon( #"death_or_disconnect" );
    
    if ( fade )
    {
        player fade_out();
    }
    
    if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
    {
        player thread ztron_player_utility::function_ca24a1915072ab29( point.origin, level.ztron.var_d2cdda04885d49d2 ?? 0 );
    }
    
    player teleport_player( point.origin, point.angles );
    player ztron_player_utility::function_e914a81b9f8ce0c8( point.origin );
    player ztron_camera::flipTopdownCamera( level.ztron.arenaCamFlip, var_73b42356d9fb64b5 );
    player ztron_camera::function_9fbc0b40b3c0f437( 1 );
    player notify( #"ztron_playerdumpfps" );
    player notify( #"ztron_player_dump_vehicle" );
    
    if ( fade )
    {
        wait 1;
        player ztron_camera::function_9fbc0b40b3c0f437( 0 );
        player fade_in();
        return;
    }
    
    wait 0.1;
    player ztron_camera::function_9fbc0b40b3c0f437( 0 );
}

// Namespace ztron_util
// Params 2
// Checksum 0xa779bda0, Offset: 0x18e9
// Size: 0x8f
function set_player_frozen_vars( var_94d1ab5da995e573, str_id )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( var_94d1ab5da995e573 )
    {
        val::set( str_id, "fire", 0 );
        val::set( str_id, "allow_movement", 0 );
        val::set( str_id, "ignoreme", 1 );
        val::set( str_id, "freezecontrols", 1 );
        val::set( str_id, "killstreaks", 0 );
        self.b_ignore_playable_area_check = 1;
        return;
    }
    
    self.b_ignore_playable_area_check = 0;
    val::reset_all( str_id );
}

// Namespace ztron_util
// Params 2
// Checksum 0xa5981dc7, Offset: 0x1980
// Size: 0xf5
function function_5daccb5b5c655ae5( origin, dist = 1024 )
{
    closestplayer = undefined;
    closestdistsq = undefined;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        distsq = distancesquared( origin, player.origin );
        
        if ( distsq > squared( dist ) )
        {
            continue;
        }
        
        if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
        {
            closestdistsq = distsq;
            closestplayer = player;
        }
    }
    
    return closestplayer;
}

// Namespace ztron_util
// Params 3
// Checksum 0xd96b7bbe, Offset: 0x1a7e
// Size: 0x36
function function_b1b04d15b778298b( array, origin, dist )
{
    furthestordered = sortbydistance( array, origin, 1 );
    return furthestordered[ 0 ];
}

// Namespace ztron_util
// Params 2
// Checksum 0x281c7c27, Offset: 0x1abd
// Size: 0x46
function function_5659cc5e67df6dfe( origin, dist = 1024 )
{
    aiarray = getaiarrayinradius( origin, dist );
    closestai = sortbydistance( aiarray, origin );
    return closestai[ 0 ];
}

// Namespace ztron_util
// Params 2
// Checksum 0xa923c621, Offset: 0x1b0c
// Size: 0xc8
function function_3b544615f0db8722( origin, dist = 1024 )
{
    sentientarray = getaiarrayinradius( origin, dist );
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        sentientarray[ sentientarray.size ] = player;
    }
    
    closestsentient = sortbydistance( sentientarray, origin );
    return closestsentient[ 0 ];
}

// Namespace ztron_util
// Params 1
// Checksum 0xf1d46724, Offset: 0x1bdd
// Size: 0x1e
function rotateme( time = 4 )
{
    thread function_b59665f20a2dbee( time );
}

// Namespace ztron_util
// Params 2
// Checksum 0x1704fcca, Offset: 0x1c03
// Size: 0x9e
function function_b59665f20a2dbee( halfturn = 0.6, clockwise = 1 )
{
    self endon( #"death", #"stoprotate" );
    angle = clockwise ? ( 0, 180, 0 ) : ( 0, -180, 0 );
    
    while ( isdefined( self ) )
    {
        self.desiredrotate = self.angles + angle;
        self rotateto( self.desiredrotate, halfturn );
        wait halfturn;
    }
}

// Namespace ztron_util
// Params 2
// Checksum 0x4ce5a405, Offset: 0x1ca9
// Size: 0xe2
function fakemoveto( location, timesec = 1 )
{
    self notify( #"fakemoveto" );
    self endon( #"fakemoveto" );
    self endon( #"death" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    if ( timesec <= 0 )
    {
        timesec = 1;
    }
    
    frames = timesec / level.framedurationseconds;
    increment = ( self.origin - location ) / frames;
    targettime = gettime() + timesec * 1000;
    
    while ( gettime() < targettime )
    {
        self.origin -= increment;
        waitframe();
    }
    
    self.origin = location;
    waitframe();
    self notify( #"movedone" );
}

// Namespace ztron_util
// Params 1
// Checksum 0xcb42936d, Offset: 0x1d93
// Size: 0x53
function function_93f43b1536a8b155( range = 3000 )
{
    zombiearray = getaiarrayinradius( self.origin, range, zm_utility::get_zombie_team() );
    closestzombie = sortbydistance( zombiearray, self.origin );
    return closestzombie[ 0 ];
}

// Namespace ztron_util
// Params 0
// Checksum 0xfb96a5cd, Offset: 0x1def
// Size: 0x91
function function_aff0434b226c0f6d()
{
    foreach ( player in level.players )
    {
        if ( player.team )
        {
            return player.team;
        }
    }
    
    return "tie";
}

// Namespace ztron_util
// Params 1
// Checksum 0xf75adcc6, Offset: 0x1e89
// Size: 0x4a
function function_da4039e4c338f818( attacker )
{
    playerattacker = undefined;
    
    if ( isplayer( attacker ) )
    {
        playerattacker = attacker;
    }
    else if ( isplayer( attacker.owner ) )
    {
        playerattacker = attacker.owner;
    }
    
    return playerattacker;
}

// Namespace ztron_util
// Params 0
// Checksum 0x5b35e155, Offset: 0x1edc
// Size: 0x7e, Type: bool
function function_5a0e1527359f13d7()
{
    checkpapaback = self.subclass == "ztron_papaback" && !self.ztron.var_409dbcca0b46e13d && !self.var_9f4fae59ff4e962a;
    notignored = !self.ignoreme;
    var_515c824ad5cf4b42 = !self.ignoreall && self getcandamage();
    return checkpapaback && notignored & var_515c824ad5cf4b42;
}

// Namespace ztron_util
// Params 2
// Checksum 0xa9adb251, Offset: 0x1f63
// Size: 0x3c
function getyaw2d( toorg, fromorg )
{
    angles = vectortoangles( ( toorg[ 0 ], toorg[ 1 ], 0 ) - ( fromorg[ 0 ], fromorg[ 1 ], 0 ) );
    return angles[ 1 ];
}

// Namespace ztron_util
// Params 0
// Checksum 0xc152ddfc, Offset: 0x1fa8
// Size: 0xc7
function function_8a7307d20b12f13f()
{
    playercount = level.players.size;
    
    if ( !isdefined( level.ztron.roundplayercount ) || level.ztron.roundplayercount == 0 )
    {
        level.ztron.roundplayercount = playercount;
    }
    
    roundstotal = int( clamp( level.ztron.roundnumber, 1, level.ztron.roundnumber ) );
    avgplayercount = int( clamp( level.ztron.roundplayercount / roundstotal, playercount, 4 ) );
    return avgplayercount;
}

// Namespace ztron_util
// Params 0, eflags: 0x4
// Checksum 0x43a58ff4, Offset: 0x2078
// Size: 0xcf, Type: bool
function private function_45b40e02f6d7f9fd()
{
    trigger_classnames = [ "trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "noent_volume_trigger_box", "noent_volume_trigger_radius" ];
    
    foreach ( classname in trigger_classnames )
    {
        if ( self.code_classname == classname || self.classname == classname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_util
// Params 0
// Checksum 0xd778fd33, Offset: 0x2150
// Size: 0x7b
function function_2f4d27d87e05d778()
{
    if ( isdefined( self.target ) )
    {
        ent = function_95ca81ff822c3de4( self.target, #targetname );
        
        if ( isdefined( ent ) && ent function_45b40e02f6d7f9fd() )
        {
            while ( true )
            {
                ent waittill( #"trigger", triggerent );
                
                if ( isplayer( triggerent ) && ent function_b0b72d20769d0233() )
                {
                    return triggerent;
                }
            }
        }
    }
}

// Namespace ztron_util
// Params 2
// Checksum 0x36d82b2c, Offset: 0x21d4
// Size: 0x42
function orgspinout( vel = 1080, time = 9999 )
{
    self endon( #"death" );
    self rotatevelocity( ( 0, vel, 0 ), time );
}

// Namespace ztron_util
// Params 3
// Checksum 0xbbc84158, Offset: 0x221e
// Size: 0x5a, Type: bool
function pointcmp( a, b, originpoint )
{
    var_30fb80e4595ff75d = distancesquared( a.origin, originpoint );
    dist2sq = distancesquared( b.origin, originpoint );
    return var_30fb80e4595ff75d < dist2sq;
}

// Namespace ztron_util
// Params 2
// Checksum 0xe71d7427, Offset: 0x2281
// Size: 0x4f
function function_c5ac6dde1c89cb8f( var_adb17f6398e92e69, var_899ec8cfd6f89eb7 )
{
    assert( isdefined( var_adb17f6398e92e69 ) );
    assert( isdefined( var_899ec8cfd6f89eb7 ) );
    
    if ( var_adb17f6398e92e69.size == 0 )
    {
        return;
    }
    
    sorted = arraysort( var_adb17f6398e92e69, var_899ec8cfd6f89eb7, &pointcmp );
    return sorted[ 0 ];
}

// Namespace ztron_util
// Params 3
// Checksum 0x361fb242, Offset: 0x22d9
// Size: 0x5e
function function_95ca81ff822c3de4( name, key, ignore_spawners )
{
    ent = getent( name, key, ignore_spawners ?? 0 );
    
    if ( !isdefined( ent ) )
    {
        entarray = getnoentvolumearray( name, key );
        
        if ( entarray.size > 0 )
        {
            ent = entarray[ 0 ];
        }
    }
    
    return ent;
}

// Namespace ztron_util
// Params 3
// Checksum 0x5bf527f4, Offset: 0x2340
// Size: 0x48
function function_2d9de5c7b97db39( name, key, ignore_spawners )
{
    ents = getentarray( name, key, ignore_spawners ?? 0 );
    ents = arraycombine( ents, getnoentvolumearray( name, key ) );
    return ents;
}

// Namespace ztron_util
// Params 3
// Checksum 0x2fd753a6, Offset: 0x2391
// Size: 0x86
function function_78a5b128a3e32460( origin, radius, minradius = 0 )
{
    theta = randomfloat( 360 );
    radius = randomfloatrange( minradius, radius );
    offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
    randompoint = origin + offset + ( 0, 0, 24 );
    randompoint = getclosestpointonnavmesh( randompoint );
    return randompoint;
}

// Namespace ztron_util
// Params 1
// Checksum 0x1830d200, Offset: 0x2420
// Size: 0x5b
function function_9737472712bf3b7e( deltavelocity )
{
    multiplier = getdvarfloat( @"hash_e2af68e4ea4a9ddf", 10000 );
    mass = vehicle::get_mass();
    
    if ( multiplier > 0 )
    {
        force = deltavelocity * mass / multiplier;
    }
    
    return clamp( force, 0, 255 );
}

// Namespace ztron_util
// Params 0
// Checksum 0xce2efbcd, Offset: 0x2484
// Size: 0x30
function slickclipsave()
{
    self.var_7b446d047112ac1c = getdvarint( @"hash_5218f366e6f0bb3e", 0 );
    self.var_b66b989a622bb6 = getdvarint( @"hash_f6f640e9b0a7a03c", 0 );
}

// Namespace ztron_util
// Params 0
// Checksum 0xd5275a39, Offset: 0x24bc
// Size: 0x22
function slickclipsetup()
{
    setdvar( @"hash_5218f366e6f0bb3e", 1 );
    setdvar( @"hash_f6f640e9b0a7a03c", 1 );
}

// Namespace ztron_util
// Params 0
// Checksum 0x1535c921, Offset: 0x24e6
// Size: 0x30
function slickcliprestore()
{
    setdvar( @"hash_5218f366e6f0bb3e", self.var_7b446d047112ac1c );
    setdvar( @"hash_f6f640e9b0a7a03c", self.var_b66b989a622bb6 );
}

// Namespace ztron_util
// Params 0
// Checksum 0xcae8f38c, Offset: 0x251e
// Size: 0x11
function function_b8bad2390c86cb38()
{
    return getdvarfloat( @"hash_d987cd10ad6f5260", 12 );
}

// Namespace ztron_util
// Params 1
// Checksum 0x9e0bc975, Offset: 0x2538
// Size: 0x92
function function_bcfd602f958f46bb( ai )
{
    if ( isdefined( ai.var_cc0cadd2af1c46b5 ) )
    {
        return ai.var_cc0cadd2af1c46b5;
    }
    
    if ( ai.ztron.boss )
    {
        return level.ztron.var_c38ef096a66e58de;
    }
    
    if ( ai.ztron.elite )
    {
        return level.ztron.var_465fa6f0e489652c;
    }
    
    return level.ztron.ai_xp;
}

// Namespace ztron_util
// Params 1
// Checksum 0x4c68b978, Offset: 0x25d3
// Size: 0x1f
function function_48adcba773dadf31( var_fcc69eea267291a6 )
{
    return int( function_b8bad2390c86cb38() * var_fcc69eea267291a6 + 0.5 );
}

// Namespace ztron_util
// Params 1
// Checksum 0xa4026905, Offset: 0x25fb
// Size: 0xf7
function function_4693a81423b56106( origin )
{
    navpoint = getclosestpointonnavmesh( origin );
    
    if ( isdefined( navpoint ) )
    {
        startpos = navpoint + ( 0, 0, 100 );
        endpos = navpoint + ( 0, 0, -100 );
        var_7b9ae2047be4c11d = trace::create_contents( 0, 1, 0, 0, 1, 0, 1 );
        groundresult = physics_raycast( startpos, endpos, var_7b9ae2047be4c11d, undefined, 0, "physicsquery_closest" );
        exitposition = groundresult[ 0 ][ "position" ] ?? navpoint;
        return exitposition;
    }
    else if ( utility::issharedfuncdefined( #"player", #"hash_9bc79685259c8dd2" ) )
    {
        exitposition = utility::callsharedfunc( #"player", #"hash_9bc79685259c8dd2" );
        
        if ( isdefined( exitposition ) )
        {
            return exitposition;
        }
    }
    
    /#
        logstring( "<dev string:x8d>" + navpoint );
    #/
}

// Namespace ztron_util
// Params 3
// Checksum 0x24b24ef6, Offset: 0x26fb
// Size: 0x20c
function function_5bd5e2f5c01a2138( scale = undefined, duration = undefined, context = "veh" )
{
    self notify( #"hash_5a92d1e5d4284e94" );
    self endon( #"hash_5a92d1e5d4284e94" );
    self endon( #"death" );
    self endon( #"interupt_change_speed" );
    scale = scale ?? 1;
    self.var_25438c6f6296d6f = self vehicle_gettopspeedforward();
    self.var_e3d006c6257913eb = self vehicle_gettopspeedreverse();
    self.var_a80a7013e007169e = self vehicle_gettopspeedforward( 1 ) * scale;
    self.var_85ac4a130b19cd5e = self vehicle_gettopspeedreverse( 1 ) * scale;
    durationms = ( duration ?? 0 ) * 1000;
    starttime = gettime();
    
    /#
        logstring( "<dev string:xbd>" + context + "<dev string:xd5>" + "<dev string:xd8>" + self.var_25438c6f6296d6f + "<dev string:xe1>" + self.var_a80a7013e007169e + "<dev string:xeb>" + durationms );
        logstring( "<dev string:xbd>" + context + "<dev string:xd5>" + "<dev string:xd8>" + self.var_e3d006c6257913eb + "<dev string:xe1>" + self.var_85ac4a130b19cd5e + "<dev string:xeb>" + durationms );
    #/
    
    while ( true )
    {
        var_4c5d15cdeda35583 = gettime() - starttime;
        scale = 1;
        
        if ( durationms != 0 )
        {
            scale = clamp( float( var_4c5d15cdeda35583 / durationms ), 0, 1 );
        }
        
        speedfwd = math::lerp( self.var_25438c6f6296d6f, self.var_a80a7013e007169e, scale );
        speedrev = math::lerp( self.var_e3d006c6257913eb, self.var_85ac4a130b19cd5e, scale );
        self vehicle_settopspeedforward( speedfwd );
        self vehicle_settopspeedreverse( speedrev );
        
        if ( speedfwd == self.var_a80a7013e007169e )
        {
            break;
        }
        
        if ( var_4c5d15cdeda35583 >= durationms )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace ztron_util
// Params 0
// Checksum 0x502e9583, Offset: 0x290f
// Size: 0x13, Type: bool
function function_5ba0edd1761596a2()
{
    return getdvarint( @"party_maxplayers", 0 ) == 1;
}

// Namespace ztron_util
// Params 2
// Checksum 0x652d5848, Offset: 0x292b
// Size: 0x33
function function_40ad6a6cc144aa3f( soundalias, delay = 0 )
{
    if ( !isdefined( soundalias ) )
    {
        return;
    }
    
    thread dialogue::say( soundalias, undefined, undefined, undefined, delay );
}

// Namespace ztron_util
// Params 0
// Checksum 0xeb5b7734, Offset: 0x2966
// Size: 0x3a
function function_d0cfe1c172136d8a()
{
    if ( !level.ztron.var_a58d52a0faa75a57 )
    {
        return 0;
    }
    
    return int( clamp( level.ztron.var_a58d52a0faa75a57.size, 0, 16 ) );
}

// Namespace ztron_util
// Params 0
// Checksum 0x9f31abb1, Offset: 0x29a9
// Size: 0x75
function function_34cfaede9c9a96ef()
{
    if ( !level.ztron.var_a58d52a0faa75a57 )
    {
        return 0;
    }
    
    value = 0;
    
    for ( arrayindex = 0; arrayindex < level.ztron.var_a58d52a0faa75a57.size ; arrayindex++ )
    {
        value += level.ztron.var_a58d52a0faa75a57[ arrayindex ] << arrayindex * 2;
    }
    
    return value;
}

// Namespace ztron_util
// Params 2
// Checksum 0x84c5e090, Offset: 0x2a27
// Size: 0x9f
function function_ee48ff8cfbc2fe5( var_a4f3910f283b35ce, branchcount )
{
    if ( !isdefined( var_a4f3910f283b35ce ) || branchcount <= 0 )
    {
        return;
    }
    
    level.ztron.var_a58d52a0faa75a57 = [];
    
    for ( i = 0; i < branchcount ; i++ )
    {
        testbit = var_a4f3910f283b35ce >> i * 2;
        bit = testbit & 3;
        level.ztron.var_a58d52a0faa75a57[ level.ztron.var_a58d52a0faa75a57.size ] = bit;
    }
}

// Namespace ztron_util
// Params 0
// Checksum 0xf69bb05c, Offset: 0x2ace
// Size: 0xcb
function function_8cebff05cffb4fa5()
{
    arena = "island";
    branch = level.ztron.var_30dc288b7210c158[ arena ];
    
    for ( i = 0; i < level.ztron.var_a58d52a0faa75a57.size ; i++ )
    {
        assert( branch );
        branchindex = level.ztron.var_a58d52a0faa75a57[ i ];
        branchindex = int( clamp( branchindex, 0, branch.size - 1 ) );
        arena = branch[ branchindex ];
        branch = level.ztron.var_30dc288b7210c158[ arena ];
    }
    
    return ztron_arena::function_973956bb5a6e60f7( arena ).id;
}

// Namespace ztron_util
// Params 0
// Checksum 0x498ceb96, Offset: 0x2ba2
// Size: 0x21
function function_9bb4cd8565cc00()
{
    return level.players.size - level.ztron.var_909f9ee392414e7.size;
}

// Namespace ztron_util
// Params 0
// Checksum 0x1701fd52, Offset: 0x2bcc
// Size: 0xc7
function function_a5baa3e740328ff1()
{
    playersintrigger = [];
    
    foreach ( player in level.players )
    {
        if ( player istouching( self ) || player.ztron.vehicle && player.ztron.vehicle istouching( self ) )
        {
            playersintrigger[ playersintrigger.size ] = player;
        }
    }
    
    return playersintrigger;
}

// Namespace ztron_util
// Params 1
// Checksum 0x67c8e78d, Offset: 0x2c9c
// Size: 0x85
function function_615c5e65f63b006a( trigger )
{
    var_e3034ec31a8bf4ae = 1;
    
    /#
        if ( level.ztron.dev.var_fd17659ef5557a41 )
        {
            return var_e3034ec31a8bf4ae;
        }
    #/
    
    playercount = function_9bb4cd8565cc00();
    
    if ( playercount > 1 )
    {
        playersintrigger = trigger function_a5baa3e740328ff1();
        
        if ( playersintrigger.size < getdvarint( @"hash_be474cc3316b1b0c", 2 ) )
        {
            var_e3034ec31a8bf4ae = 0;
        }
    }
    
    return var_e3034ec31a8bf4ae;
}

// Namespace ztron_util
// Params 15
// Checksum 0x3072e751, Offset: 0x2d2a
// Size: 0x177
function function_eb8ba16055d6da7c( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e, var_cd5368faab079fc8 = undefined, var_453f10fe0cab5896 = 0, einflictor = undefined, stype = undefined )
{
    if ( !isdefined( eattacker ) )
    {
        return;
    }
    
    if ( eattacker.var_9d75436b168f4f54 && eattacker.var_6cbefd23c1b3a72d.size > 100 )
    {
        var_6cbefd23c1b3a72d = eattacker.var_6cbefd23c1b3a72d;
        eattacker.var_6cbefd23c1b3a72d = [];
        now = gettime();
        
        for ( index = 0; index < var_6cbefd23c1b3a72d.size ; index++ )
        {
            var_817ec4f1dd2382fa = var_6cbefd23c1b3a72d[ index ];
            
            if ( now - var_817ec4f1dd2382fa.damagetime < 1000 )
            {
                eattacker.var_6cbefd23c1b3a72d[ eattacker.var_6cbefd23c1b3a72d.size ] = var_817ec4f1dd2382fa;
            }
        }
    }
    
    damage_numbers::display( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e, var_cd5368faab079fc8, var_453f10fe0cab5896, einflictor, stype );
}

