// script_3e92f2666b75a897  (hash_3e92f2666b75a897.gscc) (size: 3792 Bytes / 0xed0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x791e1e4c (2032016972)
// size ...... 3792 (0xed0)
// includes .. 4   (offset: 0xe20)
// strings ... 10  (offset: 0xe40)
// dev strs .. 1   (offset: 0xec4)
// exports ... 12  (offset: 0x8c8)
// cseg ...... 0xd4 + 0x7f4 (0x8c8)
// imports ... 30  (offset: 0xaa8)
// animtree1 . 0   (offset: 0xed0)
// animtree2 . 0   (offset: 0xed0)
#using script_3f14905e6bfa4fbb;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;

#namespace melee;

// Namespace melee
// Params 1
// Checksum 0x311c54c8, Offset: 0xf2
// Size: 0x61
function initmeleefunctions( taskid )
{
    self.meleerangesq = 6724;
    self.meleechargedistvsplayer = 100;
    self.meleeactorboundsradius = 32;
    self.acceptablemeleefraction = 0.98;
    self.fnismeleevalid = &ismeleevalid;
    self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
    return anim.success;
}

// Namespace melee
// Params 2
// Checksum 0xcd665f03, Offset: 0x15c
// Size: 0x20
function canmovefrompointtopoint( start, end )
{
    return self maymovefrompointtopoint( start, end, 0, 1 );
}

// Namespace melee
// Params 1
// Checksum 0x6a23a6fd, Offset: 0x185
// Size: 0x2c
function meleedeathhandler( enemy )
{
    self endon( #"melee_finished" );
    self waittill( #"terminate_ai_threads" );
    asm_bb::bb_clearmeleetarget();
}

// Namespace melee
// Params 0
// Checksum 0xedbf3a88, Offset: 0x1b9
// Size: 0x10
function melee_destroy()
{
    self clearbtgoal( 3 );
    self function_a227728f297b8669();
}

// Namespace melee
// Params 1
// Checksum 0x4ec881c0, Offset: 0x1d1
// Size: 0x5d
function getmeleechargerange( target )
{
    if ( isplayer( target ) )
    {
        var_a870a0f8f2ff58dc = self.meleechargedistvsplayer;
    }
    else
    {
        var_a870a0f8f2ff58dc = self.meleechargedist;
    }
    
    if ( !combat::hasammoinclip() )
    {
        reloadmultiplier = self.meleechargedistreloadmultiplier;
        var_a870a0f8f2ff58dc *= reloadmultiplier;
    }
    
    return var_a870a0f8f2ff58dc;
}

// Namespace melee
// Params 1
// Checksum 0x47b6cb54, Offset: 0x237
// Size: 0xd0
function gettargetchargepos( target )
{
    assert( isdefined( target ) );
    targetpos = target.origin;
    metotarget = target.origin - self.origin;
    metotarget = vectornormalize( metotarget );
    targetpos -= metotarget * self.meleeactorboundsradius;
    targetposdropped = getclosestpointonnavmesh( targetpos, self );
    
    if ( abs( targetpos[ 2 ] - targetposdropped[ 2 ] ) > self.maxzdiff )
    {
        return;
    }
    
    traceresults = navtrace( self.origin, targetposdropped, self, 1 );
    fraction = traceresults[ "fraction" ];
    
    if ( fraction < self.acceptablemeleefraction )
    {
        return;
    }
    
    return targetposdropped;
}

// Namespace melee
// Params 0
// Checksum 0xf4e530a9, Offset: 0x310
// Size: 0x5a
function canmeleeduringstealth()
{
    if ( isdefined( self.ent_flag[ "_stealth_enabled" ] ) && self.ent_flag[ "_stealth_enabled" ] )
    {
        if ( isdefined( self.ent_flag[ "_stealth_attack" ] ) && !self.ent_flag[ "_stealth_attack" ] )
        {
            return 0;
        }
    }
    
    return anim.success;
}

// Namespace melee
// Params 1
// Checksum 0x448f3915, Offset: 0x373
// Size: 0xb4, Type: bool
function iseitherofusalreadyinmelee( optionaltargetoverride )
{
    meleetarget = self.enemy;
    
    if ( isdefined( optionaltargetoverride ) )
    {
        meleetarget = optionaltargetoverride;
    }
    
    if ( self.in_melee )
    {
        return true;
    }
    
    if ( meleetarget.in_melee )
    {
        if ( !isdefined( meleetarget.meleepartner ) )
        {
            if ( isplayer( meleetarget ) )
            {
                meleetarget function_a227728f297b8669();
            }
            else
            {
                assert( isdefined( meleetarget.var_a6aa8551fbd7eddd ) || meleetarget.var_56a5b757af5bed42 || meleetarget.var_1acd684935b83642, "<dev string:x24>" );
            }
        }
        
        if ( meleetarget.in_melee )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace melee
// Params 1
// Checksum 0x942486d0, Offset: 0x430
// Size: 0x94, Type: bool
function ismeleerangevalid( target )
{
    assert( isdefined( self.meleemaxzdiff ) );
    
    if ( abs( target.origin[ 2 ] - self.origin[ 2 ] ) > self.meleemaxzdiff )
    {
        return false;
    }
    
    chargedist = getmeleechargerange( target );
    chargedistsq = chargedist * chargedist;
    enemydistancesq = distancesquared( self.origin, target.origin );
    return enemydistancesq <= chargedistsq;
}

// Namespace melee
// Params 2
// Checksum 0xed370db0, Offset: 0x4cd
// Size: 0x55, Type: bool
function ismeleevalid_common( target, var_fbcde6803574d9b4 )
{
    if ( self.dontmelee )
    {
        return false;
    }
    
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( target.dontmelee )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    return true;
}

// Namespace melee
// Params 2
// Checksum 0x4fec18e3, Offset: 0x52b
// Size: 0x39c, Type: bool
function ismeleevalid( target, var_fbcde6803574d9b4 )
{
    if ( !ismeleevalid_common( target, var_fbcde6803574d9b4 ) )
    {
        return false;
    }
    
    if ( var_fbcde6803574d9b4 )
    {
        if ( isdefined( self.a.onback ) || self.currentpose == "prone" )
        {
            return false;
        }
        
        if ( !utility::melee_checktimer( self.unittype, 1 ) )
        {
            return false;
        }
        
        if ( isdefined( self.pathgoalpos ) && self.facemotion && lengthsquared( self.velocity ) > 1 )
        {
            metotarget = target.origin - self.origin;
            distmetotarget = length( metotarget );
            
            if ( distmetotarget > 60 )
            {
                metotarget /= distmetotarget;
                lookaheadpos = self getposonpath( 30 );
                var_4a183ef0098fd68f = vectornormalize( lookaheadpos - self.origin );
                
                if ( vectordot( var_4a183ef0098fd68f, metotarget ) < -0.5 )
                {
                    return false;
                }
            }
        }
    }
    
    if ( isdefined( self.grenade ) && self.frontshieldanglecos == 1 )
    {
        return false;
    }
    
    if ( self.enemy == self.lastfailedmeleechargetarget && gettime() <= self.nextmeleechecktime )
    {
        return false;
    }
    
    if ( target.dontattackme || target.ignoreme || target.dontmeleeme )
    {
        return false;
    }
    
    if ( !isai( target ) && !isplayer( target ) )
    {
        return false;
    }
    
    if ( isdefined( self.meleealwayswin ) && isdefined( target.meleealwayswin ) )
    {
        return false;
    }
    
    if ( isdefined( self.meleealwayswin ) && isdefined( target.magic_bullet_shield ) || isdefined( target.meleealwayswin ) && isdefined( self.magic_bullet_shield ) )
    {
        return false;
    }
    
    var_33c1e4a9127e8142 = 0;
    
    if ( isagent( target ) )
    {
        if ( self.bsoldier )
        {
            var_33c1e4a9127e8142 = 1;
        }
    }
    else if ( !isbot( target ) )
    {
        var_33c1e4a9127e8142 = isai( target );
    }
    
    if ( var_33c1e4a9127e8142 )
    {
        if ( target isinscriptedstate() )
        {
            return false;
        }
        
        if ( target utility::doinglongdeath() || target.delayeddeath )
        {
            return false;
        }
        
        assert( isdefined( self.stairsstate ) );
        assert( isdefined( target.stairsstate ) );
        
        if ( self.stairsstate != "none" || target.stairsstate != "none" )
        {
            return false;
        }
        
        if ( target.unittype != "soldier" && target.unittype != "civilian" && target.unittype != "juggernaut" )
        {
            return false;
        }
    }
    
    if ( !self.meleeignoreplayerstance || !isplayer( target ) )
    {
        if ( isplayer( target ) )
        {
            enemypose = target getstance();
        }
        else
        {
            enemypose = target.currentpose;
        }
        
        if ( enemypose != "stand" && enemypose != "crouch" )
        {
            return false;
        }
    }
    
    if ( isdefined( self.magic_bullet_shield ) && isdefined( target.magic_bullet_shield ) )
    {
        return false;
    }
    
    if ( isdefined( target.grenade ) )
    {
        return false;
    }
    
    if ( isdefined( target.lowcovervolume ) && target.underlowcover )
    {
        return false;
    }
    
    return true;
}

