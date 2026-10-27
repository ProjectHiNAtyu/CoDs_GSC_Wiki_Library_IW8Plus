// scripts\mp\maps\mp_sat_sm_onsen\mp_sat_sm_onsen.gsc  (hash_1e63d959d0730fb1.gscc) (size: 2475 Bytes / 0x9ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe40b90b9 (3825963193)
// size ...... 2475 (0x9ab)
// includes .. 5   (offset: 0x89f)
// strings ... 18  (offset: 0x8c7)
// dev strs .. 0   (offset: 0x9ab)
// exports ... 5   (offset: 0x5a7)
// cseg ...... 0x178 + 0x42f (0x5a7)
// imports ... 19  (offset: 0x66f)
// animtree1 . 0   (offset: 0x9ab)
// animtree2 . 0   (offset: 0x9ab)
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_onsen\gen\mp_sat_sm_onsen_art;
#using scripts\mp\maps\mp_sat_sm_onsen\mp_sat_sm_onsen_fx;
#using scripts\mp\maps\mp_sat_sm_onsen\mp_sat_sm_onsen_lighting;

#namespace mp_sat_sm_onsen;

// Namespace mp_sat_sm_onsen
// Params 0
// Checksum 0xc9a14265, Offset: 0x196
// Size: 0xd8
function main()
{
    mp_sat_sm_onsen_art::main();
    mp_sat_sm_onsen_fx::main();
    mp_sat_sm_onsen_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_sm_onsen" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_caa27c0a57e26d5c = 30;
    thread init_smoke_trigger();
}

// Namespace mp_sat_sm_onsen
// Params 0
// Checksum 0x4303d17a, Offset: 0x276
// Size: 0x128
function init_smoke_trigger()
{
    level endon( #"game_ended" );
    level waittill( #"scriptables_ready" );
    level.smoke_triggers = getentarray( "smoke_trigger", "targetname" );
    level.smoke_blocksight = getent( "blocksight", "targetname" );
    
    if ( isdefined( level.smoke_blocksight ) )
    {
        level.smoke_blocksight.var_aa82c7f64e626133 = 1;
    }
    
    level.smoke_outer_blocksight = getent( "outer_blocksight", "targetname" );
    
    if ( isdefined( level.smoke_outer_blocksight ) )
    {
        level.smoke_outer_blocksight.var_aa82c7f64e626133 = 1;
    }
    
    foreach ( smoke_trigger in level.smoke_triggers )
    {
        smoke_trigger thread smoke_watchtriggerenter();
        smoke_trigger thread smoke_watchtriggerexit();
    }
}

// Namespace mp_sat_sm_onsen
// Params 0
// Checksum 0xbe5f6d02, Offset: 0x3a6
// Size: 0xf1
function smoke_watchtriggerenter()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            self.playersintrigger[ player getentitynumber() ] = player;
            player.var_87181884c4526682 = 1;
            
            if ( !isdefined( player.nosight_capsule ) )
            {
                if ( isdefined( level.smoke_blocksight ) )
                {
                    player.nosight_capsule = spawn( "script_model", player.origin );
                    player.nosight_capsule clonebrushmodeltoscriptmodel( level.smoke_blocksight );
                    player.nosight_capsule linkto( player );
                    player.nosight_capsule.var_aa82c7f64e626133 = 1;
                    player.nosight_capsule.var_639a06f1517179e2 = 1;
                }
            }
        }
    }
}

// Namespace mp_sat_sm_onsen
// Params 0
// Checksum 0xff885fb9, Offset: 0x49f
// Size: 0x108
function smoke_watchtriggerexit()
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( id, player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player istouching( self ) )
            {
                continue;
            }
            
            if ( isdefined( player.nosight_capsule ) )
            {
                player.nosight_capsule delete();
                player.nosight_capsule = undefined;
            }
            
            self.playersintrigger[ id ] = undefined;
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player.var_87181884c4526682 = undefined;
        }
        
        waitframe();
    }
}

