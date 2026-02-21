# Part B: Design Document

**Section 1: FreelanceBountyBoard (Renewable Energy Platform)**

**Section 2: DecentralisedRaffle (DeFi & NFT Integration)**

---

## WHY I BUILT IT THIS WAY

### 1. Data Structure Choices
**Explain your design decisions for BOTH contracts:**
- When would you choose to use a `mapping` instead of an `array`?
- How did you structure your state variables in `FreelanceBountyBoard` vs `DecentralisedRaffle`?
- What trade-offs did you consider for storage efficiency?

[Write your response here]

---You would choose to use a mapping instead of an array when you need fast direct access to data by addresses or ID
-In FreelanceBountyBoard i used mappings to connect freelancer addresses with their skills and to store bounties by their IDs
and in DecentralizedRaffle i had to track all entries so i used an array and mapppings to track entry counts  
-Mappings are more storage efficiency for scattered datasets and fast lookups , but can't be iterated over directly . Arrays allow iteration and ordering but can become expensive 

### 2. Security Measures
**What attacks did you protect against in BOTH implementations?**
- Reentrancy attacks? (Explain your implementation of the Checks-Effects-Interactions pattern)
- Access control vulnerabilities?
- Integer overflow/underflow?
- Front-running/Randomness manipulation (specifically for `DecentralisedRaffle`)?

[Write your response here]

---I protected against reentrancy attacks by following the Checks-Effects-Interactions pattern: state variables are updated before any external calls, and in DecentralisedRaffle I used a 'nonReentrant' modifier for functions that transfer ETH. 
-Access control vulnerabilities are mitigated by restricting sensitive functions with 'onlyOwner' (for raffle management) and by checking employer/freelancer roles in FreelanceBountyBoard. 
-Integer overflow and underflow are prevented by using Solidity 0.8+, which has built-in overflow checks. 
-For front-running and randomness manipulation in DecentralisedRaffle, I combined blockhash, block.prevrandao, and raffleId in the randomness calculation to make it harder for attackers to predict or manipulate the outcome.


### 3. Trade-offs & Future Improvements
**What would you change with more time?**
- Gas optimization opportunities?
- Additional features (e.g., dispute resolution, multiple prize tiers)?
- Better error handling?

[Write your response here]

---With more time, I would optimize gas usage by minimizing storage writes and using more efficient data structures. I would also improve error handling by using custom errors and more descriptive revert messages, and consider integrating OpenZeppelin libraries for additional security and upgradeability.

## REAL-WORLD DEPLOYMENT CONCERNS

### 1. Gas Costs
**Analyze the viability of your contracts for real-world use:**
- Estimated gas for key functions (e.g., `postBounty`, `selectWinner`).
- Is this viable for users in constrained environments (e.g., high gas fees)?
- Any specific optimization strategies you implemented?

[Write your response here]

---Gas Costs

Estimated gas for key functions like 'postBounty' and 'selectWinner' is moderate, as both rely on simple storage operations and avoid expensive loops. 'postBounty' mainly writes to mappings and emits events, while 'selectWinner' uses array access and ETH transfers. For users in constrained environments or during periods of high gas fees. Optimization strategies include using mappings for fast lookups, minimizing storage writes, and following the checks-effects-interactions pattern to reduce risk and cost. 

### 2. Scalability
**What happens with 10,000+ entries/bounties?**
- Performance considerations for loops or large arrays.
- Storage cost implications.
- Potential bottlenecks in `selectWinner` or `applyForBounty`.

[Write your response here]

---
With 10,000+ entries or bounties, performance can become a concern, especially for functions that loop through large arrays. In DecentralisedRaffle, selecting a winner from a large 'entries' array could increase gas costs and risk exceeding block gas limits. Similarly, in FreelanceBountyBoard, iterating over many bounties or freelancers would be expensive. Storage costs also grow linearly with the number of entries, impacting long-term viability. Potential bottlenecks include the 'selectWinner' function (due to array access) and any function that requires searching or iterating through large datasets. 

### User Experience

**How would you make this usable for non-crypto users?**
- Onboarding process?
- MetaMask alternatives?
- Mobile accessibility?

[Write about your UX(user experience) considerations]

---For onboarding, I would simplify the process by providing clear instructions and integrating wallet onboarding tools that guide users step-by-step. 
To support users without MetaMask, I would offer alternatives like WalletConnect, Coinbase Wallet, or browser-native wallets, enabling broader access. 
For mobile accessibility, I  would ensure the frontend is responsive and compatible with mobile wallet apps, allowing users to interact with the contracts easily from their smartphones.
## MY LEARNING APPROACH

### Resources I Used

**Show self-directed learning:**
- Documentation consulted
- Tutorials followed
- Community resources

[List 3-5 resources you used]

---Tutorials followed
Documenation consulted 

### Challenges Faced

**Problem-solving evidence:**
- Biggest technical challenge
- How you solved it
- What you learned

[Write down your challenges]

---

### What I'd Learn Next

**Growth mindset indicator:**
- Advanced Solidity patterns
- Testing frameworks
- Frontend integration

[Write your future learning goals]

---
