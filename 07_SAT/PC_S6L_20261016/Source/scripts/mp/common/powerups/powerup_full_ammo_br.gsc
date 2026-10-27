// scripts\mp\common\powerups\powerup_full_ammo_br.gsc  (hash_184e38c9b9ab9ebe.gscc) (size: 1280 Bytes / 0x500 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb70672c5 (3070653125)
// size ...... 1280 (0x500)
// includes .. 3   (offset: 0x4e8)
// strings ... 0   (offset: 0x500)
// dev strs .. 0   (offset: 0x500)
// exports ... 6   (offset: 0x29c)
// cseg ...... 0x58 + 0x244 (0x29c)
// imports ... 12  (offset: 0x38c)
// animtree1 . 0   (offset: 0x500)
// animtree2 . 0   (offset: 0x500)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\loot\common_item_ammo;

#namespace powerup_full_ammo_br;

// Namespace powerup_full_ammo_br
// Params 0, eflags: 0x1
// Checksum 0x7c89acff, Offset: 0x76
// Size: 0x2d
function autoexec main()
{
    if ( getdvarint( @"scr_br_powerups_enabled", 0 ) && !getdvarint( @"scr_disable_powerup_full_ammo", 0 ) )
    {
        init();
    }
}

// Namespace powerup_full_ammo_br
// Params 0
// Checksum 0x14972152, Offset: 0xab
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"powerup_full_ammo", #"hash_75b10183404b5a16", &function_66646fcceb16b26f );
    utility::registersharedfunc( #"powerup_full_ammo", #"modify_drop_chance", &modify_drop_chance );
    utility::registersharedfunc( #"powerup_full_ammo", #"give_ammo", &function_cf46f312587658ee );
}

// Namespace powerup_full_ammo_br
// Params 0
// Checksum 0x3f6f6d27, Offset: 0x10f
// Size: 0x4, Type: bool
function function_66646fcceb16b26f()
{
    return true;
}

// Namespace powerup_full_ammo_br
// Params 2
// Checksum 0xd6193fe6, Offset: 0x11c
// Size: 0x16b
function modify_drop_chance( chance, context )
{
    player = context.player;
    weapons = player getweaponslistprimaries();
    
    if ( weapons.size <= 0 )
    {
        return 0;
    }
    
    sum = 0;
    count = 0;
    
    foreach ( weap in weapons )
    {
        ammotype = br_weapons::br_ammo_type_for_weapon( weap );
        
        if ( !isdefined( ammotype ) )
        {
            continue;
        }
        
        maxstock = player item_ammo::function_9aecfd8b12f7ed0e( weap, ammotype );
        
        if ( isdefined( maxstock ) )
        {
            ammopct = utility::get_int_or_0( player.br_ammo[ ammotype ] ) / maxstock;
            sum += ammopct;
            count++;
        }
    }
    
    if ( count == 0 )
    {
        return 0;
    }
    
    var_fdbaea5443e355f7 = sum / count;
    
    if ( var_fdbaea5443e355f7 >= 1 )
    {
        return ( chance * 0.25 );
    }
    
    if ( var_fdbaea5443e355f7 > 0.3 )
    {
        return chance;
    }
    
    return chance * 2;
}

// Namespace powerup_full_ammo_br
// Params 0
// Checksum 0x638bb08e, Offset: 0x28f
// Size: 0xd
function function_cf46f312587658ee()
{
    item_ammo::function_a530c73bf2e2b013( 0, 0, 1 );
}

