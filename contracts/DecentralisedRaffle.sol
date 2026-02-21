// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title DecentralisedRaffle
 * @dev An advanced raffle smart contract with security features
 * @notice PART 2 - Decentralised Raffle (MANDATORY)
 */
contract DecentralisedRaffle {
    
    address public owner;
    uint256 public raffleId;
    uint256 public raffleStartTime;
    bool public isPaused;
    
    address[] public entries;
    mapping(address => uint256) public playerEntryCount; // entry count per player
    mapping(address => bool) public uniquePlayers; // Track unique players
    uint256 public uniquePlayerCount; // amount of unique players

    event RaffleEntered(address indexed player, uint256 entryCount);
    
    constructor() {
        owner = msg.sender;
        raffleId = 1;
        raffleStartTime = block.timestamp;
        isPaused = false;
    }
    
    // TODO: Implement entry function
    // Requirements:
    // - Players pay minimum 0.01 ETH to enter
    // - Track each entry (not just unique addresses)
    // - Allow multiple entries per player
    // - Emit event with player address and entry count
    function enterRaffle() public payable {
        // Your implementation here
        // Validation: Check minimum entry amount
        require(msg.value >= 0.01 ether, "Minimum entry is 0.01 ETH");
        // Validation: Check if raffle is active
        require(!isPaused, "Raffle is paused");

        entries.push(msg.sender);
        playerEntryCount[msg.sender]++;
        uniquePlayers[msg.sender] = true;

        if (uniquePlayers[msg.sender]) {
            uniquePlayerCount++;
        }

        emit RaffleEntered(msg.sender, playerEntryCount[msg.sender]);
    }

    // Reentrancy protection: add a simple nonReentrant modifier
    bool private locked = false;
    modifier nonReentrant() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    // Update selectWinner to use nonReentrant
    function selectWinner() public onlyOwner nonReentrant {
        require(entries.length > 0, "No entries");
        require(uniquePlayerCount >= 3, "At least 3 unique players required");
        require(block.timestamp >= raffleStartTime + 1 days, "Raffle must be active for 24 hours");
        require(!isPaused, "Raffle is paused");

        // Secure randomness: use blockhash and raffleId
        uint256 random = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.prevrandao, block.timestamp, raffleId)));
        uint256 winnerIndex = random % entries.length;
        address winner = entries[winnerIndex];

        uint256 pot = address(this).balance;
        uint256 winnerPrize = (pot * 90) / 100;
        uint256 ownerFee = pot - winnerPrize;

        // Checks-Effects-Interactions pattern
        // Effects
        raffleId++;
        raffleStartTime = block.timestamp;
        delete entries;
        uniquePlayerCount = 0;
        // Interactions
        (bool sentWinner, ) = winner.call{value: winnerPrize}("");
        require(sentWinner, "Failed to send prize to winner");
        (bool sentOwner, ) = owner.call{value: ownerFee}("");
        require(sentOwner, "Failed to send fee to owner");
    }
    
    // TODO: Implement circuit breaker (pause/unpause)
    // Requirements:
    // - Owner can pause raffle in emergency
    // - Owner can unpause raffle
    // - When paused, no entries allowed
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    modifier whenNotPaused() {
        require(!isPaused, " raffle is paused");
        _;
    }
    
    function pause() public onlyOwner {
        require(!isPaused, "Already paused");
        isPaused = true;
    }

    function unpause() public onlyOwner {
        require(isPaused, "Already unpaused");
        isPaused = false;
    }
    
    // TODO: Implement reentrancy protection
    // CRITICAL: Prevent reentrancy attacks when sending ETH
    // Use checks-effects-interactions pattern
    
    // Helper/View functions
    function getPotBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getPlayerEntryCount(address player) public view returns (uint256) {
        return playerEntryCount[player];
    }

    function isRaffleActive() public view returns (bool) {
        return !isPaused && (block.timestamp < raffleStartTime + 1 days);
    }

    function getUniquePlayerCount() public view returns (uint256) {
        return uniquePlayerCount;
    }
    
    // BONUS: Add multiple prize tiers (1st, 2nd, 3rd place)
    // BONUS: Add refund mechanism if minimum players not reached
}
