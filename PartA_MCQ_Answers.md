# Part A: MCQ Answers

**Status:** [In Progress / Submitted]  

---

## Instructions
**COMPLETE ALL QUESTIONS FOR BOTH PART 1 AND PART 2 BELOW**

---

## PART 1: Renewable Energy Trading Platform (Real-World African Context)

**Scenario:** You are hired as a blockchain developer to build a decentralised renewable energy marketplace for African solar micro-grid providers. The platform must:

- Allow providers to list solar energy credits as NFTs with generation certificates  
- Enable buyers to swap tokens for energy credits using a DEX  
- Store provider reputation scores transparently  
- Process payments without intermediaries  

---

### Question 1: Architecture Decision (Technical Reasoning)

**Which combination of technologies demonstrates the best understanding of blockchain fundamentals for this use case?**

- **A)** Use ERC-721 for each energy credit, build a centralised database for reputation, and integrate Binance for payments because CEXs have better liquidity.  
- **B)** Use ERC-1155 for energy credits (enabling batch listings from providers), implement reputation as on-chain mappings in the marketplace smart contract, and integrate with a DEX like Uniswap for direct provider-to-buyer swaps to minimise intermediaries.  
- **C)** Use ERC-721 exclusively, store all data off-chain for gas savings, and require buyers to use MetaMask with manual price negotiations.  
- **D)** Build everything as separate NFT collections with no DEX integration since providers won't understand DeFi protocols.  

**Your Answer:** [A/B/C/D]  B

**Your Reasoning:**  
[2–3 sentences explaining why you chose this answer. What makes it the best choice?]  

---since the buyers will be using a DEX to swap tokens we will need to use uniswap to enable direct provider to buy swaps. Because the Reputation is stored on-chain, it ensures transparency and trust.ERC-1155 for energy credits is more gas-efficient for providers and also allows batch listings 

### Question 2: Cost Optimisation (Practical Aptitude)

A solar micro-grid provider wants to list 40 energy credit bundles. Gas costs are:

- **ERC-721:** 100,000 gas per NFT mint  
- **ERC-1155:** 150,000 gas for first mint + 5,000 gas per additional item in batch  

**Current gas price:** 20 gwei  
**1 ETH = $3,000**

**What is the gas cost difference between ERC-721 and ERC-1155 for listing 40 items?**

- **A)** ERC-721 is cheaper by $15  
- **B)** ERC-1155 is cheaper by approximately $27  
- **C)** They cost exactly the same  
- **D)** ERC-1155 is cheaper by approximately $180  

**Your Answer:** [A/B/C/D]  D

**Your Calculation/Reasoning:**  

20 gwei = 0.00000002 ETH

- ERC-721 cost = [100,000 gas x 40 = 4,000,000]

                4,000,000 X 0.00000002 ETH = 0.08 ETH
                
                0.08 ETH x $3000 = $240 

- ERC-1155 cost = [(150,000 firstmint) + (5000 listings x 39 = 195,000 ) 
                    150,000 + 195,000 = 345,000 gas]

                345,000 x 0.00000002 ETH = 0.0069 ETH

                0.0069 ETH x $3000 = $20.70

j- Difference = [ERC-721 cost - ERC-1155 cost
                $240 - $20.70 = $219.30]

[Explain why gas optimisation matters for African users]  

---Because gas fees can be very high which makes it a hurdles to enter , especially in rural areas where incomes are very low . 
    Lowering the fees helps more user to get involve in to the platform making it accessible to a greta er number of people .

### Question 3: Value Proposition Explanation (Communication & Thinking)

A micro-grid provider asks: *"Why can't we just use a normal website with a database?"

**Which response demonstrates understanding of blockchain's actual value (not just its technology)?**

- **A)** "Blockchain is the future; everyone should use it."  
- **B)** "With blockchain, no middleman can manipulate your pricing or payment records. If a buyer claims they paid but you didn't receive funds, the blockchain provides immutable proof. Plus, your reputation score can follow you to other platforms since it's on-chain – it's your data, not the platform's."  
- **C)** "Because smart contracts are more secure than databases and Web3 is decentralised."  
- **D)** "Blockchain uses cryptography which makes it unhackable, unlike normal databases."  

**Your Answer:** [A/B/C/D] B 

**Your Explanation:**  
[2–3 sentences explaining what makes this answer correct. What did you learn about why blockchain matters in Africa?]  

--- It removes the need for us to have a middleman in order to trust each other and still trust that the correct agreemnt will be excuted automatically .
    It increase transpareancy and reduces fraud or corruption which is a major problem in Africa 


## PART 2: DeFi & NFT Integration (Advanced Concepts)

**Scenario:** A DeFi protocol experiences the following sequence of events:

- A liquidity provider adds 5 ETH and 15,000 USDC to an AMM pool (constant product formula: x × y = k)  
- A trader swaps 1 ETH for USDC (no fees for simplicity)  
- The protocol's governance token holders vote on implementing impermanent loss protection  
- An NFT marketplace integrates with the DEX to enable ERC-1155 token swaps  

---

### Question: Multi-Concept Synthesis

**Which statement correctly combines understanding of AMMs, governance, and technical implementation?**

- **A)** After the 1 ETH swap, the liquidity provider will have exactly the same USD value as before because the constant product formula maintains equal ratios. ERC-1155 tokens cannot be traded on AMMs since they support both fungible and non-fungible characteristics.  
- **B)** The trader will receive approximately 2,500 USDC from the swap (calculated using k = 5 × 15,000 = 75,000, then 6 × y = 75,000). Impermanent loss protection would compensate the LP for price divergence between the pool ratio and external market prices. ERC-1155's batch transfer capability makes it more gas-efficient than ERC-721 for marketplace integration.  
- **C)** The liquidity provider experiences impermanent loss because the pool maintains a constant product rather than constant ratio. ERC-721 would be more suitable than ERC-1155 for the NFT marketplace since individual NFTs require unique transactions.  
- **D)** The constant product formula prevents any impermanent loss by automatically rebalancing. DAOs cannot implement financial protections due to smart contract immutability. ERC-1155 tokens are incompatible with standard DEX protocols.  

**Your Answer:** [A/B/C/D]  B

**Your Reasoning:**  

- **AMM Mathematics:** How do you calculate the swap output? What happens to the liquidity provider's value?  
x * y = k
ETH = 5 
K = 5 x 15,000 = 75,000
user adds 1 ETH , now it's 6 ETH
y = k/x
y = 75,000/6 = 12,000

intial - new = swap output 
15,000 - 12,500 = 2,500 USDC

- **DeFi Governance:** What is impermanent loss and how does protection work?  
Impermanent loss happens when the value of the assets reduces temporary compared to holding them.

Protection works by compensating LPs for the loss between value they have in pool and what the would have had ny holding assets outside of the pool  

- **Token Standards:** Why might ERC-1155 be preferred over ERC-721 for marketplace integration?  
                    Because of the gas-efficiency it provided for marketplace integration 

[2–3 sentences synthesising these concepts into a coherent explanation]  

--- AMM use the formula (X x y = k ) to correctly calculate swap output.
    This can lead to impermanent loss for LPs when asset prices changes compared to the pool ratio, 
    but this is where impermanent loss proctection can compensate for those losses . 
    ERC-1155 is most often because of the its gas-efficiency 

## SUBMISSION CHECKLIST

- You answered all questions for **BOTH PART 1 AND PART 2**  
- Your answers include reasoning (not just A/B/C/D)  
- For PART 1 Q2: You showed your gas cost calculations  
- For PART 2: You addressed all three concept areas (AMM, Governance, Token Standards)  
- You committed and pushed to GitLab  

---

**Challenges faced:** [What was difficult? Which concepts are you less confident about?] 
AMM and pools  