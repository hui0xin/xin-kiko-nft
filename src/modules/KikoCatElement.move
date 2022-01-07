address 0x69F1E543A3BeF043B63BEd825fcd2cf6 {
module KikoCatElement05 {
    use 0x1::Signer;
    use 0x1::Event;
    use 0x1::Token;
    use 0x1::Account;
    use 0x1::NFT::{Self, NFT};
    use 0x1::NFTGallery;

    const NFT_ADDRESS: address = @0x69F1E543A3BeF043B63BEd825fcd2cf6;

    const PERMISSION_DENIED: u64 = 100001;

    // ******************** NFT ********************
    // NFT extra meta
    struct KikoCatMeta has copy, store, drop {
        type: vector<u8>,
        type_id: u64,
        property: vector<u8>,
        score: u128,
    }

    // NFT body
    struct KikoCatBody has copy, store, drop {}

    // NFT extra type info
    struct KikoCatTypeInfo has copy, store, drop {}

    struct KikoCatNFTCapability has key {
        mint: NFT::MintCapability<KikoCatMeta>,
    }

    // init nft with image data
    fun init_nft(
        sender: &signer,
        metadata: NFT::Metadata,
    ) {
        NFT::register<KikoCatMeta, KikoCatTypeInfo>(sender, KikoCatTypeInfo {}, metadata);
        let mint = NFT::remove_mint_capability<KikoCatMeta>(sender);
        move_to(sender, KikoCatNFTCapability { mint });
    }

    // mint nft
    fun mint_nft(
        sender: &signer,
        metadata: NFT::Metadata,
        type: vector<u8>,
        type_id: u64,
        property: vector<u8>,
        score: u128,
    ) acquires KikoCatNFTCapability, Events {
        let sender_address = Signer::address_of(sender);
        let cap = borrow_global_mut<KikoCatNFTCapability>(sender_address);
        let nft = NFT::mint_with_cap<KikoCatMeta, KikoCatBody, KikoCatTypeInfo>(
            sender_address,
            &mut cap.mint,
            metadata,
            KikoCatMeta {
                type,
                type_id,
                property,
                score,
            },
            KikoCatBody {}
        );
        let events = borrow_global_mut<Events>(sender_address);
        let id = NFT::get_id<KikoCatMeta, KikoCatBody>(&nft);
        NFTGallery::deposit(sender, nft);

        Event::emit_event<NFTMintEvent<KikoCatMeta, KikoCatBody>>(&mut events.nft_mint_events,
            NFTMintEvent {
                creator: sender_address,
                id: id,
            },
        );
    }

    public fun get_type_id(nft: &NFT<KikoCatMeta, KikoCatBody>) : u64 {
        let meta = NFT::get_type_meta<KikoCatMeta, KikoCatBody>(nft);
        return meta.type_id
    }

    public fun get_score(nft: &NFT<KikoCatMeta, KikoCatBody>) : u128 {
        let meta = NFT::get_type_meta<KikoCatMeta, KikoCatBody>(nft);
        return meta.score
    }

    // ******************** NFT Box ********************
    // box
    struct KikoCatBox has copy, drop, store {}

    const PRECISION: u8 = 0;

    struct KikoCatBoxCapability has key, store {
        mint: Token::MintCapability<KikoCatBox>,
        burn: Token::BurnCapability<KikoCatBox>,
    }

    // init box
    fun init_box(sender: &signer) {
        Token::register_token<KikoCatBox>(sender, PRECISION);
        let mint_cap = Token::remove_mint_capability<KikoCatBox>(sender);
        let burn_cap = Token::remove_burn_capability<KikoCatBox>(sender);
        move_to(sender, KikoCatBoxCapability { mint: mint_cap, burn: burn_cap });
    }

    // mint box
    fun mint_box(sender: &signer, amount: u128)
    acquires KikoCatBoxCapability {
        let cap = borrow_global<KikoCatBoxCapability>(NFT_ADDRESS);
        let token = Token::mint_with_capability<KikoCatBox>(&cap.mint, amount);
        Account::deposit_to_self(sender, token);
    }

    fun burn_box(token: Token::Token<KikoCatBox>)
    acquires KikoCatBoxCapability {
        let cap = borrow_global<KikoCatBoxCapability>(NFT_ADDRESS);
        Token::burn_with_capability(&cap.burn, token);
    }

    // ******************** NFT Events ********************
    // kiko gallery
    struct Events has key, store {
        nft_mint_events: Event::EventHandle<NFTMintEvent<KikoCatMeta, KikoCatBody>>,
    }

    // nft mint event
    struct NFTMintEvent<NFTMeta: store + drop, NFTBody: store + drop> has drop, store {
        creator: address,
        id: u64,
    }

    // init kiko gallery
    fun init_events(sender: &signer) {
        if (!exists<Events>(Signer::address_of(sender))) {
            let events = Events {
                nft_mint_events: Event::new_event_handle<NFTMintEvent<KikoCatMeta, KikoCatBody>>(sender),
            };
            move_to(sender, events);
        }
    }

    // ******************** NFT public function ********************

    // init nft and box with image
    public(script) fun init_with_image(
        sender: signer,
        name: vector<u8>,
        image: vector<u8>,
        description: vector<u8>,
    ) {
        assert(Signer::address_of(&sender) == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image(name, image, description);
        init_nft(&sender, metadata);
        init_box(&sender);
        init_events(&sender);
        NFTGallery::accept<KikoCatMeta, KikoCatBody>(&sender);
    }

    // mint NFT and box
    public(script) fun mint_with_image(
        sender: signer,
        name: vector<u8>,
        image: vector<u8>,
        description: vector<u8>,
        type: vector<u8>,
        type_id: u64,
        property: vector<u8>,
        score: u128,
    ) acquires KikoCatNFTCapability, Events {
        let sender_address = Signer::address_of(&sender);
        assert(sender_address == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image(name, image, description);
        mint_nft(&sender,
            metadata,
            type,
            type_id,
            property,
            score,
        );
    }

}
}
