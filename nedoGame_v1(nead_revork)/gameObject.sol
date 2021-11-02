
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "gameObjectInterface.sol";

contract gameObject is gameObjectInterface {

    struct units {
        bool unitSkill;       //0-warrior, 1-archer
        uint unitHealth;
        uint unitPower;    
    }
    uint x;
    uint[] base;
    units[] allUnits;

    mapping (uint=>uint) baseAndOwner;
    mapping (uint=>uint) unitsAndOwner;
/*
    function getPowerDefens () virtual public override returns(uint baseWithoutMy) {
        uint[] baseWithoutMy;
        for (uint i = 0; i < base.length; i++) {
            if(baseAndOwner[i] != msg.pubkey()){
                baseWithoutMy.push(base[i]);
            }
        }
    }

    function getUnitPower (uint i) public returns (uint ownerBase, uint allOwnerUnits) {
        ownerBase = base[i];
        units[] allOwnerUnits;
        for (uint j = 0; j < allUnits.length; j++) {
            if (baseAndOwner[i] == unitsAndOwner[j]){
                allOwnerUnits.push(allUnits[j]);
            }
        }
    }
*/
/*    function acceptAttack () external {

    }

    function checkDeth () private {

    }

    function dethWork () private {

    }

    function sendMoneyAndDelete () private {

    }*/

    function chekWork (uint value) virtual public override {
        tvm.accept();
        x = value;
    }

}