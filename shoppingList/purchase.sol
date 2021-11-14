pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

struct purchase {
    uint32 id;
    string name;
    uint32 amount;
    uint64 createdAt;
    bool buyed;
    uint price;
}

struct Summary {
    uint32 completedPurchases;
    uint32 incompletedPurchases;
    uint totalPurchases;
}

interface shoppingList {
    function getShoppList() external returns(mapping (uint=>purchase));
    function getSummary() external returns(Summary);
    function addPurchase(string name, uint32 amount) external;
    function deletePurchase(uint32 id) external;
    function buyPurchase(uint32 id, uint price) external;
}

interface Transactable {
   function sendTransaction(address dest, uint128 value, bool bounce, uint8 flags, TvmCell payload) external;
}


abstract contract HasConstructorWithPubKey {
constructor(uint256 pubkey) public {}
}