//! new-transaction
//! account: kiko, 0x111
//! sender: kiko
address kiko = {{kiko}};
script {
    use 0x111::KikoCat01;

    fun mint_nft(sender: signer) {
        KikoCat01::f_init_with_image(&sender, b"kiko cat", b"www.baidu.com", b"this is a cat");
        KikoCat01::f_mint_with_image(&sender, b"kiko cat", b"www.baidu.com", b"this is a cat", b"Red", b"Gray", b"Blue Sky",
            b"Bored", b"Banana", b"Mask", b"Glasses",
        );
        KikoCat01::f_mint_with_image(&sender, b"kiko cat", b"www.baidu.com", b"this is a cat", b"Red", b"Gray", b"Blue Sky",
            b"Bored", b"Banana", b"Mask", b"Glasses",
        );
        KikoCat01::f_mint_with_image(&sender, b"kiko cat", b"www.baidu.com", b"this is a cat", b"Red", b"Gray", b"Blue Sky",
            b"Bored", b"Banana", b"Mask", b"Glasses",
        );
        KikoCat01::f_open_box(&sender);
        KikoCat01::f_open_box(&sender);
        KikoCat01::f_open_box(&sender);
    }
}
// check: EXECUTED

//! new-transaction
//! account: maket, 0x222
//! sender: maket
address maket = {{maket}};
script {
    use 0x1::STC::STC;
    use 0x222::NFTMarket;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody, KikoCatBox};

    fun init_config(sender: signer) {
        NFTMarket::init_config(&sender, 1, 1);
        NFTMarket::update_config(&sender, 10, 10);
        NFTMarket::init_market<KikoCatMeta, KikoCatBody, KikoCatBox, STC>(&sender, @0x111);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    use 0x1::STC::STC;
    use 0x222::NFTMarket;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    const MULTIPLE: u128 = 1000000000;

    fun nft_sell(sender: signer) {
        //Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
        NFTMarket::nft_sell<KikoCatMeta, KikoCatBody, STC>(&sender, 1, 2 * MULTIPLE);
        NFTMarket::nft_offline<KikoCatMeta, KikoCatBody, STC>(&sender, 1);
        NFTMarket::nft_sell<KikoCatMeta, KikoCatBody, STC>(&sender, 1, 1 * MULTIPLE);
        NFTMarket::nft_change_price<KikoCatMeta, KikoCatBody, STC>(&sender, 1, 3 * MULTIPLE);
        NFTMarket::nft_sell<KikoCatMeta, KikoCatBody, STC>(&sender, 2, 2 * MULTIPLE);
        NFTMarket::nft_sell<KikoCatMeta, KikoCatBody, STC>(&sender, 3, 2 * MULTIPLE);
    }
}
// check: EXECUTED

//! new-transaction
//! account: tom, 2000000000 0x1::STC::STC
//! sender: tom
address tom = {{tom}};
script {
    use 0x1::Account;
    use 0x1::Debug;
    use 0x1::STC::STC;
    use 0x333::NFTScripts;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    const MULTIPLE: u128 = 1000000000;

    fun nft_bid(sender: signer) {
        NFTScripts::nft_bid<KikoCatMeta, KikoCatBody, STC>(sender, 1, 2 * MULTIPLE);
        let balance_stc = Account::balance<STC>(@tom);
        Debug::print<u128>( & balance_stc);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    use 0x1::Account;
    use 0x1::Debug;
    use 0x1::STC::STC;
    use 0x333::NFTScripts;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    fun nft_accept_bid(sender: signer) {
        //Dummy::mint_token<ETH>(&sender, 1 * MULTIPLE);
        NFTScripts::nft_accept_bid<KikoCatMeta, KikoCatBody, STC>(sender, 1);

        let balance_stc = Account::balance<STC>(@kiko);
        Debug::print<u128>( & balance_stc);
    }
}
// check: EXECUTED

//! new-transaction
//! sender: tom
address tom = {{tom}};
script {
    use 0x1::Debug;
    use 0x1::Signer;
    use 0x1::NFT::NFTInfo;
    use 0x1::NFTGallery;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    const MULTIPLE: u128 = 1000000000;

    fun nft_info(sender: signer) {
        Debug::print<vector<NFTInfo<KikoCatMeta>>>(&NFTGallery::get_nft_infos<KikoCatMeta, KikoCatBody>(Signer::address_of(&sender)));
    }
}
// check: EXECUTED

//! new-transaction
//! account: alise, 3000000000 0x1::STC::STC
//! sender: alise
address alise = {{alise}};
script {
    use 0x1::Account;
    use 0x1::Debug;
    use 0x1::Signer;
    use 0x1::STC::STC;
    use 0x1::NFT::NFTInfo;
    use 0x1::NFTGallery;
    use 0x222::NFTMarket;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    const MULTIPLE: u128 = 1000000000;

    fun nft_bid(sender: signer) {
        NFTMarket::nft_bid<KikoCatMeta, KikoCatBody, STC>(&sender, 2, 2 * MULTIPLE);
        let balance_stc = Account::balance<STC>(@alise);
        Debug::print<u128>(&balance_stc);
        Debug::print<vector<NFTInfo<KikoCatMeta>>>(&NFTGallery::get_nft_infos<KikoCatMeta, KikoCatBody>(Signer::address_of(&sender)));
    }
}

// check: EXECUTED
//! new-transaction
//! account: bob, 3000000000 0x1::STC::STC
//! sender: bob
address bob = {{bob}};
script {
    use 0x1::Account;
    use 0x1::Debug;
    use 0x1::STC::STC;
    use 0x333::NFTScripts;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    const MULTIPLE: u128 = 1000000000;

    fun nft_bid(sender: signer) {
        NFTScripts::nft_bid<KikoCatMeta, KikoCatBody, STC>(sender, 3, 1 * MULTIPLE);
        let balance_stc = Account::balance<STC>(@bob);
        Debug::print<u128>( & balance_stc);
    }
}
// check: EXECUTED

//! new-transaction
//! account: xin, 2000000000 0x1::STC::STC
//! sender: xin
address xin = {{xin}};
script {
    use 0x1::Account;
    use 0x1::Debug;
    use 0x1::Signer;
    use 0x1::STC::STC;
    use 0x1::NFT::NFTInfo;
    use 0x1::NFTGallery;
    use 0x222::NFTMarket;
    use 0x111::KikoCat01::{KikoCatMeta, KikoCatBody};

    fun nft_buy(sender: signer) {
        NFTMarket::nft_buy<KikoCatMeta, KikoCatBody, STC>(&sender, 3);
        let balance_stc = Account::balance<STC>(@xin);
        Debug::print<u128>( & balance_stc);
        Debug::print<vector<NFTInfo<KikoCatMeta>>>(&NFTGallery::get_nft_infos<KikoCatMeta, KikoCatBody>(Signer::address_of(&sender)));
    }
}