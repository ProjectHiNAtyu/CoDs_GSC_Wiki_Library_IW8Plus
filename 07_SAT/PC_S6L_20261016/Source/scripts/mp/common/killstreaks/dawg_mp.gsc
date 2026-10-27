// scripts\mp\common\killstreaks\dawg_mp.gsc  (hash_6dcf9f54cbf3594f.gscc) (size: 20227 Bytes / 0x4f03 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39fce32 (60804658)
// size ...... 20227 (0x4f03)
// includes .. 25  (offset: 0x4af7)
// strings ... 52  (offset: 0x4bbf)
// dev strs .. 0   (offset: 0x4f03)
// exports ... 47  (offset: 0x2dcf)
// cseg ...... 0x3d6 + 0x29f9 (0x2dcf)
// imports ... 184 (offset: 0x3527)
// animtree1 . 0   (offset: 0x4f03)
// animtree2 . 0   (offset: 0x4f03)
#using script_13865ca76df87ea;
#using script_16555c1140262e45;
#using script_16ea1b94f0f381b3;
#using script_3865eabfc59f0765;
#using script_61b40095fd0502f0;
#using scripts\asm\asm;
#using scripts\common\active_env\moving_platforms;
#using scripts\common\callbacks;
#using scripts\common\inplaylimits;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\scripted_widgets;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;

#namespace dawg_mp;

// Namespace dawg_mp
// Params 0, eflags: 0x1
// Checksum 0xb2240df9, Offset: 0x3f4
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"dawg", &init );
}

// Namespace dawg_mp
// Params 0, eflags: 0x4
// Checksum 0xd884a1b, Offset: 0x413
// Size: 0xde
function private init()
{
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    turretweaponname = bundle.var_6d133d06db83adf1 ?? "sat_dawg_turret";
    missileturretweaponname = bundle.var_29bd0ff3ab031c0f ?? "sat_dawg_missile_turret";
    
    if ( !isdefined( turretweaponname ) || !isdefined( missileturretweaponname ) || !isdefined( bundle ) )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "dawg", &function_59c61a62c20441d6 );
    killstreaks::registerkillstreakdamagedealingweapon( "dawg", turretweaponname, #"low" );
    killstreaks::registerkillstreakdamagedealingweapon( "dawg", missileturretweaponname, #"large" );
    utility::registersharedfunc( #"dawg", #"hack", &dawg_hack );
    level thread function_629218cb9d3e5292();
}

// Namespace dawg_mp
// Params 1
// Checksum 0x49d85156, Offset: 0x4f9
// Size: 0x2d9, Type: bool
function function_59c61a62c20441d6( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    streakinfo.streakduration = getscriptbundlefieldvalue( hashcat( %"dawgaisettings:", bundle.var_faafbd977112553b ), #"dawglifetime" );
    
    if ( utility::issharedfuncdefined( #"dawg", #"hash_28d193e27816d942" ) )
    {
        self thread [[ utility::getsharedfunc( #"dawg", #"hash_28d193e27816d942" ) ]]( streakinfo );
    }
    
    deployweapon = makeweapon( bundle.deployweaponname );
    
    if ( level.gametypebundle.var_711e33239e4c9925 && isplayer( self ) )
    {
        if ( !callback::exists( #"killstreak_cancel", &deploy_cancel ) )
        {
            callback::add( #"killstreak_cancel", &deploy_cancel );
        }
    }
    
    deployresult = dawg_deploy_weapon( streakinfo, deployweapon );
    
    if ( self.var_c8d50b6b9dff4afd )
    {
        self.var_c8d50b6b9dff4afd.deployresult = istrue( deployresult );
    }
    
    if ( level.gametypebundle.var_711e33239e4c9925 && isplayer( self ) )
    {
        if ( callback::exists( #"killstreak_cancel", &deploy_cancel ) )
        {
            callback::remove( #"killstreak_cancel", &deploy_cancel );
        }
    }
    
    if ( !deployresult || !self.var_5aef88060ea2e2c1 )
    {
        return false;
    }
    
    function_27040db8fead20f8( streakinfo );
    self.var_e73f627a785541a2[ "dawg" ] = 0;
    function_3d19b1ee82082e8d( self.var_5aef88060ea2e2c1, streakinfo );
    function_d85e6a2236d6e603( self, self.var_5aef88060ea2e2c1, self.angles, streakinfo );
    used_splash_ref = bundle.usedsplashref;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "dawg" + "_use", #"use", 1, var_65934120c2efeb81 );
    self setclientomnvar( level.streakglobals.inboundomnvars[ streakinfo.var_9384480e6997afd7 ], 1 );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    return true;
}

// Namespace dawg_mp
// Params 1, eflags: 0x4
// Checksum 0x2581072c, Offset: 0x7db
// Size: 0x18
function private deploy_cancel( params )
{
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace dawg_mp
// Params 2
// Checksum 0xe06a3485, Offset: 0x7fb
// Size: 0xac
function dawg_deploy_weapon( streakinfo, weaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !killstreakdeploy::candeploykillstreak( streakinfo, weaponobj ) )
    {
        return 0;
    }
    
    killstreakdeploy::ondeploystart( streakinfo );
    switchresult = killstreakdeploy::switchtodeployweapon( weaponobj, streakinfo, &killstreakdeploy::waituntilfinishedwithdeployweapon );
    
    if ( !switchresult )
    {
        killstreakdeploy::ondeployfinished( streakinfo );
        return 0;
    }
    
    val::set( "firedDeploy", "offhand_weapons", 0 );
    var_7db58a039d278180 = function_c42642024bfdccb9( streakinfo, weaponobj );
    val::reset_all( "firedDeploy" );
    killstreakdeploy::ondeployfinished( streakinfo );
    return var_7db58a039d278180;
}

// Namespace dawg_mp
// Params 0, eflags: 0x4
// Checksum 0x92e8e6b7, Offset: 0x8b0
// Size: 0xd9
function private function_629218cb9d3e5292()
{
    waitframe();
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    leveldata = airdrop::getleveldata( "dawg" );
    leveldata.var_a077b56baf606492 = &function_7683a088d491977a;
    leveldata.activatecallback = &oncrateactivated;
    leveldata.destroycallback = &oncratedestroyed;
    leveldata.var_8dea9376fe45b5dc = &function_69887acccb88a4ea;
    leveldata.minimapicon = "ui_map_icon_jugg_drop";
    
    if ( bundle.var_bb9d1681f0b75066 )
    {
        leveldata.minimapicon = "ui_shared_transparent";
    }
    
    leveldata.headicon = "ui_map_icon_jugg_drop";
    leveldata.basemodel = bundle.var_63b3db46ad407a17;
}

// Namespace dawg_mp
// Params 1, eflags: 0x4
// Checksum 0xcc29f7c7, Offset: 0x991
// Size: 0x50, Type: bool
function private function_27040db8fead20f8( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dawg_mp
// Params 1, eflags: 0x4
// Checksum 0xfb1b71f7, Offset: 0x9ea
// Size: 0x16b
function private function_7683a088d491977a( streakinfo )
{
    crate = self;
    player = crate.owner;
    bundle = streakinfo.bundle;
    crate.var_25ea9d29adb026a7 = 1;
    var_241ddd6783f0d203 = crate gettagorigin( "tag_dawg_attach" );
    waitframe();
    crate.dawg = player spawn_dawg( var_241ddd6783f0d203, crate gettagangles( "tag_dawg_attach" ), streakinfo );
    
    if ( bundle.var_bb9d1681f0b75066 && getdvarint( @"hash_ebe5848ab1d80847", 0 ) != 1 )
    {
        crate.var_5f8ae329b421d7d1 = crate objidpoolmanager::createobjective( "ui_map_icon_jugg_drop", player.team, 0, 1, 0 );
    }
    
    if ( crate.dawg )
    {
        crate.dawg motionwarpcancel();
        crate.dawg linktomoveoffset( crate, "tag_dawg_attach", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        crate.dawg.mode = "inactive";
        crate.dawg.crate = self;
        player function_f64aac5efed6f34e( crate.dawg, streakinfo );
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x45d120, Offset: 0xb5d
// Size: 0x1e3
function oncrateactivated( firstactivation )
{
    player = self.owner;
    dawg = self.dawg;
    bundle = self.streakinfo.bundle;
    utility::function_32b24db3127bff40( "open_animation", "open_animation" );
    self.platform = spawn( "script_model", self.origin );
    self.platform.angles = self.angles;
    self.platform setmodel( bundle.var_c26d82008ba60f6e );
    self.platform linkto( self );
    self.platform.var_ce8cb07fc75576b1 = 1;
    delete_self = 0;
    
    if ( self function_3d815cf843fd788e() )
    {
        thread airdrop::deletecrate( 10 );
    }
    else
    {
        delete_self = 1;
    }
    
    thread utility::delete_on_death( self.platform );
    
    if ( self.var_5f8ae329b421d7d1 )
    {
        utility::callsharedfunc( #"game", #"returnobjectiveid", self.var_5f8ae329b421d7d1 );
        self.var_5f8ae329b421d7d1 = undefined;
    }
    
    function_f8c991bad208394f( self.streakinfo );
    
    if ( isalive( dawg ) )
    {
        dawg motionwarpcancel();
        dawg unlink();
        dawg.origin += ( 0, 0, 5 );
        player function_3ac91fded8cfe302();
        waitframe();
        player thread dawg_emp_watcher( dawg );
        dawg function_5fb9cbb29986580b();
    }
    
    if ( isplayer( player ) )
    {
        player thread function_a6f8b8ca5c8cbcc7( self.streakinfo.var_9384480e6997afd7 );
    }
    
    if ( delete_self )
    {
        wait 10;
        
        if ( self )
        {
            self delete();
        }
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x5ae4dcb2, Offset: 0xd48
// Size: 0x70
function oncratedestroyed( immediate )
{
    function_f8c991bad208394f( self.streakinfo );
    
    if ( self.var_5f8ae329b421d7d1 )
    {
        utility::callsharedfunc( #"game", #"returnobjectiveid", self.var_5f8ae329b421d7d1 );
        self.var_5f8ae329b421d7d1 = undefined;
    }
    
    if ( self.dawg )
    {
        self.dawg dawg::dawg_self_destruct();
    }
}

// Namespace dawg_mp
// Params 1, eflags: 0x4
// Checksum 0x99acb46e, Offset: 0xdc0
// Size: 0x32
function private function_a6f8b8ca5c8cbcc7( slotnumber )
{
    killstreaks::function_9319ff2b1b5a6418( slotnumber );
    self setclientomnvar( level.streakglobals.inboundomnvars[ slotnumber ], 0 );
}

// Namespace dawg_mp
// Params 1, eflags: 0x4
// Checksum 0xa7e75ab9, Offset: 0xdfa
// Size: 0x2d
function private function_69887acccb88a4ea( position )
{
    navmeshposition = getclosestpointonnavmesh( position, undefined, undefined, undefined, 0 );
    
    if ( isdefined( navmeshposition ) )
    {
        return navmeshposition;
    }
    
    return position;
}

// Namespace dawg_mp
// Params 3
// Checksum 0x8f2a2b1e, Offset: 0xe30
// Size: 0x2be
function spawn_dawg( origin, angles, streakinfo )
{
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    aitype = self.team == "axis" ? bundle.var_c5f8c45ec36501a8 ?? "sat_dawg_guild" : bundle.dawgaitype ?? "sat_dawg";
    
    if ( !level.var_de0074d9320cc42f[ aitype ] )
    {
        level.var_de0074d9320cc42f[ aitype ] = getscriptbundle( "dawgaisettings:" + bundle.var_faafbd977112553b );
    }
    
    dawg = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, origin, angles, self.team );
    
    foreach ( model_override in bundle.var_5aec7880d7929a2b )
    {
        if ( getdvarint( model_override.dvarstring, 0 ) )
        {
            bodymodel = self.team == "axis" ? model_override.var_8d0dc806be6d38f3 : model_override.var_eb250933f526c710;
            
            if ( bodymodel )
            {
                dawg setmodel( bodymodel );
            }
            
            break;
        }
    }
    
    if ( dawg )
    {
        dawg dawg::dawgpostinit( self, undefined, streakinfo );
        dawg utility::callsharedfunc( #"dawg", #"hash_70fa1fdad51f3de7" );
        
        if ( dawg utility::issharedfuncdefined( #"dawg", #"spawn_dawg" ) )
        {
            dawg utility::callsharedfunc( #"dawg", #"spawn_dawg" );
        }
    }
    
    if ( streakinfo.mpstreaksysteminfo.blueprintindex > 0 )
    {
        turretmodelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex ), #"xmodel", "turretModel" );
        dawg.turret setmodel( turretmodelname );
        bodymodelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex ), #"xmodel", "bodyModel" );
        dawg setmodel( bodymodelname );
    }
    
    return dawg;
}

// Namespace dawg_mp
// Params 2
// Checksum 0xcddc4eea, Offset: 0x10f7
// Size: 0x1cd
function function_f64aac5efed6f34e( dawg, streakinfo )
{
    if ( self.dawglist.size && self.dawglist.size + 1 > inplaylimits::get_limit_per_player( streakinfo.bundle ) )
    {
        self.dawglist[ 0 ] dawg::dawg_self_destruct();
        self.dawglist = function_5713d46873b29625( self.dawglist );
    }
    
    if ( !isdefined( self.dawglist ) )
    {
        self.dawglist = [];
    }
    
    self.dawglist[ self.dawglist.size ] = dawg;
    dawg.streakinfo = streakinfo;
    dawg.turret.streakinfo = streakinfo;
    
    if ( isplayer( streakinfo.owner ) )
    {
        if ( !callback::exists( "onPlayerSpawn", &on_player_respawn ) )
        {
            callback::add( "onPlayerSpawn", &on_player_respawn );
        }
        
        thread function_a9a336616cf4cceb( dawg );
        dawg thread dawg_watchgameended( streakinfo.owner, streakinfo );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        dawg [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( "dawg", "Killstreak_Ground", self, 0, 1 );
    }
    
    self.dangerzone = namespace_9d8e359c3b1041e5::addspawninfluencersharedfunc( #"killstreak_dawg", self.origin, self.team, self.owner, self );
    dawg utility::ent_flag_set( "turned" );
    dawg.var_30656af96b2ac2a4 = [];
    dawg.add_buff = &add_buff;
    dawg.remove_buff = &remove_buff;
}

// Namespace dawg_mp
// Params 2, eflags: 0x4
// Checksum 0x48f4313b, Offset: 0x12cc
// Size: 0x91
function private dawg_watchgameended( owner, streakinfo )
{
    owner endon( #"disconnect" );
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( isplayer( owner ) && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            owner [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
    
    wait 1;
    
    if ( self )
    {
        dawg::dawg_self_destruct();
    }
}

// Namespace dawg_mp
// Params 2
// Checksum 0x7a97d609, Offset: 0x1365
// Size: 0x96
function dawg_hack( hackeffect, attacker )
{
    if ( hackeffect.var_bdd964bba0312052 )
    {
        if ( isplayer( self.owner ) )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"disrupted_hacked" );
        }
        
        thread dawg_disrupt( hackeffect, attacker );
        return;
    }
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed_hacked" );
    }
}

// Namespace dawg_mp
// Params 2
// Checksum 0xb2d137e3, Offset: 0x1403
// Size: 0x75
function dawg_disrupt( hackeffect, attacker )
{
    self endon( #"death" );
    data = { #attacker:attacker, #reason:"hacked" };
    dawg::on_emp_applied( data );
    utility::waittill_notify_or_timeout( "cancel_stun", hackeffect.hackduration * 0.001 );
    dawg::on_emp_cleared( 0 );
}

// Namespace dawg_mp
// Params 4
// Checksum 0x6ae058d0, Offset: 0x1480
// Size: 0xdf
function function_d85e6a2236d6e603( owner, position, angles, streakinfo )
{
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return;
    }
    
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    vehiclename = bundle.airdropvehicle;
    
    if ( utility::issharedfuncdefined( #"dawg", #"dawg_crate_drop" ) )
    {
        thread utility::callsharedfunc( #"dawg", #"dawg_crate_drop", bundle, vehiclename, owner, position, angles, streakinfo );
        return;
    }
    
    airdrop::dropcratefromscriptedheli( owner, owner.team, "dawg", position, angles, position, undefined, streakinfo, undefined, vehiclename, undefined, 1 );
}

// Namespace dawg_mp
// Params 3
// Checksum 0x28e39375, Offset: 0x1567
// Size: 0x15f
function function_9e4c92b84cbd01d1( range, var_8f15c4e99203efac, var_690a408d820ef0df )
{
    startpos = self geteye();
    endpos = startpos + anglestoforward( self getplayerangles() ) * range;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1 );
    ignorelist = [];
    hit = physics_raycast( startpos, endpos, contents, ignorelist, 0, "physicsquery_closest" );
    var_6a668b9b16cb7558 = var_690a408d820ef0df ? function_ef9bea5f29b98d49() : undefined;
    
    if ( var_8f15c4e99203efac && hit[ 0 ] )
    {
        surfacetype = physics_getsurfacetypefromflags( hit[ 0 ][ "surfaceflags" ] );
        
        if ( surfacetype[ "name" ] == "surftype_glass_pane" )
        {
            if ( math::anglebetweenvectors( hit[ 0 ][ "normal" ], ( 0, 0, 1 ) ) < 45 )
            {
                return function_49f58f0395fc9c65( hit[ 0 ][ "position" ], var_6a668b9b16cb7558 );
            }
            
            var_6278d14236a46c42 = trace::create_contents( 0, 1, 0, 1, 1, 1 );
            var_ab6a15e8c3e607b5 = physics_raycast( startpos, endpos, var_6278d14236a46c42, ignorelist, 0, "physicsquery_closest" );
            return function_49f58f0395fc9c65( var_ab6a15e8c3e607b5[ 0 ][ "position" ], var_6a668b9b16cb7558 );
        }
    }
    
    return function_49f58f0395fc9c65( hit[ 0 ][ "position" ], var_6a668b9b16cb7558 );
}

// Namespace dawg_mp
// Params 2
// Checksum 0x7f904374, Offset: 0x16cf
// Size: 0x73
function function_49f58f0395fc9c65( pos, var_6a668b9b16cb7558 )
{
    if ( !pos )
    {
        return;
    }
    
    if ( isalive( var_6a668b9b16cb7558 ) )
    {
        navmeshpos = var_6a668b9b16cb7558 getclosestreachablepointonnavmesh( pos, 0 );
    }
    else
    {
        navmeshpos = getclosestpointonnavmesh( pos, undefined, undefined, undefined, 0 );
    }
    
    if ( !navmeshpos || distance2dsquared( navmeshpos, pos ) > 20 || abs( navmeshpos[ 2 ] - pos[ 2 ] ) > 50 )
    {
        return;
    }
    
    return navmeshpos;
}

// Namespace dawg_mp
// Params 2
// Checksum 0xaa05fe60, Offset: 0x174b
// Size: 0x27b
function function_a147c0c3a6166c98( streakinfo, pos )
{
    if ( !pos )
    {
        return 0;
    }
    
    ignorelist = [];
    eyepos = self geteye();
    
    if ( pos[ 2 ] > eyepos[ 2 ] )
    {
        return 0;
    }
    
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    axis = anglestoaxis( self.angles );
    dropradius = bundle.var_3079b271601f20b;
    var_807b12caa271e37a = axis[ "forward" ] * ( bundle.var_d950cb5659db7e4e ?? 0 ) + axis[ "right" ] * ( bundle.var_d950cc5659db8081 ?? 0 );
    var_357ec60b510ef9cd = axis[ "up" ] * ( ( bundle.var_d950c95659db79e8 ?? 0 ) + dropradius );
    groundpos = pos + var_807b12caa271e37a;
    var_dfec5f0dd2ae3e86 = undefined;
    
    if ( utility::issharedfuncdefined( #"dawg", #"hash_5443535d3275b9e5" ) )
    {
        var_dfec5f0dd2ae3e86 = utility::callsharedfunc( #"dawg", #"hash_5443535d3275b9e5" );
    }
    else
    {
        var_dfec5f0dd2ae3e86 = trace::create_contents( 0, 1, 0, 1, 1, 1 );
    }
    
    startpos = groundpos + var_357ec60b510ef9cd;
    height = level.var_c8456aef09c0fa08 ?? 2000;
    endpos = startpos + ( 0, 0, height );
    var_f145c1bab58a18fd = physics_spherecast( startpos, endpos, dropradius, var_dfec5f0dd2ae3e86, ignorelist, "physicsquery_any" );
    
    if ( var_f145c1bab58a18fd )
    {
        return 0;
    }
    
    if ( bundle.var_ffd5cc034ed19adc )
    {
        forwardoffset = axis[ "forward" ] * bundle.var_95b1a03d1c872537 / 2;
        rightoffset = axis[ "right" ] * bundle.var_a823134945b074f9 / 2;
        
        if ( !function_209dce8c6667ac28( groundpos, forwardoffset, rightoffset ) )
        {
            return 0;
        }
    }
    
    var_1534eb4c2eb71098 = moving_platforms::get_moving_platform_ents();
    
    if ( !function_64098a364dcdcf76( groundpos, dropradius, var_1534eb4c2eb71098 ) )
    {
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"dawg", #"hash_763484c87294246c" ) )
    {
        return utility::callsharedfunc( #"dawg", #"hash_763484c87294246c", pos );
    }
    
    return 1;
}

// Namespace dawg_mp
// Params 3
// Checksum 0x4b216212, Offset: 0x19cf
// Size: 0xab, Type: bool
function function_209dce8c6667ac28( pos, forwardoffset, rightoffset )
{
    var_319831b8fd9ce4a8 = [ pos + forwardoffset + rightoffset, pos + forwardoffset - rightoffset, pos - forwardoffset - rightoffset, pos - forwardoffset + rightoffset ];
    
    for ( i = 0; i < var_319831b8fd9ce4a8.size ; i++ )
    {
        var_319831b8fd9ce4a8[ i ] = function_49f58f0395fc9c65( var_319831b8fd9ce4a8[ i ] );
        
        if ( !var_319831b8fd9ce4a8[ i ] )
        {
            return false;
        }
    }
    
    if ( navtrace( var_319831b8fd9ce4a8[ 0 ], var_319831b8fd9ce4a8[ 2 ] ) || navtrace( var_319831b8fd9ce4a8[ 1 ], var_319831b8fd9ce4a8[ 3 ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace dawg_mp
// Params 3
// Checksum 0x193e9a8b, Offset: 0x1a83
// Size: 0x63, Type: bool
function function_64098a364dcdcf76( pos, radius, var_1534eb4c2eb71098 )
{
    if ( var_1534eb4c2eb71098.size > 0 )
    {
        var_d1b27290479b66fd = trace::create_contents( 0, 0, 0, 0, 0, 0, 1 );
        var_b66364f4ac32de12 = physics_spherecastents( pos, pos, radius, var_d1b27290479b66fd, var_1534eb4c2eb71098, "physicsquery_any", undefined, 1 );
        return !var_b66364f4ac32de12;
    }
    
    return true;
}

// Namespace dawg_mp
// Params 1
// Checksum 0x8a6465a5, Offset: 0x1aef
// Size: 0x97, Type: bool
function function_157d46bbeed848f5( targetpos )
{
    var_619d6a48f5a56867 = getentarray( "no_equipment_zone", #script_noteworthy );
    
    if ( var_619d6a48f5a56867.size <= 0 )
    {
        return true;
    }
    
    triggercontents = physics_createcontents( [ "physicscontents_trigger" ] );
    [ hit ] = physics_spherecastents( targetpos, targetpos, 1, triggercontents, var_619d6a48f5a56867, "physicsquery_closest" );
    
    if ( hit[ "entity" ].weaponfilter[ #"dawg" ] )
    {
        return false;
    }
    
    return true;
}

// Namespace dawg_mp
// Params 2
// Checksum 0xd9bbc4da, Offset: 0x1b8f
// Size: 0xd9
function function_c42642024bfdccb9( streakinfo, weaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    thread function_5d7ca8287db83ef4( streakinfo, weaponobj );
    var_7db58a039d278180 = 0;
    
    while ( !var_7db58a039d278180 )
    {
        waitframe();
        firedresult = killstreakdeploy::watchdeployweaponfired( streakinfo, "weapon_fired", weaponobj );
        
        if ( firedresult )
        {
            self.var_5aef88060ea2e2c1 = function_9e4c92b84cbd01d1( bundle.var_afa9782a112632ff );
            var_7db58a039d278180 = function_a147c0c3a6166c98( streakinfo, self.var_5aef88060ea2e2c1 );
            continue;
        }
        
        if ( !isdefined( firedresult ) )
        {
            break;
        }
    }
    
    return var_7db58a039d278180;
}

// Namespace dawg_mp
// Params 2
// Checksum 0xe6f0c6cb, Offset: 0x1c71
// Size: 0x139
function function_5d7ca8287db83ef4( streakinfo, weaponobj )
{
    self notify( #"hash_86731faf077b208a" );
    self endon( #"hash_86731faf077b208a" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    
    while ( isalive( self ) && self hasweapon( weaponobj ) )
    {
        self.var_5aef88060ea2e2c1 = function_9e4c92b84cbd01d1( bundle.var_afa9782a112632ff );
        var_ef727c3ceab7d1d6 = function_a147c0c3a6166c98( streakinfo, self.var_5aef88060ea2e2c1 );
        
        if ( self.var_c8d50b6b9dff4afd )
        {
            self.var_c8d50b6b9dff4afd.var_ef727c3ceab7d1d6 = var_ef727c3ceab7d1d6;
            self.var_c8d50b6b9dff4afd.weaponobj = weaponobj;
        }
        
        if ( var_ef727c3ceab7d1d6 )
        {
            self function_43c87f41d02d3870();
        }
        else
        {
            self function_f7cc2bc7474de74e();
        }
        
        self setclientomnvar( "ui_turret_placement", !var_ef727c3ceab7d1d6 );
        wait 0.25;
    }
    
    if ( self )
    {
        self function_43c87f41d02d3870();
        self setclientomnvar( "ui_turret_placement", 0 );
    }
}

// Namespace dawg_mp
// Params 2
// Checksum 0xfc7fee97, Offset: 0x1db2
// Size: 0x115
function function_3d19b1ee82082e8d( pos, streakinfo )
{
    player = streakinfo.owner;
    
    if ( streakinfo.var_9f8e9d8675e110d6 )
    {
        streakinfo.var_9f8e9d8675e110d6.origin = pos;
    }
    else
    {
        streakinfo.var_9f8e9d8675e110d6 = utility::spawn_tag_origin( pos );
        streakinfo.var_9f8e9d8675e110d6 showtoplayer( player );
        player scripted_widgets::anchored_add( streakinfo.var_9f8e9d8675e110d6, "dawg_drop_waypoint", "scripted_widget_generic_in_world_marker_waypoint_dawg", "scripted_widget_anchor_origin_waypoint_dawg" );
        
        if ( isplayer( player ) )
        {
            if ( !isdefined( player.var_dfd1aa406bc8711f ) )
            {
                player.var_dfd1aa406bc8711f = 0;
            }
            
            player.var_dfd1aa406bc8711f++;
        }
    }
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        if ( !player callback::exists( #"killstreak_cancel", &function_5afad2cfdb66101f ) )
        {
            player callback::add( #"killstreak_cancel", &function_5afad2cfdb66101f );
        }
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0xb4d97bb, Offset: 0x1ecf
// Size: 0xdb
function function_f8c991bad208394f( streakinfo )
{
    player = streakinfo.owner;
    
    if ( streakinfo.var_9f8e9d8675e110d6 )
    {
        streakinfo.var_9f8e9d8675e110d6 delete();
    }
    
    if ( player && isplayer( player ) )
    {
        if ( player.var_dfd1aa406bc8711f )
        {
            player.var_dfd1aa406bc8711f--;
            
            if ( player.var_dfd1aa406bc8711f <= 0 )
            {
                player.var_dfd1aa406bc8711f = undefined;
            }
        }
        
        if ( level.gametypebundle.var_711e33239e4c9925 && !player.var_dfd1aa406bc8711f )
        {
            if ( player callback::exists( #"killstreak_cancel", &function_5afad2cfdb66101f ) )
            {
                player callback::remove( #"killstreak_cancel", &function_5afad2cfdb66101f );
            }
        }
    }
}

// Namespace dawg_mp
// Params 1, eflags: 0x4
// Checksum 0x67c3450, Offset: 0x1fb2
// Size: 0x8e
function private function_5afad2cfdb66101f( params )
{
    foreach ( dawg in self.dawglist )
    {
        function_f8c991bad208394f( dawg.streakinfo );
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0xcd26cbe, Offset: 0x2048
// Size: 0x35
function on_player_respawn( params )
{
    dawg = function_ef9bea5f29b98d49();
    
    if ( dawg )
    {
        thread dawg_emp_watcher( dawg );
        function_fac1509b83bac176( dawg );
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x5a6b8f79, Offset: 0x2085
// Size: 0x141
function function_a9a336616cf4cceb( dawg )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    streakinfo = dawg.streakinfo;
    dawg waittill( #"death", attacker );
    
    if ( isplayer( attacker ) && player_utility::isenemy( attacker ) )
    {
        thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"destroyed" );
    }
    
    var_4c1999e8c5706da4 = function_ef9bea5f29b98d49();
    
    if ( self.dawglist )
    {
        self.dawglist = arrayremove( self.dawglist, dawg );
    }
    
    if ( var_4c1999e8c5706da4 )
    {
        killstreak_utility::function_79acee879fb17c4a( self, "dawg" );
        prevdawg = function_ef9bea5f29b98d49();
        
        if ( prevdawg )
        {
            thread dawg_emp_watcher( prevdawg );
            function_fac1509b83bac176( prevdawg );
        }
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    killstreak_utility::recordkillstreakendstats( streakinfo );
    
    if ( self.dawglist.size <= 0 )
    {
        if ( callback::exists( "onPlayerSpawn", &on_player_respawn ) )
        {
            callback::remove( "onPlayerSpawn", &on_player_respawn );
        }
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x7d888396, Offset: 0x21ce
// Size: 0x5f
function function_5fb9cbb29986580b( disablewatcher )
{
    self notify( #"mode_changed" );
    self.mode = "attack";
    utility::function_32b24db3127bff40( "dawg_mode", "active" );
    
    if ( isplayer( self.owner ) && !disablewatcher )
    {
        self.owner thread function_3e86a2718218face( self );
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x3ecfb1a2, Offset: 0x2235
// Size: 0x21
function function_4f88815c617846a2( position )
{
    self notify( #"mode_changed" );
    thread function_5c121dce096cc8f0( position );
}

// Namespace dawg_mp
// Params 0
// Checksum 0xa0782c55, Offset: 0x225e
// Size: 0x27
function function_ef9bea5f29b98d49()
{
    if ( self.dawglist.size )
    {
        return self.dawglist[ self.dawglist.size - 1 ];
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0xdcbb1199, Offset: 0x228e
// Size: 0x4e
function function_fac1509b83bac176( dawg )
{
    if ( dawg )
    {
        if ( dawg.mode == "attack" )
        {
            thread function_3e86a2718218face( dawg );
            return;
        }
        
        if ( dawg.mode == "sentry" )
        {
            thread function_86d8549c601df12e( dawg );
        }
    }
}

// Namespace dawg_mp
// Params 0
// Checksum 0x689ab701, Offset: 0x22e4
// Size: 0xa6
function function_3ac91fded8cfe302()
{
    self notify( #"hash_339f837e27f2a6d5" );
    
    foreach ( dawg in self.dawglist )
    {
        if ( dawg.mode == "sentry" )
        {
            dawg cleanup_sentry_mode();
            dawg function_5fb9cbb29986580b( 1 );
        }
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x21a29897, Offset: 0x2392
// Size: 0xce
function dawg_emp_watcher( dawg )
{
    dawg endon( #"death" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_339f837e27f2a6d5" );
    
    while ( true )
    {
        prevmode = dawg.mode;
        dawg waittill( #"mode_changed" );
        
        if ( dawg != function_ef9bea5f29b98d49() )
        {
            break;
        }
        
        if ( dawg.mode == "emp" && prevmode != "emp" )
        {
            killstreak_utility::function_79acee879fb17c4a( self, "dawg" );
            function_3f30a40dd57b2ca3( self );
            continue;
        }
        
        if ( dawg.mode != "emp" && prevmode == "emp" )
        {
            function_fac1509b83bac176( dawg );
        }
    }
}

// Namespace dawg_mp
// Params 2
// Checksum 0x4e681bec, Offset: 0x2468
// Size: 0x54
function function_880aac7d9e75ea4c( hint, objectid )
{
    useobj = killstreak_utility::function_66160ad6f52dcbf5( "dawg", self, objectid );
    
    if ( !useobj )
    {
        useobj = killstreak_utility::function_92b58f17af03198f( "dawg", self, hint, objectid, 1 );
        useobj setuseholdduration( 500 );
    }
    
    return useobj;
}

// Namespace dawg_mp
// Params 1
// Checksum 0xc0cef71f, Offset: 0x24c5
// Size: 0x84
function function_86d8549c601df12e( dawg )
{
    owner = self;
    dawg endon( #"death" );
    owner endon( #"death_or_disconnect" );
    owner endon( #"hash_339f837e27f2a6d5" );
    useobj = owner function_880aac7d9e75ea4c( &"KILLSTREAKS_HINTS/DAWG_SENTRY_USE", #"dawg_sentry" );
    useobj waittill( #"trigger" );
    dawg cleanup_sentry_mode();
    dawg function_5fb9cbb29986580b();
}

// Namespace dawg_mp
// Params 0
// Checksum 0xec6384a9, Offset: 0x2551
// Size: 0x13e
function cleanup_sentry_mode()
{
    dawg = self;
    
    if ( dawg.owner )
    {
        killstreak_utility::function_79acee879fb17c4a( dawg.owner, "dawg" );
    }
    
    function_3f30a40dd57b2ca3( dawg );
    
    if ( dawg.being_pet )
    {
        dawg utility::waittill_notify_or_timeout( "petting_finished", 10 );
    }
    
    if ( dawg.turret dawg_turret::function_f1026959cc5e668e() )
    {
        dawg.turret utility::waittill_notify_or_timeout( "missile_fired", 10 );
    }
    
    dawg.turret dawg_turret::function_84db7c188ab0137f();
    
    if ( dawg.var_b566b2d61a12539d )
    {
        dawg.var_b566b2d61a12539d delete();
    }
    
    asmstate = dawg asmgetcurrentstate( dawg.asmname );
    
    if ( asmstate == "sentry_mode_in" || asmstate == "sentry_mode" )
    {
        dawg asm::function_7256f5ba459c840b( "sentry_mode_out" );
        dawg.var_8666a991e34bea40 = 0;
    }
    
    if ( dawg.team && dawg.dawgaisettings.hasassaultpack )
    {
        dawg thread dawg::function_ff47adf878fb519d();
    }
    
    dawg dawg_pet_asm::function_c9779b57c42e7d09();
}

// Namespace dawg_mp
// Params 1
// Checksum 0xeb5951b0, Offset: 0x2697
// Size: 0x112
function function_3e86a2718218face( dawg )
{
    if ( dawg.streakinfo.bundle.var_448f7392e3ad68a != #"sentrymode" && getdvarint( @"hash_6c929b8ae922688f", 0 ) == 0 )
    {
        return;
    }
    
    owner = self;
    dawg endon( #"death" );
    owner endon( #"death_or_disconnect" );
    owner endon( #"hash_339f837e27f2a6d5" );
    
    while ( true )
    {
        useobj = function_880aac7d9e75ea4c( &"KILLSTREAKS_HINTS/DAWG_ATTACK_USE", #"dawg_attack" );
        
        if ( useobj )
        {
            useobj waittill( #"trigger" );
        }
        else
        {
            break;
        }
        
        if ( owner function_e4b9428a73b2ff51( dawg ) )
        {
            killstreak_utility::function_79acee879fb17c4a( owner, "dawg" );
            dawg function_4f88815c617846a2( dawg.var_58b2635c80b1c153.origin );
            break;
        }
        
        hud_message::showerrormessage( %"killstreaks/cannot_be_placed" );
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0xc96d247a, Offset: 0x27b1
// Size: 0x19d, Type: bool
function function_e4b9428a73b2ff51( dawg )
{
    owner = self;
    targetpos = function_9e4c92b84cbd01d1( dawg.dawgaisettings.var_4aafac458535c9, 1, 1 );
    
    if ( !targetpos )
    {
        return false;
    }
    
    if ( !withinfov2d( owner geteye(), owner getplayerangles(), targetpos, cos( 5 ) ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"dawg", #"hash_145e09e77210f5b0" ) && !utility::callsharedfunc( #"dawg", #"hash_145e09e77210f5b0", targetpos ) )
    {
        return false;
    }
    
    axis = anglestoaxis( self.angles );
    forwardoffset = axis[ "forward" ] * 20;
    rightoffset = axis[ "right" ] * 20;
    
    if ( !function_209dce8c6667ac28( targetpos, forwardoffset, rightoffset ) )
    {
        return false;
    }
    
    var_1534eb4c2eb71098 = moving_platforms::get_moving_platform_ents();
    
    if ( !function_64098a364dcdcf76( targetpos, 40, var_1534eb4c2eb71098 ) )
    {
        return false;
    }
    
    if ( !function_157d46bbeed848f5( targetpos ) )
    {
        return false;
    }
    
    if ( dawg.var_58b2635c80b1c153 )
    {
        dawg.var_58b2635c80b1c153 delete();
    }
    
    dawg.var_58b2635c80b1c153 = utility::spawn_tag_origin( targetpos );
    dawg.var_58b2635c80b1c153 showtoplayer( self );
    scripted_widgets::anchored_add( dawg.var_58b2635c80b1c153, "dawg_sentry_waypoint", "scripted_widget_generic_in_world_marker_waypoint_dawg", "scripted_widget_anchor_origin_waypoint_dawg" );
    dawg thread utility::delete_on_death( dawg.var_58b2635c80b1c153 );
    return true;
}

// Namespace dawg_mp
// Params 1
// Checksum 0x77c13ab9, Offset: 0x2957
// Size: 0x2a
function function_3f30a40dd57b2ca3( dawg )
{
    if ( dawg.var_58b2635c80b1c153 )
    {
        dawg.var_58b2635c80b1c153 delete();
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0xc2d63ccb, Offset: 0x2989
// Size: 0x186
function function_5c121dce096cc8f0( position )
{
    self endon( #"death" );
    self endon( #"mode_changed" );
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread function_86d8549c601df12e( self );
    }
    
    if ( self.turret dawg_turret::function_f1026959cc5e668e() )
    {
        self.turret utility::waittill_notify_or_timeout( "missile_fired", 10 );
    }
    
    self.turret dawg_turret::function_832f350dfec1ef64( 0 );
    self.mode = "sentry";
    self.sentry_mode_position = position;
    dawg::dawg_set_goal( position );
    
    while ( !dawg::function_b088d49b49e6a92() )
    {
        self waittill( #"bt_goal" );
    }
    
    dawg::dawg_set_goal();
    wait self.dawgaisettings.var_3262e54f39a3ec3e;
    self.turret dawg_turret::function_1943eb45c441101d();
    utility::function_32b24db3127bff40( "dawg_mode", "sentry" );
    
    if ( getdvarint( @"hash_5322ee74d240eeb6", 0 ) == 0 )
    {
        asm::function_7256f5ba459c840b( "sentry_mode_in" );
        self.var_8666a991e34bea40 = 1;
    }
    
    if ( self.team && self.dawgaisettings.hasassaultpack )
    {
        thread dawg::function_5a26b0e63b76ad76();
    }
    
    dawg::function_cf1744a0fe86c812();
    dawg::sentry_mode_trophy_system();
    self.turret dawg_turret::function_832f350dfec1ef64( 1 );
    function_3f30a40dd57b2ca3( self );
    dawg_pet_asm::function_d88a4895de88fa18();
    self notify( #"sentry_complete" );
}

// Namespace dawg_mp
// Params 1
// Checksum 0x29e9cf3c, Offset: 0x2b17
// Size: 0x1f8
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_8f643dc67b6cb21b" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_8f643dc67b6cb21b", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner )
        {
            self.owner thread points::doscoreevent( #"hash_16c0af7021e4a987", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.streakinfo.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.streakinfo.bundle.buffedheadicon, 1 );
            }
            
            self.var_af81e0df169020e8 = params.bundle.var_fd6f835ac60089bb ?? undefined;
        }
    }
}

// Namespace dawg_mp
// Params 1
// Checksum 0x75976df0, Offset: 0x2d17
// Size: 0xb8
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_345ef9e4a8b98096 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_345ef9e4a8b98096, 1 );
                }
                
                self.var_af81e0df169020e8 = undefined;
            }
        }
    }
}

