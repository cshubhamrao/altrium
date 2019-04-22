pragma solidity ^0.4.21;

contract Escrow{
    // Flags for state of the channel
    enum State {AWAITING_BOUNTY, AWAITING_ANSWER, COMPLETE}
    
    State public currentState;
    
    address public asker;
    address public answerer;
    
    modifier askerOnly {require(msg.sender == asker); _;}
    
    constructor (address _buyer, address _seller){
        asker = _buyer;
        answerer = _seller;
    }

    // This function would stake the bounty and set the state to AWAITING_ANSWER
    function confirmBounty() askerOnly payable {
        require(currentState == State.AWAITING_BOUNTY);
        currentState == State.AWAITING_ANSWER;
    }
    // This function is still work-in-progress. It will communicate with "off-chain elements" to attest the COMPLETE state
    function confirmAnswered() askerOnly {
        require(currentState == State.AWAITING_ANSWER);
        answerer.send(this.balance);
        currentState == State.COMPLETE;
    }
}