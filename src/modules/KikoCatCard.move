address 0x69F1E543A3BeF043B63BEd825fcd2cf6 {
module KikoCatCard05 {
    use 0x1::Signer;
    use 0x1::Event;
    use 0x1::Block;
    use 0x1::Vector;
    use 0x1::Option::{Self, Option};
    use 0x1::Token;
    use 0x1::STC::STC;
    use 0x1::Account;
    use 0x1::NFT::{Self, NFT};
    use 0x1::NFTGallery;
    use 0x69F1E543A3BeF043B63BEd825fcd2cf6::KikoCatElement05::{Self, KikoCatMeta as ElementMeta, KikoCatBody as ElementBody};

    const NFT_ADDRESS: address = @0x69F1E543A3BeF043B63BEd825fcd2cf6;

    const PERMISSION_DENIED: u64 = 100001;
    const TYPE_NOT_MATCH: u64 = 100002;
    const NFT_NOT_EXIST: u64 = 100003;
    const ELEMENT_CANNOT_EMPTY: u64 = 100004;
    const INSUFFICIENT_BALANCE: u64 = 100005;

    // ******************** NFT ********************
    // NFT extra meta
    struct KikoCatMeta has copy, store, drop {
        occupation: vector<u8>,
        custom_name: vector<u8>,
        original: bool,
        score: u128,
        sex: u8,
        background_id: u64,
        fur_id: u64,
        clothes_id: u64,
        expression_id: u64,
        head_id: u64,
        accessories_id: u64,
        eyes_id: u64,
        hat_id: u64,
        costume_id: u64,
        makeup_id: u64,
        shoes_id: u64,
        mouth_id: u64,
        earring_id: u64,
        necklace_id: u64,
        neck_id: u64,
        hair_id: u64,
        horn_id: u64,
        hands_id: u64,
        body_id: u64,
        skin_id: u64,
        tattoo_id: u64,
        people_id: u64,
        characteristic_id: u64,
        hobby_id: u64,
        zodiac_id: u64,
        action_id: u64,
        toys_id: u64,
        fruits_id: u64,
        vegetables_id: u64,
        meat_id: u64,
        beverages_id: u64,
        food_id: u64,
        vehicle_id: u64,
        weather_id: u64,
        month_id: u64,
        sports_id: u64,
        music_id: u64,
        movies_id: u64,
        season_id: u64,
        outfit_id: u64,
        face_id: u64,
        arm_id: u64,
        leg_id: u64,
        foot_id: u64,
        weapon_id: u64,
        helmet_id: u64,
        armor_id: u64,
        mecha_id: u64,
        pants_id: u64,
        skirt_id: u64,
        left_hand_id: u64,
        right_hand_id: u64,
        pets_id: u64,
        gifts_id: u64,
        tail_id: u64,
    }

    // NFT body
    struct KikoCatBody has copy, store, drop {}

    // NFT extra type info
    struct KikoCatTypeInfo has copy, store, drop {}

    struct KikoCatNFTCapability has key {
        mint: NFT::MintCapability<KikoCatMeta>,
        burn: NFT::BurnCapability<KikoCatMeta>,
    }

    struct ElementGallery has key, store {
        items: vector<ElementInfo>,
    }

    struct ElementInfo has key, store {
        card_id: u64,
        background: Option<NFT<ElementMeta, ElementBody>>,
        fur: Option<NFT<ElementMeta, ElementBody>>,
        clothes: Option<NFT<ElementMeta, ElementBody>>,
        expression: Option<NFT<ElementMeta, ElementBody>>,
        head: Option<NFT<ElementMeta, ElementBody>>,
        accessories: Option<NFT<ElementMeta, ElementBody>>,
        eyes: Option<NFT<ElementMeta, ElementBody>>,
        hat: Option<NFT<ElementMeta, ElementBody>>,
        costume: Option<NFT<ElementMeta, ElementBody>>,
        makeup: Option<NFT<ElementMeta, ElementBody>>,
        shoes: Option<NFT<ElementMeta, ElementBody>>,
        mouth: Option<NFT<ElementMeta, ElementBody>>,
        earring: Option<NFT<ElementMeta, ElementBody>>,
        necklace: Option<NFT<ElementMeta, ElementBody>>,
        neck: Option<NFT<ElementMeta, ElementBody>>,
        hair: Option<NFT<ElementMeta, ElementBody>>,
        horn: Option<NFT<ElementMeta, ElementBody>>,
        hands: Option<NFT<ElementMeta, ElementBody>>,
        body: Option<NFT<ElementMeta, ElementBody>>,
        skin: Option<NFT<ElementMeta, ElementBody>>,
        tattoo: Option<NFT<ElementMeta, ElementBody>>,
        people: Option<NFT<ElementMeta, ElementBody>>,
        characteristic: Option<NFT<ElementMeta, ElementBody>>,
        hobby: Option<NFT<ElementMeta, ElementBody>>,
        zodiac: Option<NFT<ElementMeta, ElementBody>>,
        action: Option<NFT<ElementMeta, ElementBody>>,
        toys: Option<NFT<ElementMeta, ElementBody>>,
        fruits: Option<NFT<ElementMeta, ElementBody>>,
        vegetables: Option<NFT<ElementMeta, ElementBody>>,
        meat: Option<NFT<ElementMeta, ElementBody>>,
        beverages: Option<NFT<ElementMeta, ElementBody>>,
        food: Option<NFT<ElementMeta, ElementBody>>,
        vehicle: Option<NFT<ElementMeta, ElementBody>>,
        weather: Option<NFT<ElementMeta, ElementBody>>,
        month: Option<NFT<ElementMeta, ElementBody>>,
        sports: Option<NFT<ElementMeta, ElementBody>>,
        music: Option<NFT<ElementMeta, ElementBody>>,
        movies: Option<NFT<ElementMeta, ElementBody>>,
        season: Option<NFT<ElementMeta, ElementBody>>,
        outfit: Option<NFT<ElementMeta, ElementBody>>,
        face: Option<NFT<ElementMeta, ElementBody>>,
        arm: Option<NFT<ElementMeta, ElementBody>>,
        leg: Option<NFT<ElementMeta, ElementBody>>,
        foot: Option<NFT<ElementMeta, ElementBody>>,
        weapon: Option<NFT<ElementMeta, ElementBody>>,
        helmet: Option<NFT<ElementMeta, ElementBody>>,
        armor: Option<NFT<ElementMeta, ElementBody>>,
        mecha: Option<NFT<ElementMeta, ElementBody>>,
        pants: Option<NFT<ElementMeta, ElementBody>>,
        skirt: Option<NFT<ElementMeta, ElementBody>>,
        left_hand: Option<NFT<ElementMeta, ElementBody>>,
        right_hand: Option<NFT<ElementMeta, ElementBody>>,
        pets: Option<NFT<ElementMeta, ElementBody>>,
        gifts: Option<NFT<ElementMeta, ElementBody>>,
        tail: Option<NFT<ElementMeta, ElementBody>>,
    }

    // init nft with image data
    fun init_nft(
        sender: &signer,
        metadata: NFT::Metadata,
    ) {
        NFT::register<KikoCatMeta, KikoCatTypeInfo>(sender, KikoCatTypeInfo {}, metadata);
        let mint = NFT::remove_mint_capability<KikoCatMeta>(sender);
        let burn = NFT::remove_burn_capability<KikoCatMeta>(sender);
        move_to(sender, KikoCatNFTCapability { mint, burn });
    }

    fun composit_nft(
        sender: &signer,
        metadata: NFT::Metadata,
        occupation: vector<u8>,
        custom_name: vector<u8>,
        original: bool,
        sex: u8,
        background_id: u64,
        fur_id: u64,
        clothes_id: u64,
        expression_id: u64,
        head_id: u64,
        accessories_id: u64,
        eyes_id: u64,
        hat_id: u64,
        costume_id: u64,
        makeup_id: u64,
        shoes_id: u64,
        mouth_id: u64,
        earring_id: u64,
        necklace_id: u64,
        neck_id: u64,
        hair_id: u64,
        horn_id: u64,
        hands_id: u64,
        body_id: u64,
        skin_id: u64,
        tattoo_id: u64,
        people_id: u64,
        characteristic_id: u64,
        hobby_id: u64,
        zodiac_id: u64,
        action_id: u64,
        toys_id: u64,
        fruits_id: u64,
        vegetables_id: u64,
        meat_id: u64,
        beverages_id: u64,
        food_id: u64,
        vehicle_id: u64,
        weather_id: u64,
        month_id: u64,
        sports_id: u64,
        music_id: u64,
        movies_id: u64,
        season_id: u64,
        outfit_id: u64,
        face_id: u64,
        arm_id: u64,
        leg_id: u64,
        foot_id: u64,
        weapon_id: u64,
        helmet_id: u64,
        armor_id: u64,
        mecha_id: u64,
        pants_id: u64,
        skirt_id: u64,
        left_hand_id: u64,
        right_hand_id: u64,
        pets_id: u64,
        gifts_id: u64,
        tail_id: u64,
    ) : NFT<KikoCatMeta, KikoCatBody> acquires KikoCatNFTCapability, ElementGallery, KikoCatGallery {
        let sender_address = Signer::address_of(sender);
        assert(background_id + fur_id + clothes_id + expression_id + head_id > 0, ELEMENT_CANNOT_EMPTY);

        let cap = borrow_global_mut<KikoCatNFTCapability>(NFT_ADDRESS);
        // get element
        let background = get_element_by_id(sender, background_id, 1u64);
        let fur = get_element_by_id(sender, fur_id, 2u64);
        let clothes = get_element_by_id(sender, clothes_id, 3u64);
        let expression = get_element_by_id(sender, expression_id, 4u64);
        let head = get_element_by_id(sender, head_id, 5u64);
        let accessories = get_element_by_id(sender, accessories_id, 6u64);
        let eyes = get_element_by_id(sender, eyes_id, 7u64);
        let hat = get_element_by_id(sender, hat_id, 8u64);
        let costume = get_element_by_id(sender, costume_id, 9u64);
        let makeup = get_element_by_id(sender, makeup_id, 10u64);
        let shoes = get_element_by_id(sender, shoes_id, 11u64);
        let mouth = get_element_by_id(sender, mouth_id, 12u64);
        let earring = get_element_by_id(sender, earring_id, 13u64);
        let necklace = get_element_by_id(sender, necklace_id, 14u64);
        let neck = get_element_by_id(sender, neck_id, 15u64);
        let hair = get_element_by_id(sender, hair_id, 16u64);
        let horn = get_element_by_id(sender, horn_id, 17u64);
        let hands = get_element_by_id(sender, hands_id, 18u64);
        let body = get_element_by_id(sender, body_id, 19u64);
        let skin = get_element_by_id(sender, skin_id, 20u64);
        let tattoo = get_element_by_id(sender, tattoo_id, 21u64);
        let people = get_element_by_id(sender, people_id, 22u64);
        let characteristic = get_element_by_id(sender, characteristic_id, 23u64);
        let hobby = get_element_by_id(sender, hobby_id, 24u64);
        let zodiac = get_element_by_id(sender, zodiac_id, 25u64);
        let action = get_element_by_id(sender, action_id, 26u64);
        let toys = get_element_by_id(sender, toys_id, 27u64);
        let fruits = get_element_by_id(sender, fruits_id, 28u64);
        let vegetables = get_element_by_id(sender, vegetables_id, 29u64);
        let meat = get_element_by_id(sender, meat_id, 30u64);
        let beverages = get_element_by_id(sender, beverages_id, 31u64);
        let food = get_element_by_id(sender, food_id, 32u64);
        let vehicle = get_element_by_id(sender, vehicle_id, 33u64);
        let weather = get_element_by_id(sender, weather_id, 34u64);
        let month = get_element_by_id(sender, month_id, 35u64);
        let sports = get_element_by_id(sender, sports_id, 36u64);
        let music = get_element_by_id(sender, music_id, 37u64);
        let movies = get_element_by_id(sender, movies_id, 38u64);
        let season = get_element_by_id(sender, season_id, 39u64);
        let outfit = get_element_by_id(sender, outfit_id, 40u64);
        let face = get_element_by_id(sender, face_id, 41u64);
        let arm = get_element_by_id(sender, arm_id, 42u64);
        let leg = get_element_by_id(sender, leg_id, 43u64);
        let foot = get_element_by_id(sender, foot_id, 44u64);
        let weapon = get_element_by_id(sender, weapon_id, 45u64);
        let helmet = get_element_by_id(sender, helmet_id, 46u64);
        let armor = get_element_by_id(sender, armor_id, 47u64);
        let mecha = get_element_by_id(sender, mecha_id, 48u64);
        let pants = get_element_by_id(sender, pants_id, 49u64);
        let skirt = get_element_by_id(sender, skirt_id, 50u64);
        let left_hand = get_element_by_id(sender, left_hand_id, 51u64);
        let right_hand = get_element_by_id(sender, right_hand_id, 52u64);
        let pets = get_element_by_id(sender, pets_id, 53u64);
        let gifts = get_element_by_id(sender, gifts_id, 54u64);
        let tail = get_element_by_id(sender, tail_id, 55u64);

        // sum score
        let score = 0;
        score = score + get_score(&background);
        score = score + get_score(&fur);
        score = score + get_score(&clothes);
        score = score + get_score(&expression);
        score = score + get_score(&head);
        score = score + get_score(&accessories);
        score = score + get_score(&eyes);
        score = score + get_score(&hat);
        score = score + get_score(&costume);
        score = score + get_score(&makeup);
        score = score + get_score(&shoes);
        score = score + get_score(&mouth);
        score = score + get_score(&earring);
        score = score + get_score(&necklace);
        score = score + get_score(&neck);
        score = score + get_score(&hair);
        score = score + get_score(&horn);
        score = score + get_score(&hands);
        score = score + get_score(&body);
        score = score + get_score(&skin);
        score = score + get_score(&tattoo);
        score = score + get_score(&people);
        score = score + get_score(&characteristic);
        score = score + get_score(&hobby);
        score = score + get_score(&zodiac);
        score = score + get_score(&action);
        score = score + get_score(&toys);
        score = score + get_score(&fruits);
        score = score + get_score(&vegetables);
        score = score + get_score(&meat);
        score = score + get_score(&beverages);
        score = score + get_score(&food);
        score = score + get_score(&vehicle);
        score = score + get_score(&weather);
        score = score + get_score(&month);
        score = score + get_score(&sports);
        score = score + get_score(&music);
        score = score + get_score(&movies);
        score = score + get_score(&season);
        score = score + get_score(&outfit);
        score = score + get_score(&face);
        score = score + get_score(&arm);
        score = score + get_score(&leg);
        score = score + get_score(&foot);
        score = score + get_score(&weapon);
        score = score + get_score(&helmet);
        score = score + get_score(&armor);
        score = score + get_score(&mecha);
        score = score + get_score(&pants);
        score = score + get_score(&skirt);
        score = score + get_score(&left_hand);
        score = score + get_score(&right_hand);
        score = score + get_score(&pets);
        score = score + get_score(&gifts);
        score = score + get_score(&tail);

        // mint card
        let card_nft = NFT::mint_with_cap<KikoCatMeta, KikoCatBody, KikoCatTypeInfo>(
            sender_address,
            &mut cap.mint,
            metadata,
            KikoCatMeta {
                occupation: copy_vector(&occupation),
                custom_name: copy_vector(&custom_name),
                original,
                sex,
                score,
                background_id,
                fur_id,
                clothes_id,
                expression_id,
                head_id,
                accessories_id,
                eyes_id,
                hat_id,
                costume_id,
                makeup_id,
                shoes_id,
                mouth_id,
                earring_id,
                necklace_id,
                neck_id,
                hair_id,
                horn_id,
                hands_id,
                body_id,
                skin_id,
                tattoo_id,
                people_id,
                characteristic_id,
                hobby_id,
                zodiac_id,
                action_id,
                toys_id,
                fruits_id,
                vegetables_id,
                meat_id,
                beverages_id,
                food_id,
                vehicle_id,
                weather_id,
                month_id,
                sports_id,
                music_id,
                movies_id,
                season_id,
                outfit_id,
                face_id,
                arm_id,
                leg_id,
                foot_id,
                weapon_id,
                helmet_id,
                armor_id,
                mecha_id,
                pants_id,
                skirt_id,
                left_hand_id,
                right_hand_id,
                pets_id,
                gifts_id,
                tail_id,
            },
            KikoCatBody {}
        );
        // stake element
        let card_id = NFT::get_id(&card_nft);
        let element_info = ElementInfo {
            card_id,
            background,
            fur,
            clothes,
            expression,
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
            left_hand,
            right_hand,
            pets,
            gifts,
            tail,
        };
        let gallery = borrow_global_mut<ElementGallery>(NFT_ADDRESS);
        Vector::push_back(&mut gallery.items, element_info);
        let card_gallery = borrow_global_mut<KikoCatGallery>(NFT_ADDRESS);
        Event::emit_event<NFTMintEvent<KikoCatMeta, KikoCatBody>>(&mut card_gallery.nft_mint_events,
            NFTMintEvent<KikoCatMeta, KikoCatBody> {
                creator: NFT_ADDRESS,
                id: card_id,
                original: true,
                occupation,
                custom_name,
                sex,
                background_id,
                fur_id,
                clothes_id,
                expression_id,
                head_id,
                accessories_id,
                eyes_id,
                hat_id,
                costume_id,
                makeup_id,
                shoes_id,
                mouth_id,
                earring_id,
                necklace_id,
                neck_id,
                hair_id,
                horn_id,
                hands_id,
                body_id,
                skin_id,
                tattoo_id,
                people_id,
                characteristic_id,
                hobby_id,
                zodiac_id,
                action_id,
                toys_id,
                fruits_id,
                vegetables_id,
                meat_id,
                beverages_id,
                food_id,
                vehicle_id,
                weather_id,
                month_id,
                sports_id,
                music_id,
                movies_id,
                season_id,
                outfit_id,
                face_id,
                arm_id,
                leg_id,
                foot_id,
                weapon_id,
                helmet_id,
                armor_id,
                mecha_id,
                pants_id,
                skirt_id,
                left_hand_id,
                right_hand_id,
                pets_id,
                gifts_id,
                tail_id,
            },
        );
        return card_nft
    }

    // get element by id
    fun get_element_by_id(sender: &signer, nft_id: u64, type_id: u64): Option<NFT<ElementMeta, ElementBody>> {
        if (nft_id == 0) {
            return Option::none()
        };
        // get element
        let option_nft = NFTGallery::withdraw<ElementMeta, ElementBody>(sender, nft_id);
        assert(Option::is_some<NFT<ElementMeta, ElementBody>>(&option_nft), NFT_NOT_EXIST);
        // get nft
        let nft = Option::borrow<NFT<ElementMeta, ElementBody>>(&option_nft);
        assert(KikoCatElement05::get_type_id(nft) == type_id, TYPE_NOT_MATCH);
        return option_nft
    }

    // get score from element
    fun get_score(option_nft: &Option<NFT<ElementMeta, ElementBody>>): u128 {
        if (Option::is_some<NFT<ElementMeta, ElementBody>>(option_nft)) {
            let nft = Option::borrow<NFT<ElementMeta, ElementBody>>(option_nft);
            return KikoCatElement05::get_score(nft)
        };
        return 0
    }

    // resolve and destory card
    fun resolve_nft(sender: &signer, nft_id: u64) acquires KikoCatNFTCapability, KikoCatGallery, ElementGallery {
        let option_nft = NFTGallery::withdraw<KikoCatMeta, KikoCatBody>(sender, nft_id);
        assert(Option::is_some<NFT<KikoCatMeta, KikoCatBody>>(&option_nft), NFT_NOT_EXIST);
        let nft = Option::extract<NFT<KikoCatMeta, KikoCatBody>>(&mut option_nft);
        // get meta
        let meta = NFT::get_type_meta<KikoCatMeta, KikoCatBody>(&nft);
        // deposit element to user
        unstake_element(sender, meta.background_id);
        // destroy card
        let cap = borrow_global_mut<KikoCatNFTCapability>(NFT_ADDRESS);
        let KikoCatBody {} = NFT::burn_with_cap<KikoCatMeta, KikoCatBody>(&mut cap.burn, nft);
        Option::destroy_none(option_nft);

        let gallery = borrow_global_mut<KikoCatGallery>(NFT_ADDRESS);
        Event::emit_event<NFTResolveEvent<KikoCatMeta, KikoCatBody>>(&mut gallery.nft_resolve_events,
            NFTResolveEvent<KikoCatMeta, KikoCatBody> {
                owner: Signer::address_of(sender),
                id: nft_id,
            },
        );
    }

    fun unstake_element(sender: &signer, nft_id: u64) acquires ElementGallery {
        if (nft_id > 0) {
            let gallery = borrow_global_mut<ElementGallery>(NFT_ADDRESS);
            let len = Vector::length(&gallery.items);
            if (len == 0) {
                return
            };
            let idx = len - 1;
            loop {
                let info = Vector::borrow(&gallery.items, idx);
                if (info.card_id == nft_id) {
                    let info = Vector::remove<ElementInfo>(&mut gallery.items, idx);
                    deposit_nft(sender, &mut info.background);
                    deposit_nft(sender, &mut info.fur);
                    deposit_nft(sender, &mut info.clothes);
                    deposit_nft(sender, &mut info.expression);
                    deposit_nft(sender, &mut info.head);
                    deposit_nft(sender, &mut info.accessories);
                    deposit_nft(sender, &mut info.eyes);
                    deposit_nft(sender, &mut info.hat);
                    deposit_nft(sender, &mut info.costume);
                    deposit_nft(sender, &mut info.makeup);
                    deposit_nft(sender, &mut info.shoes);
                    deposit_nft(sender, &mut info.mouth);
                    deposit_nft(sender, &mut info.earring);
                    deposit_nft(sender, &mut info.necklace);
                    deposit_nft(sender, &mut info.neck);
                    deposit_nft(sender, &mut info.hair);
                    deposit_nft(sender, &mut info.horn);
                    deposit_nft(sender, &mut info.hands);
                    deposit_nft(sender, &mut info.body);
                    deposit_nft(sender, &mut info.skin);
                    deposit_nft(sender, &mut info.tattoo);
                    deposit_nft(sender, &mut info.people);
                    deposit_nft(sender, &mut info.characteristic);
                    deposit_nft(sender, &mut info.hobby);
                    deposit_nft(sender, &mut info.zodiac);
                    deposit_nft(sender, &mut info.action);
                    deposit_nft(sender, &mut info.toys);
                    deposit_nft(sender, &mut info.fruits);
                    deposit_nft(sender, &mut info.vegetables);
                    deposit_nft(sender, &mut info.meat);
                    deposit_nft(sender, &mut info.beverages);
                    deposit_nft(sender, &mut info.food);
                    deposit_nft(sender, &mut info.vehicle);
                    deposit_nft(sender, &mut info.weather);
                    deposit_nft(sender, &mut info.month);
                    deposit_nft(sender, &mut info.sports);
                    deposit_nft(sender, &mut info.music);
                    deposit_nft(sender, &mut info.movies);
                    deposit_nft(sender, &mut info.season);
                    deposit_nft(sender, &mut info.outfit);
                    deposit_nft(sender, &mut info.face);
                    deposit_nft(sender, &mut info.arm);
                    deposit_nft(sender, &mut info.leg);
                    deposit_nft(sender, &mut info.foot);
                    deposit_nft(sender, &mut info.weapon);
                    deposit_nft(sender, &mut info.helmet);
                    deposit_nft(sender, &mut info.armor);
                    deposit_nft(sender, &mut info.mecha);
                    deposit_nft(sender, &mut info.pants);
                    deposit_nft(sender, &mut info.skirt);
                    let ElementInfo {
                        card_id: _,
                        background,
                        fur,
                        clothes,
                        expression,
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
                        left_hand,
                        right_hand,
                        pets,
                        gifts,
                        tail,
                    } = info;
                    Option::destroy_none(background);
                    Option::destroy_none(fur);
                    Option::destroy_none(clothes);
                    Option::destroy_none(expression);
                    Option::destroy_none(head);
                    Option::destroy_none(accessories);
                    Option::destroy_none(eyes);
                    Option::destroy_none(hat);
                    Option::destroy_none(costume);
                    Option::destroy_none(makeup);
                    Option::destroy_none(shoes);
                    Option::destroy_none(mouth);
                    Option::destroy_none(earring);
                    Option::destroy_none(necklace);
                    Option::destroy_none(neck);
                    Option::destroy_none(hair);
                    Option::destroy_none(horn);
                    Option::destroy_none(hands);
                    Option::destroy_none(body);
                    Option::destroy_none(skin);
                    Option::destroy_none(tattoo);
                    Option::destroy_none(people);
                    Option::destroy_none(characteristic);
                    Option::destroy_none(hobby);
                    Option::destroy_none(zodiac);
                    Option::destroy_none(action);
                    Option::destroy_none(toys);
                    Option::destroy_none(fruits);
                    Option::destroy_none(vegetables);
                    Option::destroy_none(meat);
                    Option::destroy_none(beverages);
                    Option::destroy_none(food);
                    Option::destroy_none(vehicle);
                    Option::destroy_none(weather);
                    Option::destroy_none(month);
                    Option::destroy_none(sports);
                    Option::destroy_none(music);
                    Option::destroy_none(movies);
                    Option::destroy_none(season);
                    Option::destroy_none(outfit);
                    Option::destroy_none(face);
                    Option::destroy_none(arm);
                    Option::destroy_none(leg);
                    Option::destroy_none(foot);
                    Option::destroy_none(weapon);
                    Option::destroy_none(helmet);
                    Option::destroy_none(armor);
                    Option::destroy_none(mecha);
                    Option::destroy_none(pants);
                    Option::destroy_none(skirt);
                    Option::destroy_none(left_hand);
                    Option::destroy_none(right_hand);
                    Option::destroy_none(pets);
                    Option::destroy_none(gifts);
                    Option::destroy_none(tail);
                    return
                };
                idx = idx - 1;
                assert(idx >= 0, NFT_NOT_EXIST);
            }
        }
    }

    fun deposit_nft(sender: &signer, option_nft: &mut Option<NFT<ElementMeta, ElementBody>>) {
        if (Option::is_some(option_nft)) {
            let nft = Option::extract(option_nft);
            NFTGallery::deposit(sender, nft);
        }
    }

    fun copy_vector(v: &vector<u8>) : vector<u8> {
        let len = Vector::length<u8>(v);
        let i = 0;
        let target = Vector::empty<u8>();
        while (i < len) {
            let tmp = *Vector::borrow<u8>(v, i);
            Vector::push_back<u8>(&mut target, tmp);
            i = i + 1;
        };
        return target
    }

    // ******************** NFT Gallery ********************
    // kiko gallery
    struct KikoCatGallery has key, store {
        items: vector<NFT<KikoCatMeta, KikoCatBody>>,
        composite_fee: u128,
        nft_mint_events: Event::EventHandle<NFTMintEvent<KikoCatMeta, KikoCatBody>>,
        nft_resolve_events: Event::EventHandle<NFTResolveEvent<KikoCatMeta, KikoCatBody>>,
        box_open_events: Event::EventHandle<BoxOpenEvent<KikoCatMeta, KikoCatBody>>,
    }

    // box open event
    struct NFTMintEvent<NFTMeta: store + drop, NFTBody: store + drop> has drop, store {
        creator: address,
        id: u64,
        original: bool,
        occupation: vector<u8>,
        custom_name: vector<u8>,
        sex: u8,
        background_id: u64,
        fur_id: u64,
        clothes_id: u64,
        expression_id: u64,
        head_id: u64,
        accessories_id: u64,
        eyes_id: u64,
        hat_id: u64,
        costume_id: u64,
        makeup_id: u64,
        shoes_id: u64,
        mouth_id: u64,
        earring_id: u64,
        necklace_id: u64,
        neck_id: u64,
        hair_id: u64,
        horn_id: u64,
        hands_id: u64,
        body_id: u64,
        skin_id: u64,
        tattoo_id: u64,
        people_id: u64,
        characteristic_id: u64,
        hobby_id: u64,
        zodiac_id: u64,
        action_id: u64,
        toys_id: u64,
        fruits_id: u64,
        vegetables_id: u64,
        meat_id: u64,
        beverages_id: u64,
        food_id: u64,
        vehicle_id: u64,
        weather_id: u64,
        month_id: u64,
        sports_id: u64,
        music_id: u64,
        movies_id: u64,
        season_id: u64,
        outfit_id: u64,
        face_id: u64,
        arm_id: u64,
        leg_id: u64,
        foot_id: u64,
        weapon_id: u64,
        helmet_id: u64,
        armor_id: u64,
        mecha_id: u64,
        pants_id: u64,
        skirt_id: u64,
        left_hand_id: u64,
        right_hand_id: u64,
        pets_id: u64,
        gifts_id: u64,
        tail_id: u64,
    }

    // box open event
    struct NFTResolveEvent<NFTMeta: store + drop, NFTBody: store + drop> has drop, store {
        owner: address,
        id: u64,
    }

    // box open event
    struct BoxOpenEvent<NFTMeta: store + drop, NFTBody: store + drop> has drop, store {
        owner: address,
        id: u64,
    }

    // init kiko gallery
    fun init_gallery(sender: &signer, composite_fee: u128) {
        if (!exists<KikoCatGallery>(Signer::address_of(sender))) {
            let gallery = KikoCatGallery {
                items: Vector::empty<NFT<KikoCatMeta, KikoCatBody>>(),
                composite_fee,
                nft_mint_events: Event::new_event_handle<NFTMintEvent<KikoCatMeta, KikoCatBody>>(sender),
                nft_resolve_events: Event::new_event_handle<NFTResolveEvent<KikoCatMeta, KikoCatBody>>(sender),
                box_open_events: Event::new_event_handle<BoxOpenEvent<KikoCatMeta, KikoCatBody>>(sender),
            };
            move_to(sender, gallery);
        };
        if (!exists<ElementGallery>(Signer::address_of(sender))) {
            let gallery = ElementGallery {
                items: Vector::empty<ElementInfo>(),
            };
            move_to(sender, gallery);
        };
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
        composite_fee: u128,
    ) {
        assert(Signer::address_of(&sender) == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image(name, image, description);
        init_nft(&sender, metadata);
        init_box(&sender);
        init_gallery(&sender, composite_fee);
        NFTGallery::accept<KikoCatMeta, KikoCatBody>(&sender);
    }

    public(script) fun update_config(sender: signer, composite_fee: u128) acquires KikoCatGallery {
        assert(Signer::address_of(&sender) == NFT_ADDRESS, PERMISSION_DENIED);
        let gallery = borrow_global_mut<KikoCatGallery>(NFT_ADDRESS);
        gallery.composite_fee = composite_fee;
    }

    // mint NFT and box
    public(script) fun composite_original_card(
        sender: signer,
        name: vector<u8>,
        image: vector<u8>,
        description: vector<u8>,
        occupation: vector<u8>,
        custom_name: vector<u8>,
        sex: u8,
        background_id: u64,
        fur_id: u64,
        clothes_id: u64,
        expression_id: u64,
        head_id: u64,
        accessories_id: u64,
        eyes_id: u64,
        hat_id: u64,
        costume_id: u64,
        makeup_id: u64,
        shoes_id: u64,
        mouth_id: u64,
        earring_id: u64,
        necklace_id: u64,
        neck_id: u64,
        hair_id: u64,
        horn_id: u64,
        hands_id: u64,
        body_id: u64,
        skin_id: u64,
        tattoo_id: u64,
        people_id: u64,
        characteristic_id: u64,
        hobby_id: u64,
        zodiac_id: u64,
        action_id: u64,
        toys_id: u64,
        fruits_id: u64,
        vegetables_id: u64,
        meat_id: u64,
        beverages_id: u64,
        food_id: u64,
        vehicle_id: u64,
        weather_id: u64,
        month_id: u64,
        sports_id: u64,
        music_id: u64,
        movies_id: u64,
        season_id: u64,
        outfit_id: u64,
        face_id: u64,
        arm_id: u64,
        leg_id: u64,
        foot_id: u64,
        weapon_id: u64,
        helmet_id: u64,
        armor_id: u64,
        mecha_id: u64,
        pants_id: u64,
        skirt_id: u64,
        left_hand_id: u64,
        right_hand_id: u64,
        pets_id: u64,
        gifts_id: u64,
        tail_id: u64,
    )
    acquires KikoCatNFTCapability, KikoCatBoxCapability, KikoCatGallery, ElementGallery {
        let sender_address = Signer::address_of(&sender);
        assert(sender_address == NFT_ADDRESS, PERMISSION_DENIED);
        let metadata = NFT::new_meta_with_image(name, image, description);
        let nft = composit_nft(
            &sender,
            metadata,
            occupation,
            custom_name,
            true,
            sex,
            background_id,
            fur_id,
            clothes_id,
            expression_id,
            head_id,
            accessories_id,
            eyes_id,
            hat_id,
            costume_id,
            makeup_id,
            shoes_id,
            mouth_id,
            earring_id,
            necklace_id,
            neck_id,
            hair_id,
            horn_id,
            hands_id,
            body_id,
            skin_id,
            tattoo_id,
            people_id,
            characteristic_id,
            hobby_id,
            zodiac_id,
            action_id,
            toys_id,
            fruits_id,
            vegetables_id,
            meat_id,
            beverages_id,
            food_id,
            vehicle_id,
            weather_id,
            month_id,
            sports_id,
            music_id,
            movies_id,
            season_id,
            outfit_id,
            face_id,
            arm_id,
            leg_id,
            foot_id,
            weapon_id,
            helmet_id,
            armor_id,
            mecha_id,
            pants_id,
            skirt_id,
            left_hand_id,
            right_hand_id,
            pets_id,
            gifts_id,
            tail_id,
        );

        let gallery = borrow_global_mut<KikoCatGallery>(NFT_ADDRESS);
        Vector::push_back(&mut gallery.items, nft);

        mint_box(&sender, 1);
    }

    // mint custom NFT
    public(script) fun composite_custom_card(
        sender: signer,
        name: vector<u8>,
        image: vector<u8>,
        description: vector<u8>,
        occupation: vector<u8>,
        custom_name: vector<u8>,
        sex: u8,
        background_id: u64,
        fur_id: u64,
        clothes_id: u64,
        expression_id: u64,
        head_id: u64,
        accessories_id: u64,
        eyes_id: u64,
        hat_id: u64,
        costume_id: u64,
        makeup_id: u64,
        shoes_id: u64,
        mouth_id: u64,
        earring_id: u64,
        necklace_id: u64,
        neck_id: u64,
        hair_id: u64,
        horn_id: u64,
        hands_id: u64,
        body_id: u64,
        skin_id: u64,
        tattoo_id: u64,
        people_id: u64,
        characteristic_id: u64,
        hobby_id: u64,
        zodiac_id: u64,
        action_id: u64,
        toys_id: u64,
        fruits_id: u64,
        vegetables_id: u64,
        meat_id: u64,
        beverages_id: u64,
        food_id: u64,
        vehicle_id: u64,
        weather_id: u64,
        month_id: u64,
        sports_id: u64,
        music_id: u64,
        movies_id: u64,
        season_id: u64,
        outfit_id: u64,
        face_id: u64,
        arm_id: u64,
        leg_id: u64,
        foot_id: u64,
        weapon_id: u64,
        helmet_id: u64,
        armor_id: u64,
        mecha_id: u64,
        pants_id: u64,
        skirt_id: u64,
        left_hand_id: u64,
        right_hand_id: u64,
        pets_id: u64,
        gifts_id: u64,
        tail_id: u64,
    ) acquires KikoCatNFTCapability, KikoCatGallery, ElementGallery {
        let metadata = NFT::new_meta_with_image(name, image, description);
        // get fee
        let gallery = borrow_global_mut<KikoCatGallery>(NFT_ADDRESS);
        let composite_fee = gallery.composite_fee;
        let sender_address = Signer::address_of(&sender);
        assert(Account::balance<STC>(sender_address) > composite_fee, INSUFFICIENT_BALANCE);
        Account::pay_from<STC>(&sender, NFT_ADDRESS, composite_fee);

        let nft = composit_nft(
            &sender,
            metadata,
            occupation,
            custom_name,
            false,
            sex,
            background_id,
            fur_id,
            clothes_id,
            expression_id,
            head_id,
            accessories_id,
            eyes_id,
            hat_id,
            costume_id,
            makeup_id,
            shoes_id,
            mouth_id,
            earring_id,
            necklace_id,
            neck_id,
            hair_id,
            horn_id,
            hands_id,
            body_id,
            skin_id,
            tattoo_id,
            people_id,
            characteristic_id,
            hobby_id,
            zodiac_id,
            action_id,
            toys_id,
            fruits_id,
            vegetables_id,
            meat_id,
            beverages_id,
            food_id,
            vehicle_id,
            weather_id,
            month_id,
            sports_id,
            music_id,
            movies_id,
            season_id,
            outfit_id,
            face_id,
            arm_id,
            leg_id,
            foot_id,
            weapon_id,
            helmet_id,
            armor_id,
            mecha_id,
            pants_id,
            skirt_id,
            left_hand_id,
            right_hand_id,
            pets_id,
            gifts_id,
            tail_id,
        );
        NFTGallery::deposit(&sender, nft);
    }

    public(script) fun resolve_card(sender: signer, nft_id: u64)
    acquires KikoCatNFTCapability, KikoCatGallery, ElementGallery {
        resolve_nft(&sender, nft_id);
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
            BoxOpenEvent<KikoCatMeta, KikoCatBody> {
                owner: sender_address,
                id: id,
            },
        );
    }
}
}
