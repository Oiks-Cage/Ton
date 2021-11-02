
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "basePage.sol";

contract warrior {

    int public helth;
    uint public power;  
    
    uint static public unitNumber;

    constructor(int _helth, uint _power, basePage date) public {
        tvm.accept();
        helth = _helth;
        power = _power;
        //sendWarriorToBase(date);
    }

    /*function sendWarriorToBase (basePage date) public {
        date.regUnit(unitNumber, "Warrior", helth, power);
    }*/

    function minus5Helth (int damage) public {
        tvm.accept();
        helth = helth - damage;
    }
}
