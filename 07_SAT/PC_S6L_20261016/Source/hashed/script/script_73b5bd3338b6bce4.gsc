// script_73b5bd3338b6bce4  (hash_73b5bd3338b6bce4.gscc) (size: 3184 Bytes / 0xc70 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe03ba86 (4261657222)
// size ...... 3184 (0xc70)
// includes .. 5   (offset: 0xbbc)
// strings ... 9   (offset: 0xbe4)
// dev strs .. 0   (offset: 0xc70)
// exports ... 12  (offset: 0x6e8)
// cseg ...... 0xf5 + 0x5f3 (0x6e8)
// imports ... 26  (offset: 0x8c8)
// animtree1 . 0   (offset: 0xc70)
// animtree2 . 0   (offset: 0xc70)
#using scripts\asm\asm;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\points;

#namespace ob_ally_guild_bot_revive;

// Namespace ob_ally_guild_bot_revive
// Params 2
// Checksum 0xb842da22, Offset: 0x113
// Size: 0x3b
function function_9768d85234d3f859( taskid, var_40829265aee4392d )
{
    target = find_revive_target();
    
    if ( target )
    {
        self.revivetarget = target;
        return 5;
    }
    
    return 0;
}

// Namespace ob_ally_guild_bot_revive
// Params 1
// Checksum 0x7e0d594e, Offset: 0x157
// Size: 0x3e
function function_65d0d5d96f5d1f70( taskid )
{
    target = self.currenttarget;
    
    if ( function_9d4c98c8e1cd476c( target ) )
    {
        thread revive_thread( target );
    }
    
    return anim.failure;
}

// Namespace ob_ally_guild_bot_revive
// Params 0
// Checksum 0xa89fd174, Offset: 0x19e
// Size: 0x48
function setup()
{
    animindex = asm::asm_lookupanimfromalias( "animscripted", "revive_other" );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    self.var_4cd26d897a2b876a = getanimlength( xanim ) * 1000;
}

// Namespace ob_ally_guild_bot_revive
// Params 0, eflags: 0x4
// Checksum 0x2d76699, Offset: 0x1ee
// Size: 0x15d
function private find_revive_target()
{
    self.owner endon( #"death_or_disconnect" );
    player = self.owner;
    playerteam = player.team;
    playersquadindex = player.sessionsquadid;
    squadmembers = level.squaddata[ playerteam ][ playersquadindex ].players;
    range_squared = squared( self.distances[ "revive_range" ] );
    
    foreach ( member in squadmembers )
    {
        if ( distancesquared( self.origin, member.origin ) > range_squared )
        {
            continue;
        }
        
        if ( member.inlaststand && ( !member.beingrevived || member.beingrevived && member.reviver == self ) )
        {
            return member;
        }
    }
}

// Namespace ob_ally_guild_bot_revive
// Params 1, eflags: 0x4
// Checksum 0x1d2d4993, Offset: 0x354
// Size: 0x7b
function private wait_face_target( target )
{
    targetangles = vectortoangles( target geteye() - self geteye() );
    targetangles = ( function_63a2ef74ebcc6413( targetangles[ 0 ] ), targetangles[ 1 ], targetangles[ 2 ] );
    anglediff = absangleclamp180( self.angles[ 1 ] - targetangles[ 1 ] );
    
    if ( anglediff > 10 )
    {
        self motionwarp( self.origin, targetangles, 500 );
        wait 0.5;
    }
}

// Namespace ob_ally_guild_bot_revive
// Params 1, eflags: 0xc
// Checksum 0x629413f5, Offset: 0x3d7
// Size: 0xab
function private revive_thread( target )
{
    self notify( #"hash_82742c2482b9ae34" );
    self endon( #"hash_82742c2482b9ae34" );
    self endon( #"death" );
    target endon( #"death" );
    success = enter_revive( target );
    
    if ( success )
    {
        target waittill( #"laststand_revived" );
        score_event = target == self.owner ? self.var_62eb9a798fdb4b6c : self.revive_teammate_score_event;
        self.owner points::doscoreevent( score_event );
    }
    
    exit_revive();
}

// Namespace ob_ally_guild_bot_revive
// Params 1, eflags: 0x4
// Checksum 0xb3677b94, Offset: 0x48a
// Size: 0xb7, Type: bool
function private enter_revive( target )
{
    self.is_processing_revive = 1;
    val::set( "ally_guild_bot_revive", "script_pushable", 0 );
    val::set( "ally_guild_bot_revive", "script_pushable_by_ai", 0 );
    val::set( "ally_guild_bot_revive", "toggle_remote_revive", 1 );
    wait_face_target( target );
    
    if ( !target.laststandreviveent || target.beingrevived )
    {
        return false;
    }
    
    self.is_reviving_teammate = 1;
    target.laststandreviveent notify( #"trigger", self );
    thread play_scripted_anim( "revive_other" );
    self setscriptablepartstate( "revive", "on" );
    return true;
}

// Namespace ob_ally_guild_bot_revive
// Params 1
// Checksum 0x8de9fa07, Offset: 0x54a
// Size: 0xbd
function play_scripted_anim( aliasname )
{
    self notify( #"hash_7e8ec55d4089bb1e" );
    self endon( #"hash_7e8ec55d4089bb1e" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"scripted_anim_cleared" );
    self.is_script_animation = 1;
    asm_mp::asm_setanimscripted();
    animindex = asm::asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm::asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    self aisetanim( "animscripted", animindex );
    wait animlength;
    self notify( #"revive_anim_finished" );
    function_4d732b0c87bec23e();
}

// Namespace ob_ally_guild_bot_revive
// Params 0
// Checksum 0xfd35ae58, Offset: 0x60f
// Size: 0x1f
function function_4d732b0c87bec23e()
{
    utility::animscripted_clear();
    self.is_script_animation = 0;
    self notify( #"scripted_anim_cleared" );
}

// Namespace ob_ally_guild_bot_revive
// Params 0, eflags: 0x4
// Checksum 0x392bf08b, Offset: 0x636
// Size: 0x5d
function private exit_revive()
{
    function_4d732b0c87bec23e();
    val::reset( "ally_guild_bot_revive" );
    self.is_reviving_teammate = undefined;
    self.is_processing_revive = undefined;
    self.ignoreall = 0;
    self.currenttarget = undefined;
    self.var_37fde8ee38ad094a = undefined;
    self.revivetarget = undefined;
    self notify( #"ally_guild_bot_revive_finished" );
}

// Namespace ob_ally_guild_bot_revive
// Params 1
// Checksum 0x1edd124d, Offset: 0x69b
// Size: 0x4c, Type: bool
function function_9d4c98c8e1cd476c( target )
{
    if ( !self.reachedtarget )
    {
        return false;
    }
    
    if ( self.is_processing_revive )
    {
        return false;
    }
    
    if ( !target.laststandreviveent )
    {
        return false;
    }
    
    if ( target.beingrevived )
    {
        return false;
    }
    
    return true;
}

