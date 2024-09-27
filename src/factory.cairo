use starknet::{ContractAddress, ClassHash, SyscallResult};
// Selector for fn 'initialize'
const INITIALIZE_SELECTOR: felt252 = 0x79dc0da7c54b95f10aa182ad0a46400db63156920adb65eca2654c0945a463;

#[starknet::interface]
pub trait IFactory<TContractState> {
    fn deploy(
        ref self: TContractState,
        class_hash: ClassHash,
        initialize_calldata: Span<felt252>,
        salt_nonce: felt252
    ) -> SyscallResult<ContractAddress>;
}

#[starknet::contract]
pub mod Factory {
    use super::{
        IFactory,
        INITIALIZE_SELECTOR,
    };
    use starknet::{ContractAddress, ClassHash, syscalls, SyscallResult};

    #[event]
    #[derive(Drop, PartialEq, starknet::Event)]
    enum Event {
        NewContractDeployed: NewContractDeployed,
    }

    #[derive(Drop, PartialEq, starknet::Event)]
    struct NewContractDeployed {
        class_hash: ClassHash,
        contract_address: ContractAddress,
    }

    #[storage]
    struct Storage {}


    #[abi(embed_v0)]
    impl Factory of IFactory<ContractState> {
        fn deploy(
            ref self: ContractState,
            class_hash: ClassHash,
            initialize_calldata: Span<felt252>,
            salt_nonce: felt252,
        ) -> SyscallResult<ContractAddress> {
            let caller_address = starknet::get_caller_address().into();
            let salt_input = array![caller_address, salt_nonce];

            let contract_address_salt = core::poseidon::poseidon_hash_span(salt_input.span());

            let (space_address, _) = syscalls::deploy_syscall(
                class_hash, contract_address_salt, array![].span(), false
            )?;

            syscalls::call_contract_syscall(
                space_address, INITIALIZE_SELECTOR, initialize_calldata
            )?;

            self
                .emit(
                    Event::NewContractDeployed(
                        NewContractDeployed { class_hash, contract_address: space_address }
                    )
                );

            Result::Ok(space_address)
        }
    }

}