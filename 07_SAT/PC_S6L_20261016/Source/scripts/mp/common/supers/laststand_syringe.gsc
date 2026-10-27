// scripts\mp\common\supers\laststand_syringe.gsc  (hash_704a4bee6b78f5e7.gscc) (size: 6123 Bytes / 0x17eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0eebab1 (2968435377)
// size ...... 6123 (0x17eb)
// includes .. 9   (offset: 0x16cb)
// strings ... 12  (offset: 0x1713)
// dev strs .. 0   (offset: 0x17eb)
// exports ... 17  (offset: 0xe9f)
// cseg ...... 0x155 + 0xd4a (0xe9f)
// imports ... 45  (offset: 0x1147)
// animtree1 . 0   (offset: 0x17eb)
// animtree2 . 0   (offset: 0x17eb)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\supers;

#namespace laststand_syringe;

// Namespace laststand_syringe
// Params 0, eflags: 0x1
// Checksum 0x919f1e4d, Offset: 0x173
// Size: 0xce
function autoexec main()
{
    supers_mp::function_adf2820d5daa2e81( getxhash( "super_laststand_syringe" ), &laststand_syringe_init );
    utility::registersharedfunc( #"super_laststand_syringe", #"beginuse", &function_f4d19f613af5597c );
    utility::registersharedfunc( #"super_laststand_syringe", #"enduse", &function_97b90a0bc1cfbfec );
    utility::registersharedfunc( #"super_laststand_syringe", #"hash_c3a450a375ef24ea", &function_6a663f1444c366f0 );
    utility::registersharedfunc( #"super_laststand_syringe", #"hash_21904dd7b76e4e86", &function_dd9128f0855b480b );
    callback::add( #"player_laststand_exit", &function_b4dcea8c98655c73 );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    callback::add( #"on_swim_enter", &function_d88da3aa8941f30c );
}

// Namespace laststand_syringe
// Params 0
// Checksum 0x1c3512cf, Offset: 0x249
// Size: 0x1e9
function laststand_syringe_init()
{
    laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    
    if ( !isdefined( laststand_syringe_bundle ) )
    {
        laststand_syringe_bundle = {};
    }
    
    if ( !isdefined( level.laststand_syringe_params ) )
    {
        level.laststand_syringe_params = { #fireprotection:laststand_syringe_bundle.var_dba95b3068f32dbd ?? 0, #meleeprotection:laststand_syringe_bundle.var_f034f0fd3b2d71bf ?? 0, #explosiveprotection:laststand_syringe_bundle.var_8698782fc5685248 ?? 0, #worldprotection:laststand_syringe_bundle.var_8a329872f04e8ef ?? 0, #headshotprotection:laststand_syringe_bundle.var_b72f599bca10e947 ?? 0, #laststandrevivehealth:laststand_syringe_bundle.laststand_revive_health ?? 50, #laststandhealth:laststand_syringe_bundle.laststand_health ?? 40, #stockammo:laststand_syringe_bundle.var_5ec5e0352969975d ?? 40, #clipammo:laststand_syringe_bundle.var_f620777164190945 ?? 8, #var_9521f626fcc1a680:laststand_syringe_bundle.var_f2c269b6b4111208 ?? 40, #var_b115e19a6eebb884:laststand_syringe_bundle.laststand_backup_pistol ?? "t10_pi_p14_mable_mp", #maxtime:laststand_syringe_bundle.usetime ?? 15, #laststandweaponcallback:&function_bfccf7f3b7b039f7 };
    }
    
    level.laststand_syringe_params.laststandhealth = int( min( level.laststand_syringe_params.laststandhealth, getmatchrulesdata( "commonOption", "maxHealth" ) ) );
    level.laststand_syringe_params.laststandrevivehealth = int( min( level.laststand_syringe_params.laststandrevivehealth, getmatchrulesdata( "commonOption", "maxHealth" ) ) );
}

// Namespace laststand_syringe
// Params 0
// Checksum 0xc1e39b5e, Offset: 0x43a
// Size: 0xd8, Type: bool
function function_f4d19f613af5597c()
{
    if ( level.var_916645300fa04eec )
    {
        return false;
    }
    
    if ( !isdefined( self.laststand_syringe_status ) )
    {
        self.laststand_syringe_status = { #selected_weapon:undefined, #var_450c442291e5ba1d:0, #var_73fe5f51164eb3ca:1, #revived:0 };
    }
    
    if ( isdefined( self.perks[ "specialty_pistoldeath" ] ) )
    {
        self.laststand_syringe_status.var_c39074384f5520d8 = 0;
    }
    else
    {
        perk::giveperk( "specialty_pistoldeath" );
        self.laststand_syringe_status.var_c39074384f5520d8 = 1;
    }
    
    thread function_ba8e8a25cbd6a5bb();
    thread function_90f6aabe80113e78();
    thread function_20e8cbd6d4273ec3();
    function_96df42bc1519ff1e();
    self setclientomnvar( "ui_last_stand_syringe_time", level.laststand_syringe_params.maxtime );
    return true;
}

// Namespace laststand_syringe
// Params 1
// Checksum 0x3012eca9, Offset: 0x51b
// Size: 0xf6
function function_97b90a0bc1cfbfec( fromdeath )
{
    self.laststand_syringe_status.var_73fe5f51164eb3ca = 0;
    supers_mp::function_dd6d97545b84597d( 0 );
    self setclientomnvar( "ui_last_stand_syringe_time", 0 );
    
    if ( !fromdeath )
    {
        if ( self.laststand_syringe_status.var_c39074384f5520d8 )
        {
            if ( isdefined( self.perks[ "specialty_pistoldeath" ] ) )
            {
                perk::removeperk( "specialty_pistoldeath" );
            }
        }
        
        laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
        
        if ( self.laststand_syringe_status.revived )
        {
            if ( isdefined( laststand_syringe_bundle.var_a81a398299607f84 ) )
            {
                self playlocalsound( laststand_syringe_bundle.var_a81a398299607f84 );
            }
        }
        else
        {
            self notify( #"laststand_syringe_expired" );
            
            if ( isdefined( laststand_syringe_bundle.var_1bcfa0ce5e4b2d76 ) )
            {
                self playlocalsound( laststand_syringe_bundle.var_1bcfa0ce5e4b2d76 );
            }
        }
    }
    
    self.laststand_syringe_status = undefined;
}

// Namespace laststand_syringe
// Params 0
// Checksum 0x2784c8bb, Offset: 0x619
// Size: 0x18c
function function_bfccf7f3b7b039f7()
{
    if ( isdefined( self.laststand_syringe_status.selected_weapon ) )
    {
        return self.laststand_syringe_status.selected_weapon;
    }
    
    if ( self.var_a96663d316e378d1.var_a98d727f0e6d914f )
    {
        self.laststand_syringe_status.var_450c442291e5ba1d = 1;
        self.laststand_syringe_status.var_758794892c4d0f = 1;
        self.laststand_syringe_status.var_c5837c6bf0b63314 = self.var_a96663d316e378d1.var_e2e91f5170debcf2 ?? 0;
        self.laststand_syringe_status.selected_weapon = self.currentweapon;
    }
    else if ( self.secondaryweaponobj.classname == "pistol" && !weapon_utility::isknifeonly( self.secondaryweaponobj ) )
    {
        self.laststand_syringe_status.var_450c442291e5ba1d = 2;
        self.laststand_syringe_status.selected_weapon = self.secondaryweaponobj;
    }
    else
    {
        self.laststand_syringe_status.var_450c442291e5ba1d = 0;
        laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
        self.laststand_syringe_status.selected_weapon = weapon_utility::function_d2c8356dc369d9ce( laststand_syringe_bundle.laststand_backup_pistol ?? "t10_pi_p14_mable_mp" );
    }
    
    return self.laststand_syringe_status.selected_weapon;
}

// Namespace laststand_syringe
// Params 0, eflags: 0x4
// Checksum 0x2250dfb3, Offset: 0x7ae
// Size: 0x175
function private function_ba8e8a25cbd6a5bb()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"laststand_syringe_expired" );
    self.var_7e5719799a02450d = undefined;
    self waittill( #"last_stand_exit" );
    function_44cef613d4a9ad0e();
    
    if ( self.laststand_syringe_status.laststandkill && isdefined( self.laststand_syringe_status.var_647c1347cc42fe9a ) )
    {
        superinfo = supers_mp::getcurrentsuper();
        var_d15050d2f9c97607 = superinfo.staticdata.objweapon;
        thread gamelogic_mp::threadedsetweaponstatbyname( var_d15050d2f9c97607, 1, "buff_kills" );
        self.laststand_syringe_status.var_647c1347cc42fe9a thread gamelogic_mp::threadedsetweaponstatbyname( var_d15050d2f9c97607, 1, "killed_by" );
    }
    
    if ( self.laststand_syringe_status.var_7d62ef0da2c04879 )
    {
        self setweaponammoclip( self.secondaryweaponobj, self.laststand_syringe_status.returnammoclip );
        self setweaponammostock( self.secondaryweaponobj, self.laststand_syringe_status.returnammostock );
    }
    
    waitframe();
    self.laststand_syringe_status.revived = 1;
    
    if ( self.laststand_syringe_status.laststandkill )
    {
        self.var_7e5719799a02450d = 1;
    }
    
    supers_mp::superusefinished( 0, 0, 0, 1, undefined );
}

// Namespace laststand_syringe
// Params 0, eflags: 0x4
// Checksum 0x3fbe1987, Offset: 0x92b
// Size: 0x19a
function private function_90f6aabe80113e78()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"laststand_syringe_expired" );
    self waittill( #"last_stand_enter" );
    supers_mp::function_dd6d97545b84597d( 1 );
    self setclientomnvar( "ui_last_stand_syringe_time", 0 );
    
    while ( !self.var_cc09887c7db65ab5 )
    {
        waitframe();
    }
    
    currentweapon = self.laststand_syringe_status.selected_weapon;
    
    if ( self.laststand_syringe_status.var_450c442291e5ba1d == 2 )
    {
        self.laststand_syringe_status.returnammoclip = self getweaponammoclip( currentweapon );
        self.laststand_syringe_status.returnammostock = self getweaponammostock( currentweapon );
        self.laststand_syringe_status.var_7d62ef0da2c04879 = 1;
    }
    
    if ( self.laststand_syringe_status.var_450c442291e5ba1d != 1 )
    {
        clipsize = weaponclipsize( currentweapon );
        laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
        num_mags = laststand_syringe_bundle.var_a81f18ec74189d49 ?? 1;
        
        if ( num_mags > 0 )
        {
            self setweaponammoclip( currentweapon, clipsize );
            self setweaponammostock( currentweapon, int( ( num_mags - 1 ) * clipsize ) );
        }
        else
        {
            self setweaponammoclip( currentweapon, int( clipsize * num_mags ) );
            self setweaponammostock( currentweapon, 0 );
        }
    }
    
    if ( self isswimming() )
    {
        function_d44a3f5a843c9214();
    }
    
    self.laststand_syringe_status.inlaststand = 1;
}

// Namespace laststand_syringe
// Params 0, eflags: 0x4
// Checksum 0xcdf1fe86, Offset: 0xacd
// Size: 0x48
function private function_96df42bc1519ff1e()
{
    laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    
    if ( laststand_syringe_bundle.var_ffb526d615bcaeca && isdefined( laststand_syringe_bundle.var_2d18487ca57db925 ) )
    {
        pbgpostfxbundlestart( self, laststand_syringe_bundle.var_2d18487ca57db925 );
    }
}

// Namespace laststand_syringe
// Params 0, eflags: 0x4
// Checksum 0x3e00440f, Offset: 0xb1d
// Size: 0x48
function private function_44cef613d4a9ad0e()
{
    laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    
    if ( laststand_syringe_bundle.var_3a689b8112efea99 && isdefined( laststand_syringe_bundle.var_16782fc95fd2f5e ) )
    {
        pbgpostfxbundlestart( self, laststand_syringe_bundle.var_16782fc95fd2f5e );
    }
}

// Namespace laststand_syringe
// Params 0, eflags: 0x4
// Checksum 0x57ba6c18, Offset: 0xb6d
// Size: 0xb3
function private function_20e8cbd6d4273ec3()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"laststand_syringe_expired" );
    laststand_syringe_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    
    if ( isdefined( laststand_syringe_bundle.var_e6529f8aafbdd69 ) )
    {
        var_a6bae9552771ca6f = laststand_syringe_bundle.var_2700342b6bd8f834 ?? 3;
        
        if ( var_a6bae9552771ca6f < level.laststand_syringe_params.maxtime )
        {
            wait level.laststand_syringe_params.maxtime - var_a6bae9552771ca6f;
            self playlocalsound( laststand_syringe_bundle.var_e6529f8aafbdd69 );
        }
    }
}

// Namespace laststand_syringe
// Params 1
// Checksum 0x5b041938, Offset: 0xc28
// Size: 0x36
function function_b4dcea8c98655c73( params )
{
    if ( player::function_73fe5f51164eb3ca( self ) && params.reason === "last_stand_self_revive" )
    {
        self playlocalsound( "fup_laststand_kill_revive" );
    }
}

// Namespace laststand_syringe
// Params 0
// Checksum 0xceb5793e, Offset: 0xc66
// Size: 0x10b
function function_d44a3f5a843c9214()
{
    if ( self.laststand_syringe_status.var_450c442291e5ba1d == 0 )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    
    if ( !bundle.laststand_backup_pistol )
    {
        return;
    }
    
    clipammo = self getweaponammoclip( self.laststand_syringe_status.selected_weapon );
    stockammo = self getweaponammostock( self.laststand_syringe_status.selected_weapon );
    fallbackweapon = weapon_utility::function_d2c8356dc369d9ce( bundle.laststand_backup_pistol );
    inventory_utility::_giveweapon( fallbackweapon, undefined, undefined, 1, 1 );
    self switchtoweaponimmediate( fallbackweapon );
    self setweaponammoclip( fallbackweapon, min( clipammo, weaponclipsize( fallbackweapon ) ) );
    self setweaponammostock( fallbackweapon, stockammo );
    self.laststand_syringe_status.selected_weapon = fallbackweapon;
    self.laststand_syringe_status.var_450c442291e5ba1d = 0;
    self.laststandweaponobj = fallbackweapon;
}

// Namespace laststand_syringe
// Params 0
// Checksum 0xe6d5c7bb, Offset: 0xd79
// Size: 0x2c, Type: bool
function function_6a663f1444c366f0()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    return bundle.var_a86113e3c5133a83 ?? "hud_realism_head_revive";
}

// Namespace laststand_syringe
// Params 0
// Checksum 0xd1a33191, Offset: 0xdae
// Size: 0x29, Type: bool
function function_dd9128f0855b480b()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_laststand_syringe" );
    return bundle.var_f511c1af4d9a85fc ?? 1;
}

// Namespace laststand_syringe
// Params 1, eflags: 0x4
// Checksum 0x4e94ebf6, Offset: 0xde0
// Size: 0x8e
function private onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( attacker.laststand_syringe_status.inlaststand )
    {
        attacker.laststand_syringe_status.laststandkill = 1;
        attacker.laststand_syringe_status.var_647c1347cc42fe9a = victim;
    }
}

// Namespace laststand_syringe
// Params 1
// Checksum 0x52938747, Offset: 0xe76
// Size: 0x29
function function_d88da3aa8941f30c( params )
{
    if ( self.laststand_syringe_status.inlaststand )
    {
        function_d44a3f5a843c9214();
    }
}

