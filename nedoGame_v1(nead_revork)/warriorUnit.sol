
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "basePage.sol";

contract warriorUnit is basePage {

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