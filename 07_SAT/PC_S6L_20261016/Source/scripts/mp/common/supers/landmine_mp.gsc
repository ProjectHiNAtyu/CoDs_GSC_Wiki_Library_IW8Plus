// scripts\mp\common\supers\landmine_mp.gsc  (hash_5f89655cb2208cf7.gscc) (size: 2190 Bytes / 0x88e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x575e0bf (91611327)
// size ...... 2190 (0x88e)
// includes .. 10  (offset: 0x7f6)
// strings ... 4   (offset: 0x846)
// dev strs .. 0   (offset: 0x88e)
// exports ... 9   (offset: 0x3d6)
// cseg ...... 0x92 + 0x344 (0x3d6)
// imports ... 24  (offset: 0x53e)
// animtree1 . 0   (offset: 0x88e)
// animtree2 . 0   (offset: 0x88e)
#using scripts\common\equipment\landmine;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace landmine_mp;

// Namespace landmine_mp
// Params 0, eflags: 0x1
// Checksum 0x348fe32b, Offset: 0xb0
// Size: 0x7b
function autoexec main()
{
    utility::registersharedfunc( "equip_landmine", #"empapplied", &landmine_emp_applied );
    utility::registersharedfunc( "equip_landmine", #"empclear", &function_f31f3d8e2fea3ceb );
    utility::registersharedfunc( "equip_landmine", #"hash_b383a9b6a9ae6db1", &function_5605c31fd78cc188 );
    utility::registersharedfunc( "equip_landmine", #"getweaponname", &function_5b6708bc272c94c6 );
    weapons::registerusedcallback( "equip_landmine", &landmine::function_72e650c98b5fc3b8 );
}

// Namespace landmine_mp
// Params 1
// Checksum 0xe83fa8e5, Offset: 0x133
// Size: 0x7c
function landmine_emp_applied( data )
{
    if ( function_6b6d8aea60b704cb() )
    {
        if ( data.attacker )
        {
            data.attacker thread points::doscoreevent( #"hash_ae06df7368bd2eda" );
        }
        
        landmine_destroyonemp( data );
        return;
    }
    
    if ( data.attacker )
    {
        data.attacker thread points::doscoreevent( #"disabled_at_mine" );
    }
    
    function_2f55b81992e10d20( data );
}

// Namespace landmine_mp
// Params 0, eflags: 0x4
// Checksum 0x4a666203, Offset: 0x1b7
// Size: 0x45, Type: bool
function private function_6b6d8aea60b704cb()
{
    if ( self.issuper )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_landmine" );
    }
    else
    {
        bundle = weapon::getequipmenttableinfo( "equip_landmine" );
    }
    
    return bundle.landmine_destroyonemp ?? 1;
}

// Namespace landmine_mp
// Params 1, eflags: 0x4
// Checksum 0x3d411374, Offset: 0x205
// Size: 0x6f
function private landmine_destroyonemp( data )
{
    attacker = data.attacker;
    self notify( #"enemy_destroyed_equipment", attacker );
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    thread landmine::function_c989c791608191d9( attacker );
}

// Namespace landmine_mp
// Params 1, eflags: 0x4
// Checksum 0x56bbe35a, Offset: 0x27c
// Size: 0x49
function private function_2f55b81992e10d20( data )
{
    self.isdisabled = 1;
    self setscriptablepartstate( #"empd", #"active", 0 );
    self setscriptablepartstate( #"health_listener", #"off", 0 );
}

// Namespace landmine_mp
// Params 1, eflags: 0x4
// Checksum 0xcab07679, Offset: 0x2cd
// Size: 0x2f
function private function_f31f3d8e2fea3ceb( data )
{
    self.isdisabled = 0;
    self setscriptablepartstate( #"empd", #"neutral", 0 );
}

// Namespace landmine_mp
// Params 0, eflags: 0x4
// Checksum 0x92c48319, Offset: 0x304
// Size: 0xbc
function private function_5605c31fd78cc188()
{
    if ( isent( self ) )
    {
        linkedchildren = self getlinkedchildren();
    }
    
    if ( isdefined( linkedchildren ) )
    {
        foreach ( child in linkedchildren )
        {
            if ( isdefined( child ) && child.equipmentref == "equip_claymore" && !child.exploding )
            {
                child thread claymore::claymore_destroy();
            }
        }
    }
}

// Namespace landmine_mp
// Params 0, eflags: 0x4
// Checksum 0xe94a02df, Offset: 0x3c8
// Size: 0xd, Type: bool
function private function_5b6708bc272c94c6()
{
    return supers_mp::getsuperweapon( "super_landmine" );
}

