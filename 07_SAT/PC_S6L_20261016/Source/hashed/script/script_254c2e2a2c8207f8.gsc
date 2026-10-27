// script_254c2e2a2c8207f8  (hash_254c2e2a2c8207f8.gscc) (size: 3181 Bytes / 0xc6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1d2e86e7 (489588455)
// size ...... 3181 (0xc6d)
// includes .. 7   (offset: 0xc35)
// strings ... 0   (offset: 0xc6d)
// dev strs .. 0   (offset: 0xc6d)
// exports ... 2   (offset: 0x5e1)
// cseg ...... 0x58 + 0x589 (0x5e1)
// imports ... 55  (offset: 0x631)
// animtree1 . 0   (offset: 0xc6d)
// animtree2 . 0   (offset: 0xc6d)
#using script_45e6947be98e16e3;
#using scripts\mp\ftue\utility\ftue_cash;
#using scripts\mp\ftue\utility\ftue_loot_cache;
#using scripts\mp\ftue\utility\ftue_movement;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_weapon;

#namespace namespace_c6146975db76fd48;

// Namespace namespace_c6146975db76fd48
// Params 0
// Checksum 0xb369bd01, Offset: 0x76
// Size: 0x56b
function function_7ee9a231857d626a()
{
    level.var_31ba871bbc6d3d12 = [];
    level.var_31ba871bbc6d3d12[ #"hash_bd485a8766cc8144" ] = &namespace_727c07157c884ff5::function_616b36694e0a4d5;
    level.var_31ba871bbc6d3d12[ #"hash_c05f23231f1fd906" ] = &namespace_727c07157c884ff5::function_c04cf3b0a1df4691;
    level.var_31ba871bbc6d3d12[ #"hash_2fd4540e87646c8f" ] = &namespace_727c07157c884ff5::function_d1566269fe60d9a0;
    level.var_31ba871bbc6d3d12[ #"hash_9b8602e607a87dae" ] = &namespace_727c07157c884ff5::function_969703618e87966b;
    level.var_31ba871bbc6d3d12[ #"hash_2423b25b94251c73" ] = &ftue_player::function_390fcdf70be5b88d;
    level.var_31ba871bbc6d3d12[ #"hash_5e6fbe69ddb8ec3a" ] = &namespace_727c07157c884ff5::function_f7e0f9f348708385;
    level.var_31ba871bbc6d3d12[ #"hash_1d0b64065eb28cba" ] = &namespace_727c07157c884ff5::function_98154fcb15750955;
    level.var_31ba871bbc6d3d12[ #"hash_b494e46204ad69af" ] = &namespace_727c07157c884ff5::function_f23b3081cd0fcfe0;
    level.var_31ba871bbc6d3d12[ #"hash_88893fc5d607ff7b" ] = &namespace_727c07157c884ff5::function_b80a8768d6ae141a;
    level.var_31ba871bbc6d3d12[ #"hash_393d0d0552ce9cdb" ] = &ftue_player::function_22dc863a42b13911;
    level.var_31ba871bbc6d3d12[ #"condinsafezone" ] = &ftue_player::function_b940805bdd38cde7;
    level.var_31ba871bbc6d3d12[ #"hash_7fc8621471462a7" ] = &ftue_player::function_ffe170a3c300b2a1;
    level.var_31ba871bbc6d3d12[ #"hash_2985d7fb1675a4c9" ] = &ftue_movement::function_b637614feabc055f;
    level.var_31ba871bbc6d3d12[ #"condisingulag" ] = &namespace_727c07157c884ff5::condisingulag;
    level.var_31ba871bbc6d3d12[ #"hash_fdeb23005dd2fee8" ] = &ftue_player::function_9fa2f60745776946;
    level.var_31ba871bbc6d3d12[ #"hash_35b06a2bd68b0a3" ] = &namespace_727c07157c884ff5::function_282b0d131dd79a82;
    level.var_31ba871bbc6d3d12[ #"hash_c9d3284406c828b9" ] = &namespace_727c07157c884ff5::function_76035c8e0ac4b5f0;
    level.var_31ba871bbc6d3d12[ #"hash_dafc8ae8e6499e85" ] = &namespace_727c07157c884ff5::function_d6346b47316cfeca;
    level.var_31ba871bbc6d3d12[ #"hash_ddd8f13c224a9673" ] = &namespace_727c07157c884ff5::function_748dffc202f20964;
    level.var_31ba871bbc6d3d12[ #"hash_1b60259f39acecd7" ] = &namespace_727c07157c884ff5::function_da24926f47408f3a;
    level.var_31ba871bbc6d3d12[ #"hash_9f7d9a620915dddf" ] = &ftue_player::function_10e127ef0cc3ed41;
    level.var_31ba871bbc6d3d12[ #"hash_d983f744b6d432df" ] = &namespace_727c07157c884ff5::function_5b93b34229d4622a;
    level.var_31ba871bbc6d3d12[ #"hash_1a5df0a873a65c7d" ] = &namespace_727c07157c884ff5::function_eb67b51ce22d2d0c;
    level.var_31ba871bbc6d3d12[ #"hash_473ba3171fb07967" ] = &namespace_727c07157c884ff5::function_4e28a5536a8acba2;
    level.var_31ba871bbc6d3d12[ #"hash_cdb2255842d1b7a7" ] = &ftue_cash::function_11d35b17ca7c28ef;
    level.var_31ba871bbc6d3d12[ #"hash_4a6f0040129fb058" ] = &namespace_727c07157c884ff5::function_c78b9b134e8f22cf;
    level.var_31ba871bbc6d3d12[ #"hash_f77da1a0bc1b7f20" ] = &namespace_727c07157c884ff5::function_3fd61caeed3a4449;
    level.var_31ba871bbc6d3d12[ #"hash_c8e46e6c2c78a405" ] = &namespace_727c07157c884ff5::function_fae015843b69fbe8;
    level.var_31ba871bbc6d3d12[ #"hash_176a62aef59a65e9" ] = &namespace_727c07157c884ff5::function_22bfa02c238151de;
    level.var_31ba871bbc6d3d12[ #"hash_e71b427d3ac2e1e8" ] = &ftue_player::function_5bc28111ecf756e2;
    level.var_31ba871bbc6d3d12[ #"condisplayerdead" ] = &ftue_player::function_7995e388b318188c;
    level.var_31ba871bbc6d3d12[ #"hash_e944571129710325" ] = &namespace_727c07157c884ff5::function_962a6f44d52089f6;
    level.var_31ba871bbc6d3d12[ #"hash_cd4f860af4d9d01" ] = &namespace_727c07157c884ff5::function_aedb892a1c78e040;
    level.var_31ba871bbc6d3d12[ #"hash_91fb810dfb39019e" ] = &ftue_loot_cache::function_85e5174946c90517;
    level.var_31ba871bbc6d3d12[ #"hash_a478a533f6ed05ad" ] = &ftue_loot_cache::function_1d5a83b08f74c9cc;
    level.var_31ba871bbc6d3d12[ #"hash_98d6c62aa452883b" ] = &namespace_727c07157c884ff5::function_11ef24d0e4aaf282;
    level.var_31ba871bbc6d3d12[ #"hash_75ea4d06d4feb720" ] = &ftue_weapon::function_f17ccf5633ebd537;
    level.var_31ba871bbc6d3d12[ #"hash_e4cd71e9e0ba9d63" ] = &namespace_727c07157c884ff5::function_78bec54d64c6d014;
    level.var_31ba871bbc6d3d12[ #"hash_91ada55fbb1c7416" ] = &ftue_progress::function_e86e99a754ea1de2;
    level.var_31ba871bbc6d3d12[ #"hash_9271835cd909dc99" ] = &namespace_727c07157c884ff5::function_9909c3350df0537c;
    level.var_31ba871bbc6d3d12[ #"hash_51441c1a72c67c87" ] = &namespace_727c07157c884ff5::function_4641037497231bce;
    level.var_31ba871bbc6d3d12[ #"hash_1f9ca1411bb8910d" ] = &namespace_727c07157c884ff5::function_b1c7685ac37709ee;
    level.var_31ba871bbc6d3d12[ #"condisplayeralive" ] = &ftue_player::function_45230091db47a07;
    level.var_31ba871bbc6d3d12[ #"condisplayerinvehicle" ] = &namespace_727c07157c884ff5::condisplayerinvehicle;
    level.var_31ba871bbc6d3d12[ #"hash_8dac97ec51bd3519" ] = &namespace_727c07157c884ff5::function_ae55d906f194f6b2;
    level.var_31ba871bbc6d3d12[ #"condisprematch" ] = &namespace_727c07157c884ff5::condisprematch;
    level.var_31ba871bbc6d3d12[ #"hash_359bf3e84b32afa1" ] = &namespace_727c07157c884ff5::function_76f44af8b032d0b0;
    level.var_31ba871bbc6d3d12[ #"hash_12ddd1dca78a8a3b" ] = &namespace_727c07157c884ff5::function_3700200c8e51cdc2;
    level.var_31ba871bbc6d3d12[ #"hash_f3dbf9b791ebc60d" ] = &namespace_727c07157c884ff5::function_49ae08a5c8be41b0;
    level.var_31ba871bbc6d3d12[ #"condisplayermoving" ] = &namespace_727c07157c884ff5::condisplayermoving;
    level.var_31ba871bbc6d3d12[ #"condisplayersprinting" ] = &namespace_727c07157c884ff5::condisplayersprinting;
    level.var_31ba871bbc6d3d12[ #"condisplayerswimming" ] = &namespace_727c07157c884ff5::condisplayerswimming;
    level.var_31ba871bbc6d3d12[ #"hash_2503b95cfbea0dd1" ] = &namespace_727c07157c884ff5::function_666973781b4c8792;
    level.var_31ba871bbc6d3d12[ #"hash_c43c9e44b9b93b21" ] = &namespace_727c07157c884ff5::function_db633fd3f9ac034a;
    level.var_31ba871bbc6d3d12[ #"hash_a87173d8a94261bc" ] = &namespace_727c07157c884ff5::function_dd13fad7a4999f6b;
}

