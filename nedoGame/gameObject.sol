pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract gameObject {

    struct warriorUnit {
        int helth;
        uint power;
        address unitAddress;
    }
    struct archerUnit {
        int helth;
        uint power;
        address unitAddress;
    }

    mapping (uint=>warriorUnit) nomberAndWarriorUnit;
    mapping (uint=>archerUnit) nomberAndArcherUnit;
    mapping (int=>address) baseHealthAndBaseAddres;

    constructor() public {
        tvm.accept();
    }

    function regUnit (uint unitNumber, string _specification, int _helth, uint _power) public{
        if (_specification == "Archer"){
            nomberAndArcherUnit[unitNumber] = archerUnit(_helth, _power, msg.sender);
        }
        if (_specification == "Warrior"){
            nomberAndWarriorUnit[unitNumber] = warriorUnit(_helth, _power, msg.sender);
        }
    }

    function regBase (int _baseHelth) public{
        baseHealthAndBaseAddres[_baseHelth] = msg.sender;
    }


    function getNomberAndUnitAndBasePowerAndSigner () public returns (mapping (int=>address) _baseHealthAndBaseAddres, mapping (uint=>warriorUnit) _nomberAndWarriorUnit, mapping (uint=>archerUnit) _nomberAndArcherUnit) {
        tvm.accept();
        _baseHealthAndBaseAddres = baseHealthAndBaseAddres;
        _nomberAndWarriorUnit = nomberAndWarriorUnit;
        _nomberAndArcherUnit = nomberAndArcherUnit;
    }


}