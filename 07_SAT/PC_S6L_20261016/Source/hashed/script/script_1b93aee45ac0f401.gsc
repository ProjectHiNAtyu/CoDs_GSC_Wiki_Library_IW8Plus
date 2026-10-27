// script_1b93aee45ac0f401  (hash_1b93aee45ac0f401.gscc) (size: 3087 Bytes / 0xc0f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa710be1 (2859535329)
// size ...... 3087 (0xc0f)
// includes .. 6   (offset: 0xbb7)
// strings ... 2   (offset: 0xbe7)
// dev strs .. 1   (offset: 0xc03)
// exports ... 12  (offset: 0x5ef)
// cseg ...... 0x89 + 0x566 (0x5ef)
// imports ... 34  (offset: 0x7cf)
// animtree1 . 0   (offset: 0xc0f)
// animtree2 . 0   (offset: 0xc0f)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\laststand;
#using scripts\mp\ob\ob_shock_util;

#namespace skill_bubble_shield_upgrade;

// Namespace skill_bubble_shield_upgrade
// Params 0, eflags: 0x1
// Checksum 0xa075ad2d, Offset: 0xa7
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"bubble_shield_upgrade", &init );
}

// Namespace skill_bubble_shield_upgrade
// Params 0
// Checksum 0x2af5843, Offset: 0xc6
// Size: 0x4a
function init()
{
    utility::registersharedfunc( #"bubble_shield_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"bubble_shield_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    laststand::register_revive_reason( "last_stand_revived_bubble_shield" );
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0x6fb74e4b, Offset: 0x118
// Size: 0x87, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_2373875a7731acb7 = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_48d985c6c720af4b && skill_bundle.var_a4a61889962d4003 )
    {
        assert( !callback::exists( #"super_bubble_shield_damaged", &function_4f4873403a781676 ) );
        callback::add( #"super_bubble_shield_damaged", &function_4f4873403a781676 );
    }
    
    if ( skill_bundle.var_cb46f0f58343bb8d )
    {
        thread function_6a70b1970dd7c01c();
    }
    
    return true;
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0x4981746b, Offset: 0x1a8
// Size: 0x70
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_48d985c6c720af4b && skill_bundle.var_a4a61889962d4003 )
    {
        assert( callback::exists( #"super_bubble_shield_damaged", &function_4f4873403a781676 ) );
        callback::remove( #"super_bubble_shield_damaged", &function_4f4873403a781676 );
    }
    
    self.var_2373875a7731acb7 = undefined;
    self notify( #"hash_fff514b83f9aa71b" );
}

// Namespace skill_bubble_shield_upgrade
// Params 0, eflags: 0x4
// Checksum 0x1a4336c0, Offset: 0x220
// Size: 0x73
function private function_6a70b1970dd7c01c()
{
    self endon( #"death_or_disconnect", #"hash_fff514b83f9aa71b" );
    
    while ( true )
    {
        self waittill( #"bubble_shield_spawned", bubble_shield );
        bubble_shield.revived_players = [];
        bubble_shield callback::add( #"player_enter_bubble_shield", &player_enter_bubble_shield );
        bubble_shield callback::add( #"player_exit_bubble_shield", &player_exit_bubble_shield );
    }
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0x38687c29, Offset: 0x29b
// Size: 0xb7
function private player_enter_bubble_shield( params )
{
    player = params.player;
    bubble_shield_owner = self.connectedplayer;
    
    if ( player.sessionsquadid == bubble_shield_owner.sessionsquadid && !arraycontains( self.revived_players, player ) )
    {
        if ( player.inlaststand )
        {
            player function_8b33d27919598d67( self );
            return;
        }
        
        assert( !player callback::exists( #"player_laststand", &function_d304b6beab311c66, self ) );
        player callback::add( #"player_laststand", &function_d304b6beab311c66, self );
    }
}

// Namespace skill_bubble_shield_upgrade
// Params 2, eflags: 0x4
// Checksum 0x1a116cbb, Offset: 0x35a
// Size: 0x35
function private function_d304b6beab311c66( params, bubble_shield )
{
    function_8b33d27919598d67( bubble_shield );
    callback::remove( #"player_laststand", &function_d304b6beab311c66, bubble_shield );
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0x9f57d10f, Offset: 0x397
// Size: 0x3d
function private function_8b33d27919598d67( bubble_shield )
{
    laststand::function_75e6bc3d39e1f2bb( bubble_shield.connectedplayer, "last_stand_revived_bubble_shield" );
    bubble_shield.revived_players[ bubble_shield.revived_players.size ] = self;
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf4cdb5ad, Offset: 0x3dc
// Size: 0x50
function private player_exit_bubble_shield( params )
{
    if ( params.player callback::exists( #"player_laststand", &function_d304b6beab311c66, self ) )
    {
        params.player callback::remove( #"player_laststand", &function_d304b6beab311c66, self );
    }
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0xa7def63e, Offset: 0x434
// Size: 0x183
function private function_4f4873403a781676( params )
{
    bundle = self.var_2373875a7731acb7.bundle;
    assert( bundle.var_48d985c6c720af4b && bundle.var_a4a61889962d4003 );
    assert( params.attacker && params.smeansofdeath );
    
    if ( params.smeansofdeath != "MOD_MELEE" )
    {
        return;
    }
    
    if ( !isagent( params.attacker ) )
    {
        return;
    }
    
    if ( params.attacker.var_5db68ac344008297 )
    {
        return;
    }
    
    if ( bundle.var_feb4d70d7c3ca8a1 )
    {
        tier_number = params.attacker ai_utility::get_power_tier();
        assert( tier_number, "<dev string:x24>" );
        
        if ( tier_number > bundle.var_feb4d70d7c3ca8a1 )
        {
            return;
        }
    }
    
    if ( bundle.var_48d985c6c720af4b > randomfloat( 1 ) )
    {
        params.attacker ob_shock_util::stun_target( self, bundle.var_a4a61889962d4003 );
        params.attacker thread ob_shock_util::shock_fx( self, bundle.var_a4a61889962d4003 );
        
        if ( bundle.var_12feeb035189719e )
        {
            params.attacker thread function_cb3179e3cb35275f( bundle.var_a4a61889962d4003 + bundle.var_12feeb035189719e );
        }
    }
}

// Namespace skill_bubble_shield_upgrade
// Params 1, eflags: 0x4
// Checksum 0x4c1fba69, Offset: 0x5bf
// Size: 0x30
function private function_cb3179e3cb35275f( time )
{
    self endon( #"death_or_disconnect" );
    self.var_5db68ac344008297 = 1;
    wait time;
    self.var_5db68ac344008297 = undefined;
}

