// scripts\mp\zm\ztron\ztron_meta_progression.gsc  (hash_76f5f1eaf33e3f1b.gscc) (size: 6614 Bytes / 0x19d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79b8371a (2042115866)
// size ...... 6614 (0x19d6)
// includes .. 4   (offset: 0x188e)
// strings ... 16  (offset: 0x18ae)
// dev strs .. 0   (offset: 0x19d6)
// exports ... 22  (offset: 0x120e)
// cseg ...... 0x144 + 0x10ca (0x120e)
// imports ... 23  (offset: 0x157e)
// animtree1 . 0   (offset: 0x19d6)
// animtree2 . 0   (offset: 0x19d6)
#using script_31ee2a173f3499b7;
#using scripts\common\callbacks;
#using scripts\mp\playerstats_interface;
#using scripts\mp\zm\ztron\ztron_player_utility;

#namespace ztron_meta_progression;

// Namespace ztron_meta_progression
// Params 0
// Checksum 0xec39b86d, Offset: 0x162
// Size: 0x14
function function_9c32dbc4437d54dc()
{
    level callback::add( "ztron_meta_token_awarded", &ztron_ui::function_b4c1134ed6d00708 );
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0xea1c7606, Offset: 0x17e
// Size: 0x18c
function initmeta()
{
    self.ztron.meta = spawnstruct();
    self.ztron.meta.fleetFeet = 0;
    self.ztron.meta.deadshot = 0;
    self.ztron.meta.thickSkin = 0;
    self.ztron.meta.timeThief = 0;
    self.ztron.meta.armory = 0;
    self.ztron.meta.chronoCollector = 0;
    self.ztron.meta.diseaseInflictor = 0;
    self.ztron.meta.scavenger = 0;
    self.ztron.meta.secondWind = 0;
    self.ztron.meta.masterBlaster = 0;
    self.ztron.meta.tokens = 0;
    
    if ( level.ztron.metaenabled )
    {
        function_f9c85e6f5eb03a52();
    }
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0xec178010, Offset: 0x312
// Size: 0x1c8
function function_f9c85e6f5eb03a52()
{
    self.ztron.meta.fleetFeet = function_445b4f13d1176e50( "fleetFeet" );
    self.ztron.meta.deadshot = function_445b4f13d1176e50( "deadshot" );
    self.ztron.meta.thickSkin = function_445b4f13d1176e50( "thickSkin" );
    self.ztron.meta.timeThief = function_445b4f13d1176e50( "timeThief" );
    self.ztron.meta.armory = function_445b4f13d1176e50( "armory" );
    self.ztron.meta.chronoCollector = function_445b4f13d1176e50( "chronoCollector" );
    self.ztron.meta.diseaseInflictor = function_445b4f13d1176e50( "diseaseInflictor" );
    self.ztron.meta.scavenger = function_445b4f13d1176e50( "scavenger" );
    self.ztron.meta.secondWind = function_445b4f13d1176e50( "secondWind" );
    self.ztron.meta.masterBlaster = function_445b4f13d1176e50( "masterBlaster" );
    self.ztron.meta.tokens = function_445b4f13d1176e50( "tokens", 65535 );
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0xfed2054b, Offset: 0x4e2
// Size: 0x1c5
function function_c2b0649474e1e376()
{
    function_21397ed1c2570741( "fleetFeet", self.ztron.meta.fleetFeet );
    function_21397ed1c2570741( "deadshot", self.ztron.meta.deadshot );
    function_21397ed1c2570741( "thickSkin", self.ztron.meta.thickSkin );
    function_21397ed1c2570741( "timeThief", self.ztron.meta.timeThief );
    function_21397ed1c2570741( "armory", self.ztron.meta.armory );
    function_21397ed1c2570741( "chronoCollector", self.ztron.meta.chronoCollector );
    function_21397ed1c2570741( "diseaseInflictor", self.ztron.meta.diseaseInflictor );
    function_21397ed1c2570741( "scavenger", self.ztron.meta.scavenger );
    function_21397ed1c2570741( "secondWind", self.ztron.meta.secondWind );
    function_21397ed1c2570741( "masterBlaster", self.ztron.meta.masterBlaster );
    function_21397ed1c2570741( "tokens", self.ztron.meta.tokens );
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0x5f834ec3, Offset: 0x6af
// Size: 0x90
function function_156f5e9e41ac12aa()
{
    level.ztron.meta = spawnstruct();
    level.ztron.meta.timepiecesspawned = 0;
    level.ztron.meta.papabackdefeated = 0;
    level.ztron.meta.tokens = 0;
    level callback::add( "player_match_end", &function_ec69210ff289630e );
    function_9c32dbc4437d54dc();
}

// Namespace ztron_meta_progression
// Params 1
// Checksum 0x353843ec, Offset: 0x747
// Size: 0x134
function awardtoken( count )
{
    if ( !isdefined( level.ztron.meta ) )
    {
        return;
    }
    
    self.ztron.meta.tokens += count;
    
    if ( self.ztron.meta.tokens > 65535 )
    {
        self.ztron.meta.tokens = 65535;
    }
    
    function_21397ed1c2570741( "tokens", self.ztron.meta.tokens );
    data = spawnstruct();
    data.player = self;
    data.var_8f043866645d0c80 = count;
    data.newtotal = self.ztron.meta.tokens;
    level callback::callback( "ztron_meta_token_awarded", data );
}

// Namespace ztron_meta_progression
// Params 1
// Checksum 0x51aa283f, Offset: 0x883
// Size: 0x86
function function_f7216127c5e1d966( count )
{
    foreach ( player in level.players )
    {
        player thread awardtoken( count );
    }
}

// Namespace ztron_meta_progression
// Params 1
// Checksum 0x53ae2ae2, Offset: 0x911
// Size: 0x8b, Type: bool
function spendtoken( attribute )
{
    if ( self.ztron.meta.tokens <= 0 )
    {
        return false;
    }
    
    currentlevel = function_cc6891967c0b7207( attribute );
    
    if ( !isdefined( currentlevel ) || currentlevel >= 5 )
    {
        return false;
    }
    
    self.ztron.meta.tokens--;
    function_7db706bc5b8e879b( attribute, currentlevel + 1 );
    function_c2b0649474e1e376();
    return true;
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0xdb7c4644, Offset: 0x9a5
// Size: 0x1f
function function_64f7efe5d5024f66()
{
    return self.ztron.meta.tokens;
}

// Namespace ztron_meta_progression
// Params 1
// Checksum 0x9d493816, Offset: 0x9cd
// Size: 0x14
function function_36f7e718fb0fa424( attribute )
{
    return function_cc6891967c0b7207( attribute );
}

// Namespace ztron_meta_progression
// Params 2
// Checksum 0x93b59323, Offset: 0x9ea
// Size: 0x34
function function_996793ae2b9b6a3c( player, attribute )
{
    val = player function_cc6891967c0b7207( attribute );
    
    if ( !isdefined( val ) )
    {
        val = 0;
    }
    
    return val;
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0x874be9fd, Offset: 0xa27
// Size: 0x5d
function function_e9e1a6763af103a()
{
    return [ "fleetFeet", "deadshot", "armory", "timeThief", "thickSkin", "chronoCollector", "diseaseInflictor", "scavenger", "secondWind", "masterBlaster" ];
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0x76e979d2, Offset: 0xa8d
// Size: 0xab
function function_fce15efedadce8f9()
{
    var_868a2a6ea40f13cf = function_e9e1a6763af103a();
    
    foreach ( attr in var_868a2a6ea40f13cf )
    {
        function_7db706bc5b8e879b( attr, 0 );
    }
    
    self.ztron.meta.tokens = 0;
    function_c2b0649474e1e376();
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0x4cf903dd, Offset: 0xb40
// Size: 0x8d
function function_73a3e89c13fc9c2()
{
    var_868a2a6ea40f13cf = function_e9e1a6763af103a();
    
    foreach ( attr in var_868a2a6ea40f13cf )
    {
        function_7db706bc5b8e879b( attr, 5 );
    }
    
    function_c2b0649474e1e376();
}

// Namespace ztron_meta_progression
// Params 0
// Checksum 0x49f6376a, Offset: 0xbd5
// Size: 0x8d, Type: bool
function function_929384f55e44537f()
{
    var_868a2a6ea40f13cf = function_e9e1a6763af103a();
    
    foreach ( attr in var_868a2a6ea40f13cf )
    {
        if ( function_cc6891967c0b7207( attr ) < 5 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ztron_meta_progression
// Params 1
// Checksum 0xb3108317, Offset: 0xc6b
// Size: 0xd0
function function_de5c10056990b7da( attribute )
{
    var_acecf1de8ec2250a = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.ztron ) && isdefined( player.ztron.meta ) )
        {
            var_d31f0d4f00dc5b64 = player function_cc6891967c0b7207( attribute );
            
            if ( var_d31f0d4f00dc5b64 > var_acecf1de8ec2250a )
            {
                var_acecf1de8ec2250a = var_d31f0d4f00dc5b64;
            }
        }
    }
    
    return var_acecf1de8ec2250a;
}

// Namespace ztron_meta_progression
// Params 2, eflags: 0x4
// Checksum 0x8f63874d, Offset: 0xd44
// Size: 0x6d
function private function_445b4f13d1176e50( key, maxval = 5 )
{
    val = playerstats_interface::getplayerstat( "ztronPlayerStats", "meta" + key, undefined, undefined, undefined, "zm" );
    
    if ( !isdefined( val ) )
    {
        return 0;
    }
    
    val = int( val );
    
    if ( val < 0 )
    {
        val = 0;
    }
    
    if ( val > maxval )
    {
        val = maxval;
    }
    
    return val;
}

// Namespace ztron_meta_progression
// Params 2, eflags: 0x4
// Checksum 0x9db0b16d, Offset: 0xdba
// Size: 0x33
function private function_21397ed1c2570741( key, value )
{
    playerstats_interface::setplayerstat( value, "ztronPlayerStats", "meta" + key, undefined, undefined, undefined, "zm" );
}

// Namespace ztron_meta_progression
// Params 1, eflags: 0x4
// Checksum 0xbb11543, Offset: 0xdf5
// Size: 0x1c7
function private function_cc6891967c0b7207( attribute )
{
    switch ( attribute )
    {
        case #"hash_8dff832c45c7edeb":
            return self.ztron.meta.fleetFeet;
        case #"hash_5500dc6df4b50a47":
            return self.ztron.meta.deadshot;
        case #"hash_264553bbcab45dbb":
            return self.ztron.meta.thickSkin;
        case #"hash_9f73e75df33f9b4c":
            return self.ztron.meta.timeThief;
        case #"hash_46102be38855bbb7":
            return self.ztron.meta.armory;
        case #"hash_333bfd91d443f695":
            return self.ztron.meta.chronoCollector;
        case #"hash_87690cc29d5349dd":
            return self.ztron.meta.diseaseInflictor;
        case #"hash_5c57b61aa79410db":
            return self.ztron.meta.scavenger;
        case #"hash_4bd276904172cc1f":
            return self.ztron.meta.secondWind;
        case #"hash_72c1e31d3fb5e860":
            return self.ztron.meta.masterBlaster;
        default:
            return;
    }
}

// Namespace ztron_meta_progression
// Params 2, eflags: 0x4
// Checksum 0x729ff3c3, Offset: 0xfc4
// Size: 0x20b
function private function_7db706bc5b8e879b( attribute, value )
{
    if ( value < 0 )
    {
        value = 0;
    }
    
    if ( value > 5 )
    {
        value = 5;
    }
    
    switch ( attribute )
    {
        case #"hash_8dff832c45c7edeb":
            self.ztron.meta.fleetFeet = value;
            break;
        case #"hash_5500dc6df4b50a47":
            self.ztron.meta.deadshot = value;
            break;
        case #"hash_264553bbcab45dbb":
            self.ztron.meta.thickSkin = value;
            break;
        case #"hash_9f73e75df33f9b4c":
            self.ztron.meta.timeThief = value;
            break;
        case #"hash_46102be38855bbb7":
            self.ztron.meta.armory = value;
            break;
        case #"hash_333bfd91d443f695":
            self.ztron.meta.chronoCollector = value;
            break;
        case #"hash_87690cc29d5349dd":
            self.ztron.meta.diseaseInflictor = value;
            break;
        case #"hash_5c57b61aa79410db":
            self.ztron.meta.scavenger = value;
            break;
        case #"hash_4bd276904172cc1f":
            self.ztron.meta.secondWind = value;
            break;
        case #"hash_72c1e31d3fb5e860":
            self.ztron.meta.masterBlaster = value;
            break;
    }
}

// Namespace ztron_meta_progression
// Params 1
// Checksum 0xd25e19d8, Offset: 0x11d7
// Size: 0x37
function function_ec69210ff289630e( data )
{
    player = data.player;
    
    if ( player ztron_player_utility::function_9abc64ef2cb9cbd() )
    {
        player function_c2b0649474e1e376();
    }
}

