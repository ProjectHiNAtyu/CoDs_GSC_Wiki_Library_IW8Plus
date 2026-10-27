// scripts\mp\common\equipment\spycam.gsc  (hash_748a3d2d777a5f82.gscc) (size: 11433 Bytes / 0x2ca9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x571d2dff (1461530111)
// size ...... 11433 (0x2ca9)
// includes .. 22  (offset: 0x29ad)
// strings ... 37  (offset: 0x2a5d)
// dev strs .. 2   (offset: 0x2c91)
// exports ... 21  (offset: 0x1add)
// cseg ...... 0x350 + 0x178d (0x1add)
// imports ... 101 (offset: 0x1e25)
// animtree1 . 0   (offset: 0x2ca9)
// animtree2 . 0   (offset: 0x2ca9)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace spycam;

// Namespace spycam
// Params 0, eflags: 0x1
// Checksum 0x9743e965, Offset: 0x36e
// Size: 0x96
function autoexec main()
{
    level._effect[ "vfx_spycam_flash" ] = loadfxasset( "vfx_t10_core_equip_spy_camera_flash" );
    level callback::add( #"player_offhand_pullback", &function_a381ba440a9bbc42 );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    weapons::registerusedcallback( "spycam", &spycam_use );
    utility::flag_wait( "equipment_initialized" );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #equipref:"equip_spycam" } );
}

// Namespace spycam
// Params 1
// Checksum 0xf7c6151b, Offset: 0x40c
// Size: 0x31
function function_a381ba440a9bbc42( params )
{
    if ( params.objweapon.basename == "t10_spycam" )
    {
        thread function_d6ee5b0cd0d6f4b0();
    }
}

// Namespace spycam
// Params 0
// Checksum 0x3de88135, Offset: 0x445
// Size: 0x133
function function_d6ee5b0cd0d6f4b0()
{
    self notify( #"hash_ab5892995d19bb65" );
    self endon( #"hash_ab5892995d19bb65" );
    
    while ( true )
    {
        results = utility::waittill_any_ents_return_params( level, "game_ended", self, "death", self, "disconnect", self, "offhand_ads_on" );
        
        if ( results[ "message" ] != "offhand_ads_on" )
        {
            val::set( "spycam", "killstreaks", 1 );
            killstreak_shared::function_b3302c4317df36c6();
            break;
        }
        
        if ( results[ 0 ].basename != "t10_spycam" )
        {
            continue;
        }
        
        val::set( "spycam", "killstreaks", 0 );
        killstreak_shared::function_a402a9f43d6f7512( "spycam_shared" );
        results = utility::waittill_any_ents_return_params( level, "game_ended", self, "death", self, "disconnect", self, "offhand_ads_off" );
        
        if ( results[ "message" ] != "offhand_ads_off" )
        {
            val::set( "spycam", "killstreaks", 1 );
            killstreak_shared::function_b3302c4317df36c6();
            break;
        }
        
        if ( results[ 0 ].basename != "t10_spycam" )
        {
            continue;
        }
        
        val::set( "spycam", "killstreaks", 1 );
        killstreak_shared::function_b3302c4317df36c6();
        break;
    }
}

// Namespace spycam
// Params 1
// Checksum 0xcb64c577, Offset: 0x580
// Size: 0x78
function spycam_use( spycam )
{
    ref = equipment_mp::function_fdc4a655fbde0dec( spycam.weapon_name );
    spycam.tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( !isdefined( spycam.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    spycam.owner thread function_a009d21f93497f9e( spycam );
}

// Namespace spycam
// Params 0
// Checksum 0xf296329d, Offset: 0x600
// Size: 0xe
function spycam_destroy()
{
    thread spycam_delete( 0.05 );
}

// Namespace spycam
// Params 1
// Checksum 0x3144bc79, Offset: 0x616
// Size: 0x26
function spycam_delete( deletiondelay )
{
    self notify( #"death" );
    wait deletiondelay;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace spycam
// Params 1
// Checksum 0xc53ced21, Offset: 0x644
// Size: 0x5f5
function function_a009d21f93497f9e( spycam )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    var_d856775470359410 = self function_375e0d1f1562c608();
    maxdist = spycam.tableinfo.bundle.spycam_max_dist ?? 2000;
    maxtargets = spycam.tableinfo.bundle.var_9a52d78cbec1e48b ?? 5;
    markradius = spycam.tableinfo.bundle.spycam_radius ?? 250;
    markfov = self function_35100ddf92a0ae02();
    var_d4efbcc6b2d1cf28 = 83986;
    contents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    ents = self function_906f4c75be23ff6c( maxdist, markfov, var_d4efbcc6b2d1cf28, 0, contents );
    var_6511a540416498df = level.sharedfuncs[ #"perceptive" ][ #"incrementcount" ];
    targets = [];
    var_39806e7c778189c0 = 0;
    
    foreach ( ent in ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( ent === self || ent === spycam || ent.owner === self )
        {
            continue;
        }
        
        if ( isdefined( ent.spycamdebuff ) )
        {
            continue;
        }
        
        isplayertarget = 0;
        marktarget = 0;
        
        if ( isagent( ent ) || isplayer( ent ) )
        {
            if ( ent hasperk( "specialty_noscopeoutline" ) )
            {
                continue;
            }
            
            marktarget = 1;
            isplayertarget = 1;
            var_39806e7c778189c0 = 1;
            
            if ( isdefined( var_6511a540416498df ) )
            {
                ent [[ var_6511a540416498df ]]( spycam.entnum ?? utility::get_entity_number( spycam ) );
            }
        }
        else if ( isdefined( ent.streakname ) )
        {
            marktarget = 1;
        }
        else
        {
            if ( !isdefined( ent.weapon_name ) )
            {
                continue;
            }
            
            equipmenttype = weapon::getweapontype( ent.weapon_name );
            
            if ( isdefined( equipmenttype ) )
            {
                switch ( equipmenttype )
                {
                    case #"hash_339227cb650975db":
                        bundle = equipment_mp::getEquipmentBundleFromWeaponName( ent.weapon_name );
                        
                        if ( !bundle.var_b0fbb7a8dab17ef7 )
                        {
                            marktarget = 1;
                        }
                        
                        break;
                    case #"hash_850999d7864fa3b4":
                        bundle = equipment_mp::getEquipmentBundleFromWeaponName( ent.weapon_name );
                        
                        if ( !bundle.var_b0fbb7a8dab17ef7 )
                        {
                            marktarget = 1;
                        }
                        
                        break;
                    case #"hash_e534fd8ec73eafb4":
                        bundle = supers_mp::function_5ffd3dfa9cc1e8de( supers_mp::getsuperrefforsuperweapon( ent.weapon_name ) );
                        
                        if ( !bundle.var_b0fbb7a8dab17ef7 )
                        {
                            marktarget = 1;
                        }
                        
                        break;
                    default:
                        break;
                }
            }
        }
        
        if ( marktarget )
        {
            if ( level.teambased )
            {
                if ( self.team == ent.team )
                {
                    continue;
                }
            }
            
            isvisible = spycam spycam_canseetarget( ent, var_d856775470359410, contents );
            isinreticle = function_540ab5d90c03c87a( ent, markfov, markradius );
            
            if ( isvisible && isinreticle )
            {
                targetstruct = spawnstruct();
                targetstruct.ent = ent;
                targetstruct.isplayertarget = isplayertarget;
                playertoenemy = ent.origin - self geteye();
                targetstruct.dist = abs( vectordot( anglestoright( self getplayerangles() ), playertoenemy ) );
                
                if ( targets.size < maxtargets )
                {
                    targets[ targets.size ] = targetstruct;
                    continue;
                }
                
                maxdistance = targetstruct.dist;
                maxdistanceindex = 0;
                marktarget = 0;
                
                for ( i = 0; i < targets.size ; i++ )
                {
                    if ( targets[ i ].dist > maxdistance )
                    {
                        maxdistance = targets[ i ].dist;
                        maxdistanceindex = i;
                        marktarget = 1;
                    }
                }
                
                if ( marktarget )
                {
                    targets[ maxdistanceindex ] = targetstruct;
                }
            }
        }
    }
    
    if ( targets.size == 0 )
    {
        self playlocalsound( spycam.tableinfo.bundle.var_7b2843cc8ca431c9 ?? "eqp_spycam_nomark", undefined, undefined, 1 );
        hud_message::showerrormessage( %"mp/no_valid_targets" );
    }
    else
    {
        playfxontag( utility::getfx( "vfx_spycam_flash" ), spycam, "tag_fx" );
        self playlocalsound( "eqp_spycam_marked", undefined, 1 );
        spycam function_3a4846014eb6a209( targets );
        
        if ( !spycam.tableinfo.bundle.var_d36732d38484e182 )
        {
            ref = spycam.tableinfo.ref;
            currentammo = equipment_mp::getequipmentammo( ref );
            equipment_mp::setequipmentammo( ref, currentammo - 1 );
        }
        
        if ( var_39806e7c778189c0 )
        {
            level thread battlechatter_mp::trysaylocalsound( self, spycam.tableinfo.bundle.var_bed164ed1d9c68a6 );
        }
    }
    
    spycam spycam_destroy();
}

// Namespace spycam
// Params 1, eflags: 0x4
// Checksum 0x68cb6b3e, Offset: 0xc41
// Size: 0x553
function private function_3a4846014eb6a209( targets )
{
    debuffduration = self.tableinfo.bundle.var_b1e6a33329dee0e9 ?? 5;
    outlineduration = self.tableinfo.bundle.var_3a194872ce1dd019 ?? 5;
    var_852df4c54bcc0efa = self.tableinfo.bundle.var_3dcd7ee433d9ea34 ?? 5;
    warningsound = self.tableinfo.bundle.var_e3ebef0e353f448b ?? #"eqp_spycam_marked";
    outlineasset = self.tableinfo.bundle.var_163cce697ff78a56 ?? "spycam";
    var_232456e818f9142d = self.tableinfo.bundle.var_e123d291bd943f71;
    var_c2fcbd1ef18eb7e8 = self.tableinfo.bundle.var_2e5653856d07d0f4;
    var_7ac4550afe2c353 = level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ];
    
    foreach ( target in targets )
    {
        target.ent.spycamdebuff = 1;
        
        if ( level.teambased )
        {
            target.outlineid = outline::outlineenableforteam( target.ent, self.team, outlineasset, "equipment_lesser" );
        }
        else
        {
            target.outlineid = outline::outlineenableforplayer( target.ent, self.owner, outlineasset, "equipment_lesser" );
        }
        
        if ( target.isplayertarget )
        {
            if ( var_232456e818f9142d )
            {
                self.owner thread points::doscoreevent( var_232456e818f9142d, self.weapon_object );
            }
            
            target.ent thread function_59eb180bf9b3693e( debuffduration, self.owner, self.weapon_object );
            target.ent thread function_1464b9d4dd89d753( var_852df4c54bcc0efa );
            target.ent playlocalsound( warningsound, undefined, 1 );
            target.ent.var_7d3f6f02c5ac5df9[ self.owner.team ] = gettime() + outlineduration * 1000;
            self.owner function_1c61beac19953e27( target.ent );
            thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #victim:target.ent, #attacker:self.owner, #grenade:self } );
        }
        else
        {
            if ( var_c2fcbd1ef18eb7e8 )
            {
                self.owner thread points::doscoreevent( var_c2fcbd1ef18eb7e8, self.weapon_object );
            }
            
            target.ent thread function_322963d601ec33f3( debuffduration, self.owner );
        }
        
        target.ent notify( #"spycam_marked", self.owner );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
        {
            if ( isdefined( self.owner.leaderboarddata[ "spycamMarks" ] ) )
            {
                self.owner.leaderboarddata[ "spycamMarks" ] = self.owner.leaderboarddata[ "spycamMarks" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "spycamMarks" ] ) )
            {
                [[ level.leaderboardfunc[ "spycamMarks" ] ]]( self.owner, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x3f>" );
            
            if ( isdefined( self.owner.pers[ "spycamMarks" ] ) )
            {
                self.owner.pers[ "spycamMarks" ] = self.owner.pers[ "spycamMarks" ] + 1;
            }
        }
        
        target.ent thread function_db6df036d59a2848( debuffduration, var_7ac4550afe2c353, target.isplayertarget, self.owner, self );
    }
    
    challenges::function_3d7a169dbae062fb( "equip_spycam", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ), targets.size );
    thread function_8ccefa9d98c2cee0( outlineduration, targets );
}

// Namespace spycam
// Params 2
// Checksum 0x12870db4, Offset: 0x119c
// Size: 0xe1
function function_8ccefa9d98c2cee0( outlineduration, targets )
{
    owner = self.owner;
    owner.spycamoutline = 1;
    wait outlineduration;
    
    foreach ( target in targets )
    {
        if ( isdefined( target.ent ) )
        {
            outline::outlinedisable( target.outlineid, target.ent );
        }
    }
    
    if ( isdefined( owner ) )
    {
        owner.spycamoutline = 0;
    }
}

// Namespace spycam
// Params 5, eflags: 0x4
// Checksum 0xb8cabf62, Offset: 0x1285
// Size: 0xc8
function private function_db6df036d59a2848( debuffduration, var_7ac4550afe2c353, isplayertarget, owner, spycam )
{
    self endon( #"disconnect" );
    result = utility::waittill_notify_or_timeout_return( "spycam_debuff_killed", debuffduration );
    
    if ( result == "timeout" )
    {
        if ( isdefined( owner ) )
        {
            owner function_c97471ab3263d759( self );
        }
        
        if ( !isbrgamemode() || !player::isinlaststand( self ) )
        {
            self notify( #"hash_d9db67dd4cc1069d" );
        }
        
        if ( isplayertarget && isdefined( var_7ac4550afe2c353 ) && isdefined( spycam ) )
        {
            self [[ var_7ac4550afe2c353 ]]( spycam.entnum ?? utility::get_entity_number( spycam ) );
        }
    }
    
    self.spycamdebuff = undefined;
}

// Namespace spycam
// Params 1
// Checksum 0x530c5f96, Offset: 0x1355
// Size: 0x69
function function_1464b9d4dd89d753( var_852df4c54bcc0efa )
{
    self endon( #"disconnect" );
    
    if ( self.spycamdebuff == 1 )
    {
        self function_e14fdd5017e6463f( var_852df4c54bcc0efa );
    }
    
    result = utility::waittill_notify_or_timeout_return( "spycam_debuff_killed", var_852df4c54bcc0efa );
    
    if ( result == "timeout" )
    {
        self notify( #"spycam_enemy_ping_expired" );
    }
    
    self.spycamdebuff = undefined;
}

// Namespace spycam
// Params 3
// Checksum 0x18ea5c3, Offset: 0x13c6
// Size: 0xdc
function function_59eb180bf9b3693e( duration, owner, var_8d27dcedd6cd5de8 )
{
    self endon( #"disconnect" );
    self endon( #"hash_d9db67dd4cc1069d" );
    
    if ( isbrgamemode() )
    {
        self endon( #"laststand_revived" );
    }
    
    thread function_b916058b725ab191( owner );
    victim = self;
    victim.var_2ab6cdec1b1462c9 = var_8d27dcedd6cd5de8;
    self waittill( #"death", attacker );
    
    if ( player_utility::playersareenemies( attacker, victim ) )
    {
        if ( attacker == owner )
        {
            attacker thread gamelogic_mp::threadedsetweaponstatbyname( var_8d27dcedd6cd5de8, 1, "debuff_kills" );
        }
        else
        {
            owner thread points::doscoreevent( #"spycam_target_eliminated", var_8d27dcedd6cd5de8 );
            owner thread gamelogic_mp::threadedsetweaponstatbyname( var_8d27dcedd6cd5de8, 1, "debuff_assists" );
        }
    }
    
    self notify( #"spycam_debuff_killed" );
}

// Namespace spycam
// Params 1
// Checksum 0xc2d48bbe, Offset: 0x14aa
// Size: 0xf3
function function_b916058b725ab191( owner )
{
    self endon( #"disconnect" );
    hud_message::showerrormessage( %"hash_11a2e6520a1e3d23" );
    
    if ( utility::callsharedfunc( #"jamming_system", #"hash_f3a152be2dbc14b9" ) )
    {
        return;
    }
    
    minimapicon = equipment_utility::function_43352e2ff32f9a9c( "equip_spycam" ) ?? "ui_icon_minimap_alarm";
    objectid = objidpoolmanager::requestobjectiveid( 1 );
    objidpoolmanager::objective_add_objective( objectid, "current", self.origin, minimapicon );
    objidpoolmanager::objective_mask_showtoplayerteam( objectid, owner );
    objective_setminimapiconsize( objectid, "icon_small" );
    objective_setbackground( objectid, 1 );
    objective_settint( objectid, 255, 100, 100 );
    function_ac9886e0e2860e18( objectid, 20000, 15000 );
    objective_setplayintro( objectid, 0 );
    utility::waittill_any( "spycam_debuff_killed", "spycam_enemy_ping_expired" );
    objective_state( objectid, "invisible" );
    objective_delete( objectid );
}

// Namespace spycam
// Params 2
// Checksum 0x100c3e2f, Offset: 0x15a5
// Size: 0x85
function function_322963d601ec33f3( duration, owner )
{
    self endon( #"disconnect" );
    self endon( #"hash_d9db67dd4cc1069d" );
    self waittill( #"enemy_destroyed_equipment", attacker );
    
    if ( isdefined( attacker ) && attacker.team == owner.team )
    {
        owner thread points::doscoreevent( #"hash_f0b95bafe4e2d9f0" );
    }
    
    self notify( #"spycam_debuff_killed" );
}

// Namespace spycam
// Params 3
// Checksum 0x370efa1d, Offset: 0x1632
// Size: 0x18d, Type: bool
function spycam_canseetarget( target, var_d856775470359410, contents )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    playerhead = self.owner utility::function_f02ebab438642e16();
    defaultorigin = target.origin;
    tracepoints = [ defaultorigin ];
    
    if ( isplayer( target ) )
    {
        headpos = ( 0, 0, 0 );
        
        if ( player::isreallyalive( target ) )
        {
            headpos = target utility::function_f02ebab438642e16();
        }
        
        centerpos = ( 0, 0, 0 );
        
        if ( player::isreallyalive( target ) )
        {
            centerpos = target utility::function_68061c3d21a6d57a();
        }
        
        tracepoints = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( target ) )
    {
        tracepoints = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    ignorelist = [ self, self.owner, target ];
    
    if ( isdefined( target.colmodel ) )
    {
        ignorelist[ ignorelist.size ] = target.colmodel;
    }
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( playerhead, tracepoints[ i ], ignorelist, contents ) )
        {
            return false;
        }
        
        if ( !var_d856775470359410 && outline::outlineoccluded( playerhead, tracepoints[ i ] ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace spycam
// Params 3
// Checksum 0x12d2949a, Offset: 0x17c8
// Size: 0x14b, Type: bool
function function_540ab5d90c03c87a( scantarget, scanfov, var_aa7184ffa413de37 )
{
    if ( !isdefined( scantarget ) )
    {
        return false;
    }
    
    targetorigin = scantarget.origin;
    scanpoints = [ targetorigin ];
    
    if ( isplayer( scantarget ) )
    {
        headpos = scantarget utility::function_f02ebab438642e16();
        centerpos = scantarget utility::function_68061c3d21a6d57a();
        scanpoints = [ targetorigin, headpos, centerpos ];
    }
    else if ( isagent( scantarget ) )
    {
        centerpos = scantarget agent_utility::function_305eb563bc53733d();
        headpos = scantarget agent_utility::function_fa6ba9e10b560337();
        scanpoints = [ targetorigin + ( 0, 0, 1 ), centerpos, headpos ];
    }
    
    foreach ( point in scanpoints )
    {
        if ( self worldpointinreticle_circle( point, scanfov, var_aa7184ffa413de37 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spycam
// Params 1, eflags: 0x4
// Checksum 0x682908f9, Offset: 0x191c
// Size: 0x73
function private function_1c61beac19953e27( targetplayer )
{
    if ( !isdefined( self.var_d574e0265e4e6d8b[ targetplayer.guid ] ) )
    {
        self.var_d574e0265e4e6d8b[ targetplayer.guid ] = [];
    }
    
    self.var_d574e0265e4e6d8b[ targetplayer.guid ][ self.var_d574e0265e4e6d8b[ targetplayer.guid ].size ] = targetplayer.guid;
}

// Namespace spycam
// Params 1, eflags: 0x4
// Checksum 0x4eaf0316, Offset: 0x1997
// Size: 0x6b
function private function_c97471ab3263d759( targetplayer )
{
    if ( !isplayerdebuffed( targetplayer ) )
    {
        return;
    }
    
    self.var_d574e0265e4e6d8b[ targetplayer.guid ][ 0 ] = undefined;
    function_cdc669dbc8ea2101( self.var_d574e0265e4e6d8b[ targetplayer.guid ] );
    
    if ( !isplayerdebuffed( targetplayer ) )
    {
        self.var_d574e0265e4e6d8b[ targetplayer.guid ] = undefined;
    }
}

// Namespace spycam
// Params 1, eflags: 0x4
// Checksum 0xda3dff78, Offset: 0x1a0a
// Size: 0x24, Type: bool
function private isplayerdebuffed( targetplayer )
{
    return self.var_d574e0265e4e6d8b[ targetplayer.guid ].size > 0;
}

// Namespace spycam
// Params 1, eflags: 0x4
// Checksum 0x14e22480, Offset: 0x1a37
// Size: 0xa6
function private onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    spycamweapon = victim.var_2ab6cdec1b1462c9;
    victim.var_2ab6cdec1b1462c9 = undefined;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( isdefined( spycamweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( spycamweapon, 1, "killed_while_debuffed_by", undefined, attacker );
    }
    
    if ( !attacker isplayerdebuffed( victim ) )
    {
        return;
    }
    
    attacker.var_7dfa8e416c7d2d06 = 1;
    attacker function_c97471ab3263d759( victim );
}

