// scripts\mp\gametypes\escort_horde_archetypes.gsc  (hash_315e06108d117c9a.gscc) (size: 1951 Bytes / 0x79f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60a63010 (1621504016)
// size ...... 1951 (0x79f)
// includes .. 3   (offset: 0x70f)
// strings ... 10  (offset: 0x727)
// dev strs .. 0   (offset: 0x79f)
// exports ... 9   (offset: 0x383)
// cseg ...... 0x164 + 0x21f (0x383)
// imports ... 18  (offset: 0x4eb)
// animtree1 . 0   (offset: 0x79f)
// animtree2 . 0   (offset: 0x79f)
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\escort_horde_abilities;

#namespace escort_horde_archetypes;

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0x34eb40cf, Offset: 0x182
// Size: 0x4e
function function_d79b4cf0da3939c0()
{
    self detachall();
    self setmodel( "c_jup_zmb_zod_hellhound" );
    self setcamerathirdperson( 1 );
    player::_setsuit( "jup_gamemode_mutation_hellhound" );
    self.nocorpse = 1;
    self.headmodel = undefined;
    self disableweaponpickup();
    self disableexecutionattack();
    self disableexecutionvictim();
}

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0x14df65f9, Offset: 0x1d8
// Size: 0x13
function function_c3cb5f95a94d6358()
{
    thread function_6b38b9205a971947( "fullbody_zombie_a_br", "vm_arms_zombie_a" );
}

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0xdb039b9a, Offset: 0x1f3
// Size: 0x13
function function_a247c9d824afb417()
{
    thread function_6b38b9205a971947( "fullbody_zombie_a_mp_shroud", "vm_arms_zombie_a_mp_shroud" );
}

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0x91850c82, Offset: 0x20e
// Size: 0x13
function function_f645919eebc9e6e0()
{
    thread function_6b38b9205a971947( "fullbody_zombie_a_mp_sludger", "vm_arms_zombie_a_sludge" );
}

// Namespace escort_horde_archetypes
// Params 2
// Checksum 0x43cfde70, Offset: 0x229
// Size: 0xc7
function function_6b38b9205a971947( fullbodymodel, viewhandsmodel )
{
    self detachall();
    self setmodel( fullbodymodel );
    self setviewmodel( viewhandsmodel );
    self setcamerathirdperson( 0 );
    player::_setsuit( self.defaultsuit );
    self.nocorpse = undefined;
    self.headmodel = undefined;
    self disableweaponpickup();
    fistsweapon = makeweapon( "iw9_me_fists_mp" );
    inventory_utility::_takeweapon( fistsweapon );
    var_35d0c5c69e6e0416 = makeweapon( "iw9_me_fists_mp_zmb" );
    inventory_utility::_giveweapon( var_35d0c5c69e6e0416, undefined, undefined, 1 );
    
    while ( self getcurrentweapon() != var_35d0c5c69e6e0416 )
    {
        inventory_utility::_switchtoweapon( var_35d0c5c69e6e0416 );
        waitframe();
    }
    
    if ( !isdefined( self.powershud ) )
    {
        thread escort_horde_abilities::playerzombiepowers();
    }
}

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0x1d7b9500, Offset: 0x2f8
// Size: 0x35
function reset_player_model()
{
    if ( isdefined( self.defaultmodel ) && self.defaultmodel != self.model )
    {
        self setmodel( self.defaultmodel );
    }
}

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0x48a68052, Offset: 0x335
// Size: 0x1f
function reset_player_suit()
{
    if ( isdefined( self.defaultsuit ) )
    {
        player::_setsuit( self.defaultsuit );
    }
}

// Namespace escort_horde_archetypes
// Params 0
// Checksum 0x1647b217, Offset: 0x35c
// Size: 0x27
function unmakezombie()
{
    reset_player_model();
    reset_player_suit();
    self setcamerathirdperson( 0 );
    self.nocorpse = undefined;
    self enableweaponpickup();
}

