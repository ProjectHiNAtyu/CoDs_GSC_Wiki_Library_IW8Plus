// script_30bd9dea1af8d9b7  (hash_30bd9dea1af8d9b7.gscc) (size: 3889 Bytes / 0xf31 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb20832c2 (2986881730)
// size ...... 3889 (0xf31)
// includes .. 4   (offset: 0xd45)
// strings ... 31  (offset: 0xd65)
// dev strs .. 2   (offset: 0xf19)
// exports ... 7   (offset: 0x835)
// cseg ...... 0x263 + 0x5d2 (0x835)
// imports ... 35  (offset: 0x94d)
// animtree1 . 0   (offset: 0xf31)
// animtree2 . 0   (offset: 0xf31)
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\bots\bots_util;
#using scripts\mp\supers;

#namespace namespace_45d03d6739e7bccb;

// Namespace namespace_45d03d6739e7bccb
// Params 1
// Checksum 0x564c033b, Offset: 0x281
// Size: 0x41
function function_934203db7b68a874( taskid )
{
    assert( !isdefined( self.var_446d67bb90b3bf7f ) );
    self.var_446d67bb90b3bf7f = anim.running;
    thread function_75015e6e1ce6a38a();
    return anim.success;
}

// Namespace namespace_45d03d6739e7bccb
// Params 1
// Checksum 0xa59a0a30, Offset: 0x2cb
// Size: 0x4b
function function_3ad4ae6441e38599( taskid )
{
    self notify( #"hash_e10fd8f4b2738a0b" );
    
    if ( self.var_4e0d6a21d5078d85 )
    {
        supers_mp::clearsuper();
    }
    
    self botsetflag( "disable_movement", 0 );
    self.var_4e0d6a21d5078d85 = 0;
    self.var_446d67bb90b3bf7f = undefined;
}

// Namespace namespace_45d03d6739e7bccb
// Params 1
// Checksum 0x359dc82a, Offset: 0x31e
// Size: 0x15
function usefieldupgrade( taskid )
{
    return self.var_446d67bb90b3bf7f;
}

// Namespace namespace_45d03d6739e7bccb
// Params 0, eflags: 0x4
// Checksum 0xceec1b38, Offset: 0x33c
// Size: 0x5a
function private function_75015e6e1ce6a38a()
{
    self endon( #"hash_e10fd8f4b2738a0b" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    result = function_9b1bde6011487977();
    assert( isdefined( result ) );
    self.var_446d67bb90b3bf7f = result ?? anim.failure;
}

// Namespace namespace_45d03d6739e7bccb
// Params 0, eflags: 0x4
// Checksum 0x6a775bce, Offset: 0x39e
// Size: 0x33a
function private function_9b1bde6011487977()
{
    self botsetflag( "disable_movement", 1 );
    self.var_4e0d6a21d5078d85 = 1;
    
    while ( self isgestureplaying() )
    {
        wait 0.1;
    }
    
    self enableoffhandweapons();
    self enableoffhandspecialweapons();
    
    if ( supers_mp::getcurrentsuperref() == "super_trauma_kit" )
    {
        self botpressbutton( "special", 5.5 );
        return anim.success;
    }
    
    bots_util_mp::function_26196082e7a55bbd( self gettagorigin( "j_mainroot" ), 0.75 );
    self botpressbutton( "special", 0.5 );
    
    /#
        logstring( "<dev string:x24>" + self.name + "<dev string:x3a>" );
    #/
    
    thrownbox = function_71fe10fe81617e65();
    self botsetflag( "disable_movement", 0 );
    
    if ( !isdefined( thrownbox ) )
    {
        var_9d6803aa8408d215 = "[BT] Use field upgrade failed: ";
        var_9d6803aa8408d215 += self isswitchingweapon() ? ", IsSwitchingWeapon" : "";
        var_9d6803aa8408d215 += self isreloading() ? ", IsReloading" : "";
        var_9d6803aa8408d215 += self ismantling() ? ", IsMantling" : "";
        var_9d6803aa8408d215 += self isthrowinggrenade() ? ", IsThrowingGrenade" : "";
        var_9d6803aa8408d215 += self israisingweapon() ? ", IsRaisingWeapon" : "";
        var_9d6803aa8408d215 += self ismeleeing() ? ", IsMeleeing" : "";
        var_9d6803aa8408d215 += self isparachuting() ? ", IsParachuting" : "";
        var_9d6803aa8408d215 += self isskydiving() ? ", IsSkydiving" : "";
        var_9d6803aa8408d215 += self issprintsliding() ? ", IsSprintSliding" : "";
        var_9d6803aa8408d215 += self isjumping() ? ", IsJumping" : "";
        var_9d6803aa8408d215 += self isswimming() ? ", IsSwimming" : "";
        var_9d6803aa8408d215 += self isswimunderwater() ? ", IsSwimUnderwater" : "";
        var_9d6803aa8408d215 += self.inlaststand ? ", IsInLastStand" : "";
        var_9d6803aa8408d215 += ", bot stance:" + self getstance() + ", bot origin: " + self.origin + "\n";
        logstring( "No supply box thrown" + var_9d6803aa8408d215 );
        return anim.failure;
    }
    
    targetpos = bots_util_mp::function_1882f18076610076( thrownbox.origin );
    namespace_ef4547f85724edd1::setscriptgoal( targetpos, 32 );
    timelimit = 10000;
    starttime = gettime();
    
    while ( gettime() - starttime < timelimit )
    {
        result = utility::waittill_any_in_array_or_timeout( [ "goal", "bad_path" ], 5 );
        
        if ( result == "goal" )
        {
            bots_util_mp::function_26196082e7a55bbd( targetpos, 0.75 );
            wait 0.5;
            self botpressbutton( "use", 0.5 );
            return anim.success;
        }
        
        if ( result != "timeout" )
        {
            return anim.failure;
        }
    }
    
    return anim.failure;
}

// Namespace namespace_45d03d6739e7bccb
// Params 0, eflags: 0x4
// Checksum 0x836b50da, Offset: 0x6e1
// Size: 0x153
function private function_71fe10fe81617e65()
{
    timelimit = 5000;
    starttime = gettime();
    
    while ( gettime() - starttime < timelimit )
    {
        grenadearray = getentarray( "grenade", #classname );
        
        foreach ( item in grenadearray )
        {
            isvaliditem = item.superref == "super_ammo_drop" || item.superref == "super_armor_drop" || item.superref == "super_utility_drop";
            
            if ( !isvaliditem )
            {
                continue;
            }
            
            if ( item.owner != self )
            {
                continue;
            }
            
            if ( item.usedcount != 0 )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, item.origin ) > 10000 )
            {
                continue;
            }
            
            return item;
        }
        
        wait 0.5;
    }
}

