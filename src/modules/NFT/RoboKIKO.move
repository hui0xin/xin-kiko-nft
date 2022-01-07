address 0x8355417c88d969f656935244641256ad {
module RoboKIKO {
    use 0x1::Signer;
    use 0x1::Event;
    use 0x1::Block;
    use 0x1::Vector;
    use 0x1::Token;
    use 0x1::Account;
    use 0x1::NFT::{Self, NFT};
    use 0x1::NFTGallery;

    const NFT_ADDRESS: address = @0x8355417c88d969f656935244641256ad;

    const PERMISSION_DENIED: u64 = 100001;

    // ******************** NFT ********************
    // NFT extra meta
    struct KikoCatMeta has copy, store, drop {
        background: vector<u8>,
        fur: vector<u8>,
        clothes: vector<u8>,
        facial_expression: vector<u8>,
        head: vector<u8>,
        accessories: vector<u8>,
        eyes: vector<u8>,
        hat: vector<u8>,
        costume: vector<u8>,
        makeup: vector<u8>,
        shoes: vector<u8>,
        mouth: vector<u8>,
        earring: vector<u8>,
        necklace: vector<u8>,
        neck: vector<u8>,
        hair: vector<u8>,
        horn: vector<u8>,
        hands: vector<u8>,
        body: vector<u8>,
        skin: vector<u8>,
        tattoo: vector<u8>,
        people: vector<u8>,
        characteristic: vector<u8>,
        hobby: vector<u8>,
        zodiac: vector<u8>,
        action: vector<u8>,
        toys: vector<u8>,
        fruits: vector<u8>,
        vegetables: vector<u8>,
        meat: vector<u8>,
        beverages: vector<u8>,
        food: vector<u8>,
        vehicle: vector<u8>,
        weather: vector<u8>,
        month: vector<u8>,
        sports: vector<u8>,
        music: vector<u8>,
        movies: vector<u8>,
        season: vector<u8>,
        outfit: vector<u8>,
        face: vector<u8>,
        arm: vector<u8>,
        leg: vector<u8>,
        foot: vector<u8>,
        weapon: vector<u8>,
        helmet: vector<u8>,
        armor: vector<u8>,
        mecha: vector<u8>,
        pants: vector<u8>,
        skirt: vector<u8>,
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
        background: vector<u8>,
        fur: vector<u8>,
        clothes: vector<u8>,
        facial_expression: vector<u8>,
        head: vector<u8>,
        accessories: vector<u8>,
        eyes: vector<u8>,
        hat: vector<u8>,
        costume: vector<u8>,
        makeup: vector<u8>,
        shoes: vector<u8>,
        mouth: vector<u8>,
        earring: vector<u8>,
        necklace: vector<u8>,
        neck: vector<u8>,
        hair: vector<u8>,
        horn: vector<u8>,
        hands: vector<u8>,
        body: vector<u8>,
        skin: vector<u8>,
        tattoo: vector<u8>,
        people: vector<u8>,
        characteristic: vector<u8>,
        hobby: vector<u8>,
        zodiac: vector<u8>,
        action: vector<u8>,
        toys: vector<u8>,
        fruits: vector<u8>,
        vegetables: vector<u8>,
        meat: vector<u8>,
        beverages: vector<u8>,
        food: vector<u8>,
        vehicle: vector<u8>,
        weather: vector<u8>,
        month: vector<u8>,
        sports: vector<u8>,
        music: vector<u8>,
        movies: vector<u8>,
        season: vector<u8>,
        outfit: vector<u8>,
        face: vector<u8>,
        arm: vector<u8>,
        leg: vector<u8>,
        foot: vector<u8>,
        weapon: vector<u8>,
        helmet: vector<u8>,
        armor: vector<u8>,
        mecha: vector<u8>,
        pants: vector<u8>,
        skirt: vector<u8>,
    ) acquires KikoCatNFTCapability, KikoCatGallery {
        let sender_address = Signer::address_of(sender);
        let cap = borrow_global_mut<KikoCatNFTCapability>(sender_address);
        let nft = NFT::mint_with_cap<KikoCatMeta, KikoCatBody, KikoCatTypeInfo>(
            sender_address,
            &mut cap.mint,
            metadata,
            KikoCatMeta {
                background,
                fur,
                clothes,
                facial_expression,
                head,
                accessories,
                eyes,
                hat,
                costume,
                makeup,
                shoes,
                mouth,
                earring,
                necklace,
                neck,
                hair,
                horn,
                hands,
                body,
                skin,
                tattoo,
                people,
                characteristic,
                hobby,
                zodiac,
                action,
                toys,
                fruits,
                vegetables,
                meat,
                beverages,
                food,
                vehicle,
                weather,
                month,
                sports,
                music,
                movies,
                season,
                outfit,
                face,
                arm,
                leg,
                foot,
                weapon,
                helmet,
                armor,
                mecha,
                pants,
                skirt,
            },
            KikoCatBody {}
        );
        let gallery = borrow_global_mut<KikoCatGallery>(sender_address);
        let id = NFT::get_id<KikoCatMeta, KikoCatBody>(&nft);
        Vector::push_back(&mut gallery.items, nft);
        Event::emit_event<NFTMintEvent<KikoCatMeta, KikoCatBody>>(&mut gallery.nft_mint_events,
            NFTMintEvent {
                creator: sender_address,
                id: id,
            },
        );
    }

    // ******************** NFT Gallery ********************
    // kiko gallery
    struct KikoCatGallery has key, store {
        items: vector<NFT<KikoCatMeta, KikoCatBody>>,
        nft_mint_events: Event::EventHandle<NFTMintEvent<KikoCatMeta, KikoCatBody>>,
        box_open_events: Event::EventHandle<BoxOpenEvent<KikoCatMeta, KikoCatBody>>,
    }

    // box open event
    struct NFTMintEvent<NFTMeta: store + drop, NFTBody: store + drop> has drop, store {
        creator: address,
        id: u64,
    }

    // box open event
    struct BoxOpenEvent<NFTMeta: store + drop, NFTBody: store + drop> has drop, store {
        owner: address,
        id: u64,
    }

    // init kiko gallery
    fun init_gallery(sender: &signer) {
        if (!exists<KikoCatGallery>(Signer::address_of(sender))) {
            let gallery = KikoCatGallery {
                items: Vector::empty<NFT<KikoCatMeta, KikoCatBody>>(),
                nft_mint_events: Event::new_event_handle<NFTMintEvent<KikoCatMeta, KikoCatBody>>(sender),
                box_open_events: Event::new_event_handle<BoxOpenEvent<KikoCatMeta, KikoCatBody>>(sender),
            };
            move_to(sender, gallery);
        }
    }

    // Count all NFTs assigned to an owner
    public fun count_of(owner: address): u64
    acquires KikoCatGallery {
        let gallery = borrow_global_mut<KikoCatGallery>(owner);
        Vector::length(&gallery.items)
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
        init_gallery(&sender);
        NFTGallery::accept<KikoCatMeta, KikoCatBody>(&sender);
    }

    // init nft and box with image data
    public(script) fun init_with_image_data(
        sender: signer,
        name: vector<u8>,
        image_data: vector<u8>,
        description: vector<u8>,
    ) {
        assert(Signer::address_of(&sender) == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image_data(name, image_data, description);
        init_nft(&sender, metadata);
        init_box(&sender);
        init_gallery(&sender);
        NFTGallery::accept<KikoCatMeta, KikoCatBody>(&sender);
    }

    // mint NFT and box
    public(script) fun mint_with_image(
        sender: &signer,
        name: vector<u8>,
        image: vector<u8>,
        description: vector<u8>,
        background: vector<u8>,
        fur: vector<u8>,
        clothes: vector<u8>,
        facial_expression: vector<u8>,
        head: vector<u8>,
        accessories: vector<u8>,
        eyes: vector<u8>,
        hat: vector<u8>,
        costume: vector<u8>,
        makeup: vector<u8>,
        shoes: vector<u8>,
        mouth: vector<u8>,
        earring: vector<u8>,
        necklace: vector<u8>,
        neck: vector<u8>,
        hair: vector<u8>,
        horn: vector<u8>,
        hands: vector<u8>,
        body: vector<u8>,
        skin: vector<u8>,
        tattoo: vector<u8>,
        people: vector<u8>,
        characteristic: vector<u8>,
        hobby: vector<u8>,
        zodiac: vector<u8>,
        action: vector<u8>,
        toys: vector<u8>,
        fruits: vector<u8>,
        vegetables: vector<u8>,
        meat: vector<u8>,
        beverages: vector<u8>,
        food: vector<u8>,
        vehicle: vector<u8>,
        weather: vector<u8>,
        month: vector<u8>,
        sports: vector<u8>,
        music: vector<u8>,
        movies: vector<u8>,
        season: vector<u8>,
        outfit: vector<u8>,
        face: vector<u8>,
        arm: vector<u8>,
        leg: vector<u8>,
        foot: vector<u8>,
        weapon: vector<u8>,
        helmet: vector<u8>,
        armor: vector<u8>,
        mecha: vector<u8>,
        pants: vector<u8>,
        skirt: vector<u8>,
    ) acquires KikoCatNFTCapability, KikoCatBoxCapability, KikoCatGallery {
        let sender_address = Signer::address_of(sender);
        assert(sender_address == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image(name, image, description);
        mint_nft(sender,
            metadata,
            background,
            fur,
            clothes,
            facial_expression,
            head,
            accessories,
            eyes,
            hat,
            costume,
            makeup,
            shoes,
            mouth,
            earring,
            necklace,
            neck,
            hair,
            horn,
            hands,
            body,
            skin,
            tattoo,
            people,
            characteristic,
            hobby,
            zodiac,
            action,
            toys,
            fruits,
            vegetables,
            meat,
            beverages,
            food,
            vehicle,
            weather,
            month,
            sports,
            music,
            movies,
            season,
            outfit,
            face,
            arm,
            leg,
            foot,
            weapon,
            helmet,
            armor,
            mecha,
            pants,
            skirt,
        );
        mint_box(sender, 1);
    }

    // mint NFT and box
    public(script) fun mint_with_image_script(
        sender: signer,
        name: vector<u8>,
        image: vector<u8>,
        description: vector<u8>,
        background: vector<u8>,
        fur: vector<u8>,
        clothes: vector<u8>,
        facial_expression: vector<u8>,
        head: vector<u8>,
        accessories: vector<u8>,
        eyes: vector<u8>,
        hat: vector<u8>,
        costume: vector<u8>,
        makeup: vector<u8>,
        shoes: vector<u8>,
        mouth: vector<u8>,
        earring: vector<u8>,
        necklace: vector<u8>,
        neck: vector<u8>,
        hair: vector<u8>,
        horn: vector<u8>,
        hands: vector<u8>,
        body: vector<u8>,
        skin: vector<u8>,
        tattoo: vector<u8>,
        people: vector<u8>,
        characteristic: vector<u8>,
        hobby: vector<u8>,
        zodiac: vector<u8>,
        action: vector<u8>,
        toys: vector<u8>,
        fruits: vector<u8>,
        vegetables: vector<u8>,
        meat: vector<u8>,
        beverages: vector<u8>,
        food: vector<u8>,
        vehicle: vector<u8>,
        weather: vector<u8>,
        month: vector<u8>,
        sports: vector<u8>,
        music: vector<u8>,
        movies: vector<u8>,
        season: vector<u8>,
        outfit: vector<u8>,
        face: vector<u8>,
        arm: vector<u8>,
        leg: vector<u8>,
        foot: vector<u8>,
        weapon: vector<u8>,
        helmet: vector<u8>,
        armor: vector<u8>,
        mecha: vector<u8>,
        pants: vector<u8>,
        skirt: vector<u8>,
    ) acquires KikoCatNFTCapability, KikoCatBoxCapability, KikoCatGallery {
        let sender_address = Signer::address_of(&sender);
        assert(sender_address == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image(name, image, description);
        mint_nft(&sender,
            metadata,
            background,
            fur,
            clothes,
            facial_expression,
            head,
            accessories,
            eyes,
            hat,
            costume,
            makeup,
            shoes,
            mouth,
            earring,
            necklace,
            neck,
            hair,
            horn,
            hands,
            body,
            skin,
            tattoo,
            people,
            characteristic,
            hobby,
            zodiac,
            action,
            toys,
            fruits,
            vegetables,
            meat,
            beverages,
            food,
            vehicle,
            weather,
            month,
            sports,
            music,
            movies,
            season,
            outfit,
            face,
            arm,
            leg,
            foot,
            weapon,
            helmet,
            armor,
            mecha,
            pants,
            skirt,
        );
        mint_box(&sender, 1);
    }

    // mint NFT and box
    public(script) fun mint_with_image_data(
        sender: signer,
        name: vector<u8>,
        image_data: vector<u8>,
        description: vector<u8>,
        background: vector<u8>,
        fur: vector<u8>,
        clothes: vector<u8>,
        facial_expression: vector<u8>,
        head: vector<u8>,
        accessories: vector<u8>,
        eyes: vector<u8>,
        hat: vector<u8>,
        costume: vector<u8>,
        makeup: vector<u8>,
        shoes: vector<u8>,
        mouth: vector<u8>,
        earring: vector<u8>,
        necklace: vector<u8>,
        neck: vector<u8>,
        hair: vector<u8>,
        horn: vector<u8>,
        hands: vector<u8>,
        body: vector<u8>,
        skin: vector<u8>,
        tattoo: vector<u8>,
        people: vector<u8>,
        characteristic: vector<u8>,
        hobby: vector<u8>,
        zodiac: vector<u8>,
        action: vector<u8>,
        toys: vector<u8>,
        fruits: vector<u8>,
        vegetables: vector<u8>,
        meat: vector<u8>,
        beverages: vector<u8>,
        food: vector<u8>,
        vehicle: vector<u8>,
        weather: vector<u8>,
        month: vector<u8>,
        sports: vector<u8>,
        music: vector<u8>,
        movies: vector<u8>,
        season: vector<u8>,
        outfit: vector<u8>,
        face: vector<u8>,
        arm: vector<u8>,
        leg: vector<u8>,
        foot: vector<u8>,
        weapon: vector<u8>,
        helmet: vector<u8>,
        armor: vector<u8>,
        mecha: vector<u8>,
        pants: vector<u8>,
        skirt: vector<u8>,
    ) acquires KikoCatNFTCapability, KikoCatBoxCapability, KikoCatGallery {
        let sender_address = Signer::address_of(&sender);
        assert(sender_address == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image_data(name, image_data, description);
        mint_nft(&sender,
            metadata,
            background,
            fur,
            clothes,
            facial_expression,
            head,
            accessories,
            eyes,
            hat,
            costume,
            makeup,
            shoes,
            mouth,
            earring,
            necklace,
            neck,
            hair,
            horn,
            hands,
            body,
            skin,
            tattoo,
            people,
            characteristic,
            hobby,
            zodiac,
            action,
            toys,
            fruits,
            vegetables,
            meat,
            beverages,
            food,
            vehicle,
            weather,
            month,
            sports,
            music,
            movies,
            season,
            outfit,
            face,
            arm,
            leg,
            foot,
            weapon,
            helmet,
            armor,
            mecha,
            pants,
            skirt,
        );
        mint_box(&sender, 1);
    }

    // open box and get a random NFT
    public(script) fun open_box(sender: signer)
    acquires KikoCatBoxCapability, KikoCatGallery {
        let box_token = Account::withdraw<KikoCatBox>(&sender, 1);
        burn_box(box_token);
        // get hash last 64 bit and mod nft_size
        let hash = Block::get_parent_hash();
        let k = 0u64;
        let i = 0;
        while (i < 8) {
            let tmp = (Vector::pop_back<u8>(&mut hash) as u128);
            k = (tmp << (i * 8) as u64) + k;
            i = i + 1;
        };
        let idx = k % count_of(NFT_ADDRESS);
        // get a nft by idx
        let sender_address = Signer::address_of(&sender);
        let gallery = borrow_global_mut<KikoCatGallery>(NFT_ADDRESS);
        let nft = Vector::remove<NFT<KikoCatMeta, KikoCatBody>>(&mut gallery.items, idx);
        let id = NFT::get_id<KikoCatMeta, KikoCatBody>(&nft);
        NFTGallery::accept<KikoCatMeta, KikoCatBody>(&sender);
        NFTGallery::deposit<KikoCatMeta, KikoCatBody>(&sender, nft);
        // emit event
        Event::emit_event<BoxOpenEvent<KikoCatMeta, KikoCatBody>>(&mut gallery.box_open_events,
            BoxOpenEvent {
                owner: sender_address,
                id: id,
            },
        );
    }
}
}
