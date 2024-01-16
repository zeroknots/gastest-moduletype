// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

type ModuleTypesEnc is uint256;

type ModuleType is uint256;

contract Module {
    ModuleTypesEnc public immutable MODULE_TYPES;

    constructor(ModuleType[] memory moduleTypes) {
        MODULE_TYPES = ModuleTypeLib.bitEncode(moduleTypes);
    }

    function isModuleType(ModuleType _isModuleType) public view returns (bool) {
        return ModuleTypeLib.isType(MODULE_TYPES, _isModuleType);
    }

    function getModuleTypesArray() public pure returns (uint256[] memory moduleTypes) {
        moduleTypes = new uint256[](5);
        moduleTypes[0] = 1;
        moduleTypes[1] = 2;
        moduleTypes[2] = 3;
        moduleTypes[3] = 4;
    }

    function getModuleTypes() public view returns (ModuleTypesEnc) {
        return MODULE_TYPES;
    }
}

library ModuleTypeLib {
    function isType(ModuleTypesEnc self, ModuleType moduleType) internal pure returns (bool) {
        return (ModuleTypesEnc.unwrap(self) & 2 ** ModuleType.unwrap(moduleType)) != 0;
    }

    function bitEncode(ModuleType[] memory moduleTypes) internal pure returns (ModuleTypesEnc) {
        uint256 result;
        for (uint256 i; i < moduleTypes.length; i++) {
            result = result + uint256(2 ** ModuleType.unwrap(moduleTypes[i]));
        }
        return ModuleTypesEnc.wrap(result);
    }

    function bitEncodeCalldata(ModuleType[] calldata moduleTypes) internal pure returns (ModuleTypesEnc) {
        uint256 result;
        for (uint256 i; i < moduleTypes.length; i++) {
            result = result + uint256(2 ** ModuleType.unwrap(moduleTypes[i]));
        }
        return ModuleTypesEnc.wrap(result);
    }
}
