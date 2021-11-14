pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader time;
pragma AbiHeader pubkey;

import "../base/Terminal.sol";
import "../base/Menu.sol";

import "purchase.sol";
import "listInitializationDebot.sol";

contract basicMethodsDebot is listInitializationDebot {

    function _menu() virtual internal override {
        string sep = '----------------------------------------';
        Menu.select(
            format("You have {} unpaid and {} paid purchases in total of {}",
                summary.incompletedPurchases, summary.completedPurchases, summary.totalPurchases),
            sep,
            [
                MenuItem("Show purchases list","",tvm.functionId(showPurchases)),
                MenuItem("Delete purchase","",tvm.functionId(deletePurchase))
            ]
        );
    }

    function showPurchases(uint32 index) public view {
        optional(uint256) none;
        purchase(m_address).getShoppList{
            abiVer: 2,
            extMsg: true,
            sign: false,
            pubkey: none,
            time: uint64(now),
            expire: 0,
            callbackId: tvm.functionId(showPurchases_),
            onErrorId: 0
        }();
    }

    function showPurchases_( purchase[] shoppList ) public {

        if (count > 0 ) {
            Terminal.print(0, "Your shopping list:");

            for (uint32 i = 1; i < count; i++) {
                
                if (purchase.buyed) {
                    Terminal.print(0, format("Id: {}, Name: {}, Amount: {}, Created at time: {}, Price: {}.",
                        purchase.id, purchase.name, purchase.amount, purchase.createdAt, purchase.price;));
                } else {
                    Terminal.print(0, format("Id: {}, Name: {}, Amount: {}, Created at time: {}, Not bought.",
                        purchase.id, purchase.name, purchase.amount, purchase.createdAt));
                }
            }

        } else {
            Terminal.print(0, "You have not added any items yet");
        }

        _menu();
    } 

    function deletePurchase(uint32 index) public {
        if ((summary.totalPrice) {
            Terminal.input(tvm.functionId(deletePurchase_), "Enter item id", false);
        } else {
            Terminal.print(0, "You have not added any items yet");
            _menu();
        }
    }

    function deletePurchase_(string value) public view {
        (uint256 id, bool status) = stoi(value);
        optional(uint256) pubkey = 0;
        purchase(m_address).deletePurchase{
                abiVer: 2,
                extMsg: true,
                sign: true,
                pubkey: pubkey,
                time: uint64(now),
                expire: 0,
                callbackId: tvm.functionId(onSuccess),
                onErrorId: tvm.functionId(onError)
            }(uint(id));
    }
}