
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "warriorUnit.sol";
import "gameInterface.sol";

contract warrior is warriorUnit, gameInterface {

    int helth;
    int power;
    address allWarriorUnitAddress;

    constructor(address _address) public {
        helth = 10;
        power = 4;
        allWarriorUnitAddress = _address;
        warriorUnit(allWarriorUnitAddress).regUnit(helth, power);
    }

    function getAttack (int damage) external override{
        tvm.accept();
        helth = helth - damage;
        if (helth <= 0) {
            warriorUnit(allWarriorUnitAddress).delitUnit();
            msg.sender.transfer(1, true, 128 + 32);
        }
        else {
            warriorUnit(allWarriorUnitAddress).regUnit(helth, power);
            attack(msg.sender);
        }
    }

    function attack (address target) internal {
        tvm.accept();
        gameInterface(target).getAttack(power);
    }

    function getInf () public {
        tvm.accept();
        warriorUnit(allWarriorUnitAddress).getInfo();
    }
    
}