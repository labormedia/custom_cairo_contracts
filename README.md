## Testing
```bash
starknet-devnet --seed 42
2024-09-23T00:36:22.641621Z  INFO rpc: received method in on_request starknet_call
2024-09-23T00:36:50.380397Z  INFO rpc: received method in on_request starknet_getClassHashAt
2024-09-23T00:36:50.383449Z  INFO rpc: received method in on_request starknet_call
2024-09-23T00:39:50.118987Z  INFO rpc: received method in on_request starknet_chainId
2024-09-23T00:39:50.132722Z  INFO rpc: received method in on_request starknet_getNonce
2024-09-23T00:39:50.139272Z  INFO rpc: received method in on_request starknet_specVersion
2024-09-23T00:39:50.143657Z  INFO rpc: received method in on_request starknet_estimateFee
2024-09-23T00:39:50.171587Z  INFO rpc: received method in on_request starknet_addInvokeTransaction
2024-09-23T00:44:26.460385Z  INFO rpc: received method in on_request starknet_chainId
2024-09-23T00:44:26.465449Z  INFO rpc: received method in on_request starknet_getNonce
2024-09-23T00:44:26.472200Z  INFO rpc: received method in on_request starknet_specVersion
2024-09-23T00:44:26.476837Z  INFO rpc: received method in on_request starknet_estimateFee
```

# Running DevNet
```bash
mkdir /home/xmonad/.starkli-wallets
starkli account fetch --rpc http://127.0.0.1:5050 0x34ba56f92265f0868c57d3fe72ecab144fc96f97954bbbc4252cef8e8a979ba --output ~/.starkli-wallets/devnet/account.json
starkli signer keystore from-key ~/.starkli-wallets/devnet/keystore.json
```

# Declare contract in DevNet
```bash
starkli declare --watch target/dev/custom_cairo_contracts_NameRegistry.contract_class.json --rpc http://127.0.0.1:5050 --account ~/.starkli-wallets/devnet/account.json --keystore ~/.starkli-wallets/devnet/keystore.json
```

# Deploy example to account 0x0553a04e27e23b8c32961585ed96cd0c9f8755240fa9dc61df1b94f5bdbf5f57 , cairo string 0x7175616e74697479.
```bash
starkli deploy --watch 0x0435fe6ec99df5810a05c6937c09f55b26d972f54332fd186451f24ec744fc3b 0x0553a04e27e23b8c32961585ed96cd0c9f8755240fa9dc61df1b94f5bdbf5f57  0x7175616e74697479 --rpc http://127.0.0.1:5050 --account ~/.starkli-wallets/devnet/account.json --keystore ~/.starkli-wallets/devnet/keystore.json
d972f54332fd186451f24ec744fc3b 0x0553a04e27e23b8c32961585ed96cd0c9f8755240fa9dc61df1b94f5bdbf5f57  0x7175616e74697479
 --rpc http://127.0.0.1:5050 --account ~/.starkli-wallets/devnet/account.json --keystore ~/.starkli-wallets/devnet/ke
ystore.json
Enter keystore password: 
Deploying class 0x0435fe6ec99df5810a05c6937c09f55b26d972f54332fd186451f24ec744fc3b with salt 0x01e94f154a90443ab68ab95e74539c5e8e08e2536fd62437f3e4a1e6c6630a99...
The contract will be deployed at address 0x045a4f23125b781f4cb148e668f3ae6194c1b01cfa815af88f780438765fc180
Contract deployment transaction: 0x05916843ff57055b20d29e7b070f968fb418a4d9d733852ba8efdbb7e42de855
Waiting for transaction 0x05916843ff57055b20d29e7b070f968fb418a4d9d733852ba8efdbb7e42de855 to confirm...
Transaction 0x05916843ff57055b20d29e7b070f968fb418a4d9d733852ba8efdbb7e42de855 confirmed
Contract deployed:
0x045a4f23125b781f4cb148e668f3ae6194c1b01cfa815af88f780438765fc180
```

# Calculate cairo strings to felt252
```bash
starkli to-cairo-string <STRING>
```