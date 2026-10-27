// scripts\mp\common\killstreaks\sniper_briefcase.gsc  (hash_114ff5f60c83a16e.gscc) (size: 11795 Bytes / 0x2e13 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdddba3b5 (3722159029)
// size ...... 11795 (0x2e13)
// includes .. 13  (offset: 0x2c5f)
// strings ... 17  (offset: 0x2cc7)
// dev strs .. 0   (offset: 0x2e13)
// exports ... 29  (offset: 0x1d63)
// cseg ...... 0x1d9 + 0x1b8a (0x1d63)
// imports ... 87  (offset: 0x21eb)
// animtree1 . 0   (offset: 0x2e13)
// animtree2 . 0   (offset: 0x2e13)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\objidpoolmanager;

#namespace sniper_briefcase;

// Namespace sniper_briefcase
// Params 0, eflags: 0x1
// Checksum 0x46f9743, Offset: 0x1f7
// Size: 0x2d
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"sniper_briefcase", &init );
    level callback::add( #"hash_244314ef9125e636", &function_25f59e450317d72a );
}

// Namespace sniper_briefcase
// Params 0
// Checksum 0x5d3f26dc, Offset: 0x22c
// Size: 0xed
function init()
{
    sniperbriefcasebundle = level.streakglobals.streakbundles[ "sniper_briefcase" ];
    weaponname = utility::get_scripted_weapon_name( #"sniper_briefcase" );
    
    if ( isdefined( weaponname ) )
    {
        killstreaks::registerkillstreak( "sniper_briefcase", &function_4fc94c288a7df31e, &function_dd891e49b9d6d580, undefined, &function_348ab3f08e437dd2 );
        killstreaks::registerkillstreakstowableweapon( "sniper_briefcase", weaponname, undefined, "bulletWeapon", undefined, sniperbriefcasebundle.usedsplashref, 1, undefined, 0, 1, 1, 1, 1, 1, 1, 1 );
    }
    
    level function_8914c3d1eac72237();
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "sniper_briefcase", sniperbriefcasebundle.deployweaponname ?? "sat_ks_sniper_briefcase_mp", #"low" );
    killstreaks::function_61ba08bb8e2dd7a6( "sniper_briefcase", 1, #"low" );
    
    /#
        setdevdvarifuninitialized( @"hash_79d1ef59e4d461d6", 0 );
    #/
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x8ca4f0fa, Offset: 0x321
// Size: 0x2dc
function function_4fc94c288a7df31e( streakinfo )
{
    if ( !isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a = [];
    }
    
    streakinfo.var_e10238c4d70a09b9 = [];
    streakinfo.var_a3e5afcf6e603fa8 = [];
    sniperbriefcasebundle = killstreak::function_85b2d8e857ab4898( "sniper_briefcase" );
    
    if ( !isdefined( sniperbriefcasebundle ) )
    {
        sniperbriefcasebundle = spawnstruct();
    }
    
    var_d0479cded1ea362c = { #var_bbcacf231f9a9d7e:sniperbriefcasebundle.var_bbcacf231f9a9d7e ?? 3000, #var_ececd50191c37a9b:sniperbriefcasebundle.var_ececd50191c37a9b ?? 3000, #var_6742ed92278d2c31:sniperbriefcasebundle.var_6742ed92278d2c31 ?? 0, #var_ccb12beab0a87d24:sniperbriefcasebundle.var_ccb12beab0a87d24 ?? 3000, #var_211d88d33df30932:sniperbriefcasebundle.var_211d88d33df30932 ?? 3000, #var_73d284dab3990fdf:sniperbriefcasebundle.var_73d284dab3990fdf ?? 2000, #hudoutlineradius:sniperbriefcasebundle.hudoutlineradius ?? 180, #bulletweapon:sniperbriefcasebundle.deployweaponname ?? "sat_ks_sniper_briefcase_mp" };
    streakinfo.bulletweapon = var_d0479cded1ea362c.bulletweapon;
    streakinfo.var_b7f22211336c491a = sniperbriefcasebundle.var_b7f22211336c491a ?? 0;
    self.var_ec0bb630fbaa253a[ streakinfo.bulletweapon ] = streakinfo;
    
    if ( var_d0479cded1ea362c.var_6742ed92278d2c31 )
    {
        var_d0479cded1ea362c.adsstate = 0;
        var_d0479cded1ea362c.var_57522d728f234e14 = 0;
        var_d0479cded1ea362c.var_8df2877949c2d88 = 0;
    }
    
    self.var_ec0bb630fbaa253a[ var_d0479cded1ea362c.bulletweapon ].var_d0479cded1ea362c = var_d0479cded1ea362c;
    
    if ( !isdefined( self.sniperbriefcasedata ) )
    {
        self.sniperbriefcasedata = { #sniperweapon:var_d0479cded1ea362c.bulletweapon };
    }
    
    childthread function_d0b7708e540cff08( streakinfo );
    childthread sniperbriefcase_watchplayerdeath( streakinfo );
    childthread sniperbriefcase_watchuse( streakinfo );
    childthread sniperbriefcase_watchads( streakinfo );
    childthread sniperbriefcase_watchdeath( streakinfo );
    childthread function_67189fdbafebb3f( streakinfo );
    childthread function_324004eb827ce0( streakinfo );
    thread function_651af370277a2e63( streakinfo );
    thread function_c939fbdbc85ca13d( streakinfo );
    streakinfo.var_9d9eb4c709bffed9 = 1;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( streakinfo.streakname, "Killstreak_Ground", self );
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x91b5b0f9, Offset: 0x605
// Size: 0xc
function function_dd891e49b9d6d580( streakitem )
{
    
}

// Namespace sniper_briefcase
// Params 0
// Checksum 0x2ac78077, Offset: 0x619
// Size: 0x2
function function_8914c3d1eac72237()
{
    
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x5172e96, Offset: 0x623
// Size: 0xb0
function sniperbriefcase_watchuse( streakinfo )
{
    self endon( #"death" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    streakinfo endon( streakinfo.bulletweapon + "_killstreak_ammo_used_all" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.basename == self.sniperbriefcasedata.sniperweapon )
        {
            self notify( #"sniper_briefcase_fired" );
            self.var_ec0bb630fbaa253a[ streakinfo.bulletweapon ] = streakinfo;
            thread function_18ef3497fbaef56c( streakinfo );
        }
        
        waitframe();
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x355e7d40, Offset: 0x6db
// Size: 0xf9
function function_18ef3497fbaef56c( streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( self.var_c7f9996ef2343f2a && self.var_8ce8d93781ae0220 == "specialty_scout" )
    {
        return;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "sniper_briefcase" );
    streakinfo functionals_utility::clearminimapid();
    streakinfo.minimapid = objidpoolmanager::createobjective_hidden( bundle.minimapicon ?? "hud_icon_minimap_killstreak_uav" );
    objidpoolmanager::function_e4d6a71507372662( streakinfo.minimapid, 0 );
    objidpoolmanager::objective_mask_showtoenemyteam( streakinfo.minimapid, self );
    utility::waittill_any_timeout_no_endon_death( bundle.var_ab34cc7093fbebc5 ?? 3, "death" );
    entry = objidpoolmanager::function_1eca7bd1a3a49a4d( streakinfo.minimapid );
    
    if ( !isdefined( entry ) )
    {
        streakinfo functionals_utility::clearminimapid();
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0xd6d2e8dd, Offset: 0x7dc
// Size: 0xde
function function_be8f4b8e4e5e55c2( var_d0479cded1ea362c )
{
    enemyteams = team_utility::getenemyteams( self.team, 1 );
    enemies = function_6f2868251b5decd6( self geteye(), var_d0479cded1ea362c.var_211d88d33df30932, anglestoforward( self getplayerangles() ), 30, enemyteams );
    
    foreach ( enemy in enemies )
    {
        if ( enemy.juggcontext.var_fb68c148d6ef3479 )
        {
            enemies = arrayremove( enemies, enemy );
        }
    }
    
    return enemies;
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0xa2b99d35, Offset: 0x8c3
// Size: 0x5b0
function sniperbriefcase_watchads( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"streak_end" );
    var_d0479cded1ea362c = self.var_ec0bb630fbaa253a[ streakinfo.bulletweapon ].var_d0479cded1ea362c;
    hudoutlineradius = var_d0479cded1ea362c.hudoutlineradius;
    fov = self playergetzoomfov();
    var_6a5ffc3860288ca4 = squared( var_d0479cded1ea362c.var_73d284dab3990fdf );
    bundle = killstreak::function_85b2d8e857ab4898( "sniper_briefcase" );
    var_5a176905ce4dce4c = ( bundle.var_2bf3cd4d214b640 ?? 1.2 ) * 1000;
    
    while ( true )
    {
        while ( self playerads() >= 0.95 )
        {
            equippedweapon = self getcurrentweapon();
            
            if ( equippedweapon.basename != streakinfo.bulletweapon )
            {
                if ( var_d0479cded1ea362c.var_6742ed92278d2c31 )
                {
                    var_d0479cded1ea362c.adsstate = 0;
                }
                
                function_455bc22a31be61c7( streakinfo );
            }
            else if ( !self.empcount )
            {
                currenttime = gettime();
                self function_8fb7db9997715b2c();
                
                if ( var_d0479cded1ea362c.var_6742ed92278d2c31 )
                {
                    if ( !var_d0479cded1ea362c.adsstate )
                    {
                        var_d0479cded1ea362c.adsstate = 1;
                        var_d0479cded1ea362c.var_57522d728f234e14 = 1;
                        var_d0479cded1ea362c.var_8df2877949c2d88 = currenttime;
                    }
                    
                    if ( var_d0479cded1ea362c.var_57522d728f234e14 && currenttime - var_d0479cded1ea362c.var_8df2877949c2d88 > var_d0479cded1ea362c.var_ececd50191c37a9b )
                    {
                        var_d0479cded1ea362c.var_57522d728f234e14 = 0;
                        var_d0479cded1ea362c.var_8df2877949c2d88 = currenttime;
                    }
                    else if ( !var_d0479cded1ea362c.var_57522d728f234e14 && currenttime - var_d0479cded1ea362c.var_8df2877949c2d88 > var_d0479cded1ea362c.var_bbcacf231f9a9d7e )
                    {
                        var_d0479cded1ea362c.var_57522d728f234e14 = 1;
                        var_d0479cded1ea362c.var_8df2877949c2d88 = currenttime;
                    }
                }
                
                enemies = function_be8f4b8e4e5e55c2( var_d0479cded1ea362c );
                
                foreach ( enemy in enemies )
                {
                    enemyplayernum = enemy.entnum ?? utility::get_entity_number( enemy );
                    streakinfo.var_a3e5afcf6e603fa8[ enemyplayernum ] = undefined;
                    
                    if ( var_d0479cded1ea362c.var_6742ed92278d2c31 && !var_d0479cded1ea362c.var_57522d728f234e14 )
                    {
                        function_a47dfe5531905673( streakinfo, enemy, enemyplayernum );
                        continue;
                    }
                    
                    if ( isdefined( enemy.lastspawntime ) && currenttime - enemy.lastspawntime <= var_d0479cded1ea362c.var_ccb12beab0a87d24 )
                    {
                        function_a47dfe5531905673( streakinfo, enemy, enemyplayernum );
                        continue;
                    }
                    
                    enemycentroid = enemy getcentroid();
                    
                    if ( self worldpointinreticle_circle( enemycentroid, fov, hudoutlineradius ) )
                    {
                        hascoldbloodedperk = isdefined( enemy.perks[ "specialty_coldblooded" ] );
                        disttoenemysquared = distancesquared( self.origin, enemycentroid );
                        
                        if ( disttoenemysquared <= var_6a5ffc3860288ca4 && !hascoldbloodedperk )
                        {
                            if ( !streakinfo.var_e10238c4d70a09b9[ enemyplayernum ] )
                            {
                                function_e67e0fc84a8355ba( streakinfo, enemy, enemyplayernum );
                            }
                        }
                        else if ( streakinfo.var_e10238c4d70a09b9[ enemyplayernum ] )
                        {
                            function_a47dfe5531905673( streakinfo, enemy, enemyplayernum );
                        }
                        
                        continue;
                    }
                    
                    if ( streakinfo.var_e10238c4d70a09b9[ enemyplayernum ] )
                    {
                        function_a47dfe5531905673( streakinfo, enemy, enemyplayernum );
                    }
                }
                
                foreach ( var_e99d32a71b956cd8 in streakinfo.var_e10238c4d70a09b9 )
                {
                    var_92128d7bd583c6a9 = var_e99d32a71b956cd8.entnum ?? utility::get_entity_number( var_e99d32a71b956cd8 );
                    
                    if ( isdefined( var_e99d32a71b956cd8.body ) && !streakinfo.var_a3e5afcf6e603fa8[ var_92128d7bd583c6a9 ] && gettime() < var_e99d32a71b956cd8.body.birthtime + 1500 )
                    {
                        function_a47dfe5531905673( streakinfo, var_e99d32a71b956cd8, var_92128d7bd583c6a9 );
                        thread function_ce67029717a37496( streakinfo, var_e99d32a71b956cd8.body, var_92128d7bd583c6a9 );
                    }
                    else if ( !arraycontains( enemies, var_e99d32a71b956cd8 ) )
                    {
                        function_a47dfe5531905673( streakinfo, var_e99d32a71b956cd8, var_92128d7bd583c6a9 );
                        continue;
                    }
                    
                    if ( self.var_84827c2a79cf3d1e && isplayer( var_e99d32a71b956cd8 ) && ( currenttime > var_e99d32a71b956cd8.var_52eca5f5757fcd7 || !isdefined( var_e99d32a71b956cd8.var_52eca5f5757fcd7 ) ) )
                    {
                        var_e99d32a71b956cd8.var_52eca5f5757fcd7 = currenttime + var_5a176905ce4dce4c;
                        self playsoundtoplayer( #"hash_61f1da5b49b53759", var_e99d32a71b956cd8 );
                        var_e99d32a71b956cd8 setclientomnvar( o"ui_sniper_briefcase_warning", 1 );
                        var_e99d32a71b956cd8 killstreak_utility::function_3e94cbbe710e9a77( "sniper_briefcase" );
                    }
                }
            }
            
            waitframe();
        }
        
        while ( self playerads() < 0.95 )
        {
            if ( var_d0479cded1ea362c.var_6742ed92278d2c31 )
            {
                var_d0479cded1ea362c.adsstate = 0;
            }
            
            function_455bc22a31be61c7( streakinfo );
            waitframe();
        }
    }
}

/#

    // Namespace sniper_briefcase
    // Params 1, eflags: 0xc
    // Checksum 0x95b4cecc, Offset: 0xe7b
    // Size: 0xa4, Type: dev
    function private function_f4a7eb31e25acdc4( streakinfo )
    {
        self notify( #"hash_1b0213bc1379c3d2" );
        self endon( #"hash_1b0213bc1379c3d2" );
        endtimems = gettime() + ( streakinfo.bundle.sniperbriefcaseduration ?? 75 ) * 1000;
        
        while ( self && gettime() < endtimems )
        {
            var_72ecf00749f1172e = int( ( endtimems - gettime() ) * 0.001 );
            printtoscreen2d( 1000, 250, var_72ecf00749f1172e, ( 1, 0, 0 ), 5, 1 );
            waitframe();
        }
    }

#/

// Namespace sniper_briefcase
// Params 3, eflags: 0x4
// Checksum 0x3745243a, Offset: 0xf27
// Size: 0x103
function private function_659d808736a08c39( durationms, endtimems, streakinfo )
{
    profilestart();
    self setclientomnvar( o"ui_sniper_briefcase_duration", streakinfo.bundle.sniperbriefcaseduration );
    self setclientomnvar( o"ui_sniper_briefcase_start_time", gettime() * 0.001 );
    self setclientomnvar( level.streakglobals.var_d1ef34b4cd421758[ streakinfo.var_9384480e6997afd7 ], int( streakinfo.bundle.sniperbriefcaseduration * 10 ) );
    
    if ( isnumber( streakinfo.var_9384480e6997afd7 ) && streakinfo.var_9384480e6997afd7 == 0 && streakinfo.mpstreaksysteminfo )
    {
        streakinfo.mpstreaksysteminfo.var_47a7d4938ffed864 = &function_3c3d208926b14a20;
        streakinfo.mpstreaksysteminfo.var_ad34dcf3e1d7e3c1 = streakinfo;
    }
    
    profilestop();
}

// Namespace sniper_briefcase
// Params 1, eflags: 0x4
// Checksum 0x731e229b, Offset: 0x1032
// Size: 0x61
function private function_3c3d208926b14a20( streakinfo )
{
    var_7b6386c6709e9f3a = int( ( ( streakinfo.var_963923073818c1fb ?? 0 ) - gettime() ) / 100 );
    
    if ( var_7b6386c6709e9f3a > 0 )
    {
        self setclientomnvar( level.streakglobals.var_d1ef34b4cd421758[ streakinfo.var_9384480e6997afd7 ], var_7b6386c6709e9f3a );
    }
}

// Namespace sniper_briefcase
// Params 0, eflags: 0x4
// Checksum 0xcb1575df, Offset: 0x109b
// Size: 0x5f
function private function_ce1da0b4378fb398()
{
    sniperbriefcasebundle = killstreak::function_85b2d8e857ab4898( "sniper_briefcase" );
    bulletweapon = sniperbriefcasebundle.deployweaponname ?? "sat_ks_sniper_briefcase_mp";
    streakinfo = self.var_ec0bb630fbaa253a[ bulletweapon ];
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"disrupted_hacked" );
}

// Namespace sniper_briefcase
// Params 1, eflags: 0xc
// Checksum 0xf266735f, Offset: 0x1102
// Size: 0x14d
function private function_c939fbdbc85ca13d( streakinfo )
{
    self notify( #"hash_c79899811ecca623" );
    self endon( #"hash_c79899811ecca623" );
    self endon( #"disconnect" );
    streakinfo endon( streakinfo.bulletweapon + "_killstreak_use_duration_expired" );
    var_2e23924c7d49eac0 = streakinfo.bulletweapon + "_killstreak_ammo_used_all";
    
    while ( true )
    {
        msg = utility::waittill_any_ents_return( streakinfo, var_2e23924c7d49eac0, self, "death", level, "game_ended" );
        
        if ( msg == var_2e23924c7d49eac0 || msg == "game_ended" )
        {
            break;
        }
        
        if ( killstreaks::function_86ffe5755d194a83( streakinfo, streakinfo.bulletweapon ) )
        {
            break;
        }
    }
    
    self setscriptablepartstate( #"sniper_briefcase_timer", #"no_time_remaining" );
    
    if ( streakinfo )
    {
        streakinfo.var_963923073818c1fb = undefined;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fa086db745e2c53e" ][ #"hash_d428d7b9853a90d7" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( #"sniper_briefcase" );
    }
    
    self.var_7cd86348fc758d00 = undefined;
    
    if ( streakinfo )
    {
        streakinfo notify( #"hash_d7fb62022ad5f265" );
        streakinfo notify( streakinfo.bulletweapon + "_killstreak_use_duration_expired" );
    }
}

// Namespace sniper_briefcase
// Params 1, eflags: 0x4
// Checksum 0xb50b8316, Offset: 0x1257
// Size: 0x334
function private function_651af370277a2e63( streakinfo )
{
    if ( streakinfo.var_963923073818c1fb > gettime() )
    {
        if ( isnumber( streakinfo.var_9384480e6997afd7 ) && streakinfo.var_9384480e6997afd7 == 0 )
        {
            function_3c3d208926b14a20( streakinfo );
        }
        
        return;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return;
        }
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    streakinfo endon( streakinfo.bulletweapon + "_killstreak_use_duration_expired" );
    streakinfo endon( streakinfo.bulletweapon + "_killstreak_ammo_used_all" );
    streakinfo endon( #"hash_d7fb62022ad5f265" );
    wait 4;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fa086db745e2c53e" ][ #"hash_29fb623c0b4dda71" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( #"sniper_briefcase", &function_ce1da0b4378fb398 );
    }
    
    durationms = ( streakinfo.bundle.sniperbriefcaseduration ?? 75 ) * 1000;
    self.var_7cd86348fc758d00 = streakinfo.bundle.empedscoreevent;
    streakinfo.var_963923073818c1fb = gettime() + durationms;
    thread function_659d808736a08c39( durationms, streakinfo.var_963923073818c1fb, streakinfo );
    
    /#
        if ( getdvarint( @"hash_79d1ef59e4d461d6", 0 ) )
        {
            childthread function_f4a7eb31e25acdc4( streakinfo );
        }
    #/
    
    self setscriptablepartstate( "sniper_briefcase_timer", "time_remaining_long" );
    waitframe();
    
    if ( isdefined( streakinfo.var_963923073818c1fb ) )
    {
        secondsremaining = ( streakinfo.var_963923073818c1fb - gettime() ) * 0.001;
        waittime = clamp( secondsremaining - 10 - 1, 0, secondsremaining );
        
        if ( waittime )
        {
            self setscriptablepartstate( "sniper_briefcase_timer", "time_remaining_long" );
            wait waittime;
        }
    }
    
    if ( isdefined( streakinfo.var_963923073818c1fb ) )
    {
        secondsremaining = ( streakinfo.var_963923073818c1fb - gettime() ) * 0.001;
        waittime = clamp( secondsremaining - 1, 0, secondsremaining );
        
        if ( waittime )
        {
            self setscriptablepartstate( "sniper_briefcase_timer", "time_remaining_low" );
            wait waittime;
        }
    }
    
    if ( isdefined( streakinfo.var_963923073818c1fb ) )
    {
        secondsremaining = ( streakinfo.var_963923073818c1fb - gettime() ) * 0.001;
        waittime = clamp( secondsremaining, 0, secondsremaining );
        
        if ( waittime )
        {
            self setscriptablepartstate( "sniper_briefcase_timer", "no_time_remaining" );
            wait waittime;
        }
    }
    
    if ( isdefined( streakinfo.var_963923073818c1fb ) )
    {
        streakinfo.var_963923073818c1fb = undefined;
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fa086db745e2c53e" ][ #"hash_d428d7b9853a90d7" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( #"sniper_briefcase" );
        }
        
        self.var_7cd86348fc758d00 = undefined;
    }
    
    if ( isdefined( streakinfo ) )
    {
        streakinfo notify( streakinfo.bulletweapon + "_killstreak_use_duration_expired" );
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0xe4cca889, Offset: 0x1593
// Size: 0x6d
function function_324004eb827ce0( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_69562b0de38a064f", var_897f0094d6449e93 );
        
        if ( var_897f0094d6449e93 == 1 )
        {
            self.var_84827c2a79cf3d1e = 1;
            continue;
        }
        
        if ( var_897f0094d6449e93 == 2 )
        {
            self.var_84827c2a79cf3d1e = undefined;
        }
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x2816f8db, Offset: 0x1608
// Size: 0x41
function removehudoutline( var_69a96ac7ade28fc1 )
{
    if ( outline::isoutlineenabled( var_69a96ac7ade28fc1, var_69a96ac7ade28fc1.var_3f3457f3778b49ca ) )
    {
        outline::outlinedisable( var_69a96ac7ade28fc1.var_3f3457f3778b49ca, var_69a96ac7ade28fc1 );
        var_69a96ac7ade28fc1.var_3f3457f3778b49ca = undefined;
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0xb6d03983, Offset: 0x1651
// Size: 0x42
function addhudoutline( var_69a96ac7ade28fc1 )
{
    if ( !outline::function_546d21e688121132( var_69a96ac7ade28fc1, var_69a96ac7ade28fc1.var_3f3457f3778b49ca ) )
    {
        var_69a96ac7ade28fc1.var_3f3457f3778b49ca = outline::outlineenableforplayer( var_69a96ac7ade28fc1, self, "sniperbriefcase_scope", "killstreak" );
    }
}

// Namespace sniper_briefcase
// Params 3
// Checksum 0xa3b374de, Offset: 0x169b
// Size: 0x59
function function_e67e0fc84a8355ba( streakinfo, var_69a96ac7ade28fc1, playernum )
{
    addhudoutline( var_69a96ac7ade28fc1 );
    streakinfo.var_e10238c4d70a09b9[ playernum ] = var_69a96ac7ade28fc1;
    var_69a96ac7ade28fc1.var_c0e44c19a0a95c3c[ self.entnum ?? utility::get_entity_number( self ) ] = 1;
}

// Namespace sniper_briefcase
// Params 3
// Checksum 0x682eb374, Offset: 0x16fc
// Size: 0xfc
function function_ce67029717a37496( streakinfo, enemycorpse, enemyplayernum )
{
    streakinfo.var_a3e5afcf6e603fa8[ enemyplayernum ] = enemycorpse;
    addhudoutline( enemycorpse );
    fov = self playergetzoomfov();
    radius = self.var_ec0bb630fbaa253a[ streakinfo.bulletweapon ].var_d0479cded1ea362c.hudoutlineradius;
    
    while ( gettime() < enemycorpse.birthtime + 1500 && self playerads() > 0.95 && streakinfo.var_a3e5afcf6e603fa8[ enemyplayernum ] && !self.empcount )
    {
        corpsecentroid = enemycorpse getcentroid();
        
        if ( !self worldpointinreticle_circle( corpsecentroid, fov, radius ) )
        {
            break;
        }
        
        waitframe();
    }
    
    streakinfo.var_a3e5afcf6e603fa8[ enemyplayernum ] = undefined;
    removehudoutline( enemycorpse );
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x9b70971d, Offset: 0x1800
// Size: 0xa3
function function_455bc22a31be61c7( streakinfo )
{
    foreach ( enemy in streakinfo.var_e10238c4d70a09b9 )
    {
        if ( enemy )
        {
            function_a47dfe5531905673( streakinfo, enemy, enemy.entnum ?? utility::get_entity_number( enemy ) );
        }
    }
}

// Namespace sniper_briefcase
// Params 3
// Checksum 0x2fcc0d7f, Offset: 0x18ab
// Size: 0xb4
function function_a47dfe5531905673( streakinfo, var_69a96ac7ade28fc1, playernum )
{
    removehudoutline( var_69a96ac7ade28fc1 );
    streakinfo.var_e10238c4d70a09b9[ playernum ] = undefined;
    
    if ( isdefined( var_69a96ac7ade28fc1 ) )
    {
        if ( var_69a96ac7ade28fc1.var_c0e44c19a0a95c3c )
        {
            var_69a96ac7ade28fc1.var_c0e44c19a0a95c3c[ self.entnum ?? utility::get_entity_number( self ) ] = undefined;
        }
        
        var_69a96ac7ade28fc1.var_eec3766336d91616[ self.entnum ?? utility::get_entity_number( self ) ] = gettime();
        
        if ( isplayer( var_69a96ac7ade28fc1 ) )
        {
            var_69a96ac7ade28fc1 setclientomnvar( o"ui_sniper_briefcase_warning", 0 );
            var_69a96ac7ade28fc1 killstreak_utility::function_b3c5f355ab785704( "sniper_briefcase" );
        }
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x314d5487, Offset: 0x1967
// Size: 0x27
function sniperbriefcase_watchdeath( streakinfo )
{
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        function_455bc22a31be61c7( streakinfo );
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x3ff46e57, Offset: 0x1996
// Size: 0xc2
function function_67189fdbafebb3f( streakinfo )
{
    self notify( #"hash_90dc2ef36d64d8e7" );
    self endon( #"hash_90dc2ef36d64d8e7" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    result = streakinfo utility::waittill_any_return( streakinfo.bulletweapon + "_killstreak_ammo_used_all", streakinfo.bulletweapon + "_killstreak_use_duration_expired" );
    self setclientomnvar( level.streakglobals.var_d1ef34b4cd421758[ streakinfo.var_9384480e6997afd7 ], 0 );
    waitframe();
    self notify( result );
    self.sniperbriefcasekills = undefined;
    self.var_9798759b51747242 = undefined;
    
    if ( streakinfo )
    {
        streakinfo.var_963923073818c1fb = undefined;
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x714e05cb, Offset: 0x1a60
// Size: 0x63
function function_d0b7708e540cff08( streakinfo )
{
    self notify( #"hash_375ee774b4ca0839" );
    self endon( #"hash_375ee774b4ca0839" );
    streakinfo endon( streakinfo.bulletweapon + "_killstreak_ammo_used_all" );
    
    while ( true )
    {
        self waittill( #"emp_started", data );
        function_455bc22a31be61c7( streakinfo );
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0xd02632ae, Offset: 0x1acb
// Size: 0xe4
function sniperbriefcase_watchplayerdeath( streakinfo )
{
    self notify( #"hash_13086caa2832a0f0" );
    self endon( #"hash_13086caa2832a0f0" );
    streakinfo endon( streakinfo.bulletweapon + "_killstreak_ammo_used_all" );
    self waittill( #"death" );
    self notify( #"streak_end" );
    
    if ( streakinfo.usedbefore )
    {
        self.sniperbriefcasekills = undefined;
        self.var_9798759b51747242 = undefined;
    }
    
    if ( streakinfo && killstreaks::function_86ffe5755d194a83( streakinfo, "sat_ks_sniper_briefcase_mp" ) )
    {
        self setclientomnvar( o"ui_sniper_briefcase_duration", 0 );
        self setclientomnvar( o"ui_sniper_briefcase_start_time", 0 );
        streakinfo endon( streakinfo.bulletweapon + "_killstreak_ammo_used_all" );
        return;
    }
    
    if ( isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a[ streakinfo.bulletweapon ] = undefined;
    }
}

// Namespace sniper_briefcase
// Params 2
// Checksum 0xfe4ea8be, Offset: 0x1bb7
// Size: 0x9b
function function_348ab3f08e437dd2( streakitem, streakinfo )
{
    self notify( #"streak_end" );
    sniperbriefcasebundle = killstreak::function_85b2d8e857ab4898( "sniper_briefcase" );
    bulletweapon = sniperbriefcasebundle.deployweaponname ?? "sat_ks_sniper_briefcase_mp";
    
    if ( !isdefined( streakinfo ) )
    {
        streakinfo = self.var_ec0bb630fbaa253a[ bulletweapon ];
    }
    
    if ( !isdefined( streakinfo ) )
    {
        return;
    }
    
    function_455bc22a31be61c7( streakinfo );
    killstreak_utility::recordkillstreakendstats( streakinfo );
    
    if ( isdefined( self.var_ec0bb630fbaa253a ) )
    {
        self.var_ec0bb630fbaa253a[ bulletweapon ] = undefined;
    }
}

// Namespace sniper_briefcase
// Params 1
// Checksum 0x27b0a07b, Offset: 0x1c5a
// Size: 0x109
function function_25f59e450317d72a( params )
{
    attacker = params.attacker;
    idflags = params.idflags;
    objweapon = params.objweapon;
    
    if ( params.iskillstreakweapon && "sniper_briefcase" == killstreak::getkillstreaknamefromweapon( objweapon ) )
    {
        if ( !isdefined( attacker.sniperbriefcasekills ) )
        {
            attacker.sniperbriefcasekills = 0;
        }
        
        attacker.sniperbriefcasekills++;
        wallbang = attacker && idflags && idflags & 8 && !( idflags & 16384 );
        
        if ( wallbang )
        {
            if ( !isdefined( attacker.var_9798759b51747242 ) )
            {
                attacker.var_9798759b51747242 = 0;
            }
            
            attacker.var_9798759b51747242++;
            
            if ( attacker.var_9798759b51747242 == 3 )
            {
                attacker thread points::doscoreevent( #"sniper_briefcase_wall_hacks" );
            }
        }
    }
}

