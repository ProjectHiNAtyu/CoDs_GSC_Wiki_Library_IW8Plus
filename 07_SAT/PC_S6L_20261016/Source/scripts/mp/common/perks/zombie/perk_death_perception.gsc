// scripts\mp\common\perks\zombie\perk_death_perception.gsc  (hash_5b2f43a9aeb5dc54.gscc) (size: 5909 Bytes / 0x1715 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2eafe271 (783278705)
// size ...... 5909 (0x1715)
// includes .. 7   (offset: 0x15e5)
// strings ... 16  (offset: 0x161d)
// dev strs .. 0   (offset: 0x1715)
// exports ... 13  (offset: 0xebd)
// cseg ...... 0x1a8 + 0xd15 (0xebd)
// imports ... 41  (offset: 0x10c5)
// animtree1 . 0   (offset: 0x1715)
// animtree2 . 0   (offset: 0x1715)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\currency;

#namespace perk_death_perception;

// Namespace perk_death_perception
// Params 0, eflags: 0x5
// Checksum 0xc267aeeb, Offset: 0x1c6
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_death_perception", undefined, &__init__, undefined );
}

// Namespace perk_death_perception
// Params 0, eflags: 0x1
// Checksum 0x45c6e2de, Offset: 0x1e3
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_925213f093801fc5 );
}

// Namespace perk_death_perception
// Params 0
// Checksum 0x4172bd5c, Offset: 0x203
// Size: 0xa
function __init__()
{
    level thread perk_death_perception_init();
}

// Namespace perk_death_perception
// Params 1
// Checksum 0x89dfed58, Offset: 0x215
// Size: 0x5e
function function_925213f093801fc5( params )
{
    bundle = level.perkbundles[ "specialty_death_perception" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_death_perception", &function_f6be7c5d8913bdb1, &function_66f94ad916791fe3 );
    }
}

// Namespace perk_death_perception
// Params 0
// Checksum 0x66f393ef, Offset: 0x27b
// Size: 0xb0
function perk_death_perception_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_death_perception" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_deadshot" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_deadshot" );
    var_7c0c0569bf2695fb = var_fcb7626c79b3c98f ?? 2000;
    level thread zombie_perks::enable_perk_for_level( "specialty_death_perception", str_currency, var_7c0c0569bf2695fb, &function_f6be7c5d8913bdb1, &function_66f94ad916791fe3, 1, 1 );
    level utility::flag_set( "specialty_death_perception" + "init_complete" );
}

// Namespace perk_death_perception
// Params 0
// Checksum 0xadaa3f6e, Offset: 0x333
// Size: 0xae
function function_f6be7c5d8913bdb1()
{
    self notify( #"end_death_perception" );
    
    if ( utility::issharedfuncdefined( #"hash_ff8677d0e6b8c85", #"death_perception_check" ) )
    {
        self [[ utility::getsharedfunc( #"hash_ff8677d0e6b8c85", #"death_perception_check" ) ]]();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deathperception_birds_eye_view" ) )
    {
        self.radarmode = "fast_radar";
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deathperception_hidden_gems" ) )
    {
        perk::giveperk( "specialty_death_perception_augment" );
    }
    
    thread function_bfcd6cf303c762a1();
}

// Namespace perk_death_perception
// Params 0
// Checksum 0x576bd422, Offset: 0x3e9
// Size: 0x409
function function_bfcd6cf303c762a1()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_death_perception" );
    var_7053bf4ffd16c29 = [];
    bundle = level.perkbundles[ "specialty_death_perception" ];
    radius = bundle.var_c416715b16caa3b7 ?? 600;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deathperception_further_insight" ) )
    {
        bonusradius = level.zombie_augments[ #"deathperception_further_insight" ].var_56eb99c274834acd ?? 200;
        radius += bonusradius;
    }
    
    self.deathperceptionradius = radius;
    self.var_60c164c3064d05b4 = var_7053bf4ffd16c29;
    var_7331523567b1cfe1 = 0;
    
    while ( true )
    {
        ownedrcxd = self function_5e625c7b14d50b01();
        var_d226408b94784d5d = isdefined( ownedrcxd ) ? ownedrcxd.origin : self.origin;
        in_range_ais = getaiarrayinradius( var_d226408b94784d5d, radius );
        
        foreach ( ai in var_7053bf4ffd16c29 )
        {
            if ( !isdefined( ai ) || arraycontains( in_range_ais, ai ) )
            {
                if ( !self.var_3d090afcb6aae884 )
                {
                    continue;
                }
            }
            
            ai hudoutlinedisableforclient( self );
            var_7053bf4ffd16c29 = arrayremove( var_7053bf4ffd16c29, ai );
            self.var_60c164c3064d05b4 = var_7053bf4ffd16c29;
            
            if ( isdefined( ai ) && self issplitscreenplayer() )
            {
                function_a41238e85ab4cfba( ai );
            }
        }
        
        var_7053bf4ffd16c29 = function_5713d46873b29625( var_7053bf4ffd16c29 );
        self.var_60c164c3064d05b4 = var_7053bf4ffd16c29;
        
        if ( self.visibilitymode.enablevalue )
        {
            if ( !var_7331523567b1cfe1 )
            {
                self.var_2edff02632a566d3 = 1;
                var_7331523567b1cfe1 = 1;
            }
        }
        else
        {
            if ( self getcamerathirdperson() )
            {
                player_view = self getcamerathirdpersonorigin();
            }
            else
            {
                player_view = self getvieworigin();
            }
            
            foreach ( ai in in_range_ais )
            {
                if ( ai.team == self.team || ai.team == "neutral" || ai.aicategory == "boss" && !ai.var_25f933db0db285ad || self.var_3d090afcb6aae884 )
                {
                    ai hudoutlinedisableforclient( self );
                    
                    if ( arraycontains( var_7053bf4ffd16c29, ai ) )
                    {
                        var_7053bf4ffd16c29 = arrayremove( var_7053bf4ffd16c29, ai );
                        self.var_60c164c3064d05b4 = var_7053bf4ffd16c29;
                    }
                    
                    continue;
                }
                
                if ( ai utility::ent_flag( "spawn_animating" ) || self getclientomnvar( "ui_hide_hud" ) == 1 )
                {
                    ai hudoutlinedisableforclient( self );
                    
                    if ( arraycontains( var_7053bf4ffd16c29, ai ) )
                    {
                        var_7053bf4ffd16c29 = arrayremove( var_7053bf4ffd16c29, ai );
                        self.var_60c164c3064d05b4 = var_7053bf4ffd16c29;
                    }
                    
                    continue;
                }
                
                if ( isdefined( ai ) && !ai.b_ignore_death_perception && !self.var_3d090afcb6aae884 )
                {
                    var_49974990b105362e = "death_perception";
                    
                    if ( outline::outlineoccluded( player_view, ai getcentroid() ) )
                    {
                        var_49974990b105362e += "_smoke";
                    }
                    
                    ai hudoutlineenableforclients( [ self ], var_49974990b105362e );
                    ai.dp_outline_name = var_49974990b105362e;
                    
                    if ( !arraycontains( var_7053bf4ffd16c29, ai ) )
                    {
                        var_7053bf4ffd16c29[ var_7053bf4ffd16c29.size ] = ai;
                        self.var_60c164c3064d05b4 = var_7053bf4ffd16c29;
                    }
                }
            }
            
            var_7331523567b1cfe1 = 0;
        }
        
        waitframe();
    }
}

// Namespace perk_death_perception
// Params 1, eflags: 0x4
// Checksum 0xd344468d, Offset: 0x7fa
// Size: 0xdb
function private function_a41238e85ab4cfba( ai )
{
    foreach ( partner in level.players )
    {
        if ( partner == self || !partner issplitscreenplayer() )
        {
            continue;
        }
        
        if ( !isdefined( partner.var_60c164c3064d05b4 ) || !arraycontains( partner.var_60c164c3064d05b4, ai ) )
        {
            continue;
        }
        
        ai hudoutlineenableforclients( [ partner ], ai.dp_outline_name ?? "death_perception" );
    }
}

// Namespace perk_death_perception
// Params 1, eflags: 0x4
// Checksum 0x11aef85f, Offset: 0x8dd
// Size: 0xcd
function private function_fa6d884f582ae6b8( item )
{
    foreach ( partner in level.players )
    {
        if ( partner == self || !partner issplitscreenplayer() )
        {
            continue;
        }
        
        if ( !isdefined( partner.var_9033c53a0f1aa23f ) || !arraycontains( partner.var_9033c53a0f1aa23f, item ) )
        {
            continue;
        }
        
        item hudoutlineenableforclients( [ partner ], "outline_nodepth_white" );
    }
}

// Namespace perk_death_perception
// Params 0
// Checksum 0x72770b35, Offset: 0x9b2
// Size: 0x277
function function_2490f0bbb35d0116()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_death_perception" );
    var_ecfe00bc6e98152e = [];
    bundle = level.perkbundles[ "specialty_death_perception" ];
    radius = bundle.var_c416715b16caa3b7 ?? 600;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deathperception_further_insight" ) )
    {
        bonusradius = level.zombie_augments[ #"deathperception_further_insight" ].var_56eb99c274834acd ?? 200;
        radius += bonusradius;
    }
    
    while ( true )
    {
        ownedrcxd = self function_5e625c7b14d50b01();
        
        if ( isdefined( ownedrcxd ) )
        {
            in_range_items = getentarrayinradius( undefined, undefined, ownedrcxd.origin, radius );
        }
        else
        {
            in_range_items = getentarrayinradius( undefined, undefined, self.origin, radius );
        }
        
        foreach ( item in var_ecfe00bc6e98152e )
        {
            if ( !item get_is_valid_item() )
            {
                continue;
            }
            
            if ( arraycontains( in_range_items, item ) )
            {
                continue;
            }
            
            item hudoutlinedisableforclient( self );
            var_ecfe00bc6e98152e = arrayremove( var_ecfe00bc6e98152e, item );
            self.var_9033c53a0f1aa23f = var_ecfe00bc6e98152e;
            
            if ( isdefined( item ) && self issplitscreenplayer() )
            {
                function_fa6d884f582ae6b8( item );
            }
        }
        
        var_ecfe00bc6e98152e = function_5713d46873b29625( var_ecfe00bc6e98152e );
        self.var_9033c53a0f1aa23f = var_ecfe00bc6e98152e;
        
        foreach ( item in in_range_items )
        {
            if ( !item get_is_valid_item() )
            {
                continue;
            }
            
            if ( arraycontains( var_ecfe00bc6e98152e, item ) )
            {
                continue;
            }
            
            item hudoutlineenableforclients( [ self ], "outline_nodepth_white" );
            var_ecfe00bc6e98152e[ var_ecfe00bc6e98152e.size ] = item;
            self.var_9033c53a0f1aa23f = var_ecfe00bc6e98152e;
        }
        
        waitframe();
    }
}

// Namespace perk_death_perception
// Params 0
// Checksum 0xfd900411, Offset: 0xc31
// Size: 0x13, Type: bool
function get_is_valid_item()
{
    return isdefined( self ) && utility::ent_flag( "perk_death_perception_fx" );
}

// Namespace perk_death_perception
// Params 4
// Checksum 0xb0f71d3d, Offset: 0xc4d
// Size: 0x270
function function_66f94ad916791fe3( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    self notify( #"end_death_perception" );
    self.deathperceptionradius = undefined;
    self.var_60c164c3064d05b4 = undefined;
    bundle = level.perkbundles[ "specialty_death_perception" ];
    radius = bundle.var_c416715b16caa3b7 ?? 600;
    
    if ( isdefined( self.perks[ "specialty_death_perception_augment" ] ) )
    {
        perk::removeperk( "specialty_death_perception_augment" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deathperception_further_insight" ) )
    {
        bonusradius = level.zombie_augments[ #"deathperception_further_insight" ].var_56eb99c274834acd ?? 200;
        radius += bonusradius;
    }
    
    radius *= 1.5;
    in_range_ais = getaiarrayinradius( self.origin, radius );
    self.radarmode = "normal_radar";
    
    if ( !self.visibilitymode.enablevalue )
    {
        foreach ( ai in in_range_ais )
        {
            if ( !isdefined( ai ) )
            {
                continue;
            }
            
            ai hudoutlinedisableforclient( self );
        }
        
        in_range_items = getentarrayinradius( undefined, undefined, self.origin, radius );
        
        foreach ( item in in_range_items )
        {
            if ( !item get_is_valid_item() )
            {
                continue;
            }
            
            item hudoutlinedisableforclient( self );
        }
        
        return;
    }
    
    if ( self.visibilitymode.enablevalue )
    {
        self.var_2edff02632a566d3 = 1;
    }
}

