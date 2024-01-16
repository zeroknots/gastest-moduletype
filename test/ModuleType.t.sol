import "src/ModuleType.sol";

import "forge-std/Test.sol";

contract ModuleTypeTest is Test {
    using ModuleTypeLib for *;

    Module module;

    ModuleType[] typesArray;

    function setUp() public {
        typesArray = new ModuleType[](4);
        typesArray[0] = ModuleType.wrap(1);
        typesArray[1] = ModuleType.wrap(2);
        typesArray[2] = ModuleType.wrap(3);
        typesArray[3] = ModuleType.wrap(4);
        module = new Module(typesArray);
    }

    function test_encoding() public {
        ModuleTypesEnc encoded = typesArray.bitEncode();
        console2.log(ModuleTypesEnc.unwrap(encoded));
    }

    function test_array() public {
        uint256 _gas = gasleft();
        // check if module is of type 3;
        uint256[] memory types = module.getModuleTypesArray();
        uint256 length = types.length;
        bool isType = false;
        for (uint256 i; i < length; i++) {
            if (types[i] == 6) {
                isType = true;
                break;
            }
        }
        _gas = _gas - gasleft();
        console2.log("array", isType, _gas);
    }

    function test_value() public {
        uint256 _gas = gasleft();
        ModuleTypesEnc types = module.getModuleTypes();
        bool isType = types.isType(ModuleType.wrap(3));
        _gas = _gas - gasleft();
        console2.log("value", isType, _gas);
    }
}
