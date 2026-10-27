// scripts\mp\common\killstreaks\placeable.gsc  (hash_46e06758318a59e3.gscc) (size: 9880 Bytes / 0x2698 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7ac0492 (3886810258)
// size ...... 9880 (0x2698)
// includes .. 13  (offset: 0x248c)
// strings ... 27  (offset: 0x24f4)
// dev strs .. 2   (offset: 0x2680)
// exports ... 31  (offset: 0x14f4)
// cseg ...... 0x218 + 0x12dc (0x14f4)
// imports ... 94  (offset: 0x19cc)
// animtree1 . 0   (offset: 0x2698)
// animtree2 . 0   (offset: 0x2698)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\weapons;

#namespace placeable;

// Namespace placeable
// Params 0
// Checksum 0x7df6428b, Offset: 0x236
// Size: 0x18
function init()
{
    if ( !isdefined( level.placeableconfigs ) )
    {
        level.placeableconfigs = [];
    }
}

// Namespace placeable
// Params 2
// Checksum 0x3166bbfd, Offset: 0x256
// Size: 0x7f, Type: bool
function giveplaceable( streakname, var_4e458543b7b021b0 )
{
    placeable = createplaceable( streakname );
    removeperks();
    self.carrieditem = placeable;
    
    /#
        if ( getdvarint( @"hash_cae913bf39486207", 0 ) != 0 )
        {
            var_4e458543b7b021b0 = 0;
        }
    #/
    
    result = onbegincarrying( streakname, placeable, 1, var_4e458543b7b021b0 );
    self.carrieditem = undefined;
    restoreperks();
    return isdefined( placeable );
}

// Namespace placeable
// Params 1
// Checksum 0xf40a7507, Offset: 0x2de
// Size: 0x106
function createplaceable( streakname )
{
    if ( self.iscarrying )
    {
        return;
    }
    
    config = level.placeableconfigs[ streakname ];
    obj = spawn( "script_model", self.origin );
    obj setmodel( config.modelbase );
    obj.angles = self.angles;
    obj.owner = self;
    obj.team = self.team;
    obj.config = config;
    obj.firstplacement = 1;
    
    if ( isdefined( config.oncreatedelegate ) )
    {
        obj [[ config.oncreatedelegate ]]( streakname );
    }
    
    obj deactivate( streakname );
    obj thread timeout( streakname );
    obj thread handleuse( streakname );
    obj thread onkillstreakdisowned( streakname );
    obj thread ongameended( streakname );
    return obj;
}

// Namespace placeable
// Params 1
// Checksum 0x83a38e2c, Offset: 0x3ed
// Size: 0x96
function handleuse( streakname )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        assert( player == self.owner );
        assert( !isdefined( self.carriedby ) );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( isdefined( self getlinkedparent() ) )
        {
            self unlink();
        }
        
        player onbegincarrying( streakname, self, 0 );
    }
}

// Namespace placeable
// Params 4
// Checksum 0xcba35561, Offset: 0x48b
// Size: 0x1b2
function onbegincarrying( streakname, placeable, allowcancel, var_4e458543b7b021b0 )
{
    self endon( #"death_or_disconnect" );
    assert( player::isreallyalive( self ) );
    placeable thread oncarried( streakname, self );
    val::set( "carry", "weapon", 0 );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "placePlaceable", "+attack" );
        self notifyonplayercommand( "placePlaceable", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancelPlaceable", "+actionslot 4" );
        
        if ( !self isconsoleplayer() )
        {
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 5" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 6" );
            self notifyonplayercommand( "cancelPlaceable", "+actionslot 7" );
        }
    }
    
    while ( true )
    {
        if ( var_4e458543b7b021b0 == 1 && !self isonladder() && self isonground() && !self ismantling() )
        {
            result = "placePlaceable";
        }
        else
        {
            result = utility::waittill_any_return( "placePlaceable", "cancelPlaceable", "force_cancel_placement" );
        }
        
        if ( !isdefined( placeable ) )
        {
            val::reset_all( "carry" );
            return 1;
        }
        
        if ( result == "cancelPlaceable" && allowcancel || result == "force_cancel_placement" )
        {
            placeable oncancel( streakname, result == "force_cancel_placement" && !isdefined( placeable.firstplacement ) );
            return 0;
        }
        
        if ( placeable.canbeplaced )
        {
            placeable thread onplaced( streakname );
            val::reset_all( "carry" );
            return 1;
        }
        
        waitframe();
    }
}

// Namespace placeable
// Params 2
// Checksum 0x29c6d7d6, Offset: 0x645
// Size: 0xe0
function oncancel( streakname, var_5f7bdacda98b909a )
{
    if ( isdefined( self.carriedby ) )
    {
        owner = self.carriedby;
        owner forceusehintoff();
        owner.iscarrying = undefined;
        owner.carrieditem = undefined;
        owner val::reset_all( "carry" );
    }
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel delete();
    }
    
    if ( isdefined( self.carriedobj ) )
    {
        self.carriedobj delete();
    }
    
    config = level.placeableconfigs[ streakname ];
    
    if ( isdefined( config.oncanceldelegate ) )
    {
        self [[ config.oncanceldelegate ]]( streakname );
    }
    
    if ( var_5f7bdacda98b909a )
    {
        weapons::equipmentdeletevfx();
    }
    
    self delete();
}

// Namespace placeable
// Params 1
// Checksum 0x391f9781, Offset: 0x72d
// Size: 0x28d
function onplaced( streakname )
{
    config = level.placeableconfigs[ streakname ];
    self.origin = self.placementorigin;
    self.angles = self.carriedobj.angles;
    self playsound( config.placedsfx );
    showplacedmodel( streakname );
    
    if ( isdefined( config.onplaceddelegate ) )
    {
        self [[ config.onplaceddelegate ]]( streakname );
    }
    
    owner = self.owner;
    owner forceusehintoff();
    owner.iscarrying = undefined;
    self.carriedby = undefined;
    self.isplaced = 1;
    self.firstplacement = undefined;
    
    if ( isdefined( config.headiconheight ) )
    {
        profilestart();
        self.headiconid = entityheadicons::setheadicon_factionimage( 0, config.headiconheight, 0, undefined, undefined, undefined, 1 );
        profilestop();
    }
    
    thread handledamage( streakname );
    thread handledeath( streakname );
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( config.hintstring );
    sentientpoolmanager::registersentient( "Killstreak_Ground", self.owner );
    
    foreach ( player in level.players )
    {
        if ( player == owner )
        {
            self enableplayeruse( player );
            continue;
        }
        
        self disableplayeruse( player );
    }
    
    if ( isdefined( self.shouldsplash ) )
    {
        level thread hud_util::teamplayercardsplash( config.splashname, owner );
        self.shouldsplash = 0;
    }
    
    data = spawnstruct();
    data.linkparent = self.moving_platform;
    data.endonstring = "carried";
    
    if ( isdefined( config.onmovingplatformcollision ) )
    {
        data.deathoverridecallback = config.onmovingplatformcollision;
    }
    
    thread movers::handle_moving_platforms( data );
    thread watchplayerconnected();
    self notify( #"placed" );
    self.carriedobj delete();
    self.carriedobj = undefined;
}

// Namespace placeable
// Params 2
// Checksum 0x3be02d4d, Offset: 0x9c2
// Size: 0xdb
function oncarried( streakname, carrier )
{
    config = level.placeableconfigs[ streakname ];
    assert( isplayer( carrier ) );
    assert( carrier == self.owner, "<dev string:x24>" );
    self.carriedobj = carrier createcarriedobject( streakname );
    self.isplaced = undefined;
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    deactivate( streakname );
    hideplacedmodel( streakname );
    
    if ( isdefined( config.oncarrieddelegate ) )
    {
        self [[ config.oncarrieddelegate ]]( streakname );
    }
    
    thread updateplacement( streakname, carrier );
    thread oncarrierdeath( streakname, carrier );
    self notify( #"carried" );
}

// Namespace placeable
// Params 2
// Checksum 0x9fc9c1e6, Offset: 0xaa5
// Size: 0x201
function updateplacement( streakname, carrier )
{
    carrier endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"placed" );
    self endon( #"death" );
    self.canbeplaced = 1;
    prevcanbeplaced = -1;
    config = level.placeableconfigs[ streakname ];
    placementoffset = ( 0, 0, 0 );
    
    if ( isdefined( config.placementoffsetz ) )
    {
        placementoffset = ( 0, 0, config.placementoffsetz );
    }
    
    carriedobj = self.carriedobj;
    
    while ( true )
    {
        placement = carrier canplayerplacesentry( 1, config.placementradius );
        self.placementorigin = placement[ "origin" ];
        carriedobj.origin = self.placementorigin + placementoffset;
        carriedobj.angles = placement[ "angles" ];
        self.canbeplaced = carrier isonground() && placement[ "result" ] && abs( self.placementorigin[ 2 ] - carrier.origin[ 2 ] ) < config.placementheighttolerance;
        
        if ( isdefined( placement[ "entity" ] ) )
        {
            self.moving_platform = placement[ "entity" ];
        }
        else
        {
            self.moving_platform = undefined;
        }
        
        if ( self.canbeplaced != prevcanbeplaced )
        {
            if ( self.canbeplaced )
            {
                carriedobj setmodel( config.modelplacement );
                carrier forceusehinton( config.placestring );
            }
            else
            {
                carriedobj setmodel( config.modelplacementfailed );
                carrier forceusehinton( config.cannotplacestring );
            }
        }
        
        prevcanbeplaced = self.canbeplaced;
        waitframe();
    }
}

// Namespace placeable
// Params 1
// Checksum 0xb6fda570, Offset: 0xcae
// Size: 0x51
function deactivate( streakname )
{
    self makeunusable();
    hideheadicons();
    config = level.placeableconfigs[ streakname ];
    
    if ( isdefined( config.ondeactivedelegate ) )
    {
        self [[ config.ondeactivedelegate ]]( streakname );
    }
}

// Namespace placeable
// Params 0
// Checksum 0xf1f5be2b, Offset: 0xd07
// Size: 0x12
function hideheadicons()
{
    entityheadicons::setheadicon_deleteicon( self.headiconid );
}

// Namespace placeable
// Params 1
// Checksum 0x5162d0c0, Offset: 0xd21
// Size: 0x59
function handledamage( streakname )
{
    self endon( #"carried" );
    config = level.placeableconfigs[ streakname ];
    damage::monitordamage( config.maxhealth, config.damagefeedback, &handledeathdamage, &modifydamage, 1 );
}

// Namespace placeable
// Params 1
// Checksum 0x7d8c79bb, Offset: 0xd82
// Size: 0x100
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    config = self.config;
    
    if ( config.allowmeleedamage )
    {
        modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    }
    
    if ( config.allowempdamage )
    {
        modifieddamage = damage::handleempdamage( objweapon, type, modifieddamage );
    }
    
    modifieddamage = damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handlegrenadedamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    
    if ( isdefined( config.modifydamage ) )
    {
        modifieddamage = self [[ config.modifydamage ]]( objweapon, type, modifieddamage );
    }
    
    return modifieddamage;
}

// Namespace placeable
// Params 1
// Checksum 0xbc815228, Offset: 0xe8b
// Size: 0xe4
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = self.config;
    notifyattacker = damage::onkillstreakkilled( self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo );
    
    if ( notifyattacker && isdefined( config.ondestroyeddelegate ) )
    {
        self [[ config.ondestroyeddelegate ]]( self.streakname, attacker, self.owner, type );
    }
}

// Namespace placeable
// Params 1
// Checksum 0x2ce7082, Offset: 0xf77
// Size: 0x91
function handledeath( streakname )
{
    self endon( #"carried" );
    self waittill( #"death" );
    config = level.placeableconfigs[ streakname ];
    
    if ( isdefined( self ) )
    {
        deactivate( streakname );
        
        if ( isdefined( config.modeldestroyed ) )
        {
            self setmodel( config.modeldestroyed );
        }
        
        if ( isdefined( config.ondeathdelegate ) )
        {
            self [[ config.ondeathdelegate ]]( streakname );
        }
        
        self delete();
    }
}

// Namespace placeable
// Params 2
// Checksum 0x889942b0, Offset: 0x1010
// Size: 0x69
function oncarrierdeath( streakname, carrier )
{
    self endon( #"placed" );
    self endon( #"death" );
    carrier endon( #"disconnect" );
    carrier waittill( #"death" );
    
    if ( self.canbeplaced )
    {
        thread onplaced( streakname );
        return;
    }
    
    oncancel( streakname );
}

// Namespace placeable
// Params 1
// Checksum 0xd5779513, Offset: 0x1081
// Size: 0x4e
function onkillstreakdisowned( streakname )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    childthread watchownerstatus( "disconnect", streakname );
    childthread watchownerstatus( "joined_team", streakname );
    childthread watchownerstatus( "joined_spectators", streakname );
}

// Namespace placeable
// Params 2
// Checksum 0xce205298, Offset: 0x10d7
// Size: 0x2c
function watchownerstatus( notifymsg, streakname )
{
    self.owner waittill( notifymsg );
    cleanup( streakname );
}

// Namespace placeable
// Params 1
// Checksum 0x8c437103, Offset: 0x110b
// Size: 0x2e
function ongameended( streakname )
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    cleanup( streakname );
}

// Namespace placeable
// Params 1
// Checksum 0xed2eb2be, Offset: 0x1141
// Size: 0x31
function cleanup( streakname )
{
    if ( isdefined( self.isplaced ) )
    {
        self notify( #"death" );
        return;
    }
    
    oncancel( streakname );
}

// Namespace placeable
// Params 0
// Checksum 0xd7dcce6f, Offset: 0x117a
// Size: 0x38
function watchplayerconnected()
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        thread onplayerconnected( player );
    }
}

// Namespace placeable
// Params 1
// Checksum 0x695881d7, Offset: 0x11ba
// Size: 0x3b
function onplayerconnected( owner )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner waittill( #"spawned_player" );
    self disableplayeruse( owner );
}

// Namespace placeable
// Params 1
// Checksum 0x133738ad, Offset: 0x11fd
// Size: 0xc7
function timeout( streakname )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    config = level.placeableconfigs[ streakname ];
    lifespan = config.lifespan;
    
    while ( lifespan > 0 )
    {
        wait 1;
        hostmigration::waittillhostmigrationdone();
        
        if ( !isdefined( self.carriedby ) )
        {
            lifespan -= 1;
        }
    }
    
    if ( isdefined( self.owner ) && isdefined( config.gonevo ) )
    {
        self.owner thread dialog::leaderdialogonplayer( config.gonevo );
    }
    
    self notify( #"death" );
}

// Namespace placeable
// Params 0
// Checksum 0xbc14c5f, Offset: 0x12cc
// Size: 0x29
function removeweapons()
{
    if ( self hasweapon( "iw6_riotshield_mp" ) )
    {
        self.restoreweapon = "iw6_riotshield_mp";
        inventory_utility::_takeweapon( "iw6_riotshield_mp" );
    }
}

// Namespace placeable
// Params 0
// Checksum 0x92b573c6, Offset: 0x12fd
// Size: 0x2f
function removeperks()
{
    if ( isdefined( self.perks[ "specialty_explosivebullets" ] ) )
    {
        self.restoreperk = "specialty_explosivebullets";
        perk::removeperk( "specialty_explosivebullets" );
    }
}

// Namespace placeable
// Params 0
// Checksum 0x1d8ba156, Offset: 0x1334
// Size: 0x29
function restoreweapons()
{
    if ( isdefined( self.restoreweapon ) )
    {
        inventory_utility::_giveweapon( self.restoreweapon );
        self.restoreweapon = undefined;
    }
}

// Namespace placeable
// Params 0
// Checksum 0x9f67f2ec, Offset: 0x1365
// Size: 0x29
function restoreperks()
{
    if ( isdefined( self.restoreperk ) )
    {
        perk::giveperk( self.restoreperk );
        self.restoreperk = undefined;
    }
}

// Namespace placeable
// Params 1
// Checksum 0x7c399d3f, Offset: 0x1396
// Size: 0x39
function showplacedmodel( streakname )
{
    self show();
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( #"update_bombsquad" );
    }
}

// Namespace placeable
// Params 1
// Checksum 0x8810ec2d, Offset: 0x13d7
// Size: 0x2d
function hideplacedmodel( streakname )
{
    self hide();
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel hide();
    }
}

// Namespace placeable
// Params 1
// Checksum 0x28f1a926, Offset: 0x140c
// Size: 0xe7
function createcarriedobject( streakname )
{
    assert( isdefined( self ), "<dev string:x63>" );
    
    if ( self.iscarrying )
    {
        return;
    }
    
    carriedobj = spawnturret( "misc_turret", self.origin + ( 0, 0, 25 ), "sentry_minigun_mp" );
    carriedobj.angles = self.angles;
    carriedobj.owner = self;
    config = level.placeableconfigs[ streakname ];
    carriedobj setmodel( config.modelbase );
    carriedobj maketurretinoperable();
    carriedobj setturretmodechangewait( 1 );
    carriedobj setmode( "sentry_offline" );
    carriedobj makeunusable();
    carriedobj setsentryowner( self );
    carriedobj setsentrycarrier( self );
    carriedobj setcandamage( 0 );
    carriedobj notsolid();
    return carriedobj;
}

