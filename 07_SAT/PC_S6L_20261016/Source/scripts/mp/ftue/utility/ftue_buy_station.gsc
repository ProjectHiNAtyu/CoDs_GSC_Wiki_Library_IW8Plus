// scripts\mp\ftue\utility\ftue_buy_station.gsc  (hash_0c7a00602fb8e464.gscc) (size: 2040 Bytes / 0x7f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63b2893f (1672644927)
// size ...... 2040 (0x7f8)
// includes .. 0   (offset: 0x7a0)
// strings ... 6   (offset: 0x7a0)
// dev strs .. 0   (offset: 0x7f8)
// exports ... 9   (offset: 0x5e0)
// cseg ...... 0xd8 + 0x508 (0x5e0)
// imports ... 3   (offset: 0x748)
// animtree1 . 0   (offset: 0x7f8)
// animtree2 . 0   (offset: 0x7f8)
#namespace ftue_buy_station;

// Namespace ftue_buy_station
// Params 1
// Checksum 0x3bf2e27, Offset: 0xf6
// Size: 0xe1
function function_257e64c6b678cf0e( var_e10a15fe8b2b59de )
{
    if ( !isdefined( level.br_armory_kiosk ) )
    {
        return;
    }
    
    var_37a43e3e209b44cc = undefined;
    
    foreach ( item in level.br_armory_kiosk.items )
    {
        if ( item.cost < var_37a43e3e209b44cc.cost || !isdefined( var_37a43e3e209b44cc ) )
        {
            if ( var_e10a15fe8b2b59de && item.cost == 0 )
            {
                continue;
            }
            
            var_37a43e3e209b44cc = item;
        }
    }
    
    return var_37a43e3e209b44cc;
}

// Namespace ftue_buy_station
// Params 1
// Checksum 0x1febe15d, Offset: 0x1e0
// Size: 0xa0
function function_6b9b839e78816bea( entryref )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    foreach ( item in self.items )
    {
        if ( item.entryref == entryref )
        {
            return item.cost;
        }
    }
}

// Namespace ftue_buy_station
// Params 1
// Checksum 0xfebd7c46, Offset: 0x289
// Size: 0x6d
function function_24ecaedc04ead4df( callback )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "buy_menu_option_selected" || channel == "buy_menu_open" )
        {
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace ftue_buy_station
// Params 1
// Checksum 0x902002b7, Offset: 0x2fe
// Size: 0x92
function function_41412941194cd7c9( callback )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "br_cancel_purchase" )
        {
            self [[ callback ]]();
            return;
        }
        
        if ( channel == "br_item_purchase" || channel == "br_loadout_purchase" )
        {
            if ( getdvarint( @"hash_ed6e4ffa933af621", 0 ) == 0 )
            {
                self [[ callback ]]();
                return;
            }
        }
    }
}

// Namespace ftue_buy_station
// Params 2
// Checksum 0x9ff2eb9a, Offset: 0x398
// Size: 0xca
function function_4c013e59d38a18ec( callback, var_69340207cbad6530 )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "br_item_purchase" || channel == "br_loadout_purchase" || channel == "br_team_revive" )
        {
            itemdata = level.br_armory_kiosk.items[ class ];
            
            if ( isdefined( var_69340207cbad6530 ) )
            {
                if ( isdefined( itemdata ) && itemdata.ref == var_69340207cbad6530 )
                {
                    self [[ callback ]]();
                    return;
                }
                
                continue;
            }
            
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace ftue_buy_station
// Params 2
// Checksum 0x1701140a, Offset: 0x46a
// Size: 0xa6
function function_c4b9676fb3dc21ff( callback, var_d7fdd4b679cae28 )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    itemindex = 0;
    
    if ( isdefined( var_d7fdd4b679cae28 ) )
    {
        itemindex = level.br_armory_kiosk function_aa45744700d3e689( var_d7fdd4b679cae28 );
    }
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, id );
        
        if ( channel == "buy_menu_option_selected" )
        {
            if ( isdefined( var_d7fdd4b679cae28 ) )
            {
                if ( itemindex == id )
                {
                    self [[ callback ]]();
                    return;
                }
            }
            else
            {
                self [[ callback ]]();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_buy_station
// Params 2
// Checksum 0xcec9c279, Offset: 0x518
// Size: 0x6a
function function_baf3585c71fae0de( callback, var_69340207cbad6530 )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "br_team_revive" )
        {
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace ftue_buy_station
// Params 1
// Checksum 0xc9bb5246, Offset: 0x58a
// Size: 0x55
function function_aa45744700d3e689( itemref )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    for ( index = 0; index < self.items.size ; index++ )
    {
        if ( self.items[ index ].entryref == itemref )
        {
            return index;
        }
    }
}

