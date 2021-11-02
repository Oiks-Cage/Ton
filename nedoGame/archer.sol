
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameObject.sol";

contract archer {

    int public helth;
    uint public power;

    uint static public unitNumber;

    constructor(int _helth, uint _power, gameObject date) public {
        tvm.accept();
        helth = _helth;
        power = _power;
        sendArcerToObject(date);
    }

    function sendArcerToObject (gameObject date) public {
        date.regUnit(unitNumber, "Archer", helth, power);
    }

}