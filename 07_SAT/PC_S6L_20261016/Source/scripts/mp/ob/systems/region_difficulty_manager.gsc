// scripts\mp\ob\systems\region_difficulty_manager.gsc  (hash_02f9543776d129cd.gscc) (size: 13997 Bytes / 0x36ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b426671 (994207345)
// size ...... 13997 (0x36ad)
// includes .. 12  (offset: 0x3305)
// strings ... 37  (offset: 0x3365)
// dev strs .. 19  (offset: 0x35c9)
// exports ... 32  (offset: 0x22a5)
// cseg ...... 0x40a + 0x1e9b (0x22a5)
// imports ... 93  (offset: 0x27a5)
// animtree1 . 0   (offset: 0x36ad)
// animtree2 . 0   (offset: 0x36ad)
#using script_2498b7c75f1dee2d;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;

#namespace region_difficulty_manager;

// Namespace region_difficulty_manager
// Params 0, eflags: 0x5
// Checksum 0x82ffa79d, Offset: 0x428
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"region_difficulty_manager", undefined, &_pre_main_init, &_post_main_init );
}

// Namespace region_difficulty_manager
// Params 0, eflags: 0x4
// Checksum 0x7bd3157d, Offset: 0x44d
// Size: 0x4d3
function private _pre_main_init()
{
    level.region_difficulty_manager = spawnstruct();
    level.region_difficulty_manager.difficulties = [ "difficulty_undefined", "difficulty_easy", "difficulty_normal", "difficulty_hard", "difficulty_darkaether", "difficulty5", "difficulty6" ];
    level.region_difficulty_manager.round_number_table = [ "difficulty6":getdvarint( @"hash_bad65024142d0a69", 100 ), "difficulty5":getdvarint( @"hash_bad64d24142d03d0", 100 ), "difficulty_darkaether":getdvarint( @"hash_bad64e24142d0603", 55 ), "difficulty_hard":getdvarint( @"hash_bad65324142d1102", 35 ), "difficulty_normal":getdvarint( @"hash_bad65424142d1335", 20 ), "difficulty_easy":getdvarint( @"hash_bad65124142d0c9c", 3 ), "difficulty_undefined":getdvarint( @"hash_d06430cd9b7524df", 1 ) ];
    level.region_difficulty_manager.region_difficulty_to_int = [ "difficulty6":6, "difficulty5":5, "difficulty_darkaether":4, "difficulty_hard":3, "difficulty_normal":2, "difficulty_easy":1, "difficulty_undefined":0 ];
    level.region_difficulty_manager.default_region = { #difficultyint:1, #difficulty:"difficulty_easy", #name:"WORLD_REGION", #index:-1 };
    
    if ( !isdefined( level.var_bb86f77304f193c4 ) )
    {
        if ( level.gametypebundle.var_bb86f77304f193c4 )
        {
            level.var_bb86f77304f193c4 = getscriptbundle( level.gametypebundle.var_bb86f77304f193c4 );
        }
        else
        {
            level.var_bb86f77304f193c4 = getscriptbundle( %"hash_179cc1dca1a65126" );
        }
    }
    
    if ( !level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        return;
    }
    
    level.region_difficulty_manager.regions = [];
    region_volumes = getnoentvolumearray( level.var_bb86f77304f193c4.var_27a887619fcae604, #script_noteworthy );
    
    foreach ( volume in region_volumes )
    {
        region_name = volume.targetname;
        
        if ( !isdefined( region_name ) )
        {
            throw( "Region volume at " + volume.origin + " does not have a targetname field to specify the name." );
            continue;
        }
        
        var_546e4eb5269dbafa = volume.script_parameters;
        
        if ( !isdefined( var_546e4eb5269dbafa ) )
        {
            throw( "Region \"" + region_name + "\" does not have a script_parameters field to specify the difficulty." );
            continue;
        }
        
        region_difficulty_int = int( var_546e4eb5269dbafa );
        var_546e4eb5269dbafa = level.region_difficulty_manager.difficulties[ region_difficulty_int ];
        
        if ( !isdefined( var_546e4eb5269dbafa ) )
        {
            throw( "Region \"" + region_name + "\" does not specify a valid difficulty:" + volume.script_parameters );
            continue;
        }
        
        level.region_difficulty_manager.regions[ region_name ] = { #volume:volume, #difficultyint:region_difficulty_int, #difficulty:var_546e4eb5269dbafa, #name:region_name, #index:level.region_difficulty_manager.regions.size };
    }
    
    level callback::add( "on_zombie_ai_spawned", &function_fefd8fb7d307d2b4 );
    level.var_148e14aa588539af = &function_dd8fdc097de1db78;
    level.var_bb131187d6741752 = &get_region_difficulty;
    level.var_2f699c8203773173 = &function_f9fbb630598afdc7;
    
    if ( level.var_bb86f77304f193c4.var_b286821540ba34f0 )
    {
        callback::add( "player_region_difficulty_change", &function_f26583cf3dcbd795 );
    }
    
    if ( level.var_bb86f77304f193c4.var_8d8184f49503222d )
    {
        callback::add( "player_region_difficulty_change", &function_bd9847f267d142f6 );
    }
    
    if ( level.var_bb86f77304f193c4.var_219c204899ce2b0e )
    {
        callback::add( "player_region_difficulty_change", &function_aec1065e06c4336e );
    }
    
    if ( getdvarint( @"hash_144e2791a71573c4", 1 ) )
    {
        callback::add( "player_region_difficulty_change", &function_b1af95c2d8f522c7 );
    }
    
    utility::registersharedfunc( #"region_difficulty_manager", #"hash_92c9697fbfaef62e", &function_94a2b03802002237 );
    thread update_player_regions();
}

// Namespace region_difficulty_manager
// Params 0, eflags: 0x4
// Checksum 0x4715046c, Offset: 0x928
// Size: 0xdc
function private _post_main_init()
{
    level callback::callback( "region_difficulties_registered" );
    
    if ( !level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        return;
    }
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x48>", &debug_print_player_region );
        devgui::add_devgui_func( "<dev string:x62>", "<dev string:x7a>", &function_9bc1c93013ebb474 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x94>", "<dev string:xb0>", &function_18e30232f36a1951, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc1>", "<dev string:xda>", &function_18e30232f36a1951, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xeb>", "<dev string:x104>", &function_18e30232f36a1951, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x115>", "<dev string:x12e>", &function_18e30232f36a1951, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13f>", "<dev string:x158>", &function_18e30232f36a1951, 0 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace region_difficulty_manager
// Params 0
// Checksum 0x7186d00d, Offset: 0xa0c
// Size: 0x15
function function_ca02c3577d55b5f6()
{
    return level.region_difficulty_manager.difficulties;
}

// Namespace region_difficulty_manager
// Params 2
// Checksum 0x452fbf8, Offset: 0xa2a
// Size: 0xc3
function override_region_difficulty( region_name, difficulty )
{
    region = level.region_difficulty_manager.regions[ region_name ];
    
    if ( region )
    {
        region.difficulty = difficulty;
        region.difficultyint = level.region_difficulty_manager.region_difficulty_to_int[ difficulty ];
        return;
    }
    
    level.region_difficulty_manager.default_region.difficulty = difficulty;
    level.region_difficulty_manager.default_region.difficultyint = level.region_difficulty_manager.region_difficulty_to_int[ difficulty ];
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0xada9717c, Offset: 0xaf5
// Size: 0xf6
function function_410b4f83b0a5b98( difficulty )
{
    /#
        assert( isdefined( difficulty ) );
        assert( arraycontains( level.region_difficulty_manager.difficulties, difficulty ) );
    #/
    
    self.difficulty = difficulty;
    round_number = function_d33b93a54f11258d( difficulty );
    zombie_utils::set_zombie_round_difficulty( round_number, 0, 0 );
    
    if ( isdefined( self.var_d6894f01a36b4ff3.healthscriptbundle ) )
    {
        ai::set_ai_max_health( namespace_775af9b7afedb6d1::function_28795222258b3cca( self.var_d6894f01a36b4ff3.healthscriptbundle, round_number ) );
    }
    
    self.maxhealth *= getdvarfloat( @"hash_a296d84ecc8ab62a", level.gametypebundle.var_6cfc57a4b0d987d ?? 1 );
    self.health = self.maxhealth;
    function_2f156738dfca327c( self, difficulty, round_number );
}

// Namespace region_difficulty_manager
// Params 2
// Checksum 0xda2b407b, Offset: 0xbf3
// Size: 0x14e
function function_a30ff99c426601b4( var_9e6c61f06d68f6d9, var_61e5fd9b46e98e4f )
{
    base_difficulty_num = 0;
    
    foreach ( difficulty in level.region_difficulty_manager.difficulties )
    {
        if ( difficulty == var_9e6c61f06d68f6d9 )
        {
            break;
        }
        
        base_difficulty_num++;
    }
    
    new_difficulty = undefined;
    new_difficulty_index = base_difficulty_num + var_61e5fd9b46e98e4f;
    var_a376fd5283f69590 = 0;
    
    foreach ( difficulty in level.region_difficulty_manager.difficulties )
    {
        new_difficulty = difficulty;
        
        if ( var_a376fd5283f69590 >= new_difficulty_index )
        {
            break;
        }
        
        var_a376fd5283f69590++;
    }
    
    return new_difficulty;
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0xac4879ac, Offset: 0xd4a
// Size: 0x75
function function_dc53171229eb2097( difficultyint )
{
    switch ( difficultyint )
    {
        case 2:
            return "difficulty_normal";
        case 3:
            return "difficulty_hard";
        case 4:
            return "difficulty_darkaether";
        case 5:
            return "difficulty5";
        case 6:
            return "difficulty6";
    }
    
    return "difficulty_easy";
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0xaab73d1c, Offset: 0xdc8
// Size: 0x1d
function function_d2213de17e7b3faf( region )
{
    return function_dc53171229eb2097( region.difficultyint );
}

// Namespace region_difficulty_manager
// Params 0
// Checksum 0xc0e0377a, Offset: 0xdee
// Size: 0x5a
function function_4f8f6054ecabf2dc()
{
    regions = arraycopy( level.region_difficulty_manager.regions );
    regions[ level.region_difficulty_manager.default_region.name ] = level.region_difficulty_manager.default_region;
    return regions;
}

// Namespace region_difficulty_manager
// Params 0
// Checksum 0xb95878c6, Offset: 0xe51
// Size: 0x21
function get_regions_randomized()
{
    regions = function_4f8f6054ecabf2dc();
    function_cdc669dbc8ea2101( regions );
    return arrayrandomize( regions );
}

// Namespace region_difficulty_manager
// Params 2, eflags: 0x4
// Checksum 0x6e3602ba, Offset: 0xe7b
// Size: 0x13b
function private calculate_region( point, var_5697346d179cd4ca )
{
    if ( !isvector( point ) )
    {
        assertmsg( "<dev string:x169>" );
        return;
    }
    
    var_93cd412d79e5e458 = undefined;
    var_fe6dae3e95f1ae7a = undefined;
    
    foreach ( region in level.region_difficulty_manager.regions )
    {
        if ( var_5697346d179cd4ca && region.name == var_5697346d179cd4ca )
        {
            return region;
        }
        
        if ( ispointinvolume( point, region.volume ) )
        {
            if ( isdefined( var_fe6dae3e95f1ae7a ) )
            {
                volume_size = length( region.volume getboundshalfsize() );
                
                if ( volume_size < var_fe6dae3e95f1ae7a )
                {
                    var_93cd412d79e5e458 = region;
                    var_fe6dae3e95f1ae7a = volume_size;
                }
                
                continue;
            }
            
            var_93cd412d79e5e458 = region;
            var_fe6dae3e95f1ae7a = length( region.volume getboundshalfsize() );
        }
    }
    
    return var_93cd412d79e5e458;
}

// Namespace region_difficulty_manager
// Params 0
// Checksum 0x68981aba, Offset: 0xfbf
// Size: 0x15
function get_default_region()
{
    return level.region_difficulty_manager.default_region;
}

// Namespace region_difficulty_manager
// Params 2
// Checksum 0x308e4f7b, Offset: 0xfdd
// Size: 0x4a
function function_f9fbb630598afdc7( point, var_5697346d179cd4ca )
{
    region = calculate_region( point, var_5697346d179cd4ca );
    
    if ( isdefined( region ) )
    {
        return region;
    }
    
    return level.region_difficulty_manager.default_region;
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x803fda1d, Offset: 0x102f
// Size: 0x28
function get_region_difficulty( point )
{
    region = function_f9fbb630598afdc7( point );
    return function_d2213de17e7b3faf( region );
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x3f2bec19, Offset: 0x1060
// Size: 0x1e
function get_region_difficulty_int( point )
{
    return function_f9fbb630598afdc7( point ).difficultyint;
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x23668f4c, Offset: 0x1087
// Size: 0x3f
function function_fefd8fb7d307d2b4( params )
{
    difficulty = function_94a2b03802002237( zombie_utils::get_zombie_round_difficulty() );
    self.difficulty = difficulty;
    function_2f156738dfca327c( self, difficulty, zombie_utils::get_zombie_round_difficulty() );
}

// Namespace region_difficulty_manager
// Params 2, eflags: 0x4
// Checksum 0xb49462bf, Offset: 0x10ce
// Size: 0x34
function private function_dd8fdc097de1db78( zombie, round_number )
{
    difficulty = function_94a2b03802002237( round_number );
    function_2f156738dfca327c( zombie, difficulty, round_number );
}

// Namespace region_difficulty_manager
// Params 3
// Checksum 0x4c34a933, Offset: 0x110a
// Size: 0x28a
function function_2f156738dfca327c( ai, difficulty, round_number )
{
    ai utility::callsharedfunc( #"zombie", #"hash_e27e55920dabe660", round_number );
    
    if ( ai.aicategory == "normal" )
    {
        var_e710411b7972ce5d = "run";
        archetype = ai getbasearchetype();
        has_sprint_speed = isdefined( getanimspeedthreshold( self, "sprint" ) );
        
        if ( has_sprint_speed )
        {
            randomroll = randomint( 100 );
            
            switch ( difficulty )
            {
                case #"hash_7bb2cd766703d463":
                    if ( randomroll < getdvarint( @"hash_80d80a5d47a0071f", 0 ) )
                    {
                        var_e710411b7972ce5d = "super_sprint";
                    }
                    else if ( randomroll < getdvarint( @"hash_46afd4b17cc02e43", 25 ) )
                    {
                        var_e710411b7972ce5d = "sprint";
                    }
                    
                    break;
                case #"hash_af83e47edfa8900a":
                    if ( randomroll < getdvarint( @"hash_80d80b5d47a00952", 5 ) )
                    {
                        var_e710411b7972ce5d = "super_sprint";
                    }
                    else if ( randomroll < getdvarint( @"hash_46afd5b17cc03076", 60 ) )
                    {
                        var_e710411b7972ce5d = "sprint";
                    }
                    
                    break;
                case #"hash_5343b465e56ec9a4":
                    if ( randomroll < getdvarint( @"hash_80d80c5d47a00b85", 30 ) )
                    {
                        var_e710411b7972ce5d = "super_sprint";
                    }
                    else if ( randomroll < getdvarint( @"hash_46afd6b17cc032a9", 100 ) )
                    {
                        var_e710411b7972ce5d = "sprint";
                    }
                    
                    break;
                case #"hash_651f76c0ad6741ec":
                    if ( randomroll < getdvarint( @"hash_80d8055d479ffc20", 30 ) )
                    {
                        var_e710411b7972ce5d = "super_sprint";
                    }
                    else if ( randomroll < getdvarint( @"hash_46afd7b17cc034dc", 100 ) )
                    {
                        var_e710411b7972ce5d = "sprint";
                    }
                    
                    break;
                case #"hash_c0250ffc2e87f2ff":
                case #"hash_c02510fc2e87f492":
                    if ( randomroll < getdvarint( @"hash_80d8065d479ffe53", 50 ) )
                    {
                        var_e710411b7972ce5d = "super_sprint";
                    }
                    else if ( randomroll < getdvarint( @"hash_46afd8b17cc0370f", 100 ) )
                    {
                        var_e710411b7972ce5d = "sprint";
                    }
                    
                    break;
            }
        }
        
        ai zombie_utils::function_a8ce00e0448cb6f0( var_e710411b7972ce5d, "difficulty_region", 1 );
        params = spawnstruct();
        params.ai = ai;
        params.difficulty = difficulty;
        params.id = "difficulty_region";
        params.priority = 1;
        level callback::callback( "set_region_difficulty_manager_speed", params );
    }
}

// Namespace region_difficulty_manager
// Params 0
// Checksum 0xc854b23a, Offset: 0x139c
// Size: 0x281
function update_player_regions()
{
    var_f8cb6799fe42c1a2 = getdvarint( @"hash_ae11980aa01e5e33", 2 );
    
    while ( true )
    {
        if ( isdefined( level.players ) )
        {
            var_7f0e6b04339fd3b9 = 0;
            
            foreach ( player in level.players )
            {
                if ( isplayer( player ) && isalive( player ) )
                {
                    squad = teams::function_72b89edf6b47c40a( player );
                    var_dde04c7fea2f4f91 = function_f9fbb630598afdc7( player.origin, squad.force_region_name );
                    
                    if ( var_dde04c7fea2f4f91 == level.region_difficulty_manager.default_region )
                    {
                        continue;
                    }
                    
                    new_difficulty = function_d2213de17e7b3faf( var_dde04c7fea2f4f91 );
                    
                    if ( player.assigned_difficulty == var_dde04c7fea2f4f91.difficulty && !player.oob )
                    {
                        player.var_27fd0d2a449557bf = player.origin;
                        player.var_755ed09478df002 = player getvelocity();
                        
                        if ( player.vehicle )
                        {
                            player.var_420a3b8802c6905e = player.vehicle vehicle_getvelocity();
                        }
                    }
                    
                    if ( player.region != var_dde04c7fea2f4f91.name || player.var_546e4eb5269dbafa != new_difficulty )
                    {
                        params = { #var_705eae6dbfaf5fad:player.var_546e4eb5269dbafa, #new_difficulty:new_difficulty, #new_region_index:var_dde04c7fea2f4f91.index, #var_b37ea39a3899f970:player.region, #var_dde04c7fea2f4f91:var_dde04c7fea2f4f91.name, #player:player };
                        player.region = var_dde04c7fea2f4f91.name;
                        player.var_546e4eb5269dbafa = new_difficulty;
                        player callback::callback( "player_region_difficulty_change", params );
                    }
                }
                
                var_7f0e6b04339fd3b9++;
                
                if ( var_7f0e6b04339fd3b9 >= var_f8cb6799fe42c1a2 )
                {
                    var_7f0e6b04339fd3b9 = 0;
                    waitframe();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0xf9b62138, Offset: 0x1625
// Size: 0x22
function function_d33b93a54f11258d( difficulty )
{
    return level.region_difficulty_manager.round_number_table[ difficulty ];
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x24adee58, Offset: 0x1650
// Size: 0xb6
function function_94a2b03802002237( round_number )
{
    var_ae3dd00ddfbbc105 = undefined;
    var_f7a74bb3f41e9150 = -1;
    
    foreach ( var_9053018338dfbc53, var_849563ffb285d4c4 in level.region_difficulty_manager.round_number_table )
    {
        if ( round_number >= var_849563ffb285d4c4 && var_849563ffb285d4c4 > var_f7a74bb3f41e9150 )
        {
            var_f7a74bb3f41e9150 = var_849563ffb285d4c4;
            var_ae3dd00ddfbbc105 = var_9053018338dfbc53;
        }
    }
    
    return var_ae3dd00ddfbbc105;
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x64bcc702, Offset: 0x170f
// Size: 0xda
function function_f26583cf3dcbd795( params )
{
    self notify( #"hash_12476ffe5761af59" );
    self endon( #"hash_12476ffe5761af59" );
    utility::flag_wait( "ob_infil_completed" );
    
    if ( isdefined( params.player ) )
    {
        if ( isdefined( params.new_difficulty ) )
        {
            if ( !isdefined( params.var_705eae6dbfaf5fad ) || params.new_difficulty != params.var_705eae6dbfaf5fad )
            {
                var_e7b67b42155f71ee = level.region_difficulty_manager.region_difficulty_to_int[ params.new_difficulty ];
                
                if ( isdefined( var_e7b67b42155f71ee ) )
                {
                    params.player setclientomnvar( "ui_region_difficulty", var_e7b67b42155f71ee );
                }
            }
            
            return;
        }
        
        params.player setclientomnvar( "ui_region_difficulty", 0 );
    }
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x8e41b8bb, Offset: 0x17f1
// Size: 0x1e8
function function_bd9847f267d142f6( params )
{
    self notify( #"hash_f0981e660fc12765" );
    self endon( #"hash_f0981e660fc12765" );
    utility::flag_wait( "ob_infil_completed" );
    
    if ( !isdefined( params.player ) )
    {
        return;
    }
    
    player = params.player;
    var_cf2c91a325e12400 = params.var_dde04c7fea2f4f91;
    newdifficulty = params.new_difficulty;
    olddifficulty = params.var_705eae6dbfaf5fad;
    
    if ( !isdefined( var_cf2c91a325e12400 ) || newdifficulty == olddifficulty || player.var_753b31fc1dd0e162 )
    {
        return;
    }
    
    if ( !isdefined( player.var_a34a6d19acf471b0 ) )
    {
        player.var_a34a6d19acf471b0 = [];
    }
    
    var_a8b93b22192fdd5c = isdefined( player.var_a34a6d19acf471b0[ newdifficulty ] ) && gettime() < player.var_a34a6d19acf471b0[ newdifficulty ];
    
    if ( !var_a8b93b22192fdd5c && isdefined( newdifficulty ) && newdifficulty != olddifficulty )
    {
        splashreference = undefined;
        splashlistoverride = "splash_list_sat_ob";
        
        switch ( newdifficulty )
        {
            case #"hash_7bb2cd766703d463":
                splashreference = "regiondifficulty_entering_easy";
                break;
            case #"hash_af83e47edfa8900a":
                splashreference = "regiondifficulty_entering_normal";
                break;
            case #"hash_5343b465e56ec9a4":
                splashreference = "regiondifficulty_entering_hard";
                break;
            case #"hash_651f76c0ad6741ec":
                splashreference = "regiondifficulty_entering_darkaether";
                break;
            case #"hash_c0250ffc2e87f2ff":
                splashreference = "regiondifficulty_entering_difficulty5";
                break;
        }
        
        if ( isdefined( splashreference ) )
        {
            player thread hud_message::showsplash( splashreference, undefined, undefined, undefined, 1, splashlistoverride );
        }
    }
    
    if ( olddifficulty )
    {
        player.var_a34a6d19acf471b0[ olddifficulty ] = gettime() + getdvarfloat( @"hash_f3bf98bfe679cdbc", 10000 );
    }
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x1125975d, Offset: 0x19e1
// Size: 0xef
function function_aec1065e06c4336e( params )
{
    self notify( #"hash_487e505de9f1e53b" );
    self endon( #"hash_487e505de9f1e53b" );
    utility::flag_wait( "ob_infil_completed" );
    
    if ( !( isdefined( params.player ) && isdefined( params.new_difficulty ) && isdefined( level.moods ) ) || params.new_difficulty == params.var_705eae6dbfaf5fad )
    {
        return;
    }
    
    var_e7b67b42155f71ee = level.region_difficulty_manager.region_difficulty_to_int[ params.new_difficulty ];
    
    if ( var_e7b67b42155f71ee >= 0 )
    {
        self.var_2a9e1239e68562fa = var_e7b67b42155f71ee - 1;
        utility::callsharedfunc( #"mood", #"hash_bbfd57d533279922", params.player, level.moods[ self.var_2a9e1239e68562fa ] );
    }
}

// Namespace region_difficulty_manager
// Params 1
// Checksum 0xdbcc8b2c, Offset: 0x1ad8
// Size: 0x407
function function_b1af95c2d8f522c7( params )
{
    self notify( #"hash_afc18e9a7f9a86a3" );
    self endon( #"hash_afc18e9a7f9a86a3" );
    utility::flag_wait( "ob_infil_completed" );
    
    if ( !( isdefined( params.player ) && isdefined( params.new_difficulty ) && isdefined( level.moods ) ) || params.new_difficulty == params.var_705eae6dbfaf5fad )
    {
        return;
    }
    
    if ( !isdefined( params.player.var_4acfe6ee978e5c0b ) )
    {
        params.player.var_4acfe6ee978e5c0b = [];
    }
    
    if ( isdefined( params.player.var_4acfe6ee978e5c0b[ params.new_difficulty ] ) && gettime() < params.player.var_4acfe6ee978e5c0b[ params.new_difficulty ] || params.player.var_33cc5b033ddc1c9d )
    {
        switch ( params.new_difficulty )
        {
            case #"hash_7bb2cd766703d463":
                params.player setscriptablepartstate( #"ob_mood", #"tier1" );
                break;
            case #"hash_af83e47edfa8900a":
                params.player setscriptablepartstate( #"ob_mood", #"tier2" );
                break;
            case #"hash_5343b465e56ec9a4":
                params.player setscriptablepartstate( #"ob_mood", #"tier3" );
                break;
            case #"hash_651f76c0ad6741ec":
                params.player setscriptablepartstate( #"ob_mood", #"tier4" );
                break;
            case #"hash_c0250ffc2e87f2ff":
                params.player setscriptablepartstate( #"ob_mood", #"tier5" );
                break;
        }
    }
    else
    {
        switch ( params.new_difficulty )
        {
            case #"hash_7bb2cd766703d463":
                params.player setscriptablepartstate( #"ob_mood", #"hash_6688c452abf28aa3" );
                thread function_4ae4b035a2ab4482( params.player, 1, 0.1, -5, "cradle_rumble_tier2" );
                break;
            case #"hash_af83e47edfa8900a":
                params.player setscriptablepartstate( #"ob_mood", #"hash_c9d8a41227e6b732" );
                thread function_4ae4b035a2ab4482( params.player, 1, 0.1, -5, "cradle_rumble_tier2" );
                break;
            case #"hash_5343b465e56ec9a4":
                params.player setscriptablepartstate( #"ob_mood", #"hash_ba64a23a416c205d" );
                thread function_4ae4b035a2ab4482( params.player, 3, 0.3, -10, "cradle_rumble_tier3" );
                break;
            case #"hash_651f76c0ad6741ec":
                params.player setscriptablepartstate( #"ob_mood", #"hash_1e666cb6ab46b0ec" );
                thread function_4ae4b035a2ab4482( params.player, 5, 0.5, -15, "cradle_rumble_tier4" );
                break;
            case #"hash_c0250ffc2e87f2ff":
                params.player setscriptablepartstate( #"ob_mood", #"hash_208305accac5c33f" );
                thread function_4ae4b035a2ab4482( params.player, 5, 0.5, -15, "cradle_rumble_tier5" );
                break;
        }
    }
    
    if ( params.var_705eae6dbfaf5fad )
    {
        params.player.var_4acfe6ee978e5c0b[ params.var_705eae6dbfaf5fad ] = gettime() + getdvarfloat( @"hash_1619466c0fcafb65", 10000 );
    }
}

// Namespace region_difficulty_manager
// Params 5, eflags: 0x4
// Checksum 0x28835416, Offset: 0x1ee7
// Size: 0x13a
function private function_4ae4b035a2ab4482( player, scramble_strength, earthquake_strength, fov_change, rumble )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player_utility::function_99d180c3f0ca93b8( player, "player_soundveil_shake_mp", 2 );
    player thread emp_debuff::play_emp_scramble( scramble_strength );
    player earthquakeforplayer( earthquake_strength, 1, player.origin, 512 );
    player playrumbleonpositionforclient( rumble, player.origin );
    
    if ( !isdefined( level.var_af3c7b9fcdd66244 ) )
    {
        level.var_af3c7b9fcdd66244 = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    if ( player ispcplayer() )
    {
        fov_value = clamp( level.var_af3c7b9fcdd66244 + fov_change, 30, 110 );
    }
    else
    {
        fov_value = clamp( level.var_af3c7b9fcdd66244 + fov_change, 30, 170 );
    }
    
    half_duration = 0.5;
    player modifybasefov( fov_value, half_duration );
    wait half_duration;
    player modifybasefov( level.var_af3c7b9fcdd66244, half_duration );
    wait half_duration;
    player_utility::function_c14762bb6e0b4edb( player );
    player thread emp_debuff::stop_emp_scramble( scramble_strength );
}

/#

    // Namespace region_difficulty_manager
    // Params 0, eflags: 0x4
    // Checksum 0x5057cdaa, Offset: 0x2029
    // Size: 0x68, Type: dev
    function private debug_print_player_region()
    {
        region = function_f9fbb630598afdc7( level.players[ 0 ].origin );
        println( "<dev string:x1b8>" + getxhashsourcename( region.name ) + "<dev string:x1de>" + level.players[ 0 ].origin + "<dev string:x1ec>" );
    }

    // Namespace region_difficulty_manager
    // Params 0, eflags: 0x4
    // Checksum 0xc31c7934, Offset: 0x2099
    // Size: 0x38, Type: dev
    function private function_9bc1c93013ebb474()
    {
        if ( getdvarint( @"trigger_draw", 0 ) )
        {
            setdvar( @"trigger_draw", 0 );
            return;
        }
        
        setdvar( @"trigger_draw", 2 );
    }

#/

// Namespace region_difficulty_manager
// Params 1
// Checksum 0x94d4445f, Offset: 0x20d9
// Size: 0x123
function function_18e30232f36a1951( params )
{
    region = function_f9fbb630598afdc7( level.players[ 0 ].origin );
    var_1117cd637c834b4a = int( params[ 0 ] );
    new_difficulty = level.region_difficulty_manager.difficulties[ var_1117cd637c834b4a ] ?? "difficulty_undefined";
    override_region_difficulty( region.name, new_difficulty );
    zombies = getaispeciesarray( "all", "zombie" );
    
    foreach ( zombie in zombies )
    {
        new_difficulty = get_region_difficulty( zombie.origin );
        zombie function_410b4f83b0a5b98( new_difficulty );
    }
    
    ob::function_da3837eda9123641();
}

// Namespace region_difficulty_manager
// Params 3
// Checksum 0xc508b843, Offset: 0x2204
// Size: 0xa1
function add_difficulty_region( difficultyint, name, volume )
{
    var_546e4eb5269dbafa = level.region_difficulty_manager.difficulties[ difficultyint ];
    level.region_difficulty_manager.regions[ name ] = { #volume:volume, #difficultyint:difficultyint, #difficulty:var_546e4eb5269dbafa, #name:name, #index:level.region_difficulty_manager.regions.size };
}

