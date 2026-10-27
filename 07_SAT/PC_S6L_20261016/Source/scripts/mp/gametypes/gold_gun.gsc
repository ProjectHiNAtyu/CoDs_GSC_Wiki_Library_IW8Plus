// scripts\mp\gametypes\gold_gun.gsc  (hash_0e8a252b4c2138ed.gscc) (size: 5369 Bytes / 0x14f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e0dded0 (1846402768)
// size ...... 5369 (0x14f9)
// includes .. 7   (offset: 0x1151)
// strings ... 51  (offset: 0x1189)
// dev strs .. 5   (offset: 0x14bd)
// exports ... 14  (offset: 0xbc1)
// cseg ...... 0x453 + 0x76e (0xbc1)
// imports ... 30  (offset: 0xdf1)
// animtree1 . 0   (offset: 0x14f9)
// animtree2 . 0   (offset: 0x14f9)
#using scripts\common\utility;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\flags;
#using scripts\mp\hud_message;

#namespace gold_gun;

// Namespace gold_gun
// Params 0, eflags: 0x5
// Checksum 0xfdc39049, Offset: 0x471
// Size: 0x1e
function private autoexec init()
{
    level.var_2d26813259dde738 = &gold_gun_main;
    level.var_dba053ed1cfdefa0 = &gold_gun_init;
}

// Namespace gold_gun
// Params 0, eflags: 0x4
// Checksum 0xb8718115, Offset: 0x497
// Size: 0x33
function private gold_gun_main()
{
    level.allowclasschoicefunc = &function_a14acb9a81ff297e;
    level.bypassclasschoicefunc = &function_4a4e2cac4cf424b6;
    level.onplayerkilled = &function_245a1e76a60544c6;
    function_13a5a7a33ae8cd01();
}

// Namespace gold_gun
// Params 0
// Checksum 0xea6c7006, Offset: 0x4d2
// Size: 0x1f
function gold_gun_init()
{
    level thread uav::function_bb7953c7f773188e( 5 );
    flags::gameflagwait( "prematch_done" );
    function_6cfaf61b3168f20d();
}

// Namespace gold_gun
// Params 0
// Checksum 0x1505711c, Offset: 0x4f9
// Size: 0x43
function function_6cfaf61b3168f20d()
{
    player = utility::array_random( level.players );
    
    if ( class::isvalidclass( player.class ) )
    {
        player store_prev_class();
    }
    
    player function_78ae7b8f54bc38ee();
}

// Namespace gold_gun
// Params 0
// Checksum 0x52575781, Offset: 0x544
// Size: 0xbf
function function_78ae7b8f54bc38ee()
{
    player = self;
    player.raygun = 1;
    
    if ( class::isvalidclass( player.class ) )
    {
        player store_prev_class();
    }
    
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = level.aon_loadouts[ "allies" ];
    player class::giveloadout( player.pers[ "team" ], "gamemode", 0, 1 );
    player inventory_utility::_takeweapon( "iw9_me_fists_mp" );
    
    /#
        player hudoutlineenable( "<dev string:x24>" );
    #/
    
    player setclientomnvar( "ui_gold_gun_show_perk_hud", 1 );
    player hud_message::showsplash( "mp_terminus_gun" );
}

// Namespace gold_gun
// Params 0
// Checksum 0xc33b4e50, Offset: 0x60b
// Size: 0x32
function function_f3b2f91ac560967c()
{
    player = self;
    player.raygun = 0;
    player function_9d4229836b073f27();
    player setclientomnvar( "ui_gold_gun_show_perk_hud", 0 );
}

// Namespace gold_gun
// Params 0
// Checksum 0x269219f6, Offset: 0x645
// Size: 0x1d
function function_4a4e2cac4cf424b6()
{
    if ( self.raygun )
    {
        return "gamemode";
    }
    
    return "class0";
}

// Namespace gold_gun
// Params 0
// Checksum 0x538b4bfe, Offset: 0x66a
// Size: 0x4d
function store_prev_class()
{
    self.pers[ "prev_class" ] = self.class;
    self.pers[ "prev_classCache" ] = self.classstruct;
    class::addclassstructtocache( self.classstruct, self.class );
}

// Namespace gold_gun
// Params 0
// Checksum 0x40226123, Offset: 0x6bf
// Size: 0xdd
function function_9d4229836b073f27()
{
    if ( isdefined( self.pers[ "prev_class" ] ) )
    {
        if ( isdefined( self.pers[ "prev_classCache" ] ) )
        {
            function_40268b06d542bdb6( self.pers[ "prev_class" ] );
            class::loadout_updateclass( self.pers[ "prev_classCache" ], self.pers[ "prev_class" ] );
            class::preloadandqueueclass( self.pers[ "prev_class" ], 1 );
            class::giveloadout( self.team, self.pers[ "prev_class" ], 0, 1 );
        }
        else
        {
            assert( isdefined( self.pers[ "<dev string:x38>" ] ), "<dev string:x48>" );
        }
        
        return;
    }
    
    assert( isdefined( self.pers[ "<dev string:x85>" ] ), "<dev string:x90>" );
}

// Namespace gold_gun
// Params 1
// Checksum 0x6844e48f, Offset: 0x7a4
// Size: 0x86
function function_40268b06d542bdb6( class )
{
    self setclientomnvar( "ui_skip_loadout", 1 );
    self.pers[ "class" ] = class;
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    
    if ( isbot( self ) )
    {
        self.classcallback = &bots_loadout::function_c39c5c8073b9c407;
    }
}

// Namespace gold_gun
// Params 0
// Checksum 0xc5cd76e9, Offset: 0x832
// Size: 0xc, Type: bool
function function_a14acb9a81ff297e()
{
    return !self.raygun;
}

// Namespace gold_gun
// Params 10
// Checksum 0xc80c5405, Offset: 0x847
// Size: 0x92
function function_245a1e76a60544c6( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( self.raygun )
    {
        if ( isplayer( attacker ) && !attacker.raygun )
        {
            attacker function_78ae7b8f54bc38ee();
            function_f3b2f91ac560967c();
        }
    }
}

// Namespace gold_gun
// Params 0
// Checksum 0x33833fbb, Offset: 0x8e1
// Size: 0x2e0
function function_13a5a7a33ae8cd01()
{
    level.aon_loadouts[ "allies" ][ "loadoutPrimary" ] = "jup_pi_goldengun_mp";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryAttachment" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryAttachment2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryCamo" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryReticle" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutPrimaryVariantID" ] = -1;
    level.aon_loadouts[ "allies" ][ "loadoutSecondary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryAttachment" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryAttachment2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryCamo" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryReticle" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSecondaryVariantID" ] = -1;
    level.aon_loadouts[ "allies" ][ "loadoutEquipmentPrimary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutEquipmentSecondary" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutSuper" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutStreakType" ] = "assault";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak1" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak2" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutKillstreak3" ] = "none";
    level.aon_loadouts[ "allies" ][ "loadoutUsingSpecialist" ] = 1;
    level.aon_loadouts[ "allies" ][ "loadoutPerks" ] = [ "specialty_hustle", "specialty_hardline" ];
    level.aon_loadouts[ "allies" ][ "loadoutExtraPerks" ] = [ "specialty_scavenger", "specialty_huntmaster", "specialty_surveillance" ];
    level.aon_loadouts[ "allies" ][ "loadoutGesture" ] = "playerData";
    level.aon_loadouts[ "allies" ][ "loadoutFieldUpgrade1" ] = "super_deadsilence";
    level.aon_loadouts[ "allies" ][ "loadoutFieldUpgrade2" ] = "none";
    level.aon_loadouts[ "axis" ] = level.aon_loadouts[ "allies" ];
}

