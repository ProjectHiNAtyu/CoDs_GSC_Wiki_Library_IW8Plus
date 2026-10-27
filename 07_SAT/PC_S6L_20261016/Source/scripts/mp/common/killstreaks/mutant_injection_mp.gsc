// scripts\mp\common\killstreaks\mutant_injection_mp.gsc  (hash_47e04fe9b78c3fdb.gscc) (size: 8516 Bytes / 0x2144 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x820b6206 (2181784070)
// size ...... 8516 (0x2144)
// includes .. 14  (offset: 0x1f48)
// strings ... 17  (offset: 0x1fb8)
// dev strs .. 14  (offset: 0x209c)
// exports ... 26  (offset: 0x11bc)
// cseg ...... 0x15e + 0x105e (0x11bc)
// imports ... 83  (offset: 0x15cc)
// animtree1 . 0   (offset: 0x2144)
// animtree2 . 0   (offset: 0x2144)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\mutant_injection_shared;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\objidpoolmanager;

#namespace mutant_injection;

// Namespace mutant_injection
// Params 0, eflags: 0x1
// Checksum 0xf61753d, Offset: 0x17c
// Size: 0x22
function autoexec main()
{
    utility::registersharedfunc( #"mutant_injection", #"init", &init, 1 );
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xa12c9114, Offset: 0x1a6
// Size: 0x11a
function private init()
{
    utility::registersharedfunc( #"mutant_injection", #"getconfig", &getconfig );
    utility::registersharedfunc( #"mutant_injection", #"setcontext", &setcontext );
    utility::registersharedfunc( #"mutant_injection", #"removemutantinjection", &removemutantinjection );
    utility::registersharedfunc( #"mutant_injection", #"starttransformation", &starttransformation );
    utility::registersharedfunc( #"mutant_injection", #"getnearbytargets", &getnearbytargets );
    utility::registersharedfunc( #"mutant_injection", #"hash_63554db87d064a6b", &function_a3f71ecb6eb404cc );
    utility::registersharedfunc( #"mutant_injection", #"hash_d2f6004b101d75ea", &function_c059fcb8b93ffa03 );
    utility::registersharedfunc( #"mutant_injection", #"completetransformation", &completetransformation );
    utility::registersharedfunc( #"mutant_injection", #"hash_2f590838fdf8226f", &function_99c9f95e96f25130 );
    
    /#
        function_747263780094d57();
    #/
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x9a432295, Offset: 0x2c8
// Size: 0xbb
function private getconfig()
{
    bundle = level.streakglobals.streakbundles[ "zm_minj" ];
    config = {};
    config.maxhealth = bundle.mutantinjectiondata.manglerhealth ?? 800;
    config.startinghealth = config.maxhealth;
    config.manglercannondropweapon = bundle.mutantinjectiondata.manglercannonname ?? %"t10_la_mangler_cannon_mp";
    config.var_bf95338539967227 = 1;
    config.var_573b7ef5186ac8c6 = 1;
    return config;
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x36b4183b, Offset: 0x38c
// Size: 0xfd
function private setcontext( config, streakinfo )
{
    bundle = self.micontext.bundle;
    
    if ( bundle.mutantinjectiondata.var_a75ca531128dbabf )
    {
        self.micontext.partshealth = [];
        self.micontext.partshealth[ "j_gun" ] = bundle.mutantinjectiondata.manglercannonhealth ?? 100;
    }
    
    if ( bundle.mutantinjectiondata.var_a788fb2aed1e877e )
    {
        self.micontext.removeondeath = 1;
    }
    
    self.micontext.prevhealth = self.health;
    self.micontext.prevmaxhealth = self.maxhealth;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x1e054a7, Offset: 0x491
// Size: 0x5f
function private starttransformation()
{
    self setscriptablepartstate( "j_gun", "off" );
    self sethidenameplate( 1 );
    function_952d1de8c8e3f698( "sat_ui_waypoint_mangler_target" );
    self.damagemanglercannon = &damagemanglercannon;
    
    if ( self.micontext.removeondeath )
    {
        self.var_53fc5e1e26ae990f = &mutant_injection_shared::function_2b562b60a3d69e6f;
    }
    
    function_965b9d0fd3b6ecfc();
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0x998b925d, Offset: 0x4f8
// Size: 0xa7
function private getnearbytargets( radius )
{
    currentpos = self.origin;
    var_cd7fbd135a81723f = self.micontext.var_cd7fbd135a81723f;
    var_f4cfb89f123543d9 = self.micontext.var_f4cfb89f123543d9;
    
    if ( var_cd7fbd135a81723f && var_f4cfb89f123543d9 )
    {
        potentialtargets = getplayersandaiarrayinradius( currentpos, radius ) ?? [];
    }
    else if ( var_cd7fbd135a81723f )
    {
        potentialtargets = getaiarrayinradius( currentpos, radius ) ?? [];
    }
    else if ( var_f4cfb89f123543d9 )
    {
        potentialtargets = getplayersinradius( currentpos, radius ) ?? [];
    }
    
    return potentialtargets;
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xb3f791d7, Offset: 0x5a8
// Size: 0x31, Type: bool
function private function_a3f71ecb6eb404cc( target )
{
    if ( isplayer( target ) && player_utility::isenemy( target ) )
    {
        return true;
    }
    
    if ( isagent( target ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x9e845762, Offset: 0x5e2
// Size: 0x39
function private function_c059fcb8b93ffa03( target, damagescale = 3 )
{
    maxhealth = target.maxhealth;
    return maxhealth * damagescale;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xce5cdaaa, Offset: 0x624
// Size: 0x9f
function private completetransformation()
{
    self.maxhealth = self.micontext.miconfig.maxhealth;
    self.health = self.micontext.miconfig.startinghealth;
    self function_ec04263fa4f47f78( 1 );
    dialog::statusdialog( "mangler_friendly", self.team, "survivorWarning", [ self ] );
    dialog::statusdialog( "mangler_enemy", team_utility::getotherteam( self.team ) );
    thread watchforgameend();
    thread function_ec0cd0893c714743();
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xf6c00cc2, Offset: 0x6cb
// Size: 0x41
function private resetplayerhealth()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.maxhealth = self.micontext.prevmaxhealth;
    self.health = self.micontext.prevhealth;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x560689d7, Offset: 0x714
// Size: 0x3e
function private watchforgameend()
{
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self.micontext ) )
    {
        thread mutant_injection_shared::function_2b562b60a3d69e6f( 0, 1 );
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x8cc6ab4d, Offset: 0x75a
// Size: 0x6c
function private function_ec0cd0893c714743()
{
    level endon( #"game_ended" );
    self endon( #"mutantinjection_end" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self.micontext ) )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:self.micontext.streakinfo } );
        thread mutant_injection_shared::function_2b562b60a3d69e6f( 0, 1 );
    }
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0xca9457b9, Offset: 0x7ce
// Size: 0x6e
function private removemutantinjection( istimeout, skipanimation )
{
    self.damagemanglercannon = undefined;
    self function_ec04263fa4f47f78( 0 );
    self sethidenameplate( 0 );
    function_8244743e1d93edd();
    
    if ( self.micontext.removeondeath )
    {
        self.micontext.removeondeath = undefined;
    }
    
    if ( player::isreallyalive( self ) )
    {
        resetplayerhealth();
    }
}

// Namespace mutant_injection
// Params 4, eflags: 0x4
// Checksum 0x29a8f5f2, Offset: 0x844
// Size: 0x4f
function private damagemanglercannon( damage, hitloc, smeansofdeath, attacker )
{
    var_e628984c7b8aa67f = function_94b2f980f884bac3( hitloc, smeansofdeath, attacker );
    
    if ( !isdefined( var_e628984c7b8aa67f ) )
    {
        return;
    }
    
    function_cec743f91935a6e6( var_e628984c7b8aa67f, damage );
}

// Namespace mutant_injection
// Params 3, eflags: 0x4
// Checksum 0x8cc1aa77, Offset: 0x89b
// Size: 0x6f
function private function_94b2f980f884bac3( hitloc, smeansofdeath, attacker )
{
    var_e628984c7b8aa67f = undefined;
    
    if ( damage_utility::istorsoshot( hitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "j_gun";
    }
    
    /#
        if ( isdefined( hitloc ) && hitloc != "<dev string:x24>" && isplayer( attacker ) )
        {
            attacker iprintlnbold( "<dev string:x29>" + hitloc );
        }
    #/
    
    return var_e628984c7b8aa67f;
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x52dc866a, Offset: 0x913
// Size: 0x12b
function private function_5cdda63f595bfcbc()
{
    micontext = self.micontext;
    miconfig = micontext.miconfig;
    self notify( #"hash_3d677b7e1c78cd10" );
    
    if ( miconfig.infiniteammo )
    {
        weapon::stopinfiniteammothread();
    }
    
    var_a441f49e346e0bd7 = miconfig.manglercannondropweapon;
    manglercannonweapon = weapon_utility::function_d2c8356dc369d9ce( var_a441f49e346e0bd7 );
    assert( isdefined( manglercannonweapon ), "<dev string:x46>" );
    self giveweapon( manglercannonweapon );
    droppedgun = self dropitem( manglercannonweapon );
    
    if ( !isdefined( droppedgun ) )
    {
        self takeallweapons();
        return;
    }
    
    droppedgun.objweapon = manglercannonweapon;
    droppedgun.targetname = "dropped_weapon";
    waitframe();
    self takeallweapons();
    inventory_utility::_giveweapon( level.defaultfist );
    inventory_utility::_switchtoweaponimmediate( level.defaultfist );
    weapon::fixupplayerweapons( self, level.defaultfist );
    self.micontext.partshealth[ "j_gun" ] = undefined;
    self setscriptablepartstate( "j_gun", "destroyed_loot" );
}

// Namespace mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x2c97e32b, Offset: 0xa46
// Size: 0xb7
function private function_cec743f91935a6e6( part, damage )
{
    if ( isdefined( self.micontext.partshealth[ part ] ) )
    {
        self.micontext.partshealth[ part ] -= damage;
        self setscriptablepartstate( "cannon_weakpoint", "hit" );
        self setscriptablepartstate( "cannon_weakpoint", "default" );
        
        if ( self.micontext.partshealth[ part ] <= 0 )
        {
            self.micontext.partshealth[ part ] = undefined;
            thread function_5cdda63f595bfcbc();
        }
    }
}

// Namespace mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xd1411a02, Offset: 0xb05
// Size: 0x89
function private function_965b9d0fd3b6ecfc()
{
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_minj" ];
    self.var_a84311e2c57646de = &function_2517d13792310bd8;
    
    if ( !level.var_1b9830ec53186383 )
    {
        level.var_1b9830ec53186383 = 1;
        function_fcf5976652be830( 1, bundle.mutantinjectiondata.var_e4091068e46d716f ?? 0, undefined, undefined, 1 );
    }
}

// Namespace mutant_injection
// Params 5
// Checksum 0x1c98df8b, Offset: 0xb96
// Size: 0xa3
function function_fcf5976652be830( var_d648d1dbc51f0b0f, reduce_time, aicategory, means_of_death, var_f89e75bfc3059069 )
{
    if ( !isdefined( var_d648d1dbc51f0b0f ) || !isdefined( reduce_time ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_a417b33646ddb4b3 ) )
    {
        level.var_a417b33646ddb4b3 = [];
    }
    
    level.var_a417b33646ddb4b3[ level.var_a417b33646ddb4b3.size ] = { #var_f89e75bfc3059069:var_f89e75bfc3059069, #means_of_death:means_of_death, #aicategory:aicategory, #reduce_time:reduce_time, #var_d648d1dbc51f0b0f:var_d648d1dbc51f0b0f };
}

// Namespace mutant_injection
// Params 1, eflags: 0x4
// Checksum 0x3a26dbe1, Offset: 0xc41
// Size: 0x2d2
function private function_2517d13792310bd8( params )
{
    if ( params.eattacker != self && isplayer( params.eattacker ) && !player_utility::isenemy( params.eattacker ) )
    {
        return;
    }
    
    if ( !isplayer( params.eattacker ) && !isagent( params.eattacker ) && params.idamage >= self.health )
    {
        if ( params.smeansofdeath == "MOD_CRUSH" || params.smeansofdeath == "MOD_FALLING" || params.smeansofdeath == "MOD_TRIGGER_HURT" )
        {
            self kill();
        }
    }
    
    if ( params.eattacker && self.ismutantinjection )
    {
        foreach ( data in level.var_a417b33646ddb4b3 )
        {
            if ( params.idamage >= data.var_d648d1dbc51f0b0f )
            {
                if ( isdefined( data.aicategory ) && isagent( params.eattacker ) && params.eattacker.aicategory != data.aicategory )
                {
                    continue;
                }
                
                if ( isdefined( data.means_of_death ) && params.smeansofdeath != data.means_of_death )
                {
                    continue;
                }
                
                if ( params.eattacker.var_c4ad96ba9582dfec )
                {
                    continue;
                }
                
                if ( self.mutant_injection_end_time && data.var_d648d1dbc51f0b0f > 0 )
                {
                    reduce_time = int( data.var_f89e75bfc3059069 ? data.reduce_time * params.idamage / data.var_d648d1dbc51f0b0f : data.reduce_time );
                    mutant_injection_shared::function_4860a77f84a3ed4d( reduce_time * -1 );
                }
                
                if ( isplayer( params.eattacker ) )
                {
                    if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
                    {
                        params.eattacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "standard", 0, 0, undefined );
                    }
                }
            }
        }
    }
}

// Namespace mutant_injection
// Params 1
// Checksum 0xd3f48cd9, Offset: 0xf1b
// Size: 0x11b
function function_952d1de8c8e3f698( objicon )
{
    objid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objid < 0 )
    {
        return;
    }
    
    self.micontext.objidnum = objid;
    objective_icon( objid, objicon );
    objective_setbackground( objid, 0 );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, self.team );
    function_2b8e3d3ae2a6414a( objid, 1 );
    objective_removeallfrommask( objid );
    
    foreach ( p in level.players )
    {
        if ( player_utility::isenemy( p ) )
        {
            objective_addclienttomask( objid, p );
        }
    }
    
    objective_showtoplayersinmask( objid );
    objective_onentity( objid, self );
    objective_setzoffset( objid, 95 );
}

// Namespace mutant_injection
// Params 0
// Checksum 0x72ab1e2c, Offset: 0x103e
// Size: 0x45
function function_8244743e1d93edd()
{
    if ( self.micontext.objidnum )
    {
        objidpoolmanager::returnobjectiveid( self.micontext.objidnum );
        self.micontext.objidnum = undefined;
    }
}

// Namespace mutant_injection
// Params 0
// Checksum 0xe237b6e7, Offset: 0x108b
// Size: 0x2
function function_99c9f95e96f25130()
{
    
}

/#

    // Namespace mutant_injection
    // Params 0, eflags: 0x4
    // Checksum 0xd04f59b8, Offset: 0x1095
    // Size: 0x86, Type: dev
    function private function_747263780094d57()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6d>" );
        devgui::add_devgui_func( "<dev string:x82>", "<dev string:x9a>", &mutant_injection_shared::function_50daa7ab3c558bab );
        devgui::add_devgui_func( "<dev string:xb8>", "<dev string:xce>", &mutant_injection_shared::function_663e93cb28525637 );
        devgui::add_devgui_func( "<dev string:xe9>", "<dev string:x100>", &mutant_injection_shared::function_f7772824238349df );
        devgui::add_devgui_func( "<dev string:x119>", "<dev string:x12c>", &mutant_injection_shared::function_30d6debfc33678ce );
        devgui::add_devgui_func( "<dev string:x14c>", "<dev string:x163>", &function_f1e980787689edd3 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace mutant_injection
    // Params 0
    // Checksum 0xa40ea717, Offset: 0x1123
    // Size: 0x99, Type: dev
    function function_f1e980787689edd3()
    {
        level endon( #"game_ended" );
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.micontext ) )
            {
                player function_5cdda63f595bfcbc();
            }
        }
    }

#/
