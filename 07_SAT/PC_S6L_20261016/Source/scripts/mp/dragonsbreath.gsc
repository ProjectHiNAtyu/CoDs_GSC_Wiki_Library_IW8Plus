// scripts\mp\dragonsbreath.gsc  (hash_1e8f3bc97f602082.gscc) (size: 8588 Bytes / 0x218c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae07283f (2919704639)
// size ...... 8588 (0x218c)
// includes .. 5   (offset: 0x1f5c)
// strings ... 28  (offset: 0x1f84)
// dev strs .. 1   (offset: 0x2180)
// exports ... 21  (offset: 0x178c)
// cseg ...... 0x2ef + 0x149d (0x178c)
// imports ... 37  (offset: 0x1ad4)
// animtree1 . 0   (offset: 0x218c)
// animtree2 . 0   (offset: 0x218c)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;

#namespace dragonsbreath;

// Namespace dragonsbreath
// Params 0, eflags: 0x1
// Checksum 0xe3de3da6, Offset: 0x30d
// Size: 0x1ee
function autoexec initdragonsbreath()
{
    overridevalues = istrue( level.gametypebundle.var_9fe335fefd960436 );
    level.dragonsbreathdata = { #firedamageweapon:overridevalues ? level.gametypebundle.dragonsbreathoverrides.firedamageweapon : "dragonsbreath_mp", #var_c2acefbae901858:overridevalues ? level.gametypebundle.dragonsbreathoverrides.var_c2acefbae901858 : 3, #var_8843469331569751:overridevalues ? level.gametypebundle.dragonsbreathoverrides.var_5d9456581fc9be99 : 4, #var_58521575e5f9ccdb:overridevalues ? level.gametypebundle.dragonsbreathoverrides.var_58521575e5f9ccdb : 10, #var_6bb9b27a3aad49b6:overridevalues ? level.gametypebundle.dragonsbreathoverrides.var_6bb9b27a3aad49b6 : 0.25, #var_8a85c6aea27a2f08:overridevalues ? level.gametypebundle.dragonsbreathoverrides.var_8a85c6aea27a2f08 : 1, #burntimecap:overridevalues ? level.gametypebundle.dragonsbreathoverrides.burntimecap : 4, #burntime:overridevalues ? level.gametypebundle.dragonsbreathoverrides.burntime : 0.5 };
    utility::registersharedfunc( #"hash_2e4d9770285c43d1", #"hash_b3b9e769b19108fd", &isdragonsbreathweapon );
    callback::add( #"on_player_clear_burning", &function_122a80904195ee86 );
}

// Namespace dragonsbreath
// Params 0
// Checksum 0x5c094db1, Offset: 0x503
// Size: 0x3f
function function_9829423140f8ffeb()
{
    dragonsbreathdamage = spawnstruct();
    dragonsbreathdamage.newhitlocs = [];
    dragonsbreathdamage.hitslocs = [];
    dragonsbreathdamage.burningstate = "neutral";
    return dragonsbreathdamage;
}

// Namespace dragonsbreath
// Params 3
// Checksum 0x8f500afc, Offset: 0x54b
// Size: 0xaf
function function_6e45d22ffdfaeade( newhitlocs, attacker, objweapon )
{
    foreach ( part in newhitlocs )
    {
        if ( isshield( part ) )
        {
            newhitlocs = arrayremove( newhitlocs, part );
        }
    }
    
    if ( newhitlocs.size == 0 )
    {
        return;
    }
    
    thread function_a5196650e2f7ad1d( newhitlocs, attacker, objweapon );
}

// Namespace dragonsbreath
// Params 1
// Checksum 0x2b45c22, Offset: 0x602
// Size: 0x4e
function function_9db00fb5b6541561( objweapon )
{
    corpsetable = self getcorpseentity();
    
    if ( !isdefined( corpsetable ) )
    {
        return;
    }
    
    function_ae48408627975c7a( objweapon );
    corpsetable setscriptablepartstate( self.dragonsbreathdamage.scriptablepart, "flareUp", 0 );
}

// Namespace dragonsbreath
// Params 0
// Checksum 0x2f27adcd, Offset: 0x658
// Size: 0x1d
function function_f4b267b485217e63()
{
    self notify( #"hash_a91ea20949c36b49" );
    self.dragonsbreathdamage = function_9829423140f8ffeb();
}

// Namespace dragonsbreath
// Params 3
// Checksum 0x25c424f8, Offset: 0x67d
// Size: 0x34c
function function_a5196650e2f7ad1d( newburningparts, attacker, objweapon )
{
    self notify( #"newburningparts" );
    self endon( #"disconnect" );
    self endon( #"newburningparts" );
    self endon( #"hash_a91ea20949c36b49" );
    newburningparts = arrayremoveduplicates( newburningparts );
    
    foreach ( part in newburningparts )
    {
        if ( isdefined( self.dragonsbreathdamage.hitslocs[ part ] ) )
        {
            self.dragonsbreathdamage.hitslocs[ part ] += level.dragonsbreathdata.burntime;
            
            if ( getweaponhasperk( objweapon, "specialty_ub_flamethrower" ) )
            {
                self.dragonsbreathdamage.hitslocs[ part ] = min( self.dragonsbreathdamage.hitslocs[ part ], level.dragonsbreathdata.var_8a85c6aea27a2f08 );
            }
            else
            {
                self.dragonsbreathdamage.hitslocs[ part ] = min( self.dragonsbreathdamage.hitslocs[ part ], level.dragonsbreathdata.burntimecap );
            }
            
            continue;
        }
        
        self.dragonsbreathdamage.hitslocs[ part ] = level.dragonsbreathdata.burntime;
    }
    
    function_ae48408627975c7a( objweapon );
    function_da92183026c23d34();
    
    while ( true )
    {
        wait level.dragonsbreathdata.var_6bb9b27a3aad49b6;
        
        if ( !player::isreallyalive( self ) || self.dragonsbreathdamage.hitslocs.size == 0 )
        {
            break;
        }
        
        statechange = 0;
        function_403744f8f3646e3f( attacker, objweapon );
        
        foreach ( key, hitsloc in self.dragonsbreathdamage.hitslocs )
        {
            self.dragonsbreathdamage.hitslocs[ key ] -= level.dragonsbreathdata.var_6bb9b27a3aad49b6;
            
            if ( self.dragonsbreathdamage.hitslocs[ key ] <= 0 )
            {
                self.dragonsbreathdamage.hitslocs[ key ] = undefined;
                statechange = 1;
            }
        }
        
        if ( statechange )
        {
            function_ae48408627975c7a( objweapon );
            function_da92183026c23d34();
        }
    }
}

// Namespace dragonsbreath
// Params 2
// Checksum 0xb1185050, Offset: 0x9d1
// Size: 0x163
function function_403744f8f3646e3f( attacker, objweapon )
{
    if ( isalive( attacker ) )
    {
        attacker endon( #"death" );
        db_weapon = makeweapon( level.dragonsbreathdata.firedamageweapon );
        attacker weapon_utility::function_502496613f00eb2a( db_weapon, objweapon );
        var_ee65d132406fafe6 = level.dragonsbreathdata.var_58521575e5f9ccdb * level.dragonsbreathdata.var_6bb9b27a3aad49b6 / level.dragonsbreathdata.burntime;
        numevents = min( self.dragonsbreathdamage.hitslocs.size, level.dragonsbreathdata.var_c2acefbae901858 );
        damagepertick = int( var_ee65d132406fafe6 * numevents );
        
        if ( getweaponhasperk( objweapon, "specialty_ub_flamethrower" ) )
        {
            var_ee65d132406fafe6 = level.dragonsbreathdata.var_8843469331569751 * level.dragonsbreathdata.var_6bb9b27a3aad49b6 / level.dragonsbreathdata.burntime;
            damagepertick = int( var_ee65d132406fafe6 * numevents );
        }
        
        if ( damagepertick > 0 )
        {
            self dodamage( damagepertick, attacker.origin, attacker, attacker, "MOD_FIRE", db_weapon, "torso_upper" );
        }
    }
}

// Namespace dragonsbreath
// Params 1
// Checksum 0x1e7badc8, Offset: 0xb3c
// Size: 0x99
function function_ae48408627975c7a( objweapon )
{
    self.dragonsbreathdamage.scriptablepart = "burning";
    
    if ( objweapon.underbarrel == "jup_ub_flame_01" && objweapon.underbarrelvarindex == 5 )
    {
        self.dragonsbreathdamage.scriptablepart = "virus";
    }
    
    if ( !self getscriptablehaspart( self.dragonsbreathdamage.scriptablepart ) )
    {
        self.dragonsbreathdamage.scriptablepart = "burning";
    }
}

// Namespace dragonsbreath
// Params 0
// Checksum 0xc8643d5d, Offset: 0xbdd
// Size: 0x434
function function_da92183026c23d34()
{
    burningstate = "";
    points = [];
    points[ "al_" ] = 0;
    points[ "to_" ] = 0;
    points[ "ar_" ] = 0;
    points[ "ll_" ] = 0;
    points[ "lr" ] = 0;
    
    if ( !isdefined( self.dragonsbreathdamage ) )
    {
        return;
    }
    
    hitlocs = self.dragonsbreathdamage.hitslocs;
    
    if ( isdefined( self.var_3409becd9d39cca9 ) )
    {
        foreach ( damagestruct in self.var_3409becd9d39cca9 )
        {
            if ( !isdefined( hitlocs[ damagestruct.hitloc ] ) )
            {
                hitlocs[ damagestruct.hitloc ] = 1;
                continue;
            }
            
            hitlocs[ damagestruct.hitloc ] += 1;
        }
    }
    
    if ( isdefined( self.dragonsbreathdamage.var_ade0789cb6b9323d ) )
    {
        foreach ( burningparts in self.dragonsbreathdamage.var_ade0789cb6b9323d )
        {
            if ( !isdefined( hitlocs[ burningparts ] ) )
            {
                hitlocs[ burningparts ] = 2;
                continue;
            }
            
            hitlocs[ burningparts ] += 1;
        }
    }
    
    foreach ( hitlocname, hitlocvalue in hitlocs )
    {
        burningpart = function_3542513c121ddbdd( hitlocname );
        
        if ( isdefined( burningpart ) )
        {
            points[ burningpart ] += hitlocvalue;
        }
        
        /#
            if ( !isdefined( burningpart ) )
            {
                assertmsg( "<dev string:x24>" );
            }
        #/
    }
    
    if ( points[ "al_" ] > 0 || points[ "to_" ] >= 2 )
    {
        burningstate += "al_";
    }
    
    if ( points[ "to_" ] > 0 || points[ "al_" ] >= 2 || points[ "ar_" ] >= 2 )
    {
        burningstate += "to_";
    }
    
    if ( points[ "ar_" ] > 0 || points[ "to_" ] >= 2 )
    {
        burningstate += "ar_";
    }
    
    if ( points[ "ll_" ] > 0 || points[ "lr" ] >= 2 )
    {
        burningstate += "ll_";
    }
    
    if ( points[ "lr" ] > 0 || points[ "ll_" ] >= 2 )
    {
        burningstate += "lr";
    }
    
    if ( burningstate == "al_to_ar_ll_" || burningstate == "al_to_ar_lr" || burningstate == "al_to_ll_lr" || burningstate == "al_ar_ll_lr" || burningstate == "to_ar_ll_lr" || burningstate == "al_to_ar_ll_lr" )
    {
        burningstate = "all_parts";
    }
    else if ( burningstate == "" )
    {
        burningstate = "neutral";
    }
    
    if ( burningstate != self.dragonsbreathdamage.burningstate )
    {
        if ( burningstate == "neutral" )
        {
            damage_effects::disableburnfx( 1, self.dragonsbreathdamage.burningstate, self.dragonsbreathdamage.scriptablepart );
        }
        else
        {
            damage_effects::enableburnfx( 1, burningstate, self.dragonsbreathdamage.scriptablepart );
        }
        
        self.dragonsbreathdamage.burningstate = burningstate;
    }
}

// Namespace dragonsbreath
// Params 1
// Checksum 0x48c06c1f, Offset: 0x1019
// Size: 0x196
function function_3542513c121ddbdd( hitloc )
{
    switch ( hitloc )
    {
        case #"hash_8a1772f5f912c880":
            return "to_";
        case #"hash_b107b5547c755d23":
            return "to_";
        case #"hash_92bbfe494d03d772":
            return "to_";
        case #"hash_b275b50677dcf6cb":
            return "to_";
        case #"hash_fbb61fc356f3c75e":
            return "to_";
        case #"hash_d42e71cd9f1e822f":
            return "ar_";
        case #"hash_51d5d0b9add9cc5a":
            return "al_";
        case #"hash_5d5aac570f6fd382":
            return "ar_";
        case #"hash_a7980c387477e7bb":
            return "al_";
        case #"hash_da2f35145aa58933":
            return "ar_";
        case #"hash_da51cc36a471058":
            return "al_";
        case #"hash_1cbc508a2fe01b79":
            return "lr";
        case #"hash_810a7426c8bac3ac":
            return "ll_";
        case #"hash_a638fec9040cfcf4":
            return "lr";
        case #"hash_7b36142458a6c2d5":
            return "ll_";
        case #"hash_9536712388e65bce":
            return "lr";
        case #"hash_168c74e879f0ba11":
            return "ll_";
        case #"hash_fb5b5e6c07253005":
            return "ar_";
        case #"hash_25789111b74943b4":
        case #"hash_b2116949ba13eb10":
        case #"hash_df21ff8a0b282215":
            return "to_";
        default:
            return "to_";
    }
}

// Namespace dragonsbreath
// Params 1
// Checksum 0xfd2c3a07, Offset: 0x11b7
// Size: 0x51, Type: bool
function isdragonsbreathweapon( objweapon )
{
    if ( objweapon.isalternate )
    {
        if ( getweaponhasperk( objweapon, "specialty_incendiary_alt" ) )
        {
            return true;
        }
        
        if ( getweaponhasperk( objweapon, "specialty_ub_flamethrower" ) )
        {
            return true;
        }
    }
    else if ( getweaponhasperk( objweapon, "specialty_incendiary" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace dragonsbreath
// Params 1
// Checksum 0xf6edeefe, Offset: 0x1211
// Size: 0x25, Type: bool
function function_527608d84b46e115( victim )
{
    if ( isdefined( victim.perks[ "specialty_one_shot_protection" ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace dragonsbreath
// Params 1
// Checksum 0x78db0341, Offset: 0x123f
// Size: 0x41, Type: bool
function function_7feebca326ca7376( objweapon )
{
    if ( !objweapon.isalternate )
    {
        if ( objweapon.basename == level.dragonsbreathdata.firedamageweapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dragonsbreath
// Params 1
// Checksum 0x90321c77, Offset: 0x1289
// Size: 0x1f
function isshield( hitloc )
{
    if ( hitloc == "shield" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace dragonsbreath
// Params 4
// Checksum 0x49d8d5eb, Offset: 0x12b0
// Size: 0x141
function function_86551e1f9bf5f185( idamage, attacker, objweapon, hitloc )
{
    if ( !isdefined( self.var_3409becd9d39cca9 ) )
    {
        self.var_3409becd9d39cca9 = [];
    }
    
    if ( !isdefined( self.dragonsbreathdamage ) )
    {
        self.dragonsbreathdamage = function_9829423140f8ffeb();
    }
    
    basedamage = idamage * getdvarfloat( @"hash_ba97c3be3b58a828", 0.2 );
    ticksleft = getdvarint( @"hash_632c2d7b6b4c3771", 2 );
    damagetime = getdvarfloat( @"hash_a55cc107911a0ce0", 0.75 );
    var_5b3a502d41e6bf57 = damagetime / ticksleft;
    damagestruct = spawnstruct();
    damagestruct.ticksleft = ticksleft;
    damagestruct.damagepertick = round( basedamage / damagestruct.ticksleft );
    damagestruct.attacker = attacker;
    damagestruct.objweapon = objweapon;
    damagestruct.hitloc = hitloc;
    self.var_3409becd9d39cca9[ self.var_3409becd9d39cca9.size ] = damagestruct;
    thread function_bc9ec04f5877d101( attacker, var_5b3a502d41e6bf57 );
}

// Namespace dragonsbreath
// Params 2
// Checksum 0xea0f5e9b, Offset: 0x13f9
// Size: 0x1ee
function function_bc9ec04f5877d101( attacker, var_5b3a502d41e6bf57 )
{
    self notify( #"db_damage" );
    self endon( #"db_damage" );
    self endon( #"death_or_disconnect" );
    self.var_d70dae05b0831219 = 1;
    function_da92183026c23d34();
    db_weapon = makeweapon( level.dragonsbreathdata.firedamageweapon );
    initialwait = getdvarfloat( @"hash_de9e421a9bb5c99a", 0.3 );
    wait initialwait;
    
    while ( self.var_3409becd9d39cca9.size > 0 )
    {
        var_4c40acc5b3880a70 = self.var_3409becd9d39cca9[ 0 ];
        
        while ( var_4c40acc5b3880a70.ticksleft > 0 && isdefined( var_4c40acc5b3880a70.attacker ) )
        {
            wait var_5b3a502d41e6bf57;
            damage = 0;
            
            for ( i = 0; i < self.var_3409becd9d39cca9.size ; i++ )
            {
                attacker = self.var_3409becd9d39cca9[ i ].attacker;
                objweapon = self.var_3409becd9d39cca9[ i ].objweapon;
                hitloc = self.var_3409becd9d39cca9[ i ].hitloc;
                
                if ( isdefined( attacker ) )
                {
                    attacker weapon_utility::function_502496613f00eb2a( db_weapon, objweapon );
                    damage = self.var_3409becd9d39cca9[ i ].damagepertick;
                    self dodamage( damage, attacker.origin, attacker, attacker, "MOD_FIRE", db_weapon, "torso_lower" );
                    self.var_3409becd9d39cca9[ i ].ticksleft--;
                }
            }
        }
        
        self.var_3409becd9d39cca9 = arrayremove( self.var_3409becd9d39cca9, var_4c40acc5b3880a70 );
        function_da92183026c23d34();
        waitframe();
    }
    
    function_901919a685d3348b();
    function_da92183026c23d34();
}

// Namespace dragonsbreath
// Params 0
// Checksum 0x56f46744, Offset: 0x15ef
// Size: 0x15
function function_6a26482545c51285()
{
    self notify( #"db_damage" );
    function_901919a685d3348b();
}

// Namespace dragonsbreath
// Params 0
// Checksum 0x792feb78, Offset: 0x160c
// Size: 0x29
function function_901919a685d3348b()
{
    self.var_3409becd9d39cca9 = undefined;
    self.var_d70dae05b0831219 = undefined;
    self.dragonsbreathdamage.hitslocs = undefined;
}

// Namespace dragonsbreath
// Params 2
// Checksum 0xd380801e, Offset: 0x163d
// Size: 0x12d
function function_339797d4003778a7( hitloc, burningtime )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    note = "crossbowBurning" + hitloc;
    self notify( note );
    self endon( note );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a91ea20949c36b49" );
    
    if ( !isdefined( self.dragonsbreathdamage ) )
    {
        self.dragonsbreathdamage = function_9829423140f8ffeb();
    }
    
    if ( !isdefined( self.dragonsbreathdamage.var_ade0789cb6b9323d ) )
    {
        self.dragonsbreathdamage.var_ade0789cb6b9323d = [];
    }
    
    self.dragonsbreathdamage.var_ade0789cb6b9323d[ self.dragonsbreathdamage.var_ade0789cb6b9323d.size ] = hitloc;
    function_da92183026c23d34();
    wait burningtime;
    
    if ( isdefined( self ) && isdefined( self.dragonsbreathdamage ) && isdefined( self.dragonsbreathdamage.var_ade0789cb6b9323d ) )
    {
        self.dragonsbreathdamage.var_ade0789cb6b9323d = arrayremove( self.dragonsbreathdamage.var_ade0789cb6b9323d, hitloc );
    }
    
    function_da92183026c23d34();
}

// Namespace dragonsbreath
// Params 1
// Checksum 0x70e2274d, Offset: 0x1772
// Size: 0x1a
function function_122a80904195ee86( params )
{
    function_f4b267b485217e63();
    function_6a26482545c51285();
}

