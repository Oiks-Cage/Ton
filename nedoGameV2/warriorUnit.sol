pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract warriorUnit {

    struct Units {
        uint unitNumber;
        string specification;
        int helth;
        uint power;
        address unitAddress;
    }

    Units[] nomberAndUnit;


    constructor() public {
        tvm.accept();
    }

    function regUnit (uint unitNumber, string _specification, int _helth, uint _power) public{
        nomberAndUnit.push(Units(unitNumber, _specification, _helth, _power, msg.sender));
    }

    function unitDeth (address _unitAddress) public{
        tvm.accept();
        uint _n;
        for (uint i = 0; i < nomberAndUnit.length; i++){
	        if(nomberAndUnit[i].unitAddress == _unitAddress){
                delete nomberAndUnit[i];
            }
        } 
    }


    function getNomberAndUnitAndBasePowerAndSigner () public returns (Units[] _nomberAndUnit) {
        tvm.accept();
        _nomberAndUnit = nomberAndUnit;
    }
    
}
