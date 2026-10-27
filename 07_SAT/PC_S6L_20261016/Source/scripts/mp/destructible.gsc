// scripts\mp\destructible.gsc  (hash_2dcd44765b157d94.gscc) (size: 17828 Bytes / 0x45a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcaa73f62 (3399958370)
// size ...... 17828 (0x45a4)
// includes .. 11  (offset: 0x4260)
// strings ... 52  (offset: 0x42b8)
// dev strs .. 0   (offset: 0x4594)
// exports ... 39  (offset: 0x2d9c)
// cseg ...... 0x432 + 0x296a (0x2d9c)
// imports ... 116 (offset: 0x33b4)
// animtree1 . 1   (offset: 0x4594)
// animtree2 . 0   (offset: 0x45a4)
#using scripts\common\anim;
#using scripts\common\rockable_vehicles;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\gameobjects;
#using scripts\mp\rank;

#namespace destructible;

// Namespace destructible
// Params 0
// Checksum 0x30d55060, Offset: 0x450
// Size: 0x2
function init()
{
    
}

// Namespace destructible
// Params 0
// Checksum 0x9278e72d, Offset: 0x45a
// Size: 0x2
function script_model_anims()
{
    
}

#using_animtree( "script_model" );

// Namespace destructible
// Params 3
// Checksum 0xe3c52094, Offset: 0x464
// Size: 0xed
function create_player_rig( player, animname, rig_model )
{
    if ( !isdefined( player ) || isdefined( player.player_rig ) )
    {
        return;
    }
    
    player.animname = animname;
    
    if ( !isdefined( rig_model ) )
    {
        rig_model = "viewhands_base_iw8";
    }
    
    player.player_rig = spawn( "script_model", player.origin );
    player.player_rig setmodel( rig_model );
    player.player_rig hide();
    player.player_rig.animname = animname;
    player.player_rig useanimtree( #animtree );
    player playerlinktodelta( player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0 );
    player watch_remove_rig();
    remove_player_rig( player );
}

// Namespace destructible
// Params 1
// Checksum 0x598f865, Offset: 0x559
// Size: 0x93
function remove_player_rig( player )
{
    if ( !( isdefined( player ) && isdefined( player.player_rig ) ) )
    {
        return;
    }
    
    player unlink();
    droppos = player getdroptofloorposition( player.origin );
    
    if ( isdefined( droppos ) )
    {
        player setorigin( droppos );
    }
    else
    {
        player setorigin( player.origin + ( 0, 0, 100 ) );
    }
    
    player.player_rig delete();
    player.player_rig = undefined;
}

// Namespace destructible
// Params 1
// Checksum 0xfa724be6, Offset: 0x5f4
// Size: 0x1d
function watch_remove_rig( struct )
{
    utility::waittill_any( "remove_rig", "death_or_disconnect" );
}

// Namespace destructible
// Params 2
// Checksum 0xa0714aae, Offset: 0x619
// Size: 0x100
function add_destructible_array( value, type )
{
    array = getentarray( value, type );
    
    foreach ( ent in array )
    {
        destructible = spawnstruct();
        add_destructible( destructible, ent );
        destructible assigninteractteam( level.teamnamelist );
        
        if ( !isdefined( level.destructibles[ value ] ) )
        {
            level.destructibles[ value ] = [];
        }
        
        level.destructibles[ value ][ level.destructibles[ value ].size ] = destructible;
        destructible process_action( "init" );
    }
}

// Namespace destructible
// Params 2
// Checksum 0x1eecd1e7, Offset: 0x721
// Size: 0x120
function add_destructible( struct, ent )
{
    if ( !isdefined( struct.ents ) )
    {
        struct.ents = [];
    }
    
    struct read_properties( ent );
    struct read_actions( ent );
    struct.ents[ struct.ents.size ] = ent;
    ent.parent = struct;
    
    if ( isdefined( ent.target ) )
    {
        targets = getentarray( ent.target, #targetname );
        
        if ( isdefined( targets ) && targets.size > 0 )
        {
            foreach ( target in targets )
            {
                add_destructible( struct, target );
            }
        }
    }
}

// Namespace destructible
// Params 1
// Checksum 0xe095708e, Offset: 0x849
// Size: 0x1c9
function read_properties( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    switch ( ent.classname )
    {
        case #"hash_5e80cefd309127e7":
            self.use_trigger = ent;
            break;
        case #"hash_34386070076b3ec1":
            label = ent.script_label;
            
            if ( isdefined( label ) )
            {
                switch ( label )
                {
                    case #"hash_bab519a8c9a664ee":
                        if ( !isdefined( self.useobjects ) )
                        {
                            self.useobjects = [];
                        }
                        
                        self.useobjects[ "front" ] = setup_bomb_object( ent.origin );
                        self.useobjects[ "front" ].scenenodekey = "front";
                        break;
                    case #"hash_e1339489d1059713":
                        if ( !isdefined( self.scenenodes ) )
                        {
                            self.scenenodes = [];
                        }
                        
                        self.scenenodes[ "front" ] = ent;
                        break;
                    case #"hash_5ca8db6dafc678d0":
                        if ( !isdefined( self.useobjects ) )
                        {
                            self.useobjects = [];
                        }
                        
                        self.useobjects[ "back" ] = setup_bomb_object( ent.origin );
                        self.useobjects[ "back" ].scenenodekey = "back";
                        break;
                    case #"hash_383a7c211337491f":
                        if ( !isdefined( self.scenenodes ) )
                        {
                            self.scenenodes = [];
                        }
                        
                        self.scenenodes[ "back" ] = ent;
                        break;
                }
            }
            
            break;
        case #"hash_efad986c2d96044e":
            self.scriptable = ent;
            break;
    }
}

// Namespace destructible
// Params 1
// Checksum 0x4f93b029, Offset: 0xa1a
// Size: 0x149
function read_actions( ent )
{
    if ( !isdefined( ent.script_noteworthy ) )
    {
        return;
    }
    
    types = strtok( ent.script_noteworthy, "," );
    
    foreach ( type in types )
    {
        actions = strtok( type, "|" );
        
        if ( !isdefined( actions ) )
        {
            return;
        }
        
        if ( actions.size < 2 )
        {
            return;
        }
        
        type = actions[ 0 ];
        
        if ( !isdefined( ent.actions ) )
        {
            ent.actions = [];
        }
        
        if ( !isdefined( ent.actions[ type ] ) )
        {
            ent.actions[ type ] = [];
        }
        
        for ( index = 1; index < actions.size ; index++ )
        {
            ent.actions[ type ][ ent.actions[ type ].size ] = actions[ index ];
        }
    }
}

// Namespace destructible
// Params 2
// Checksum 0x3a3b258b, Offset: 0xb6b
// Size: 0x2d
function waittime_process_action( type, time )
{
    level endon( #"game_ended" );
    wait time;
    process_action( type );
}

// Namespace destructible
// Params 1
// Checksum 0x31785d79, Offset: 0xba0
// Size: 0x27
function waitmsg_process_action( waitmsg )
{
    level endon( #"game_ended" );
    self waittill( waitmsg );
    process_action( waitmsg );
}

// Namespace destructible
// Params 1
// Checksum 0x45aa7f60, Offset: 0xbcf
// Size: 0x134
function process_action( type )
{
    if ( !isdefined( self.ents ) )
    {
        return;
    }
    
    foreach ( ent in self.ents )
    {
        if ( isdefined( ent.actions ) && isdefined( ent.actions[ type ] ) )
        {
            foreach ( action in ent.actions[ type ] )
            {
                ent actionmap( action );
            }
        }
    }
    
    self.state = type;
}

// Namespace destructible
// Params 1
// Checksum 0xc5f8d9ad, Offset: 0xd0b
// Size: 0x159
function actionmap( action )
{
    switch ( action )
    {
        case #"hash_ca51c18a00a0a89c":
            self show();
            break;
        case #"hash_7ebb454a971d80d":
            self hide();
            break;
        case #"hash_b669df4fb84dddd4":
            self solid();
            break;
        case #"hash_814a3d48452ddccd":
            self notsolid();
            break;
        case #"hash_47ef848af9047e3d":
            self disconnectpaths();
            break;
        case #"hash_491ccd849f5f0b23":
            self connectpaths();
            break;
        case #"hash_9fc8c71433fa319d":
            explosionorigin = self.origin;
            rot = self.angles;
            explosioneffect = spawnfx( level._effect[ "breach_explode" ], explosionorigin, anglestoforward( rot ) * -1, ( 0, 0, 1 ) );
            triggerfx( explosioneffect );
            physicsexplosionsphere( explosionorigin, 200, 100, 3 );
            playrumbleonposition( "grenade_rumble", explosionorigin );
            earthquake( 0.5, 1, explosionorigin, 1500 );
            self.parent.plantedbomb setscriptablepartstate( "bomb", "destroy" );
            break;
    }
}

// Namespace destructible
// Params 1
// Checksum 0x21315999, Offset: 0xe6c
// Size: 0x81
function setup_bomb_object( position )
{
    useobject = gameobjects::createhintobject( position, "HINT_BUTTON", "hud_icon_c4_plant", &"mp/breach", undefined, undefined, undefined, 800, 120, 72, 120 );
    
    if ( !isdefined( level.breachusetriggers ) )
    {
        level.breachusetriggers = [];
    }
    
    level.breachusetriggers[ level.breachusetriggers.size ] = useobject;
    self.defused = 0;
    thread usetriggerthink( useobject );
    return useobject;
}

// Namespace destructible
// Params 2
// Checksum 0x75d57f61, Offset: 0xef6
// Size: 0x3c3
function bomb_planted_think( scenenodekey, player )
{
    plantedteam = player.team;
    self.defused = 0;
    
    if ( !isdefined( self.breachindex ) )
    {
        if ( !isdefined( level.breachindex ) )
        {
            level.breachindex = 0;
        }
        else
        {
            level.breachindex++;
        }
        
        self.breachindex = level.breachindex;
    }
    
    bomb_fuse_think( plantedteam );
    
    if ( !self.defused )
    {
        process_action( "destroyed" );
        explosionorigin = self.useobjects[ scenenodekey ].origin;
        
        if ( isdefined( self.scriptable ) )
        {
            if ( scenenodekey == "front" )
            {
                self.scriptable setscriptablepartstate( "base", "destroyFront" );
            }
            else
            {
                self.scriptable setscriptablepartstate( "base", "destroyBack" );
            }
        }
        else
        {
            rot = self.useobjects[ scenenodekey ].angles;
            explosioneffect = spawnfx( level._effect[ "breach_explode" ], explosionorigin, anglestoforward( rot ) * -1, ( 0, 0, 1 ) );
            triggerfx( explosioneffect );
            self.plantedbomb setscriptablepartstate( "bomb", "destroy" );
        }
        
        physicsexplosionsphere( explosionorigin, 200, 100, 3 );
        playrumbleonposition( "grenade_rumble", explosionorigin );
        earthquake( 0.5, 1, explosionorigin, 1500 );
        
        foreach ( entry in self.useobjects )
        {
            entry delete();
            level.breachusetriggers = arrayremove( level.breachusetriggers, entry );
        }
        
        wait 0.1;
        
        if ( isdefined( player ) )
        {
            self.plantedbomb radiusdamage( self.plantedbomb.origin, 300, 120, 10, player, "MOD_EXPLOSIVE", "bomb_site_mp" );
        }
        else
        {
            self.plantedbomb radiusdamage( self.plantedbomb.origin, 300, 120, 10, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );
        }
        
        if ( isdefined( level.hostages ) )
        {
            thread playhostagehelp( self.plantedbomb.origin );
        }
    }
    
    self.plantedbomb delete();
    self.plantedbomb = undefined;
    self.plantedkey = undefined;
    setomnvar( "ui_ingame_timer_" + self.breachindex, 0 );
    setomnvar( "ui_ingame_timer_ent_" + self.breachindex, undefined );
    
    if ( self.defused )
    {
        foreach ( entry in self.useobjects )
        {
            entry sethintstring( &"mp/breach" );
        }
        
        assigninteractteam( level.teamnamelist );
        process_action( "init" );
    }
}

// Namespace destructible
// Params 1
// Checksum 0x76502cd, Offset: 0x12c1
// Size: 0x46
function playhostagehelp( origin )
{
    wait 1;
    
    if ( distance2d( level.hostages[ 0 ].origin, origin ) < 500 )
    {
        level.hostages[ 0 ] playsound( "dx_mpb_us3_hvt_up" );
    }
}

// Namespace destructible
// Params 1
// Checksum 0x10c9a2fc, Offset: 0x130f
// Size: 0x22a
function bomb_fuse_think( team )
{
    self endon( #"defused" );
    
    foreach ( entry in self.useobjects )
    {
        entry sethintstring( &"mp/breach_defuse" );
    }
    
    self.timerobject = spawn( "script_model", self.plantedbomb.origin );
    self.timerobject makeusable();
    assigninteractteam( team_utility::getenemyteams( team ) );
    currenttime = gettime();
    bombendtime = int( currenttime + 5000 );
    setomnvar( "ui_ingame_timer_" + self.breachindex, bombendtime );
    setomnvar( "ui_ingame_timer_ent_" + self.breachindex, self.timerobject );
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    
    while ( !self.defused && var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 < 1500 )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                self.plantedbomb playsound( "breach_warning_beep_05" );
            }
            else if ( var_f4f3f0356fef8102 < 500 )
            {
                self.plantedbomb playsound( "breach_warning_beep_04" );
            }
            else if ( var_f4f3f0356fef8102 < 1500 )
            {
                self.plantedbomb playsound( "breach_warning_beep_03" );
            }
            else
            {
                self.plantedbomb playsound( "breach_warning_beep_02" );
            }
            
            wait 0.25;
        }
        else if ( var_f4f3f0356fef8102 < 3500 )
        {
            self.plantedbomb playsound( "breach_warning_beep_02" );
            wait 0.5;
        }
        else
        {
            self.plantedbomb playsound( "breach_warning_beep_01" );
            wait 1;
        }
        
        if ( var_f4f3f0356fef8102 < 0 )
        {
            break;
        }
    }
}

// Namespace destructible
// Params 1
// Checksum 0x468057da, Offset: 0x1541
// Size: 0x97
function usetriggerthink( trigger )
{
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !arraycontains( self.interactteams, player.team ) )
        {
            continue;
        }
        
        if ( player weapon::grenadeinpullback() )
        {
            return 0;
        }
        
        if ( player meleebuttonpressed() )
        {
            return 0;
        }
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        if ( !isdefined( self.plantedbomb ) )
        {
            plantbreachc4( trigger, player );
            continue;
        }
        
        defusec4( player );
    }
}

// Namespace destructible
// Params 2
// Checksum 0x20b8cf0a, Offset: 0x15e0
// Size: 0x3a4, Type: bool
function plantbreachc4( trigger, player )
{
    thread watchplayerdeath( player );
    player.linktoent = player utility::spawn_tag_origin();
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 0 );
    player.linktoent moveto( self.scenenodes[ trigger.scenenodekey ].origin, 0.25, 0.1, 0.1 );
    player.linktoent rotateto( self.scenenodes[ trigger.scenenodekey ].angles, 0.25, 0.1, 0.1 );
    player setstance( "stand" );
    
    if ( !player givegunless() )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
        return false;
    }
    
    if ( self.cancelplant )
    {
        return false;
    }
    
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( self.scenenodes[ trigger.scenenodekey ].origin );
    player setplayerangles( self.scenenodes[ trigger.scenenodekey ].angles );
    
    foreach ( entry in self.useobjects )
    {
        entry hide();
    }
    
    faction = player.team == "allies" ? "usp1" : "afp1";
    player queuedialogforplayer( #"queue1", "dx_mpp_" + faction + "_breach_plant", "cop_breach_plant", 2 );
    thread create_player_rig( player, "planter" );
    player thread anim_mp::anim_player_solo( player, player.player_rig, "plant" );
    wm_c4 = spawn( "script_model", self.scenenodes[ trigger.scenenodekey ].origin );
    wm_c4 setmodel( "offhand_wm_c4" );
    wm_c4.animname = "c4";
    wm_c4 useanimtree( #animtree );
    self.plantedbomb = wm_c4;
    self.plantedkey = trigger.scenenodekey;
    self.scenenodes[ trigger.scenenodekey ] thread animation::anim_single_solo( wm_c4, "plant" );
    animlength = getanimlength( level.scr_anim[ "planter" ][ "plant" ] );
    armedtimeoffset = 0.5;
    wait animlength - armedtimeoffset;
    
    if ( self.cancelplant )
    {
        return false;
    }
    
    thread bomb_planted_think( trigger.scenenodekey, player );
    givebreachscore( player );
    wait armedtimeoffset - 0.1;
    player thread takegunless();
    remove_player_rig( player );
    process_action( "onuse" );
    self notify( #"breach_complete" );
    return true;
}

// Namespace destructible
// Params 1
// Checksum 0x2e01eb6c, Offset: 0x198d
// Size: 0xf3
function watchplayerdeath( player )
{
    self endon( #"breach_complete" );
    self.cancelplant = 0;
    
    while ( true )
    {
        if ( !isdefined( player ) || !player::isreallyalive( player ) )
        {
            foreach ( entry in self.useobjects )
            {
                entry show();
            }
            
            if ( isdefined( self.plantedbomb ) )
            {
                self.plantedbomb delete();
                self.plantedbomb = undefined;
                self.plantedkey = undefined;
            }
            
            self.cancelplant = 1;
            break;
        }
        
        waitframe();
    }
}

// Namespace destructible
// Params 1
// Checksum 0x1189df61, Offset: 0x1a88
// Size: 0x91
function allowplayertobreach( player )
{
    if ( isdefined( level.breachusetriggers ) )
    {
        foreach ( trigger in level.breachusetriggers )
        {
            trigger enableplayeruse( player );
        }
    }
}

// Namespace destructible
// Params 1
// Checksum 0x86171db8, Offset: 0x1b21
// Size: 0x91
function disallowplayertobreach( player )
{
    if ( isdefined( level.breachusetriggers ) )
    {
        foreach ( trigger in level.breachusetriggers )
        {
            trigger disableplayeruse( player );
        }
    }
}

// Namespace destructible
// Params 1
// Checksum 0x1da668b0, Offset: 0x1bba
// Size: 0x2c
function defusec4( player )
{
    self.defused = 1;
    self notify( #"defused" );
    givedefusescore( player );
}

// Namespace destructible
// Params 1
// Checksum 0x2bfb38b0, Offset: 0x1bee
// Size: 0xed
function onplayerjoinedteam( player )
{
    foreach ( array in level.destructibles )
    {
        foreach ( d in array )
        {
            d applyinteractteam( player );
        }
    }
}

// Namespace destructible
// Params 1
// Checksum 0xff68babe, Offset: 0x1ce3
// Size: 0x90
function assigninteractteam( teams )
{
    self.interactteams = teams;
    
    foreach ( player in level.players )
    {
        applyinteractteam( player );
    }
}

// Namespace destructible
// Params 1
// Checksum 0xfe6226be, Offset: 0x1d7b
// Size: 0x227
function applyinteractteam( player )
{
    if ( self.state == "destroyed" )
    {
        return;
    }
    
    if ( !isdefined( self.useobjects ) )
    {
        return;
    }
    
    if ( arraycontains( self.interactteams, player.team ) )
    {
        if ( isdefined( self.plantedbomb ) )
        {
            self.timerobject hidefromplayer( player );
            
            foreach ( key, entry in self.useobjects )
            {
                if ( key == self.plantedkey )
                {
                    entry setuseholdduration( "duration_medium" );
                    entry enableplayeruse( player );
                    entry showtoplayer( player );
                    continue;
                }
                
                entry disableplayeruse( player );
                entry hidefromplayer( player );
            }
        }
        else
        {
            foreach ( key, entry in self.useobjects )
            {
                entry setuseholdduration( "duration_short" );
                entry enableplayeruse( player );
                entry showtoplayer( player );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.plantedbomb ) )
    {
        self.timerobject showtoplayer( player );
    }
    
    foreach ( entry in self.useobjects )
    {
        entry disableplayeruse( player );
        entry hidefromplayer( player );
    }
}

// Namespace destructible
// Params 1
// Checksum 0x9fd7d1ec, Offset: 0x1faa
// Size: 0x48
function givebreachscore( player )
{
    event = #"breach";
    points = rank::getscoreinfovalue( event );
    player thread rank::giverankxp( event, points );
    player thread rank::scoreeventpopup( event );
}

// Namespace destructible
// Params 1
// Checksum 0xcf1f82e5, Offset: 0x1ffa
// Size: 0x48
function givedefusescore( player )
{
    event = #"breach_defuse";
    points = rank::getscoreinfovalue( event );
    player thread rank::giverankxp( event, points );
    player thread rank::scoreeventpopup( event );
}

// Namespace destructible
// Params 0
// Checksum 0x57ffc62e, Offset: 0x204a
// Size: 0x9e
function givegunless()
{
    self endon( #"death_or_disconnect" );
    gunless = makeweapon( "iw8_gunless" );
    inventory_utility::_giveweapon( gunless, undefined, undefined, 1 );
    success = inventory_utility::domonitoredweaponswitch( gunless, 0 );
    
    if ( success )
    {
        self.gunnlessweapon = gunless;
        val::set( "gunless", "weapon_switch", 0 );
        val::set( "gunless", "offhand_weapons", 0 );
        val::set( "gunless", "melee", 0 );
    }
    else
    {
        inventory_utility::_takeweapon( gunless );
        inventory_utility::forcevalidweapon();
    }
    
    return success;
}

// Namespace destructible
// Params 0
// Checksum 0x56140713, Offset: 0x20f1
// Size: 0xad
function takegunless()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
    {
        return;
    }
    
    self.takinggunless = 1;
    
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
    
    self.takinggunless = 0;
    self.gunnlessweapon = undefined;
    val::reset_all( "gunless" );
}

// Namespace destructible
// Params 0
// Checksum 0x54070215, Offset: 0x21a6
// Size: 0x33
function rockable_cars_init()
{
    waitframe();
    rockable_vehicles::rockable_cars_init();
    
    if ( level.projectbundle.var_1067dc4fffdf80b5 )
    {
        level thread function_328ac3fb2f9bdbd8();
        return;
    }
    
    level thread rockable_cars_watch_players();
}

// Namespace destructible
// Params 0, eflags: 0x4
// Checksum 0x205cb6f5, Offset: 0x21e1
// Size: 0x1ee
function private function_328ac3fb2f9bdbd8()
{
    if ( !( isdefined( level.rockablecars ) && isdefined( level.rockablecars.cars ) ) || level.rockablecars.cars.size == 0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player ismantling() || !player isonground() )
            {
                continue;
            }
            
            car = player getmovingplatformparent();
            
            if ( !car || !car.var_74b4660926b3c4f3 || car.var_8d918d553d786fb2 )
            {
                continue;
            }
            
            btwn = player.origin - car.toppoint;
            
            if ( vectordot( btwn, car.up ) < 0 )
            {
                continue;
            }
            
            forwarddot = vectordot( btwn, car.forward );
            rightdot = vectordot( btwn, car.right );
            
            if ( forwarddot >= 0 )
            {
                rock = rightdot >= 0 ? #"front_right" : #"front_left";
            }
            else
            {
                rock = rightdot >= 0 ? #"back_right" : #"back_left";
            }
            
            car thread function_953de4132f2ed0e( player, rock );
        }
        
        waitframe();
    }
}

// Namespace destructible
// Params 2, eflags: 0x4
// Checksum 0x2c770563, Offset: 0x23d7
// Size: 0x1f9
function private function_953de4132f2ed0e( player, currentrock )
{
    self.var_8d918d553d786fb2 = 1;
    self setscriptablepartstate( level.projectbundle.var_123b00100ba4c517 ?? #"anim_playerstandrock", currentrock, 0 );
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( player ) || !player::isreallyalive( player ) )
        {
            break;
        }
        
        if ( player ismantling() || !player isonground() )
        {
            break;
        }
        
        movingplatformparent = player getmovingplatformparent();
        
        if ( movingplatformparent != self )
        {
            break;
        }
        
        btwn = player.origin - self.toppoint;
        
        if ( vectordot( btwn, self.up ) < 0 )
        {
            break;
        }
        
        forwarddot = vectordot( btwn, self.forward );
        rightdot = vectordot( btwn, self.right );
        
        if ( forwarddot >= 0 )
        {
            rock = rightdot >= 0 ? #"front_right" : #"front_left";
        }
        else
        {
            rock = rightdot >= 0 ? #"back_right" : #"back_left";
        }
        
        if ( rock == currentrock )
        {
            continue;
        }
        
        self setscriptablepartstate( level.projectbundle.var_123b00100ba4c517 ?? #"anim_playerstandrock", rock, 0 );
        currentrock = rock;
    }
    
    self setscriptablepartstate( level.projectbundle.var_123b00100ba4c517 ?? #"anim_playerstandrock", hashcat( currentrock, "_up" ), 0 );
    
    while ( self getscriptablepartstate( level.projectbundle.var_123b00100ba4c517 ?? #"anim_playerstandrock", 1 ) != #"off" )
    {
        waitframe();
    }
    
    self.var_8d918d553d786fb2 = undefined;
}

// Namespace destructible
// Params 0, eflags: 0x4
// Checksum 0x286fc806, Offset: 0x25d8
// Size: 0x526
function private rockable_cars_watch_players()
{
    if ( !( isdefined( level.rockablecars ) && isdefined( level.rockablecars.cars ) ) || level.rockablecars.cars.size == 0 )
    {
        return;
    }
    
    waitframe();
    function_5e1df6024557e751();
    level endon( #"game_ended" );
    rockablecars = level.rockablecars.carsinplayspace ?? level.rockablecars.cars;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            car = player getmovingplatformparent();
            
            if ( !car || !car.var_74b4660926b3c4f3 )
            {
                continue;
            }
            
            if ( !level.rockablecars.carsinplayspace[ car.entnum ?? utility::get_entity_number( car ) ] )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player ismantling() || !player isonground() )
            {
                continue;
            }
            
            btwn = player.origin - car.toppoint;
            
            if ( vectordot( btwn, car.up ) < 0 )
            {
                continue;
            }
            
            forwarddot = vectordot( btwn, car.forward );
            rightdot = vectordot( btwn, car.right );
            
            if ( forwarddot >= 0 )
            {
                rock = rightdot >= 0 ? #"front_right" : #"front_left";
            }
            else
            {
                rock = rightdot >= 0 ? #"back_right" : #"back_left";
            }
            
            if ( player.lastrock == rock )
            {
                continue;
            }
            
            if ( !isdefined( car.players[ player.entnum ?? utility::get_entity_number( player ) ] ) )
            {
                car rockable_car_add_player( player );
            }
            
            var_dfb6ff51ad0c8a86 = abs( forwarddot ) / car.halflength;
            
            if ( var_dfb6ff51ad0c8a86 > 1 )
            {
                continue;
            }
            
            halfwidthratio = abs( rightdot ) / car.halfwidth;
            
            if ( halfwidthratio > 1 )
            {
                continue;
            }
            
            if ( var_dfb6ff51ad0c8a86 > 0.4 && halfwidthratio > 0 )
            {
                car rockable_car_rock( player, var_dfb6ff51ad0c8a86, halfwidthratio, forwarddot, rightdot, rock );
            }
        }
        
        now = gettime();
        
        foreach ( car in rockablecars )
        {
            if ( !isdefined( car ) )
            {
                continue;
            }
            
            foreach ( id, player in car.players )
            {
                touchdelay = now - car.touchtimes[ id ];
                
                if ( !isdefined( player ) || !player::isreallyalive( player ) )
                {
                    car rockable_car_remove_player( player, id, undefined, 0 );
                    continue;
                }
                
                if ( player ismantling() || !player isonground() )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                movingplatformparent = player getmovingplatformparent();
                
                if ( movingplatformparent != car )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                btwn = player.origin - car.toppoint;
                
                if ( vectordot( btwn, car.up ) < 0 )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                if ( abs( vectordot( btwn, car.forward ) ) / car.halflength > 1 )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                if ( abs( vectordot( btwn, car.right ) ) / car.halfwidth > 1 )
                {
                    car rockable_car_remove_player( player, id, touchdelay, 1 );
                    continue;
                }
                
                car.touchtimes[ id ] = now;
            }
        }
        
        waitframe();
    }
}

// Namespace destructible
// Params 0, eflags: 0x4
// Checksum 0xa42a0f37, Offset: 0x2b06
// Size: 0x10b
function private function_5e1df6024557e751()
{
    mapinfoname = getactivemapinfobundlename();
    
    if ( mapinfoname && !function_b6f868c0d5ba41aa( "mapinfo", mapinfoname, #"hash_e78234bd1c23d8bf" ) )
    {
        return;
    }
    
    level.rockablecars.carsinplayspace = [];
    
    foreach ( car in level.rockablecars.cars )
    {
        if ( !isdefined( car ) )
        {
            continue;
        }
        
        if ( !ispointonnavmesh( car.origin ) )
        {
            continue;
        }
        
        level.rockablecars.carsinplayspace[ car.entnum ?? utility::get_entity_number( car ) ] = car;
    }
}

// Namespace destructible
// Params 1
// Checksum 0xb9e9a96e, Offset: 0x2c19
// Size: 0x3e
function rockable_car_add_player( player )
{
    self.players[ player.entnum ] = player;
    self.touchtimes[ player.entnum ] = gettime();
}

// Namespace destructible
// Params 4
// Checksum 0x7bcc4630, Offset: 0x2c5f
// Size: 0xa1
function rockable_car_remove_player( player, id, touchdelay, var_88e02e011dc99b74 )
{
    if ( var_88e02e011dc99b74 )
    {
        if ( touchdelay >= 200 )
        {
            self.players[ id ] = undefined;
            self.touchtimes[ id ] = undefined;
            self.rocktimes[ id ] = undefined;
            
            if ( isdefined( player ) )
            {
                player.lastrock = undefined;
            }
        }
        
        return;
    }
    
    self.players[ id ] = undefined;
    self.touchtimes[ id ] = undefined;
    self.rocktimes[ id ] = undefined;
    
    if ( isdefined( player ) )
    {
        player.lastrock = undefined;
    }
}

// Namespace destructible
// Params 6
// Checksum 0x85fe1922, Offset: 0x2d08
// Size: 0x94
function rockable_car_rock( player, var_dfb6ff51ad0c8a86, halfwidthratio, forwarddot, rightdot, rock )
{
    self setscriptablepartstate( level.projectbundle.var_123b00100ba4c517 ?? #"anim_playerstandrock", rock, 0 );
    self.rocktimes[ player.entnum ?? utility::get_entity_number( player ) ] = gettime();
    player.lastrock = rock;
}

