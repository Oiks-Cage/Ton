pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract SampleToken {
   
    struct animal {
        string name;
        uint maxAge;
        string class;
        bool inRebBook;    
    }

    animal[] animalsArr;
    mapping (uint => uint) animalAndOwner;
    mapping (uint => uint) animalsPrice;

    modifier chekAnimalsOwner (uint animalId) {
        require(animalAndOwner[animalId] == msg.pubkey());
        tvm.accept();   
        _;
    }

    modifier chekAnimalsName (string name) {
        for (uint256 i = 0; i < animalsArr.length; i++) {
            require(animalsArr[i].name != name);
        }
        tvm.accept();
        _;
    }

    function createAnimals (string name, uint maxAge, string class, bool inRedBook) public chekAnimalsName(name) {
        animalsArr.push(animal(name, maxAge, class, inRedBook));
        uint lastNome = animalsArr.length -1;
        animalAndOwner[lastNome] = msg.pubkey();
    }

    function createAnimalPrice (uint animalId, uint animalPrice) public chekAnimalsOwner(animalId){
        animalsPrice[animalId] = animalPrice;
    }

    function getAnimalPrice (uint animalId) public returns (uint price){
        price = animalsPrice[animalId];
    }

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

    }

}
