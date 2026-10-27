// scripts\mp\common\killstreaks\deployablebox.gsc  (hash_78c4eeb199715644.gscc) (size: 12911 Bytes / 0x326f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x475c181b (1197217819)
// size ...... 12911 (0x326f)
// includes .. 20  (offset: 0x309f)
// strings ... 22  (offset: 0x313f)
// dev strs .. 3   (offset: 0x324b)
// exports ... 40  (offset: 0x1d63)
// cseg ...... 0x1c0 + 0x1ba3 (0x1d63)
// imports ... 112 (offset: 0x23a3)
// animtree1 . 0   (offset: 0x326f)
// animtree2 . 0   (offset: 0x326f)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\gameobjects;
#using scripts\mp\hostmigration;
#using scripts\mp\movers;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;

#namespace deployablebox;

// Namespace deployablebox
// Params 0
// Checksum 0x4bf1b142, Offset: 0x1de
// Size: 0x18
function init()
{
    if ( !isdefined( level.boxsettings ) )
    {
        level.boxsettings = [];
    }
}

// Namespace deployablebox
// Params 8
// Checksum 0x127cfc6d, Offset: 0x1fe
// Size: 0x68, Type: bool
function begindeployableviamarker( streakinfo, lifeid, boxtype, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_8313fa50c6c6aa8b )
{
    thread cleanupdeployablemarkerondisconnect( projectileentity );
    thread watchdeployablemarkerplacement( streakinfo, boxtype, lifeid, projectileentity, weaponname, damagefuncoverride, deathfuncoverride, var_8313fa50c6c6aa8b );
    return true;
}

// Namespace deployablebox
// Params 8
// Checksum 0xdb35f01c, Offset: 0x26f
// Size: 0x136
function watchdeployablemarkerplacement( streakinfo, boxtype, lifeid, marker, weaponname, damagefunc, deathfunc, timeoutfunc )
{
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    
    if ( !isdefined( marker ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( weaponname ) )
    {
        assertmsg( "<dev string:x93>" );
        return;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        marker delete();
    }
    
    marker makecollidewithitemclip( 1 );
    self notify( #"deployable_deployed" );
    marker.owner = self;
    marker.weaponname = weaponname;
    self.marker = marker;
    
    if ( isgrenadedeployable( boxtype ) )
    {
        self thread [[ level.boxsettings[ boxtype ].grenadeusefunc ]]( marker );
        return;
    }
    
    marker playsoundtoplayer( level.boxsettings[ boxtype ].deployedsfx, self );
    marker thread markeractivate( streakinfo, lifeid, boxtype, &box_setactive, damagefunc, deathfunc, timeoutfunc );
}

// Namespace deployablebox
// Params 1
// Checksum 0x978105e4, Offset: 0x3ad
// Size: 0x4d
function cleanupdeployablemarkerondisconnect( marker )
{
    marker endon( #"death" );
    marker endon( #"late_missile_stuck" );
    marker thread script::notifyafterframeend( "missile_stuck", "late_missile_stuck" );
    self waittill( #"disconnect" );
    marker delete();
}

// Namespace deployablebox
// Params 1
// Checksum 0x61bb647b, Offset: 0x402
// Size: 0x23
function override_box_moving_platform_death( data )
{
    self.isdestroyed = 1;
    self notify( #"death" );
}

// Namespace deployablebox
// Params 7
// Checksum 0x4ae9f6ba, Offset: 0x42d
// Size: 0x1ff
function markeractivate( streakinfo, lifeid, boxtype, usedcallback, damagecallback, deathcallback, timeoutcallback )
{
    self notify( #"hash_602d4befe1adb1a2" );
    self endon( #"hash_602d4befe1adb1a2" );
    self waittill( #"missile_stuck" );
    owner = self.owner;
    position = self.origin;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    box = createboxforplayer( boxtype, position, owner );
    data = spawnstruct();
    data.linkparent = self getlinkedparent();
    
    if ( isdefined( data.linkparent ) && isdefined( data.linkparent.model ) && data.linkparent.model != "" )
    {
        box.origin = data.linkparent.origin;
        grandparent = data.linkparent getlinkedparent();
        
        if ( isdefined( grandparent ) )
        {
            data.linkparent = grandparent;
        }
        else
        {
            data.linkparent = undefined;
        }
    }
    
    data.deathoverridecallback = &override_box_moving_platform_death;
    box thread movers::handle_moving_platforms( data );
    box.moving_platform = data.linkparent;
    box setotherent( owner );
    waitframe();
    box thread [[ usedcallback ]]( damagecallback, deathcallback, timeoutcallback );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    self delete();
    
    if ( isdefined( box ) && box entity::touchingbadtrigger() )
    {
        self.isdestroyed = 1;
        box notify( #"death" );
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0xb8883019, Offset: 0x634
// Size: 0x43, Type: bool
function deployableexclusion( parentmodel )
{
    if ( parentmodel == "mp_satcom" )
    {
        return true;
    }
    else if ( issubstr( parentmodel, "paris_catacombs_iron" ) )
    {
        return true;
    }
    else if ( issubstr( parentmodel, "mp_warhawk_iron_gate" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace deployablebox
// Params 3
// Checksum 0xf213a1bf, Offset: 0x680
// Size: 0x16d
function createboxforplayer( boxtype, position, owner )
{
    assert( isdefined( owner ), "<dev string:xff>" );
    boxconfig = level.boxsettings[ boxtype ];
    box = spawn( "script_model", position - ( 0, 0, 1 ) );
    box setmodel( boxconfig.modelbase );
    box.health = 999999;
    box.maxhealth = boxconfig.maxhealth;
    box.angles = owner.angles;
    box.boxtype = boxtype;
    box.owner = owner;
    box.team = owner.team;
    box.id = boxconfig.id;
    
    if ( isdefined( boxconfig.dpadname ) )
    {
        box.dpadname = boxconfig.dpadname;
    }
    
    if ( isdefined( boxconfig.maxuses ) )
    {
        box.usesremaining = boxconfig.maxuses;
    }
    
    box box_setinactive();
    box thread box_handleownerdisconnect();
    box addboxtolevelarray();
    return box;
}

// Namespace deployablebox
// Params 3
// Checksum 0x4eee775, Offset: 0x7f6
// Size: 0x4a6
function box_setactive( damagecallback, deathcallback, timeoutcallback )
{
    boxconfig = level.boxsettings[ self.boxtype ];
    self.inuse = 0;
    curobjid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( curobjid == -1 )
    {
        return;
    }
    
    objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
    
    if ( !isdefined( self getlinkedparent() ) )
    {
        objidpoolmanager::update_objective_position( curobjid, self.origin );
    }
    else
    {
        objidpoolmanager::update_objective_onentity( curobjid, self );
    }
    
    objidpoolmanager::update_objective_state( curobjid, "active" );
    objidpoolmanager::update_objective_icon( curobjid, boxconfig.shadername );
    objidpoolmanager::update_objective_setbackground( curobjid, 1 );
    self.objidfriendly = curobjid;
    
    if ( level.teambased )
    {
        if ( curobjid != -1 )
        {
            objidpoolmanager::objective_teammask_single( curobjid, self.team );
        }
        
        box_seticon( self.team, boxconfig.streakname, boxconfig.headiconoffset );
        
        foreach ( player in level.players )
        {
            if ( self.team != player.team )
            {
                continue;
            }
            
            if ( isdefined( boxconfig.canusecallback ) && !player [[ boxconfig.canusecallback ]]( self ) )
            {
                if ( isdefined( self.boxiconid ) )
                {
                    entityheadicons::setheadicon_removeclientfrommask( self.boxiconid, player );
                }
            }
        }
    }
    else
    {
        if ( curobjid != -1 )
        {
            objidpoolmanager::objective_playermask_single( curobjid, self.owner );
        }
        
        if ( !isdefined( boxconfig.canusecallback ) || self.owner [[ boxconfig.canusecallback ]]( self ) )
        {
            box_seticon( self.owner, boxconfig.streakname, boxconfig.headiconoffset );
        }
    }
    
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( boxconfig.hintstring );
    self setusehideprogressbar( 1 );
    self.isusable = 1;
    self setcandamage( 1 );
    
    if ( isdefined( damagecallback ) )
    {
        self thread [[ damagecallback ]]();
    }
    else
    {
        thread box_handledamage();
    }
    
    if ( isdefined( deathcallback ) )
    {
        self thread [[ deathcallback ]]();
    }
    else
    {
        thread box_handledeath();
    }
    
    if ( isdefined( timeoutcallback ) )
    {
        self thread [[ timeoutcallback ]]();
    }
    else
    {
        thread box_timeout();
    }
    
    sentientpoolmanager::registersentient( "Tactical_Ground", self.owner );
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"new_deployable_box", self );
    }
    
    if ( level.teambased )
    {
        foreach ( player in level.participants )
        {
            if ( boxconfig.isteamless )
            {
                _box_setactivehelper( player, 1, boxconfig.canusecallback );
            }
            else
            {
                _box_setactivehelper( player, self.team == player.team, boxconfig.canusecallback );
            }
            
            if ( !isai( player ) )
            {
                thread box_playerjoinedteam( player );
            }
        }
    }
    else
    {
        foreach ( player in level.participants )
        {
            _box_setactivehelper( player, self.owner == player, boxconfig.canusecallback );
        }
    }
    
    thread box_playerconnected();
    thread box_agentconnected();
    
    if ( isdefined( boxconfig.ondeploycallback ) )
    {
        self [[ boxconfig.ondeploycallback ]]( boxconfig );
    }
}

// Namespace deployablebox
// Params 3
// Checksum 0x3f19641f, Offset: 0xca4
// Size: 0x67
function _box_setactivehelper( player, bactivate, canusefunc )
{
    if ( bactivate )
    {
        if ( !isdefined( canusefunc ) || player [[ canusefunc ]]( self ) )
        {
            box_enableplayeruse( player );
        }
        else
        {
            box_disableplayeruse( player );
            thread doubledip( player );
        }
        
        thread boxthink( player );
        return;
    }
    
    box_disableplayeruse( player );
}

// Namespace deployablebox
// Params 0
// Checksum 0xaa97573b, Offset: 0xd13
// Size: 0x38
function box_playerconnected()
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        childthread box_waittill_player_spawn_and_add_box( player );
    }
}

// Namespace deployablebox
// Params 0
// Checksum 0x92e24dc5, Offset: 0xd53
// Size: 0x38
function box_agentconnected()
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"hash_9d131336aa866afd", agent );
        box_addboxforplayer( agent );
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0x62027db2, Offset: 0xd93
// Size: 0x38
function box_waittill_player_spawn_and_add_box( player )
{
    player waittill( #"spawned_player" );
    
    if ( level.teambased )
    {
        box_addboxforplayer( player );
        thread box_playerjoinedteam( player );
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0x632084f6, Offset: 0xdd3
// Size: 0x50
function box_playerjoinedteam( player )
{
    self endon( #"death" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"joined_team" );
        
        if ( level.teambased )
        {
            box_addboxforplayer( player );
        }
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0xe89375dd, Offset: 0xe2b
// Size: 0x82
function box_addboxforplayer( player )
{
    if ( self.team == player.team || level.boxsettings[ self.boxtype ].isteamless )
    {
        box_enableplayeruse( player );
        thread boxthink( player );
        return;
    }
    
    box_disableplayeruse( player );
    
    if ( isdefined( self.boxiconid ) )
    {
        entityheadicons::setheadicon_removeclientfrommask( self.boxiconid, player );
    }
}

// Namespace deployablebox
// Params 3
// Checksum 0x8ac93a2, Offset: 0xeb5
// Size: 0x8a
function box_seticon( player, streakname, voffset )
{
    boxconfig = level.boxsettings[ self.boxtype ];
    headicon = killstreak::getkillstreakoverheadicon( streakname );
    
    if ( isdefined( boxconfig.headicon ) )
    {
        headicon = boxconfig.headicon;
    }
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        self.boxiconid = entityheadicons::setheadicon_singleimage( player, headicon, voffset, 1 );
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0x9f831987, Offset: 0xf47
// Size: 0x2f
function box_enableplayeruse( player )
{
    if ( isplayer( player ) )
    {
        self enableplayeruse( player );
    }
    
    self.disabled_use_for[ player getentitynumber() ] = 0;
}

// Namespace deployablebox
// Params 1
// Checksum 0x24d8a2eb, Offset: 0xf7e
// Size: 0x30
function box_disableplayeruse( player )
{
    if ( isplayer( player ) )
    {
        self disableplayeruse( player );
    }
    
    self.disabled_use_for[ player getentitynumber() ] = 1;
}

// Namespace deployablebox
// Params 0
// Checksum 0x2fbaff1, Offset: 0xfb6
// Size: 0x2f
function box_setinactive()
{
    self makeunusable();
    self.isusable = 0;
    
    if ( isdefined( self.objidfriendly ) )
    {
        objidpoolmanager::returnobjectiveid( self.objidfriendly );
    }
}

// Namespace deployablebox
// Params 0
// Checksum 0x15f9743f, Offset: 0xfed
// Size: 0x4a
function box_handledamage()
{
    boxconfig = level.boxsettings[ self.boxtype ];
    damage::monitordamage( boxconfig.maxhealth, boxconfig.damagefeedback, &box_handledeathdamage, &box_modifydamage, 1 );
}

// Namespace deployablebox
// Params 1
// Checksum 0x5e73c306, Offset: 0x103f
// Size: 0xcd
function box_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    boxconfig = level.boxsettings[ self.boxtype ];
    
    if ( boxconfig.allowmeleedamage )
    {
        modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    }
    
    modifieddamage = damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handlegrenadedamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    return modifieddamage;
}

// Namespace deployablebox
// Params 1
// Checksum 0xc0654cf9, Offset: 0x1115
// Size: 0xbb
function box_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    self.destroyedbydamage = 1;
    boxconfig = level.boxsettings[ self.boxtype ];
    notifyattacker = damage::onkillstreakkilled( "deployable_ammo", attacker, objweapon, type, damage, boxconfig.scorepopup, boxconfig.vodestroyed );
}

// Namespace deployablebox
// Params 0
// Checksum 0xb2c61c05, Offset: 0x11d8
// Size: 0x159
function box_handledeath()
{
    self waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    box_setinactive();
    removeboxfromlevelarray();
    boxconfig = level.boxsettings[ self.boxtype ];
    
    if ( !self.destroyedbydamage )
    {
        playfx( boxconfig.deathvfx, self.origin );
        self playsound( "mp_killstreak_disappear" );
    }
    else
    {
        damagespawnpos = self.origin + ( 0, 0, boxconfig.headiconoffset );
        
        if ( isdefined( boxconfig.deathdamagemax ) )
        {
            owner = undefined;
            
            if ( isdefined( self.owner ) )
            {
                owner = self.owner;
            }
            
            if ( isdefined( boxconfig.explodevfx ) )
            {
                playfx( boxconfig.explodevfx, self.origin );
                self playsound( "c4_expl_trans" );
            }
            
            radiusdamage( damagespawnpos, boxconfig.deathdamageradius, boxconfig.deathdamagemax, boxconfig.deathdamagemin, owner, "MOD_EXPLOSIVE", "support_box_mp" );
            thread shellshock::grenade_earthquakeatposition( self.origin, 1 );
        }
    }
    
    self notify( #"deleting" );
    self delete();
}

// Namespace deployablebox
// Params 0
// Checksum 0x30ef5f4a, Offset: 0x1339
// Size: 0x56
function box_handleownerdisconnect()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self notify( #"hash_2969c7acec3c98d0" );
    self endon( #"hash_2969c7acec3c98d0" );
    childthread box_watchownerstatus( "disconnect" );
    childthread box_watchownerstatus( "joined_team" );
    childthread box_watchownerstatus( "joined_spectators" );
}

// Namespace deployablebox
// Params 1
// Checksum 0xd1a6fc4c, Offset: 0x1397
// Size: 0x31
function box_watchownerstatus( notifymsg )
{
    self.owner waittill( notifymsg );
    self.isdestroyed = 1;
    self notify( #"death" );
}

// Namespace deployablebox
// Params 1
// Checksum 0xeb3d0603, Offset: 0x13d0
// Size: 0x253
function boxthink( player )
{
    self endon( #"death" );
    thread boxcapturethink( player );
    
    if ( !isdefined( player.boxes ) )
    {
        player.boxes = [];
    }
    
    player.boxes[ player.boxes.size ] = self;
    boxconfig = level.boxsettings[ self.boxtype ];
    
    for ( ;; )
    {
        self waittill( #"captured", capturer );
        
        if ( capturer == player )
        {
            player playlocalsound( boxconfig.onusesfx );
            
            if ( isdefined( boxconfig.onusecallback ) )
            {
                player [[ boxconfig.onusecallback ]]( self );
            }
            
            if ( isdefined( self.owner ) && player != self.owner && !player_utility::playersareenemies( self.owner, player ) )
            {
                self.owner thread points::doscoreevent( #"support", undefined, boxconfig.usexp );
            }
            
            if ( isdefined( self.usesremaining ) )
            {
                self.usesremaining--;
                
                if ( self.usesremaining == 0 )
                {
                    box_leave();
                    break;
                }
            }
            
            if ( boxconfig.canuseotherboxes )
            {
                foreach ( box in level.deployable_box[ boxconfig.streakname ] )
                {
                    box box_disableplayeruse( player );
                    
                    if ( isdefined( box.boxiconid ) )
                    {
                        entityheadicons::setheadicon_removeclientfrommask( box.boxiconid, player );
                    }
                    
                    box thread doubledip( player );
                }
                
                continue;
            }
            
            if ( boxconfig.canreusebox )
            {
                continue;
            }
            
            if ( isdefined( self.boxiconid ) )
            {
                entityheadicons::setheadicon_removeclientfrommask( self.boxiconid, player );
            }
            
            box_disableplayeruse( player );
            thread doubledip( player );
        }
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0xd96147cb, Offset: 0x162b
// Size: 0xb9
function doubledip( player )
{
    self endon( #"death" );
    player endon( #"disconnect" );
    player waittill( #"death" );
    
    if ( level.teambased )
    {
        if ( self.team == player.team )
        {
            if ( isdefined( self.boxiconid ) )
            {
                entityheadicons::setheadicon_addclienttomask( self.boxiconid, player );
            }
            
            box_enableplayeruse( player );
        }
        
        return;
    }
    
    if ( self.owner == player )
    {
        if ( isdefined( self.boxiconid ) )
        {
            entityheadicons::setheadicon_addclienttomask( self.boxiconid, player );
        }
        
        box_enableplayeruse( player );
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0xfdc1ab7d, Offset: 0x16ec
// Size: 0xaa
function boxcapturethink( player )
{
    level endon( #"game_ended" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", triggerer );
        
        if ( level.boxsettings[ self.boxtype ].nousekillstreak && weapon::iskillstreakweapon( player getcurrentweapon() ) )
        {
            continue;
        }
        
        if ( triggerer == player && useholdthink( player, level.boxsettings[ self.boxtype ].usetime ) )
        {
            self notify( #"captured", player );
        }
    }
}

// Namespace deployablebox
// Params 1
// Checksum 0x56b1873b, Offset: 0x179e
// Size: 0x2e, Type: bool
function isfriendlytobox( box )
{
    return level.teambased && self.team == box.team;
}

// Namespace deployablebox
// Params 0
// Checksum 0x9f84d6be, Offset: 0x17d5
// Size: 0x88
function box_timeout()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    boxconfig = level.boxsettings[ self.boxtype ];
    lifespan = boxconfig.lifespan;
    hostmigration::waitlongdurationwithhostmigrationpause( lifespan );
    
    if ( isdefined( boxconfig.vogone ) )
    {
        self.owner thread dialog::leaderdialogonplayer( boxconfig.vogone );
    }
    
    box_leave();
}

// Namespace deployablebox
// Params 0
// Checksum 0x30146000, Offset: 0x1865
// Size: 0x1a
function box_leave()
{
    waitframe();
    self.isdestroyed = 1;
    self notify( #"death" );
}

// Namespace deployablebox
// Params 1
// Checksum 0xc733eb09, Offset: 0x1887
// Size: 0x4e
function deleteonownerdeath( owner )
{
    wait 0.25;
    self linkto( owner, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    owner waittill( #"death" );
    box_leave();
}

// Namespace deployablebox
// Params 1
// Checksum 0xd894a782, Offset: 0x18dd
// Size: 0x13c
function box_modelteamupdater( var_5d9289b5976f67df )
{
    self endon( #"death" );
    self hide();
    
    foreach ( player in level.players )
    {
        if ( player.team == var_5d9289b5976f67df )
        {
            self showtoplayer( player );
        }
    }
    
    for ( ;; )
    {
        level waittill( #"joined_team" );
        self hide();
        
        foreach ( player in level.players )
        {
            if ( player.team == var_5d9289b5976f67df )
            {
                self showtoplayer( player );
            }
        }
    }
}

// Namespace deployablebox
// Params 2
// Checksum 0xd0b91c38, Offset: 0x1a21
// Size: 0x158
function useholdthink( player, usetime )
{
    movers::script_mover_link_to_use_object( player );
    player val::set( "useHold", "weapon", 0 );
    player.boxparams = spawnstruct();
    player.boxparams.curprogress = 0;
    player.boxparams.inuse = 1;
    player.boxparams.userate = 0;
    player.boxparams.id = self.id;
    
    if ( isdefined( usetime ) )
    {
        player.boxparams.usetime = usetime;
    }
    else
    {
        player.boxparams.usetime = 3000;
    }
    
    result = useholdthinkloop( player );
    assert( isdefined( result ) );
    
    if ( isalive( player ) )
    {
        player val::reset_all( "useHold" );
        movers::script_mover_unlink_from_use_object( player );
    }
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    player.boxparams.inuse = 0;
    player.boxparams.curprogress = 0;
    return result;
}

// Namespace deployablebox
// Params 1
// Checksum 0xbfd12b88, Offset: 0x1b82
// Size: 0xfa, Type: bool
function useholdthinkloop( player )
{
    config = player.boxparams;
    
    while ( player isplayerusingbox( config ) )
    {
        if ( !player movers::script_mover_use_can_link( self ) )
        {
            player gameobjects::updateuiprogress( config, 0 );
            return false;
        }
        
        config.curprogress += level.frameduration * config.userate;
        
        if ( isdefined( player.objectivescaler ) )
        {
            config.userate = 1 * player.objectivescaler;
        }
        else
        {
            config.userate = 1;
        }
        
        player gameobjects::updateuiprogress( config, 1 );
        
        if ( config.curprogress >= config.usetime )
        {
            player gameobjects::updateuiprogress( config, 0 );
            return player::isreallyalive( player );
        }
        
        waitframe();
    }
    
    player gameobjects::updateuiprogress( config, 0 );
    return false;
}

// Namespace deployablebox
// Params 0
// Checksum 0xd4fcd5b4, Offset: 0x1c85
// Size: 0x1d
function addboxtolevelarray()
{
    level.deployable_box[ self.boxtype ][ self getentitynumber() ] = self;
}

// Namespace deployablebox
// Params 0
// Checksum 0x49539bff, Offset: 0x1caa
// Size: 0x1b
function removeboxfromlevelarray()
{
    level.deployable_box[ self.boxtype ][ self getentitynumber() ] = undefined;
}

// Namespace deployablebox
// Params 1
// Checksum 0x8dc1344f, Offset: 0x1ccd
// Size: 0x6e, Type: bool
function isplayerusingbox( box )
{
    return !level.gameended && isdefined( box ) && player::isreallyalive( self ) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && box.curprogress < box.usetime && !self.teleporting;
}

// Namespace deployablebox
// Params 1
// Checksum 0x632c1be9, Offset: 0x1d44
// Size: 0x1e
function isgrenadedeployable( boxtype )
{
    isgrenade = 0;
    isgrenade = 0;
    return isgrenade;
}

