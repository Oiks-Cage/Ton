
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameObject.sol";

contract basePage is gameObject {

    modifier chekOwnerNo () {
        for (uint i = 0; i < base.length; i++) {
            require(baseAndOwner[i] != msg.pubkey());
        }
        tvm.accept();
        _;
    }

    modifier chekOwnerYes (uint unitId) {
        require(unitsAndOwner[unitId] == msg.pubkey());
        tvm.accept();
        _;
    }

    function createDefensPower (uint defens) chekOwnerNo external {
        base.push(defens);
        baseAndOwner[base.length-1] = msg.pubkey();
    }

    function baseDeth (uint baseId) public {
        for (uint i = 0; i < allUnits.length; i++) {
            if (unitsAndOwner[i] == baseAndOwner[baseId]){
                unitDeth(i);
            }
        }

        delete baseAndOwner[baseId];
	    for (uint i=baseId; i < base.length; i++) {
	        baseAndOwner[i] = baseAndOwner[i+1];
	    }
        delete baseAndOwner[base.length+1];

        delete base[baseId];
	    for (uint i=baseId; i < base.length; i++) {
	        base[i] = base[i+1];
	    }
        delete base[base.length+1];
    }

    function delitBase (uint baseId) chekOwnerYes (baseId) external{
        baseDeth(baseId);
    }

    function unitDeth (uint unitId) virtual public override{
        delete unitsAndOwner[unitId];
	    for (uint i=unitId; i < allUnits.length; i++) {
	        unitsAndOwner[i] = unitsAndOwner[i+1];
	    }
        delete unitsAndOwner[allUnits.length+1];

        delete allUnits[unitId];
	    for (uint i=unitId; i < allUnits.length; i++) {
	        allUnits[i] = allUnits[i+1];
	    }
        delete allUnits[allUnits.length+1];
    }

    function delitUnit (uint unitId) chekOwnerYes (unitId) virtual external override{
        unitDeth(unitId);
    }

    

}