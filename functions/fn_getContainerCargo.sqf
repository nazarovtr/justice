// Some weapns have classes like
private _basicWeapons = [
    ["srifle_DMR_01_", "srifle_DMR_01_F"],
    ["srifle_DMR_02_sniper_", "srifle_DMR_02_sniper_F"],
    ["srifle_DMR_02_camo_", "srifle_DMR_02_camo_F"],
    ["srifle_DMR_02_", "srifle_DMR_02_F"],
    ["srifle_DMR_03_khaki_", "srifle_DMR_03_khaki_F"],
    ["srifle_DMR_03_tan_", "srifle_DMR_03_tan_F"],
    ["srifle_DMR_03_multicam_", "srifle_DMR_03_multicam_F"],
    ["srifle_DMR_03_woodland_", "srifle_DMR_03_woodland_F"],
    ["srifle_DMR_03_", "srifle_DMR_03_F"],
    ["srifle_DMR_04_Tan_", "srifle_DMR_04_Tan_F"],
    ["srifle_DMR_04_", "srifle_DMR_04_F"],
    ["srifle_DMR_05_hex_", "srifle_DMR_05_hex_F"],
    ["srifle_DMR_05_tan_", "srifle_DMR_05_tan_f"],
    ["srifle_DMR_05_", "srifle_DMR_05_blk_F"],
    ["srifle_DMR_06_camo_", "srifle_DMR_06_camo_F"],
    ["srifle_DMR_06_olive_", "srifle_DMR_06_olive_F"],
    ["srifle_DMR_07_blk_", "srifle_DMR_07_blk_F"],
    ["srifle_DMR_07_hex_", "srifle_DMR_07_hex_F"],
    ["srifle_DMR_07_ghex_", "srifle_DMR_07_ghex_F"],
    ["srifle_EBR_", "srifle_EBR_F"],
    ["srifle_GM6_camo_", "srifle_GM6_camo_F"],
    ["srifle_GM6_", "srifle_GM6_F"],
    ["srifle_LRR_camo_", "srifle_LRR_camo_F"],
    ["srifle_LRR_tna_", "srifle_LRR_tna_F"],
    ["srifle_GM6_ghex_", "srifle_GM6_ghex_F"],
    ["srifle_LRR_", "srifle_LRR_F"],
    ["LMG_Mk200_", "LMG_Mk200_F"],
    ["LMG_Zafir_", "LMG_Zafir_F"],
    ["MMG_01_hex_", "MMG_01_hex_F"],
    ["MMG_01_tan_", "MMG_01_tan_F"],
    ["MMG_02_camo_", "MMG_02_camo_F"],
    ["MMG_02_black_", "MMG_02_black_F"],
    ["MMG_02_sand_", "MMG_02_sand_F"],
    ["LMG_03_", "LMG_03_F"],
    ["hgun_ACPC2_", "hgun_ACPC2_F"],
    ["hgun_P07_khk_", "hgun_P07_khk_F"],
    ["hgun_P07_", "hgun_P07_F"],
    ["hgun_Pistol_heavy_01_", "hgun_Pistol_heavy_01_F"],
    ["hgun_Pistol_heavy_02_", "hgun_Pistol_heavy_02_F"],
    ["hgun_Rook40_", "hgun_Rook40_F"],
    ["hgun_Pistol_01_", "hgun_Pistol_01_F"],
    ["arifle_Katiba_GL_", "arifle_Katiba_GL_F"],
    ["arifle_Katiba_C_", "arifle_Katiba_C_F"],
    ["arifle_Katiba_", "arifle_Katiba_F"],
    ["arifle_Mk20_GL_plain_", "arifle_Mk20_GL_plain_F"],
    ["arifle_Mk20_GL_", "arifle_Mk20_GL_F"],
    ["arifle_Mk20C_plain_F", "arifle_Mk20C_plain_F "],
    ["arifle_Mk20C_", "arifle_Mk20C_F"],
    ["arifle_Mk20_plain_", "arifle_Mk20_plain_F"],
    ["arifle_Mk20_", "arifle_Mk20_F"],
    ["arifle_MX_SW_Black_", "arifle_MX_SW_Black_F"],
    ["arifle_MX_GL_Black_", "arifle_MX_GL_Black_F"],
    ["arifle_MXC_Black_", "arifle_MXC_Black_F"],
    ["arifle_MXM_Black_", "arifle_MXM_Black_F"],
    ["arifle_MX_Black_", "arifle_MX_Black_F"],
    ["arifle_MX_SW_khk_", "arifle_MX_SW_khk_F"],
    ["arifle_MX_GL_khk_", "arifle_MX_GL_khk_F"],
    ["arifle_MXC_khk_", "arifle_MXC_khk_F"],
    ["arifle_MXM_khk_", "arifle_MXM_khk_F"],
    ["arifle_MX_khk_", "arifle_MX_khk_F"],
    ["arifle_MX_SW_", "arifle_MX_SW_F"],
    ["arifle_MX_GL_", "arifle_MX_GL_F"],
    ["arifle_MXC_", "arifle_MXC_F"],
    ["arifle_MXM_", "arifle_MXM_F"],
    ["arifle_MX_", "arifle_MX_F"],
    ["arifle_TRG21_GL_F", "arifle_TRG21_GL_F"],
    ["arifle_TRG21_", "arifle_TRG21_F"],
    ["arifle_TRG20_", "arifle_TRG20_F"],
    ["arifle_AK12_GL_", "arifle_AK12_GL_F"],
    ["arifle_AK12_", "arifle_AK12_F"],
    ["arifle_ARX_blk_", "arifle_ARX_blk_F"],
    ["arifle_ARX_ghex_", "arifle_ARX_ghex_F"],
    ["arifle_ARX_hex_", "arifle_ARX_hex_F"],
    ["arifle_CTAR_GL_blk_F", "arifle_CTAR_GL_blk_F"],
    ["arifle_CTAR_blk_", "arifle_CTAR_blk_F"],
    ["arifle_CTAR_GL_hex_", "arifle_CTAR_GL_hex_F"],
    ["arifle_CTAR_hex_", "arifle_CTAR_hex_F"],
    ["arifle_CTAR_GL_ghex_", "arifle_CTAR_GL_ghex_F"],
    ["arifle_CTAR_ghex_", "arifle_CTAR_ghex_F"],
    ["arifle_CTARS_blk_", "arifle_CTARS_blk_F"],
    ["arifle_CTARS_hex_", "arifle_CTARS_hex_F"],
    ["arifle_CTARS_ghex_", "arifle_CTARS_ghex_F"],
    ["arifle_SPAR_01_GL_blk_", "arifle_SPAR_01_GL_blk_F"],
    ["arifle_SPAR_01_GL_khk_", "arifle_SPAR_01_GL_khk_F"],
    ["arifle_SPAR_01_GL_snd_", "arifle_SPAR_01_GL_snd_F"],
    ["arifle_SPAR_01_blk_", "arifle_SPAR_01_blk_F"],
    ["arifle_SPAR_01_khk_", "arifle_SPAR_01_khk_F"],
    ["arifle_SPAR_01_snd_", "arifle_SPAR_01_snd_F"],
    ["arifle_SPAR_02_blk_", "arifle_SPAR_02_blk_F"],
    ["arifle_SPAR_02_khk_", "arifle_SPAR_02_khk_F"],
    ["arifle_SPAR_02_snd_", "arifle_SPAR_02_snd_F"],
    ["arifle_SPAR_03_blk_", "arifle_SPAR_03_blk_F"],
    ["arifle_SPAR_03_khk_", "arifle_SPAR_03_khk_F"],
    ["arifle_SPAR_03_snd_", "arifle_SPAR_03_snd_F"],
    ["arifle_CTAR_ghex_", "arifle_CTAR_ghex_F"],
    ["arifle_CTAR_ghex_", "arifle_CTAR_ghex_F"],
    ["hgun_PDW2000_", "hgun_PDW2000_F"],
    ["SMG_05_", "SMG_05_F"],
    ["SMG_02_", "SMG_02_F"],
    ["SMG_01_", "SMG_01_F"],
    ["hgun_PDW2000_", "hgun_PDW2000_F"],
    ["hgun_PDW2000_", "hgun_PDW2000_F"],
    ["hgun_PDW2000_", "hgun_PDW2000_F"],
    ["srifle_DMR_01_", "srifle_DMR_01_F"]
];

fn_getWeaponNoAttachments = {
    private _weaponName = _this select 0;
    scopeName "main";
    {
        if ((_weaponName find (_x select 0)) == 0) then {
            _weaponName = _x select 1;
            breakTo "main";
        };
    } forEach _basicWeapons;
    _weaponName;
};

private _container = _this select 0;

private _weaponNames = weaponCargo _container;
private _magazineNames = magazineCargo _container;
private _itemNames = itemCargo _container;
private _backpackNames = [];
{
    _backpackNames pushBack (_x call BIS_fnc_basicBackpack);
} forEach backpackCargo _container;
private _innerContainers = everyContainer _container;
{
    _weaponNames = _weaponNames + weaponCargo (_x select 1);
    _magazineNames = _magazineNames + magazineCargo (_x select 1);
    _itemNames = _itemNames + itemCargo (_x select 1);
    {
        {
            if (count _x > 0) then {
                if (typeName _x == "ARRAY") then {
                    _magazineNames pushBack (_x select 0);
                } else {
                    _itemNames pushBack _x;
                }
            };
        } forEach (_x select [1, (count _x) -1]);
    } forEach weaponsItemsCargo (_x select 1);
} forEach _innerContainers;

{
    {
        if (count _x > 0) then {
            if (typeName _x == "ARRAY") then {
                _magazineNames pushBack (_x select 0);
            } else {
                _itemNames pushBack _x;
            }
        };
    } forEach (_x select [1, (count _x) -1]);
} forEach weaponsItemsCargo _container;
private _cargo = [];
private _cargoItemNumber = 1;
{
    _cargo pushBack [[_x] call fn_getWeaponNoAttachments, _cargoItemNumber, "w"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _weaponNames;
{
    _cargo pushBack [_x, _cargoItemNumber, "i"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _itemNames;
{
    _cargo pushBack [_x, _cargoItemNumber, "b"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _backpackNames;
{
    _cargo pushBack [_x, _cargoItemNumber, "m"];
    _cargoItemNumber = _cargoItemNumber + 1;
} forEach _magazineNames;
_cargo;