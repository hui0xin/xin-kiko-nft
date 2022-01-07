//! new-transaction
//! account: kiko, 0x69F1E543A3BeF043B63BEd825fcd2cf6, 1000000000 0x1::STC::STC
//! sender: kiko
address kiko = {{kiko}};
script {
    use 0x69F1E543A3BeF043B63BEd825fcd2cf6::KikoCatElement04;

    fun init(sender: signer) {
        KikoCatElement04::init_with_image(sender, b"kiko cat", b"www.baidu.com", b"this is a cat");
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    //    use 0x1::Debug;
    use 0x69F1E543A3BeF043B63BEd825fcd2cf6::KikoCatElement04;

    fun mint(sender: signer) {
        KikoCatElement04::mint_with_image(sender,
            b"kiko cat", b"www.baidu.com", b"this is a cat", b"background",
            1, b"Bored", 1
        );
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    //    use 0x1::Debug;
    use 0x69F1E543A3BeF043B63BEd825fcd2cf6::KikoCatCard03;

    fun mint(sender: signer) {
        KikoCatCard03::init_with_image(sender, b"kiko cat", b"www.baidu.com", b"this is a cat");
    }
}
// check: EXECUTED

//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    //    use 0x1::Debug;
    use 0x69F1E543A3BeF043B63BEd825fcd2cf6::KikoCatCard03;

    fun mint(sender: signer) {
        KikoCatCard03::composite_custom_card(sender,
            b"kiko cat", b"www.baidu.com", b"this is a cat", b"miner", b"test1",
            1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        );

    }
}
// check: EXECUTED



//! new-transaction
//! sender: kiko
address kiko = {{kiko}};
script {
    //    use 0x1::Debug;
    use 0x69F1E543A3BeF043B63BEd825fcd2cf6::KikoCatCard03;

    fun mint(sender: signer) {
        KikoCatCard03::resolve_card(sender, 1);
    }
}
// check: EXECUTED
