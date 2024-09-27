#[test]
fn idle_test() {
    assert_eq!(42, 41+1);
}

#[cfg(test)]
mod tests {
    use custom_cairo_contracts::factory::{
        Factory,
        IFactoryDispatcher,
        IFactoryDispatcherTrait,
    };

    #[test]
    fn call_abi() {
    }
}