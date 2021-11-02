
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameObject.sol";

contract warrior {

    int public helth;
    uint public power;  
    
    uint static public unitNumber;

    constructor(int _helth, uint _power, gameObject date) public {
        tvm.accept();
        helth = _helth;
        power = _power;
        sendWarriorToObject(date);
    }

    function sendWarriorToObject (gameObject date) public {
        date.regUnit(unitNumber, "Warrior", helth, power);
    }

}


//gameObject -a:  0:1b5c8809385e199700758e9c816fd5ec23add1512c686541b0d2df24f4ae8fac

//warrior -a:  0:aef8c088aaf8b961704cac7c304cc7b7ded6bd46c2966331057978de35dd82c3
//archer -a:  0:155d07a0326c730cac6b501690316976724f429f655eebd9445b6bb262a65f8a