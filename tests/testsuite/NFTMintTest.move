//! new-transaction
//! account: kiko, 0x111, 1000000000 0x1::STC::STC
//! sender: kiko
address kiko = {{kiko}};
script {
    use 0x111::KikoCat01;

    fun mint_nft(sender: signer) {
        KikoCat01::f_init_with_image(&sender, b"kiko cat", b"www.baidu.com", b"this is a cat");
        KikoCat01::f_mint_with_image(&sender, b"kiko cat", b"www.baidu.com", b"this is a cat", b"Red", b"Gray", b"Blue Sky",
            b"Bored", b"Banana", b"Mask", b"Glasses",
        );
        KikoCat01::f_mint_with_image_data(&sender, b"kiko cat", b"abcdefg", b"this is a cat", b"Red", b"Gray", b"Blue Sky",
            b"Bored", b"Banana", b"Mask", b"Glasses",
        );
        KikoCat01::f_open_box(&sender);
    }
}
// check: EXECUTED

//! new-transaction
//! account: platform, 0x222
//! sender: platform
address platform = {{platform}};
script {
    use 0x1::Account;
    use 0x111::KikoCat01::{KikoCatBox};

    fun accept_token(sender: signer) {
        Account::accept_token<KikoCatBox>(sender);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    use 0x1::Account;
//    use 0x1::Debug;
    use 0x111::KikoCat01::{KikoCatBox};

    fun transfer(sender: signer) {
//        Debug::print<u128>(&Account::balance<KikoCatBox>(@kiko));
        Account::pay_from<KikoCatBox>(&sender, @0x222, 1);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: platform
address platform = {{platform}};
script {
    use 0x1::STC::STC;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody, KikoCatBox};
    use 0x222::NFTMarket;

    const DECIMAL: u128 = 1000000000;

    fun box_initial_offering(sender: signer) {
        NFTMarket::box_initial_offering<KikoCatMeta, KikoCatBody, KikoCatBox, STC>(&sender, 1, 10 * DECIMAL, 0, @platform);
    }
}
// check: EXECUTED

//! new-transaction
//! account: alice, 10000000000 0x1::STC::STC
//! sender: alice
address alice = {{alice}};
script {
    use 0x1::STC::STC;
    use 0x111::KikoCat01::{Self, KikoCatBox};
    use 0x222::NFTMarket;

    fun box_initial_offering(sender: signer) {
        NFTMarket::box_buy_from_offering<KikoCatBox, STC>(&sender, 1);
        KikoCat01::f_open_box(&sender);
    }
}
// check: EXECUTED
