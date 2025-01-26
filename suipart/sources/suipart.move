module suipart::suipart {
    use sui::coin;
    public struct SUIPART has drop {}
    public struct NDR has drop {}

    fun init(witness: SUIPART, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency<SUIPART>(
            witness,
            18,
            b"NDR",
            b"Inter-Blockchain Token",
            b"",
            option::none(),
            ctx
        );
        transfer::public_transfer(treasury, tx_context::sender(ctx));
        transfer::public_transfer(metadata, tx_context::sender(ctx));
    }

    public entry fun mint(
        treasury_cap: &mut coin::TreasuryCap<NDR>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let coins = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coins, recipient);
    }

    public entry fun burn(
        treasury_cap: &mut coin::TreasuryCap<NDR>,
        coins: coin::Coin<NDR>,
        _ctx: &mut TxContext
    ) {
        coin::burn(treasury_cap, coins);
    }
}
