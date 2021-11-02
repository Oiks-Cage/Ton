
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "warriorUnit.sol";

contract archer {

    int public helth;
    uint public power;

    uint static public unitNumber;

    constructor(int _helth, uint _power, warriorUnit date) public {
        tvm.accept();
        helth = _helth;
        power = _power;
        sendArcer(date);
    }

    function sendArcer (warriorUnit date) public {
        date.regUnit(unitNumber, "Archer", helth, power);
    }

}