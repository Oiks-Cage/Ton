
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameObject.sol";

contract basePage {

    int baseHelth;

    constructor(int _baseHelth, gameObject date) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        baseHelth = _baseHelth;
        sendBaserToObject(date);
    }

    function sendBaserToObject (gameObject date) public {
        date.regBase(baseHelth);
    }

}
