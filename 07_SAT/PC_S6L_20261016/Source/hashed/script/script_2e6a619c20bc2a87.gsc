// script_2e6a619c20bc2a87  (hash_2e6a619c20bc2a87.gscc) (size: 4234 Bytes / 0x108a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8a7792 (243955602)
// size ...... 4234 (0x108a)
// includes .. 5   (offset: 0xf8a)
// strings ... 3   (offset: 0xfb2)
// dev strs .. 15  (offset: 0xfd6)
// exports ... 11  (offset: 0x8ba)
// cseg ...... 0x85 + 0x835 (0x8ba)
// imports ... 45  (offset: 0xa72)
// animtree1 . 0   (offset: 0x108a)
// animtree2 . 0   (offset: 0x108a)
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\operator;

#namespace character_review;

// Namespace character_review
// Params 0, eflags: 0x5
// Checksum 0xd68438ff, Offset: 0xa3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"character_review", undefined, undefined, &init_character_review );
}

// Namespace character_review
// Params 0, eflags: 0x4
// Checksum 0x9d041e7b, Offset: 0xc4
// Size: 0x2fb
function private init_character_review()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_742caa13b3c2e685" ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_21b7433fe7d7e5ec", 1 ) )
        {
            return;
        }
        
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_95e34f0acb24f5b1", 48 );
        setdvarifuninitialized( @"hash_643fb203d0765042", ( 750, 0, 0 ) );
        setdvarifuninitialized( @"hash_2d18f8b8b4998819", "<dev string:x24>" );
        setdvar( @"bot_disableallai", 1 );
        setdvar( @"hash_803cefdbe23f6bfe", 1 );
        level.var_22773e0b911bedd3 = 1;
        level.assigned_operator_skins = 0;
        level.var_ba57ea5862ae69c5 = [];
        devgui::function_9082edeb5db93280( "<dev string:x2b>" );
        devgui::add_devgui_func( "<dev string:x4c>", "<dev string:x65>", &function_5367399920875bab );
        devgui::add_devgui_command( "<dev string:x85>", "<dev string:x91>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x104>", @"hash_d923532208e882e5" );
        operator::function_2a088dd032a61c0a();
        level.operator_skin_data = spawnstruct();
        level.operator_skin_data.operator_refs = [];
        level.operator_skin_data.operator_skins = [];
        
        foreach ( operator in level.var_b3fc180d242c4d12 )
        {
            operatorbundle = operator::getoperatorbundle( operator );
            skins = operatorbundle.skins;
            
            foreach ( skin in skins )
            {
                skin_name = tolower( getxhashsourcename( skin.skin ) );
                
                if ( isvalidskin( skin_name, operatorbundle ) )
                {
                    devgui::function_cd4e263c1f3018ae( "<dev string:x114>" + skin_name, "<dev string:x11b>" + level.operator_skin_data.operator_refs.size, &function_2fe508b123d6ed72 );
                    level.operator_skin_data.operator_refs[ level.operator_skin_data.operator_refs.size ] = operator;
                    level.operator_skin_data.operator_skins[ level.operator_skin_data.operator_skins.size ] = skin_name;
                }
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace character_review
    // Params 2, eflags: 0x4
    // Checksum 0x99a0a287, Offset: 0x3c7
    // Size: 0x81, Type: dev
    function private isvalidskin( skin_name, operatorbundle )
    {
        if ( issubstr( skin_name, "<dev string:x136>" ) )
        {
            if ( getdvarint( @"hash_8fb0b273e38438db", 1 ) && ( issubstr( skin_name, "<dev string:x13a>" ) || issubstr( skin_name, "<dev string:x149>" ) || issubstr( skin_name, "<dev string:x158>" ) || issubstr( skin_name, "<dev string:x162>" ) ) )
            {
                return 0;
            }
            else
            {
                return 1;
            }
            
            return;
        }
        
        return 0;
    }

#/

// Namespace character_review
// Params 0, eflags: 0x4
// Checksum 0x721cfb23, Offset: 0x450
// Size: 0x11b
function private function_5367399920875bab()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_d79850106ac81a77" ) )
    {
        setdvar( @"hash_d79850106ac81a77", 0 );
        level.assigned_operator_skins = 0;
    }
    
    angles = ( 0, 180, 0 );
    spacing = getdvarfloat( @"hash_95e34f0acb24f5b1" );
    right = anglestoright( angles ) * spacing;
    left = anglestoleft( angles ) * spacing;
    right_count = 1;
    left_count = 1;
    
    for ( i = 0; i < level.operator_skin_data.operator_refs.size ; i++ )
    {
        step_direction = undefined;
        step_count = undefined;
        
        if ( i > 0 )
        {
            if ( i % 2 == 1 )
            {
                step_direction = right;
                step_count = right_count;
                right_count++;
            }
            else
            {
                step_direction = left;
                step_count = left_count;
                left_count++;
            }
        }
        
        function_b5d9a88cacf47cec( step_count, step_direction );
    }
}

// Namespace character_review
// Params 2, eflags: 0x4
// Checksum 0xd654c4aa, Offset: 0x573
// Size: 0x102
function private function_b5d9a88cacf47cec( step_count = 0, step_dir = ( 0, 0, 0 ) )
{
    starting_origin = getdvarvector( @"hash_643fb203d0765042" );
    angles = ( 0, 180, 0 );
    team = getdvar( @"hash_2d18f8b8b4998819" );
    spawner = spawnstruct();
    spawner.angles = angles;
    origin = starting_origin + step_dir * step_count;
    spawner.origin = origin;
    
    if ( getdvarint( @"hash_d923532208e882e5", 0 ) )
    {
        thread utility::draw_line_for_time( origin, origin + ( 0, 0, 128 ), 1, 1, 1, 120, "game_ended" );
    }
    
    bots::spawn_bots( 1, team, &function_25e573fe3838d91c, undefined, undefined, "recruit", spawner );
}

// Namespace character_review
// Params 0, eflags: 0x4
// Checksum 0x7257a333, Offset: 0x67d
// Size: 0xa2
function private function_25e573fe3838d91c()
{
    /#
        self function_3a7598d6982eb648( 1 );
        index = level.var_1f9fb992094061db ?? level.assigned_operator_skins;
        
        if ( isdefined( level.var_1f9fb992094061db ) )
        {
            level.var_1f9fb992094061db = undefined;
        }
        else
        {
            level.assigned_operator_skins++;
        }
        
        operator::createoperatorcustomization( level.operator_skin_data.operator_refs[ index ], level.operator_skin_data.operator_skins[ index ] );
        level.var_ba57ea5862ae69c5[ level.var_ba57ea5862ae69c5.size ] = self;
        thread function_b214cce58c4999d2();
    #/
}

// Namespace character_review
// Params 0, eflags: 0x4
// Checksum 0x33b05618, Offset: 0x727
// Size: 0x79
function private remove_all_spawned_bots()
{
    foreach ( bot in level.var_ba57ea5862ae69c5 )
    {
        bot kill();
    }
}

// Namespace character_review
// Params 0, eflags: 0x4
// Checksum 0x6da51394, Offset: 0x7a8
// Size: 0x32
function private function_b214cce58c4999d2()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    level.var_ba57ea5862ae69c5 = arrayremove( level.var_ba57ea5862ae69c5, self );
}

// Namespace character_review
// Params 0, eflags: 0x4
// Checksum 0x59bdc4a2, Offset: 0x7e2
// Size: 0x7f
function private function_90c05b25589265ef()
{
    foreach ( bot in level.var_ba57ea5862ae69c5 )
    {
        bot botsetflag( "disable_rotation", 0 );
    }
}

// Namespace character_review
// Params 1, eflags: 0x4
// Checksum 0x540b63e5, Offset: 0x869
// Size: 0x51
function private function_2fe508b123d6ed72( params )
{
    if ( !isdefined( params ) || params.size < 1 )
    {
        return;
    }
    
    if ( level.var_ba57ea5862ae69c5.size > 0 )
    {
        /#
            adddebugcommand( "<dev string:x178>" );
        #/
    }
    
    level.var_1f9fb992094061db = int( params[ 0 ] );
    function_b5d9a88cacf47cec();
}

