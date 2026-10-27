// scripts\mp\emp_debuff_mp.gsc  (hash_0091857b22bc390b.gscc) (size: 1378 Bytes / 0x562 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65306ec9 (1697672905)
// size ...... 1378 (0x562)
// includes .. 5   (offset: 0x52a)
// strings ... 1   (offset: 0x552)
// dev strs .. 0   (offset: 0x562)
// exports ... 6   (offset: 0x2d6)
// cseg ...... 0x6f + 0x267 (0x2d6)
// imports ... 12  (offset: 0x3c6)
// animtree1 . 0   (offset: 0x562)
// animtree2 . 0   (offset: 0x562)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player_utility;

#namespace emp_debuff_mp;

// Namespace emp_debuff_mp
// Params 0
// Checksum 0xcb3f1149, Offset: 0x8d
// Size: 0x5c
function emp_debuff_init()
{
    utility::registersharedfunc( #"emp", #"hash_24292c1f5df2e9dd", &setplayerempimmune );
    utility::registersharedfunc( #"emp", #"hash_1ffae9c7bf3f1bac", &onplayeremped );
    utility::registersharedfunc( #"emp", #"onvehicleemped", &onvehicleemped );
}

// Namespace emp_debuff_mp
// Params 1
// Checksum 0x423d4844, Offset: 0xf1
// Size: 0x2c
function setplayerempimmune( isimmune )
{
    if ( isimmune )
    {
        perk::giveperk( "specialty_empimmune" );
        return;
    }
    
    perk::removeperk( "specialty_empimmune" );
}

// Namespace emp_debuff_mp
// Params 1
// Checksum 0x26c46582, Offset: 0x125
// Size: 0x81
function onplayeremped( data )
{
    if ( data.inflictor.var_7563c9e8d353ca9a || data.doscoreevent == 0 )
    {
        return;
    }
    
    if ( data.var_7563c9e8d353ca9a )
    {
        [[ data.var_7563c9e8d353ca9a ]]( data );
        return;
    }
    
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self, attacker ) )
    {
        attacker thread killstreaks::givescoreforempedplayer();
    }
}

// Namespace emp_debuff_mp
// Params 1
// Checksum 0x1234bd21, Offset: 0x1ae
// Size: 0xb6
function onvehicleemped( data )
{
    if ( data.inflictor.var_7563c9e8d353ca9a || data.doscoreevent == 0 )
    {
        return;
    }
    
    if ( data.var_7563c9e8d353ca9a )
    {
        [[ data.var_7563c9e8d353ca9a ]]( data );
        return;
    }
    
    attacker = data.attacker;
    
    if ( self.turrets.size > 0 )
    {
        function_cd79c6d9a491a780( data );
    }
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker killstreaks::givescoreforempedvehicle();
        return;
    }
    
    if ( vehicle::is_boss() )
    {
        attacker killstreaks::givescoreforempedvehicle();
    }
}

// Namespace emp_debuff_mp
// Params 1
// Checksum 0x60b02dfd, Offset: 0x26c
// Size: 0x6a
function function_cd79c6d9a491a780( data )
{
    if ( data.inflictor.var_7563c9e8d353ca9a || data.doscoreevent == 0 )
    {
        return;
    }
    
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker killstreaks::function_8b448160c6542f37();
    }
}

