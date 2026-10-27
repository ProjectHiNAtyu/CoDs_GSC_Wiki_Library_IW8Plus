// scripts\mp\common\equipment\fulton.gsc  (hash_493b50b7b643c1cb.gscc) (size: 9550 Bytes / 0x254e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3abeebd (3819695805)
// size ...... 9550 (0x254e)
// includes .. 14  (offset: 0x2266)
// strings ... 38  (offset: 0x22d6)
// dev strs .. 0   (offset: 0x2512)
// exports ... 28  (offset: 0x13a6)
// cseg ...... 0x3b4 + 0xff2 (0x13a6)
// imports ... 88  (offset: 0x1806)
// animtree1 . 1   (offset: 0x2512)
// animtree2 . 3   (offset: 0x251e)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\parachute;
#using scripts\mp\supers;

#namespace fulton;

// Namespace fulton
// Params 0
// Checksum 0xa773e30, Offset: 0x3d2
// Size: 0x9c
function fulton_init()
{
    fulton_initrepository();
    game[ "dialog" ][ "plunder_extract_fail_fulton" ] = "pxff_wzan_plnd";
    level._effect[ "vfx_fulton_explode" ] = loadfxasset( "vfx_iw8_br_gameplay_money_fulton_destr" );
    
    /#
        setdevdvarifuninitialized( @"hash_480475a0dec18661", 1 );
        setdevdvarifuninitialized( @"hash_491b43c08b40fe8c", 1 );
        setdevdvarifuninitialized( @"scr_fultonusetime", 0.75 );
        setdevdvarifuninitialized( @"scr_fultonuseamount", 250 );
        setdevdvarifuninitialized( @"scr_fultoncapacity", 1500 );
        setdevdvarifuninitialized( @"scr_fultoncountdown", 20 );
    #/
}

#using_animtree( "script_model" );

// Namespace fulton
// Params 0
// Checksum 0x87942f4, Offset: 0x476
// Size: 0x71
function fulton_initanims()
{
    level.scr_animtree[ "fulton" ] = #animtree;
    level.scr_anim[ "fulton" ][ "fulton_open" ] = %wm_skyhook_ground_open;
    level.scr_anim[ "fulton" ][ "fulton_open_idle" ] = %wm_skyhook_ground_idle_open;
    level.scr_anim[ "fulton" ][ "fulton_takeoff" ] = %wm_skyhook_ground_takeoff;
}

// Namespace fulton
// Params 0
// Checksum 0x2585031e, Offset: 0x4ef
// Size: 0x1b2
function fulton_initrepository()
{
    leveldataforrepository = br_plunder::plunder_getleveldataforrepository( "equip_mp_fulton", 1 );
    leveldataforrepository.type = 0;
    leveldataforrepository.usetime = getdvarfloat( @"scr_fultonusetime", 0.75 );
    leveldataforrepository.useeventtype = 2;
    leveldataforrepository.useeventamount = getdvarint( @"scr_fultonuseamount", 250 );
    leveldataforrepository.teamuseonly = 1;
    leveldataforrepository.teamanchoredwidget = 1;
    leveldataforrepository.usefailcapacitymsg = %"mp/cannot_deposit_cash_balloon_full";
    leveldataforrepository.usefailextractingmsg = %"mp/cannot_deposit_cash_balloon_leaving";
    leveldataforrepository.scriptableusepart = "fulton_use_cache";
    leveldataforrepository.scriptableusestate = "usable";
    leveldataforrepository.scriptablenousestate = "unusable";
    leveldataforrepository.extractcountdown = getdvarint( @"scr_fultoncountdown", 20 );
    leveldataforrepository.extractcountdownmsg = %"mp/cash_balloon_leaving_in_n";
    leveldataforrepository.capacity = getdvarint( @"scr_fultoncapacity", 1500 );
    leveldataforrepository.countdownendcallback = &fulton_repositorycountdownendcallback;
    leveldataforrepository.extractcallback = &fulton_repositoryextractcallback;
    leveldataforrepository.atcapacitycallback = &fulton_repositoryatcapacitycallback;
    leveldataforrepository.extractionmethod = "fulton";
    leveldataforrepository.dropplunder = getdvarint( @"hash_491b43c08b40fe8c", 1 ) > 0;
    leveldataforrepository.cantakedamage = getdvarint( @"hash_480475a0dec18661", 1 ) > 0;
}

// Namespace fulton
// Params 1
// Checksum 0x184a3e8b, Offset: 0x6a9
// Size: 0xda
function fulton_create( grenade )
{
    fulton = spawn( "script_model", grenade.origin );
    fulton setautoboxcalculationusingdobj( 1 );
    var_1ee733f09e84db4e = fulton_getmodel();
    fulton setmodel( var_1ee733f09e84db4e );
    fulton.angles = grenade.angles;
    fulton.owner = self;
    fulton.team = self.team;
    
    if ( isdefined( grenade.moving_platform ) )
    {
        fulton.moving_platform = grenade.moving_platform;
    }
    
    fulton.animname = "fulton";
    fulton animation::setanimtree();
    self.fulton = fulton;
    fulton thread fulton_planted();
}

// Namespace fulton
// Params 1
// Checksum 0xd60fc5d6, Offset: 0x78b
// Size: 0xa1
function fulton_destroy( damagedata )
{
    leveldataforrepository = br_plunder::plunder_getleveldataforrepository( "equip_mp_fulton" );
    thread br::teamsplashbr( "br_fulton_balloon_shot_down", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    br_plunder::entityplunderlosealldeposited( leveldataforrepository.dropplunder );
    playfx( utility::getfx( "vfx_fulton_explode" ), self.origin, anglestoforward( self.angles ) );
    playsoundatpos( self.origin, "br_fulton_extract_exp" );
    function_d6cfdd18fb0a2453( self );
    thread fulton_deletenextframe();
}

// Namespace fulton
// Params 0
// Checksum 0x1a4af14a, Offset: 0x834
// Size: 0xa3
function fulton_deletenextframe()
{
    self notify( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner.fulton = undefined;
    }
    
    self hide();
    damage::monitordamageend();
    self setscriptablepartstate( "fulton_use_cache", "unusable", 0 );
    self setscriptablepartstate( "fulton_use_extract", "unusable", 0 );
    self setscriptablepartstate( "effects", "neutral", 0 );
    br_plunder::plunder_deregisterrepositoryinstance( self );
    self stopanimscripted();
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
    }
    
    waitframe();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace fulton
// Params 1
// Checksum 0xfe9b2694, Offset: 0x8df
// Size: 0x1cc
function fulton_used( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    fultonmodel = fulton_getmodel();
    self prestreamasset( "model", fultonmodel, 0 );
    thread function_66d390986d8b3da0( grenade );
    grenade waittill( #"missile_stuck", stuckto );
    
    if ( !isalive( self ) )
    {
        if ( isdefined( grenade ) )
        {
            grenade delete();
        }
        
        self prestreamclear( "model" );
        return;
    }
    
    if ( isdefined( stuckto ) )
    {
        if ( getdvarint( @"hash_269506ff08a558cd", 1 ) == 1 )
        {
            fulton_check_for_moving_platform( grenade, stuckto );
        }
        
        if ( !isdefined( grenade.moving_platform ) )
        {
            self playlocalsound( "fly_pickup_deny" );
            hud_message::showerrormessage( %"mp/cash_balloon_cannot_place" );
            
            if ( isdefined( self.super ) )
            {
                fulton_refundsuper();
            }
            
            grenade delete();
            return;
        }
    }
    
    if ( !fulton_cancreate( grenade ) )
    {
        self playlocalsound( "fly_pickup_deny" );
        hud_message::showerrormessage( %"mp/cash_balloon_blocked" );
        
        if ( isdefined( self.super ) )
        {
            fulton_refundsuper();
        }
        
        grenade delete();
        return;
    }
    else if ( 1 && isdefined( self.fulton ) )
    {
        self playlocalsound( "fly_pickup_deny" );
        hud_message::showerrormessage( %"mp/cash_balloon_too_many" );
        
        if ( isdefined( self.super ) )
        {
            fulton_refundsuper();
        }
        
        grenade delete();
        return;
    }
    
    if ( isdefined( self.super ) )
    {
        supers_mp::superusefinished( undefined, undefined, undefined, 1 );
    }
    
    thread fulton_create( grenade );
    self prestreamclear( "model" );
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace fulton
// Params 2
// Checksum 0x2137f245, Offset: 0xab3
// Size: 0x8e
function fulton_check_for_moving_platform( grenade, stuckto )
{
    if ( isdefined( stuckto.linked_brush ) )
    {
        if ( isdefined( stuckto.linked_brush.targetname ) )
        {
            if ( stuckto.linked_brush.targetname == "train_wz" )
            {
                grenade.moving_platform = stuckto;
            }
        }
        
        return;
    }
    
    if ( stuckto.targetname == "train_wz" )
    {
        grenade.moving_platform = stuckto;
    }
}

// Namespace fulton
// Params 0
// Checksum 0x145d1cca, Offset: 0xb49
// Size: 0x1ad
function fulton_planted()
{
    self endon( #"death" );
    self endon( #"start_extract" );
    playsoundatpos( self.origin, "iw9_extraction_balloon_drop" );
    thread br::teamsplashbr( "br_fulton_device_placed", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    players = teams::getfriendlyplayers( self.team );
    br_plunder::plunder_registerrepositoryinstance( self, "equip_mp_fulton" );
    thread br_plunder::plunder_repositorywatchcountdown( self, players );
    br_plunder::plunder_updateanchoredwidgetforplayers( self, players );
    fulton_trigger = spawn( "trigger_radius", self.origin, 0, 128, 128 );
    self.fulton_trigger = fulton_trigger;
    fulton_trigger.fulton = self;
    trigger::makeenterexittrigger( fulton_trigger, &function_eecaf90e73ca1e5e, &function_fbdc36cad50c4f08 );
    scenenode = spawn( "script_model", self.origin );
    scenenode setmodel( "tag_origin" );
    scenenode.angles = self.angles * ( 0, 1, 0 );
    scenenode.fulton = self;
    self.scenenode = scenenode;
    
    if ( isdefined( self.moving_platform ) )
    {
        self linkto( self.moving_platform );
        scenenode linkto( self.moving_platform );
    }
    
    fulton_open();
    leveldataforrepository = br_plunder::plunder_getleveldataforrepository( "equip_mp_fulton", 1 );
    
    if ( leveldataforrepository.cantakedamage )
    {
        thread damage::monitordamage( 300, "", &fulton_handlefataldamage, &fulton_handledamage );
    }
}

// Namespace fulton
// Params 0
// Checksum 0x9a1941d0, Offset: 0xcfe
// Size: 0x37
function fulton_open()
{
    self setscriptablepartstate( "effects", "fillUp", 0 );
    self.scenenode animation::anim_single_solo( self, "fulton_open" );
    childthread fulton_openidle_sfx();
    childthread fulton_openidle();
}

// Namespace fulton
// Params 0
// Checksum 0x3e9db569, Offset: 0xd3d
// Size: 0x20
function fulton_openidle()
{
    while ( true )
    {
        self.scenenode animation::anim_single_solo( self, "fulton_open_idle" );
    }
}

// Namespace fulton
// Params 0
// Checksum 0x332116e, Offset: 0xd65
// Size: 0x4b
function fulton_openidle_sfx()
{
    self endon( #"death" );
    fulton_idle_lp = "iw9_extraction_balloon_idle_lp";
    utility::play_loop_sound_on_entity( fulton_idle_lp, ( 0, 0, 72 ) );
    self waittill( #"fulton_takeoff" );
    utility::stop_loop_sound_on_entity( fulton_idle_lp );
}

// Namespace fulton
// Params 1
// Checksum 0xb1838b9c, Offset: 0xdb8
// Size: 0xd8
function fulton_handledamage( damagedata )
{
    damage = damagedata.damage;
    
    if ( !player_utility::playersareenemies( damagedata.attacker, self.owner ) )
    {
        damage = 0;
    }
    else
    {
        damage = damage::handleshotgundamage( damagedata.objweapon, damagedata.meansofdeath, damagedata.damage );
        
        if ( damagedata.meansofdeath == "MOD_MELEE" )
        {
            damage = int( ceil( self.maxhealth / 6 ) );
        }
        else if ( isexplosivedamagemod( damagedata.meansofdeath ) )
        {
            if ( damagedata.damage >= 50 )
            {
                damage = int( ceil( self.maxhealth / 1 ) );
            }
        }
    }
    
    return damage;
}

// Namespace fulton
// Params 1
// Checksum 0x9763fafd, Offset: 0xe99
// Size: 0x15
function fulton_handlefataldamage( damagedata )
{
    thread fulton_destroy( damagedata );
}

// Namespace fulton
// Params 3
// Checksum 0x9e095d6f, Offset: 0xeb6
// Size: 0x4c
function fulton_repositoryusecallback( entity, player, amount )
{
    leveldataforrepository = br_plunder::plunder_getleveldataforrepository( "equip_mp_fulton" );
    player thread br_plunder::playerplunderevent( amount, leveldataforrepository.useeventtype, entity );
}

// Namespace fulton
// Params 2
// Checksum 0x3764222c, Offset: 0xf0a
// Size: 0x4b
function fulton_repositorycountdownendcallback( entity, fromtimeout )
{
    if ( isdefined( entity.owner ) )
    {
        entity.owner.fulton = undefined;
    }
    
    function_d6cfdd18fb0a2453( entity );
    br_plunder::plunder_repositoryextract( entity );
}

// Namespace fulton
// Params 1
// Checksum 0x2bc0010a, Offset: 0xf5d
// Size: 0xa1
function fulton_repositoryextractcallback( entity )
{
    entity endon( #"death" );
    leveldataforrepository = br_plunder::plunder_getleveldataforrepository( "equip_mp_fulton" );
    entity damage::monitordamageend();
    data = br_plunder::entityplunderbankalldeposited();
    thread br::teamsplashbr( "br_fulton_balloon_successfully_away", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    self notify( #"fulton_takeoff" );
    self playsoundonmovingent( "iw9_extraction_balloon_takeoff" );
    self.scenenode animation::anim_single_solo( self, "fulton_takeoff" );
    thread fulton_deletenextframe();
}

// Namespace fulton
// Params 1
// Checksum 0xc495afa2, Offset: 0x1006
// Size: 0x34
function fulton_repositoryatcapacitycallback( entity )
{
    thread br::teamsplashbr( "br_fulton_balloon_full", entity.owner, entity.team, undefined, "splash_list_br_plunder_iw9_mp" );
}

// Namespace fulton
// Params 2
// Checksum 0x92dfd45e, Offset: 0x1042
// Size: 0x6b
function function_eecaf90e73ca1e5e( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        entity = trigger.fulton;
        br_plunder::plunder_updaterepositorywidgetforplayer( ent, entity.plunderinstanceid, 0, 1, entity.plundercountdownendtime, entity.plundertotal );
        br_plunder::plunder_sendrepositorywidgetomnvar( ent );
    }
}

// Namespace fulton
// Params 2
// Checksum 0xab1224a9, Offset: 0x10b5
// Size: 0x27
function function_fbdc36cad50c4f08( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        br_plunder::plunder_clearrepositorywidgetforplayer( ent );
    }
}

// Namespace fulton
// Params 1
// Checksum 0x2a2ffe5, Offset: 0x10e4
// Size: 0xbc, Type: bool
function fulton_cancreate( grenade )
{
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return true;
    }
    
    var_ac4b2840d73fab5a = 25;
    planeflyheight = parachute::getc130height();
    start = grenade.origin + ( 0, 0, var_ac4b2840d73fab5a + 1 );
    end = ( grenade.origin[ 0 ], grenade.origin[ 1 ], planeflyheight );
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trc = trace::sphere_trace( start, end, var_ac4b2840d73fab5a, grenade, contents );
    return trc[ "fraction" ] == 1;
}

// Namespace fulton
// Params 0
// Checksum 0x369100aa, Offset: 0x11a9
// Size: 0x51
function fulton_refundsuper()
{
    self notify( #"super_use_finished_lb" );
    self notify( #"super_use_finished" );
    superinfo = supers_mp::getcurrentsuper();
    supers_mp::setsuperisinuse( 0 );
    supers_mp::setsuperexpended( 0 );
    superinfo.wasrefunded = 1;
    supers_mp::refundsuper();
}

// Namespace fulton
// Params 0
// Checksum 0x802b6fef, Offset: 0x1202
// Size: 0x1e
function fulton_refundsuperammo()
{
    if ( equipment_mp::hasequipment( "equip_extract" ) )
    {
        equipment_mp::incrementequipmentammo( "equip_extract", 1 );
    }
}

// Namespace fulton
// Params 0
// Checksum 0xa82781ac, Offset: 0x1228
// Size: 0x28
function fulton_getmodel()
{
    var_1ee733f09e84db4e = "military_skyhook_far_mp";
    
    if ( level.var_c13e18e90aee7c5c )
    {
        var_1ee733f09e84db4e = "military_skyhook_far_plunder";
    }
    
    return var_1ee733f09e84db4e;
}

// Namespace fulton
// Params 1
// Checksum 0x680693d1, Offset: 0x1259
// Size: 0x5b
function function_66d390986d8b3da0( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"missile_stuck" );
    grenade waittill( #"death" );
    self prestreamclear( "model" );
    
    if ( isalive( self ) && isdefined( self.super ) )
    {
        fulton_refundsuper();
    }
}

// Namespace fulton
// Params 0
// Checksum 0xe627eafa, Offset: 0x12bc
// Size: 0x4
function function_6cdbcf6ccef161a9()
{
    return 128;
}

// Namespace fulton
// Params 1
// Checksum 0x247e1eca, Offset: 0x12c9
// Size: 0xdd
function function_d6cfdd18fb0a2453( ent )
{
    if ( ent.fulton_trigger )
    {
        radius = function_6cdbcf6ccef161a9();
        players = getplayersinradius( ent.fulton_trigger.origin, radius, radius );
        
        foreach ( player in players )
        {
            function_fbdc36cad50c4f08( player, ent.fulton_trigger );
        }
        
        ent.fulton_trigger delete();
    }
}

