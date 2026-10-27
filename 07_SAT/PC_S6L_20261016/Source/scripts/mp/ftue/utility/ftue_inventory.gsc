// scripts\mp\ftue\utility\ftue_inventory.gsc  (hash_458ce44388c14a5f.gscc) (size: 1351 Bytes / 0x547 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61cb1098 (1640698008)
// size ...... 1351 (0x547)
// includes .. 1   (offset: 0x50b)
// strings ... 4   (offset: 0x513)
// dev strs .. 0   (offset: 0x547)
// exports ... 8   (offset: 0x31f)
// cseg ...... 0xa6 + 0x279 (0x31f)
// imports ... 6   (offset: 0x45f)
// animtree1 . 0   (offset: 0x547)
// animtree2 . 0   (offset: 0x547)
#using scripts\mp\br\gametypes\br;

#namespace ftue_inventory;

// Namespace ftue_inventory
// Params 1
// Checksum 0x8dfc989, Offset: 0xc4
// Size: 0x16
function function_3fe39e89019f53d1( callback )
{
    function_65640c4fcadb01b7( callback, 0 );
}

// Namespace ftue_inventory
// Params 1
// Checksum 0xcc2c641c, Offset: 0xe2
// Size: 0x17
function function_5686a343a63d751b( callback )
{
    function_65640c4fcadb01b7( callback, 1 );
}

// Namespace ftue_inventory
// Params 2
// Checksum 0xcd5f5200, Offset: 0x101
// Size: 0x1f
function function_c73aae2dec3c0746( itemindex, callback )
{
    function_8a33d8e2935f2ab( itemindex, callback );
}

// Namespace ftue_inventory
// Params 2
// Checksum 0xf8bf3f08, Offset: 0x128
// Size: 0x1f
function function_28f17fc1944afdb( callback, itemtype )
{
    function_419e7b9e14ada9c2( callback, itemtype );
}

// Namespace ftue_inventory
// Params 2, eflags: 0x4
// Checksum 0x24cc1f3f, Offset: 0x14f
// Size: 0x72
function private function_65640c4fcadb01b7( callback, typeaction )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, action );
        
        if ( channel == "inventory_action" )
        {
            if ( action == typeaction )
            {
                self [[ callback ]]();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_inventory
// Params 2, eflags: 0x4
// Checksum 0xbe533bad, Offset: 0x1c9
// Size: 0x7f
function private function_8a33d8e2935f2ab( item, callback )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    assert( isdefined( item ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, itemindex );
        
        if ( channel == "inventory_select_option" )
        {
            if ( item == itemindex )
            {
                self [[ callback ]]( itemindex );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_inventory
// Params 2, eflags: 0x4
// Checksum 0x20946555, Offset: 0x250
// Size: 0xcf
function private function_419e7b9e14ada9c2( callback, itemtype )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, id );
        
        if ( channel != "drop_all_items" && channel != "drop_item" )
        {
            continue;
        }
        
        dropall = channel == "drop_all_items";
        itemtypedropped = br::function_3de28729170831f5( id );
        itemindexdropped = br::function_7c2313dee0222a3( id );
        
        if ( isdefined( itemtype ) )
        {
            if ( itemtypedropped == itemtype )
            {
                self [[ callback ]]( id, itemtypedropped, itemindexdropped, dropall );
            }
            
            return;
        }
        
        self [[ callback ]]( id, itemtypedropped, itemindexdropped, dropall );
        return;
    }
}

