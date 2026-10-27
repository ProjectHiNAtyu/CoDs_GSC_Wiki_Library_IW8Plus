// script_75994df35243cb2a  (hash_75994df35243cb2a.gscc) (size: 6366 Bytes / 0x18de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ff70673 (2683766387)
// size ...... 6366 (0x18de)
// includes .. 11  (offset: 0x17d2)
// strings ... 13  (offset: 0x182a)
// dev strs .. 0   (offset: 0x18de)
// exports ... 19  (offset: 0xe8a)
// cseg ...... 0x149 + 0xd41 (0xe8a)
// imports ... 54  (offset: 0x1182)
// animtree1 . 0   (offset: 0x18de)
// animtree2 . 0   (offset: 0x18de)
#using script_54a05cbb2455bc6f;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_33e886a9a5b55137;

// Namespace namespace_33e886a9a5b55137
// Params 0, eflags: 0x5
// Checksum 0xdf000d86, Offset: 0x167
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bea982fb7d035b30", #"ztron_item", undefined, &init );
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0x5ad72ce7, Offset: 0x190
// Size: 0x8b
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"boost", #"use", &useboost );
    ztron_item::function_5844a9c240f7dc8d( #"boost", #"canautouse", &function_27464e2f1d09b8e1 );
    ztron_item::function_5844a9c240f7dc8d( #"boost", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
    ztron_item::function_5844a9c240f7dc8d( #"boost", #"hash_87300e1dbd3aa856", &function_27464e2f1d09b8e1 );
    ztron_sound::function_4ac735395b173fe( "player_boost", "evt_ztron_player_dash" );
}

// Namespace namespace_33e886a9a5b55137
// Params 1, eflags: 0x4
// Checksum 0x95d91b12, Offset: 0x223
// Size: 0x8f
function private useboost( params )
{
    item = params.scriptable;
    
    if ( item.inuse )
    {
        return;
    }
    
    level notify( #"item_picked_up", { #player:params.player, #item:params.scriptable } );
    owner = params.player;
    owner function_1b82715a32cd1380();
    item ztron_item::function_f580915d21ddba69( owner );
}

// Namespace namespace_33e886a9a5b55137
// Params 1, eflags: 0x4
// Checksum 0x26716742, Offset: 0x2ba
// Size: 0x19, Type: bool
function private function_27464e2f1d09b8e1( params )
{
    return function_a4ca73e22464e330() < ztron_score::getmaxboosts();
}

// Namespace namespace_33e886a9a5b55137
// Params 1, eflags: 0x4
// Checksum 0xbfdf84c0, Offset: 0x2dc
// Size: 0x1c
function private function_2c983537c15e53e7( params )
{
    params.cleanupdisabled = 1;
    return params;
}

/#

    // Namespace namespace_33e886a9a5b55137
    // Params 1
    // Checksum 0xbe29f299, Offset: 0x301
    // Size: 0x72, Type: dev
    function function_3b07dfd81fd12f4d( trigger )
    {
        self notify( #"hash_c9ba41d9c7c6720d" );
        self endon( #"hash_c9ba41d9c7c6720d" );
        level endon( #"ztron_game_is_over" );
        
        if ( getdvarint( @"hash_1c4410b0efd8746", 0 ) )
        {
            while ( isdefined( trigger ) )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0, 0, 0, ( 1, 0, 0 ) );
                waitframe();
            }
        }
    }

#/

// Namespace namespace_33e886a9a5b55137
// Params 1
// Checksum 0x9496605a, Offset: 0x37b
// Size: 0x5b
function function_bf4ae7c014acb333( player )
{
    self endon( #"death" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        self.origin = player.origin + player.ztron.boostdirection * 200;
        waitframe();
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 1
// Checksum 0x8f5e2a05, Offset: 0x3de
// Size: 0x14d
function function_26465602954fa44e( player )
{
    player endon( #"disconnect" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy ) )
        {
            continue;
        }
        
        if ( !issentient( guy ) )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( !guy.takedamage )
        {
            continue;
        }
        
        if ( guy.ztron.ignorebooster || guy.ztron.boss )
        {
            continue;
        }
        
        if ( !isdefined( guy.team ) )
        {
            continue;
        }
        
        if ( guy.team === player.team )
        {
            continue;
        }
        
        if ( gettime() < guy.ztron.shieldprotected )
        {
            continue;
        }
        
        guy function_7f8988ce63c1623d( 0 );
        player thread ztron_player_utility::function_9dbd11353321b474( "booster", guy.var_945ef487faad2413 );
        var_3df44f796978c518 = guy.origin - self.origin;
        guy thread ztron_util::function_afa1f6a404783c8a( var_3df44f796978c518, 10000 );
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 0, eflags: 0xc
// Checksum 0x3ebcad32, Offset: 0x533
// Size: 0x185
function private updatebooster()
{
    self notify( #"hash_f89765fd41123a3b" );
    self endon( #"hash_f89765fd41123a3b" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    while ( self.ztron.isboosting )
    {
        waitframe();
        time = gettime();
        
        if ( time < self.ztron.boostendtime )
        {
            self setvelocity( self.ztron.boostvector );
            ztron_debug::debugmsg( "Player(" + self.ztron.color + ") BOOSTING active" );
            
            if ( self.ztron.var_9b2b1b27f628ceb1 < time )
            {
                level notify( #"boostlane", { #origin:self.origin } );
                self.ztron.var_9b2b1b27f628ceb1 = time + 250;
            }
            
            continue;
        }
        
        self.ztron.isboosting = 0;
        thread ztron_player_utility::turnPlayerShieldOn();
        
        if ( isdefined( self.ztron.var_f566a419af3206df ) )
        {
            self.ztron.var_f566a419af3206df delete();
        }
        
        self notify( #"boosting_done" );
        ztron_debug::debugmsg( "Player(" + self.ztron.color + ") BOOSTING deactivating" );
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0x2c21ee74, Offset: 0x6c0
// Size: 0x2f5
function deploybooster()
{
    self.ztron.forceboost = 0;
    
    if ( function_a4ca73e22464e330() > 0 )
    {
        self.ztron.isboosting = 1;
        function_744c9d02ea7dbf44();
        self playrumbleonentity( "heavy_1s" );
        thread ztron_player_utility::turnPlayerShieldOn();
        self.ztron.boostdirection = anglestoforward( self.angles );
        ztron_sound::ztron_playsound( "player_boost" );
        self.ztron.var_f566a419af3206df = spawn( "trigger_radius", self.origin, 0, 60, 60 );
        
        if ( isdefined( self.ztron.var_f566a419af3206df ) )
        {
            self.ztron.var_f566a419af3206df.targetname = "triggerBoost";
            self.ztron.var_f566a419af3206df thread ztron_util::function_1544885c712921f8( self );
            self.ztron.var_f566a419af3206df thread ztron_util::deletemedelay( 0.9 );
            self.ztron.var_f566a419af3206df thread function_bf4ae7c014acb333( self );
            self.ztron.var_f566a419af3206df thread function_26465602954fa44e( self );
            
            /#
                level thread function_3b07dfd81fd12f4d( self.ztron.var_f566a419af3206df );
            #/
        }
        
        self.ztron.boostendtime = gettime() + 300;
        self.ztron.boostvector = self.ztron.boostdirection * 2500;
        self.ztron.boostvector += ( 0, 0, 200 );
        self setvelocity( self.ztron.boostvector );
        self.ztron.boostvector -= ( 0, 0, 200 );
        self.ztron.var_9b2b1b27f628ceb1 = 0;
        thread updatebooster();
        
        if ( ztron_fate::function_c93d5c389d532c34( 4, 2 ) || self.ztron.upgradeMask & 2199023255552 )
        {
            thread firetrail( 0.3 );
        }
        
        if ( ztron_fate::function_c93d5c389d532c34( 2, 5 ) )
        {
            params = spawnstruct();
            params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 400 );
            ztron_item::function_d0a061baefd87906( self.origin + ( 0, 0, 100 ), 1, 20, undefined, params );
        }
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 1
// Checksum 0x79f51115, Offset: 0x9bd
// Size: 0x91
function firedot( owner )
{
    self notify( #"hash_c0262dce1172458f" );
    self endon( #"hash_c0262dce1172458f" );
    self endon( #"death" );
    self.firedot = 1;
    ticks = 8;
    thread ztron_vfx::burn();
    
    while ( ticks )
    {
        self dodamage( 250, self.origin, owner, owner, "MOD_FIRE" );
        ticks--;
        wait 0.5;
    }
    
    wait 0.5;
    self.firedot = undefined;
    thread ztron_vfx::stopburn();
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0x8a843eb3, Offset: 0xa56
// Size: 0x78
function fireburn()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( guy.ztron.boss )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( !guy.firedot )
        {
            guy thread firedot( self.owner );
        }
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 1
// Checksum 0xddf47d3f, Offset: 0xad6
// Size: 0x111
function function_353b1c649b9da7b5( origin )
{
    org = utility::spawn_model( "tag_origin", origin );
    org.owner = self;
    org thread ztron_util::function_f7544bfa701db406( self );
    trigger = spawn( "trigger_radius", org.origin, 9, 48, 64 );
    org.trigger = trigger;
    org.trigger.owner = self;
    org.trigger thread fireburn();
    org.trigger thread ztron_util::function_f7544bfa701db406( org );
    playfxontag( utility::getfx( "feet_upgrade_firetrailLP" ), org, "tag_origin" );
    wait 8;
    
    if ( isdefined( org ) )
    {
        stopfxontag( utility::getfx( "feet_upgrade_firetrailLP" ), org, "tag_origin" );
        playfx( utility::getfx( "feet_upgrade_firetrailDone" ), org.origin );
        org delete();
    }
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 1
// Checksum 0xd5ba694, Offset: 0xbef
// Size: 0x4d
function firetrail( duration )
{
    self endon( #"disconnect", #"boosting_done" );
    waittime = duration / 6;
    
    while ( true )
    {
        thread function_353b1c649b9da7b5( self.origin );
        wait waittime;
    }
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0x9e8a3190, Offset: 0xc44
// Size: 0xa3
function function_1b82715a32cd1380()
{
    self.ztron.score.var_59f1f1595961cbe = clampint( self.ztron.score.var_59f1f1595961cbe + 1, 0, ztron_score::getmaxboosts() );
    params = { #count:self.ztron.score.var_59f1f1595961cbe, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_5b0ba7dbe42fc385", params );
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0xd8abea0f, Offset: 0xcef
// Size: 0xa3
function function_744c9d02ea7dbf44()
{
    self.ztron.score.var_59f1f1595961cbe = clampint( self.ztron.score.var_59f1f1595961cbe - 1, 0, ztron_score::getmaxboosts() );
    params = { #count:self.ztron.score.var_59f1f1595961cbe, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_5b0ba7dbe42fc385", params );
}

// Namespace namespace_33e886a9a5b55137
// Params 2
// Checksum 0x46476de2, Offset: 0xd9a
// Size: 0xc8
function function_992dffefa33a9534( boostcount, forced = 0 )
{
    if ( forced )
    {
        self.ztron.score.var_59f1f1595961cbe = boostcount;
    }
    else
    {
        self.ztron.score.var_59f1f1595961cbe = clampint( boostcount, 0, ztron_score::getmaxboosts() );
    }
    
    params = { #count:self.ztron.score.var_59f1f1595961cbe, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_5b0ba7dbe42fc385", params );
}

// Namespace namespace_33e886a9a5b55137
// Params 0
// Checksum 0x1cb309ee, Offset: 0xe6a
// Size: 0x1f
function function_a4ca73e22464e330()
{
    return self.ztron.score.var_59f1f1595961cbe;
}

