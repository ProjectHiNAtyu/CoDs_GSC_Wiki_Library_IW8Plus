// script_f06363d2daed312  (hash_0f06363d2daed312.gscc) (size: 6040 Bytes / 0x1798 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ec06c06 (1052797958)
// size ...... 6040 (0x1798)
// includes .. 7   (offset: 0x15b0)
// strings ... 29  (offset: 0x15e8)
// dev strs .. 0   (offset: 0x1798)
// exports ... 13  (offset: 0x1030)
// cseg ...... 0x2f6 + 0xd3a (0x1030)
// imports ... 27  (offset: 0x1238)
// animtree1 . 0   (offset: 0x1798)
// animtree2 . 0   (offset: 0x1798)
#using scripts\common\callbacks;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\rank;

#namespace momentum_meter;

// Namespace momentum_meter
// Params 0
// Checksum 0xe826f6b2, Offset: 0x314
// Size: 0x253
function function_5b8137092c54af1d()
{
    level.var_f46fa8341cc4687e = getmatchrulesdata( "ctdmData", "comboMomentumBaseActionPoints" );
    level.var_2c1f017a17d954cb = getmatchrulesdata( "ctdmData", "comboMomentumPointCap" );
    level.var_ffe8d21589e700e = getmatchrulesdata( "ctdmData", "comboMomentumDecayBaseValue" );
    level.momentumlevel[ 0 ] = 0;
    level.momentumlevel[ 1 ] = getmatchrulesdata( "ctdmData", "momentumLevel_1" );
    level.momentumlevel[ 2 ] = getmatchrulesdata( "ctdmData", "momentumLevel_2" );
    level.momentumlevel[ 3 ] = getmatchrulesdata( "ctdmData", "momentumLevel_3" );
    level.momentumlevel[ 4 ] = getmatchrulesdata( "ctdmData", "momentumLevel_4" );
    level.momentummultiplier[ 0 ] = getmatchrulesdata( "ctdmData", "momentumMultiplier_0" );
    level.momentummultiplier[ 1 ] = getmatchrulesdata( "ctdmData", "momentumMultiplier_1" );
    level.momentummultiplier[ 2 ] = getmatchrulesdata( "ctdmData", "momentumMultiplier_2" );
    level.momentummultiplier[ 3 ] = getmatchrulesdata( "ctdmData", "momentumMultiplier_3" );
    level.momentummultiplier[ 4 ] = getmatchrulesdata( "ctdmData", "momentumMultiplier_3" );
    level.momentumdecaymultiplier[ 0 ] = getmatchrulesdata( "ctdmData", "momentumDecayMultiplier_0" );
    level.momentumdecaymultiplier[ 1 ] = getmatchrulesdata( "ctdmData", "momentumDecayMultiplier_1" );
    level.momentumdecaymultiplier[ 2 ] = getmatchrulesdata( "ctdmData", "momentumDecayMultiplier_2" );
    level.momentumdecaymultiplier[ 3 ] = getmatchrulesdata( "ctdmData", "momentumDecayMultiplier_3" );
    
    foreach ( team in level.teamnamelist )
    {
        level.var_8dfdf1dccdcaaf4a[ team ] = 0;
        level.var_8e72823d58a68ef2[ team ] = 0;
    }
    
    level callback::add( #"hash_fa7263897b3164e", &scoreeventcallback );
}

// Namespace momentum_meter
// Params 1
// Checksum 0x8330a74a, Offset: 0x56f
// Size: 0xf1
function initializemomentum( var_64c262124aec9388 )
{
    level.var_64c262124aec9388 = var_64c262124aec9388;
    function_5b8137092c54af1d();
    level.var_81ade82ecdb5240c = [];
    level.momentumvalue = [];
    
    foreach ( team in level.teamnamelist )
    {
        if ( level.teamnamelist.size == 0 )
        {
            continue;
        }
        
        if ( level.var_64c262124aec9388 )
        {
            level.var_81ade82ecdb5240c[ team ] = 0;
        }
        
        level.momentumvalue[ team ] = 0;
        level.var_8dfdf1dccdcaaf4a[ team ] = 0;
    }
    
    thread momentumdecay();
}

// Namespace momentum_meter
// Params 1
// Checksum 0x96523a4b, Offset: 0x668
// Size: 0x60
function function_2029e2e407fd5396( team )
{
    if ( level.var_64c262124aec9388 )
    {
        if ( level.var_81ade82ecdb5240c[ team ] )
        {
            return level.momentummultiplier[ 1 ];
        }
        
        return level.momentummultiplier[ 0 ];
    }
    
    return level.momentummultiplier[ function_a2245f565a23fa2d( level.momentumvalue[ team ] ) ];
}

// Namespace momentum_meter
// Params 0
// Checksum 0xb7929787, Offset: 0x6d0
// Size: 0x1b3
function momentumdecay()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            var_e9cb1aa09034cf44 = 0;
            currentmomentum = level.momentumvalue[ team ];
            momentumlevel = function_a2245f565a23fa2d( currentmomentum );
            
            if ( currentmomentum > level.var_8e72823d58a68ef2[ team ] + level.momentumlevel[ 1 ] )
            {
                if ( level.var_64c262124aec9388 )
                {
                    level.momentumvalue[ team ] = 0;
                    level.var_81ade82ecdb5240c[ team ] = 1;
                    thread poweruptimer( team );
                }
                else
                {
                    level.var_8e72823d58a68ef2[ team ] += level.momentumlevel[ 1 ];
                }
                
                var_e9cb1aa09034cf44 = 1;
                level notify( #"hash_41e4b78cd142cd2a" );
            }
            
            if ( level.momentumvalue[ team ] > level.var_8e72823d58a68ef2[ team ] && !level.var_8dfdf1dccdcaaf4a[ team ] )
            {
                level.momentumvalue[ team ] = currentmomentum - level.var_ffe8d21589e700e * level.momentumdecaymultiplier[ momentumlevel ];
                var_e9cb1aa09034cf44 = 1;
            }
            
            if ( var_e9cb1aa09034cf44 )
            {
                function_fac3369fe008c427( team );
            }
        }
        
        hostmigration::waitlongdurationwithgameendtimeupdate( 1 );
    }
}

// Namespace momentum_meter
// Params 1
// Checksum 0x84b5880e, Offset: 0x88b
// Size: 0x255
function poweruptimer( team )
{
    self notify( #"hash_e3b07d98436b4123" );
    self endon( #"hash_e3b07d98436b4123" );
    level endon( #"game_ended" );
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player hud_message::function_78fedf6f526825f4( "ctdm_heat_zone_captured", level.gametypebundle.var_e662dd7f27d462eb );
        player playsoundtoplayer( "uin_ctdm_heatbuff_gain", player );
    }
    
    foreach ( player in level.teamdata[ team_utility::getotherteam( team ) ][ "players" ] )
    {
        player hud_message::function_78fedf6f526825f4( "ctdm_heat_zone_captured_enemy", level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    level dialog::statusdialog( "hs_secured", team );
    level dialog::statusdialog( "hs_captured", team_utility::getotherteam( team ) );
    thread powerupradar( team );
    level notify( #"uav_update" );
    wait 30;
    level notify( #"hash_371edd98ebc19689" );
    thread powerdownradar( team );
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player playsoundtoplayer( "uin_ctdm_heatbuff_lose", player );
    }
    
    function_fac3369fe008c427( team, 1 );
    level.var_81ade82ecdb5240c[ team ] = 0;
}

// Namespace momentum_meter
// Params 1
// Checksum 0x8faadff8, Offset: 0xae8
// Size: 0x1b5
function powerupradar( team )
{
    self notify( #"hash_fc529e227b6b43fb" );
    self endon( #"hash_fc529e227b6b43fb" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_371edd98ebc19689" );
    
    while ( true )
    {
        level waittill( #"uav_update" );
        
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            if ( uav::function_c6b46bde3b7bc0a1( player.team ) > getuavstrengthmin() )
            {
                player.skipuavupdate = 1;
                player.radarstrength = getuavstrengthlevelneutral();
                player.isradarblocked = 0;
                player.hasradar = 1;
                player.radarshowenemydirection = 0;
                player.radarmode = "normal_radar";
                var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
                
                if ( isdefined( var_ec86cf09b79859c3 ) )
                {
                    level [[ var_ec86cf09b79859c3 ]]( [ player ] );
                }
                
                continue;
            }
            
            player.skipuavupdate = 0;
            radardata = uav::function_ce7678b7924e8588( player.team );
            uav::function_1d490f49c4dc99a9( player, radardata );
        }
    }
}

// Namespace momentum_meter
// Params 1
// Checksum 0x6ba80d8a, Offset: 0xca5
// Size: 0x9f
function powerdownradar( team )
{
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player.skipuavupdate = 0;
        player.hasradar = 0;
    }
}

// Namespace momentum_meter
// Params 2
// Checksum 0x708006e, Offset: 0xd4c
// Size: 0x109
function function_fac3369fe008c427( team, var_a17308375c7b47f9 )
{
    level endon( #"game_ended" );
    currentmomentum = level.momentumvalue[ team ];
    momentummultiplier = var_a17308375c7b47f9 ?? function_2029e2e407fd5396( team );
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player setclientomnvar( "ui_momentumMeterValue", currentmomentum );
    }
    
    setomnvar( "ui_AlliesMomentumMeterMultiplier", var_a17308375c7b47f9 ?? function_2029e2e407fd5396( "allies" ) );
    setomnvar( "ui_AxisMomentumMeterMultiplier", var_a17308375c7b47f9 ?? function_2029e2e407fd5396( "axis" ) );
}

// Namespace momentum_meter
// Params 1
// Checksum 0xf3ee6196, Offset: 0xe5d
// Size: 0x54
function function_a2245f565a23fa2d( currentmomentum )
{
    for ( i = 1; i < level.momentumlevel.size ; i++ )
    {
        if ( currentmomentum <= level.momentumlevel[ i ] )
        {
            return ( i - 1 );
        }
    }
    
    return level.momentumlevel.size - 1;
}

// Namespace momentum_meter
// Params 2
// Checksum 0xdc3d41a6, Offset: 0xeba
// Size: 0x96
function addmomentum( event, momentummultiplier )
{
    level.momentumvalue[ self.team ] += level.var_f46fa8341cc4687e * momentummultiplier;
    
    if ( level.momentumvalue[ self.team ] > level.var_2c1f017a17d954cb )
    {
        level.momentumvalue[ self.team ] = level.var_2c1f017a17d954cb;
    }
    
    function_fac3369fe008c427( self.team );
}

// Namespace momentum_meter
// Params 1
// Checksum 0x925378e4, Offset: 0xf58
// Size: 0x83
function function_e35270bfe4821380( points )
{
    level.momentumvalue[ self.team ] += points;
    
    if ( level.momentumvalue[ self.team ] > level.var_2c1f017a17d954cb )
    {
        level.momentumvalue[ self.team ] = level.var_2c1f017a17d954cb;
    }
    
    function_fac3369fe008c427( self.team );
}

// Namespace momentum_meter
// Params 1
// Checksum 0x2e848cd6, Offset: 0xfe3
// Size: 0x4d
function scoreeventcallback( params )
{
    event = params.event;
    var_4c8d4a1c6c67bc78 = rank::function_abe49cc2fd43e371( event );
    
    if ( isdefined( var_4c8d4a1c6c67bc78 ) && var_4c8d4a1c6c67bc78 != 0 )
    {
        thread addmomentum( event, var_4c8d4a1c6c67bc78 );
    }
}

