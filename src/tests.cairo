#[test]
fn idle_test() {
    assert_eq!(42, 41+1);
}

#[cfg(test)]
mod tests {
    use starknet::{
        syscalls,
    };
    use core::panic_with_felt252;
    use custom_cairo_contracts::{
        factory::{
            Factory,
            IFactoryDispatcher,
            IFactoryDispatcherTrait,
        },
        NameRegistry::TEST_CLASS_HASH,
    };

    #[test]
    #[available_gas(10_000_000_000)]
    fn call_abi_deploy() {
        let mut constructor_calldata = array![];

        let factory_address =
            match syscalls::deploy_syscall(
                Factory::TEST_CLASS_HASH.try_into().unwrap(), 0, constructor_calldata.span(), false
            ) {
                Result::Ok((address, _)) => address,
                Result::Err(_) => {
                    panic_with_felt252('deploy failed');
                    starknet::contract_address_const::<0>()
            },
        };

        let factory = IFactoryDispatcher { contract_address: factory_address };
        let mut serialized: felt252 = 0;
        let felt_array: Array<felt252> = array![];

        let _ = factory.deploy(TEST_CLASS_HASH.try_into().unwrap(), felt_array.span(), 0);
    }
}