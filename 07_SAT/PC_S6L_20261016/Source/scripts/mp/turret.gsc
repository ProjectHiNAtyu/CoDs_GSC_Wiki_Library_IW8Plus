// scripts\mp\turret.gsc  (hash_6595ed698585f630.gscc) (size: 2834 Bytes / 0xb12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe0118ba (4261484730)
// size ...... 2834 (0xb12)
// includes .. 2   (offset: 0xa76)
// strings ... 10  (offset: 0xa86)
// dev strs .. 0   (offset: 0xb12)
// exports ... 6   (offset: 0x5de)
// cseg ...... 0xcf + 0x50f (0x5de)
// imports ... 32  (offset: 0x6ce)
// animtree1 . 0   (offset: 0xb12)
// animtree2 . 0   (offset: 0xb12)
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\gameobjects;

#namespace turret;

// Namespace turret
// Params 0
// Checksum 0xf7767162, Offset: 0xed
// Size: 0xfe
function init()
{
    array = getentarray( "turret_mp", #targetname );
    
    if ( isbrgamemode() )
    {
        foreach ( ent in array )
        {
            ent delete();
        }
        
        return;
    }
    
    foreach ( ent in array )
    {
        add_turret( ent );
    }
}

// Namespace turret
// Params 1
// Checksum 0xf0fe2b8a, Offset: 0x1f3
// Size: 0x272
function add_turret( turret )
{
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    objweapon = makeweapon( turret.weaponinfo );
    turret.objweapon = objweapon;
    
    if ( isdefined( turret.script_noteworthy ) )
    {
        types = strtok( turret.script_noteworthy, "," );
        
        foreach ( type in types )
        {
            values = strtok( type, "|" );
            
            if ( isdefined( values ) )
            {
                if ( values[ 0 ] == "arc" )
                {
                    if ( isdefined( values[ 1 ] ) && values[ 1 ] != "0" )
                    {
                        turret setleftarc( int( values[ 1 ] ) );
                    }
                    
                    if ( isdefined( values[ 2 ] ) && values[ 2 ] != "0" )
                    {
                        turret setrightarc( int( values[ 2 ] ) );
                    }
                    
                    if ( isdefined( values[ 3 ] ) && values[ 3 ] != "0" )
                    {
                        turret settoparc( int( values[ 3 ] ) );
                    }
                    
                    if ( isdefined( values[ 4 ] ) && values[ 4 ] != "0" )
                    {
                        turret setbottomarc( int( values[ 4 ] ) );
                    }
                }
            }
        }
    }
    
    useobjorigin = turret gettagorigin( "tag_turret_pitch" );
    useobj = gameobjects::createhintobject( useobjorigin, "HINT_BUTTON", "hud_icon_turret", &"killstreaks_hints/sentry_use_gl" );
    useobj linkto( turret, "tag_turret_pitch", ( 0, 0, 5 ), ( 0, 0, 0 ) );
    turret.useobj = useobj;
    useobj thread turretthink( turret );
    killcamorigin = turret gettagorigin( "tag_player" );
    turret.killcament = spawn( "script_model", killcamorigin );
    turret.killcament linkto( turret, "tag_player", ( -60, 0, 20 ), ( 0, 0, 0 ) );
}

// Namespace turret
// Params 1
// Checksum 0x336f7367, Offset: 0x46d
// Size: 0xf8
function turretthink( turret )
{
    while ( true )
    {
        self waittill( #"trigger", player );
        self makeunusable();
        thread endturretonplayer( player );
        player.prevweapon = player getcurrentweapon();
        player.useweapon = getcompleteweaponname( turret.objweapon );
        player inventory_utility::_giveweapon( player.useweapon, undefined, undefined, 1 );
        
        while ( player inventory_utility::domonitoredweaponswitch( player.useweapon, 1 ) == 0 )
        {
            waitframe();
        }
        
        player controlturreton( turret );
        thread endturretusewatch( player, turret );
        self waittill( #"hash_ebfdc855350d305" );
        
        if ( isdefined( player ) )
        {
            player controlturretoff( turret );
            player switchtoweaponimmediate( player.prevweapon );
            player inventory_utility::_takeweapon( player.useweapon );
        }
        
        self makeusable();
    }
}

// Namespace turret
// Params 2
// Checksum 0xdeab80b7, Offset: 0x56d
// Size: 0x43
function endturretusewatch( player, turret )
{
    while ( player usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( player usebuttonpressed() )
        {
            self notify( #"hash_ebfdc855350d305" );
            break;
        }
        
        waitframe();
    }
}

// Namespace turret
// Params 1
// Checksum 0xbe1d5fb9, Offset: 0x5b8
// Size: 0x26
function endturretonplayer( player )
{
    player waittill( #"death_or_disconnect" );
    self notify( #"hash_ebfdc855350d305" );
}

