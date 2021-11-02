
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "warriorUnit.sol";

contract warrior {

    int public helth;
    uint public power;  
    
    uint static public unitNumber;

    constructor(int _helth, uint _power, warriorUnit date) public {
        tvm.accept();
        helth = _helth;
        power = _power;
        sendWarrior(date);
    }

    function sendWarrior (warriorUnit date) public {
        date.regUnit(unitNumber, "Warrior", helth, power);
    }

}