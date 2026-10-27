// scripts\mp\gametypes\wm_utility.gsc  (hash_66200b7bf3fe7a49.gscc) (size: 6560 Bytes / 0x19a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3fddeb55 (1071508309)
// size ...... 6560 (0x19a0)
// includes .. 6   (offset: 0x17a8)
// strings ... 29  (offset: 0x17d8)
// dev strs .. 5   (offset: 0x1964)
// exports ... 17  (offset: 0xf14)
// cseg ...... 0x265 + 0xcaf (0xf14)
// imports ... 51  (offset: 0x11bc)
// animtree1 . 0   (offset: 0x19a0)
// animtree2 . 0   (offset: 0x19a0)
#using scripts\anim\utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;

#namespace wm_utility;

// Namespace wm_utility
// Params 2
// Checksum 0x2ddb6589, Offset: 0x283
// Size: 0x6a
function function_6a8add6912adc43f( gestureweaponname, outtime )
{
    if ( !self.var_90610028cd67d0f1 )
    {
        self.var_90610028cd67d0f1 = 1;
        self.var_3b1afe57248bceec = gestureweaponname;
        self.var_da6fef6dec42c01b = outtime;
        
        if ( gestureweaponname == "nothing_here" )
        {
            thread inventory_utility::givegunlessweapon();
            return;
        }
        
        thread utility::function_72b6372d2d8c997( self.var_3b1afe57248bceec, 1 );
    }
}

// Namespace wm_utility
// Params 0
// Checksum 0xb177a9d8, Offset: 0x2f5
// Size: 0x6c
function function_977af8dcbb181e1d()
{
    self.var_90610028cd67d0f1 = 0;
    
    if ( isdefined( self.var_3b1afe57248bceec ) )
    {
        if ( self.var_3b1afe57248bceec == "nothing_here" )
        {
            thread inventory_utility::takegunlessweapon();
            return;
        }
        
        outtime = 0;
        
        if ( isdefined( self.var_da6fef6dec42c01b ) )
        {
            outtime = self.var_da6fef6dec42c01b;
        }
        
        self stopgestureviewmodel( self.var_3b1afe57248bceec, outtime, 0 );
    }
}

// Namespace wm_utility
// Params 1
// Checksum 0x5e584bba, Offset: 0x369
// Size: 0x45
function function_5485d4fdf955437e( delaytime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( delaytime ) || delaytime <= 0 )
    {
        function_977af8dcbb181e1d();
        return;
    }
    
    wait delaytime;
    function_977af8dcbb181e1d();
}

// Namespace wm_utility
// Params 1
// Checksum 0x4b6ea336, Offset: 0x3b6
// Size: 0xf9
function function_cdfabc0db5ed0575( groupname )
{
    if ( !isdefined( level.var_20d3d5482a745c81 ) )
    {
        level.var_20d3d5482a745c81 = [];
        level.var_20d3d5482a745c81[ "repair_tank" ] = [ 1, 1 ];
        level.var_20d3d5482a745c81[ "hacking_1" ] = [ 2, 2 ];
        level.var_20d3d5482a745c81[ "hacking_2" ] = [ 3, 2 ];
        level.var_20d3d5482a745c81[ "recovering_1" ] = [ 2, 3 ];
        level.var_20d3d5482a745c81[ "recovering_2" ] = [ 3, 3 ];
        level.var_20d3d5482a745c81[ "build" ] = [ 0, 4 ];
        level.var_20d3d5482a745c81[ "destroy" ] = [ 0, 5 ];
    }
    
    return level.var_20d3d5482a745c81[ groupname ];
}

// Namespace wm_utility
// Params 2
// Checksum 0xa897607a, Offset: 0x4b8
// Size: 0x21
function function_f07e90ed96504935( player, groupname )
{
    thread function_50f27526144a0ebb( player, groupname, 1 );
}

// Namespace wm_utility
// Params 2
// Checksum 0x2cf03c2e, Offset: 0x4e1
// Size: 0x20
function function_116938e7dc005626( player, groupname )
{
    thread function_50f27526144a0ebb( player, groupname, 0 );
}

// Namespace wm_utility
// Params 3
// Checksum 0x5bf2a10a, Offset: 0x509
// Size: 0x123
function function_50f27526144a0ebb( player, groupname, var_e8a78bc4edada0c6 )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"hash_1fa97b5596819146" );
    self notify( #"hash_5a389cd9e5e3edef" );
    self endon( #"hash_5a389cd9e5e3edef" );
    group = function_cdfabc0db5ed0575( groupname );
    iconindex = group[ 0 ];
    stringindex = group[ 1 ];
    
    if ( isdefined( self.ownerteam ) )
    {
        player setclientomnvar( "ui_wm_objective_friendly_owner", player.team == self.ownerteam );
    }
    
    player setclientomnvar( "ui_wm_interacting_icon", iconindex );
    player setclientomnvar( "ui_wm_interacting_string", stringindex );
    progress = undefined;
    
    while ( true )
    {
        if ( var_e8a78bc4edada0c6 )
        {
            progress = self.curprogress / self.usetime;
        }
        else
        {
            progress = self.var_6d52475bcda53d28;
        }
        
        if ( isdefined( progress ) )
        {
            player setclientomnvar( "ui_wm_interacting_progress", progress );
        }
        
        waitframe();
    }
}

// Namespace wm_utility
// Params 1
// Checksum 0xa5490d4e, Offset: 0x634
// Size: 0x25
function function_6789bf4a2324b515( player )
{
    self notify( #"hash_1fa97b5596819146" );
    player setclientomnvar( "ui_wm_interacting_progress", 0 );
}

// Namespace wm_utility
// Params 6
// Checksum 0x4d3bdd6a, Offset: 0x661
// Size: 0xde
function function_9f7271c73ff4e07a( zone, eventname, var_13743fc5b60270f5, delaytime, context, customtrigger )
{
    if ( !( isdefined( zone ) && isdefined( level.scriptevents[ zone ] ) ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    event = spawnstruct();
    event.zone = zone;
    event.eventname = eventname;
    event.ontriggerevent = var_13743fc5b60270f5;
    event.delaytime = delaytime;
    event.context = context;
    event.customtrigger = customtrigger;
    level.scriptevents[ zone ][ level.scriptevents[ zone ].size ] = event;
}

// Namespace wm_utility
// Params 1
// Checksum 0x3a4ade1d, Offset: 0x747
// Size: 0x64
function function_c2a6e3ba60f1b487( objectivestr )
{
    level endon( #"game_ended" );
    level endon( objectivestr + "_objective_end" );
    
    if ( isdefined( self.customtrigger ) )
    {
        self [[ self.customtrigger ]]();
    }
    else
    {
        wait self.delaytime;
    }
    
    if ( isdefined( self.ontriggerevent ) )
    {
        self [[ self.ontriggerevent ]]();
    }
}

// Namespace wm_utility
// Params 0
// Checksum 0x2cf24cac, Offset: 0x7b3
// Size: 0x125
function function_a659df6027f39035()
{
    level endon( #"game_ended" );
    level waittill( #"matchstarttimer_done" );
    
    foreach ( objectivestr in level.objectiveorder )
    {
        flags::gameflagwait( objectivestr + "_objective_start" );
        
        if ( isdefined( level.scriptevents[ objectivestr ] ) )
        {
            foreach ( event in level.scriptevents[ objectivestr ] )
            {
                event thread function_c2a6e3ba60f1b487( objectivestr );
            }
        }
    }
}

// Namespace wm_utility
// Params 1
// Checksum 0xc6c5bda7, Offset: 0x8e0
// Size: 0x21c
function function_744019b1b08359c6( animstruct )
{
    level.brspawnplayersending = 1;
    level notify( #"hash_bcd7948d1417bc21" );
    
    foreach ( player in level.players )
    {
        player painvisionoff();
        player notify( #"ending_cinematic" );
        player function_e19ccf4da1a61ba7( animstruct.origin );
        player utility::hidehudenable();
        player setcinematicmotionoverride( "disabled" );
        player setclientomnvar( "ui_hide_hud", 1 );
        
        if ( isdefined( player.sessionstate ) )
        {
            if ( player.sessionstate == "intermission" )
            {
                player player::updatesessionstate( "spectator" );
            }
            
            if ( player.sessionstate == "spectator" )
            {
                player setspectatedefaults( animstruct.cam.origin, animstruct.cam.angles );
                player spawn( animstruct.cam.origin, animstruct.cam.angles );
                continue;
            }
            
            player setorigin( animstruct.origin );
        }
    }
    
    foreach ( player in level.players )
    {
        player playerlinkto( animstruct.cam, "tag_player" );
        player playerhide();
    }
}

// Namespace wm_utility
// Params 0
// Checksum 0xad954f69, Offset: 0xb04
// Size: 0x80
function function_4afa4860425f25d1()
{
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_wm_objective_show_match_status", 1 );
    }
}

// Namespace wm_utility
// Params 6
// Checksum 0xd8b05c18, Offset: 0xb8c
// Size: 0x165
function function_b4958bedd3689804( showhint, origin, team, displayrange, fov, hintstring )
{
    if ( !isdefined( self.hinttrigger ) )
    {
        self.hinttrigger = spawn( "script_model", origin );
    }
    
    trigger = self.hinttrigger;
    
    if ( showhint )
    {
        trigger makeusable();
        trigger sethintdisplayrange( displayrange );
        trigger sethintdisplayfov( fov );
        trigger setuserange( displayrange );
        trigger setusefov( fov );
        trigger sethintonobstruction( "show" );
        trigger setcursorhint( "HINT_NOBUTTON" );
        trigger sethintstring( hintstring );
        trigger setusepriority( -4 );
        
        foreach ( player in level.players )
        {
            if ( player.pers[ "team" ] != team )
            {
                trigger disableplayeruse( player );
                continue;
            }
            
            trigger enableplayeruse( player );
        }
        
        return;
    }
    
    trigger makeunusable();
}

// Namespace wm_utility
// Params 1
// Checksum 0x292aedc2, Offset: 0xcf9
// Size: 0xff
function function_649e3f7aca9ba137( switchimmediate )
{
    self endon( #"death_or_disconnect" );
    weaponname = "ks_use_crate_mp_wm";
    
    if ( isdefined( self.gunnlessweapon ) )
    {
        return;
    }
    
    gunless = makeweapon( weaponname );
    inventory_utility::_giveweapon( gunless, undefined, undefined, 1 );
    self.gunnlessweapon = gunless;
    val::reset_all( "gunless" );
    val::set( "gunless", "script_weapon_switch", 1 );
    println( self.name + "<dev string:x35>" );
    
    if ( !isdefined( switchimmediate ) )
    {
        switchimmediate = 0;
    }
    
    success = inventory_utility::domonitoredweaponswitch( gunless, switchimmediate );
    
    if ( !success )
    {
        inventory_utility::_takeweapon( gunless );
        inventory_utility::forcevalidweapon();
    }
    
    val::set( "gunless", "script_weapon_switch", 0 );
    println( self.name + "<dev string:x5d>" );
    
    if ( !success )
    {
        self.gunnlessweapon = undefined;
    }
}

// Namespace wm_utility
// Params 0
// Checksum 0xab48c752, Offset: 0xe00
// Size: 0x114
function function_1ceee90c081efe45()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
    {
        return;
    }
    
    if ( utility::ent_flag_exist( "swapLoadout_pending" ) && utility::ent_flag( "swapLoadout_pending" ) )
    {
        utility::ent_flag_wait( "swapLoadout_complete" );
    }
    
    val::reset_all( "gunless" );
    val::set( "gunless", "script_weapon_switch", 1 );
    println( self.name + "<dev string:x85>" );
    
    while ( self hasweapon( self.gunnlessweapon ) )
    {
        if ( !inventory_utility::iscurrentweapon( self.gunnlessweapon ) )
        {
            inventory_utility::abortmonitoredweaponswitch( self.gunnlessweapon );
        }
        else
        {
            inventory_utility::_takeweapon( self.gunnlessweapon );
            inventory_utility::forcevalidweapon();
        }
        
        waitframe();
    }
    
    self.gunnlessweapon = undefined;
    val::set( "gunless", "script_weapon_switch", 0 );
    println( self.name + "<dev string:xad>" );
}

