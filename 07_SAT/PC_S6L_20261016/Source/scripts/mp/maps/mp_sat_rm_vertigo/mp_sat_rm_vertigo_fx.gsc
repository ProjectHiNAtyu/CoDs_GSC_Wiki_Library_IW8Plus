// scripts\mp\maps\mp_sat_rm_vertigo\mp_sat_rm_vertigo_fx.gsc  (hash_6de77768959b3652.gscc) (size: 1176 Bytes / 0x498 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x524d3f95 (1380794261)
// size ...... 1176 (0x498)
// includes .. 0   (offset: 0x448)
// strings ... 5   (offset: 0x448)
// dev strs .. 0   (offset: 0x498)
// exports ... 4   (offset: 0x2b8)
// cseg ...... 0x92 + 0x226 (0x2b8)
// imports ... 8   (offset: 0x358)
// animtree1 . 0   (offset: 0x498)
// animtree2 . 0   (offset: 0x498)
#namespace mp_sat_rm_vertigo_fx;

// Namespace mp_sat_rm_vertigo_fx
// Params 0
// Checksum 0x24c742c3, Offset: 0xb0
// Size: 0xe
function main()
{
    thread sliding_door( "sliding_door" );
}

// Namespace mp_sat_rm_vertigo_fx
// Params 1
// Checksum 0xb234be80, Offset: 0xc6
// Size: 0xb0
function sliding_door( trigname )
{
    level endon( #"game_ended" );
    level waittill( #"matchstarttimer_done" );
    door_triggers = getentarray( trigname, #targetname );
    
    foreach ( trig in door_triggers )
    {
        thread sliding_door_watch( trig );
    }
}

// Namespace mp_sat_rm_vertigo_fx
// Params 1
// Checksum 0x1896eff5, Offset: 0x17e
// Size: 0x13a
function sliding_door_watch( trig )
{
    while ( true )
    {
        if ( !( isdefined( trig.scriptable_01 ) && isdefined( trig.scriptable_02 ) ) )
        {
            scriptables = getentitylessscriptablearray( "door_scr", #targetname );
            trig.scriptable_01 = sortbydistancecullbyradius( scriptables, trig.origin, 128 )[ 0 ];
            trig.scriptable_02 = sortbydistancecullbyradius( scriptables, trig.origin, 128 )[ 1 ];
        }
        
        trig waittill( #"trigger" );
        trig.scriptable_01 setscriptablepartstate( "door", "opening" );
        
        if ( isdefined( trig.scriptable_02 ) )
        {
            trig.scriptable_02 setscriptablepartstate( "door", "opening" );
        }
        
        wait 5;
        trig.scriptable_01 setscriptablepartstate( "door", "closing" );
        
        if ( isdefined( trig.scriptable_02 ) )
        {
            trig.scriptable_02 setscriptablepartstate( "door", "closing" );
        }
        
        while ( sliding_door_watch( trig ) )
        {
            waitframe();
        }
    }
}

