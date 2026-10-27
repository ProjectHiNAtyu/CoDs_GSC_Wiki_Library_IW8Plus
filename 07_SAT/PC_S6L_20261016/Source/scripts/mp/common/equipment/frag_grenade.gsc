// scripts\mp\common\equipment\frag_grenade.gsc  (hash_60d5a4154363677a.gscc) (size: 1752 Bytes / 0x6d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6536356c (1698051436)
// size ...... 1752 (0x6d8)
// includes .. 5   (offset: 0x660)
// strings ... 5   (offset: 0x688)
// dev strs .. 0   (offset: 0x6d8)
// exports ... 6   (offset: 0x3c4)
// cseg ...... 0xaf + 0x315 (0x3c4)
// imports ... 15  (offset: 0x4b4)
// animtree1 . 0   (offset: 0x6d8)
// animtree2 . 0   (offset: 0x6d8)
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\equipment;

#namespace frag_grenade;

// Namespace frag_grenade
// Params 0, eflags: 0x1
// Checksum 0xea4f6f36, Offset: 0xcd
// Size: 0xa
function autoexec main()
{
    level frag_grenade_init();
}

// Namespace frag_grenade
// Params 0, eflags: 0x4
// Checksum 0x2bf3db10, Offset: 0xdf
// Size: 0x3a
function private frag_grenade_init()
{
    utility::flag_wait( "equipment_initialized" );
    equipment_mp::registercallback( "equip_frag", "onGive", &frag_grenade_on_give );
    equipment_mp::registercallback( "equip_frag", "onTake", &frag_grenade_on_take );
}

// Namespace frag_grenade
// Params 4
// Checksum 0x19eecb41, Offset: 0x121
// Size: 0x12e
function frag_grenade_on_give( equipmentref, equipmentslot, variantid, attachments )
{
    bundle = weapon::getequipmenttableinfo( equipmentref ).bundle;
    var_6820384ee51d5bd9 = ( bundle.var_3fdaa3811ce847ec ?? #"hash_d492b60b69b5cc8a" ) == #"hash_d492b60b69b5cc8a";
    
    if ( var_6820384ee51d5bd9 && !bundle.var_e36b84555e7df1d3 )
    {
        return;
    }
    
    foreach ( attachment in attachments )
    {
        if ( var_6820384ee51d5bd9 && getxhashasset( attachment ) == bundle.var_e36b84555e7df1d3 )
        {
            self.var_2e4d194d7a5f9d61 = bundle.var_41b002e948524c2f ?? 1.2;
            thread function_8ce7d26f6d9cd28c();
            break;
        }
    }
}

// Namespace frag_grenade
// Params 2
// Checksum 0x4af619e2, Offset: 0x257
// Size: 0x2b
function frag_grenade_on_take( equipmentref, slot )
{
    self notify( #"frag_grenade_on_take" );
    self.var_2e4d194d7a5f9d61 = undefined;
}

// Namespace frag_grenade
// Params 0, eflags: 0xc
// Checksum 0x95d2a1c4, Offset: 0x28a
// Size: 0x13a
function private function_8ce7d26f6d9cd28c()
{
    self notify( #"hash_2cd78e334d7a2386" );
    self endon( #"hash_2cd78e334d7a2386" );
    self endon( #"disconnect", #"frag_grenade_on_take" );
    level endon( #"game_ended" );
    bundle = weapon::getequipmenttableinfo( "equip_frag" ).bundle;
    var_6820384ee51d5bd9 = ( bundle.var_3fdaa3811ce847ec ?? #"hash_d492b60b69b5cc8a" ) == #"hash_d492b60b69b5cc8a";
    
    while ( true )
    {
        if ( player::isreallyalive( self ) )
        {
            currentweapon = weapon::getgrenadeinpullback();
            
            if ( currentweapon.var_25b0062cbe4d9c99 == #"frag_grenade" )
            {
                if ( var_6820384ee51d5bd9 && currentweapon hasattachmenthash( bundle.var_e36b84555e7df1d3 ) && !isdefined( self.perks[ "specialty_grenade_expert" ] ) )
                {
                    perk::giveperk( "specialty_grenade_expert" );
                    
                    if ( self.var_2e4d194d7a5f9d61 )
                    {
                        self setgrenadethrowscale( self.var_2e4d194d7a5f9d61 );
                    }
                }
            }
            else if ( isdefined( self.perks[ "specialty_grenade_expert" ] ) )
            {
                perk::removeperk( "specialty_grenade_expert" );
            }
        }
        
        waitframe();
    }
}

