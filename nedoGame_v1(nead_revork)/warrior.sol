
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "warriorUnit.sol";

contract warrior is warriorUnit {
    function createWarrior (uint health, uint power) virtual external {
        allUnits.push(units(false, health, power));
        unitsAndOwner[allUnits.length-1] = msg.pubkey();
    }
}