// scripts\mp\bots\bots_gametype_gun.gsc  (hash_5de9067b193f86a7.gscc) (size: 1341 Bytes / 0x53d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6976fa0 (3600248736)
// size ...... 1341 (0x53d)
// includes .. 4   (offset: 0x4ad)
// strings ... 9   (offset: 0x4cd)
// dev strs .. 0   (offset: 0x53d)
// exports ... 5   (offset: 0x2a5)
// cseg ...... 0xec + 0x1b9 (0x2a5)
// imports ... 11  (offset: 0x36d)
// animtree1 . 0   (offset: 0x53d)
// animtree2 . 0   (offset: 0x53d)
#using scripts\common\weapon;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\common\utility\weapon;

#namespace bots_gametype_gun;

// Namespace bots_gametype_gun
// Params 0
// Checksum 0xf76598e6, Offset: 0x10a
// Size: 0x2c
function main()
{
    setup_callbacks();
    setup_bot_gun();
    autopilot::initialize( undefined, undefined, [ "bot_gun_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_gun
// Params 0
// Checksum 0x91a5c3, Offset: 0x13e
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_gun_think;
}

// Namespace bots_gametype_gun
// Params 0
// Checksum 0x6c8cfca, Offset: 0x15d
// Size: 0xd
function setup_bot_gun()
{
    level.bots_gametype_handles_class_choice = 1;
}

// Namespace bots_gametype_gun
// Params 0
// Checksum 0x8936ff2d, Offset: 0x172
// Size: 0x133
function bot_gun_think()
{
    self notify( #"bot_gun_think" );
    self endon( #"bot_gun_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    throwknifechance = self botgetdifficultysetting( "throwKnifeChance" );
    
    if ( throwknifechance < 0.25 )
    {
        self botsetdifficultysetting( "throwKnifeChance", 0.25 );
    }
    
    self botsetdifficultysetting( "allowGrenades", 1 );
    last_weapon_name = "";
    wait 0.1;
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon.basename != "none" && !weapon::iskillstreakweapon( current_weapon ) && current_weapon.basename != last_weapon_name && !weapon::function_e93a21a657377115( current_weapon ) )
        {
            last_weapon_name = current_weapon.basename;
            
            if ( self botgetdifficultysetting( "advancedPersonality" ) && self botgetdifficultysetting( "strategyLevel" ) > 0 )
            {
                bots_personality::function_cc26fb6ecde979dc( 1 );
            }
        }
        
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

