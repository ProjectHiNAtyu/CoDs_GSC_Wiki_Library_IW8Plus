// scripts\mp\destructables.gsc  (hash_7ad2c20674b3130b.gscc) (size: 1474 Bytes / 0x5c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b75e5b8 (729146808)
// size ...... 1474 (0x5c2)
// includes .. 1   (offset: 0x59e)
// strings ... 2   (offset: 0x5a6)
// dev strs .. 0   (offset: 0x5c2)
// exports ... 8   (offset: 0x322)
// cseg ...... 0x6d + 0x2b5 (0x322)
// imports ... 11  (offset: 0x462)
// animtree1 . 0   (offset: 0x5c2)
// animtree2 . 0   (offset: 0x5c2)
#using scripts\common\utility;

#namespace destructables;

// Namespace destructables
// Params 0
// Checksum 0x1e5cf1f9, Offset: 0x8b
// Size: 0x75
function init()
{
    ents = getentarray( "destructable", #targetname );
    
    if ( getdvarint( @"scr_destructables", 1 ) == 0 )
    {
        for ( i = 0; i < ents.size ; i++ )
        {
            ents[ i ] delete();
        }
        
        return;
    }
    
    for ( i = 0; i < ents.size ; i++ )
    {
        ents[ i ] thread destructable_think();
    }
}

// Namespace destructables
// Params 0
// Checksum 0x87ee12aa, Offset: 0x108
// Size: 0x115
function destructable_think()
{
    accumulate = 40;
    threshold = 0;
    
    if ( isdefined( self.script_accumulate ) )
    {
        accumulate = self.script_accumulate;
    }
    
    if ( isdefined( self.script_threshold ) )
    {
        threshold = self.script_threshold;
    }
    
    if ( isdefined( self.script_destructable_area ) )
    {
        areas = strtok( self.script_destructable_area, " " );
        
        for ( i = 0; i < areas.size ; i++ )
        {
            blockarea( areas[ i ] );
        }
    }
    
    if ( isdefined( self.script_fxid ) )
    {
        self.fx = utility::load_fx( self.script_fxid );
    }
    
    dmg = 0;
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( #"damage", amount, other );
        
        if ( amount >= threshold )
        {
            dmg += amount;
            
            if ( dmg >= accumulate )
            {
                thread destructable_destruct();
                return;
            }
        }
    }
}

// Namespace destructables
// Params 0
// Checksum 0xdf1b84a1, Offset: 0x225
// Size: 0x9b
function destructable_destruct()
{
    ent = self;
    
    if ( isdefined( self.script_destructable_area ) )
    {
        areas = strtok( self.script_destructable_area, " " );
        
        for ( i = 0; i < areas.size ; i++ )
        {
            unblockarea( areas[ i ] );
        }
    }
    
    if ( isdefined( ent.fx ) )
    {
        playfx( ent.fx, ent.origin + ( 0, 0, 6 ) );
    }
    
    ent delete();
}

// Namespace destructables
// Params 1
// Checksum 0x2dbdf39a, Offset: 0x2c8
// Size: 0xc
function blockarea( area )
{
    
}

// Namespace destructables
// Params 2
// Checksum 0x47b746b4, Offset: 0x2dc
// Size: 0x15
function blockentsinarea( ents, area )
{
    
}

// Namespace destructables
// Params 1
// Checksum 0xe0689caa, Offset: 0x2f9
// Size: 0xc
function unblockarea( area )
{
    
}

// Namespace destructables
// Params 2
// Checksum 0xd052ed3d, Offset: 0x30d
// Size: 0x15
function unblockentsinarea( ents, area )
{
    
}

