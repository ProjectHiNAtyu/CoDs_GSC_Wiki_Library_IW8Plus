// script_2ca303a73fb6436d  (hash_2ca303a73fb6436d.gscc) (size: 1056 Bytes / 0x420 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b4a2857 (994715735)
// size ...... 1056 (0x420)
// includes .. 3   (offset: 0x3c8)
// strings ... 5   (offset: 0x3e0)
// dev strs .. 0   (offset: 0x420)
// exports ... 5   (offset: 0x1dc)
// cseg ...... 0x88 + 0x154 (0x1dc)
// imports ... 10  (offset: 0x2a4)
// animtree1 . 0   (offset: 0x420)
// animtree2 . 0   (offset: 0x420)
#using script_d74ae0b4aa21186;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;

#namespace namespace_cfbf3e363210f7ae;

// Namespace namespace_cfbf3e363210f7ae
// Params 0
// Checksum 0xec9ec4e7, Offset: 0xa6
// Size: 0x12
function createdecision()
{
    return mind::function_6e220221dd563155( &evaluatescore, &createaction );
}

// Namespace namespace_cfbf3e363210f7ae
// Params 1
// Checksum 0xde3ebdbf, Offset: 0xc1
// Size: 0xe, Type: bool
function evaluatescore( bot )
{
    return true;
}

// Namespace namespace_cfbf3e363210f7ae
// Params 1
// Checksum 0xbc6e28bc, Offset: 0xd8
// Size: 0x28
function createaction( bot )
{
    return mind::createactionbase( "Auto Run Map", undefined, "main", "", &actionprocess, self );
}

// Namespace namespace_cfbf3e363210f7ae
// Params 1
// Checksum 0xfc6d5242, Offset: 0x109
// Size: 0xd3
function actionprocess( bot )
{
    while ( true )
    {
        if ( getdvarint( @"hash_5749a8474f4dab7d" ) == 1 )
        {
            setdvar( @"hash_57e665aef01b95a9", 0 );
            run_target = getdvarvector( @"hash_747a3d0ee28ac5a8", ( 0, 0, 0 ) );
            bot namespace_ef4547f85724edd1::setscriptgoal( run_target, 20 );
            result = bot utility::waittill_any_in_array_return( [ "goal", "bad_path" ] );
            
            if ( result == "goal" )
            {
                setdvar( @"hash_57e665aef01b95a9", 1 );
            }
            else
            {
                setdvar( @"hash_57e665aef01b95a9", 2 );
            }
            
            setdvar( @"hash_5749a8474f4dab7d", 0 );
            continue;
        }
        
        wait 0.5;
    }
}

