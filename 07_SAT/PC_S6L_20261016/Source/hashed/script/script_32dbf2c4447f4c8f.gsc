// script_32dbf2c4447f4c8f  (hash_32dbf2c4447f4c8f.gscc) (size: 4597 Bytes / 0x11f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39373553 (959919443)
// size ...... 4597 (0x11f5)
// includes .. 8   (offset: 0x1131)
// strings ... 8   (offset: 0x1171)
// dev strs .. 2   (offset: 0x11d9)
// exports ... 9   (offset: 0xb6d)
// cseg ...... 0xf7 + 0xa76 (0xb6d)
// imports ... 37  (offset: 0xcd5)
// animtree1 . 0   (offset: 0x11f5)
// animtree2 . 0   (offset: 0x11f5)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;

#namespace specialty_markequipment;

// Namespace specialty_markequipment
// Params 0, eflags: 0x1
// Checksum 0x6360345c, Offset: 0x115
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_markequipment
// Params 1
// Checksum 0x949e151b, Offset: 0x135
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_markequipment", &setmarkequipment, &unsetmarkequipment, [] );
    }
}

// Namespace specialty_markequipment
// Params 0, eflags: 0x4
// Checksum 0x52eb0319, Offset: 0x177
// Size: 0x14e
function private setmarkequipment()
{
    self.var_1d222e257350015f = self.var_9842326056fd7207.var_1d222e257350015f ?? 999;
    self.var_5e4f335fd40f2b70 = self.var_9842326056fd7207.var_5e4f335fd40f2b70 ?? 8 ?? getdvarint( @"perk_mark_equipment_duration" );
    self.var_e68f7662e5a0af98 = self.var_9842326056fd7207.var_e68f7662e5a0af98 ?? 1000000;
    self.var_f3f1714fd025b4f3 = self.var_9842326056fd7207.var_f3f1714fd025b4f3 ?? getdvarint( @"perk_see_equipment_distance" ) ?? 1000;
    self.var_aca00f135984de59 = self.var_9842326056fd7207.var_aca00f135984de59 ?? getdvarint( @"perk_see_killstreak_distance" ) ?? 5000;
    self.var_879cb83edc05207d = self.var_9842326056fd7207.var_879cb83edc05207d ?? getdvarint( @"perk_see_air_killstreak_distance" ) ?? 5000;
    self.var_e142a70849450b9f = self.var_9842326056fd7207.var_e142a70849450b9f ?? "iw8_mp_perk_tactical_recon_marked";
    
    if ( !level.teambased )
    {
        return;
    }
    
    self enabletargetmarks();
    thread markequipment_monitorlook();
}

// Namespace specialty_markequipment
// Params 0, eflags: 0x4
// Checksum 0x1cdfb52d, Offset: 0x2cd
// Size: 0xc2
function private unsetmarkequipment()
{
    if ( !level.teambased )
    {
        return;
    }
    
    if ( isdefined( self.markequipmentstate ) )
    {
        foreach ( ent in self.markequipmentstate.markedents )
        {
            if ( isdefined( ent ) )
            {
                unmarkent( ent );
            }
        }
    }
    
    self.markequipmentstate = undefined;
    self disabletargetmarks();
    self notify( #"hash_4754e733ad1413f8" );
}

// Namespace specialty_markequipment
// Params 0
// Checksum 0x6c5d0977, Offset: 0x397
// Size: 0x147
function markequipment_monitorlook()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_4754e733ad1413f8" );
    flags::gameflagwait( "prematch_done" );
    
    if ( !isdefined( self.markequipmentstate ) )
    {
        self.markequipmentstate = spawnstruct();
        self.markequipmentstate.markingtime = 0;
        self.markequipmentstate.markingent = undefined;
        self.markequipmentstate.markedents = [];
        self.markequipmentstate.markedentindex = 0;
        self.markequipmentstate.pastmarkedents = [];
        self.markequipmentstate.pastmarkedentindex = 0;
    }
    
    while ( true )
    {
        self waittill( #"marks_target_changed", ent );
        startmarking = isdefined( ent ) && !isdefined( self.markequipmentstate.markingent );
        self.markequipmentstate.markingent = ent;
        self.markequipmentstate.markingtime = 0;
        
        if ( startmarking )
        {
            thread markequipment_updatestate();
        }
    }
}

// Namespace specialty_markequipment
// Params 0
// Checksum 0x39edcae1, Offset: 0x4e6
// Size: 0x51a
function markequipment_updatestate()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_4754e733ad1413f8" );
    lasttime = gettime();
    maxdist = 0;
    
    if ( self entityhasmark( #"air_killstreak", self.markequipmentstate.markingent ) )
    {
        maxdist = getdvarint( @"perk_see_air_killstreak_distance" );
    }
    else if ( self entityhasmark( #"killstreak", self.markequipmentstate.markingent ) )
    {
        maxdist = self.var_aca00f135984de59;
    }
    else if ( self entityhasmark( #"equipment", self.markequipmentstate.markingent ) )
    {
        maxdist = self.var_f3f1714fd025b4f3;
    }
    else
    {
        assert( 0, "<dev string:x24>" );
    }
    
    maxdistsqrd = maxdist * maxdist;
    
    while ( isdefined( self.markequipmentstate.markingent ) && !self.ishacking )
    {
        if ( self entitymarkfilteredin( self.markequipmentstate.markingent ) )
        {
            break;
        }
        
        if ( self.vehicle == self.markequipmentstate.markingent )
        {
            break;
        }
        
        if ( vehicle_occupancy::function_3080323254ba6900( self ) && !self isinvehicleleanout() )
        {
            break;
        }
        
        if ( distancesquared( self.origin, self.markequipmentstate.markingent.origin ) > maxdistsqrd )
        {
            break;
        }
        
        currenttime = gettime();
        deltatime = currenttime - lasttime;
        self.markequipmentstate.markingtime += deltatime;
        
        if ( !arraycontains( self.markequipmentstate.markedents, self.markequipmentstate.markingent ) )
        {
            if ( player::isplayerads() )
            {
                markindex = self.markequipmentstate.markedentindex;
                ent = self.markequipmentstate.markedents[ markindex ];
                
                if ( isdefined( ent ) )
                {
                    ent filterinplayermarks( undefined );
                    perkfunctions::outlinehelper_updateentityoutline( ent );
                }
                
                if ( level.teambased )
                {
                    self.markequipmentstate.markingent filterinplayermarks( self.team );
                }
                else
                {
                    self.markequipmentstate.markingent filterinplayermarks( self );
                }
                
                perkfunctions::outlinehelper_updateentityoutline( self.markequipmentstate.markingent );
                self playlocalsound( self.var_e142a70849450b9f );
                
                if ( level.teambased && vehicle_compass::instance_is_registered( self.markequipmentstate.markingent ) )
                {
                    self.markequipmentstate.markingent.teammarkedfor = self.team;
                    players = [];
                    
                    if ( utility::issharedfuncdefined( #"game", #"getteamdata" ) )
                    {
                        players = [[ utility::getsharedfunc( #"game", #"getteamdata" ) ]]( self.markequipmentstate.markingent.teammarkedfor, "players" );
                    }
                    else
                    {
                        assert( "<dev string:x80>" );
                    }
                    
                    vehicle_compass::function_f43158fa5698deb9( self.markequipmentstate.markingent, players );
                }
                
                self.markequipmentstate.markedents[ markindex ] = self.markequipmentstate.markingent;
                self.markequipmentstate.markedentindex = ( markindex + 1 ) % self.var_1d222e257350015f;
                
                if ( !arraycontains( self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent ) )
                {
                    killstreaks::givescoreformarktarget( 1 );
                    self.markequipmentstate.pastmarkedents[ self.markequipmentstate.pastmarkedentindex ] = self.markequipmentstate.markingent;
                    self.markequipmentstate.pastmarkedentindex++;
                }
                else
                {
                    killstreaks::givescoreformarktarget( 0 );
                }
                
                thread unmarkafterduration( self.markequipmentstate.markingent );
                break;
            }
        }
        
        lasttime = currenttime;
        waitframe();
    }
    
    if ( !self.ishacking )
    {
        self setclientomnvar( "ui_securing", 0 );
        self setclientomnvar( "ui_securing_progress", 0 );
    }
    
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markingtime = 0;
}

// Namespace specialty_markequipment
// Params 1
// Checksum 0x1c72cbc1, Offset: 0xa08
// Size: 0x6b
function unmarkafterduration( markedent )
{
    level endon( #"game_ended" );
    self endon( #"hash_4754e733ad1413f8" );
    self endon( "unmarkEnt_" + self getentitynumber() );
    markedent endon( #"death" );
    timeoutduration = self.var_5e4f335fd40f2b70;
    utility::waittill_any_timeout_no_endon_death( timeoutduration, "disconnect" );
    unmarkent( markedent );
}

// Namespace specialty_markequipment
// Params 1
// Checksum 0x36c8a7b9, Offset: 0xa7b
// Size: 0xf2
function unmarkent( markedent )
{
    markedent filterinplayermarks( undefined );
    
    if ( isdefined( markedent.teammarkedfor ) )
    {
        if ( level.teambased && vehicle_compass::instance_is_registered( markedent ) )
        {
            if ( utility::issharedfuncdefined( #"game", #"getteamdata" ) )
            {
                players = [[ utility::getsharedfunc( #"game", #"getteamdata" ) ]]( markedent.teammarkedfor, "players" );
            }
            else
            {
                assertmsg( "<dev string:x80>" );
            }
            
            vehicle_compass::function_f43158fa5698deb9( markedent, players );
        }
        
        markedent.teammarkedfor = undefined;
    }
    
    if ( isdefined( self ) )
    {
        self.markequipmentstate.markedents = arrayremove( self.markequipmentstate.markedents, markedent );
        markedent notify( "unmarkEnt_" + self getentitynumber() );
    }
}

