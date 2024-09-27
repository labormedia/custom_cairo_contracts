use starknet::{ContractAddress, ClassHash, SyscallResult};

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
    use super::IFactory;
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
    
}