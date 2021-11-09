pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract warriorUnit {

    struct unit{
        int helth;
        int power;
    }

    mapping (address=>unit) unitAndOwner;

    constructor() public {
        tvm.accept();
    }

    function regUnit (int helth, int power) virtual external {
        unitAndOwner[msg.sender] = unit(helth, power);
    }

    function delitUnit () virtual external {
        delete unitAndOwner[msg.sender];
    }
    
    function getInfo() external virtual returns (mapping (address=>unit) _unitAndOwner){
        _unitAndOwner = unitAndOwner;
    }

}
