//! account: dummy, 0x2
//! sender:dummy
address dummy = {{dummy}};
module dummy::Dummy {
    use 0x1::Account;
    use 0x1::Token;

    struct ETH has copy, drop, store { }
    struct USDT has copy, drop, store { }

    struct SharedMintCapability<TokenType: store> has key, store {
        cap: Token::MintCapability<TokenType>,
    }

    struct SharedBurnCapability<TokenType> has key {
        cap: Token::BurnCapability<TokenType>,
    }

    public fun initialize<TokenType: store>(account: &signer) {
        Token::register_token<TokenType>(account, 9);
        Account::do_accept_token<TokenType>(account);
        let burn_cap = Token::remove_burn_capability<TokenType>(account);
        move_to(account, SharedBurnCapability<TokenType> { cap: burn_cap });
        let mint_cap = Token::remove_mint_capability<TokenType>(account);
        move_to(account, SharedMintCapability<TokenType> { cap: mint_cap });
    }

    public fun mint_token<TokenType: store>(account: &signer, amount: u128) acquires SharedMintCapability {
        let token = mint<TokenType>(amount);
        Account::deposit_to_self(account, token);
    }

    /// Burn the given token.
    public fun burn<TokenType: store>(token: Token::Token<TokenType>) acquires SharedBurnCapability{
        let cap = borrow_global<SharedBurnCapability<TokenType>>(token_address<TokenType>());
        Token::burn_with_capability(&cap.cap, token);
    }

    public fun mint<TokenType: store>(amount: u128): Token::Token<TokenType> acquires SharedMintCapability {
        let cap = borrow_global<SharedMintCapability<TokenType>>(token_address<TokenType>());
        Token::mint_with_capability<TokenType>(&cap.cap, amount)
    }

    public fun token_address<TokenType: store>(): address {
        Token::token_address<TokenType>()
    }

}
// check: "Keep(EXECUTED)"

//! new-transaction
//! sender: dummy
script {
    use dummy::Dummy::{Self, ETH, USDT};

    const MULTIPLE: u128 = 1000000000;

    fun register_token(sender: signer) {
        Dummy::initialize<ETH>(&sender);
        Dummy::initialize<USDT>(&sender);
    }
}
// check: "Keep(EXECUTED)"

//! new-transaction
//! account: maket, 0x222
//! sender: maket
address maket = {{maket}};
script {
    use 0x333::NFTScripts;
    fun init_config(sender: signer) {
        NFTScripts::init_config(sender, 1 ,1);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: maket
script {
    use dummy::Dummy::{ETH, USDT};
    use 0x222::NFTMarket;
    use 0x111::KikoCat01;

    fun init_box(sender: signer) {
        NFTMarket::init_market<KikoCat01::KikoCatMeta, KikoCat01::KikoCatBody, ETH, USDT>(&sender, @0x11111);
    }
}
// check: "Keep(EXECUTED)"


//! new-transaction
//! account: my, 0x11111
//! sender: my
address my = {{my}};
script {
    use 0x1::Account;
    use dummy::Dummy::{USDT};

    fun accept_token(sender: signer) {
        Account::accept_token<USDT>(sender);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: maket
address maket = {{maket}};
script {
    use 0x1::Account;
    use dummy::Dummy::{USDT};

    fun accept_token(sender: signer) {
        Account::accept_token<USDT>(sender);
    }
}
// check: EXECUTED


//! new-transaction
//! account: kiko, 0x111
//! sender: kiko
address kiko = {{kiko}};
script {
    use dummy::Dummy::{Self, ETH, USDT};
    use 0x222::NFTMarket;

    const MULTIPLE: u128 = 10000;

    fun box_sell(sender: signer) {
        Dummy::mint_token<ETH>(&sender, 5 * MULTIPLE);
        Dummy::mint_token<USDT>(&sender, 20 * MULTIPLE);

        NFTMarket::box_sell<ETH, USDT>(&sender, 2 * MULTIPLE);
        NFTMarket::box_sell<ETH, USDT>(&sender, 5 * MULTIPLE);
        NFTMarket::box_sell<ETH, USDT>(&sender, 9 * MULTIPLE);
        NFTMarket::box_sell<ETH, USDT>(&sender, 1 * MULTIPLE);
    }
}
// check: EXECUTED


//! new-transaction
//! account: alice, 0x66
//! sender: alice
address alice = {{alice}};
script {
    use dummy::Dummy::{Self, ETH, USDT};
    use 0x222::NFTMarket;

    const MULTIPLE: u128 = 10000;

    fun box_buy(sender: signer) {
        Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
        Dummy::mint_token<USDT>(&sender, 20 * MULTIPLE);

        NFTMarket::box_buy<ETH, USDT>(&sender, 1);
    }
}
// check: EXECUTED



//! new-transaction
//! account: bob, 0x77
//! sender: bob
address bob = {{bob}};
script {
    use dummy::Dummy::{Self, ETH, USDT};
    use 0x222::NFTMarket;

    const MULTIPLE: u128 = 10000;

    fun box_bid(sender: signer) {
//        Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
        Dummy::mint_token<USDT>(&sender, 20 * MULTIPLE);

        //        NFTMarket::box_buy<ETH, USDT>(&sender, 2);
        //        NFTMarket::box_buy<ETH, USDT>(&sender, 3);
        //        NFTMarket::box_buy<ETH, USDT>(&sender, 4);
        NFTMarket::box_bid<ETH, USDT>(&sender, 2, 6 * MULTIPLE);
    }
}
// check: EXECUTED


//! new-transaction
//! account: jack, 0x88
//! sender: jack
address bob = {{bob}};
script {
    use dummy::Dummy::{Self, ETH, USDT};
    use 0x222::NFTMarket;

    const MULTIPLE: u128 = 10000;

    fun box_bid(sender: signer) {
        Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
        Dummy::mint_token<USDT>(&sender, 20 * MULTIPLE);

        NFTMarket::box_bid<ETH, USDT>(&sender, 3, 6 * MULTIPLE);
    }
}
// check: EXECUTED



//! new-transaction
//! account: jackma, 0x8888
//! sender: jackma
address bob = {{bob}};
script {
    use dummy::Dummy::{Self, ETH, USDT};
    use 0x222::NFTMarket;

    const MULTIPLE: u128 = 10000;

    fun box_bid(sender: signer) {
        Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
        Dummy::mint_token<USDT>(&sender, 20 * MULTIPLE);

        NFTMarket::box_bid<ETH, USDT>(&sender, 3, 8 * MULTIPLE);
    }
}
// check: EXECUTED


//! new-transaction
//! sender: kiko
address bob = {{bob}};
script {
    use dummy::Dummy::{Self, ETH, USDT};
    use 0x222::NFTMarket;

    const MULTIPLE: u128 = 10000;

    fun box_accept_bid(sender: signer) {
        Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
//        Dummy::mint_token<USDT>(&sender, 20 * MULTIPLE);

        //        NFTMarket::box_buy<ETH, USDT>(&sender, 2);
        //        NFTMarket::box_buy<ETH, USDT>(&sender, 3);
        //        NFTMarket::box_buy<ETH, USDT>(&sender, 4);
        NFTMarket::box_accept_bid<ETH, USDT>(&sender, 3);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    use dummy::Dummy::{ETH, USDT};
    use 0x222::NFTMarket;
    const MULTIPLE: u128 = 10000;

    fun box_bid(sender: signer) {
        NFTMarket::box_change_price<ETH, USDT>(&sender, 4, 2 * MULTIPLE);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    use dummy::Dummy::{ETH, USDT};
    use 0x222::NFTMarket;

    fun box_bid(sender: signer) {
        NFTMarket::box_offline<ETH, USDT>(&sender, 4);
    }
}
// check: EXECUTED