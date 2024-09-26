use starknet::{
    ContractAddress,
};
use core::num::traits::Zero;

#[starknet::interface]
trait IOwnable<TState> {
    fn owner(self: @TState) -> ContractAddress;
    fn transfer_ownership(ref self: TState, new_owner: ContractAddress);
    fn renounce_ownership(ref self: TState);
}

#[starknet::contract]
mod Ownable {
    use super::{IOwnable, ContractAddress, Zero};
    use starknet::get_caller_address;
    
    use core::starknet::storage::{
        StoragePointerReadAccess, StoragePointerWriteAccess
    };

    #[storage]
    struct Storage {
        owner: ContractAddress
    }

    pub mod Errors {
        pub const NOT_OWNER: felt252 = 'Caller is not the owner';
        pub const ZERO_ADDRESS_CALLER: felt252 = 'Caller is the zero address';
        pub const ZERO_ADDRESS_OWNER: felt252 = 'New owner is the zero address';
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn initializer(ref self: ContractState, owner: ContractAddress) {
            self._transfer_ownership(owner);
        }

        fn assert_only_owner(self: @ContractState) {
            let owner: ContractAddress = self.owner.read();
            let caller: ContractAddress = get_caller_address();
            assert(!caller.is_zero(), Errors::ZERO_ADDRESS_CALLER);
            assert(caller == owner, Errors::NOT_OWNER);
        }

        fn _transfer_ownership(ref self: ContractState, new_owner: ContractAddress) {
            let previous_owner: ContractAddress = self.owner.read();
            self.owner.write(new_owner);
        }
    }

    #[abi(embed_v0)]
    impl OwnableImpl of IOwnable<ContractState> {
        fn owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
        fn transfer_ownership(ref self: ContractState, new_owner: ContractAddress) {
            assert(!new_owner.is_zero(), Errors::ZERO_ADDRESS_OWNER);
            self.assert_only_owner();
            self._transfer_ownership(new_owner);
        }
        fn renounce_ownership(ref self: ContractState) {
            self.assert_only_owner();
            self._transfer_ownership(Zero::zero());
        }
    }
}