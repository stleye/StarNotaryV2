# StarNotaryV2 (Using ERC-721 - NFT Tokens)

Steps to create this project

1 - truffle unbox webpack (It creates a lot of boilerplate code, set up directories, structures, etc, the same than StarNotaryV1)

2 - Inside the app folder we run -> npm install @openzeppelin/contracts (It installs A library for secure smart contract development)

3 - we delete all the code that is not needed (ConvertLib.sol, MetaCoin.sol, metacoin.js, TestMetaCoin.sol)

4 - We have a new folder with a standar implementation of ERC721 - app/node-modules/@openzeppelin/contracts/token/ERC721.sol (among other files)

5 - truffle develop (It starts a local Ethereum Network, check in what port is running and connect to it with Metamask, the chainId can be obtained running await web3.eth.getChainId();)

6 - compile (in the console, inside truffle)

7 - Update files inside migration directory (remove old code and update it with new contracts)

8 - Add tests to Test folder

9 - On terminal run truffle test and check that all the tests pass

10 - Add index.html and index.js for the DApp

11 - For running the DApp - 
	- truffle develop
	- compile
	- migrate --reset
	- in a different terminal run - npm run dev
	- on a browser, open the address given by the previous command (normally http://localhost:8080) and connect metamask
	- create a star and click button, then accept transaction on metaslack