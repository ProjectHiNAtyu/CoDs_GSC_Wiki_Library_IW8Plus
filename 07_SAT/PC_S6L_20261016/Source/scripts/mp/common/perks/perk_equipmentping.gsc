// scripts\mp\common\perks\perk_equipmentping.gsc  (hash_727f5065e5780977.gscc) (size: 2607 Bytes / 0xa2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc3a5c51 (3694812241)
// size ...... 2607 (0xa2f)
// includes .. 6   (offset: 0x95f)
// strings ... 13  (offset: 0x98f)
// dev strs .. 0   (offset: 0xa2f)
// exports ... 6   (offset: 0x5e3)
// cseg ...... 0x16f + 0x474 (0x5e3)
// imports ... 23  (offset: 0x6d3)
// animtree1 . 0   (offset: 0xa2f)
// animtree2 . 0   (offset: 0xa2f)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\objidpoolmanager;

#namespace perk_equipmentping;

// Namespace perk_equipmentping
// Params 0
// Checksum 0xed502c88, Offset: 0x18d
// Size: 0x1b
function init()
{
    level._effect[ "perk_equipmentping" ] = loadfxasset( "vfx_core_equip_snap_gren_pulse" );
}

// Namespace perk_equipmentping
// Params 3
// Checksum 0x140718ed, Offset: 0x1b0
// Size: 0x2b3
function runequipmentping( ignore, lastpingtime, useoutline )
{
    if ( !level.equipmentpingactive )
    {
        return;
    }
    
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    owner = self.owner;
    
    if ( !isdefined( lastpingtime ) )
    {
        lastpingtime = 0;
    }
    
    self.equipping_lastpingtime = lastpingtime;
    
    if ( isdefined( owner.perks[ "specialty_equipment_ping" ] ) )
    {
        while ( true )
        {
            shouldping = 0;
            
            if ( gettime() >= self.equipping_lastpingtime + 3000 )
            {
                pingplayers = utility::playersincylinder( self.origin, 300 );
                
                foreach ( player in pingplayers )
                {
                    if ( !player::isreallyalive( player ) )
                    {
                        continue;
                    }
                    
                    if ( !owner player_utility::isenemy( player ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( player.perks[ "specialty_covert_ops" ] ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( player.outlined ) )
                    {
                        continue;
                    }
                    
                    contentignore = arraycombine( level.players, [ self ] );
                    
                    if ( isdefined( ignore ) )
                    {
                        contentignore[ contentignore.size ] = ignore;
                    }
                    
                    originoffset = self.origin + anglestoup( self.angles ) * 10;
                    
                    if ( trace::ray_trace_passed( originoffset, player gettagorigin( "j_head" ), contentignore ) )
                    {
                        if ( !isdefined( player.perks[ "specialty_gpsjammer" ] ) )
                        {
                            owner thread markasrelaysource( player );
                        }
                        
                        shouldping = 1;
                    }
                }
                
                if ( shouldping )
                {
                    if ( !self.eyespyalerted )
                    {
                        self.eyespyalerted = 1;
                    }
                    
                    if ( useoutline )
                    {
                        playsoundatpos( self.origin, "iw9_snapshot_expl" );
                        markents = [ self, player ];
                        playfx( level._effect[ "perk_equipmentping" ], self.origin );
                        thread outline::function_67e3226e79560595( markents, self.owner, self.owner, 1, "ddos_target_non_player", "perk_superior" );
                    }
                    else
                    {
                        triggerportableradarping( self.origin, owner, 400, 800 );
                    }
                    
                    wait 3;
                }
            }
            
            waitframe();
        }
    }
}

// Namespace perk_equipmentping
// Params 2
// Checksum 0x9feb4fe5, Offset: 0x46b
// Size: 0xa0
function markdangerzoneonminimap( target, equipment )
{
    target endon( #"death_or_disconnect" );
    
    if ( !isdefined( target ) || !player::isreallyalive( target ) )
    {
        return;
    }
    
    thread markasrelaysource( target );
    objid = objidpoolmanager::requestobjectiveid( 10 );
    
    if ( objid == -1 )
    {
        return;
    }
    
    objidpoolmanager::objective_add_objective( objid, "active", equipment.origin, "cb_compassping_eqp_ping", "icon_large" );
    objidpoolmanager::objective_playermask_single( objid, self );
    target thread watchfordeath( objid );
    wait 3;
    objidpoolmanager::returnobjectiveid( objid );
}

// Namespace perk_equipmentping
// Params 1
// Checksum 0xd2f1bf61, Offset: 0x513
// Size: 0x22
function watchfordeath( objid )
{
    self waittill( #"death_or_disconnect" );
    objidpoolmanager::returnobjectiveid( objid );
}

// Namespace perk_equipmentping
// Params 1
// Checksum 0x10910795, Offset: 0x53d
// Size: 0xa6
function markasrelaysource( otherplayer )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    idx = otherplayer getentitynumber();
    
    if ( !isdefined( self.relaysource ) )
    {
        self.relaysource = [];
    }
    else if ( isdefined( self.relaysource[ idx ] ) )
    {
        self notify( #"hash_dc1a915074276564" );
        self endon( #"hash_dc1a915074276564" );
    }
    
    self.relaysource[ idx ] = 1;
    otherplayer utility::waittill_any_timeout( 10, "death_or_disconnect" );
    self.relaysource[ idx ] = 0;
}

