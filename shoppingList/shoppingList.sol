pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'purchase.sol';

contract sgoppingList {

    uint256 ownerPubkey;
    uint32 count;

    constructor( uint256 pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        ownerPubkey = pubkey;
    }

    modifier onlyOwner() {
        require(msg.pubkey() == ownerPubkey, 101);
        _;
    }
    
    mapping (uint=>purchase) shoppList;
    Summary summary;

    function getShoppList() public onlyOwner returns(mapping (uint=>purchase)){
        tvm.accept();
        return shoppList;
    }

    function getSummary() public onlyOwner returns(Summary){
        tvm.accept();
        return summary;
    }

    function addPurchase(string name, uint32 amount) public onlyOwner {
        tvm.accept();
        count++;
        shoppList[count] = purchase(count, name, amount, now, false, 0);
        summary.incompletedPurchases += amount;
        summary.totalPurchases += amount;
    }

    function deletePurchase (uint32 id) public onlyOwner {
        require(shoppList.exists(id), 102);
        tvm.accept();
        summary.totalPurchases -= shoppList[id].amount;
        if (shoppList[id].buyed == false) {
            summary.incompletedPurchases -= shoppList[id].amount;
        }
        else {
            summary.completedPurchases -= shoppList[id].amount;
        }
        delete shoppList[id];
        for (uint256 i = id; i < count; i++) {
            shoppList[i+1].id = shoppList[i+1].id -1;
            shoppList[i] = shoppList[i+1];
        }
       delete shoppList[count];
       count--;
    }

    function buyPurchase (uint32 id, uint price) public onlyOwner {
        require(shoppList.exists(id), 102);
        tvm.accept();
        purchase m_shoppList = shoppList[id];
        shoppList[id] = purchase(m_shoppList.id, m_shoppList.name, m_shoppList.amount, m_shoppList.createdAt, true, price);
        summary.incompletedPurchases -= shoppList[id].amount;
        summary.completedPurchases += shoppList[id].amount;
    }
    
}