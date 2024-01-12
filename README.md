# hello_world

## 实操

```shell
cd Code/
mcd cairo  # mkdir cairo cd cairo
c  # code .
which scarb # vscode cairo1 插件配置
scarb new hello_world
ls
cd hello_world/
c

scarb test
scarb cairo-run --available-gas=200000000

curl https://get.starkli.sh | sh
. /Users/qiaopengjun/.starkli/env
starkliup -v v0.2.3

mkdir ~/.starknet_accounts
starkli signer keystore new ~/.starknet_accounts/key.json
starkli -h
starkli account -h
export STARKNET_KEYSTORE=~/.starknet_accounts/key.json
starkli account oz init  ~/.starknet_accounts/starkli.json
export STARKNET_RPC=https://starknet-testnet.public.blastapi.io/rpc/v0_6
starkli account deploy /Users/qiaopengjun/.starknet_accounts/starkli.json
```

- <https://book.starkli.rs/installation>
- <https://faucet.goerli.starknet.io/>
- <https://testnet.starkscan.co/tx/0x0702470c421f248a6a3c3ff2c6398f433218fe0b0b18a45424860df12db35e24>
- <https://blastapi.io/public-api/starknet>
- <https://foundry-rs.github.io/starknet-foundry/getting-started/installation.html>
- <https://book.cairo-lang.org/ch01-01-installation.html>
- <https://ecn.notion.site/L2-Knowledge-Base-9abc08edafbf408e9b125f0bbb9c54ef>
