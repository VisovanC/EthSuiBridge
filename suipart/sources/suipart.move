module suipart::suipart {
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option;

    public struct SUIPART has drop {}

    fun init(witness: SUIPART, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<SUIPART>(
            witness,
            18,
            b"NDR",
            b"Inter-Blockchain Token",
            b"",
            option::none(),
            ctx
        );
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        transfer::public_transfer(metadata, tx_context::sender(ctx));
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<SUIPART>, 
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient);
    }
}