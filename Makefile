-include .env

build:; forge build
deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEP_RPC) --private-key $(PRIV_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvvma