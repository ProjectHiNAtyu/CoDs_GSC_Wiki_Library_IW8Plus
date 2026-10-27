// scripts\mp\ammomods\ammo_mod.gsc  (hash_53d9b43dfecd95ed.gscc) (size: 19498 Bytes / 0x4c2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x583efeb (92532715)
// size ...... 19498 (0x4c2a)
// includes .. 8   (offset: 0x481e)
// strings ... 28  (offset: 0x485e)
// dev strs .. 45  (offset: 0x49de)
// exports ... 38  (offset: 0x355e)
// cseg ...... 0x285 + 0x32d9 (0x355e)
// imports ... 98  (offset: 0x3b4e)
// animtree1 . 0   (offset: 0x4c2a)
// animtree2 . 0   (offset: 0x4c2a)
#using script_73d7bd610ea3f98e;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\gameplay_telemetry;

#namespace ammo_mod;

// Namespace ammo_mod
// Params 0
// Checksum 0xcbaf9b94, Offset: 0x2a3
// Size: 0x54f
function init_ammo_mod()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    utility::flag_init( "ammo_mods_ready" );
    level.ammo_mods = [];
    level.ammo_mod_exemptions = [];
    level.var_79df1e78af004c4f = [];
    level.ammo_mods[ "none" ] = spawnstruct();
    level.ammo_mods[ "none" ].name = "none";
    level callback::add( #"player_connect", &ammo_mod_on_player_connect );
    level callback::add( #"player_spawned", &ammo_mod_on_player_spawned );
    level callback::add( #"player_weapon_change", &ammo_mod_on_weapon_change );
    utility::registersharedfunc( #"zombie", #"ammo_mod_cooldown_init", &ammo_mod_cooldown_init );
    utility::registersharedfunc( #"zombie", #"has_ammo_mod", &has_ammo_mod );
    utility::registersharedfunc( #"zombie", #"get_ammo_mod_name", &get_ammo_mod_name );
    utility::registersharedfunc( #"ammo_mod", #"use_ammo_mod", &use_ammo_mod );
    utility::registersharedfunc( #"ammo_mod", #"hash_4f3b91e6539bb512", &function_7bbc1db07694f31d );
    utility::registersharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", &function_7ec17b1b91c4db2b );
    utility::registersharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", &add_ammo_mod_to_weapon );
    utility::registersharedfunc( #"ammo_mod", #"hash_ddbe3f904027bd04", &function_a0eaff256065cb6d );
    utility::registersharedfunc( #"ammo_mod", #"get_random_ammo_mod", &get_random_ammo_mod );
    utility::registersharedfunc( #"ammo_mod", #"hash_dd0e24457cb788c3", &function_ba9b2ecd18bdbdd8 );
    utility::registersharedfunc( #"ammo_mod", #"hash_88a73fb490c01c96", &function_eafaed136ccbb423 );
    utility::flag_set( "ammo_mods_ready" );
    
    /#
        level thread setup_ammomod_devgui();
    #/
    
    var_e824f255fb47c9b9 = level.gametypebundle.ammomodbundlelist ?? level.gamemodebundle.ammomodbundlelist;
    assert( isdefined( var_e824f255fb47c9b9 ), "<dev string:x24>" );
    level.var_b7d9d7926154819d = getscriptbundle( var_e824f255fb47c9b9 );
    level.var_a1068b18c80486d8 = [];
    
    if ( isdefined( level.var_b7d9d7926154819d.var_b475cb87645c871a ) )
    {
        foreach ( entry in level.var_b7d9d7926154819d.var_b475cb87645c871a )
        {
            if ( entry.weapon )
            {
                w = makeweapon( entry.weapon );
                level.var_a1068b18c80486d8[ w.var_1616e6fbba9a722d ] = 1;
            }
        }
    }
    
    if ( isdefined( level.var_b7d9d7926154819d.ammomodbundle_list ) )
    {
        level.var_b7d9d7926154819d.ammomodbundles = [];
        var_5c27c837e8fbbd3c = getdvarint( @"hash_32788d7d08476733", 1 );
        
        foreach ( i, ammomodbundlename in level.var_b7d9d7926154819d.ammomodbundle_list )
        {
            if ( ammomodbundlename.ammomodbundle )
            {
                ammomodbundle = getscriptbundle( ammomodbundlename.ammomodbundle );
                
                if ( var_5c27c837e8fbbd3c )
                {
                    ammomodbundle.description = undefined;
                    ammomodbundle.displayname = undefined;
                    ammomodbundle.unlocktype = undefined;
                    ammomodbundle.rarity = undefined;
                    ammomodbundle.visibilitylevel = undefined;
                    ammomodbundle.availableprojects = undefined;
                    ammomodbundle.unlockableprojects = undefined;
                    ammomodbundle.availableoffline = undefined;
                    ammomodbundle.availablegamemodes = undefined;
                    ammomodbundle.var_7352c2073d1e6cec = undefined;
                    ammomodbundle.var_5cfb1af2fd2e5eac = undefined;
                    ammomodbundle.var_15642e668475ba1a = undefined;
                    ammomodbundle.image = undefined;
                    ammomodbundle.hudicon = undefined;
                    ammomodbundle.model = undefined;
                    ammomodbundle.var_52ec9d15cbe72a7b = undefined;
                    ammomodbundle.var_4e7f78dc38b740d6 = undefined;
                    ammomodbundle.var_79be7a4f24551746 = undefined;
                    ammomodbundle.var_23a6bc800441f3fe = undefined;
                }
                
                level.var_b7d9d7926154819d.ammomodbundles[ ammomodbundle.ammomodname ] = ammomodbundle;
                level.var_b7d9d7926154819d.ammomodbundles[ ammomodbundle.ammomodname ].id = i + 1;
            }
        }
    }
    
    level thread function_344893a5c82d9b66();
}

// Namespace ammo_mod
// Params 0
// Checksum 0xc144c710, Offset: 0x7fa
// Size: 0x9b
function function_344893a5c82d9b66()
{
    while ( !isdefined( level.weaponmetadata ) )
    {
        waitframe();
    }
    
    foreach ( var_2e08e94c9cb1747c, var_fe68cd50dcda7fdc in level.weaponmetadata )
    {
        if ( var_fe68cd50dcda7fdc.var_9bbc1db92f200a6a )
        {
            function_a79c33384b443709( var_2e08e94c9cb1747c );
        }
    }
}

// Namespace ammo_mod
// Params 11
// Checksum 0x21a6e9c2, Offset: 0x89d
// Size: 0x160
function function_63e201d6895d439( ammomodname, var_511d306b51d343a2, weapon_attachment, var_866744e27c70eb1c, var_7f515edc435c90db, var_4b4c3d5cf3ae6bb2, var_3ff07e6eae94c01f, var_303968efeee35d49, var_da44a1b46cc4167c, var_c2360f247b85895d, var_2c24f5a4b1707e53 )
{
    ammomodbundle = level.var_b7d9d7926154819d.ammomodbundles[ ammomodname ];
    register_ammo_mod( ammomodname, ammomodbundle.id, ammomodbundle.procpercent, ammomodbundle.var_a3e31d9c9d0c8ca6, ammomodbundle.cooldownentity, ammomodbundle.cooldownattacker, ammomodbundle.cooldownglobal, ammomodbundle.occursondeath, var_511d306b51d343a2, ammomodbundle.var_2d38a15555828531 ?? "", ammomodbundle.var_1c73b60ea00808df ?? "", var_866744e27c70eb1c, ammomodbundle.element, var_7f515edc435c90db, var_4b4c3d5cf3ae6bb2, ammomodbundle.proctype, ammomodbundle.var_7179b5b921ed30d0, ammomodbundle.var_4ff3d1c0f1c27a9d, ammomodbundle.var_cb00fad54c079ba4, ammomodbundle.var_8df1a3050b00049c, ammomodbundle.var_cb2cf8d54c37fda4, var_3ff07e6eae94c01f, var_303968efeee35d49, var_da44a1b46cc4167c, var_c2360f247b85895d, var_2c24f5a4b1707e53, weapon_attachment );
}

// Namespace ammo_mod
// Params 27
// Checksum 0xfebf1db2, Offset: 0xa05
// Size: 0x5d3
function register_ammo_mod( ammomodname, ammomodid, percentage, var_a408648e01b65b6, var_681d2f3717009d49, var_d8565ba5d24b8a01, var_1bef8601add71e65, var_c35add1a78e2d004, var_511d306b51d343a2, damage_feedback_icon, var_64663d2ac1cf944b, var_866744e27c70eb1c, element, var_7f515edc435c90db, var_4b4c3d5cf3ae6bb2, proctype = "percentage", var_7179b5b921ed30d0, var_4ff3d1c0f1c27a9d, var_cb00fad54c079ba4, var_8df1a3050b00049c, var_cb2cf8d54c37fda4, var_3ff07e6eae94c01f, var_303968efeee35d49, var_da44a1b46cc4167c, var_c2360f247b85895d, var_2c24f5a4b1707e53, weapon_attachment )
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    assert( isdefined( ammomodname ), "<dev string:x7a>" );
    assert( "<dev string:xae>" != ammomodname, "<dev string:xb3>" );
    assert( !isdefined( level.ammo_mods[ ammomodname ] ), "<dev string:x11d>" + ammomodname + "<dev string:x147>" );
    assert( isdefined( percentage ), "<dev string:x165>" + ammomodname + "<dev string:x18f>" );
    assert( 0 <= percentage && 1 >= percentage, "<dev string:x1ad>" + ammomodname + "<dev string:x1d7>" );
    assert( isdefined( var_681d2f3717009d49 ), "<dev string:x1ad>" + ammomodname + "<dev string:x22c>" );
    assert( 0 <= var_681d2f3717009d49, "<dev string:x1ad>" + ammomodname + "<dev string:x254>" );
    assert( isdefined( var_681d2f3717009d49 ), "<dev string:x1ad>" + ammomodname + "<dev string:x297>" );
    assert( 0 <= var_681d2f3717009d49, "<dev string:x1ad>" + ammomodname + "<dev string:x2c1>" );
    assert( isdefined( var_1bef8601add71e65 ), "<dev string:x1ad>" + ammomodname + "<dev string:x306>" );
    assert( 0 <= var_1bef8601add71e65, "<dev string:x1ad>" + ammomodname + "<dev string:x32e>" );
    assert( isdefined( var_c35add1a78e2d004 ), "<dev string:x1ad>" + ammomodname + "<dev string:x371>" );
    assert( isdefined( var_511d306b51d343a2 ), "<dev string:x1ad>" + ammomodname + "<dev string:x394>" );
    assert( isdefined( damage_feedback_icon ), "<dev string:x1ad>" + ammomodname + "<dev string:x3b3>" );
    assert( isstring( damage_feedback_icon ), "<dev string:x1ad>" + ammomodname + "<dev string:x3db>" );
    assert( isdefined( var_64663d2ac1cf944b ), "<dev string:x1ad>" + ammomodname + "<dev string:x404>" );
    assert( isstring( var_64663d2ac1cf944b ), "<dev string:x1ad>" + ammomodname + "<dev string:x42d>" );
    level.ammo_mods[ ammomodname ] = spawnstruct();
    level.ammo_mods[ ammomodname ].name = ammomodname;
    level.ammo_mods[ ammomodname ].id = ammomodid;
    
    switch ( proctype )
    {
        case #"hash_7c7c0cdffe207815":
            level.ammo_mods[ ammomodname ].percentage = percentage;
            level.ammo_mods[ ammomodname ].var_a408648e01b65b6 = var_a408648e01b65b6;
            break;
        case #"hash_2f003e488b3d92b2":
            level.ammo_mods[ ammomodname ].var_7179b5b921ed30d0 = var_7179b5b921ed30d0;
            level.ammo_mods[ ammomodname ].var_cb00fad54c079ba4 = var_cb00fad54c079ba4;
            level.ammo_mods[ ammomodname ].var_8df1a3050b00049c = var_8df1a3050b00049c;
            level.ammo_mods[ ammomodname ].var_cb2cf8d54c37fda4 = var_cb2cf8d54c37fda4;
            level.ammo_mods[ ammomodname ].var_3ff07e6eae94c01f = var_3ff07e6eae94c01f;
            level.ammo_mods[ ammomodname ].var_303968efeee35d49 = var_303968efeee35d49;
            level.ammo_mods[ ammomodname ].var_da44a1b46cc4167c = var_da44a1b46cc4167c;
            level.ammo_mods[ ammomodname ].var_c2360f247b85895d = var_c2360f247b85895d;
            level.ammo_mods[ ammomodname ].var_2c24f5a4b1707e53 = var_2c24f5a4b1707e53;
            level.ammo_mods[ ammomodname ].var_4ff3d1c0f1c27a9d = var_4ff3d1c0f1c27a9d;
            break;
    }
    
    level.ammo_mods[ ammomodname ].var_681d2f3717009d49 = var_681d2f3717009d49;
    level.ammo_mods[ ammomodname ].var_d8565ba5d24b8a01 = var_d8565ba5d24b8a01;
    level.ammo_mods[ ammomodname ].var_1bef8601add71e65 = var_1bef8601add71e65;
    level.ammo_mods[ ammomodname ].var_ee095d0f4c1a917e = 0;
    level.ammo_mods[ ammomodname ].var_c35add1a78e2d004 = var_c35add1a78e2d004;
    level.ammo_mods[ ammomodname ].var_511d306b51d343a2 = var_511d306b51d343a2;
    level.ammo_mods[ ammomodname ].damage_feedback_icon = damage_feedback_icon;
    level.ammo_mods[ ammomodname ].var_64663d2ac1cf944b = var_64663d2ac1cf944b;
    level.ammo_mods[ ammomodname ].var_866744e27c70eb1c = var_866744e27c70eb1c;
    level.ammo_mods[ ammomodname ].var_b5a37532c4a162a8 = [];
    level.ammo_mods[ ammomodname ].var_619b827d8f50a2bf = [];
    level.ammo_mods[ ammomodname ].var_e57f2c412810e148 = [];
    level.ammo_mods[ ammomodname ].var_7f515edc435c90db = var_7f515edc435c90db;
    level.ammo_mods[ ammomodname ].var_4b4c3d5cf3ae6bb2 = var_4b4c3d5cf3ae6bb2;
    level.ammo_mods[ ammomodname ].element = element;
    level.ammo_mods[ ammomodname ].weapon_attachment = weapon_attachment;
}

// Namespace ammo_mod
// Params 1
// Checksum 0xd148adfc, Offset: 0xfe0
// Size: 0x2b, Type: bool
function function_4e8b25d4e8ae4e68( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    return istrue( level.var_a1068b18c80486d8[ weapon.var_1616e6fbba9a722d ] );
}

// Namespace ammo_mod
// Params 1, eflags: 0x4
// Checksum 0x1bf13c9e, Offset: 0x1014
// Size: 0xfa
function private internal_get_ammo_mod_name( weapon )
{
    ammo_mod_name = undefined;
    var_c66d223021b64422 = weapon;
    
    if ( weapon.isalternate )
    {
        var_c66d223021b64422 = weapon getnoaltweapon();
    }
    
    if ( self.ammo_mod.size > 0 )
    {
        a_ammomods = arrayrandomize( self.ammo_mod );
        
        foreach ( ammomodstruct in a_ammomods )
        {
            if ( ammomodstruct.weapon == weapon || ammomodstruct.weapon == var_c66d223021b64422 )
            {
                ammo_mod_name = ammomodstruct.ammomodname;
            }
        }
    }
    
    return ammo_mod_name;
}

// Namespace ammo_mod
// Params 1
// Checksum 0x3237c576, Offset: 0x1117
// Size: 0x26c
function default_ai_response( damagestruct )
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    if ( !isplayer( damagestruct.eattacker ) )
    {
        return;
    }
    
    var_5e94b7b011663cfd = damagestruct.idamage > self.health;
    var_88f31e1cf8b10209 = damagestruct.sweapon;
    
    if ( function_4e8b25d4e8ae4e68( damagestruct.sweapon ) )
    {
        var_88f31e1cf8b10209 = isdefined( damagestruct.einflictor.glgrenadeparent ) ? damagestruct.einflictor.glgrenadeparent : damagestruct.eattacker getcurrentweapon();
    }
    
    ammo_mod = level.ammo_mods[ damagestruct.eattacker internal_get_ammo_mod_name( var_88f31e1cf8b10209 ) ];
    
    if ( ammo_mod.percentage && isdefined( damagestruct.eattacker.var_2763b30d6d337ccf ) )
    {
        timediff = ( gettime() - damagestruct.eattacker.var_2763b30d6d337ccf ) / 1000;
        
        if ( timediff < 1 && timediff != 0 )
        {
            return;
        }
    }
    
    response = ammo_mod_response( var_5e94b7b011663cfd, damagestruct.einflictor, damagestruct.eattacker, damagestruct.idamage, damagestruct.idflags, damagestruct.smeansofdeath, damagestruct.sweapon, damagestruct.vpoint, damagestruct.vdir, damagestruct.shitloc, damagestruct.timeoffset, damagestruct.modelindex, damagestruct.partname, damagestruct.objweapon );
    
    if ( !response )
    {
        damagestruct.eattacker.var_2763b30d6d337ccf = gettime();
    }
    else
    {
        damagestruct.eattacker.var_2763b30d6d337ccf = undefined;
    }
    
    if ( isdefined( ammo_mod ) && var_5e94b7b011663cfd )
    {
        if ( isdefined( ammo_mod.var_7f515edc435c90db ) && var_5e94b7b011663cfd )
        {
            self thread [[ ammo_mod.var_7f515edc435c90db ]]( damagestruct.idamage, damagestruct.eattacker, damagestruct.sweapon );
        }
    }
}

// Namespace ammo_mod
// Params 19
// Checksum 0x23e764cc, Offset: 0x138b
// Size: 0x85e, Type: bool
function ammo_mod_response( death, einflictor, eattacker, idamage, idflags, mod, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, var_a0fc7d899d3386fb, currentweapon, var_b8f3721c1cf18fb7, var_b121bc46582c97be, var_f9dca4132990131b )
{
    if ( !can_use_ammomod( eattacker ) || !( isdefined( eattacker.ammo_mod ) && isdefined( sweapon ) ) )
    {
        return false;
    }
    
    var_bb1a55e72f9f1af = function_4e8b25d4e8ae4e68( sweapon ) && ( mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH" );
    
    if ( mod != "MOD_PISTOL_BULLET" && mod != "MOD_RIFLE_BULLET" && mod != "MOD_GRENADE" && mod != "MOD_PROJECTILE" && mod != "MOD_EXPLOSIVE" && mod != "MOD_IMPACT" && mod != "MOD_MELEE" && mod != "MOD_EXPLOSIVE_BULLET" && !var_bb1a55e72f9f1af )
    {
        if ( !eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_elemental_pop", #"elemental_pop_elemental_equipment" ) )
        {
            return false;
        }
    }
    
    if ( var_bb1a55e72f9f1af && isdefined( einflictor ) && istrue( einflictor.var_68edc78ded613aaf ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_c42dd935c4b19dde ) && mod == "MOD_MELEE" )
    {
        if ( ![[ level.var_c42dd935c4b19dde ]]( sweapon ) )
        {
            return false;
        }
    }
    
    if ( isplayer( einflictor ) && !isdefined( einflictor.ammo_mod ) )
    {
        return false;
    }
    
    if ( eattacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( eattacker, self ) )
        {
            return false;
        }
    }
    
    var_88f31e1cf8b10209 = sweapon;
    
    if ( function_4e8b25d4e8ae4e68( sweapon ) )
    {
        var_88f31e1cf8b10209 = isdefined( einflictor.glgrenadeparent ) ? einflictor.glgrenadeparent : eattacker getcurrentweapon();
    }
    
    ammo_mod_name = var_f9dca4132990131b ?? eattacker internal_get_ammo_mod_name( var_88f31e1cf8b10209 );
    
    if ( !isdefined( ammo_mod_name ) )
    {
        return false;
    }
    
    if ( !isdefined( level.ammo_mods[ ammo_mod_name ] ) )
    {
        assertmsg( "<dev string:x457>" + ammo_mod_name + "<dev string:x46b>" );
        return false;
    }
    
    if ( ammo_mod_name == "brainrot" )
    {
        if ( !eattacker.var_d979f5d362b549ab && isalive( eattacker.brainrottedzombie ) )
        {
            return false;
        }
    }
    
    if ( death && !level.ammo_mods[ ammo_mod_name ].var_c35add1a78e2d004 )
    {
        return false;
    }
    
    if ( death && self.var_698cf8d8d4a8cbb9 )
    {
        return false;
    }
    
    if ( !var_b121bc46582c97be || !isplayer( self ) )
    {
        if ( !isdefined( self.basearchetype ) )
        {
            return false;
        }
    }
    
    if ( self.var_eb92c31552620100 )
    {
        return false;
    }
    
    if ( utility::callsharedfunc( #"zombie_utils", #"hash_ed46e37d3efd53d3" ) )
    {
        return false;
    }
    
    if ( level.ammo_mods[ ammo_mod_name ].var_b5a37532c4a162a8[ self.basearchetype ] )
    {
        return false;
    }
    
    now = gettime() / 1000;
    
    if ( isdefined( level.var_9626beebc6dc1871 ) )
    {
        if ( self [[ level.var_9626beebc6dc1871 ]]( ammo_mod_name, now, eattacker ) )
        {
            return false;
        }
    }
    else
    {
        if ( !isdefined( var_a0fc7d899d3386fb ) )
        {
            var_a0fc7d899d3386fb = eattacker.var_d979f5d362b549ab ?? 0;
        }
        
        /#
            if ( getdvarint( @"scr_skip_cooldowns", 0 ) )
            {
                var_a0fc7d899d3386fb = 1;
            }
        #/
        
        if ( !var_a0fc7d899d3386fb && isdefined( self.var_cca0c8973424675a ) && isdefined( ammo_mod_name ) && isdefined( self.var_cca0c8973424675a[ ammo_mod_name ] ) && isdefined( level.ammo_mods[ ammo_mod_name ].var_681d2f3717009d49 ) && now <= ( self.var_cca0c8973424675a[ ammo_mod_name ] ?? 0 ) + ( level.ammo_mods[ ammo_mod_name ].var_681d2f3717009d49 ?? 0 ) )
        {
            return false;
        }
        
        var_151ee1feabe67fd3 = level.ammo_mods[ ammo_mod_name ].var_d8565ba5d24b8a01;
        var_fc4f2f03bc3893e2 = 0;
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_15ca371de3d570b9" ) )
        {
            var_fc4f2f03bc3893e2 = eattacker utility::callsharedfunc( #"zombie", #"hash_15ca371de3d570b9", ammo_mod_name );
        }
        
        if ( var_fc4f2f03bc3893e2 > 0 )
        {
            var_151ee1feabe67fd3 = clamp( var_151ee1feabe67fd3 - var_fc4f2f03bc3893e2, 0, var_151ee1feabe67fd3 );
        }
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_da0b8e642d871723" ) )
        {
            var_151ee1feabe67fd3 = eattacker utility::callsharedfunc( #"zombie", #"hash_da0b8e642d871723", ammo_mod_name, var_151ee1feabe67fd3 );
        }
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_67dba6baa6a33fb7" ) )
        {
            var_151ee1feabe67fd3 = eattacker utility::callsharedfunc( #"zombie", #"hash_67dba6baa6a33fb7", ammo_mod_name, var_151ee1feabe67fd3 );
            var_dda431706a607d1a = 1;
        }
        
        if ( !var_a0fc7d899d3386fb && now <= ( eattacker.var_cca0c8973424675a[ ammo_mod_name ] ?? 0 ) + var_151ee1feabe67fd3 )
        {
            return false;
        }
        
        if ( !var_a0fc7d899d3386fb && !var_dda431706a607d1a && now <= ( level.ammo_mods[ ammo_mod_name ].var_ee095d0f4c1a917e ?? 0 ) + ( level.ammo_mods[ ammo_mod_name ].var_1bef8601add71e65 ?? 0 ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.ammo_mods[ ammo_mod_name ].var_866744e27c70eb1c ) )
    {
        if ( ![[ level.ammo_mods[ ammo_mod_name ].var_866744e27c70eb1c ]]() )
        {
            return false;
        }
    }
    
    success = 0;
    var_c902cdef88e85750 = undefined;
    
    if ( isdefined( level.ammo_mods[ ammo_mod_name ].percentage ) )
    {
        percentage = function_a0f300c9718efc08( eattacker, ammo_mod_name );
        
        if ( percentage == 1 || percentage >= randomfloat( 1 ) )
        {
            success = 1;
        }
    }
    else if ( isdefined( level.ammo_mods[ ammo_mod_name ].var_7179b5b921ed30d0 ) )
    {
        success = ammo_mod_accumulate( ammo_mod_name, eattacker, mod, sweapon );
    }
    
    if ( !success )
    {
        return false;
    }
    
    weapon = sweapon;
    
    if ( isdefined( currentweapon ) )
    {
        weapon = currentweapon;
    }
    
    level.ammo_mods[ ammo_mod_name ].var_ee095d0f4c1a917e = now;
    eattacker.var_cca0c8973424675a[ ammo_mod_name ] = now;
    self.var_cca0c8973424675a[ ammo_mod_name ] = now;
    
    if ( var_bb1a55e72f9f1af && isdefined( einflictor ) )
    {
        einflictor.var_68edc78ded613aaf = 1;
    }
    
    result_params = { #var_b121bc46582c97be:var_b121bc46582c97be, #var_b8f3721c1cf18fb7:var_b8f3721c1cf18fb7, #modelindex:modelindex, #shitloc:shitloc, #vpoint:vpoint, #sweapon:weapon, #mod:mod, #attacker:eattacker, #death:death };
    self thread [[ level.ammo_mods[ ammo_mod_name ].var_511d306b51d343a2 ]]( result_params );
    
    if ( getdvarint( @"hash_e742008972155619", 0 ) )
    {
        eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_ammo_mod_triggered", weapon.basename, 4 );
    }
    
    sparams = spawnstruct();
    sparams.ammomod_name = ammo_mod_name;
    sparams.var_6b85a8ba774528fb = 0;
    sparams.sweapon = weapon;
    sparams.victim = self;
    sparams.zombie = self;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier == 2 )
    {
        sparams.var_6b85a8ba774528fb = 1;
    }
    
    eattacker callback::callback( "ammomod_proc", sparams );
    
    if ( isplayer( eattacker ) )
    {
        eattacker playlocalsound( "uin_ammomod_proc_to_player_2d" );
    }
    
    return true;
}

// Namespace ammo_mod
// Params 2, eflags: 0x4
// Checksum 0x6fd8aed, Offset: 0x1bf2
// Size: 0x2b3
function private function_a0f300c9718efc08( eattacker, ammo_mod_name )
{
    percentage = 0;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( self.aisettings.var_eb0346702e39f265 || self.aicategory == "hvt" || self.aicategory == "boss" )
    {
        return percentage;
    }
    
    if ( ai_tier == 3 )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_fc017b4ab1759c43" ) )
        {
            var_da3ccdca6a3dd542 = eattacker utility::callsharedfunc( #"zombie", #"hash_fc017b4ab1759c43", ammo_mod_name );
            
            if ( var_da3ccdca6a3dd542 > 0 )
            {
                var_9f36d9cb87ba50d3 = 1;
                percentage = var_da3ccdca6a3dd542;
            }
        }
    }
    else if ( ai_tier == 2 )
    {
        var_9f36d9cb87ba50d3 = 1;
        percentage = level.ammo_mods[ ammo_mod_name ].var_a408648e01b65b6;
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_cdf6ce9b64729ea3" ) )
        {
            var_a3e31d9c9d0c8ca6 = eattacker utility::callsharedfunc( #"zombie", #"hash_cdf6ce9b64729ea3", ammo_mod_name );
            
            if ( var_a3e31d9c9d0c8ca6 > 0 )
            {
                percentage = var_a3e31d9c9d0c8ca6;
            }
        }
    }
    else
    {
        var_9f36d9cb87ba50d3 = 1;
        percentage = level.ammo_mods[ ammo_mod_name ].percentage;
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_e895853edab9ed9b" ) )
        {
            var_b1540e6cadebd70a = eattacker utility::callsharedfunc( #"zombie", #"hash_e895853edab9ed9b", ammo_mod_name );
            
            if ( var_b1540e6cadebd70a > 0 )
            {
                percentage = var_b1540e6cadebd70a;
            }
        }
    }
    
    if ( !var_9f36d9cb87ba50d3 )
    {
        return percentage;
    }
    
    if ( isdefined( level.var_79df1e78af004c4f[ ammo_mod_name ] ) )
    {
        if ( level.var_79df1e78af004c4f[ ammo_mod_name ] < percentage )
        {
            percentage = level.var_79df1e78af004c4f[ ammo_mod_name ];
        }
    }
    
    if ( isdefined( eattacker.var_88cc283ee5d29498 ) )
    {
        percentage = eattacker.var_88cc283ee5d29498;
    }
    
    if ( self.aicategory )
    {
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                class_override_perc = eattacker.var_21b6849991ff8d5d;
                break;
            case #"hash_8c089e813083e510":
                class_override_perc = eattacker.var_1db20ec8603de2ad;
                break;
            case #"hash_7b0e2f2ed84f34":
                class_override_perc = eattacker.var_3c03e691e10ab42d;
                break;
        }
        
        if ( isdefined( class_override_perc ) )
        {
            percentage = class_override_perc;
        }
    }
    
    /#
        var_a81f0db7e41abe6d = getdvarfloat( @"hash_46a29d9f01b6b83d", 0 );
        
        if ( var_a81f0db7e41abe6d > 0 )
        {
            percentage = var_a81f0db7e41abe6d;
        }
    #/
    
    return percentage;
}

// Namespace ammo_mod
// Params 5, eflags: 0x4
// Checksum 0x59ef804f, Offset: 0x1eae
// Size: 0xe9, Type: bool
function private ammo_mod_accumulate( ammo_mod_name, einflictor, eattacker, mod, weaponobj )
{
    ammomod = level.ammo_mods[ ammo_mod_name ];
    
    if ( !effect_accumulate::function_f6eb20ef6c541dc7( ammo_mod_name ) )
    {
        effect_accumulate::function_cf20746494aeaca8( ammo_mod_name, ammomod.var_7179b5b921ed30d0, ammomod.var_cb00fad54c079ba4, ammomod.var_8df1a3050b00049c, ammomod.var_cb2cf8d54c37fda4 );
        effect_accumulate::function_40685dcb08461e57( ammo_mod_name, ammomod.var_3ff07e6eae94c01f, ammomod.var_303968efeee35d49, ammomod.var_da44a1b46cc4167c, ammomod.var_c2360f247b85895d, ammomod.var_2c24f5a4b1707e53 );
    }
    
    if ( effect_accumulate::accumulate( ammo_mod_name, ammomod.var_4ff3d1c0f1c27a9d, einflictor, eattacker, mod, weaponobj ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ammo_mod
// Params 5
// Checksum 0x9d41afbb, Offset: 0x1fa0
// Size: 0x38e
function add_ammo_mod_to_weapon( weapon, ammo_mod_name, b_hud_update = 1, var_1e454fb3d0388f95 = 1, b_switch_to_weapon = 1 )
{
    if ( !level.ammo_mods_in_use )
    {
        return weapon;
    }
    
    assert( isdefined( weapon ), "<dev string:x48d>" );
    
    if ( function_93602b4237468711( weapon ) )
    {
        return weapon;
    }
    
    if ( isdefined( ammo_mod_name ) )
    {
        assert( isdefined( level.ammo_mods[ ammo_mod_name ] ), "<dev string:x4c8>" + ammo_mod_name + "<dev string:x4d3>" );
        
        if ( !has_ammo_mod( weapon ) )
        {
            ammomodstruct = spawnstruct();
            ammomodstruct.weapon = weapon getnoaltweapon();
            ammomodstruct.ammomodname = ammo_mod_name;
            ammomodstruct.var_de99e1b8565cec68 = var_1e454fb3d0388f95;
            
            if ( !isdefined( self.ammo_mod ) )
            {
                self.ammo_mod = [];
            }
            
            self.ammo_mod[ self.ammo_mod.size ] = ammomodstruct;
        }
        else
        {
            weapon = weapon getnoaltweapon();
            
            foreach ( i, modstruct in self.ammo_mod )
            {
                if ( modstruct.weapon == weapon )
                {
                    ammomodstruct = modstruct;
                    callback::callback( "ammo_mod_removed", { #ammo_mod_name:self.ammo_mod[ i ].ammomodname, #weapon:weapon, #player:self } );
                    
                    if ( level.ammo_mods[ self.ammo_mod[ i ].ammomodname ].weapon_attachment )
                    {
                        new_weapon = ammomodstruct.weapon withoutattachment( level.ammo_mods[ self.ammo_mod[ i ].ammomodname ].weapon_attachment );
                        self takeweapon( ammomodstruct.weapon );
                        self giveweapon( new_weapon );
                        
                        if ( b_switch_to_weapon )
                        {
                            self switchtoweaponimmediate( new_weapon );
                        }
                        
                        ammomodstruct.weapon = new_weapon;
                    }
                    
                    self.ammo_mod[ i ].ammomodname = ammo_mod_name;
                }
            }
        }
        
        if ( level.ammo_mods[ ammo_mod_name ].weapon_attachment )
        {
            new_weapon = ammomodstruct.weapon withattachment( level.ammo_mods[ ammo_mod_name ].weapon_attachment );
            self takeweapon( ammomodstruct.weapon );
            self giveweapon( new_weapon );
            
            if ( b_switch_to_weapon )
            {
                self switchtoweaponimmediate( new_weapon );
            }
            
            ammomodstruct.weapon = new_weapon;
        }
        
        params = spawnstruct();
        params.player = self;
        params.weapon = ammomodstruct.weapon;
        params.ammo_mod_name = ammo_mod_name;
        callback::callback( "ammo_mod_equipped", params );
        
        if ( b_hud_update )
        {
            function_eafaed136ccbb423( weapon );
        }
        
        self notify( #"ammo_mod_acquired" );
        return ammomodstruct.weapon;
    }
    
    return weapon;
}

// Namespace ammo_mod
// Params 2
// Checksum 0x669e267e, Offset: 0x2337
// Size: 0x1df
function function_e6267ae500506234( weapon, b_hud_update = 1 )
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    assert( isdefined( weapon ), "<dev string:x4ea>" );
    weapon = weapon getnoaltweapon();
    root_weapon_string = weapon.var_1616e6fbba9a722d;
    
    foreach ( i, ammomodstruct in self.ammo_mod )
    {
        if ( ammomodstruct.weapon == weapon )
        {
            callback::callback( "ammo_mod_removed", { #ammo_mod_name:self.ammo_mod[ i ].ammomodname, #weapon:weapon, #player:self } );
            
            if ( level.ammo_mods[ self.ammo_mod[ i ].ammomodname ].weapon_attachment )
            {
                new_weapon = ammomodstruct.weapon withoutattachment( level.ammo_mods[ self.ammo_mod[ i ].ammomodname ].weapon_attachment );
                self takeweapon( ammomodstruct.weapon );
                self giveweapon( new_weapon );
                self switchtoweaponimmediate( new_weapon );
            }
            
            self.ammo_mod = arrayremove( self.ammo_mod, self.ammo_mod[ i ] );
        }
    }
    
    if ( b_hud_update )
    {
        self setclientomnvar( "ui_pap_current_ammomod", 0 );
    }
}

// Namespace ammo_mod
// Params 1, eflags: 0x4
// Checksum 0xd8f579, Offset: 0x251e
// Size: 0x1e
function private ammo_mod_on_weapon_change( params )
{
    function_eafaed136ccbb423( params.weapon );
}

// Namespace ammo_mod
// Params 1
// Checksum 0x5b8e3ed2, Offset: 0x2544
// Size: 0x12d
function function_eafaed136ccbb423( weapon = self getcurrentweapon() )
{
    str_ammo_mod_name = undefined;
    weapslot = gameplay_telemetry_utils::function_87e071d9cdce86a7( weapon.basename );
    var_93ba52859ed5d2cc = weapslot ? "ui_" + weapslot + "_weapon_ammomod_zm" : "undefined";
    
    if ( has_ammo_mod( weapon ) )
    {
        str_ammo_mod_name = get_ammo_mod_name( weapon );
    }
    
    if ( hasomnvar( var_93ba52859ed5d2cc ) )
    {
        if ( str_ammo_mod_name )
        {
            self setclientomnvar( var_93ba52859ed5d2cc, level.ammo_mods[ str_ammo_mod_name ].id );
        }
        else
        {
            self setclientomnvar( var_93ba52859ed5d2cc, 0 );
        }
    }
    
    if ( self function_5c766d1d0140b86( o"ui_current_weapon_supports_ammo_mod" ) )
    {
        self setclientomnvar( o"ui_current_weapon_supports_ammo_mod", function_7bbc1db07694f31d( weapon ) );
    }
    
    if ( self function_5c766d1d0140b86( o"ui_pap_current_ammomod" ) )
    {
        if ( isdefined( str_ammo_mod_name ) )
        {
            self setclientomnvar( o"ui_pap_current_ammomod", level.ammo_mods[ str_ammo_mod_name ].id ?? 0 );
            return;
        }
        
        self setclientomnvar( o"ui_pap_current_ammomod", 0 );
    }
}

// Namespace ammo_mod
// Params 1
// Checksum 0xa122dd09, Offset: 0x2679
// Size: 0x9e
function ammo_mod_on_player_connect( params )
{
    self.ammo_mod = [];
    self.var_cca0c8973424675a = [];
    
    foreach ( key, v in level.ammo_mods )
    {
        self.var_cca0c8973424675a[ key ] = 0;
    }
}

// Namespace ammo_mod
// Params 1
// Checksum 0x9c00c8d5, Offset: 0x271f
// Size: 0x1c
function ammo_mod_on_player_spawned( params )
{
    function_eafaed136ccbb423( self.spawnweaponobj );
}

// Namespace ammo_mod
// Params 1
// Checksum 0x29deaab3, Offset: 0x2743
// Size: 0x2f, Type: bool
function can_use_ammomod( entity )
{
    if ( isdefined( entity ) && ( isplayer( entity ) || entity.can_use_ammo_mod ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ammo_mod
// Params 1
// Checksum 0x59b1444f, Offset: 0x277b
// Size: 0x3f, Type: bool
function function_93602b4237468711( weapon )
{
    root_weapon_string = weapon.var_1616e6fbba9a722d;
    
    if ( !level.ammo_mods_in_use )
    {
        return false;
    }
    
    return istrue( level.ammo_mod_exemptions[ root_weapon_string ] );
}

// Namespace ammo_mod
// Params 1
// Checksum 0xc91c73a1, Offset: 0x27c3
// Size: 0x5f
function function_7bbc1db07694f31d( weapon )
{
    if ( function_93602b4237468711( weapon ) )
    {
        return 0;
    }
    
    if ( weapon::iskillstreakweapon( weapon ) )
    {
        return 0;
    }
    
    if ( weapon.ismelee && isdefined( level.var_c42dd935c4b19dde ) )
    {
        return [[ level.var_c42dd935c4b19dde ]]( weapon );
    }
    
    if ( weapon::iswonderweapon( weapon ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace ammo_mod
// Params 0
// Checksum 0x82c2a96d, Offset: 0x282b
// Size: 0x98
function ammo_mod_cooldown_init()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    self.var_cca0c8973424675a = [];
    
    foreach ( key, v in level.ammo_mods )
    {
        self.var_cca0c8973424675a[ key ] = 0;
    }
}

// Namespace ammo_mod
// Params 5
// Checksum 0xe622c709, Offset: 0x28cb
// Size: 0x16f
function function_6975f9d247792a0e( ammo_mod_name, archetype, var_b5a37532c4a162a8, var_619b827d8f50a2bf, var_e57f2c412810e148 )
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    assert( isdefined( ammo_mod_name ), "<dev string:x52a>" );
    assert( isdefined( archetype ), "<dev string:x55e>" );
    assert( isdefined( var_b5a37532c4a162a8 ), "<dev string:x597>" );
    assert( isdefined( var_619b827d8f50a2bf ), "<dev string:x5d5>" );
    assert( isdefined( var_e57f2c412810e148 ), "<dev string:x619>" );
    
    if ( !isdefined( level.ammo_mods[ ammo_mod_name ].var_b5a37532c4a162a8 ) )
    {
        level.ammo_mods[ ammo_mod_name ].var_b5a37532c4a162a8 = [];
    }
    
    if ( !isdefined( level.ammo_mods[ ammo_mod_name ].var_619b827d8f50a2bf ) )
    {
        level.ammo_mods[ ammo_mod_name ].var_619b827d8f50a2bf = [];
    }
    
    if ( !isdefined( level.ammo_mods[ ammo_mod_name ].var_e57f2c412810e148 ) )
    {
        level.ammo_mods[ ammo_mod_name ].var_e57f2c412810e148 = [];
    }
    
    level.ammo_mods[ ammo_mod_name ].var_b5a37532c4a162a8[ archetype ] = var_b5a37532c4a162a8;
    level.ammo_mods[ ammo_mod_name ].var_619b827d8f50a2bf[ archetype ] = var_619b827d8f50a2bf;
    level.ammo_mods[ ammo_mod_name ].var_e57f2c412810e148[ archetype ] = var_e57f2c412810e148;
}

// Namespace ammo_mod
// Params 1
// Checksum 0x33f7a2b4, Offset: 0x2a42
// Size: 0x29
function function_a79c33384b443709( weapon_root_name )
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level.ammo_mod_exemptions[ weapon_root_name ] = 1;
}

// Namespace ammo_mod
// Params 2
// Checksum 0x99434214, Offset: 0x2a73
// Size: 0x149, Type: bool
function has_ammo_mod( w_current, inflictor = undefined )
{
    if ( !level.ammo_mods_in_use )
    {
        return false;
    }
    
    if ( isplayer( self ) && function_4e8b25d4e8ae4e68( w_current ) )
    {
        w_current = isdefined( inflictor.glgrenadeparent ) ? inflictor.glgrenadeparent : self getcurrentweapon();
    }
    
    if ( isplayer( self ) && isdefined( self.ammo_mod ) && isdefined( w_current ) )
    {
        var_c66d223021b64422 = w_current;
        
        if ( w_current.isalternate )
        {
            var_c66d223021b64422 = w_current getnoaltweapon();
        }
        
        if ( isarray( self.ammo_mod ) )
        {
            foreach ( ammomodstruct in self.ammo_mod )
            {
                if ( ammomodstruct.weapon == w_current || ammomodstruct.weapon == var_c66d223021b64422 )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace ammo_mod
// Params 2
// Checksum 0x3279f758, Offset: 0x2bc5
// Size: 0xef, Type: bool
function function_ba9b2ecd18bdbdd8( w_current, ammo_mod_name )
{
    if ( !level.ammo_mods_in_use )
    {
        return false;
    }
    
    var_c66d223021b64422 = w_current;
    
    if ( w_current.isalternate )
    {
        var_c66d223021b64422 = w_current getnoaltweapon();
    }
    
    foreach ( ammomodstruct in self.ammo_mod )
    {
        if ( ( ammomodstruct.weapon == w_current || ammomodstruct.weapon == var_c66d223021b64422 ) && ammomodstruct.ammomodname == ammo_mod_name )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ammo_mod
// Params 2
// Checksum 0xd8fcf0d0, Offset: 0x2cbd
// Size: 0x164
function get_ammo_mod_id( w_current, inflictor = undefined )
{
    if ( !level.ammo_mods_in_use )
    {
        return int( 0 );
    }
    
    if ( function_4e8b25d4e8ae4e68( w_current ) )
    {
        w_current = isdefined( inflictor.glgrenadeparent ) ? inflictor.glgrenadeparent : self getcurrentweapon();
    }
    
    var_c66d223021b64422 = w_current;
    
    if ( w_current.isalternate )
    {
        var_c66d223021b64422 = w_current getnoaltweapon();
    }
    
    if ( self.ammo_mod.size > 0 )
    {
        a_ammomods = arrayrandomize( self.ammo_mod );
        
        foreach ( ammomodstruct in a_ammomods )
        {
            if ( ammomodstruct.weapon == w_current || ammomodstruct.weapon == var_c66d223021b64422 )
            {
                ammomodname = ammomodstruct.ammomodname;
                return level.ammo_mods[ ammomodname ].id;
            }
        }
    }
    
    return int( 0 );
}

// Namespace ammo_mod
// Params 1
// Checksum 0x9a633890, Offset: 0x2e2a
// Size: 0x2c
function get_ammo_mod_loot_id( ammomod_name )
{
    return level.var_b7d9d7926154819d.ammomodbundles[ ammomod_name ].lootid;
}

// Namespace ammo_mod
// Params 2
// Checksum 0x291425cf, Offset: 0x2e5f
// Size: 0x144
function get_ammo_mod_name( w_current, inflictor = undefined )
{
    if ( !level.ammo_mods_in_use )
    {
        return "";
    }
    
    if ( function_4e8b25d4e8ae4e68( w_current ) )
    {
        w_current = isdefined( inflictor.glgrenadeparent ) ? inflictor.glgrenadeparent : self getcurrentweapon();
    }
    
    var_c66d223021b64422 = w_current;
    
    if ( w_current.isalternate )
    {
        var_c66d223021b64422 = w_current getnoaltweapon();
    }
    
    if ( self.ammo_mod.size > 0 )
    {
        a_ammomods = arrayrandomize( self.ammo_mod );
        
        foreach ( ammomodstruct in a_ammomods )
        {
            if ( ammomodstruct.weapon == w_current || ammomodstruct.weapon == var_c66d223021b64422 )
            {
                return ammomodstruct.ammomodname;
            }
        }
    }
    
    return "";
}

// Namespace ammo_mod
// Params 1
// Checksum 0x2c4cea73, Offset: 0x2fac
// Size: 0xbd
function function_7fe70894ab337d3f( id )
{
    if ( !level.ammo_mods_in_use )
    {
        return "";
    }
    
    if ( !isdefined( id ) || id == 0 )
    {
        return "";
    }
    
    foreach ( ammo_mod_name, ammo_mod in level.ammo_mods )
    {
        if ( ammo_mod.id == id )
        {
            return ammo_mod_name;
        }
    }
    
    return "";
}

// Namespace ammo_mod
// Params 1
// Checksum 0xfea5f6ca, Offset: 0x3072
// Size: 0xb4
function function_a0eaff256065cb6d( name )
{
    if ( !level.ammo_mods_in_use )
    {
        return 0;
    }
    
    if ( !isdefined( name ) || name == "" )
    {
        return 0;
    }
    
    foreach ( ammo_mod_name, ammo_mod in level.ammo_mods )
    {
        if ( name == ammo_mod_name )
        {
            return ammo_mod.id;
        }
    }
    
    return 0;
}

// Namespace ammo_mod
// Params 3
// Checksum 0xf4ec32f3, Offset: 0x312f
// Size: 0x7a
function use_ammo_mod( weapon, itembundle, item )
{
    if ( function_7bbc1db07694f31d( weapon ) && !function_ba9b2ecd18bdbdd8( weapon, itembundle.ammomodname ) )
    {
        add_ammo_mod_to_weapon( weapon, itembundle.ammomodname );
        
        if ( has_ammo_mod( weapon ) )
        {
            return ( item.count - 1 );
        }
    }
    
    return item.count;
}

// Namespace ammo_mod
// Params 2
// Checksum 0xc6680789, Offset: 0x31b2
// Size: 0x6c
function function_7ec17b1b91c4db2b( weapon, var_7bb0b04ebf0e3bd8 = 1 )
{
    if ( has_ammo_mod( weapon ) )
    {
        if ( level utility::flag( "disable_ammo_mod_on_item_drop_copy" ) )
        {
            return;
        }
        
        if ( var_7bb0b04ebf0e3bd8 && !should_drop_ammo_mod( weapon ) )
        {
            return;
        }
        
        oldammomod = get_ammo_mod_name( weapon );
        function_e6267ae500506234( weapon );
        return oldammomod;
    }
}

// Namespace ammo_mod
// Params 1
// Checksum 0xc392403c, Offset: 0x3226
// Size: 0xf2
function should_drop_ammo_mod( w_current )
{
    if ( !level.ammo_mods_in_use )
    {
        return 1;
    }
    
    var_c66d223021b64422 = w_current;
    
    if ( w_current.isalternate )
    {
        var_c66d223021b64422 = w_current getnoaltweapon();
    }
    
    foreach ( ammomodstruct in self.ammo_mod )
    {
        if ( ammomodstruct.weapon == w_current || ammomodstruct.weapon == var_c66d223021b64422 )
        {
            if ( !isdefined( ammomodstruct.var_de99e1b8565cec68 ) )
            {
                return 1;
            }
            
            return ammomodstruct.var_de99e1b8565cec68;
        }
    }
    
    return 1;
}

// Namespace ammo_mod
// Params 0
// Checksum 0x6b995fc8, Offset: 0x3321
// Size: 0x77
function get_random_ammo_mod()
{
    assert( isdefined( level.var_b7d9d7926154819d ), "<dev string:x65f>" );
    var_9366bffa899d8c27 = level.var_b7d9d7926154819d.ammomodbundles;
    assert( isdefined( var_9366bffa899d8c27 ), "<dev string:x68a>" );
    assert( var_9366bffa899d8c27.size > 0, "<dev string:x6c4>" );
    randomammomodbundle = utility::array_random( var_9366bffa899d8c27 );
    return randomammomodbundle.ammomodname;
}

/#

    // Namespace ammo_mod
    // Params 0
    // Checksum 0xbf97e6df, Offset: 0x33a1
    // Size: 0x66, Type: dev
    function function_34ce52ae51828b83()
    {
        if ( getdvarfloat( @"hash_46a29d9f01b6b83d", 0 ) > 0 )
        {
            setdvar( @"hash_46a29d9f01b6b83d", 0 );
        }
        else
        {
            setdvar( @"hash_46a29d9f01b6b83d", 0.99 );
        }
        
        iprintlnbold( "<dev string:x6f5>" + getdvarfloat( @"hash_46a29d9f01b6b83d", 0 ) );
    }

    // Namespace ammo_mod
    // Params 0
    // Checksum 0x56cec1c3, Offset: 0x340f
    // Size: 0x51, Type: dev
    function function_33bf9c5c7e04ccf5()
    {
        if ( getdvarint( @"scr_skip_cooldowns", 0 ) )
        {
            setdvar( @"scr_skip_cooldowns", 0 );
        }
        else
        {
            setdvar( @"scr_skip_cooldowns", 1 );
        }
        
        iprintlnbold( "<dev string:x718>" + getdvarint( @"scr_skip_cooldowns", 0 ) );
    }

    // Namespace ammo_mod
    // Params 0
    // Checksum 0xf6d0ba6a, Offset: 0x3468
    // Size: 0x91, Type: dev
    function function_ee6b91383190e26()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player function_e6267ae500506234( currentweapon, 1 );
        }
    }

    // Namespace ammo_mod
    // Params 0
    // Checksum 0x10c47ee4, Offset: 0x3501
    // Size: 0x5d, Type: dev
    function setup_ammomod_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x736>" );
        devgui::add_devgui_func( "<dev string:x747>", "<dev string:x764>", &function_34ce52ae51828b83, 0 );
        devgui::add_devgui_func( "<dev string:x779>", "<dev string:x793>", &function_33bf9c5c7e04ccf5, 0 );
        devgui::add_devgui_func( "<dev string:x7a2>", "<dev string:x7b2>", &function_ee6b91383190e26, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
