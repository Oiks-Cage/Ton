
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract taskList {
    
	struct task {
        string name;
        uint32 timestamp;
        bool flag;    
    }

    mapping(uint8 => task) public list;

	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

    uint8 public i = 0;

	modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	function add(string name) public checkOwnerAndAccept {
        i++;
        task myMainTask = task (name, now, false);
        list[i] = myMainTask;
	}

    function renderTaskKol () public returns (uint8) {
        tvm.accept();
        return i;
    }

    function renderList () public returns (mapping(uint8 => task)) {
        tvm.accept();
        return list;
    }

    function takeName(uint8 n) public returns (string) {
        tvm.accept();
        task myTask = list[n];
        string myTaskName = myTask.name;
        return myTaskName;
	}

    function delit(uint8 n) public checkOwnerAndAccept {
       delete list[n];
	   for (n; n < i; n++) {
		   list[n] = list[n+1];
	   }
       delete list[i];
	}

    function chek(uint8 n) public checkOwnerAndAccept {
        task myTooTask = list[n];
        list[n] = task(myTooTask.name, myTooTask.timestamp, true);
	}
}