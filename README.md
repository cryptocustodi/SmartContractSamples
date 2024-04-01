# SmartContractSamples
Example Smart Contracts - not real projects, need tests and SafeMath...

# SampleTokenContract.sol
This contract, MyToken, is a basic implementation of an ERC-20 token. It allows the creator to specify the token's name, symbol, decimals, and initial supply upon deployment. The contract tracks balances of token holders and allows transfers between them. It also implements approval and allowance mechanisms for delegated transfers.

Please note that this is a simplified example and may need additional features and security measures for use in production environments. Additionally, proper testing and auditing should be conducted before deploying any token contract to the Ethereum blockchain.

# CheckersGame.sol
This contract provides the basic structure for a checkers game on the Ethereum blockchain. Players can create games, make moves, and interact with the game state. However, please note that this is a simplified example and does not implement all the rules and mechanics of a complete checkers game. Further implementation would be needed to handle things like capturing opponent pieces, kinging pieces, checking for win conditions, and enforcing turn-taking rules. 
Additionally, proper testing and security considerations should be taken into account before deploying a contract like this to the Ethereum blockchain.

# DeedRegistry.sol
This contract allows:
Registering properties by providing an ID, location, and value.
Transferring ownership of properties from the current owner to a new owner.
Querying property details by providing the property ID.

Please note that this is a simplified example and may need enhancements for a real-world scenario, such as handling multiple owners, updating property details, implementing access control, and integrating with external systems for verifying property ownership. Additionally, proper testing and security considerations should be taken into account before deploying a contract like this to the Ethereum blockchain.

# BondMarket.sol
This contract allows:
Issuing new bonds by providing details such as name, face value, maturity date, coupon rate, and supply.
Buying bonds by specifying the bond ID and the amount to purchase.
Selling bonds owned by the caller.
Retrieving bond details by providing the bond ID.
This is a basic example and may need enhancements for a real-world scenario, such as handling interest payments, secondary market trading, regulatory compliance, and more robust error handling. 

Additionally, it's important to consider security measures such as access control and proper testing before deploying a contract like this to the Ethereum blockchain.
