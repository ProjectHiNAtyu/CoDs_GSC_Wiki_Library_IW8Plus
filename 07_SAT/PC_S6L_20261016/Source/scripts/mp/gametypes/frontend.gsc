// scripts\mp\gametypes\frontend.gsc  (hash_1d0029e7bdfce7e2.gscc) (size: 2293 Bytes / 0x8f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74e5c852 (1961216082)
// size ...... 2293 (0x8f5)
// includes .. 0   (offset: 0x8e5)
// strings ... 0   (offset: 0x8e5)
// dev strs .. 1   (offset: 0x8e5)
// exports ... 17  (offset: 0x479)
// cseg ...... 0x58 + 0x421 (0x479)
// imports ... 16  (offset: 0x721)
// animtree1 . 0   (offset: 0x8f5)
// animtree2 . 0   (offset: 0x8f5)
#namespace frontend;

// Namespace frontend
// Params 0
// Checksum 0x1b39dd6f, Offset: 0x76
// Size: 0xd4
function main()
{
    level.callbackstartgametype = &callback_frontendstartgametype;
    level.callbackplayerconnect = &callback_frontendplayeractive;
    level.callbackplayerconnect = &callback_frontendplayerconnect;
    level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
    level.callbackplayerdamage = &callback_frontendplayerdamage;
    level.callbackplayerdamagescore = &callback_frontendplayerdamagescore;
    level.callbackplayerimpaled = &callback_frontendplayerimpaled;
    level.var_8f62eac141f8bdb6 = &callback_frontendplayerlaunched;
    level.callbackplayerkilled = &callback_frontendplayerkilled;
    level.callbackplayerlaststand = &callback_frontendplayerlaststand;
    level.callbackplayermigrated = &callback_frontendplayermigrated;
    level.callbackhostmigration = &callback_frontendhostmigration;
    level.var_4524771918fe585f = &callback_frontendplayerconnectrejoin;
    level.var_880cfcfec57ca836 = &function_58b6508d68b59f3f;
    level.var_16eab40d8f2ae445 = &function_b69d00f730747014;
}

// Namespace frontend
// Params 0
// Checksum 0x6ac7d6e5, Offset: 0x152
// Size: 0x2
function callback_frontendstartgametype()
{
    
}

// Namespace frontend
// Params 0
// Checksum 0xc3d5954c, Offset: 0x15c
// Size: 0x2
function callback_frontendplayeractive()
{
    
}

// Namespace frontend
// Params 0
// Checksum 0xb0a04aeb, Offset: 0x166
// Size: 0x2
function callback_frontendplayerconnect()
{
    
}

// Namespace frontend
// Params 1
// Checksum 0xce9c8eea, Offset: 0x170
// Size: 0xc
function callback_frontendplayerdisconnect( reason )
{
    
}

// Namespace frontend
// Params 18
// Checksum 0x9d2cb5cc, Offset: 0x184
// Size: 0xa5
function callback_frontendplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    
}

// Namespace frontend
// Params 12
// Checksum 0x38ca93d3, Offset: 0x231
// Size: 0x6f
function callback_frontendplayerdamagescore( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage )
{
    
}

// Namespace frontend
// Params 10
// Checksum 0x8992c078, Offset: 0x2a8
// Size: 0x5d
function callback_frontendplayerimpaled( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100 )
{
    
}

// Namespace frontend
// Params 5
// Checksum 0x2e331011, Offset: 0x30d
// Size: 0x30
function callback_frontendplayerlaunched( eattacker, objweapon, vdir, magnitude, shitloc )
{
    
}

// Namespace frontend
// Params 10
// Checksum 0xac0b2329, Offset: 0x345
// Size: 0x5d
function callback_frontendplayerkilled( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    
}

// Namespace frontend
// Params 11
// Checksum 0xc3e44681, Offset: 0x3aa
// Size: 0x66
function callback_frontendplayerlaststand( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, var_61e4f4a3c7e15e02 )
{
    
}

// Namespace frontend
// Params 0
// Checksum 0xfd439787, Offset: 0x418
// Size: 0xf
function callback_frontendplayermigrated()
{
    assertmsg( "<dev string:x24>" );
}

// Namespace frontend
// Params 0
// Checksum 0x65c72a28, Offset: 0x42f
// Size: 0xf
function callback_frontendhostmigration()
{
    assertmsg( "<dev string:x24>" );
}

// Namespace frontend
// Params 0
// Checksum 0x82717db7, Offset: 0x446
// Size: 0x2
function callback_frontendplayerconnectrejoin()
{
    
}

// Namespace frontend
// Params 1
// Checksum 0x123183d0, Offset: 0x450
// Size: 0xc
function function_58b6508d68b59f3f( reason )
{
    
}

// Namespace frontend
// Params 2
// Checksum 0x58d6f5e1, Offset: 0x464
// Size: 0x15
function function_b69d00f730747014( achievementid, progressdata )
{
    
}

