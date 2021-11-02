pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract test {

    struct units {
        string unitSkill;       //0-warrior, 1-archer
        uint unitHealth;
        uint unitPower;    
    }
    uint x;
    uint[] base;
    units[] allUnits;

    mapping (uint=>uint) baseAndOwner;
    mapping (uint=>uint) unitsAndOwner;

    function getPowerDefens () public returns(uint baseWithoutMy) {
        tvm.accept();
        uint[] baseWithoutMy;
        for (uint i = 0; i < base.length; i++) {
            if(baseAndOwner[i] != msg.pubkey()){
                baseWithoutMy.push(base[i]);
            }
        }
    }

    function getUnitPower (uint i) public returns(uint ownerBase, uint allOwnerUnits) {
        tvm.accept();
        ownerBase = base[i];
        units[] allOwnerUnits;
        for (uint j = 0; j < allUnits.length; j++) {
            if (baseAndOwner[i] == unitsAndOwner[j]){
                allOwnerUnits.push(allUnits[j]);
            }
        }
    }

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

    function createDefensPower (uint defens) chekOwnerNo public {
        base.push(defens);
        baseAndOwner[base.length-1] = msg.pubkey();
    }

    function baseDeth (uint baseId) public {
        tvm.accept();
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

    function delitBase (uint baseId) chekOwnerYes (baseId) public{
        tvm.accept();
        baseDeth(baseId);
    }

    function unitDeth (uint unitId) public{
        tvm.accept();
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

    function delitUnit (uint unitId) chekOwnerYes (unitId) public{
        unitDeth(unitId);
    }

    function createWarrior (uint health, uint power) public {
        tvm.accept();
        allUnits.push(units("warrior", health, power));
        unitsAndOwner[allUnits.length-1] = msg.pubkey();
    }

    function createArcher (uint health, uint power) public {
        tvm.accept();
        allUnits.push(units("archer", health, power));
        unitsAndOwner[allUnits.length-1] = msg.pubkey();
    }

    function getAllUnits () public returns(units[]){
        tvm.accept();
        return (allUnits);
    }

    function getUnitsAndOwner () public returns(mapping(uint=>uint)){
        tvm.accept();
        return (unitsAndOwner);
    }

}