
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "warriorUnit.sol";

contract archer is warriorUnit {
    function createArcher (uint health, uint power) virtual external {
        allUnits.push(units(true, health, power));
        unitsAndOwner[allUnits.length-1] = msg.pubkey();
    }
}