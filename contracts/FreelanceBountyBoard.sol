// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title FreelanceBountyBoard
 * @dev A decentralised marketplace for skills and bounties
 * @notice PART 1 - Freelance Bounty Board (MANDATORY)
 */
contract FreelanceBountyBoard {
    
    // TODO: Define your state variables here
    // Consider:
    // - How will you track freelancers and their skills?
    // - How will you store bounty information?
    // - How will you manage payments?
    
    address public owner;

    struct Bounty {
        string description;
        string skill;
        address employer;
        address freelancer;
        uint256 reward;
        bool isDone;
    }

    mapping(address => string) public freelancers;
    mapping(uint256 => Bounty) public bounties;
    uint256 public bountyCount;

    constructor() {
        owner = msg.sender;
    }
    
    // TODO: Implement registerFreelancer function
    // Requirements:
    // - Freelancers should be able to register with their skill
    // - Prevent duplicate registrations
    // - Emit an event when a freelancer registers
    event FreelancerRegistered(address indexed freelancer, string skill);

    function registerFreelancer(string memory skill) public {
        require(bytes(freelancers[msg.sender]).length == 0, "Already registered");
        require(bytes(skill).length > 0, "Skill required");
        freelancers[msg.sender] = skill;
        emit FreelancerRegistered(msg.sender, skill);
    }
    
    // TODO: Implement postBounty function
    // Requirements:
    // - Employers post bounties with bounty (msg.value)
    // - Store bounty description and required skill
    // - Ensure ETH is sent with the transaction
    // - Emit an event when bounty is posted
    event BountyPosted(uint256 indexed bountyId, address indexed employer, string description, string skill, uint256 reward);

    function postBounty(string memory description, string memory skill) public payable {
        require(msg.value > 0, "Bounty must have a reward");
        bountyCount++;
        bounties[bountyCount] = Bounty({
            description: description,
            skill: skill,
            employer: msg.sender,
            freelancer: address(0),
            reward: msg.value,
            isDone: false
        });
        emit BountyPosted(bountyCount, msg.sender, description, skill, msg.value);
    }

    // TODO: Implement applyForBounty function
    // Requirements:
    // - Freelancers can apply for bounties
    // - Check if freelancer has the required skill
    // - Prevent duplicate applications
    // - Emit an event
    event BountyApplied(uint256 indexed bountyId, address indexed freelancer);

    function applyForBounty(uint256 bountyId) public {
        require(bountyId > 0 && bountyId <= bountyCount, "Invalid bounty ID");
        require(bytes(freelancers[msg.sender]).length > 0, "Not a registered freelancer");
        require(keccak256(bytes(freelancers[msg.sender])) == keccak256(bytes(bounties[bountyId].skill)), "Skill mismatch");
        require(bounties[bountyId].freelancer == address(0), "Bounty already taken");

        bounties[bountyId].freelancer = msg.sender;
        emit BountyApplied(bountyId, msg.sender);
    }

    // TODO: Implement submitWork function
    // Requirements:
    // - Freelancers submit completed work (with proof/URL)
    // - Validate that freelancer applied for this bounty
    // - Update bounty status
    // - Emit an event
    event WorkSubmitted(uint256 indexed bountyId, address indexed freelancer, string submissionUrl);

    function submitWork(uint256 bountyId, string memory submissionUrl) public {
        require(bountyId > 0 && bountyId <= bountyCount, "Invalid bounty ID");
        require(bounties[bountyId].freelancer == msg.sender, "Not the assigned freelancer");

        emit WorkSubmitted(bountyId, msg.sender, submissionUrl);
    }

    // TODO: Implement approveAndPay function
    // Requirements:
    // - Only employer who posted bounty can approve
    // - Transfer payment to freelancer
    // - CRITICAL: Implement reentrancy protection
    // - Update bounty status to completed
    // - Emit an event
    event BountyApproved(uint256 indexed bountyId, address indexed employer, address indexed freelancer, uint256 reward);

    function approveAndPay(uint256 bountyId, address freelancer) public {
        require(bountyId > 0 && bountyId <= bountyCount, "Invalid bounty ID");
        require(bounties[bountyId].employer == msg.sender, "Not the employer");
        require(bounties[bountyId].freelancer == freelancer, "Invalid freelancer");

        uint256 reward = bounties[bountyId].reward;
        bounties[bountyId].isDone = true;

        (bool success, ) = freelancer.call{value: reward}("");
        require(success, "Payment failed");

        emit BountyApproved(bountyId, msg.sender, freelancer, reward);
    }

    // BONUS: Implement dispute resolution
    // What happens if employer doesn't approve but work is done?
    // Consider implementing a timeout mechanism
    
    // Helper functions you might need:
    // - Function to get bounty details
    // - Function to check freelancer registration
    // - Function to get all bounties
}
