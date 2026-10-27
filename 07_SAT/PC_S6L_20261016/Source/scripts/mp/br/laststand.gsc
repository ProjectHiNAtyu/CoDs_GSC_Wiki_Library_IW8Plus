// scripts\mp\br\laststand.gsc  (hash_4d06de6580424f59.gscc) (size: 2823 Bytes / 0xb07 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa56d643a (2775409722)
// size ...... 2823 (0xb07)
// includes .. 7   (offset: 0xa6b)
// strings ... 7   (offset: 0xaa3)
// dev strs .. 0   (offset: 0xb07)
// exports ... 10  (offset: 0x60f)
// cseg ...... 0xd8 + 0x537 (0x60f)
// imports ... 24  (offset: 0x79f)
// animtree1 . 0   (offset: 0xb07)
// animtree2 . 0   (offset: 0xb07)
#using script_be7da0439d09064;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;

#namespace laststand_br;

// Namespace laststand_br
// Params 0
// Checksum 0xd325c23f, Offset: 0xf6
// Size: 0x95
function init()
{
    callback::add( #"hash_9741c7ee14b21924", &function_b45827dc259331b );
    callback::add( #"player_laststand_exit", &laststandexit );
    callback::add( #"player_laststand_revived", &onplayerrevived );
    callback::add( #"hash_d4e35c0ab858b283", &laststandsecondwind );
    callback::add( #"player_laststand_set_revive_progress", &function_557baf1122339fa4 );
    callback::add( #"player_laststand_bleedout", &function_3b3de6615e4b0caf );
    callback::add( #"player_laststand_death", &function_7287ce7611d8022c );
}

// Namespace laststand_br
// Params 1
// Checksum 0xdfec8c6c, Offset: 0x193
// Size: 0xea
function function_b45827dc259331b( params )
{
    if ( !self.gulag )
    {
        utility::callsharedfunc( #"gametype", #"hash_57aad19264731fb6" );
        
        if ( !level.var_4b1d806e34262a54 )
        {
            foreach ( teammate in level.teamdata[ self.team ][ "alivePlayers" ] )
            {
                if ( !isdefined( teammate ) )
                {
                    continue;
                }
                
                if ( teammate != self )
                {
                    teammate thread hud_message::showsplash( "br_teammate_down", undefined, self );
                    teammate thread br_ftue_popups::function_e05ce093ad06ba05( self );
                }
            }
        }
    }
}

// Namespace laststand_br
// Params 1
// Checksum 0x865fc35d, Offset: 0x285
// Size: 0x8a
function laststandexit( params )
{
    if ( params.revived )
    {
        var_46a1b10e3dccc319 = "crouch";
        
        if ( self.var_37064d2e7bfab77c )
        {
            var_46a1b10e3dccc319 = "prone";
        }
        
        self.var_37064d2e7bfab77c = undefined;
        var_5495dd3c0596b514 = self setstance( var_46a1b10e3dccc319 );
        
        if ( !var_5495dd3c0596b514 )
        {
            triedcrouch = var_46a1b10e3dccc319 == "crouch";
            var_5495dd3c0596b514 = self setstance( triedcrouch ? "prone" : "crouch" );
        }
    }
}

// Namespace laststand_br
// Params 1
// Checksum 0x56bc9889, Offset: 0x317
// Size: 0x13c
function onplayerrevived( params )
{
    if ( params.selfrevive )
    {
        br_analytics::branalytics_selfrevive( self );
        playsoundatpos( self.origin + ( 0, 0, 15 ), #"eqp_revive_use_end" );
    }
    
    if ( isdefined( level.forcegivesuper ) && isdefined( self.var_5ad7275235a06b0 ) )
    {
        self [[ level.forcegivesuper ]]( self.var_5ad7275235a06b0 );
        self.var_5ad7275235a06b0 = undefined;
    }
    
    if ( !self.gulag )
    {
        if ( !level.var_4b1d806e34262a54 )
        {
            foreach ( teammate in level.teamdata[ self.team ][ "alivePlayers" ] )
            {
                if ( !isdefined( teammate ) )
                {
                    continue;
                }
                
                if ( teammate != self )
                {
                    teammate thread hud_message::showsplash( "br_teammate_revived", undefined, self );
                }
            }
        }
    }
}

// Namespace laststand_br
// Params 1
// Checksum 0x6739fc4c, Offset: 0x45b
// Size: 0x8e
function laststandsecondwind( params )
{
    br_analytics::branalytics_secondwind( self, params.var_27d4a3941580b2e4, params.evictim, params.meansofdeath, params.weaponname, params.laststandmeansofdeath, params.laststandweaponname, params.var_8bdbcd3d7da5ab82, params.var_52b8bcac39b24683, params.bbledout, params.var_b717015fd4296ea6 );
    thread hud_message::showsplash( "br_second_wind" );
}

// Namespace laststand_br
// Params 1
// Checksum 0xc7ed52f3, Offset: 0x4f1
// Size: 0x3a
function function_557baf1122339fa4( params )
{
    if ( level.var_894cf9c132c87505 )
    {
        laststand::updatesquadmemberlaststandreviveprogress( self, params.reviver ?? self, params.progress );
    }
}

// Namespace laststand_br
// Params 0
// Checksum 0xf72a0d87, Offset: 0x533
// Size: 0xa6
function playerdeathcleanup()
{
    if ( !level.gameended )
    {
        self.deathsdoorsfx = 0;
        damage_effects::function_e8cba6f10a4635e9();
        self notify( #"deaths_door_exit" );
        
        if ( isdefined( level.gamemodebundle.var_feb4b2aad25fbaf3 ) && soundexists( level.gamemodebundle.var_feb4b2aad25fbaf3 ) )
        {
            self playlocalsound( level.gamemodebundle.var_feb4b2aad25fbaf3 );
        }
        
        self stoplocalsound( "mvmt_heartbeat_plr_laststand" );
        
        if ( isdefined( self.heartbeatalias ) )
        {
            self stoplocalsound( self.heartbeatalias );
        }
        
        self enableplayerbreathsystem( 1 );
    }
}

// Namespace laststand_br
// Params 1
// Checksum 0x724edf0, Offset: 0x5e1
// Size: 0x13
function function_3b3de6615e4b0caf( params )
{
    playerdeathcleanup();
}

// Namespace laststand_br
// Params 1
// Checksum 0x62c10a47, Offset: 0x5fc
// Size: 0x13
function function_7287ce7611d8022c( params )
{
    playerdeathcleanup();
}

