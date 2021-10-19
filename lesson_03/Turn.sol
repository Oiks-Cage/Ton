
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Turn {
    
	string[] storeTurn;

	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}
	
	function goToTurn(string name) public checkOwnerAndAccept {
       storeTurn.push(name);
	}

    function goNext() public checkOwnerAndAccept {
       delete storeTurn[0];
	   for (uint256 i = 1; i < storeTurn.length; i++) {
		   storeTurn[i-1] = storeTurn[i];
	   }
	   storeTurn.pop();
	}

}