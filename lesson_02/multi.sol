
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract multi {
    
	uint public multiplecation = 1;

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
	
	function add(uint value) public checkOwnerAndAccept {
        require(value > 0);
        require(value < 11);
		multiplecation *= value;
	}
}