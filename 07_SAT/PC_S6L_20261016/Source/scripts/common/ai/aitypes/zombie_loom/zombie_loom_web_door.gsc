// scripts\common\ai\aitypes\zombie_loom\zombie_loom_web_door.gsc  (hash_1005a9f8fa0fdb60.gscc) (size: 10060 Bytes / 0x274c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1b5674b (3786762059)
// size ...... 10060 (0x274c)
// includes .. 13  (offset: 0x2520)
// strings ... 28  (offset: 0x2588)
// dev strs .. 7   (offset: 0x26f4)
// exports ... 28  (offset: 0x1714)
// cseg ...... 0x20f + 0x1505 (0x1714)
// imports ... 85  (offset: 0x1b74)
// animtree1 . 0   (offset: 0x274c)
// animtree2 . 0   (offset: 0x274c)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\zm\systems\agent_manager;

#namespace zombie_loom_web_door;

// Namespace zombie_loom_web_door
// Params 0
// Checksum 0xdb289098, Offset: 0x22d
// Size: 0x62
function init_global()
{
    /#
        function_a09a902e357bbb3a();
    #/
    
    callback::get_template( self.animsetname ) callback::add( "out_playable_space", &out_playable_space );
    callback::get_template( self.animsetname ) callback::add( "in_playable_space", &in_playable_space );
    level callback::add( #"on_molotov_impact", &on_molotov_impact );
}

// Namespace zombie_loom_web_door
// Params 0
// Checksum 0x73f9cca4, Offset: 0x297
// Size: 0x235
function init()
{
    self.var_cc3b300ea0b9e91d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f6684b80a03e534b * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f6684b80a03e534b;
    self.var_4f69a803a59f0bd = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.doorhealth / 100;
    
    if ( !isdefined( self.var_b80666b93897c691 ) )
    {
        self.var_b80666b93897c691 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b80666b93897c691;
    }
    
    if ( !isdefined( self.var_a2755b751509465a ) )
    {
        self.var_a2755b751509465a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a2755b751509465a;
    }
    
    if ( !isdefined( self.var_f25455524d1cc27b ) )
    {
        self.var_f25455524d1cc27b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f25455524d1cc27b;
    }
    
    if ( !isdefined( self.var_8ecd18f1031f8fa9 ) )
    {
        self.var_8ecd18f1031f8fa9 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d484a895d442738f * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d484a895d442738f;
    }
    
    self.var_48c6225189b2a5d = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_48c6225189b2a5d ) );
    self.var_c380bb748c9031d6 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_84a0609d2e4d4103;
    self.var_ca89eaa9de14d2a8 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7c5384c27c00f715;
    self.var_bc03d6aab61458e2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e3a5fe9b47b9dc9f;
    self.var_f5addc86f7bff752 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f5addc86f7bff752;
    thread function_fc196e070f411dbd();
    thread function_22bcae3b6736f765();
    thread function_cd755ff8b5fdea2a();
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0x38dbd91d, Offset: 0x4d4
// Size: 0x2c
function private function_c360af1f7a0fd893( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        self function_f2df0257c63f229( "disable_doorbuy_attack" );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "disable_doorbuy_attack", 1 );
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0x4e60f821, Offset: 0x508
// Size: 0x14
function private out_playable_space( params )
{
    function_c360af1f7a0fd893( 0 );
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0x61fddf76, Offset: 0x524
// Size: 0x15
function private in_playable_space( params )
{
    function_c360af1f7a0fd893( 1 );
}

// Namespace zombie_loom_web_door
// Params 2
// Checksum 0x193a9f5f, Offset: 0x541
// Size: 0x54
function function_a01977d473c63806( taskid, params )
{
    if ( self.var_4531cd9cbd33850d && !self.doorbuytarget )
    {
        self.doorbuytarget = self.var_4531cd9cbd33850d;
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_loom_web_door
// Params 0, eflags: 0x4
// Checksum 0xec17bb3f, Offset: 0x59e
// Size: 0x28
function private function_fc196e070f411dbd()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.var_4531cd9cbd33850d = function_6713c0884510a07f();
        wait 1;
    }
}

// Namespace zombie_loom_web_door
// Params 0, eflags: 0x4
// Checksum 0xc47dc5ca, Offset: 0x5ce
// Size: 0x80
function private function_22bcae3b6736f765()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_51b54afa3e20cc8f" );
        dir = anglestoforward( self.angles );
        
        if ( self.doorbuytarget )
        {
            dir = self.doorbuytarget.origin - self.origin;
        }
        
        self orientmode( "face direction", dir );
        asm::function_7256f5ba459c840b( "doorbuy_attack_in" );
    }
}

// Namespace zombie_loom_web_door
// Params 0, eflags: 0x4
// Checksum 0x5bbcef5a, Offset: 0x656
// Size: 0x2a
function private function_cd755ff8b5fdea2a()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_459e1f7f3e133ff3" );
        function_5a48a73ee2c4ab48();
    }
}

// Namespace zombie_loom_web_door
// Params 0, eflags: 0x4
// Checksum 0x3695ad3c, Offset: 0x688
// Size: 0xff
function private function_5a48a73ee2c4ab48()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    startpos = self gettagorigin( "tag_spinneret", 1 ) ?? ( 0, 0, 0 );
    projectile = spawn( "script_model", startpos );
    projectile setmodel( self.var_80bdd5b7339864bd );
    projectile.owner = self;
    projectile utility::function_32b24db3127bff40( "spit", "aerial" );
    endpos = self.doorbuytarget.origin;
    distance = distance( startpos, endpos );
    traveltime = distance / 700;
    projectile moveto( endpos, traveltime );
    utility::delaycall( traveltime, &function_ec9e5191a1a09198, self.doorbuytarget );
    utility::delaycall( traveltime, &delete_projectile, projectile );
    self function_786bb6aa1b76c7ee( "doorbuy_attack_time", gettime() + self.var_48c6225189b2a5d );
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0x583d398b, Offset: 0x78f
// Size: 0x41
function private delete_projectile( projectile )
{
    impactvfx = utility::getfx( "loom_cocoon_impact" );
    
    if ( impactvfx )
    {
        playfx( impactvfx, projectile.origin );
    }
    
    projectile delete();
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0xff183d1a, Offset: 0x7d8
// Size: 0x73
function private function_ec9e5191a1a09198( door )
{
    if ( isalive( self ) )
    {
        if ( self )
        {
            self.doorbuytarget = undefined;
        }
        
        webbed_door = door function_a90bdac8f11e670a( self );
        webbed_door.isactive = 1;
        self.var_865aafa52f1e6798 = 1;
        
        while ( webbed_door.isactive )
        {
            wait 0.2;
        }
        
        door function_4bfa2251cd1776cf( self, webbed_door );
    }
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0xa88995af, Offset: 0x853
// Size: 0x17a
function private function_a90bdac8f11e670a( owner )
{
    if ( !isdefined( level.var_a9f25cfea1b7cf35 ) )
    {
        level.var_a9f25cfea1b7cf35 = [];
    }
    
    webbed_door = function_f6c006800fdc7b6b( owner );
    webbed_door.var_b80666b93897c691 = owner.var_b80666b93897c691;
    webbed_door.var_a2755b751509465a = owner.var_a2755b751509465a;
    webbed_door.var_f25455524d1cc27b = owner.var_f25455524d1cc27b;
    webbed_door.var_1355a2eee0e45cf0 = 1;
    self.iswebbed = 1;
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin ) );
    webbed_door.var_2b5852f808241817 = owner.var_4f69a803a59f0bd * zombie_base_health;
    webbed_door.maxhealth = 100000000;
    webbed_door.health = webbed_door.maxhealth;
    webbed_door.team = owner.team;
    webbed_door.var_a075da6848fb726e = owner.var_f5addc86f7bff752;
    damage_utility::register_damageable_entity( webbed_door, webbed_door.team );
    webbed_door setcandamage( 1 );
    webbed_door thread function_1705c8c3a75c1af4();
    level.var_a9f25cfea1b7cf35[ level.var_a9f25cfea1b7cf35.size ] = webbed_door;
    thread function_396a8eceb0dc31d5( webbed_door );
    webbed_door thread function_91f9ab975bf0f360( owner );
    return webbed_door;
}

// Namespace zombie_loom_web_door
// Params 2, eflags: 0x4
// Checksum 0xe92ccac7, Offset: 0x9d6
// Size: 0x94
function private function_4bfa2251cd1776cf( owner, webbed_door )
{
    self notify( #"hash_1e0a565333aad56b" );
    webbed_door notify( #"hash_1e0a565333aad56b" );
    webbed_door.var_1355a2eee0e45cf0 = 0;
    webbed_door setcandamage( 0 );
    damage_utility::function_b84e11c8ca9801fe( webbed_door, webbed_door.team );
    webbed_door utility::function_32b24db3127bff40( "door", "explode" );
    level.var_a9f25cfea1b7cf35 = arrayremove( level.var_a9f25cfea1b7cf35, webbed_door );
    self.iswebbed = 0;
    waitframe();
    webbed_door delete();
}

// Namespace zombie_loom_web_door
// Params 0, eflags: 0xc
// Checksum 0xef2b0703, Offset: 0xa72
// Size: 0x27a
function private function_1705c8c3a75c1af4()
{
    self notify( #"hash_da234d104c05d5a6" );
    self endon( #"hash_da234d104c05d5a6" );
    self endon( #"hash_1e0a565333aad56b" );
    self.elementalweakness[ "fire" ] = 1;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isdefined( objweapon ) )
        {
            objweapon = level.weaponnone;
        }
        
        element = zombie_damage::get_element( objweapon, attacker, meansofdeath );
        dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        dmgstruct.idamage = damage;
        override_damage = utility::callsharedfunc( #"zombie_loom", #"hash_46c84f4e79aa1b36", dmgstruct );
        var_1f9094aa868e0513 = dmgstruct.var_11e45b42fe0bdb00;
        
        if ( var_1f9094aa868e0513 )
        {
            damage = override_damage;
        }
        
        if ( !var_1f9094aa868e0513 )
        {
            dmgstruct.idamage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
            damage = zombie_damage::function_cef159ba09a96f98( dmgstruct );
            
            if ( !var_1f9094aa868e0513 && !isdefined( self.var_b80666b93897c691[ objweapon.var_25b0062cbe4d9c99 ] ) && element != "fire" && meansofdeath != "MOD_MELEE" )
            {
                damage *= self.var_f25455524d1cc27b;
            }
            
            if ( element == "fire" )
            {
                damage *= self.var_a2755b751509465a;
            }
        }
        
        self.var_2b5852f808241817 -= int( damage );
        var_c57ed7c52106c0f3 = 0;
        
        if ( self.var_2b5852f808241817 <= 0 )
        {
            var_c57ed7c52106c0f3 = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", var_c57ed7c52106c0f3 );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), point, 0, element, 0, 0 );
            }
        }
        
        if ( var_c57ed7c52106c0f3 )
        {
            self.isactive = 0;
        }
    }
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0xc
// Checksum 0x613c0984, Offset: 0xcf4
// Size: 0x9c
function private function_91f9ab975bf0f360( owner )
{
    self notify( #"hash_c077ce20390ec859" );
    self endon( #"hash_c077ce20390ec859" );
    self endon( #"hash_1e0a565333aad56b" );
    var_2ffc92cd0bdd7d8f = owner.var_8ecd18f1031f8fa9;
    owner waittill( #"death" );
    pos = owner.origin;
    
    if ( self.origin && pos && distancesquared( self.origin, pos ) < var_2ffc92cd0bdd7d8f )
    {
        self.isactive = 0;
    }
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0xae22cdcc, Offset: 0xd98
// Size: 0x19e
function private function_f6c006800fdc7b6b( loom_owner )
{
    origin = self.v_close_pos;
    
    if ( !isdefined( origin ) )
    {
        origin = self.origin;
    }
    
    angles = self.v_close_ang;
    
    if ( !isdefined( angles ) )
    {
        angles = self.angles;
    }
    
    halfsize = ( 0, 0, 0 );
    
    if ( self.doorbuy_size == "doorbuy_small" )
    {
        model = loom_owner.var_c380bb748c9031d6;
        var_52bac88688424761 = ( 0, 0, 48 );
        halfsize = ( 8, 56, 48 );
    }
    else if ( self.doorbuy_size == "doorbuy_medium" )
    {
        model = loom_owner.var_ca89eaa9de14d2a8;
        var_52bac88688424761 = ( 0, 0, 120 );
        halfsize = ( 8, 88, 120 );
    }
    else if ( self.doorbuy_size == "doorbuy_large" )
    {
        model = loom_owner.var_bc03d6aab61458e2;
    }
    
    webbed_door = spawn( "script_model", origin );
    webbed_door setmodel( model );
    webbed_door.angles = angles;
    webbed_door.var_b196c5e6da89bfe8 = var_52bac88688424761;
    webbed_door.halfsize = halfsize;
    webbed_door.center = ( webbed_door.origin[ 0 ], webbed_door.origin[ 1 ], webbed_door.origin[ 2 ] + halfsize[ 2 ] );
    return webbed_door;
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0xc8976fb5, Offset: 0xf3f
// Size: 0x14b
function private function_396a8eceb0dc31d5( webbed_door )
{
    triggers = [];
    
    foreach ( interact in self.var_fc824b622a52db8d )
    {
        trigger = spawn( "noent_volume_trigger_brushmodel", interact.origin, 0, interact );
        trigger::makeenterexittrigger( trigger, &function_9b3dc97a097eab75, &function_d1a827af246b35ab, undefined, undefined, undefined, webbed_door );
        triggers[ triggers.size ] = trigger;
    }
    
    self waittill( #"hash_1e0a565333aad56b" );
    
    foreach ( trigger in triggers )
    {
        trigger triggerdisable();
        trigger trigger::cleanup_enter_exit_trigger( self );
        trigger delete();
    }
}

// Namespace zombie_loom_web_door
// Params 3, eflags: 0x4
// Checksum 0xaeafdfbd, Offset: 0x1092
// Size: 0x5a
function private function_9b3dc97a097eab75( ent, door, payload )
{
    if ( isai( ent ) && ent.animsetname != "zombie_loom" && ent.animsetname != "zombie_vermin" )
    {
        thread function_985f50707c549269( payload );
    }
}

// Namespace zombie_loom_web_door
// Params 3, eflags: 0x4
// Checksum 0xb9e3c1bf, Offset: 0x10f4
// Size: 0x5d
function private function_d1a827af246b35ab( ent, door, payload )
{
    if ( isai( ent ) && ent.animsetname != "zombie_loom" && ent.animsetname != "zombie_vermin" )
    {
        self notify( #"hash_9adbc9a2d8ea53a2" );
    }
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0xc
// Checksum 0x4a9e6c56, Offset: 0x1159
// Size: 0x9e
function private function_985f50707c549269( webbed_door )
{
    self notify( #"hash_71a53e376288f395" );
    self endon( #"hash_71a53e376288f395" );
    webbed_door endon( #"hash_1e0a565333aad56b" );
    self endon( #"hash_9adbc9a2d8ea53a2" );
    self endon( #"death" );
    
    while ( webbed_door.isactive )
    {
        if ( self istouching( webbed_door ) )
        {
            effect_slow::slow( "webbed_wall", webbed_door.var_a075da6848fb726e, 0.75, webbed_door, &function_c56003a2409a610d );
            utility::function_32b24db3127bff40( "y_mod", "web_on" );
        }
        
        wait 0.25;
    }
}

// Namespace zombie_loom_web_door
// Params 2, eflags: 0x44 variadic
// Checksum 0xa9e3f1cd, Offset: 0x11ff
// Size: 0x2a
function private function_c56003a2409a610d( ... )
{
    if ( self )
    {
        utility::function_32b24db3127bff40( "y_mod", "off" );
    }
}

// Namespace zombie_loom_web_door
// Params 0, eflags: 0x4
// Checksum 0xf766918e, Offset: 0x1231
// Size: 0x15b
function private function_6713c0884510a07f()
{
    forward = anglestoforward( self.angles );
    
    foreach ( doorbuy_brush in level.var_22c88164c67477ae )
    {
        if ( !doorbuy_brush.s_doorbuy.b_doorbuy_opened )
        {
            continue;
        }
        
        if ( doorbuy_brush.iswebbed )
        {
            continue;
        }
        
        center = doorbuy_brush.origin;
        var_6e65cd2002f7c34c = center - self.origin;
        
        /#
            if ( getdvarint( @"hash_9e1fdc180739ee2e", 0 ) > 0 )
            {
                sphere( center, 5, undefined, undefined, 60 );
            }
        #/
        
        if ( isent( doorbuy_brush ) && self.var_cc3b300ea0b9e91d > vectordot( var_6e65cd2002f7c34c, var_6e65cd2002f7c34c ) )
        {
            if ( vectordot( var_6e65cd2002f7c34c, forward ) < 0 )
            {
                if ( doorbuy_brush.temple_index && level.var_cd93870ee4d04f72[ doorbuy_brush.temple_index ] )
                {
                    continue;
                }
                
                return doorbuy_brush;
            }
        }
    }
}

// Namespace zombie_loom_web_door
// Params 1, eflags: 0x4
// Checksum 0x1a082f40, Offset: 0x1395
// Size: 0x20a
function private on_molotov_impact( params )
{
    radius = 60;
    
    if ( params.bundle.coredata.triggerradius && params.bundle.tendrildata.triggerradius )
    {
        radius = params.bundle.coredata.triggerradius + params.bundle.tendrildata.triggerradius;
    }
    
    radiussqrd = radius * radius;
    grenadepos = params.grenade.origin;
    
    foreach ( webbed_door in level.var_a9f25cfea1b7cf35 )
    {
        if ( !webbed_door )
        {
            continue;
        }
        
        if ( distancesquared( webbed_door.center, grenadepos ) > 90000 )
        {
            continue;
        }
        
        closestpoint = math::function_1243a6cc6a030f2a( grenadepos, webbed_door.center, webbed_door.halfsize, webbed_door.angles );
        
        if ( distancesquared( grenadepos, closestpoint ) <= radiussqrd )
        {
            if ( utility::issharedfuncdefined( #"molotov", #"hash_42699d8a779042f6" ) )
            {
                webbed_door thread [[ utility::getsharedfunc( #"molotov", #"hash_42699d8a779042f6" ) ]]( params.bundle.var_f81d0343e92b24c6 ?? 6, self, params.grenade, params.grenade );
            }
        }
    }
}

/#

    // Namespace zombie_loom_web_door
    // Params 0
    // Checksum 0x1e0236d, Offset: 0x15a7
    // Size: 0x44, Type: dev
    function function_a09a902e357bbb3a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x49>", &function_b06928ed2e0350a8 );
        devgui::add_devgui_func( "<dev string:x57>", "<dev string:x65>", &web_all_doors );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_loom_web_door
    // Params 0, eflags: 0x4
    // Checksum 0x972ae339, Offset: 0x15f3
    // Size: 0x1a, Type: dev
    function private function_b06928ed2e0350a8()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x71>", @"hash_9e1fdc180739ee2e" );
    }

    // Namespace zombie_loom_web_door
    // Params 0, eflags: 0x4
    // Checksum 0x9a297928, Offset: 0x1615
    // Size: 0xff, Type: dev
    function private web_all_doors()
    {
        loom = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x84>" );
        
        if ( !loom )
        {
            loom = agent_manager::spawn_agent( "<dev string:x84>", level.players[ 0 ].origin );
        }
        
        foreach ( doorbuy_brush in level.var_22c88164c67477ae )
        {
            if ( !doorbuy_brush.s_doorbuy.b_doorbuy_opened )
            {
                continue;
            }
            
            if ( doorbuy_brush.iswebbed )
            {
                continue;
            }
            
            loom thread function_ec9e5191a1a09198( doorbuy_brush );
        }
    }

#/
