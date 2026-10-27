// scripts\mp\bots\bots_gametype_ko.gsc  (hash_00cc652497df12a7.gscc) (size: 1835 Bytes / 0x72b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64c84aba (1690847930)
// size ...... 1835 (0x72b)
// includes .. 4   (offset: 0x68b)
// strings ... 10  (offset: 0x6ab)
// dev strs .. 0   (offset: 0x72b)
// exports ... 6   (offset: 0x3a3)
// cseg ...... 0x11d + 0x286 (0x3a3)
// imports ... 17  (offset: 0x493)
// animtree1 . 0   (offset: 0x72b)
// animtree2 . 0   (offset: 0x72b)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\mp\autopilot;
#using scripts\mp\gameobjects;

#namespace bots_gametype_ko;

// Namespace bots_gametype_ko
// Params 0
// Checksum 0x10cec3a5, Offset: 0x13b
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_ko();
}

// Namespace bots_gametype_ko
// Params 0
// Checksum 0x4fa1adf9, Offset: 0x153
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_ko_think;
    autopilot::initialize( undefined, undefined, [ "bot_ko_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_ko
// Params 0
// Checksum 0x3880945b, Offset: 0x18e
// Size: 0x2
function setup_bot_ko()
{
    
}

// Namespace bots_gametype_ko
// Params 0
// Checksum 0xab58f92c, Offset: 0x198
// Size: 0x1f1
function bot_ko_think()
{
    self notify( #"bot_ko_think" );
    self endon( #"bot_ko_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.next_flag_hide_time = 0;
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        flagownerteam = level.knockoutflag gameobjects::getownerteam();
        
        if ( flagownerteam == "none" || flagownerteam == "neutral" )
        {
            clear_defend();
            self botsetscriptgoal( level.knockoutflag.curorigin, 16, "critical" );
        }
        else if ( flagownerteam == self.team )
        {
            if ( level.knockoutflag.currentcarrier == self )
            {
                if ( gettime() > self.next_flag_hide_time )
                {
                    clear_defend();
                    tacpoints = function_a034a927128ada11( self.origin, 900, 0, 300 );
                    hide_tacpoint = bots_util::function_ec1247a9311f67a4( "bot_ko_think -> tacpoint pick hide anywhere", tacpoints, tacpoints.size * 0.15, "hide_anywhere" );
                    
                    if ( isdefined( hide_tacpoint ) )
                    {
                        success = self botsetscriptgoal( hide_tacpoint, 0, "critical" );
                        
                        if ( success )
                        {
                            self.next_flag_hide_time = gettime() + 15000;
                        }
                    }
                }
            }
            else if ( !namespace_14346d439f44a158::function_737443eaedb33690() )
            {
                clear_defend();
                self botclearscriptgoal();
                namespace_14346d439f44a158::guard_player( level.knockoutflag.currentcarrier, 500 );
            }
        }
        else
        {
            clear_defend();
            self botsetscriptgoal( level.knockoutflag.currentcarrier.origin, 16, "critical" );
        }
        
        wait 0.05;
    }
}

// Namespace bots_gametype_ko
// Params 0
// Checksum 0x2298ee6f, Offset: 0x391
// Size: 0x12
function clear_defend()
{
    if ( namespace_14346d439f44a158::is_defending() )
    {
        namespace_14346d439f44a158::function_87e8deae08ce1a0();
    }
}

