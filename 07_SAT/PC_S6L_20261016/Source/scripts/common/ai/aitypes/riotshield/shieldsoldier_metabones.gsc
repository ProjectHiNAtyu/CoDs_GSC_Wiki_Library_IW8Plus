// scripts\common\ai\aitypes\riotshield\shieldsoldier_metabones.gsc  (hash_433b39f7e60abf59.gscc) (size: 2424 Bytes / 0x978 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd21ddba6 (3525172134)
// size ...... 2424 (0x978)
// includes .. 3   (offset: 0x8b0)
// strings ... 13  (offset: 0x8c8)
// dev strs .. 0   (offset: 0x978)
// exports ... 6   (offset: 0x590)
// cseg ...... 0x146 + 0x44a (0x590)
// imports ... 19  (offset: 0x680)
// animtree1 . 0   (offset: 0x978)
// animtree2 . 0   (offset: 0x978)
#using scripts\asm\asm;
#using scripts\common\metabone;
#using scripts\mp\damagefeedback;

#namespace shieldsoldier_metabones;

// Namespace shieldsoldier_metabones
// Params 0, eflags: 0x1
// Checksum 0xfee45412, Offset: 0x164
// Size: 0x3a
function autoexec main()
{
    var_fb56e56d94279338 = "riotshield_soldier";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
    metabone::function_7b57cab1f2311c7b( var_fb56e56d94279338, &on_metabone_damaged_not_destroyed );
    level.var_76b3c0b7aff5a045 = 1;
}

// Namespace shieldsoldier_metabones
// Params 1, eflags: 0x4
// Checksum 0x9ea55440, Offset: 0x1a6
// Size: 0x15
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params );
}

// Namespace shieldsoldier_metabones
// Params 1, eflags: 0x4
// Checksum 0x40244016, Offset: 0x1c3
// Size: 0x15
function private on_metabone_damaged_not_destroyed( params )
{
    _on_metabone_damaged_not_destroyed( params );
}

// Namespace shieldsoldier_metabones
// Params 1, eflags: 0x4
// Checksum 0x32501489, Offset: 0x1e0
// Size: 0x224
function private _on_metabone_destroyed( params )
{
    if ( getdvarint( @"hash_5aff7a09e9c738ce", 0 ) == 1 )
    {
        return;
    }
    
    metabone_name = params.metabone_name;
    self.dropweapon = 0;
    self.var_6357802f7e466fae = 1;
    self.bhasthermitestucktoshield = 1;
    self.thermitestuckpains = 5;
    self setscriptablepartstate( "riotshield", "destroyed" );
    self aisetriotshieldweapon( nullweapon() );
    asm::function_7256f5ba459c840b( "exposed_weaponswitch" );
    
    if ( isdefined( self.dstalias ) )
    {
        playsoundatpos( self.origin, self.dstalias );
    }
    
    damager = params.eattacker.owner ?? params.eattacker;
    
    if ( isplayer( damager ) )
    {
        self playsoundtoplayer( "hit_marker_3d_zombie_armor_break", damager, self );
        targetentnum = self getentitynumber();
        damager damagefeedback::updatedamagefeedback( "hitarmorlightbreak", 0, 0, "temperedarmor", 0, undefined, targetentnum, 1, undefined ?? {}, undefined, 1 );
    }
    
    if ( params.einflictor.weapon_object.classname == "throwingknife" )
    {
        if ( isdefined( params.einflictor.deletefunction ) )
        {
            params.einflictor [[ params.einflictor.deletefunction ]]();
        }
    }
    
    foreach ( throwingweapon in self.var_e45e4b29480e5368 )
    {
        if ( isdefined( throwingweapon.deletefunction ) )
        {
            throwingweapon [[ throwingweapon.deletefunction ]]();
        }
    }
    
    self.var_e45e4b29480e5368 = [];
    self enableexecutionvictim();
}

// Namespace shieldsoldier_metabones
// Params 1, eflags: 0x4
// Checksum 0x71b2884b, Offset: 0x40c
// Size: 0x184
function private _on_metabone_damaged_not_destroyed( params )
{
    self.var_bf5f63a2a00f59ce = 20;
    
    if ( isplayer( params.eattacker ) )
    {
        armor_data = metabone::get_metabone_metadata( params.metabone_name, "Types_Damageable" );
        var_35069c22d08b1f24 = params.health / armor_data.health;
        
        if ( var_35069c22d08b1f24 <= 0.25 )
        {
            self setscriptablepartstate( "riotshield", "damage03" );
        }
        else if ( var_35069c22d08b1f24 <= 0.5 )
        {
            self setscriptablepartstate( "riotshield", "damage02" );
        }
        else if ( var_35069c22d08b1f24 <= 0.75 )
        {
            self setscriptablepartstate( "riotshield", "damage01" );
        }
        
        if ( isdefined( self.impactalias ) )
        {
            self playsoundtoplayer( self.impactalias, params.eattacker, self );
        }
        
        targetentnum = self getentitynumber();
        params.eattacker damagefeedback::updatedamagefeedback( "hitarmorlight", 0, 0, "temperedarmor", 0, undefined, targetentnum, 1, undefined ?? {}, undefined, 1 );
    }
    
    if ( params.einflictor.weapon_object.classname == "throwingknife" )
    {
        if ( !isdefined( self.var_e45e4b29480e5368 ) )
        {
            self.var_e45e4b29480e5368 = [];
        }
        
        self.var_e45e4b29480e5368[ self.var_e45e4b29480e5368.size ] = params.einflictor;
    }
}

