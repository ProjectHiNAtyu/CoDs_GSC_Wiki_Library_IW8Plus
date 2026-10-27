// scripts\mp\common\killstreaks\mutant_injection_disciple_mp.gsc  (hash_2565ae5e98ab6d9d.gscc) (size: 7577 Bytes / 0x1d99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbecbb4c6 (3201021126)
// size ...... 7577 (0x1d99)
// includes .. 13  (offset: 0x1c25)
// strings ... 18  (offset: 0x1c8d)
// dev strs .. 4   (offset: 0x1d69)
// exports ... 27  (offset: 0xe69)
// cseg ...... 0x220 + 0xc49 (0xe69)
// imports ... 83  (offset: 0x12a1)
// animtree1 . 0   (offset: 0x1d99)
// animtree2 . 0   (offset: 0x1d99)
#using script_214060780e647f61;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\objidpoolmanager;

#namespace mutant_injection_disciple_mp;

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x1
// Checksum 0xc658d84f, Offset: 0x23e
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"zm_dinj", #"init", &init );
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0xaf50b53b, Offset: 0x266
// Size: 0x2a9
function private init()
{
    utility::registersharedfunc( #"zm_dinj", #"getconfig", &getconfig );
    utility::registersharedfunc( #"zm_dinj", #"setcontext", &setcontext );
    utility::registersharedfunc( #"zm_dinj", #"starttransformation", &starttransformation );
    utility::registersharedfunc( #"zm_dinj", #"getnearbytargets", &getnearbytargets );
    utility::registersharedfunc( #"zm_dinj", #"hash_63554db87d064a6b", &function_a3f71ecb6eb404cc );
    utility::registersharedfunc( #"zm_dinj", #"hash_737633f5a317c5cf", &function_5da7e225cbfb13ae );
    utility::registersharedfunc( #"zm_dinj", #"completetransformation", &completetransformation );
    utility::registersharedfunc( #"zm_dinj", #"removemutantinjection", &removemutantinjection );
    utility::registersharedfunc( #"zm_dinj", #"hash_2f590838fdf8226f", &function_99c9f95e96f25130 );
    utility::registersharedfunc( #"zm_dinj", #"hash_9b359784e8530f5", &function_ba3d79cb556f9f5a );
    utility::registersharedfunc( #"zm_dinj", #"hash_d2f6004b101d75ea", &function_c059fcb8b93ffa03 );
    utility::registersharedfunc( #"zm_dinj", #"give_ammo", &full_ammo::function_cf46f312587658ee );
    utility::registersharedfunc( #"zm_dinj", #"drainlife", &watchdrainlife );
    utility::registersharedfunc( #"zm_dinj", #"hash_25813f7a5a02ae90", &function_c700123edd4ca05f );
    utility::registersharedfunc( #"zm_dinj", #"scream", &function_ba1287ece709a0eb );
    utility::registersharedfunc( #"zm_dinj", #"hash_73388df4a8875c87", &function_8f9f9a1061809b7a );
    utility::registersharedfunc( #"zm_dinj", #"hash_dfab93a6c53cf329", &function_ecc9b1d7fb6089b6 );
    utility::registersharedfunc( #"zm_dinj", #"hash_2f14a34a4aa8f645", &function_2b0a975a1895015c );
    utility::registersharedfunc( #"zm_dinj", #"hash_630da97e3b3ba2d6", &function_a16be694f3cc5c4d );
    level._effect[ "mutant_injection_zombie_annihilate" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_weap_mangler_zombie_annihilate_1" );
    utility::add_fx( "minj_disciple_lifedrain_beam_fx", "vfx_sat_gameplay_zm_weapons_dinj_drain_beam" );
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &mutant_injection_disciple_zombies::function_65b40f31d56d5b2c );
    }
    
    /#
        function_747263780094d57();
    #/
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0x87a08148, Offset: 0x517
// Size: 0x8e
function private getconfig()
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    config = {};
    config.maxhealth = bundle.mutantinjectiondata.manglerhealth ?? 800;
    config.startinghealth = config.maxhealth;
    config.var_bf95338539967227 = 1;
    config.var_573b7ef5186ac8c6 = 1;
    return config;
}

// Namespace mutant_injection_disciple_mp
// Params 2, eflags: 0x4
// Checksum 0x1fe5f902, Offset: 0x5ae
// Size: 0xde
function private setcontext( config, streakinfo )
{
    mutant_injection_disciple_zombies::setcontext( config, streakinfo );
    
    if ( self.micontext )
    {
        bundle = self.micontext.bundle;
        
        if ( bundle.mutantinjectiondata.var_a788fb2aed1e877e )
        {
            self.micontext.removeondeath = 1;
        }
        
        self.micontext.prevhealth = self.health;
        self.micontext.prevmaxhealth = self.maxhealth;
        self.micontext.var_20b536a9378bf072 = 1;
        self.micontext.var_351060baffe07228 = 1;
    }
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0x832c488a, Offset: 0x694
// Size: 0x41
function private starttransformation()
{
    mutant_injection_disciple_zombies::starttransformation();
    self sethidenameplate( 1 );
    function_c2c48a3d0f7f1af3( "sat_ui_waypoint_disciple_target" );
    
    if ( self.micontext.removeondeath )
    {
        self.var_53fc5e1e26ae990f = &mutant_injection_utility::function_2b562b60a3d69e6f;
    }
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0xd29b968c, Offset: 0x6dd
// Size: 0xa7
function private completetransformation()
{
    self.maxhealth = self.micontext.miconfig.maxhealth;
    self.health = self.micontext.miconfig.startinghealth;
    self function_ec04263fa4f47f78( 1 );
    self setcandamage( 1 );
    dialog::statusdialog( "disciple_friendly", self.team, "survivorWarning", [ self ] );
    dialog::statusdialog( "disciple_enemy", team_utility::getotherteam( self.team ) );
    thread watchforgameend();
    thread function_ec0cd0893c714743();
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0xe341c74d, Offset: 0x78c
// Size: 0x14
function private getnearbytargets( radius )
{
    return mutant_injection_disciple_zombies::getnearbytargets( radius );
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0x8c686e9d, Offset: 0x7a9
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

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0xc95ff388, Offset: 0x7e3
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

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0xf01d0027, Offset: 0x82c
// Size: 0x3e
function private watchforgameend()
{
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self.micontext ) )
    {
        thread mutant_injection_utility::function_2b562b60a3d69e6f( 0, 1 );
    }
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0x2add22bd, Offset: 0x872
// Size: 0x6c
function private function_ec0cd0893c714743()
{
    level endon( #"game_ended" );
    self endon( #"mutantinjection_end" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self.micontext ) )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:self.micontext.streakinfo } );
        thread mutant_injection_utility::function_2b562b60a3d69e6f( 0, 1 );
    }
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0x8da5574, Offset: 0x8e6
// Size: 0x14
function private function_5da7e225cbfb13ae( target )
{
    return mutant_injection_disciple_zombies::function_5da7e225cbfb13ae( target );
}

// Namespace mutant_injection_disciple_mp
// Params 2, eflags: 0x4
// Checksum 0x90bfc4a7, Offset: 0x903
// Size: 0xb1
function private removemutantinjection( istimeout = 0, skipanimation = 0 )
{
    mutant_injection_disciple_zombies::removemutantinjection( istimeout, skipanimation );
    self function_ec04263fa4f47f78( 0 );
    self sethidenameplate( 0 );
    function_816eb5306753e48c();
    self.damagemanglercannon = undefined;
    
    if ( self.micontext.removeondeath )
    {
        self.micontext.removeondeath = undefined;
    }
    
    if ( self.micontext.var_53fc5e1e26ae990f )
    {
        self.micontext.var_53fc5e1e26ae990f = undefined;
    }
    
    if ( player::isreallyalive( self ) )
    {
        resetplayerhealth();
    }
}

// Namespace mutant_injection_disciple_mp
// Params 4, eflags: 0x4
// Checksum 0x5eb991f4, Offset: 0x9bc
// Size: 0x34
function private function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale )
{
    mutant_injection_disciple_zombies::function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale );
}

// Namespace mutant_injection_disciple_mp
// Params 2, eflags: 0x4
// Checksum 0x801f6bb7, Offset: 0x9f8
// Size: 0x1e
function private function_c059fcb8b93ffa03( target, damagescale )
{
    return mutant_injection_disciple_zombies::function_c059fcb8b93ffa03( target, damagescale );
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0xbd4198e9, Offset: 0xa1f
// Size: 0x9
function private watchdrainlife()
{
    thread mutant_injection_disciple_zombies::watchdrainlife();
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0xa735f826, Offset: 0xa30
// Size: 0x9
function private function_c700123edd4ca05f()
{
    thread mutant_injection_disciple_zombies::function_c700123edd4ca05f();
}

// Namespace mutant_injection_disciple_mp
// Params 0, eflags: 0x4
// Checksum 0x9f82b574, Offset: 0xa41
// Size: 0x9
function private function_ba1287ece709a0eb()
{
    thread mutant_injection_disciple_zombies::function_ba1287ece709a0eb();
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0x98a8c8f8, Offset: 0xa52
// Size: 0xca
function private function_a16be694f3cc5c4d( victim )
{
    level endon( #"game_ended" );
    victim endon( #"disconnect" );
    victim notify( #"shockstick_haywireapplied" );
    victim endon( #"shockstick_haywireapplied" );
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    weapon = mutant_injection_disciple_zombies::function_eec781547b670f5();
    data = damage_utility::packdamagedata( self, victim, 0, weapon, "MOD_EXPLOSIVE", self, self.origin );
    shock_stick::shockstick_applyhaywirestruct( data );
    shock_stick::function_91912910551a1283( data, bundle.mutantinjectiondata.var_6de553651e492660 );
    shock_stick::function_396a585ccd7071f5( data, 0 );
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0x5a6ed87a, Offset: 0xb24
// Size: 0x67
function private function_8f9f9a1061809b7a( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
        {
            params.eattacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "standard", 0, 0, undefined );
        }
    }
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0xc3415185, Offset: 0xb93
// Size: 0x54, Type: bool
function private function_ecc9b1d7fb6089b6( target )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) && !player_utility::isenemy( target ) )
    {
        return false;
    }
    
    if ( target.aicategory == "boss" )
    {
        return false;
    }
    
    if ( !target isscriptable() )
    {
        return false;
    }
    
    return true;
}

// Namespace mutant_injection_disciple_mp
// Params 1, eflags: 0x4
// Checksum 0x21ccba01, Offset: 0xbf0
// Size: 0xc2, Type: bool
function private function_2b0a975a1895015c( target )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) )
    {
        return false;
    }
    
    if ( target.disallow_grab )
    {
        return false;
    }
    
    if ( target.magic_bullet_shield || target.damageshield )
    {
        return false;
    }
    
    if ( isanimscripted( target ) )
    {
        return false;
    }
    
    return target.subclass == "zombie_base" || target.subclass == "zombie_base_armored_light" || target.subclass == "zombie_base_armored_heavy" || target.subclass == "zombie_shade" || target.subclass == "zombie_methone";
}

// Namespace mutant_injection_disciple_mp
// Params 1
// Checksum 0x37337abe, Offset: 0xcbb
// Size: 0x11b
function function_c2c48a3d0f7f1af3( objicon )
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
    objective_setzoffset( objid, 90 );
}

// Namespace mutant_injection_disciple_mp
// Params 0
// Checksum 0xffae60fe, Offset: 0xdde
// Size: 0x45
function function_816eb5306753e48c()
{
    if ( self.micontext.objidnum )
    {
        objidpoolmanager::returnobjectiveid( self.micontext.objidnum );
        self.micontext.objidnum = undefined;
    }
}

// Namespace mutant_injection_disciple_mp
// Params 0
// Checksum 0xdda849ad, Offset: 0xe2b
// Size: 0x2
function function_99c9f95e96f25130()
{
    
}

/#

    // Namespace mutant_injection_disciple_mp
    // Params 0, eflags: 0x4
    // Checksum 0x9b85a13b, Offset: 0xe35
    // Size: 0x34, Type: dev
    function private function_747263780094d57()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x39>", "<dev string:x52>" + "<dev string:x75>", &mutant_injection_utility::function_50daa7ab3c558bab );
        devgui::function_77df7fe7dd273e10();
    }

#/
