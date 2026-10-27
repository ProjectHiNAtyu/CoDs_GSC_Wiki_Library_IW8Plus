// script_424482c57bfb1ebc  (hash_424482c57bfb1ebc.gscc) (size: 4953 Bytes / 0x1359 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x949032e9 (2492478185)
// size ...... 4953 (0x1359)
// includes .. 5   (offset: 0x1299)
// strings ... 10  (offset: 0x12c1)
// dev strs .. 2   (offset: 0x1339)
// exports ... 24  (offset: 0xa6d)
// cseg ...... 0xd0 + 0x99d (0xa6d)
// imports ... 39  (offset: 0xe2d)
// animtree1 . 0   (offset: 0x1359)
// animtree2 . 0   (offset: 0x1359)
#using script_38b3a2dd00d469d7;
#using scripts\common\callbacks;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\equipment;

#namespace namespace_e385f05e4980c92f;

// Namespace namespace_e385f05e4980c92f
// Params 0
// Checksum 0x997809f9, Offset: 0xee
// Size: 0xae
function register()
{
    namespace_65703d98c062a7d0::register_task( #"eliminations", { #description:undefined, #title:undefined, #var_d510f1926ab220cf:1, #defaulttimelimit:level.var_4e147a96a4a5740d.taskduration ?? 120, #var_a689daceff70fb12:25, #callbacks:{ #onkilled:&onkilled, #ondamaged:&ondamaged, #onspawn:&onspawn, #end:&end, #begin:&begin } } );
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0xe26e094f, Offset: 0x1a4
// Size: 0xce
function begin( task )
{
    foreach ( player in level.players )
    {
        player.var_791a6a36ec5ee182 = 0;
        player.var_d642a91f0a8fe884 = undefined;
        player.var_e6c9d65c05c92eda = 0;
    }
    
    if ( task.eliminationtype == #"no_reload" )
    {
        callback::add( #"reload", &function_e20895536464fde0 );
    }
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x7dbeab61, Offset: 0x27a
// Size: 0x39
function end( task )
{
    if ( task.eliminationtype == #"no_reload" )
    {
        callback::remove( #"reload", &function_e20895536464fde0 );
    }
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x3902d161, Offset: 0x2bb
// Size: 0x3b
function onspawn( spawndata )
{
    self.var_791a6a36ec5ee182 = 0;
    self.var_d642a91f0a8fe884 = undefined;
    self.var_12bec2d67f827bf8 = undefined;
    self.var_e6c9d65c05c92eda = 0;
    thread monitorsprint();
}

// Namespace namespace_e385f05e4980c92f
// Params 0, eflags: 0x4
// Checksum 0x91e783fc, Offset: 0x2fe
// Size: 0x2c
function private monitorsprint()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( self issprinting() )
        {
            self.var_12bec2d67f827bf8 = gettime();
        }
        
        waitframe();
    }
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x952ba4ae, Offset: 0x332
// Size: 0x17
function ondamaged( damagedata )
{
    self.var_791a6a36ec5ee182 = 1;
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x234820d7, Offset: 0x351
// Size: 0x98
function onkilled( deathdata )
{
    attacker = deathdata.attacker;
    
    if ( !isplayer( attacker ) || attacker == self )
    {
        return;
    }
    
    if ( attacker.team == self.team )
    {
        return;
    }
    
    task = level.var_1304fc1c8fb51e7b.active;
    
    if ( !task )
    {
        return;
    }
    
    if ( !function_14a91dc443447bec( task, deathdata, attacker ) )
    {
        return;
    }
    
    attacker namespace_65703d98c062a7d0::function_3e454447aae37e67( attacker.team, 1 );
}

// Namespace namespace_e385f05e4980c92f
// Params 3
// Checksum 0xf695be2f, Offset: 0x3f1
// Size: 0x16d
function function_14a91dc443447bec( task, deathdata, attacker )
{
    elimtype = task.eliminationtype ?? #"any";
    
    switch ( elimtype )
    {
        case #"headshot":
            return function_b202ad9afdeac1f8( deathdata );
        case #"ads":
            return isadskill( deathdata );
        case #"hipfire":
            return function_3ed6f5e1654968af( deathdata );
        case #"weapon":
            return function_9d20356905f1e50a( deathdata, task.eliminationfilter );
        case #"weapon_type":
            return function_175b6379b408d4d2( deathdata, task.eliminationfilter );
        case #"scorestreak":
            return function_5680f76895d633f2( deathdata );
        case #"no_damage":
            return function_10723f03e2e304f4( attacker );
        case #"double_kill":
            return function_f4b1e43517991a65( attacker );
        case #"elimination_streak":
            return function_163833a1440dd033( attacker, task.eliminationfilter );
        case #"sprinting":
            return function_a7034472ef62ea16( attacker );
        case #"no_reload":
            return function_43bc14de8026ca44( attacker, task.eliminationfilter );
        default:
            return 1;
    }
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0xc55edc53, Offset: 0x566
// Size: 0x32, Type: bool
function function_b202ad9afdeac1f8( deathdata )
{
    return deathdata.hitloc == "head" || deathdata.meansofdeath == "MOD_HEAD_SHOT";
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x4c6391e5, Offset: 0x5a1
// Size: 0xb8, Type: bool
function function_80679c413f8bb267( deathdata )
{
    return deathdata.meansofdeath != "MOD_MELEE" && ( deathdata.objweapon.inventorytype == "primary" || deathdata.objweapon.inventorytype == "secondary" || deathdata.objweapon.inventorytype == "altmode" ) && ( deathdata.objweapon.type == "projectile" || deathdata.objweapon.type == "bullet" );
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0xdcb1680, Offset: 0x662
// Size: 0x29, Type: bool
function isadskill( deathdata )
{
    return deathdata.attacker player::isplayerads() && function_80679c413f8bb267( deathdata );
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x4b550551, Offset: 0x694
// Size: 0x2a, Type: bool
function function_3ed6f5e1654968af( deathdata )
{
    return !deathdata.attacker player::isplayerads() && function_80679c413f8bb267( deathdata );
}

// Namespace namespace_e385f05e4980c92f
// Params 2
// Checksum 0x2d1f3bc2, Offset: 0x6c7
// Size: 0x55, Type: bool
function function_9d20356905f1e50a( deathdata, filter )
{
    assert( filter && filter != "<dev string:x24>", "<dev string:x25>" );
    
    if ( !deathdata.objweapon )
    {
        return false;
    }
    
    return weapon::getweaponrootname( deathdata.objweapon ) == filter;
}

// Namespace namespace_e385f05e4980c92f
// Params 2
// Checksum 0x1928fd2a, Offset: 0x725
// Size: 0xb7, Type: bool
function function_175b6379b408d4d2( deathdata, filter )
{
    assert( filter && filter != "<dev string:x24>", "<dev string:x25>" );
    
    if ( !deathdata.objweapon || !deathdata.weapongroup )
    {
        return false;
    }
    
    if ( filter == "ww" && deathdata.weapongroup == "weapon_wonder" )
    {
        return true;
    }
    
    if ( !function_80679c413f8bb267( deathdata ) || weapon::iskillstreakweapon( deathdata.objweapon ) || function_6e7e6dff0a9a5dda( deathdata ) )
    {
        return false;
    }
    
    return weapon::getweaponclasstoken( deathdata.objweapon ) == filter;
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x5743235b, Offset: 0x7e5
// Size: 0x2c, Type: bool
function function_5680f76895d633f2( deathdata )
{
    return deathdata.objweapon && weapon::iskillstreakweapon( deathdata.objweapon );
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0xee0432cc, Offset: 0x81a
// Size: 0x34, Type: bool
function function_6e7e6dff0a9a5dda( deathdata )
{
    equipmentref = function_3ab56a99632b63e4( deathdata );
    return equipment_mp::isequipmentlethal( equipmentref ) || equipment_mp::isequipmenttactical( equipmentref );
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x6d1d7734, Offset: 0x857
// Size: 0x6c
function function_3ab56a99632b63e4( deathdata )
{
    if ( deathdata.objweapon )
    {
        equipmentref = deathdata.objweapon.equipmentref ?? equipment_mp::getequipmentreffromweapon( deathdata.objweapon );
        
        if ( equipmentref )
        {
            return equipmentref;
        }
    }
    
    return deathdata.inflictor.equipmentref;
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x95d6a4fc, Offset: 0x8cc
// Size: 0x1b, Type: bool
function function_10723f03e2e304f4( attacker )
{
    return !( attacker.var_791a6a36ec5ee182 === 1 );
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0xf71f7441, Offset: 0x8f0
// Size: 0x5f, Type: bool
function function_f4b1e43517991a65( attacker )
{
    now = gettime();
    lastkill = attacker.var_d642a91f0a8fe884;
    
    if ( lastkill && now - lastkill <= 1500 )
    {
        attacker.var_d642a91f0a8fe884 = undefined;
        return true;
    }
    
    attacker.var_d642a91f0a8fe884 = now;
    return false;
}

// Namespace namespace_e385f05e4980c92f
// Params 2
// Checksum 0xe8a8f1f3, Offset: 0x958
// Size: 0x2d, Type: bool
function function_163833a1440dd033( attacker, filter )
{
    return ( attacker.var_9b5953146269e8f8 ?? 0 ) % int( filter ) == 0;
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x12a4664b, Offset: 0x98e
// Size: 0x50, Type: bool
function function_a7034472ef62ea16( attacker )
{
    if ( attacker issprinting() )
    {
        return true;
    }
    
    if ( isdefined( attacker.var_12bec2d67f827bf8 ) )
    {
        var_ef0401a10107d39b = gettime() - attacker.var_12bec2d67f827bf8;
        
        if ( var_ef0401a10107d39b <= 500 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_e385f05e4980c92f
// Params 2
// Checksum 0xc1503f8f, Offset: 0x9e7
// Size: 0x67, Type: bool
function function_43bc14de8026ca44( attacker, filter )
{
    if ( !isdefined( attacker.var_e6c9d65c05c92eda ) )
    {
        attacker.var_e6c9d65c05c92eda = 0;
    }
    
    attacker.var_e6c9d65c05c92eda++;
    requirement = int( filter );
    
    if ( requirement <= 0 )
    {
        requirement = 1;
    }
    
    return attacker.var_e6c9d65c05c92eda >= requirement;
}

// Namespace namespace_e385f05e4980c92f
// Params 1
// Checksum 0x9cb4ccf6, Offset: 0xa57
// Size: 0x16
function function_e20895536464fde0( params )
{
    self.var_e6c9d65c05c92eda = undefined;
}

