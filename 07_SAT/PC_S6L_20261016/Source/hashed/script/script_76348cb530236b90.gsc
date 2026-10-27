// script_76348cb530236b90  (hash_76348cb530236b90.gscc) (size: 10728 Bytes / 0x29e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f8bda2e (529259054)
// size ...... 10728 (0x29e8)
// includes .. 5   (offset: 0x21fc)
// strings ... 72  (offset: 0x2224)
// dev strs .. 12  (offset: 0x2958)
// exports ... 14  (offset: 0x1b9c)
// cseg ...... 0x59a + 0x1602 (0x1b9c)
// imports ... 36  (offset: 0x1dcc)
// animtree1 . 0   (offset: 0x29e8)
// animtree2 . 0   (offset: 0x29e8)
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\inventory_utility;

#namespace namespace_fc2681562de9e9ac;

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0x41efcbc5, Offset: 0x5b8
// Size: 0x24
function function_4c5431bad95a680b()
{
    level.var_953912b81fc6bf6c = weapon::buildweapon( "rex_ar_mike4_mp" );
    function_47d3a0b6f193042d();
    thread function_dbc714f6d000324d();
}

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0x17848269, Offset: 0x5e4
// Size: 0x63
function function_47d3a0b6f193042d()
{
    /#
        devgui::add_devgui_command( "<dev string:x24>", "<dev string:x4b>", 0 );
        devgui::add_devgui_command( "<dev string:xae>", "<dev string:xd8>", 1 );
        devgui::add_devgui_command( "<dev string:x13b>", "<dev string:x161>", 2 );
        devgui::add_devgui_command( "<dev string:x1c4>", "<dev string:x1ed>", 3 );
        devgui::add_devgui_command( "<dev string:x250>", "<dev string:x276>", 4 );
    #/
}

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0x7001ad10, Offset: 0x64f
// Size: 0x31
function function_dbc714f6d000324d()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_cf4b35b993af73ed", 0 ) != 0 )
        {
            function_456f1730e211cd81();
        }
        
        waitframe();
    }
}

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0xea1064b3, Offset: 0x688
// Size: 0x76
function function_456f1730e211cd81()
{
    weapon = function_7a0540ae90c14b6f();
    archetype = function_d5870d7bd6f2c7da();
    
    if ( weapon::getweaponname( weapon ) == "rex_ar_mike4_mp" )
    {
        attachments = function_ddb9a355227816de( weapon, archetype );
    }
    
    function_37618f81e6a7524b( attachments );
    setdvar( @"hash_cf4b35b993af73ed", 0 );
    
    /#
        iprintlnbold( "<dev string:x2d9>" + archetype + "<dev string:x2e7>" );
    #/
}

// Namespace namespace_fc2681562de9e9ac
// Params 2
// Checksum 0x2a7e2396, Offset: 0x706
// Size: 0xc61
function function_5bcbf561c88d8341( archetype, apex )
{
    switch ( archetype )
    {
        case #"hash_a140edb8b517af03":
            if ( apex )
            {
                receiver = undefined;
                frontpiece = undefined;
                backpiece = [ "rex_stock_lgt_mike4", "rex_stockno_mike4", "rex_stock_tac_mike4" ];
                magazine = undefined;
                reargrip = [ "rex_pgrip_ske_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex04", "rex_holo01" ];
                muzzle = [ "rex_sil_lgt_a", "rex_breach_a", "rex_flash_a" ];
                underbarrel = undefined;
                extra = [ "rex_laserhip_lrg03", "rex_laserhip_lrg04", "rex_lasercant_lrg05" ];
                modifier = [ "rex_ammo_5x28_hp", "rex_ammo_5x28_fr", "rex_ammo_5x28_op" ];
                trigger = [ "rex_grip_vert", "rex_grip_vert_short" ];
            }
            else
            {
                receiver = undefined;
                frontpiece = [ "rex_bar_lgtsht_mike4", "rex_bar_lgt_mike4" ];
                backpiece = [ "rex_stock_lgt_mike4", "rex_stockno_mike4", "rex_stock_tac_mike4" ];
                magazine = [ "rex_xmag_mike4" ];
                reargrip = [ "rex_pgrip_ske_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex03", "rex_reflex04", "rex_holo01" ];
                muzzle = [ "rex_sil_lgt_a", "rex_breach_a", "rex_flash_a" ];
                underbarrel = undefined;
                extra = [ "rex_laserhip_lrg03", "rex_laserhip_lrg04", "rex_lasercant_lrg05" ];
                modifier = [ "rex_ammo_556n_fr", "rex_ammo_556n_hp", "rex_ammo_556n_hv", "rex_ammo_556n_op" ];
                trigger = [ "rex_grip_vert", "rex_grip_vert_short" ];
            }
            
            break;
        case #"hash_b9f74b8e3b05037d":
            if ( apex )
            {
                receiver = undefined;
                frontpiece = undefined;
                backpiece = [ "rex_stock_lgt_mike4", "rex_stock_ass_mike4", "rex_stock_tac_mike4", "rex_stock_hvy_mike4" ];
                magazine = undefined;
                reargrip = [ "rex_pgrip_ske_mike4", "rex_pgrip_ass_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex04", "rex_holo01", "rex_holo02", "rex_holo03" ];
                muzzle = [ "rex_comp_vert_a", "rex_comp_hoz_a", "rex_comp_bal_a", "rex_sil_lgt_a", "rex_sil_tac_a" ];
                underbarrel = undefined;
                extra = [ "rex_laserads_lrg01", "rex_laserads_lrg02", "rex_lasercant_lrg05" ];
                modifier = [ "rex_ammo_5x28_hp", "rex_ammo_5x28_fr", "rex_ammo_5x28_op" ];
                trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_vert", "rex_grip_vert_short", "rex_grip_bipod01" ];
            }
            else
            {
                receiver = undefined;
                frontpiece = [ "rex_bar_hvysht_mike4", "rex_bar_lgt_mike4", "rex_bar_hvy_mike4" ];
                backpiece = [ "rex_stock_lgt_mike4", "rex_stock_ass_mike4", "rex_stock_tac_mike4", "rex_stock_hvy_mike4" ];
                magazine = [ "rex_xmag_mike4" ];
                reargrip = [ "rex_pgrip_ske_mike4", "rex_pgrip_ass_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex03", "rex_reflex04", "rex_holo01", "rex_holo02", "rex_holo03", "rex_holo04", "rex_fourx01", "rex_fourx02", "rex_fourx_hybcant01", "rex_fourx_hybflip01" ];
                muzzle = [ "rex_comp_vert_a", "rex_comp_hoz_a", "rex_comp_bal_a", "rex_sil_lgt_a", "rex_sil_tac_a" ];
                underbarrel = undefined;
                extra = [ "rex_laserads_lrg01", "rex_laserads_lrg02", "rex_laserhip_lrg03", "rex_lasercant_lrg05" ];
                modifier = [ "rex_ammo_556n_fr", "rex_ammo_556n_hp", "rex_ammo_556n_hv", "rex_ammo_556n_op" ];
                trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_vert", "rex_grip_vert_short", "rex_grip_bipod01", "rex_ub_gl_std" ];
            }
            
            break;
        case #"hash_7da1ec39ef45a5b3":
            receiver = undefined;
            frontpiece = [ "rex_bar_hvy_mike4", "rex_bar_lng_mike4" ];
            backpiece = [ "rex_stock_ass_mike4", "rex_stock_hvy_mike4" ];
            magazine = undefined;
            reargrip = [ "rex_pgrip_ass_mike4", "rex_pgrip_snp_mike4" ];
            scope = undefined;
            muzzle = [ "rex_comp_vert_a", "rex_comp_hoz_a", "rex_sil_hvy_a", "rex_sil_tac_a" ];
            underbarrel = undefined;
            extra = [ "rex_laserads_lrg01", "rex_laserads_lrg02" ];
            modifier = [ "rex_ammo_556n_ap", "rex_ammo_556n_hp", "rex_ammo_556n_op" ];
            trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_bipod01", "rex_bipod01" ];
            break;
        case #"hash_3d5f49f17b95335c":
            if ( apex )
            {
                receiver = undefined;
                frontpiece = undefined;
                backpiece = [ "rex_stock_lgt_mike4", "rex_stock_ass_mike4", "rex_stock_tac_mike4", "rex_stockno_mike4" ];
                magazine = undefined;
                reargrip = [ "rex_pgrip_ske_mike4", "rex_pgrip_ass_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex04", "rex_holo01", "rex_holo02", "rex_holo03" ];
                muzzle = undefined;
                underbarrel = undefined;
                extra = undefined;
                modifier = undefined;
                trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_vert", "rex_grip_vert_short" ];
            }
            else
            {
                receiver = undefined;
                frontpiece = [ "rex_bar_hvysht_mike4", "rex_bar_lgt_mike4", "rex_bar_hvy_mike4", "rex_bar_lng_mike4" ];
                backpiece = [ "rex_stock_lgt_mike4", "rex_stock_ass_mike4", "rex_stock_tac_mike4", "rex_stock_hvy_mike4" ];
                magazine = undefined;
                reargrip = [ "rex_pgrip_ske_mike4", "rex_pgrip_ass_mike4", "rex_pgrip_snp_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex03", "rex_reflex04", "rex_holo01", "rex_holo02", "rex_holo03", "rex_holo04", "rex_fourx01", "rex_fourx02", "rex_fourx_hybcant01", "rex_fourx_hybflip01" ];
                muzzle = undefined;
                underbarrel = undefined;
                extra = undefined;
                modifier = undefined;
                trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_vert", "rex_grip_vert_short", "rex_grip_bipod01" ];
            }
            
            break;
        case #"hash_ee5a421e18a58c0f":
            if ( apex )
            {
                receiver = undefined;
                frontpiece = undefined;
                backpiece = [ "rex_stock_lgt_mike4", "rex_stockno_mike4", "rex_stock_ass_mike4", "rex_stock_tac_mike4", "rex_stock_hvy_mike4" ];
                magazine = undefined;
                reargrip = [ "rex_pgrip_ske_mike4", "rex_pgrip_ass_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex04", "rex_holo01", "rex_holo02", "rex_holo03" ];
                muzzle = [ "rex_comp_vert_a", "rex_comp_hoz_a", "rex_comp_bal_a", "rex_sil_lgt_a", "rex_sil_tac_a", "rex_breach_a", "rex_flash_a" ];
                underbarrel = undefined;
                extra = [ "rex_laserads_lrg01", "rex_laserads_lrg02", "rex_laserhip_lrg03", "rex_laserhip_lrg04", "rex_lasercant_lrg05" ];
                modifier = [ "rex_ammo_5x28_hp", "rex_ammo_5x28_fr", "rex_ammo_5x28_op", "rex_ammo_5x28_ap" ];
                trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_vert", "rex_grip_vert_short" ];
            }
            else
            {
                receiver = undefined;
                frontpiece = [ "rex_bar_hvysht_mike4", "rex_bar_lgtsht_mike4", "rex_bar_lgt_mike4", "rex_bar_hvy_mike4" ];
                backpiece = [ "rex_stock_lgt_mike4", "rex_stock_ass_mike4", "rex_stock_tac_mike4", "rex_stock_hvy_mike4" ];
                magazine = undefined;
                reargrip = [ "rex_pgrip_ske_mike4", "rex_pgrip_ass_mike4" ];
                scope = [ "rex_minireddot01", "rex_minireddot02", "rex_minireddot03", "rex_minireddot04", "rex_reflex01", "rex_reflex02", "rex_reflex03", "rex_reflex04", "rex_holo01", "rex_holo02", "rex_holo03", "rex_holo04", "rex_fourx01", "rex_fourx02", "rex_fourx_hybcant01", "rex_fourx_hybflip01" ];
                muzzle = [ "rex_comp_vert_a", "rex_comp_hoz_a", "rex_comp_bal_a", "rex_sil_lgt_a", "rex_sil_tac_a", "rex_breach_a", "rex_flash_a" ];
                underbarrel = undefined;
                extra = [ "rex_laserads_lrg01", "rex_laserads_lrg02", "rex_laserhip_lrg03", "rex_laserhip_lrg04", "rex_lasercant_lrg05" ];
                modifier = [ "rex_ammo_556n_fr", "rex_ammo_556n_hp", "rex_ammo_556n_hv", "rex_ammo_556n_op", "rex_ammo_556n_ap" ];
                trigger = [ "rex_grip_ang", "rex_grip_ang_short", "rex_grip_vert", "rex_grip_vert_short", "rex_grip_bipod01", "rex_ub_gl_std" ];
            }
            
            break;
    }
    
    attachmentarrays = [ receiver, frontpiece, backpiece, magazine, reargrip, scope, muzzle, underbarrel, extra, modifier, trigger ];
    return attachmentarrays;
}

// Namespace namespace_fc2681562de9e9ac
// Params 2
// Checksum 0x6a95f2ec, Offset: 0x1370
// Size: 0xf4
function function_2516351354870cf4( categoryarray, maxcategories )
{
    var_90521be3966c3e7b = [];
    
    for ( i = 0; i < maxcategories ; i++ )
    {
        category = utility::array_random( categoryarray );
        
        if ( var_90521be3966c3e7b.size > 0 )
        {
            samecategory = 0;
            
            foreach ( array in var_90521be3966c3e7b )
            {
                if ( array[ 0 ] == category[ 0 ] )
                {
                    samecategory = 1;
                    i--;
                    break;
                }
            }
            
            if ( samecategory == 0 )
            {
                var_90521be3966c3e7b[ var_90521be3966c3e7b.size ] = category;
            }
            
            continue;
        }
        
        var_90521be3966c3e7b[ var_90521be3966c3e7b.size ] = category;
    }
    
    return var_90521be3966c3e7b;
}

// Namespace namespace_fc2681562de9e9ac
// Params 1
// Checksum 0x27f9a4a, Offset: 0x146d
// Size: 0x22
function function_1b997f5d7a3bda28( attachmentarray )
{
    attachment = utility::array_random( attachmentarray );
    return attachment;
}

// Namespace namespace_fc2681562de9e9ac
// Params 2
// Checksum 0xd716f827, Offset: 0x1498
// Size: 0x234
function function_ddb9a355227816de( weapon, archetype )
{
    apex = utility::cointoss();
    
    if ( archetype == "stealth" )
    {
        maxcategories = 4;
    }
    else if ( archetype == "ammo" )
    {
        if ( apex )
        {
            maxcategories = 5;
        }
        else
        {
            maxcategories = 4;
        }
    }
    else if ( archetype == "long" )
    {
        if ( apex )
        {
            apex = 0;
        }
        
        maxcategories = 4;
    }
    else
    {
        maxcategories = 5;
    }
    
    attachmentarrays = function_5bcbf561c88d8341( archetype, apex );
    var_90521be3966c3e7b = function_2516351354870cf4( attachmentarrays, maxcategories );
    attachments = [];
    
    if ( apex )
    {
        attachments[ attachments.size ] = "rex_rec_mike4_pdw";
    }
    
    if ( archetype == "ammo" )
    {
        if ( !apex )
        {
            magazine = [ "rex_xmag_mike4", "rex_drum_mike4" ];
            var_90521be3966c3e7b[ var_90521be3966c3e7b.size ] = magazine;
        }
    }
    else if ( archetype == "long" )
    {
        scope = [ "rex_holo01", "rex_holo02", "rex_fourx01", "rex_fourx02", "rex_fourx_hybcant01", "rex_fourx_hybflip01", "rex_arscope01", "rex_arscope_vz01", "rex_arscope_rf01" ];
        var_90521be3966c3e7b[ var_90521be3966c3e7b.size ] = scope;
    }
    else if ( archetype == "stealth" )
    {
        muzzle = [ "rex_sil_hvy_a", "rex_sil_tac_a", "rex_sil_lgt_a" ];
        var_90521be3966c3e7b[ var_90521be3966c3e7b.size ] = muzzle;
    }
    
    foreach ( category in var_90521be3966c3e7b )
    {
        attachment = function_1b997f5d7a3bda28( category );
        attachments[ attachments.size ] = attachment;
    }
    
    verifiedattachments = function_29aa524cb12b07ce( weapon, attachments );
    return verifiedattachments;
}

// Namespace namespace_fc2681562de9e9ac
// Params 2
// Checksum 0x2afa0854, Offset: 0x16d5
// Size: 0x262
function function_29aa524cb12b07ce( weapon, attachments )
{
    slots = [];
    verifiedattachments = [];
    
    foreach ( attachment in attachments )
    {
        slot = getattachmentslot( weapon, attachment );
        slots[ slots.size ] = slot;
    }
    
    foreach ( attachment in attachments )
    {
        slotblocked = 0;
        attblocked = 0;
        slotsblocked = getattachmentslotsblocked( weapon, attachment );
        
        if ( slotsblocked.size > 0 )
        {
            foreach ( blockedslot in slotsblocked )
            {
                if ( arraycontains( slots, blockedslot ) )
                {
                    slotblocked = 1;
                    break;
                }
            }
        }
        
        if ( slotblocked == 0 )
        {
            attachmentsblocked = getattachmentsblocked( weapon, attachment );
            
            if ( attachmentsblocked.size > 0 )
            {
                foreach ( blockedattachment in attachmentsblocked )
                {
                    if ( arraycontains( attachments, blockedattachment ) )
                    {
                        attblocked = 1;
                        break;
                    }
                }
            }
        }
        
        if ( slotblocked == 0 && attblocked == 0 )
        {
            verifiedattachments[ verifiedattachments.size ] = attachment;
        }
    }
    
    return verifiedattachments;
}

// Namespace namespace_fc2681562de9e9ac
// Params 1
// Checksum 0x57b7cc65, Offset: 0x1940
// Size: 0xb1
function function_37618f81e6a7524b( attachments )
{
    player = level.players[ 0 ];
    weapontobuild = getdvarint( @"hash_995eeacf44b5f5c4", 0 );
    
    if ( weapontobuild == 0 )
    {
        builtweapon = weapon::buildweapon( "rex_ar_mike4_mp", attachments );
    }
    else
    {
        iprintlnbold( "Failed to build weapon" );
        return;
    }
    
    spawnpos = player function_7833342f583bc2fd();
    player inventory_utility::_giveweapon( builtweapon );
    waitframe();
    spawnedweapon = player dropitem( builtweapon );
    spawnedweapon.origin = spawnpos + ( 0, 0, 16 );
}

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0xab53ce4c, Offset: 0x19f9
// Size: 0xf8
function function_7833342f583bc2fd()
{
    playerdirection = anglestoforward( self getplayerangles() );
    playerlocation = self geteye();
    raydistance = playerlocation + playerdirection * 5000;
    var_2b3f6b130f89caf2 = trace::ray_trace( playerlocation, raydistance, self );
    aimpos = var_2b3f6b130f89caf2[ "position" ];
    waitframe();
    xoffset = randomintrange( 5, 25 );
    
    if ( utility::cointoss() )
    {
        xoffset *= -1;
    }
    
    yoffset = randomfloatrange( 5, 20 );
    
    if ( utility::percent_chance( 25 ) )
    {
        yoffset *= -1;
    }
    
    randpos = aimpos + ( xoffset, yoffset, 15 );
    tracestart = randpos;
    ground = randpos + ( 0, 0, -300 );
    var_f234ed4ac3a5a0f4 = trace::ray_trace( tracestart, ground, self );
    return var_f234ed4ac3a5a0f4[ "position" ];
}

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0x5f4b1e11, Offset: 0x1afa
// Size: 0x6d
function function_d5870d7bd6f2c7da()
{
    archetype = getdvarint( @"hash_fbdae313316d5bbf", 0 );
    
    if ( archetype == 0 )
    {
        return "close";
    }
    
    if ( archetype == 1 )
    {
        return "balanced";
    }
    
    if ( archetype == 2 )
    {
        return "long";
    }
    
    if ( archetype == 3 )
    {
        return "stealth";
    }
    
    if ( archetype == 4 )
    {
        return "ammo";
    }
}

// Namespace namespace_fc2681562de9e9ac
// Params 0
// Checksum 0x212be38c, Offset: 0x1b6f
// Size: 0x2d
function function_7a0540ae90c14b6f()
{
    weapon = getdvarint( @"hash_995eeacf44b5f5c4", 0 );
    
    if ( weapon == 0 )
    {
        return level.var_953912b81fc6bf6c;
    }
}

